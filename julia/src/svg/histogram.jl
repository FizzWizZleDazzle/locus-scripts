#= Histogram — binned frequency chart for statistics =#

"""
Histogram with automatic or manual binning.

    h = Histogram(; width=300, height=200)
    bins_from_data!(h, [3, 7, 7, 8, 12, 14, 14, 14, 18]; n_bins=5)
    svg = render(h)
"""
mutable struct Histogram
    _width::Int
    _height::Int
    _padding::Int
    _bins::Vector{Tuple{Float64,Float64,Int}}  # (lo, hi, count)
    _x_label::String
    _y_label::String

    function Histogram(; width::Int=300, height::Int=200, padding::Int=40,
                        x_label::String="", y_label::String="")
        new(width, height, padding, Tuple{Float64,Float64,Int}[], x_label, y_label)
    end
end

"""Add a single bin manually: bin!(h, lo, hi, count)."""
function bin!(h::Histogram, lo, hi, count::Int)
    push!(h._bins, (Float64(lo), Float64(hi), count))
end

"""Auto-bin data into n_bins equal-width bins."""
function bins_from_data!(h::Histogram, data; n_bins::Int=5)
    h._bins = Tuple{Float64,Float64,Int}[]
    lo = Float64(minimum(data))
    hi = Float64(maximum(data))
    hi == lo && (hi = lo + 1)
    bw = (hi - lo) / n_bins
    for i in 1:n_bins
        edge_lo = lo + (i - 1) * bw
        edge_hi = lo + i * bw
        c = count(x -> (i == n_bins ? edge_lo <= x <= edge_hi : edge_lo <= x < edge_hi), data)
        push!(h._bins, (edge_lo, edge_hi, c))
    end
end

function render(h::Histogram)
    isempty(h._bins) && return """<svg xmlns="http://www.w3.org/2000/svg"></svg>"""

    parts = String[]
    pad = h._padding
    w, h_px = h._width, h._height
    inner_w = w - 2 * pad
    inner_h = h_px - 2 * pad

    max_count = maximum(c for (_, _, c) in h._bins)
    max_count == 0 && (max_count = 1)
    y_max = max_count * 1.15

    x_min = h._bins[1][1]
    x_max = h._bins[end][2]
    x_range = x_max - x_min
    x_range == 0 && (x_range = 1)

    # Y-axis grid
    n_grid = 4
    for i in 0:n_grid
        yv = y_max * i / n_grid
        gy = pad + inner_h - (yv / y_max) * inner_h
        push!(parts, """<line x1="$(pad)" y1="$(round(gy; digits=1))" x2="$(pad + inner_w)" y2="$(round(gy; digits=1))" stroke="currentColor" stroke-opacity="0.12" stroke-width="1"/>""")
        label = string(round(Int, yv))
        push!(parts, """<text x="$(pad - 6)" y="$(round(gy + 4; digits=1))" font-size="10" fill="currentColor" text-anchor="end">$(label)</text>""")
    end

    # X-axis
    push!(parts, """<line x1="$(pad)" y1="$(pad + inner_h)" x2="$(pad + inner_w)" y2="$(pad + inner_h)" stroke="currentColor" stroke-width="1"/>""")
    # Y-axis
    push!(parts, """<line x1="$(pad)" y1="$(pad)" x2="$(pad)" y2="$(pad + inner_h)" stroke="currentColor" stroke-width="1"/>""")

    # Bars
    for (i, (blo, bhi, cnt)) in enumerate(h._bins)
        bx = pad + (blo - x_min) / x_range * inner_w
        bw_px = (bhi - blo) / x_range * inner_w
        bh_px = (cnt / y_max) * inner_h
        by = pad + inner_h - bh_px
        color = _PLOT_COLORS[mod1(i, length(_PLOT_COLORS))]
        push!(parts, """<rect x="$(round(bx; digits=1))" y="$(round(by; digits=1))" width="$(round(bw_px; digits=1))" height="$(round(bh_px; digits=1))" fill="$(color)" fill-opacity="0.7" stroke="currentColor" stroke-opacity="0.3" stroke-width="1"/>""")

        # Count label above bar
        if cnt > 0
            push!(parts, """<text x="$(round(bx + bw_px / 2; digits=1))" y="$(round(by - 4; digits=1))" font-size="10" fill="currentColor" text-anchor="middle">$(cnt)</text>""")
        end
    end

    # Bin edge labels on x-axis
    edges = unique([h._bins[1][1]; [b[2] for b in h._bins]])
    for edge in edges
        ex = pad + (edge - x_min) / x_range * inner_w
        label = edge == round(edge) ? string(Int(round(edge))) : string(round(edge; digits=1))
        push!(parts, """<text x="$(round(ex; digits=1))" y="$(pad + inner_h + 14)" font-size="9" fill="currentColor" text-anchor="middle">$(label)</text>""")
    end

    # Axis labels
    if !isempty(h._x_label)
        push!(parts, """<text x="$(pad + inner_w / 2)" y="$(h_px - 4)" font-size="11" fill="currentColor" text-anchor="middle">$(h._x_label)</text>""")
    end
    if !isempty(h._y_label)
        push!(parts, """<text x="12" y="$(pad + inner_h / 2)" font-size="11" fill="currentColor" text-anchor="middle" transform="rotate(-90, 12, $(pad + inner_h / 2))">$(h._y_label)</text>""")
    end

    vb = "0 0 $(w) $(h_px)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
