#= DiagramObj — geometry diagrams (polygons, angles, circles, etc.) =#

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
    _markers::Set{Symbol}

    function DiagramObj(; width::Int=300, height::Int=250, padding::Int=40, _kw...)
        new(width, height, padding,
            Tuple{Float64,Float64}[],
            Tuple[],
            Set{Symbol}())
    end
    DiagramObj(width::Int, height::Int; padding::Int=40, kw...) = DiagramObj(; width, height, padding)
end
# Catch-all: scripts pass wrong constructor args (tuples for ranges, etc.)
DiagramObj(args...; kw...) = DiagramObj(; kw...)

function _register!(d::DiagramObj, pts...)
    for p in pts
        if p isa Real
            push!(d._points, (Float64(p), 0.0))  # scalar → (x, 0)
        elseif p isa AbstractString
            continue  # skip string args (e.g. from swapped text! calls)
        else
            try
                push!(d._points, (Float64(p[1]), Float64(p[2])))
            catch
                continue  # skip unparseable points
            end
        end
    end
end

function _bounds(d::DiagramObj)
    xs = [p[1] for p in d._points]
    ys = [p[2] for p in d._points]
    return minimum(xs), maximum(xs), minimum(ys), maximum(ys)
end

# Helper: normalize common keyword aliases used by LLM-generated scripts
function _norm_kw(kw)
    d = Dict{Symbol,Any}(kw)
    haskey(d, :stroke) && !haskey(d, :color) && (d[:color] = pop!(d, :stroke))
    haskey(d, :fill_color) && !haskey(d, :fill) && (d[:fill] = pop!(d, :fill_color))
    haskey(d, :size) && !haskey(d, :font_size) && (d[:font_size] = pop!(d, :size))
    d
end

# -- public API --------------------------------------------------------------

function line!(d::DiagramObj, p1::Tuple, p2::Tuple; dashed::Bool=false,
               stroke_width=2, color="currentColor", opacity=nothing, kw...)
    nk = _norm_kw(kw)
    color = get(nk, :color, color)
    _register!(d, p1, p2)
    push!(d._elements, (:line, p1, p2, dashed, Dict(:stroke_width=>stroke_width, :color=>color, :opacity=>opacity)))
end

# Overload: 4 scalar coords → tuple form
function line!(d::DiagramObj, x1::Real, y1::Real, x2::Real, y2::Real; kw...)
    nk = _norm_kw(kw)
    line!(d, (x1, y1), (x2, y2);
          dashed=get(nk, :dashed, false),
          stroke_width=get(nk, :stroke_width, 2),
          color=get(nk, :color, "currentColor"),
          opacity=get(nk, :opacity, nothing))
end

# Overload: 4 scalars + extra positional args (color symbol, stroke_width, etc.)
function line!(d::DiagramObj, x1::Real, y1::Real, x2::Real, y2::Real, extra, extras...; kw...)
    nk = _norm_kw(kw)
    for a in (extra, extras...)
        a isa Symbol && !haskey(nk, :color) && (nk[:color] = string(a))
        a isa Real && !haskey(nk, :stroke_width) && (nk[:stroke_width] = a)
    end
    line!(d, (x1, y1), (x2, y2);
          dashed=get(nk, :dashed, false),
          stroke_width=get(nk, :stroke_width, 2),
          color=get(nk, :color, "currentColor"),
          opacity=get(nk, :opacity, nothing))
end

# Overload: tuples + extra positional args
function line!(d::DiagramObj, p1::Tuple, p2::Tuple, extra, extras...; kw...)
    nk = _norm_kw(kw)
    for a in (extra, extras...)
        a isa Symbol && !haskey(nk, :color) && (nk[:color] = string(a))
        a isa Real && !haskey(nk, :stroke_width) && (nk[:stroke_width] = a)
    end
    line!(d, p1, p2;
          dashed=get(nk, :dashed, false),
          stroke_width=get(nk, :stroke_width, 2),
          color=get(nk, :color, "currentColor"),
          opacity=get(nk, :opacity, nothing))
end

# Overload: Vector points [x,y] → tuple form
function line!(d::DiagramObj, p1::AbstractVector, p2::AbstractVector; kw...)
    line!(d, Tuple(p1), Tuple(p2); kw...)
end

function arrow!(d::DiagramObj, p1, p2; dashed::Bool=false,
                stroke_width=2, color="currentColor", opacity=nothing, kw...)
    nk = _norm_kw(kw)
    color = get(nk, :color, color)
    _register!(d, p1, p2)
    push!(d._markers, :arrow_head)
    push!(d._elements, (:arrow, p1, p2, dashed, Dict(:stroke_width=>stroke_width, :color=>color, :opacity=>opacity)))
end

function polygon!(d::DiagramObj, points; labels=nothing, fill=nothing,
                  stroke_width=2, color="currentColor", opacity=nothing, font_size=14, kw...)
    nk = _norm_kw(kw)
    color = get(nk, :color, color)
    fill = get(nk, :fill, fill)
    font_size = get(nk, :font_size, font_size)
    # If points is a flat vector of numbers, pair them as (x,y) tuples
    pts = if !isempty(points) && first(points) isa Real
        [(points[i], points[i+1]) for i in 1:2:length(points)-1]
    else
        collect(points)
    end
    for p in pts
        _register!(d, p)
    end
    push!(d._elements, (:polygon, pts, labels, fill, Dict(:stroke_width=>stroke_width, :color=>color, :opacity=>opacity, :font_size=>font_size)))
end

# Overload: separate x/y coordinate vectors (Vector{Any} from computed expressions)
function polygon!(d::DiagramObj, v1::AbstractVector{Any}, v2::AbstractVector{Any}, rest...; kw...)
    polygon!(d, Real.(v1), Real.(v2), rest...; kw...)
end

# Overload: separate x/y coordinate vectors or individual [x,y] point vectors
function polygon!(d::DiagramObj, v1::AbstractVector{<:Real}, v2::AbstractVector{<:Real}, rest...; kw...)
    nk = _norm_kw(kw)
    if length(v1) == 2 && length(v2) == 2
        # Individual 2D point vectors: polygon!(d, [x1,y1], [x2,y2], ...)
        pts = Tuple{Real,Real}[Tuple(v1), Tuple(v2)]
        for a in rest
            a isa AbstractVector && length(a) == 2 && push!(pts, Tuple(a))
        end
    else
        # Separate x/y arrays: polygon!(d, xs, ys)
        pts = collect(zip(v1, v2))
    end
    polygon!(d, pts; labels=get(nk, :labels, nothing), fill=get(nk, :fill, nothing),
             stroke_width=get(nk, :stroke_width, 2), color=get(nk, :color, "currentColor"),
             opacity=get(nk, :opacity, nothing), font_size=get(nk, :font_size, 14))
end

# Overload: positional labels/fill after points vector
function polygon!(d::DiagramObj, points::AbstractVector{<:Tuple}, labels, fill, args...; kw...)
    nk = _norm_kw(kw)
    _labels = labels === :nothing || labels === nothing ? nothing : labels
    _fill = fill === :nothing || fill === nothing ? nothing : (fill isa Symbol ? string(fill) : fill)
    polygon!(d, points; labels=_labels, fill=_fill,
             stroke_width=get(nk, :stroke_width, 2), color=get(nk, :color, "currentColor"),
             opacity=get(nk, :opacity, nothing), font_size=get(nk, :font_size, 14))
end

function circle!(d::DiagramObj, center, radius; fill=nothing,
                 stroke_width=2, color="currentColor", opacity=nothing)
    _register!(d, center,
               (center[1] - radius, center[2]),
               (center[1] + radius, center[2]),
               (center[1], center[2] - radius),
               (center[1], center[2] + radius))
    push!(d._elements, (:circle, center, radius, fill, Dict(:stroke_width=>stroke_width, :color=>color, :opacity=>opacity)))
end

# Overload: separate cx, cy, r scalars → tuple center
function circle!(d::DiagramObj, cx::Real, cy::Real, r::Real, args...; kw...)
    nk = _norm_kw(kw)
    circle!(d, (cx, cy), r;
            fill=get(nk, :fill, nothing),
            stroke_width=get(nk, :stroke_width, 2),
            color=get(nk, :color, "currentColor"),
            opacity=get(nk, :opacity, nothing))
end

function arc!(d::DiagramObj, center, radius, start_deg, end_deg;
              stroke_width=2, color="currentColor", opacity=nothing)
    s = deg2rad(start_deg)
    e = deg2rad(end_deg)
    _register!(d, center,
               (center[1] + radius * cos(s), center[2] + radius * sin(s)),
               (center[1] + radius * cos(e), center[2] + radius * sin(e)))
    push!(d._elements, (:arc, center, radius, start_deg, end_deg, Dict(:stroke_width=>stroke_width, :color=>color, :opacity=>opacity)))
end

# Overload: separate cx, cy scalars → tuple center
function arc!(d::DiagramObj, cx::Real, cy::Real, r, s, e; kw...)
    nk = _norm_kw(kw)
    arc!(d, (cx, cy), r, s, e;
         stroke_width=get(nk, :stroke_width, 2),
         color=get(nk, :color, "currentColor"),
         opacity=get(nk, :opacity, nothing))
end

# Overload: 6+ scalar args (extra args after cx,cy,r,s,e are ignored)
function arc!(d::DiagramObj, cx::Real, cy::Real, r::Real, s::Real, e::Real, extra, extras...; kw...)
    nk = _norm_kw(kw)
    for a in (extra, extras...)
        a isa Symbol && !haskey(nk, :color) && (nk[:color] = string(a))
    end
    arc!(d, (cx, cy), r, s, e;
         stroke_width=get(nk, :stroke_width, 2),
         color=get(nk, :color, "currentColor"),
         opacity=get(nk, :opacity, nothing))
end

function point!(d::DiagramObj, x, y; label=nothing,
                color="currentColor", font_size=13, kw...)
    nk = _norm_kw(kw)
    color = get(nk, :color, color)
    font_size = get(nk, :font_size, font_size)
    _register!(d, (x, y))
    push!(d._elements, (:point, (x, y), label, Dict(:color=>color, :font_size=>font_size)))
end

# Overload: positional label string
function point!(d::DiagramObj, x, y, label::AbstractString, args...; kw...)
    nk = _norm_kw(kw)
    point!(d, x, y;
           label=label,
           color=get(nk, :color, "currentColor"),
           font_size=get(nk, :font_size, 13))
end

# Overload: positional Symbol (placement/style) + optional more args — extract label from later args
function point!(d::DiagramObj, x::Real, y::Real, s::Symbol, args...; kw...)
    nk = _norm_kw(kw)
    # Look for a string label in remaining args
    label = nothing
    for a in args
        a isa AbstractString && (label = a; break)
    end
    point!(d, x, y;
           label=label,
           color=get(nk, :color, "currentColor"),
           font_size=get(nk, :font_size, 13))
end

# Overload: single Vector [x,y] instead of separate x,y
function point!(d::DiagramObj, v::AbstractVector; kw...)
    point!(d, v[1], v[2]; kw...)
end

# Overload: single Tuple (x,y) + optional positional label/placement
function point!(d::DiagramObj, pos::Tuple, label::AbstractString, args...; kw...)
    point!(d, pos[1], pos[2], label; kw...)
end
function point!(d::DiagramObj, pos::Tuple; kw...)
    point!(d, pos[1], pos[2]; kw...)
end

function angle_arc!(d::DiagramObj, vertex, p1, p2; label=nothing,
                    color="currentColor", font_size=12, kw...)
    nk = _norm_kw(kw)
    color = get(nk, :color, color)
    font_size = get(nk, :font_size, font_size)
    _register!(d, vertex, p1, p2)
    push!(d._elements, (:angle_arc, vertex, p1, p2, label, Dict(:color=>color, :font_size=>font_size)))
end

# Overload: 6 scalar coords → 3 tuples
function angle_arc!(d::DiagramObj, vx::Real, vy::Real, p1x::Real, p1y::Real, p2x::Real, p2y::Real; kw...)
    nk = _norm_kw(kw)
    angle_arc!(d, (vx, vy), (p1x, p1y), (p2x, p2y);
               label=get(nk, :label, nothing),
               color=get(nk, :color, "currentColor"),
               font_size=get(nk, :font_size, 12))
end

# Overload: 7 scalars (6 coords + extra ignored arg like size)
function angle_arc!(d::DiagramObj, vx::Real, vy::Real, p1x::Real, p1y::Real, p2x::Real, p2y::Real, extra, extras...; kw...)
    angle_arc!(d, vx, vy, p1x, p1y, p2x, p2y; kw...)
end

# Overload: 5 scalars — (vx, vy, angle1_deg, angle2_deg, radius) arc-style
function angle_arc!(d::DiagramObj, vx::Real, vy::Real, a1::Real, a2::Real, r::Real; kw...)
    nk = _norm_kw(kw)
    p1 = (vx + r * cos(deg2rad(a1)), vy + r * sin(deg2rad(a1)))
    p2 = (vx + r * cos(deg2rad(a2)), vy + r * sin(deg2rad(a2)))
    angle_arc!(d, (vx, vy), p1, p2;
               label=get(nk, :label, nothing),
               color=get(nk, :color, "currentColor"),
               font_size=get(nk, :font_size, 12))
end

# Overload: 5 reals + non-Real (Symbol/String for color, etc.)
function angle_arc!(d::DiagramObj, vx::Real, vy::Real, a1::Real, a2::Real, a3::Real, s::Union{Symbol,AbstractString}, extras...; kw...)
    nk = _norm_kw(kw)
    nk[:color] = string(s)
    angle_arc!(d, vx, vy, a1, a2, a3;
               label=get(nk, :label, nothing),
               color=get(nk, :color, "currentColor"),
               font_size=get(nk, :font_size, 12))
end

# Overload: mixed args — (vx, vy, p1::Tuple, p2::Tuple, extra...)
function angle_arc!(d::DiagramObj, vx::Real, vy::Real, p1::Tuple, p2::Tuple, extras...; kw...)
    nk = _norm_kw(kw)
    angle_arc!(d, (vx, vy), p1, p2;
               label=get(nk, :label, nothing),
               color=get(nk, :color, "currentColor"),
               font_size=get(nk, :font_size, 12))
end

function right_angle!(d::DiagramObj, vertex, p1, p2; kw...)
    _register!(d, vertex, p1, p2)
    push!(d._elements, (:right_angle, vertex, p1, p2))
end

# Overload: 6 scalar coords → 3 tuples
function right_angle!(d::DiagramObj, vx::Real, vy::Real, p1x::Real, p1y::Real, p2x::Real, p2y::Real; kw...)
    right_angle!(d, (vx, vy), (p1x, p1y), (p2x, p2y))
end

# Overload: 7+ scalars (6 coords + extra ignored args)
function right_angle!(d::DiagramObj, vx::Real, vy::Real, p1x::Real, p1y::Real, p2x::Real, p2y::Real, extra, extras...; kw...)
    right_angle!(d, (vx, vy), (p1x, p1y), (p2x, p2y))
end

# Overload: tuples + extra positional (e.g. size int)
function right_angle!(d::DiagramObj, vertex, p1, p2, extra, extras...; kw...)
    right_angle!(d, vertex, p1, p2)
end

# Overload: only 2-3 scalars — not enough info for a right angle, silently skip
function right_angle!(d::DiagramObj, x::Real, y::Real; kw...)
end
function right_angle!(d::DiagramObj, x::Real, y::Real, z::Real; kw...)
end

function segment_label!(d::DiagramObj, p1, p2, text;
                        font_size=13, color="currentColor", kw...)
    nk = _norm_kw(kw)
    color = get(nk, :color, color)
    font_size = get(nk, :font_size, font_size)
    _register!(d, p1, p2)
    push!(d._elements, (:segment_label, p1, p2, text, Dict(:font_size=>font_size, :color=>color)))
end

# Overload: 4 scalar coords + text
function segment_label!(d::DiagramObj, x1::Real, y1::Real, x2::Real, y2::Real, text; kw...)
    segment_label!(d, (x1, y1), (x2, y2), text; kw...)
end

# Overload: 4 scalar coords + text + extra positional (placement Symbol, etc.)
function segment_label!(d::DiagramObj, x1::Real, y1::Real, x2::Real, y2::Real, text, placement, extras...; kw...)
    segment_label!(d, (x1, y1), (x2, y2), text; kw...)
end

# Overload: tuple points + text + extra positional (placement Symbol)
function segment_label!(d::DiagramObj, p1, p2, text, placement, extras...; kw...)
    segment_label!(d, p1, p2, text; kw...)
end

# Overload: Vector points with positional text
function segment_label!(d::DiagramObj, p1::AbstractVector, p2::AbstractVector, text, extras...; kw...)
    segment_label!(d, Tuple(p1), Tuple(p2), text; kw...)
end

# Overload: Vector points with keyword text
function segment_label!(d::DiagramObj, p1::AbstractVector, p2::AbstractVector; text="", kw...)
    segment_label!(d, Tuple(p1), Tuple(p2), text; kw...)
end

# Overload: 2 scalar coords + text (scripts pass center point, not a segment)
function segment_label!(d::DiagramObj, x::Real, y::Real, text::AbstractString, extras...; kw...)
    text!(d, x, y, text; kw...)
end

function tick_marks!(d::DiagramObj, p1, p2; count::Int=1, kw...)
    _register!(d, p1, p2)
    push!(d._elements, (:tick_marks, p1, p2, count))
end

# Overload: tuples + positional count
function tick_marks!(d::DiagramObj, p1::Tuple, p2::Tuple, count::Integer, extras...; kw...)
    tick_marks!(d, p1, p2; count=Int(count))
end

# Overload: 4 scalar coords → tuple form
function tick_marks!(d::DiagramObj, x1::Real, y1::Real, x2::Real, y2::Real; kw...)
    nk = _norm_kw(kw)
    tick_marks!(d, (x1, y1), (x2, y2); count=get(nk, :count, 1))
end

# Overload: 4 scalar coords + positional count
function tick_marks!(d::DiagramObj, x1::Real, y1::Real, x2::Real, y2::Real, count::Integer; kw...)
    tick_marks!(d, (x1, y1), (x2, y2); count=Int(count))
end

function text!(d::DiagramObj, x, y, text;
               font_size=13, color="currentColor", kw...)
    nk = _norm_kw(kw)
    color = get(nk, :color, color)
    font_size = get(nk, :font_size, font_size)
    _register!(d, (x, y))
    push!(d._elements, (:text, (x, y), text, Dict(:font_size=>font_size, :color=>color)))
end

# Overload: positional font_size after text (and possibly more args)
function text!(d::DiagramObj, x, y, text, font_size::Real, extras...; kw...)
    text!(d, x, y, text; font_size=Int(font_size), kw...)
end

# Overload: swapped args — text!(d, "label", x, y, ...) instead of text!(d, x, y, "label", ...)
function text!(d::DiagramObj, text::AbstractString, x::Real, y::Real, args...; kw...)
    text!(d, x, y, text, args...; kw...)
end

# -- convenience primitives --------------------------------------------------

function rect!(d::DiagramObj, x, y, w, h; labels=nothing, fill=nothing,
               stroke_width=2, color="currentColor", opacity=nothing, font_size=14)
    corners = [(x, y), (x + w, y), (x + w, y + h), (x, y + h)]
    polygon!(d, corners; labels=labels, fill=fill, stroke_width=stroke_width,
             color=color, opacity=opacity, font_size=font_size)
end

function ellipse!(d::DiagramObj, center, rx, ry; fill=nothing,
                  stroke_width=2, color="currentColor", opacity=nothing)
    _register!(d, center,
               (center[1] - rx, center[2]),
               (center[1] + rx, center[2]),
               (center[1], center[2] - ry),
               (center[1], center[2] + ry))
    push!(d._elements, (:ellipse, center, rx, ry, fill, Dict(:stroke_width=>stroke_width, :color=>color, :opacity=>opacity)))
end

function midpoint_label!(d::DiagramObj, p1, p2, text;
                         font_size=13, color="currentColor")
    segment_label!(d, p1, p2, text; font_size=font_size, color=color)
end

function distance_marker!(d::DiagramObj, p1, p2; label="", offset=14)
    _register!(d, p1, p2)
    push!(d._elements, (:distance_marker, p1, p2, label, offset))
end

function parallel_marks!(d::DiagramObj, p1, p2; count::Int=1)
    _register!(d, p1, p2)
    push!(d._elements, (:parallel_marks, p1, p2, count))
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
    ct = _CoordTransform(Float64(d._padding), Float64(d._width), Float64(d._height),
                         x_min, x_min + dx, y_min, y_min + dy)
    inner_w = d._width - 2 * d._padding
    inner_h = d._height - 2 * d._padding
    scale = min(inner_w / dx, inner_h / dy)

    tx(px, py) = _apply(ct, px, py)

    parts = String[]
    placed_labels = _BBox[]

    # Emit marker defs if needed
    markers_str = _emit_markers(d._markers)
    if !isempty(markers_str)
        push!(parts, markers_str)
    end

    for el in d._elements
        kind = el[1]

        if kind === :line
            _, p1, p2, dashed, sty = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
            opa = sty[:opacity] !== nothing ? """ stroke-opacity="$(sty[:opacity])\"""" : ""
            push!(parts, """<line x1="$(x1)" y1="$(y1)" x2="$(x2)" y2="$(y2)" stroke="$(sty[:color])" stroke-width="$(sty[:stroke_width])"$(dash)$(opa)/>""")

        elseif kind === :arrow
            _, p1, p2, dashed, sty = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            dash = dashed ? """ stroke-dasharray="6,4\"""" : ""
            opa = sty[:opacity] !== nothing ? """ stroke-opacity="$(sty[:opacity])\"""" : ""
            push!(parts, """<line x1="$(x1)" y1="$(y1)" x2="$(x2)" y2="$(y2)" stroke="$(sty[:color])" stroke-width="$(sty[:stroke_width])"$(dash)$(opa) marker-end="url(#ah)"/>""")

        elseif kind === :polygon
            _, points, labels, fill, sty = el
            coords = [tx(p[1], p[2]) for p in points]
            pts_str = join(["$(c[1]),$(c[2])" for c in coords], " ")
            fill_attr = fill !== nothing ? """fill="$(fill)" fill-opacity="0.15\"""" : """fill="none\""""
            opa = sty[:opacity] !== nothing ? """ stroke-opacity="$(sty[:opacity])\"""" : ""
            push!(parts, """<polygon points="$(pts_str)" stroke="$(sty[:color])" stroke-width="$(sty[:stroke_width])" $(fill_attr)$(opa)/>""")
            if labels !== nothing && !(labels isa Symbol) && !(labels isa AbstractString)
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
                    lx, ly = _nudge_label(px, py, ox, oy + 5, placed_labels; text_len=length(lbl))
                    push!(parts, """<text x="$(lx)" y="$(ly)" font-size="$(sty[:font_size])" fill="$(sty[:color])" font-style="italic" text-anchor="middle">$(lbl)</text>""")
                end
            end

        elseif kind === :circle
            _, center, radius, fill, sty = el
            ccx, ccy = tx(center[1], center[2])
            r = round(radius * scale; digits=1)
            fill_attr = fill !== nothing ? """fill="$(fill)" fill-opacity="0.15\"""" : """fill="none\""""
            opa = sty[:opacity] !== nothing ? """ stroke-opacity="$(sty[:opacity])\"""" : ""
            push!(parts, """<circle cx="$(ccx)" cy="$(ccy)" r="$(r)" stroke="$(sty[:color])" stroke-width="$(sty[:stroke_width])" $(fill_attr)$(opa)/>""")

        elseif kind === :ellipse
            _, center, rx, ry, fill, sty = el
            ccx, ccy = tx(center[1], center[2])
            srx = round(rx * scale; digits=1)
            sry = round(ry * scale; digits=1)
            fill_attr = fill !== nothing ? """fill="$(fill)" fill-opacity="0.15\"""" : """fill="none\""""
            opa = sty[:opacity] !== nothing ? """ stroke-opacity="$(sty[:opacity])\"""" : ""
            push!(parts, """<ellipse cx="$(ccx)" cy="$(ccy)" rx="$(srx)" ry="$(sry)" stroke="$(sty[:color])" stroke-width="$(sty[:stroke_width])" $(fill_attr)$(opa)/>""")

        elseif kind === :arc
            _, center, radius, start_deg, end_deg, sty = el
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
            opa = sty[:opacity] !== nothing ? """ stroke-opacity="$(sty[:opacity])\"""" : ""
            push!(parts, """<path d="M$(ax1),$(ay1) A$(round(r; digits=1)),$(round(r; digits=1)) 0 $(large) 0 $(ax2),$(ay2)" stroke="$(sty[:color])" stroke-width="$(sty[:stroke_width])" fill="none"$(opa)/>""")

        elseif kind === :point
            _, pos, label, sty = el
            px, py = tx(pos[1], pos[2])
            push!(parts, """<circle cx="$(px)" cy="$(py)" r="3" fill="$(sty[:color])"/>""")
            if label !== nothing
                lx, ly = _nudge_label(px, py, 6.0, -6.0, placed_labels; text_len=length(label))
                push!(parts, """<text x="$(lx)" y="$(ly)" font-size="$(sty[:font_size])" fill="$(sty[:color])">$(label)</text>""")
            end

        elseif kind === :angle_arc
            _, vertex, p1, p2, label, sty = el
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
            push!(parts, """<path d="M$(ax1),$(ay1) A$(r),$(r) 0 0 $(sweep) $(ax2),$(ay2)" stroke="$(sty[:color])" stroke-width="1.5" fill="none"/>""")
            if label !== nothing
                lx, ly = _nudge_label(vx, vy, (r + 14) * cos(mid_a), (r + 14) * sin(mid_a), placed_labels; text_len=length(label))
                push!(parts, """<text x="$(lx)" y="$(ly)" font-size="$(sty[:font_size])" fill="$(sty[:color])" text-anchor="middle" dominant-baseline="central">$(label)</text>""")
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
            _, p1, p2, txt, sty = el
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
            lx, ly = _nudge_label(mx, my, nx, ny, placed_labels; text_len=length(txt))
            push!(parts, """<text x="$(lx)" y="$(ly)" font-size="$(sty[:font_size])" fill="$(sty[:color])" text-anchor="middle" dominant-baseline="central">$(txt)</text>""")

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

        elseif kind === :distance_marker
            _, p1, p2, label_txt, off = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            ds_x = x2 - x1
            ds_y = y2 - y1
            len = hypot(ds_x, ds_y)
            len == 0 && (len = 1)
            nx = -ds_y / len * off
            ny = ds_x / len * off
            ox1, oy1 = x1 + nx, y1 + ny
            ox2, oy2 = x2 + nx, y2 + ny
            push!(parts, """<line x1="$(round(ox1; digits=1))" y1="$(round(oy1; digits=1))" x2="$(round(ox2; digits=1))" y2="$(round(oy2; digits=1))" stroke="currentColor" stroke-width="1"/>""")
            tnx = -ds_y / len * 4
            tny = ds_x / len * 4
            for (ex, ey) in [(ox1, oy1), (ox2, oy2)]
                push!(parts, """<line x1="$(round(ex - tnx; digits=1))" y1="$(round(ey - tny; digits=1))" x2="$(round(ex + tnx; digits=1))" y2="$(round(ey + tny; digits=1))" stroke="currentColor" stroke-width="1"/>""")
            end
            if !isempty(label_txt)
                mx = (ox1 + ox2) / 2
                my = (oy1 + oy2) / 2
                lx, ly = _nudge_label(mx, my, 0.0, -8.0, placed_labels; text_len=length(label_txt))
                push!(parts, """<text x="$(lx)" y="$(ly)" font-size="12" fill="currentColor" text-anchor="middle">$(label_txt)</text>""")
            end

        elseif kind === :parallel_marks
            _, p1, p2, count = el
            x1, y1 = tx(p1[1], p1[2])
            x2, y2 = tx(p2[1], p2[2])
            mx = (x1 + x2) / 2
            my = (y1 + y2) / 2
            ds_x = x2 - x1
            ds_y = y2 - y1
            len = hypot(ds_x, ds_y)
            len == 0 && (len = 1)
            ux = ds_x / len
            uy = ds_y / len
            spacing = 4
            chevron_size = 5
            for i in 1:count
                offset = (i - 1 - (count - 1) / 2) * spacing
                cx_pt = mx + offset * ux
                cy_pt = my + offset * uy
                tip_x = cx_pt + ux * chevron_size
                tip_y = cy_pt + uy * chevron_size
                nx = -uy * chevron_size
                ny = ux * chevron_size
                wing1_x = cx_pt - ux * chevron_size * 0.3 + nx * 0.5
                wing1_y = cy_pt - uy * chevron_size * 0.3 + ny * 0.5
                wing2_x = cx_pt - ux * chevron_size * 0.3 - nx * 0.5
                wing2_y = cy_pt - uy * chevron_size * 0.3 - ny * 0.5
                push!(parts, """<path d="M$(round(wing1_x; digits=1)),$(round(wing1_y; digits=1)) L$(round(tip_x; digits=1)),$(round(tip_y; digits=1)) L$(round(wing2_x; digits=1)),$(round(wing2_y; digits=1))" stroke="currentColor" stroke-width="1.5" fill="none"/>""")
            end

        elseif kind === :text
            _, pos, txt, sty = el
            px, py = tx(pos[1], pos[2])
            lx, ly = _nudge_label(px, py, 0.0, 0.0, placed_labels; text_len=length(txt))
            push!(parts, """<text x="$(lx)" y="$(ly)" font-size="$(sty[:font_size])" fill="$(sty[:color])">$(txt)</text>""")
        end
    end

    vb = "0 0 $(d._width) $(d._height)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(d._width)px" fill="currentColor">$(body)</svg>"""
end
