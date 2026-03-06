#=
SVG diagram builders for geometry and graphing problems.
Pure-Julia port of python/svg_utils.py — manual SVG string construction,
no external graphics libraries (no Cairo/Luxor dependency).

Three structs:
  DiagramObj — geometry diagrams (polygons, angles, circles, etc.)
  GraphObj   — function plots on a coordinate grid
  NumberLine — number line with points and shading

All produce compact, dark-mode-compatible SVG strings using currentColor.
=#

using Symbolics: build_function, get_variables

# ---------------------------------------------------------------------------
# Label collision avoidance helpers
# ---------------------------------------------------------------------------

struct _BBox
    x::Float64
    y::Float64
    w::Float64
    h::Float64
end

function _boxes_overlap(b1::_BBox, b2::_BBox)
    return b1.x < b2.x + b2.w && b1.x + b1.w > b2.x &&
           b1.y < b2.y + b2.h && b1.y + b1.h > b2.y
end

"""
Push label position outward until no overlap with placed labels.
Returns (final_x, final_y). Up to 5 attempts with 1.4x nudge factor.
"""
function _nudge_label(px, py, ox, oy, placed::Vector{_BBox}; font_w=7.0, font_h=14.0)
    for attempt in 1:5
        factor = 1.4 ^ (attempt - 1)
        lx = px + ox * factor
        ly = py + oy * factor
        # Estimate bounding box (centered horizontally, above baseline)
        # Use a generous width estimate
        bbox = _BBox(lx - font_w, ly - font_h, font_w * 2, font_h)
        if !any(b -> _boxes_overlap(bbox, b), placed)
            push!(placed, bbox)
            return round(lx; digits=1), round(ly; digits=1)
        end
    end
    # Give up — use last attempt position
    factor = 1.4 ^ 4
    lx = round(px + ox * factor; digits=1)
    ly = round(py + oy * factor; digits=1)
    push!(placed, _BBox(lx - font_w, ly - font_h, font_w * 2, font_h))
    return lx, ly
end

# ---------------------------------------------------------------------------
# Arrowhead SVG defs
# ---------------------------------------------------------------------------

const _ARROW_MARKER = """<defs><marker id="ah" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto"><polygon points="0 0,10 3.5,0 7" fill="currentColor"/></marker></defs>"""
const _AXIS_MARKER = """<defs><marker id="ax" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="currentColor"/></marker></defs>"""

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
    _has_arrows::Bool

    function DiagramObj(; width::Int=300, height::Int=250, padding::Int=40)
        new(width, height, padding,
            Tuple{Float64,Float64}[],
            Tuple[],
            false)
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

function arrow!(d::DiagramObj, p1, p2; dashed::Bool=false)
    _register!(d, p1, p2)
    d._has_arrows = true
    push!(d._elements, (:arrow, p1, p2, dashed))
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
    placed_labels = _BBox[]

    # Emit arrow marker defs if needed
    if d._has_arrows
        push!(parts, _ARROW_MARKER)
    end

    for el in d._elements
        kind = el[1]

        if kind === :line
            _, p1, p2, dashed = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
            push!(parts, """<line x1="$(x1)" y1="$(y1)" x2="$(x2)" y2="$(y2)" stroke="currentColor" stroke-width="2"$(dash)/>""")

        elseif kind === :arrow
            _, p1, p2, dashed = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
            push!(parts, """<line x1="$(x1)" y1="$(y1)" x2="$(x2)" y2="$(y2)" stroke="currentColor" stroke-width="2"$(dash) marker-end="url(#ah)"/>""")

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
                    lx, ly = _nudge_label(px, py, ox, oy + 5, placed_labels)
                    push!(parts, """<text x="$(lx)" y="$(ly)" font-size="14" fill="currentColor" font-style="italic" text-anchor="middle">$(lbl)</text>""")
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
                lx, ly = _nudge_label(px, py, 6.0, -6.0, placed_labels)
                push!(parts, """<text x="$(lx)" y="$(ly)" font-size="13" fill="currentColor">$(label)</text>""")
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
                lx, ly = _nudge_label(vx, vy, (r + 14) * cos(mid_a), (r + 14) * sin(mid_a), placed_labels)
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
            mx = (x1 + x2) / 2
            my = (y1 + y2) / 2
            ds_x = x2 - x1
            ds_y = y2 - y1
            len = hypot(ds_x, ds_y)
            len == 0 && (len = 1)
            nx = -ds_y / len * 14
            ny = ds_x / len * 14
            lx, ly = _nudge_label(mx, my, nx, ny, placed_labels)
            push!(parts, """<text x="$(lx)" y="$(ly)" font-size="13" fill="currentColor" text-anchor="middle" dominant-baseline="central">$(txt)</text>""")

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
            lx, ly = _nudge_label(px, py, 0.0, 0.0, placed_labels)
            push!(parts, """<text x="$(lx)" y="$(ly)" font-size="13" fill="currentColor">$(txt)</text>""")
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
    _plots_fill::Vector{Tuple{Any,Any,String,Float64}}
    _points::Vector{Tuple{Float64,Float64,Union{Nothing,String}}}
    _vlines::Vector{Tuple{Float64,Bool}}
    _hlines::Vector{Tuple{Float64,Bool}}
    _color_idx::Int

    function GraphObj(; x_range=(-5, 5), y_range=(-5, 5), width::Int=300, height::Int=300, padding::Int=35)
        new(Float64(x_range[1]), Float64(x_range[2]),
            Float64(y_range[1]), Float64(y_range[2]),
            width, height, padding,
            Tuple{Any,String,Bool}[],
            Tuple{Any,Any,String,Float64}[],
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

function fill_between!(g::GraphObj, expr1, expr2=nothing; color="#3b82f6", opacity=0.15)
    push!(g._plots_fill, (expr1, expr2, color, Float64(opacity)))
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

"""
Evaluate expr at uniformly+adaptively sampled x values.
Returns sorted (x, y) pairs with discontinuity breaks as (NaN, NaN).
Phase 1: 80 uniform base samples. Phase 2: refine high-curvature intervals. Cap 400 pts.
"""
function _adaptive_sample(f, x_min, x_max, y_span)
    n_base = 80
    step = (x_max - x_min) / n_base
    xs = Float64[]
    ys = Float64[]

    # Phase 1: uniform base
    for i in 0:n_base
        xv = x_min + i * step
        yv = try Float64(f(xv)) catch; NaN end
        push!(xs, xv)
        push!(ys, yv)
    end

    # Phase 2: adaptive refinement on high-curvature intervals
    refined_xs = Float64[]
    for i in 2:(length(ys)-1)
        if isfinite(ys[i-1]) && isfinite(ys[i]) && isfinite(ys[i+1])
            curvature = abs(ys[i+1] - 2*ys[i] + ys[i-1])
            if curvature > 0.5
                dx = xs[i] - xs[i-1]
                for k in 1:3
                    push!(refined_xs, xs[i-1] + dx * k / 4)
                end
            end
        end
    end

    # Evaluate refined points (cap at 400 total)
    max_extra = 400 - length(xs)
    for rx in refined_xs[1:min(length(refined_xs), max_extra)]
        yv = try Float64(f(rx)) catch; NaN end
        push!(xs, rx)
        push!(ys, yv)
    end

    # Sort by x
    perm = sortperm(xs)
    return xs[perm], ys[perm]
end

"""Break sorted (xs, ys) into continuous segments, splitting on NaN/Inf/discontinuities."""
function _segment_points(xs, ys, y_span)
    segments = Vector{Vector{Tuple{Float64,Float64}}}()
    current = Tuple{Float64,Float64}[]

    for i in eachindex(xs)
        if isnan(ys[i]) || isinf(ys[i])
            if !isempty(current)
                push!(segments, current)
                current = Tuple{Float64,Float64}[]
            end
            continue
        end
        if !isempty(current)
            prev_y = current[end][2]
            if abs(ys[i] - prev_y) > y_span
                push!(segments, current)
                current = Tuple{Float64,Float64}[]
            end
        end
        push!(current, (xs[i], ys[i]))
    end
    if !isempty(current)
        push!(segments, current)
    end
    return segments
end

function render(g::GraphObj)
    parts = String[]

    pad = g._padding
    inner_w = g._width - 2 * pad
    inner_h = g._height - 2 * pad
    bot = pad + inner_h  # bottom edge
    r = pad + inner_w    # right edge
    has_axes = (g._y_min <= 0 <= g._y_max) || (g._x_min <= 0 <= g._x_max)

    # CSS classes for compact SVG
    push!(parts, """<style>.g{stroke:currentColor;stroke-opacity:.12;stroke-width:1}.a{stroke:currentColor;stroke-width:1.5}.t{font-size:10px;fill:currentColor}</style>""")

    # Axis arrowhead defs (only if axes visible)
    if has_axes
        push!(parts, _AXIS_MARKER)
    end

    # grid lines
    for xi in Int(floor(g._x_min)):Int(ceil(g._x_max))
        gx, _ = _tx_graph(g, xi, 0)
        push!(parts, """<line x1="$(gx)" y1="$(pad)" x2="$(gx)" y2="$(bot)" class="g"/>""")
    end
    for yi in Int(floor(g._y_min)):Int(ceil(g._y_max))
        _, gy = _tx_graph(g, 0, yi)
        push!(parts, """<line x1="$(pad)" y1="$(gy)" x2="$(r)" y2="$(gy)" class="g"/>""")
    end

    # axes with arrowheads
    if g._y_min <= 0 <= g._y_max
        _, ay = _tx_graph(g, 0, 0)
        push!(parts, """<line x1="$(pad)" y1="$(ay)" x2="$(r)" y2="$(ay)" class="a" marker-end="url(#ax)"/>""")
    end
    if g._x_min <= 0 <= g._x_max
        ax, _ = _tx_graph(g, 0, 0)
        push!(parts, """<line x1="$(ax)" y1="$(bot)" x2="$(ax)" y2="$(pad)" class="a" marker-end="url(#ax)"/>""")
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

    y_span = (g._y_max - g._y_min) * 2

    # fill_between regions
    for (expr1, expr2, color, opacity) in g._plots_fill
        vars1 = get_variables(expr1)
        isempty(vars1) && continue
        var1 = first(vars1)
        f1 = try build_function(expr1, var1; expression=Val{false}) catch; continue end

        if expr2 !== nothing
            vars2 = get_variables(expr2)
            isempty(vars2) && continue
            var2 = first(vars2)
            f2 = try build_function(expr2, var2; expression=Val{false}) catch; continue end
        else
            f2 = _ -> 0.0
        end

        # Sample upper and lower curves
        n = 80
        step = (g._x_max - g._x_min) / n
        upper_pts = Tuple{Float64,Float64}[]
        lower_pts = Tuple{Float64,Float64}[]
        for i in 0:n
            xv = g._x_min + i * step
            y1v = try Float64(f1(xv)) catch; NaN end
            y2v = try Float64(f2(xv)) catch; NaN end
            (isfinite(y1v) && isfinite(y2v)) || continue
            # Clamp to visible range
            y1c = clamp(y1v, g._y_min, g._y_max)
            y2c = clamp(y2v, g._y_min, g._y_max)
            push!(upper_pts, (xv, y1c))
            push!(lower_pts, (xv, y2c))
        end

        if length(upper_pts) >= 2
            # Build polygon: upper forward + lower backward
            poly_pts = String[]
            for (px, py) in upper_pts
                sx, sy = _tx_graph(g, px, py)
                push!(poly_pts, "$(Int(round(sx))),$(Int(round(sy)))")
            end
            for (px, py) in reverse(lower_pts)
                sx, sy = _tx_graph(g, px, py)
                push!(poly_pts, "$(Int(round(sx))),$(Int(round(sy)))")
            end
            push!(parts, """<polygon points="$(join(poly_pts, " "))" fill="$(color)" fill-opacity="$(opacity)" stroke="none"/>""")
        end
    end

    # plot curves (adaptive sampling)
    for (expr, color, dashed) in g._plots
        vars = get_variables(expr)
        if isempty(vars)
            continue
        end
        var = first(vars)
        f = try
            build_function(expr, var; expression=Val{false})
        catch
            continue
        end

        xs, ys = _adaptive_sample(f, g._x_min, g._x_max, y_span)
        segments = _segment_points(xs, ys, y_span)

        dash_attr = dashed ? """ stroke-dasharray="6,4\"""" : ""
        for seg in segments
            length(seg) < 2 && continue
            pts_str = join(["$(Int(round(_tx_graph(g, px, py)[1]))),$(Int(round(_tx_graph(g, px, py)[2])))" for (px, py) in seg], " ")
            push!(parts, """<polyline points="$(pts_str)" stroke="$(color)" stroke-width="2" fill="none" stroke-opacity="0.85"$(dash_attr)/>""")
        end
    end

    # points
    placed_labels = _BBox[]
    for (px, py, label) in g._points
        sx, sy = _tx_graph(g, px, py)
        push!(parts, """<circle cx="$(sx)" cy="$(sy)" r="3.5" fill="currentColor"/>""")
        if label !== nothing
            lx, ly = _nudge_label(sx, sy, 7.0, -7.0, placed_labels)
            push!(parts, """<text x="$(lx)" y="$(ly)" font-size="12" fill="currentColor">$(label)</text>""")
        end
    end

    vb = "0 0 $(g._width) $(g._height)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(g._width)px">$(body)</svg>"""
end


# ---------------------------------------------------------------------------
# NumberLine — number lines with points and shading
# ---------------------------------------------------------------------------

"""
Number line with open/closed points and shaded regions.

    nl = NumberLine(; x_range=(-5, 5))
    closed_point!(nl, -3)
    open_point!(nl, 2)
    shade!(nl, -3, 2)
    svg = render(nl)
"""
mutable struct NumberLine
    _x_min::Float64
    _x_max::Float64
    _width::Int
    _height::Int
    _padding::Int
    _elements::Vector{Tuple}

    function NumberLine(; x_range=(-5, 5), width::Int=300, height::Int=60, padding::Int=30)
        new(Float64(x_range[1]), Float64(x_range[2]),
            width, height, padding,
            Tuple[])
    end
end

function _tx_nl(nl::NumberLine, x)
    inner_w = nl._width - 2 * nl._padding
    return round(nl._padding + (x - nl._x_min) / (nl._x_max - nl._x_min) * inner_w; digits=1)
end

function open_point!(nl::NumberLine, x)
    push!(nl._elements, (:open_point, Float64(x)))
end

function closed_point!(nl::NumberLine, x)
    push!(nl._elements, (:closed_point, Float64(x)))
end

function shade!(nl::NumberLine, x_left, x_right)
    push!(nl._elements, (:shade, Float64(x_left), Float64(x_right)))
end

function shade_left!(nl::NumberLine, x)
    push!(nl._elements, (:shade_left, Float64(x)))
end

function shade_right!(nl::NumberLine, x)
    push!(nl._elements, (:shade_right, Float64(x)))
end

function render(nl::NumberLine)
    parts = String[]
    pad = nl._padding
    inner_w = nl._width - 2 * pad
    cy = nl._height / 2.0
    left_x = pad
    right_x = pad + inner_w
    tick_h = 6.0

    # Axis arrow marker
    push!(parts, """<defs><marker id="nla" markerWidth="8" markerHeight="6" refX="8" refY="3" orient="auto"><polygon points="0 0,8 3,0 6" fill="currentColor"/></marker><marker id="nlb" markerWidth="8" markerHeight="6" refX="0" refY="3" orient="auto"><polygon points="8 0,0 3,8 6" fill="currentColor"/></marker></defs>""")

    # Shaded regions (render first, behind everything)
    for el in nl._elements
        kind = el[1]
        if kind === :shade
            _, xl, xr = el
            sx1 = _tx_nl(nl, xl)
            sx2 = _tx_nl(nl, xr)
            push!(parts, """<rect x="$(sx1)" y="$(round(cy - 8; digits=1))" width="$(round(sx2 - sx1; digits=1))" height="16" fill="#3b82f6" fill-opacity="0.2"/>""")
        elseif kind === :shade_left
            _, xv = el
            sx = _tx_nl(nl, xv)
            push!(parts, """<rect x="$(left_x)" y="$(round(cy - 8; digits=1))" width="$(round(sx - left_x; digits=1))" height="16" fill="#3b82f6" fill-opacity="0.2"/>""")
        elseif kind === :shade_right
            _, xv = el
            sx = _tx_nl(nl, xv)
            push!(parts, """<rect x="$(sx)" y="$(round(cy - 8; digits=1))" width="$(round(right_x - sx; digits=1))" height="16" fill="#3b82f6" fill-opacity="0.2"/>""")
        end
    end

    # Main axis line with arrowheads at both ends
    push!(parts, """<line x1="$(left_x)" y1="$(cy)" x2="$(right_x)" y2="$(cy)" stroke="currentColor" stroke-width="1.5" marker-start="url(#nlb)" marker-end="url(#nla)"/>""")

    # Integer tick marks with labels
    for xi in Int(ceil(nl._x_min)):Int(floor(nl._x_max))
        gx = _tx_nl(nl, xi)
        push!(parts, """<line x1="$(gx)" y1="$(round(cy - tick_h; digits=1))" x2="$(gx)" y2="$(round(cy + tick_h; digits=1))" stroke="currentColor" stroke-width="1"/>""")
        push!(parts, """<text x="$(gx)" y="$(round(cy + tick_h + 14; digits=1))" font-size="11" fill="currentColor" text-anchor="middle">$(xi)</text>""")
    end

    # Points (open and closed)
    for el in nl._elements
        kind = el[1]
        if kind === :closed_point
            _, xv = el
            sx = _tx_nl(nl, xv)
            push!(parts, """<circle cx="$(sx)" cy="$(cy)" r="4" fill="currentColor"/>""")
        elseif kind === :open_point
            _, xv = el
            sx = _tx_nl(nl, xv)
            push!(parts, """<circle cx="$(sx)" cy="$(cy)" r="4" fill="var(--bg,#1a1a2e)" stroke="currentColor" stroke-width="2"/>""")
        end
    end

    vb = "0 0 $(nl._width) $(nl._height)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(nl._width)px">$(body)</svg>"""
end
