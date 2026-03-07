#= NumberLine — number lines with points and shading =#

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
    ct = _CoordTransform(Float64(pad), Float64(nl._width), Float64(nl._height),
                         nl._x_min, nl._x_max, 0.0, 1.0)
    inner_w = nl._width - 2 * pad
    cy = nl._height / 2.0
    left_x = pad
    right_x = pad + inner_w
    tick_h = 6.0

    tx_nl(x) = _apply_x(ct, x)

    markers = Set{Symbol}([:axis_fwd, :axis_bwd])
    push!(parts, _emit_markers(markers))

    # Shaded regions (render first, behind everything)
    for el in nl._elements
        kind = el[1]
        if kind === :shade
            _, xl, xr = el
            sx1 = tx_nl(xl)
            sx2 = tx_nl(xr)
            push!(parts, """<rect x="$(sx1)" y="$(round(cy - 8; digits=1))" width="$(round(sx2 - sx1; digits=1))" height="16" fill="#3b82f6" fill-opacity="0.2"/>""")
        elseif kind === :shade_left
            _, xv = el
            sx = tx_nl(xv)
            push!(parts, """<rect x="$(left_x)" y="$(round(cy - 8; digits=1))" width="$(round(sx - left_x; digits=1))" height="16" fill="#3b82f6" fill-opacity="0.2"/>""")
        elseif kind === :shade_right
            _, xv = el
            sx = tx_nl(xv)
            push!(parts, """<rect x="$(sx)" y="$(round(cy - 8; digits=1))" width="$(round(right_x - sx; digits=1))" height="16" fill="#3b82f6" fill-opacity="0.2"/>""")
        end
    end

    push!(parts, """<line x1="$(left_x)" y1="$(cy)" x2="$(right_x)" y2="$(cy)" stroke="currentColor" stroke-width="1.5" marker-start="url(#nlb)" marker-end="url(#ax)"/>""")

    for xi in Int(ceil(nl._x_min)):Int(floor(nl._x_max))
        gx = tx_nl(xi)
        push!(parts, """<line x1="$(gx)" y1="$(round(cy - tick_h; digits=1))" x2="$(gx)" y2="$(round(cy + tick_h; digits=1))" stroke="currentColor" stroke-width="1"/>""")
        push!(parts, """<text x="$(gx)" y="$(round(cy + tick_h + 14; digits=1))" font-size="11" fill="currentColor" text-anchor="middle">$(xi)</text>""")
    end

    for el in nl._elements
        kind = el[1]
        if kind === :closed_point
            _, xv = el
            sx = tx_nl(xv)
            push!(parts, """<circle cx="$(sx)" cy="$(cy)" r="4" fill="currentColor"/>""")
        elseif kind === :open_point
            _, xv = el
            sx = tx_nl(xv)
            push!(parts, """<circle cx="$(sx)" cy="$(cy)" r="4" fill="var(--bg,#1a1a2e)" stroke="currentColor" stroke-width="2"/>""")
        end
    end

    vb = "0 0 $(nl._width) $(nl._height)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(nl._width)px">$(body)</svg>"""
end
