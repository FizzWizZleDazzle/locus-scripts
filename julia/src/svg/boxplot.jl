#= BoxPlot — box-and-whisker diagram for statistics =#

"""
Box-and-whisker plot. Supports multiple datasets stacked vertically.

    bp = BoxPlot(; width=300, height=150)
    add_data!(bp, [2, 3, 5, 7, 8, 9, 11, 14]; label="Set A")
    svg = render(bp)
"""
mutable struct BoxPlot
    _width::Int
    _height::Int
    _padding::Int
    _datasets::Vector{Tuple{String,Vector{Float64}}}

    function BoxPlot(; width::Int=300, height::Int=150, padding::Int=40)
        new(width, height, padding, Tuple{String,Vector{Float64}}[])
    end
end

"""Add a dataset with optional label."""
function add_data!(bp::BoxPlot, data; label::String="")
    push!(bp._datasets, (label, Float64.(collect(data))))
end

function render(bp::BoxPlot)
    isempty(bp._datasets) && return """<svg xmlns="http://www.w3.org/2000/svg"></svg>"""

    parts = String[]
    pad = bp._padding
    w = bp._width
    n = length(bp._datasets)
    # Adjust height for multiple datasets
    row_h = 40
    inner_h = max(row_h * n, 60)
    h = inner_h + 2 * pad

    # Find global min/max across all datasets
    all_vals = vcat([d for (_, d) in bp._datasets]...)
    g_min = minimum(all_vals)
    g_max = maximum(all_vals)
    margin = (g_max - g_min) * 0.1
    margin == 0 && (margin = 1)
    x_lo = g_min - margin
    x_hi = g_max + margin
    inner_w = w - 2 * pad

    to_x(v) = round(pad + (v - x_lo) / (x_hi - x_lo) * inner_w; digits=1)

    # X-axis
    push!(parts, """<line x1="$(pad)" y1="$(pad + inner_h)" x2="$(pad + inner_w)" y2="$(pad + inner_h)" stroke="currentColor" stroke-width="1"/>""")

    # Tick marks on x-axis
    n_ticks = 5
    for i in 0:n_ticks
        val = x_lo + (x_hi - x_lo) * i / n_ticks
        tx = to_x(val)
        label = val == round(val) ? string(Int(round(val))) : string(round(val; digits=1))
        push!(parts, """<line x1="$(tx)" y1="$(pad + inner_h)" x2="$(tx)" y2="$(pad + inner_h + 5)" stroke="currentColor" stroke-width="1"/>""")
        push!(parts, """<text x="$(tx)" y="$(pad + inner_h + 16)" font-size="10" fill="currentColor" text-anchor="middle">$(label)</text>""")
    end

    for (idx, (label, data)) in enumerate(bp._datasets)
        s = sort(data)
        n_pts = length(s)
        q = (
            min = s[1],
            Q1 = Float64(stat_median(s[1:n_pts÷2])),
            med = Float64(stat_median(s)),
            Q3 = Float64(stat_median(s[n_pts÷2 + (isodd(n_pts) ? 2 : 1):end])),
            max = s[end],
        )
        iqr = q.Q3 - q.Q1
        whisker_lo = max(q.min, q.Q1 - 1.5 * iqr)
        whisker_hi = min(q.max, q.Q3 + 1.5 * iqr)

        cy = pad + (idx - 0.5) * row_h
        box_h = row_h * 0.5
        top_y = round(cy - box_h / 2; digits=1)

        x1 = to_x(q.Q1)
        x3 = to_x(q.Q3)
        xm = to_x(q.med)
        xwl = to_x(whisker_lo)
        xwh = to_x(whisker_hi)

        color = _PLOT_COLORS[mod1(idx, length(_PLOT_COLORS))]

        # Box
        push!(parts, """<rect x="$(x1)" y="$(top_y)" width="$(round(x3 - x1; digits=1))" height="$(round(box_h; digits=1))" fill="$(color)" fill-opacity="0.2" stroke="$(color)" stroke-width="1.5"/>""")

        # Median line
        push!(parts, """<line x1="$(xm)" y1="$(top_y)" x2="$(xm)" y2="$(round(top_y + box_h; digits=1))" stroke="$(color)" stroke-width="2"/>""")

        # Whiskers
        push!(parts, """<line x1="$(xwl)" y1="$(round(cy; digits=1))" x2="$(x1)" y2="$(round(cy; digits=1))" stroke="$(color)" stroke-width="1.5"/>""")
        push!(parts, """<line x1="$(x3)" y1="$(round(cy; digits=1))" x2="$(xwh)" y2="$(round(cy; digits=1))" stroke="$(color)" stroke-width="1.5"/>""")

        # Whisker caps
        push!(parts, """<line x1="$(xwl)" y1="$(round(cy - box_h * 0.3; digits=1))" x2="$(xwl)" y2="$(round(cy + box_h * 0.3; digits=1))" stroke="$(color)" stroke-width="1.5"/>""")
        push!(parts, """<line x1="$(xwh)" y1="$(round(cy - box_h * 0.3; digits=1))" x2="$(xwh)" y2="$(round(cy + box_h * 0.3; digits=1))" stroke="$(color)" stroke-width="1.5"/>""")

        # Outlier dots
        for v in s
            if v < whisker_lo || v > whisker_hi
                ox = to_x(v)
                push!(parts, """<circle cx="$(ox)" cy="$(round(cy; digits=1))" r="3" fill="$(color)" fill-opacity="0.7"/>""")
            end
        end

        # Dataset label
        if !isempty(label)
            push!(parts, """<text x="$(pad - 6)" y="$(round(cy + 4; digits=1))" font-size="11" fill="currentColor" text-anchor="end">$(label)</text>""")
        end
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
