#= ScatterPlot — scatter plot with optional regression line =#

"""
Scatter plot for paired (x, y) data with optional least-squares regression line.

    sp = ScatterPlot(; width=300, height=250)
    scatter_points!(sp, [1,2,3,4,5], [2,4,5,4,5])
    regression_line!(sp, 0.4, 2.2)   # y = 2.2 + 0.4x
    svg = render(sp)
"""
mutable struct ScatterPlot
    _width::Int
    _height::Int
    _padding::Int
    _points::Vector{Tuple{Float64,Float64}}
    _regression::Union{Nothing,Tuple{Float64,Float64}}  # (slope, intercept)
    _x_label::String
    _y_label::String

    function ScatterPlot(; width::Int=300, height::Int=250, padding::Int=40,
                          x_label::String="", y_label::String="")
        new(width, height, padding, Tuple{Float64,Float64}[], nothing, x_label, y_label)
    end
end

"""Add scatter points from parallel x and y vectors."""
function scatter_points!(sp::ScatterPlot, xs, ys)
    length(xs) == length(ys) || error("xs and ys must have same length")
    for (x, y) in zip(xs, ys)
        push!(sp._points, (Float64(x), Float64(y)))
    end
end

"""Add a regression line y = intercept + slope*x."""
function regression_line!(sp::ScatterPlot, slope, intercept)
    sp._regression = (Float64(slope), Float64(intercept))
end

function render(sp::ScatterPlot)
    isempty(sp._points) && return """<svg xmlns="http://www.w3.org/2000/svg"></svg>"""

    parts = String[]
    pad = sp._padding
    w, h = sp._width, sp._height
    inner_w = w - 2 * pad
    inner_h = h - 2 * pad

    xs = [p[1] for p in sp._points]
    ys = [p[2] for p in sp._points]

    x_min = minimum(xs)
    x_max = maximum(xs)
    y_min = minimum(ys)
    y_max = maximum(ys)

    # Add margin
    xm = (x_max - x_min) * 0.1
    ym = (y_max - y_min) * 0.1
    xm == 0 && (xm = 1)
    ym == 0 && (ym = 1)
    x_lo = x_min - xm
    x_hi = x_max + xm
    y_lo = y_min - ym
    y_hi = y_max + ym

    to_sx(x) = round(pad + (x - x_lo) / (x_hi - x_lo) * inner_w; digits=1)
    to_sy(y) = round(pad + (y_hi - y) / (y_hi - y_lo) * inner_h; digits=1)

    # Grid lines
    for i in 0:4
        xv = x_lo + (x_hi - x_lo) * i / 4
        yv = y_lo + (y_hi - y_lo) * i / 4
        gx = to_sx(xv)
        gy = to_sy(yv)

        push!(parts, """<line x1="$(gx)" y1="$(pad)" x2="$(gx)" y2="$(pad + inner_h)" stroke="currentColor" stroke-opacity="0.08" stroke-width="1"/>""")
        push!(parts, """<line x1="$(pad)" y1="$(gy)" x2="$(pad + inner_w)" y2="$(gy)" stroke="currentColor" stroke-opacity="0.08" stroke-width="1"/>""")

        x_label = xv == round(xv) ? string(Int(round(xv))) : string(round(xv; digits=1))
        y_label = yv == round(yv) ? string(Int(round(yv))) : string(round(yv; digits=1))
        push!(parts, """<text x="$(gx)" y="$(pad + inner_h + 14)" font-size="10" fill="currentColor" text-anchor="middle">$(x_label)</text>""")
        push!(parts, """<text x="$(pad - 6)" y="$(round(gy + 4; digits=1))" font-size="10" fill="currentColor" text-anchor="end">$(y_label)</text>""")
    end

    # Axes
    push!(parts, """<line x1="$(pad)" y1="$(pad + inner_h)" x2="$(pad + inner_w)" y2="$(pad + inner_h)" stroke="currentColor" stroke-width="1"/>""")
    push!(parts, """<line x1="$(pad)" y1="$(pad)" x2="$(pad)" y2="$(pad + inner_h)" stroke="currentColor" stroke-width="1"/>""")

    # Regression line (draw before points so points appear on top)
    if sp._regression !== nothing
        slope, intercept = sp._regression
        rl_y1 = intercept + slope * x_lo
        rl_y2 = intercept + slope * x_hi
        push!(parts, """<line x1="$(to_sx(x_lo))" y1="$(to_sy(rl_y1))" x2="$(to_sx(x_hi))" y2="$(to_sy(rl_y2))" stroke="#ef4444" stroke-width="2" stroke-dasharray="6,3"/>""")
    end

    # Points
    for (px, py) in sp._points
        sx = to_sx(px)
        sy = to_sy(py)
        push!(parts, """<circle cx="$(sx)" cy="$(sy)" r="4" fill="#3b82f6" fill-opacity="0.8"/>""")
    end

    # Axis labels
    if !isempty(sp._x_label)
        push!(parts, """<text x="$(pad + inner_w / 2)" y="$(h - 4)" font-size="11" fill="currentColor" text-anchor="middle">$(sp._x_label)</text>""")
    end
    if !isempty(sp._y_label)
        push!(parts, """<text x="12" y="$(pad + inner_h / 2)" font-size="11" fill="currentColor" text-anchor="middle" transform="rotate(-90, 12, $(pad + inner_h / 2))">$(sp._y_label)</text>""")
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
