#= VennDiagram, BarChart, PieChart =#

# ---------------------------------------------------------------------------
# VennDiagram
# ---------------------------------------------------------------------------

"""
Venn diagram with 2 or 3 overlapping circles.

    vd = VennDiagram(; sets=2)
    label_set!(vd, 1, "A")
    label_region!(vd, [1, 2], "5")
    svg = render(vd)
"""
mutable struct VennDiagram
    _sets::Int
    _width::Int
    _height::Int
    _set_labels::Dict{Int,String}
    _region_labels::Vector{Tuple{Vector{Int},String}}

    function VennDiagram(; sets::Int=2, width::Int=280, height::Int=200)
        (sets == 2 || sets == 3) || error("VennDiagram supports 2 or 3 sets")
        new(sets, width, height, Dict{Int,String}(), Tuple{Vector{Int},String}[])
    end
end

function label_set!(vd::VennDiagram, idx::Int, label::String)
    vd._set_labels[idx] = label
end

function label_region!(vd::VennDiagram, sets::Vector{Int}, label::String)
    push!(vd._region_labels, (sort(sets), label))
end

function render(vd::VennDiagram)
    parts = String[]
    placed = _BBox[]
    w, h = vd._width, vd._height

    if vd._sets == 2
        r = min(w, h) * 0.28
        cx1, cy1 = w * 0.38, h * 0.5
        cx2, cy2 = w * 0.62, h * 0.5
        centers = [(cx1, cy1), (cx2, cy2)]
        region_centroids = Dict{Vector{Int},Tuple{Float64,Float64}}(
            [1] => (cx1 - r * 0.45, cy1),
            [2] => (cx2 + r * 0.45, cy2),
            [1, 2] => ((cx1 + cx2) / 2, (cy1 + cy2) / 2),
        )
    else
        r = min(w, h) * 0.25
        cx1, cy1 = w * 0.42, h * 0.38
        cx2, cy2 = w * 0.58, h * 0.38
        cx3, cy3 = w * 0.50, h * 0.58
        centers = [(cx1, cy1), (cx2, cy2), (cx3, cy3)]
        region_centroids = Dict{Vector{Int},Tuple{Float64,Float64}}(
            [1] => (cx1 - r * 0.4, cy1 - r * 0.2),
            [2] => (cx2 + r * 0.4, cy2 - r * 0.2),
            [3] => (cx3, cy3 + r * 0.45),
            [1, 2] => ((cx1 + cx2) / 2, cy1 - r * 0.1),
            [1, 3] => ((cx1 + cx3) / 2 - r * 0.15, (cy1 + cy3) / 2 + r * 0.1),
            [2, 3] => ((cx2 + cx3) / 2 + r * 0.15, (cy2 + cy3) / 2 + r * 0.1),
            [1, 2, 3] => ((cx1 + cx2 + cx3) / 3, (cy1 + cy2 + cy3) / 3),
        )
    end

    colors = ["#3b82f6", "#ef4444", "#10b981"]

    for (i, (cx, cy)) in enumerate(centers)
        push!(parts, """<circle cx="$(round(cx; digits=1))" cy="$(round(cy; digits=1))" r="$(round(r; digits=1))" stroke="$(colors[i])" stroke-width="2" fill="$(colors[i])" fill-opacity="0.1"/>""")
    end

    for (idx, lbl) in vd._set_labels
        idx > length(centers) && continue
        cx, cy = centers[idx]
        ly = cy - r - 8
        push!(parts, """<text x="$(round(cx; digits=1))" y="$(round(ly; digits=1))" font-size="14" fill="currentColor" text-anchor="middle" font-weight="bold">$(lbl)</text>""")
    end

    for (sets, lbl) in vd._region_labels
        centroid = get(region_centroids, sets, nothing)
        centroid === nothing && continue
        rx, ry = centroid
        lx, ly = _nudge_label(rx, ry, 0.0, 0.0, placed; text_len=length(lbl))
        push!(parts, """<text x="$(lx)" y="$(ly)" font-size="13" fill="currentColor" text-anchor="middle" dominant-baseline="central">$(lbl)</text>""")
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end

# ---------------------------------------------------------------------------
# BarChart
# ---------------------------------------------------------------------------

"""
Vertical bar chart with auto-scaled y-axis.

    bc = BarChart(; width=300, height=200)
    bar!(bc, "Mon", 5)
    bars!(bc, ["Tue", "Wed"], [8, 3])
    svg = render(bc)
"""
mutable struct BarChart
    _width::Int
    _height::Int
    _padding::Int
    _bars::Vector{Tuple{String,Float64}}

    function BarChart(; width::Int=300, height::Int=200, padding::Int=40)
        new(width, height, padding, Tuple{String,Float64}[])
    end
end

function bar!(bc::BarChart, label::String, value)
    push!(bc._bars, (label, Float64(value)))
end

function bars!(bc::BarChart, labels::Vector{String}, values)
    for (l, v) in zip(labels, values)
        bar!(bc, l, v)
    end
end

function render(bc::BarChart)
    isempty(bc._bars) && return """<svg xmlns="http://www.w3.org/2000/svg"></svg>"""

    parts = String[]
    pad = bc._padding
    w, h = bc._width, bc._height
    inner_w = w - 2 * pad
    inner_h = h - 2 * pad

    vals = [v for (_, v) in bc._bars]
    y_max = maximum(vals) * 1.15
    y_max == 0 && (y_max = 1)
    n = length(bc._bars)
    bar_w = inner_w / n * 0.7
    gap = inner_w / n * 0.3

    n_grid = 4
    for i in 0:n_grid
        yv = y_max * i / n_grid
        gy = pad + inner_h - (yv / y_max) * inner_h
        push!(parts, """<line x1="$(pad)" y1="$(round(gy; digits=1))" x2="$(pad + inner_w)" y2="$(round(gy; digits=1))" stroke="currentColor" stroke-opacity="0.12" stroke-width="1"/>""")
        label = yv == round(yv) ? string(Int(round(yv))) : string(round(yv; digits=1))
        push!(parts, """<text x="$(pad - 6)" y="$(round(gy + 4; digits=1))" font-size="10" fill="currentColor" text-anchor="end">$(label)</text>""")
    end

    push!(parts, """<line x1="$(pad)" y1="$(pad + inner_h)" x2="$(pad + inner_w)" y2="$(pad + inner_h)" stroke="currentColor" stroke-width="1"/>""")

    for (i, (label, val)) in enumerate(bc._bars)
        bx = pad + (i - 1) * (inner_w / n) + gap / 2
        bh = (val / y_max) * inner_h
        by = pad + inner_h - bh
        color = _PLOT_COLORS[mod1(i, length(_PLOT_COLORS))]
        push!(parts, """<rect x="$(round(bx; digits=1))" y="$(round(by; digits=1))" width="$(round(bar_w; digits=1))" height="$(round(bh; digits=1))" fill="$(color)" fill-opacity="0.7" rx="2"/>""")
        val_str = val == round(val) ? string(Int(round(val))) : string(round(val; digits=1))
        push!(parts, """<text x="$(round(bx + bar_w / 2; digits=1))" y="$(round(by - 5; digits=1))" font-size="11" fill="currentColor" text-anchor="middle">$(val_str)</text>""")
        push!(parts, """<text x="$(round(bx + bar_w / 2; digits=1))" y="$(pad + inner_h + 14)" font-size="10" fill="currentColor" text-anchor="middle">$(label)</text>""")
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end

# ---------------------------------------------------------------------------
# PieChart
# ---------------------------------------------------------------------------

"""
Pie chart with colored slices and labels.

    pc = PieChart(; width=200, height=200)
    slice!(pc, "A", 30)
    slice!(pc, "B", 50)
    svg = render(pc)
"""
mutable struct PieChart
    _width::Int
    _height::Int
    _slices::Vector{Tuple{String,Float64}}

    function PieChart(; width::Int=200, height::Int=200)
        new(width, height, Tuple{String,Float64}[])
    end
end

function slice!(pc::PieChart, label::String, value)
    push!(pc._slices, (label, Float64(value)))
end

function render(pc::PieChart)
    isempty(pc._slices) && return """<svg xmlns="http://www.w3.org/2000/svg"></svg>"""

    parts = String[]
    label_pad = 50  # extra space for labels around the pie
    w, h = pc._width + label_pad, pc._height + label_pad
    cx, cy = w / 2.0, h / 2.0
    r = min(pc._width, pc._height) * 0.38
    label_r = r + 16

    total = sum(v for (_, v) in pc._slices)
    total == 0 && (total = 1)

    placed = _BBox[]
    angle = -π / 2

    for (i, (label, val)) in enumerate(pc._slices)
        sweep = (val / total) * 2π
        a1 = angle
        a2 = angle + sweep

        x1 = cx + r * cos(a1)
        y1 = cy + r * sin(a1)
        x2 = cx + r * cos(a2)
        y2 = cy + r * sin(a2)
        large = sweep > π ? 1 : 0
        color = _PLOT_COLORS[mod1(i, length(_PLOT_COLORS))]

        push!(parts, """<path d="M$(round(cx; digits=1)),$(round(cy; digits=1)) L$(round(x1; digits=1)),$(round(y1; digits=1)) A$(round(r; digits=1)),$(round(r; digits=1)) 0 $(large) 1 $(round(x2; digits=1)),$(round(y2; digits=1)) Z" fill="$(color)" fill-opacity="0.7" stroke="var(--bg,#1a1a2e)" stroke-width="2"/>""")

        mid_a = (a1 + a2) / 2
        lx = cx + label_r * cos(mid_a)
        ly = cy + label_r * sin(mid_a)
        anchor = abs(cos(mid_a)) < 0.1 ? "middle" : (cos(mid_a) > 0 ? "start" : "end")
        flx, fly = _nudge_label(lx, ly, 0.0, 0.0, placed; text_len=length(label))
        push!(parts, """<text x="$(flx)" y="$(fly)" font-size="11" fill="currentColor" text-anchor="$(anchor)">$(label)</text>""")

        angle = a2
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
