#=
SVG diagram builders for geometry and graphing problems.
Pure-Julia port of python/svg_utils.py — manual SVG string construction,
no external graphics libraries (no Cairo/Luxor dependency).

Two structs:
  DiagramObj — geometry diagrams (polygons, angles, circles, etc.)
  GraphObj   — function plots on a coordinate grid

Both produce compact, dark-mode-compatible SVG strings using currentColor.
=#

using Symbolics: build_function, get_variables

# ---------------------------------------------------------------------------
# DiagramObj — geometry diagrams
# ---------------------------------------------------------------------------

"""
Build geometry diagrams in math coordinates (y-up).
Coordinates are auto-scaled to fit the SVG viewBox at render time.

    d = DiagramObj()
    polygon!(d, [(0,0), (4,0), (2,3)]; labels=["A", "B", "C"])
    angle_arc!(d, (0,0), (4,0), (2,3); label="60°")
    svg = render(d)
"""
mutable struct DiagramObj
    _width::Int
    _height::Int
    _padding::Int
    _points::Vector{Tuple{Float64,Float64}}
    _elements::Vector{Tuple}

    function DiagramObj(; width::Int=300, height::Int=250, padding::Int=40)
        new(width, height, padding,
            Tuple{Float64,Float64}[],
            Tuple[])
    end
end

function _register!(d::DiagramObj, pts...)
    for p in pts
        push!(d._points, (Float64(p[1]), Float64(p[2])))
    end
end

function _bounds(d::DiagramObj)
    xs = [p[1] for p in d._points]
    ys = [p[2] for p in d._points]
    return minimum(xs), maximum(xs), minimum(ys), maximum(ys)
end

function _transform(d::DiagramObj, px, py, x_min, y_min, y_max, scale)
    svgx = d._padding + (px - x_min) * scale
    svgy = d._padding + (y_max - py) * scale
    return round(svgx; digits=1), round(svgy; digits=1)
end

# -- public API --------------------------------------------------------------

function line!(d::DiagramObj, p1, p2; dashed::Bool=false)
    _register!(d, p1, p2)
    push!(d._elements, (:line, p1, p2, dashed))
end

function polygon!(d::DiagramObj, points; labels=nothing, fill=nothing)
    for p in points
        _register!(d, p)
    end
    push!(d._elements, (:polygon, collect(points), labels, fill))
end

function circle!(d::DiagramObj, center, radius; fill=nothing)
    _register!(d, center,
               (center[1] - radius, center[2]),
               (center[1] + radius, center[2]),
               (center[1], center[2] - radius),
               (center[1], center[2] + radius))
    push!(d._elements, (:circle, center, radius, fill))
end

function arc!(d::DiagramObj, center, radius, start_deg, end_deg)
    s = deg2rad(start_deg)
    e = deg2rad(end_deg)
    _register!(d, center,
               (center[1] + radius * cos(s), center[2] + radius * sin(s)),
               (center[1] + radius * cos(e), center[2] + radius * sin(e)))
    push!(d._elements, (:arc, center, radius, start_deg, end_deg))
end

function point!(d::DiagramObj, x, y; label=nothing)
    _register!(d, (x, y))
    push!(d._elements, (:point, (x, y), label))
end

function angle_arc!(d::DiagramObj, vertex, p1, p2; label=nothing)
    _register!(d, vertex, p1, p2)
    push!(d._elements, (:angle_arc, vertex, p1, p2, label))
end

function right_angle!(d::DiagramObj, vertex, p1, p2)
    _register!(d, vertex, p1, p2)
    push!(d._elements, (:right_angle, vertex, p1, p2))
end

function segment_label!(d::DiagramObj, p1, p2, text)
    _register!(d, p1, p2)
    push!(d._elements, (:segment_label, p1, p2, text))
end

function tick_marks!(d::DiagramObj, p1, p2; count::Int=1)
    _register!(d, p1, p2)
    push!(d._elements, (:tick_marks, p1, p2, count))
end

function text!(d::DiagramObj, x, y, text)
    _register!(d, (x, y))
    push!(d._elements, (:text, (x, y), text))
end

# -- render ------------------------------------------------------------------

function render(d::DiagramObj)
    if isempty(d._points)
        return """<svg xmlns="http://www.w3.org/2000/svg"></svg>"""
    end

    x_min, x_max, y_min, y_max = _bounds(d)
    dx = x_max - x_min
    dy = y_max - y_min
    dx == 0 && (dx = 1)
    dy == 0 && (dy = 1)
    inner_w = d._width - 2 * d._padding
    inner_h = d._height - 2 * d._padding
    scale = min(inner_w / dx, inner_h / dy)

    tx(px, py) = _transform(d, px, py, x_min, y_min, y_max, scale)

    parts = String[]

    for el in d._elements
        kind = el[1]

        if kind === :line
            _, p1, p2, dashed = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
            push!(parts, """<line x1="$(x1)" y1="$(y1)" x2="$(x2)" y2="$(y2)" stroke="currentColor" stroke-width="2"$(dash)/>""")

        elseif kind === :polygon
            _, points, labels, fill = el
            coords = [tx(p[1], p[2]) for p in points]
            pts_str = join(["$(c[1]),$(c[2])" for c in coords], " ")
            fill_attr = fill !== nothing ? """fill="$(fill)" fill-opacity="0.15\"""" : """fill="none\""""
            push!(parts, """<polygon points="$(pts_str)" stroke="currentColor" stroke-width="2" $(fill_attr)/>""")
            if labels !== nothing
                cx = sum(c[1] for c in coords) / length(coords)
                cy = sum(c[2] for c in coords) / length(coords)
                for (i, lbl) in enumerate(labels)
                    lbl === nothing && continue
                    px, py = coords[i]
                    ddx = px - cx
                    ddy = py - cy
                    dist = hypot(ddx, ddy)
                    dist == 0 && (dist = 1)
                    ox = ddx / dist * 18
                    oy = ddy / dist * 18
                    push!(parts, """<text x="$(round(px + ox; digits=1))" y="$(round(py + oy + 5; digits=1))" font-size="14" fill="currentColor" font-style="italic" text-anchor="middle">$(lbl)</text>""")
                end
            end

        elseif kind === :circle
            _, center, radius, fill = el
            ccx, ccy = tx(center[1], center[2])
            r = round(radius * scale; digits=1)
            fill_attr = fill !== nothing ? """fill="$(fill)" fill-opacity="0.15\"""" : """fill="none\""""
            push!(parts, """<circle cx="$(ccx)" cy="$(ccy)" r="$(r)" stroke="currentColor" stroke-width="2" $(fill_attr)/>""")

        elseif kind === :arc
            _, center, radius, start_deg, end_deg = el
            r = radius * scale
            s_rad = deg2rad(start_deg)
            e_rad = deg2rad(end_deg)
            sx1 = center[1] + radius * cos(s_rad)
            sy1 = center[2] + radius * sin(s_rad)
            sx2 = center[1] + radius * cos(e_rad)
            sy2 = center[2] + radius * sin(e_rad)
            ax1, ay1 = tx(sx1, sy1)
            ax2, ay2 = tx(sx2, sy2)
            sweep_angle = mod(end_deg - start_deg, 360)
            large = sweep_angle > 180 ? 1 : 0
            push!(parts, """<path d="M$(ax1),$(ay1) A$(round(r; digits=1)),$(round(r; digits=1)) 0 $(large) 0 $(ax2),$(ay2)" stroke="currentColor" stroke-width="2" fill="none"/>""")

        elseif kind === :point
            _, pos, label = el
            px, py = tx(pos[1], pos[2])
            push!(parts, """<circle cx="$(px)" cy="$(py)" r="3" fill="currentColor"/>""")
            if label !== nothing
                push!(parts, """<text x="$(round(px + 6; digits=1))" y="$(round(py - 6; digits=1))" font-size="13" fill="currentColor">$(label)</text>""")
            end

        elseif kind === :angle_arc
            _, vertex, p1, p2, label = el
            vx, vy = tx(vertex[1], vertex[2])
            p1x, p1y = tx(p1[1], p1[2])
            p2x, p2y = tx(p2[1], p2[2])
            a1 = atan(p1y - vy, p1x - vx)
            a2 = atan(p2y - vy, p2x - vx)
            r = 25
            ax1 = round(vx + r * cos(a1); digits=1)
            ay1 = round(vy + r * sin(a1); digits=1)
            ax2 = round(vx + r * cos(a2); digits=1)
            ay2 = round(vy + r * sin(a2); digits=1)
            cw = mod(a1 - a2, 2π)
            ccw = mod(a2 - a1, 2π)
            if ccw <= cw
                sweep = 1
                mid_a = a1 + ccw / 2
            else
                sweep = 0
                mid_a = a1 - cw / 2
            end
            push!(parts, """<path d="M$(ax1),$(ay1) A$(r),$(r) 0 0 $(sweep) $(ax2),$(ay2)" stroke="currentColor" stroke-width="1.5" fill="none"/>""")
            if label !== nothing
                lx = round(vx + (r + 14) * cos(mid_a); digits=1)
                ly = round(vy + (r + 14) * sin(mid_a); digits=1)
                push!(parts, """<text x="$(lx)" y="$(ly)" font-size="12" fill="currentColor" text-anchor="middle" dominant-baseline="central">$(label)</text>""")
            end

        elseif kind === :right_angle
            _, vertex, p1, p2 = el
            vx, vy = tx(vertex[1], vertex[2])
            p1x, p1y = tx(p1[1], p1[2])
            p2x, p2y = tx(p2[1], p2[2])
            a1 = atan(p1y - vy, p1x - vx)
            a2 = atan(p2y - vy, p2x - vx)
            s = 12
            cx1 = round(vx + s * cos(a1); digits=1)
            cy1 = round(vy + s * sin(a1); digits=1)
            cx2 = round(vx + s * cos(a2); digits=1)
            cy2 = round(vy + s * sin(a2); digits=1)
            corner_x = round(vx + s * cos(a1) + s * cos(a2); digits=1)
            corner_y = round(vy + s * sin(a1) + s * sin(a2); digits=1)
            push!(parts, """<path d="M$(cx1),$(cy1) L$(corner_x),$(corner_y) L$(cx2),$(cy2)" stroke="currentColor" stroke-width="1.5" fill="none"/>""")

        elseif kind === :segment_label
            _, p1, p2, txt = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            mx = round((x1 + x2) / 2; digits=1)
            my = round((y1 + y2) / 2; digits=1)
            ds_x = x2 - x1
            ds_y = y2 - y1
            len = hypot(ds_x, ds_y)
            len == 0 && (len = 1)
            nx = -ds_y / len * 14
            ny = ds_x / len * 14
            push!(parts, """<text x="$(round(mx + nx; digits=1))" y="$(round(my + ny; digits=1))" font-size="13" fill="currentColor" text-anchor="middle" dominant-baseline="central">$(txt)</text>""")

        elseif kind === :tick_marks
            _, p1, p2, count = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            mx = (x1 + x2) / 2
            my = (y1 + y2) / 2
            ds_x = x2 - x1
            ds_y = y2 - y1
            len = hypot(ds_x, ds_y)
            len == 0 && (len = 1)
            nx = -ds_y / len
            ny = ds_x / len
            tx_dir = ds_x / len
            ty_dir = ds_y / len
            spacing = 4
            for i in 1:count
                offset = (i - 1 - (count - 1) / 2) * spacing
                ccx = mx + offset * tx_dir
                ccy = my + offset * ty_dir
                tx1 = round(ccx + nx * 5; digits=1)
                ty1 = round(ccy + ny * 5; digits=1)
                tx2 = round(ccx - nx * 5; digits=1)
                ty2 = round(ccy - ny * 5; digits=1)
                push!(parts, """<line x1="$(tx1)" y1="$(ty1)" x2="$(tx2)" y2="$(ty2)" stroke="currentColor" stroke-width="1.5"/>""")
            end

        elseif kind === :text
            _, pos, txt = el
            px, py = tx(pos[1], pos[2])
            push!(parts, """<text x="$(px)" y="$(py)" font-size="13" fill="currentColor">$(txt)</text>""")
        end
    end

    vb = "0 0 $(d._width) $(d._height)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(d._width)px" fill="currentColor">$(body)</svg>"""
end


# ---------------------------------------------------------------------------
# GraphObj — function plots on a coordinate grid
# ---------------------------------------------------------------------------

const _PLOT_COLORS = ["#3b82f6", "#ef4444", "#10b981", "#f59e0b", "#8b5cf6", "#ec4899"]

"""
Plot Symbolics expressions on a coordinate grid.

    g = GraphObj(; x_range=(-5, 5), y_range=(-5, 5))
    plot!(g, x^2 - 3)
    point!(g, 2, 1; label="(2, 1)")
    svg = render(g)
"""
mutable struct GraphObj
    _x_min::Float64
    _x_max::Float64
    _y_min::Float64
    _y_max::Float64
    _width::Int
    _height::Int
    _padding::Int
    _plots::Vector{Tuple{Any,String,Bool}}
    _points::Vector{Tuple{Float64,Float64,Union{Nothing,String}}}
    _vlines::Vector{Tuple{Float64,Bool}}
    _hlines::Vector{Tuple{Float64,Bool}}
    _color_idx::Int

    function GraphObj(; x_range=(-5, 5), y_range=(-5, 5), width::Int=300, height::Int=300, padding::Int=35)
        new(Float64(x_range[1]), Float64(x_range[2]),
            Float64(y_range[1]), Float64(y_range[2]),
            width, height, padding,
            Tuple{Any,String,Bool}[],
            Tuple{Float64,Float64,Union{Nothing,String}}[],
            Tuple{Float64,Bool}[],
            Tuple{Float64,Bool}[],
            0)
    end
end

function _next_color!(g::GraphObj)
    c = _PLOT_COLORS[mod1(g._color_idx + 1, length(_PLOT_COLORS))]
    g._color_idx += 1
    return c
end

function _tx_graph(g::GraphObj, mx, my)
    inner_w = g._width - 2 * g._padding
    inner_h = g._height - 2 * g._padding
    sx = inner_w / (g._x_max - g._x_min)
    sy = inner_h / (g._y_max - g._y_min)
    svgx = g._padding + (mx - g._x_min) * sx
    svgy = g._padding + (g._y_max - my) * sy
    return round(svgx; digits=1), round(svgy; digits=1)
end

function plot!(g::GraphObj, expr; color=nothing, dashed::Bool=false)
    c = color !== nothing ? color : _next_color!(g)
    push!(g._plots, (expr, c, dashed))
end

function point!(g::GraphObj, x, y; label=nothing)
    push!(g._points, (Float64(x), Float64(y), label))
end

function vline!(g::GraphObj, x; dashed::Bool=true)
    push!(g._vlines, (Float64(x), dashed))
end

function hline!(g::GraphObj, y; dashed::Bool=true)
    push!(g._hlines, (Float64(y), dashed))
end

function render(g::GraphObj)
    parts = String[]

    pad = g._padding
    inner_w = g._width - 2 * pad
    inner_h = g._height - 2 * pad
    bot = pad + inner_h  # bottom edge
    r = pad + inner_w    # right edge

    # CSS classes for compact SVG
    push!(parts, """<style>.g{stroke:currentColor;stroke-opacity:.12;stroke-width:1}.a{stroke:currentColor;stroke-width:1.5}.t{font-size:10px;fill:currentColor}</style>""")

    # grid lines
    for xi in Int(floor(g._x_min)):Int(ceil(g._x_max))
        gx, _ = _tx_graph(g, xi, 0)
        push!(parts, """<line x1="$(gx)" y1="$(pad)" x2="$(gx)" y2="$(bot)" class="g"/>""")
    end
    for yi in Int(floor(g._y_min)):Int(ceil(g._y_max))
        _, gy = _tx_graph(g, 0, yi)
        push!(parts, """<line x1="$(pad)" y1="$(gy)" x2="$(r)" y2="$(gy)" class="g"/>""")
    end

    # axes
    if g._y_min <= 0 <= g._y_max
        _, ay = _tx_graph(g, 0, 0)
        push!(parts, """<line x1="$(pad)" y1="$(ay)" x2="$(r)" y2="$(ay)" class="a"/>""")
    end
    if g._x_min <= 0 <= g._x_max
        ax, _ = _tx_graph(g, 0, 0)
        push!(parts, """<line x1="$(ax)" y1="$(pad)" x2="$(ax)" y2="$(bot)" class="a"/>""")
    end

    # tick labels on x-axis
    for xi in Int(floor(g._x_min)):Int(ceil(g._x_max))
        xi == 0 && continue
        gx, y0 = _tx_graph(g, xi, 0)
        yl = min(y0 + 16, bot + 16)
        push!(parts, """<text x="$(gx)" y="$(yl)" class="t" text-anchor="middle">$(xi)</text>""")
    end

    # tick labels on y-axis
    for yi in Int(floor(g._y_min)):Int(ceil(g._y_max))
        yi == 0 && continue
        x0, gy = _tx_graph(g, 0, yi)
        xl = max(x0 - 8, pad - 20)
        push!(parts, """<text x="$(xl)" y="$(round(gy + 4; digits=1))" class="t" text-anchor="end">$(yi)</text>""")
    end

    # vertical lines
    for (vx, dashed) in g._vlines
        gx, _ = _tx_graph(g, vx, 0)
        dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
        push!(parts, """<line x1="$(gx)" y1="$(pad)" x2="$(gx)" y2="$(bot)" stroke="currentColor" stroke-opacity="0.5" stroke-width="1.5"$(dash)/>""")
    end

    # horizontal lines
    for (hy, dashed) in g._hlines
        _, gy = _tx_graph(g, 0, hy)
        dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
        push!(parts, """<line x1="$(pad)" y1="$(gy)" x2="$(r)" y2="$(gy)" stroke="currentColor" stroke-opacity="0.5" stroke-width="1.5"$(dash)/>""")
    end

    # plot curves
    n_pts = 100
    for (expr, color, dashed) in g._plots
        # Build a callable function from the Symbolics expression
        vars = get_variables(expr)
        if isempty(vars)
            continue  # constant expression — skip
        end
        var = first(vars)  # assume single-variable expression
        f = try
            build_function(expr, var; expression=Val{false})
        catch
            continue
        end

        step = (g._x_max - g._x_min) / n_pts
        segments = Vector{Vector{Tuple{Float64,Float64}}}()
        current_seg = Tuple{Float64,Float64}[]
        y_span = (g._y_max - g._y_min) * 2

        for i in 0:n_pts
            xv = g._x_min + i * step
            yv = try
                Float64(f(xv))
            catch
                if !isempty(current_seg)
                    push!(segments, current_seg)
                    current_seg = Tuple{Float64,Float64}[]
                end
                continue
            end

            if isnan(yv) || isinf(yv)
                if !isempty(current_seg)
                    push!(segments, current_seg)
                    current_seg = Tuple{Float64,Float64}[]
                end
                continue
            end

            # discontinuity detection
            if !isempty(current_seg)
                prev_y = current_seg[end][2]
                if abs(yv - prev_y) > y_span
                    push!(segments, current_seg)
                    current_seg = Tuple{Float64,Float64}[]
                end
            end

            push!(current_seg, (xv, yv))
        end
        if !isempty(current_seg)
            push!(segments, current_seg)
        end

        dash_attr = dashed ? """ stroke-dasharray="6,4\"""" : ""
        for seg in segments
            length(seg) < 2 && continue
            pts_str = join(["$(Int(round(_tx_graph(g, px, py)[1]))),$(Int(round(_tx_graph(g, px, py)[2])))" for (px, py) in seg], " ")
            push!(parts, """<polyline points="$(pts_str)" stroke="$(color)" stroke-width="2" fill="none" stroke-opacity="0.85"$(dash_attr)/>""")
        end
    end

    # points
    for (px, py, label) in g._points
        sx, sy = _tx_graph(g, px, py)
        push!(parts, """<circle cx="$(sx)" cy="$(sy)" r="3.5" fill="currentColor"/>""")
        if label !== nothing
            push!(parts, """<text x="$(round(sx + 7; digits=1))" y="$(round(sy - 7; digits=1))" font-size="12" fill="currentColor">$(label)</text>""")
        end
    end

    vb = "0 0 $(g._width) $(g._height)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(g._width)px">$(body)</svg>"""
end
