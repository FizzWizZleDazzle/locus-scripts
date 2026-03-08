#= ProjectilePath — parabolic trajectory diagram for physics =#

"""
Projectile motion trajectory with labeled range, max height, and launch angle.

    pp = ProjectilePath(20.0, 45)
    add_label!(pp, :range)
    add_label!(pp, :max_height)
    add_label!(pp, :angle)
    svg = render(pp)
"""
mutable struct ProjectilePath
    _v0::Float64
    _angle_deg::Float64
    _width::Int
    _height::Int
    _padding::Int
    _labels::Set{Symbol}
    _g::Float64

    function ProjectilePath(v0, angle_deg; width::Int=320, height::Int=200, padding::Int=35, g::Float64=9.80)
        new(Float64(v0), Float64(angle_deg), width, height, padding, Set{Symbol}(), g)
    end
end

"""Add a label: :range, :max_height, :angle, :v0."""
function add_label!(pp::ProjectilePath, sym::Symbol)
    sym in (:range, :max_height, :angle, :v0) || error("Unknown label: $sym")
    push!(pp._labels, sym)
end

function render(pp::ProjectilePath)
    parts = String[]
    pad = pp._padding
    w, h = pp._width, pp._height
    inner_w = w - 2 * pad
    inner_h = h - 2 * pad

    θ = pp._angle_deg * π / 180
    vx = pp._v0 * cos(θ)
    vy0 = pp._v0 * sin(θ)
    t_flight = 2 * vy0 / pp._g
    R = vx * t_flight
    H = vy0^2 / (2 * pp._g)

    # Coordinate transform: x in [0, R], y in [0, H*1.2]
    x_max = R
    y_max = H * 1.25
    x_max == 0 && (x_max = 1)
    y_max == 0 && (y_max = 1)

    to_sx(x) = round(pad + x / x_max * inner_w; digits=1)
    to_sy(y) = round(pad + (y_max - y) / y_max * inner_h; digits=1)

    # Ground line
    gy = to_sy(0)
    push!(parts, """<line x1="$(pad)" y1="$(gy)" x2="$(pad + inner_w)" y2="$(gy)" stroke="currentColor" stroke-width="1"/>""")

    # Trajectory curve (sample points)
    n_pts = 50
    path_pts = String[]
    for i in 0:n_pts
        ti = t_flight * i / n_pts
        px = vx * ti
        py = vy0 * ti - 0.5 * pp._g * ti^2
        push!(path_pts, "$(to_sx(px)),$(to_sy(py))")
    end
    push!(parts, """<polyline points="$(join(path_pts, " "))" fill="none" stroke="#3b82f6" stroke-width="2"/>""")

    # Origin dot
    push!(parts, """<circle cx="$(to_sx(0))" cy="$(gy)" r="3" fill="currentColor"/>""")

    # Landing dot
    push!(parts, """<circle cx="$(to_sx(R))" cy="$(gy)" r="3" fill="currentColor"/>""")

    # Labels
    if :range in pp._labels
        # Range arrow below ground
        rx1 = to_sx(0)
        rx2 = to_sx(R)
        ry = round(gy + 16; digits=1)
        push!(parts, """<line x1="$(rx1)" y1="$(ry)" x2="$(rx2)" y2="$(ry)" stroke="currentColor" stroke-width="1" marker-start="url(#nlb)" marker-end="url(#ax)"/>""")
        push!(parts, """<text x="$(to_sx(R / 2))" y="$(round(gy + 30; digits=1))" font-size="11" fill="currentColor" text-anchor="middle">R = $(round(R; digits=1)) m</text>""")
    end

    if :max_height in pp._labels
        # Dashed vertical at peak
        peak_x = to_sx(R / 2)
        peak_y = to_sy(H)
        push!(parts, """<line x1="$(peak_x)" y1="$(peak_y)" x2="$(peak_x)" y2="$(gy)" stroke="currentColor" stroke-width="1" stroke-dasharray="4,3"/>""")
        push!(parts, """<text x="$(round(peak_x + 8; digits=1))" y="$(to_sy(H / 2))" font-size="11" fill="currentColor">H = $(round(H; digits=1)) m</text>""")
        push!(parts, """<circle cx="$(peak_x)" cy="$(peak_y)" r="3" fill="#ef4444"/>""")
    end

    if :angle in pp._labels
        # Angle arc at origin
        arc_r = 30
        ax = to_sx(0)
        ay = gy
        # Arc from horizontal to launch angle
        end_x = round(ax + arc_r; digits=1)
        end_y = ay
        arc_x = round(ax + arc_r * cos(θ); digits=1)
        arc_y = round(ay - arc_r * sin(θ); digits=1)
        push!(parts, """<path d="M$(end_x),$(end_y) A$(arc_r),$(arc_r) 0 0 0 $(arc_x),$(arc_y)" fill="none" stroke="currentColor" stroke-width="1"/>""")
        label_a = round(ax + (arc_r + 12) * cos(θ / 2); digits=1)
        label_b = round(ay - (arc_r + 12) * sin(θ / 2); digits=1)
        push!(parts, """<text x="$(label_a)" y="$(label_b)" font-size="11" fill="currentColor">$(round(Int, pp._angle_deg))°</text>""")
    end

    if :v0 in pp._labels
        # Initial velocity arrow
        v_len = 40
        vx2 = round(to_sx(0) + v_len * cos(θ); digits=1)
        vy2 = round(gy - v_len * sin(θ); digits=1)
        push!(parts, """<defs><marker id="pp-ah" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto"><polygon points="0 0,10 3.5,0 7" fill="currentColor"/></marker></defs>""")
        push!(parts, """<line x1="$(to_sx(0))" y1="$(gy)" x2="$(vx2)" y2="$(vy2)" stroke="currentColor" stroke-width="2" marker-end="url(#pp-ah)"/>""")
        push!(parts, """<text x="$(round(vx2 + 4; digits=1))" y="$(round(vy2 - 4; digits=1))" font-size="11" fill="currentColor">v₀</text>""")
    end

    # Axis markers
    markers = _emit_markers(Set([:axis_fwd, :axis_bwd]))
    vb = "0 0 $(w) $(h)"
    body = markers * join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
