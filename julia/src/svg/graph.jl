#= GraphObj — function plots on a coordinate grid =#

using Symbolics: build_function, get_variables

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
    _plots::Vector{Tuple{Any,String,Bool,Union{Nothing,String}}}
    _plots_fill::Vector{Tuple{Any,Any,String,Float64}}
    _points::Vector{Tuple{Float64,Float64,Union{Nothing,String}}}
    _vlines::Vector{Tuple{Float64,Bool}}
    _hlines::Vector{Tuple{Float64,Bool}}
    _color_idx::Int
    _grid_step::Float64
    _axis_labels::Union{Nothing,Tuple{String,String}}
    _show_legend::Bool
    _labels::Vector{Tuple{Float64,Float64,String}}
    _asymptotes::Vector{Tuple{Float64,String}}
    _parametric_plots::Vector{Tuple{Any,Float64,Float64,String,Bool,Union{Nothing,String}}}

    function GraphObj(; x_range=(-5, 5), y_range=(-5, 5), width::Int=300, height::Int=300,
                       padding::Int=35, grid_step::Float64=1.0,
                       axis_labels::Union{Nothing,Tuple{String,String}}=nothing,
                       show_legend::Bool=false)
        new(Float64(x_range[1]), Float64(x_range[2]),
            Float64(y_range[1]), Float64(y_range[2]),
            width, height, padding,
            Tuple{Any,String,Bool,Union{Nothing,String}}[],
            Tuple{Any,Any,String,Float64}[],
            Tuple{Float64,Float64,Union{Nothing,String}}[],
            Tuple{Float64,Bool}[],
            Tuple{Float64,Bool}[],
            0,
            grid_step,
            axis_labels,
            show_legend,
            Tuple{Float64,Float64,String}[],
            Tuple{Float64,String}[],
            Tuple{Any,Float64,Float64,String,Bool,Union{Nothing,String}}[])
    end
end

function _next_color!(g::GraphObj)
    c = _PLOT_COLORS[mod1(g._color_idx + 1, length(_PLOT_COLORS))]
    g._color_idx += 1
    return c
end

function plot!(g::GraphObj, expr; color=nothing, dashed::Bool=false, name::Union{Nothing,String}=nothing)
    c = color !== nothing ? color : _next_color!(g)
    push!(g._plots, (expr, c, dashed, name))
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

function asymptote!(g::GraphObj, x; label::Union{Nothing,String}=nothing)
    lbl = label !== nothing ? label : "x = $(x)"
    push!(g._asymptotes, (Float64(x), lbl))
    vline!(g, x; dashed=true)
end

function label!(g::GraphObj, x, y, text)
    push!(g._labels, (Float64(x), Float64(y), text))
end

function plot_parametric!(g::GraphObj, f, t_min, t_max;
                          color=nothing, dashed::Bool=false, name::Union{Nothing,String}=nothing)
    c = color !== nothing ? color : _next_color!(g)
    push!(g._parametric_plots, (f, Float64(t_min), Float64(t_max), c, dashed, name))
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

    for i in 0:n_base
        xv = x_min + i * step
        yv = try Float64(f(xv)) catch; NaN end
        push!(xs, xv)
        push!(ys, yv)
    end

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

    max_extra = 400 - length(xs)
    for rx in refined_xs[1:min(length(refined_xs), max_extra)]
        yv = try Float64(f(rx)) catch; NaN end
        push!(xs, rx)
        push!(ys, yv)
    end

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

"""Render a polyline from SVG-coordinate pairs."""
function _render_polyline!(parts, pairs, color, dashed; stroke_width=2, opacity="0.85")
    length(pairs) < 2 && return
    pts_str = join(["$(round(px; digits=1)),$(round(py; digits=1))" for (px, py) in pairs], " ")
    dash_attr = dashed ? """ stroke-dasharray="6,4\"""" : ""
    push!(parts, """<polyline points="$(pts_str)" stroke="$(color)" stroke-width="$(stroke_width)" fill="none" stroke-opacity="$(opacity)"$(dash_attr)/>""")
end

function _format_tick(v::Float64)
    v == round(v) ? string(Int(round(v))) : string(round(v; digits=2))
end

function render(g::GraphObj)
    parts = String[]

    pad = g._padding
    inner_w = g._width - 2 * pad
    inner_h = g._height - 2 * pad
    bot = pad + inner_h
    r = pad + inner_w
    has_axes = (g._y_min <= 0 <= g._y_max) || (g._x_min <= 0 <= g._x_max)

    ct = _CoordTransform(Float64(pad), Float64(g._width), Float64(g._height),
                         g._x_min, g._x_max, g._y_min, g._y_max)
    txg(px, py) = _apply_graph(ct, px, py)

    markers = Set{Symbol}()
    if has_axes
        push!(markers, :axis_fwd)
    end

    push!(parts, """<style>.g{stroke:currentColor;stroke-opacity:.12;stroke-width:1}.a{stroke:currentColor;stroke-width:1.5}.t{font-size:10px;fill:currentColor}</style>""")

    markers_str = _emit_markers(markers)
    if !isempty(markers_str)
        push!(parts, markers_str)
    end

    # grid lines
    gs = g._grid_step
    xi = ceil(g._x_min / gs) * gs
    while xi <= g._x_max
        gx, _ = txg(xi, 0)
        push!(parts, """<line x1="$(gx)" y1="$(pad)" x2="$(gx)" y2="$(bot)" class="g"/>""")
        xi += gs
    end
    yi = ceil(g._y_min / gs) * gs
    while yi <= g._y_max
        _, gy = txg(0, yi)
        push!(parts, """<line x1="$(pad)" y1="$(gy)" x2="$(r)" y2="$(gy)" class="g"/>""")
        yi += gs
    end

    # axes
    if g._y_min <= 0 <= g._y_max
        _, ay = txg(0, 0)
        push!(parts, """<line x1="$(pad)" y1="$(ay)" x2="$(r)" y2="$(ay)" class="a" marker-end="url(#ax)"/>""")
    end
    if g._x_min <= 0 <= g._x_max
        ax, _ = txg(0, 0)
        push!(parts, """<line x1="$(ax)" y1="$(bot)" x2="$(ax)" y2="$(pad)" class="a" marker-end="url(#ax)"/>""")
    end

    # x tick labels
    xi = ceil(g._x_min / gs) * gs
    while xi <= g._x_max
        if abs(xi) > gs * 0.01
            gx, y0 = txg(xi, 0)
            yl = min(y0 + 16, bot + 16)
            push!(parts, """<text x="$(gx)" y="$(yl)" class="t" text-anchor="middle">$(_format_tick(xi))</text>""")
        end
        xi += gs
    end

    # y tick labels
    yi = ceil(g._y_min / gs) * gs
    while yi <= g._y_max
        if abs(yi) > gs * 0.01
            x0, gy = txg(0, yi)
            xl = max(x0 - 8, pad - 20)
            push!(parts, """<text x="$(xl)" y="$(round(gy + 4; digits=1))" class="t" text-anchor="end">$(_format_tick(yi))</text>""")
        end
        yi += gs
    end

    # axis labels
    if g._axis_labels !== nothing
        x_label, y_label = g._axis_labels
        if !isempty(x_label)
            push!(parts, """<text x="$(r - 4)" y="$(round(bot + 28; digits=1))" font-size="12" fill="currentColor" text-anchor="end">$(x_label)</text>""")
        end
        if !isempty(y_label)
            push!(parts, """<text x="$(round(pad - 8; digits=1))" y="$(pad - 8)" font-size="12" fill="currentColor" text-anchor="end">$(y_label)</text>""")
        end
    end

    # vertical lines
    for (vx, dashed) in g._vlines
        gx, _ = txg(vx, 0)
        dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
        push!(parts, """<line x1="$(gx)" y1="$(pad)" x2="$(gx)" y2="$(bot)" stroke="currentColor" stroke-opacity="0.5" stroke-width="1.5"$(dash)/>""")
    end

    # horizontal lines
    for (hy, dashed) in g._hlines
        _, gy = txg(0, hy)
        dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
        push!(parts, """<line x1="$(pad)" y1="$(gy)" x2="$(r)" y2="$(gy)" stroke="currentColor" stroke-opacity="0.5" stroke-width="1.5"$(dash)/>""")
    end

    # asymptote labels
    for (ax_val, ax_lbl) in g._asymptotes
        gx, _ = txg(ax_val, 0)
        push!(parts, """<text x="$(round(gx + 4; digits=1))" y="$(pad + 12)" font-size="10" fill="currentColor" fill-opacity="0.7">$(ax_lbl)</text>""")
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

        n = 80
        step = (g._x_max - g._x_min) / n
        upper_pts = Tuple{Float64,Float64}[]
        lower_pts = Tuple{Float64,Float64}[]
        for i in 0:n
            xv = g._x_min + i * step
            y1v = try Float64(f1(xv)) catch; NaN end
            y2v = try Float64(f2(xv)) catch; NaN end
            (isfinite(y1v) && isfinite(y2v)) || continue
            y1c = clamp(y1v, g._y_min, g._y_max)
            y2c = clamp(y2v, g._y_min, g._y_max)
            push!(upper_pts, (xv, y1c))
            push!(lower_pts, (xv, y2c))
        end

        if length(upper_pts) >= 2
            poly_pts = String[]
            for (px, py) in upper_pts
                sx, sy = txg(px, py)
                push!(poly_pts, "$(round(sx; digits=1)),$(round(sy; digits=1))")
            end
            for (px, py) in reverse(lower_pts)
                sx, sy = txg(px, py)
                push!(poly_pts, "$(round(sx; digits=1)),$(round(sy; digits=1))")
            end
            push!(parts, """<polygon points="$(join(poly_pts, " "))" fill="$(color)" fill-opacity="$(opacity)" stroke="none"/>""")
        end
    end

    # plot curves
    for (expr, color, dashed, _name) in g._plots
        vars = get_variables(expr)
        isempty(vars) && continue
        var = first(vars)
        f = try build_function(expr, var; expression=Val{false}) catch; continue end

        xs, ys = _adaptive_sample(f, g._x_min, g._x_max, y_span)
        segments = _segment_points(xs, ys, y_span)

        for seg in segments
            svg_pairs = [txg(px, py) for (px, py) in seg]
            _render_polyline!(parts, svg_pairs, color, dashed)
        end
    end

    # parametric plots
    for (f, t_min, t_max, color, dashed, _name) in g._parametric_plots
        n_pts = 200
        dt = (t_max - t_min) / n_pts
        svg_pairs = Tuple{Float64,Float64}[]
        for i in 0:n_pts
            t = t_min + i * dt
            xy = try f(t) catch; (NaN, NaN) end
            xv, yv = Float64(xy[1]), Float64(xy[2])
            if isfinite(xv) && isfinite(yv) && g._x_min <= xv <= g._x_max && g._y_min <= yv <= g._y_max
                push!(svg_pairs, txg(xv, yv))
            else
                _render_polyline!(parts, svg_pairs, color, dashed)
                svg_pairs = Tuple{Float64,Float64}[]
            end
        end
        _render_polyline!(parts, svg_pairs, color, dashed)
    end

    # points
    placed_labels = _BBox[]
    for (px, py, plabel) in g._points
        sx, sy = txg(px, py)
        push!(parts, """<circle cx="$(sx)" cy="$(sy)" r="3.5" fill="currentColor"/>""")
        if plabel !== nothing
            lx, ly = _nudge_label(sx, sy, 7.0, -7.0, placed_labels; text_len=length(plabel))
            push!(parts, """<text x="$(lx)" y="$(ly)" font-size="12" fill="currentColor">$(plabel)</text>""")
        end
    end

    # coordinate labels (no dot)
    for (lx_val, ly_val, ltxt) in g._labels
        sx, sy = txg(lx_val, ly_val)
        lx, ly = _nudge_label(sx, sy, 6.0, -6.0, placed_labels; text_len=length(ltxt))
        push!(parts, """<text x="$(lx)" y="$(ly)" font-size="12" fill="currentColor">$(ltxt)</text>""")
    end

    # auto-legend
    if g._show_legend
        legend_items = Tuple{String,String,Bool}[]
        for (_, color, dashed, name) in g._plots
            name !== nothing && push!(legend_items, (name, color, dashed))
        end
        for (_, _, _, color, dashed, name) in g._parametric_plots
            name !== nothing && push!(legend_items, (name, color, dashed))
        end
        if !isempty(legend_items)
            lw = 80
            lh = length(legend_items) * 18 + 8
            lx_start = r - lw - 4
            ly_start = pad + 4
            push!(parts, """<rect x="$(lx_start)" y="$(ly_start)" width="$(lw)" height="$(lh)" fill="var(--bg,#1a1a2e)" fill-opacity="0.85" stroke="currentColor" stroke-opacity="0.3" rx="3"/>""")
            for (idx, (name, color, dashed)) in enumerate(legend_items)
                iy = ly_start + 6 + (idx - 1) * 18
                dash = dashed ? """ stroke-dasharray="4,3\"""" : ""
                push!(parts, """<line x1="$(lx_start + 6)" y1="$(iy + 7)" x2="$(lx_start + 22)" y2="$(iy + 7)" stroke="$(color)" stroke-width="2"$(dash)/>""")
                push!(parts, """<text x="$(lx_start + 26)" y="$(iy + 11)" font-size="10" fill="currentColor">$(name)</text>""")
            end
        end
    end

    vb = "0 0 $(g._width) $(g._height)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(g._width)px">$(body)</svg>"""
end
