#= unit_circle() factory function =#

const _TRIG_VALUES = Dict{Int,Tuple{String,String}}(
    0   => ("1", "0"),
    30  => ("\\frac{\\sqrt{3}}{2}", "\\frac{1}{2}"),
    45  => ("\\frac{\\sqrt{2}}{2}", "\\frac{\\sqrt{2}}{2}"),
    60  => ("\\frac{1}{2}", "\\frac{\\sqrt{3}}{2}"),
    90  => ("0", "1"),
    120 => ("-\\frac{1}{2}", "\\frac{\\sqrt{3}}{2}"),
    135 => ("-\\frac{\\sqrt{2}}{2}", "\\frac{\\sqrt{2}}{2}"),
    150 => ("-\\frac{\\sqrt{3}}{2}", "\\frac{1}{2}"),
    180 => ("-1", "0"),
    210 => ("-\\frac{\\sqrt{3}}{2}", "-\\frac{1}{2}"),
    225 => ("-\\frac{\\sqrt{2}}{2}", "-\\frac{\\sqrt{2}}{2}"),
    240 => ("-\\frac{1}{2}", "-\\frac{\\sqrt{3}}{2}"),
    270 => ("0", "-1"),
    300 => ("\\frac{1}{2}", "-\\frac{\\sqrt{3}}{2}"),
    315 => ("\\frac{\\sqrt{2}}{2}", "-\\frac{\\sqrt{2}}{2}"),
    330 => ("\\frac{\\sqrt{3}}{2}", "-\\frac{1}{2}"),
    360 => ("1", "0"),
)

"""
Render a unit circle SVG with labeled angles and trig coordinates.

    svg = unit_circle(; angles=[0, 30, 45, 60, 90], show_coordinates=true, highlight=45)
"""
function unit_circle(; angles::Vector{Int}=[0, 30, 45, 60, 90],
                       show_coordinates::Bool=true,
                       highlight::Union{Nothing,Int}=nothing,
                       width::Int=300, height::Int=300)
    d = DiagramObj(; width=width, height=height, padding=50)

    circle!(d, (0, 0), 1)
    line!(d, (-1.2, 0), (1.2, 0))
    line!(d, (0, -1.2), (0, 1.2))

    for ang in angles
        rad = deg2rad(ang)
        px = cos(rad)
        py = sin(rad)

        if highlight !== nothing && ang == highlight
            line!(d, (0, 0), (px, py); stroke_width=2, color="#ef4444")
            point!(d, px, py; color="#ef4444")
        else
            line!(d, (0, 0), (px, py); stroke_width=1, color="currentColor", opacity=0.5)
            point!(d, px, py)
        end

        label_r = 0.35
        lx = label_r * cos(rad / 2 + (ang > 0 ? deg2rad(angles[1]) : 0))
        ly = label_r * sin(rad / 2 + (ang > 0 ? deg2rad(angles[1]) : 0))
        text!(d, lx, ly, "$(ang)°"; font_size=10)

        if show_coordinates && haskey(_TRIG_VALUES, ang)
            cos_s, sin_s = _TRIG_VALUES[ang]
            coord_label = "($(cos_s), $(sin_s))"
            lbl_dist = 1.15
            text!(d, px * lbl_dist, py * lbl_dist, coord_label; font_size=9)
        end
    end

    return render(d)
end
