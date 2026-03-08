#= FreeBodyDiagram — force diagrams for physics =#

"""
Free-body diagram with labeled force arrows on a central object.

    fbd = FreeBodyDiagram(; width=250, height=250)
    set_object!(fbd, :box)
    add_force!(fbd, 50, 90; label="N")
    add_force!(fbd, 50, 270; label="mg")
    add_force!(fbd, 20, 0; label="F")
    svg = render(fbd)
"""
mutable struct FreeBodyDiagram
    _width::Int
    _height::Int
    _forces::Vector{Tuple{Float64,Float64,String}}  # (magnitude, angle_deg, label)
    _object::Symbol  # :box or :circle
    _surface::Union{Nothing,Float64}  # incline angle in degrees, nothing = no surface

    function FreeBodyDiagram(; width::Int=250, height::Int=250)
        new(width, height, Tuple{Float64,Float64,String}[], :box, nothing)
    end
end

"""Add a force arrow. angle is in degrees (0=right, 90=up, 180=left, 270=down)."""
function add_force!(fbd::FreeBodyDiagram, magnitude, angle_deg; label::String="")
    push!(fbd._forces, (Float64(magnitude), Float64(angle_deg), label))
end

"""Set object shape: :box or :circle."""
function set_object!(fbd::FreeBodyDiagram, shape::Symbol)
    shape in (:box, :circle) || error("shape must be :box or :circle")
    fbd._object = shape
end

"""Add a surface (optional incline). incline_deg=0 for flat ground."""
function add_surface!(fbd::FreeBodyDiagram; incline_deg::Real=0)
    fbd._surface = Float64(incline_deg)
end

function render(fbd::FreeBodyDiagram)
    parts = String[]
    w, h = fbd._width, fbd._height
    cx, cy = w / 2.0, h / 2.0
    obj_size = 24.0
    obj_rotation = 0.0  # degrees, for box on incline

    # Arrow marker
    push!(parts, """<defs><marker id="fbd-ah" markerWidth="10" markerHeight="7" refX="10" refY="3.5" orient="auto"><polygon points="0 0,10 3.5,0 7" fill="currentColor"/></marker></defs>""")

    # Surface (if any)
    if fbd._surface !== nothing
        inc = fbd._surface
        if inc == 0
            # Flat ground below the object
            gy = cy + obj_size + 4
            push!(parts, """<line x1="$(round(cx - 60; digits=1))" y1="$(round(gy; digits=1))" x2="$(round(cx + 60; digits=1))" y2="$(round(gy; digits=1))" stroke="currentColor" stroke-width="1.5"/>""")
            for i in -3:3
                sx = cx + i * 15
                push!(parts, """<line x1="$(round(sx; digits=1))" y1="$(round(gy; digits=1))" x2="$(round(sx - 6; digits=1))" y2="$(round(gy + 8; digits=1))" stroke="currentColor" stroke-width="1" stroke-opacity="0.5"/>""")
            end
        else
            # Inclined surface — ramp triangle with box sitting on it
            θ = inc * π / 180
            obj_size = 20.0  # slightly smaller for ramp layout

            # Ramp triangle geometry
            ramp_left = 20.0
            ramp_bot = h - 20.0
            ramp_right = w - 30.0
            ramp_base = ramp_right - ramp_left
            ramp_h = ramp_base * tan(θ)
            # Clamp for steep angles
            if ramp_h > h * 0.55
                ramp_h = h * 0.55
                ramp_base = ramp_h / tan(θ)
                ramp_right = ramp_left + ramp_base
            end
            ramp_top = ramp_bot - ramp_h

            # Draw triangle (bottom-left, bottom-right, top-right)
            push!(parts, """<path d="M$(round(ramp_left; digits=1)),$(round(ramp_bot; digits=1)) L$(round(ramp_right; digits=1)),$(round(ramp_bot; digits=1)) L$(round(ramp_right; digits=1)),$(round(ramp_top; digits=1)) Z" fill="none" stroke="currentColor" stroke-width="1.5"/>""")
            # Hatch marks on base
            nhatch = Int(floor(ramp_base / 16))
            for i in 0:nhatch
                hx = ramp_left + 6 + i * 16
                hx > ramp_right - 6 && break
                push!(parts, """<line x1="$(round(hx; digits=1))" y1="$(round(ramp_bot; digits=1))" x2="$(round(hx - 5; digits=1))" y2="$(round(ramp_bot + 7; digits=1))" stroke="currentColor" stroke-width="1" stroke-opacity="0.5"/>""")
            end
            # Angle arc at bottom-left
            arc_r = 24.0
            push!(parts, """<path d="M$(round(ramp_left + arc_r; digits=1)),$(round(ramp_bot; digits=1)) A$(arc_r),$(arc_r) 0 0 0 $(round(ramp_left + arc_r * cos(θ); digits=1)),$(round(ramp_bot - arc_r * sin(θ); digits=1))" fill="none" stroke="currentColor" stroke-width="1"/>""")
            push!(parts, """<text x="$(round(ramp_left + arc_r + 12; digits=1))" y="$(round(ramp_bot - 6; digits=1))" font-size="11" fill="currentColor">$(round(Int, inc))°</text>""")

            # Position box on hypotenuse
            hyp_len = sqrt(ramp_base^2 + ramp_h^2)
            # Normal to surface (pointing away from triangle interior)
            nx = -ramp_h / hyp_len
            ny = -ramp_base / hyp_len
            # Point on hypotenuse at t=0.45
            t = 0.45
            hx = ramp_left + t * (ramp_right - ramp_left)
            hy = ramp_bot + t * (ramp_top - ramp_bot)
            # Box center: offset from surface by obj_size along normal
            cx = hx + obj_size * nx
            cy = hy + obj_size * ny
            obj_rotation = -inc  # tilt box to match slope
        end
    end

    # Object
    if fbd._object == :box
        rot_attr = obj_rotation != 0 ? " transform=\"rotate($(round(obj_rotation; digits=1)), $(round(cx; digits=1)), $(round(cy; digits=1)))\"" : ""
        push!(parts, """<rect x="$(round(cx - obj_size; digits=1))" y="$(round(cy - obj_size; digits=1))" width="$(round(2 * obj_size; digits=1))" height="$(round(2 * obj_size; digits=1))" fill="currentColor" fill-opacity="0.1" stroke="currentColor" stroke-width="1.5"$(rot_attr)/>""")
    else
        push!(parts, """<circle cx="$(round(cx; digits=1))" cy="$(round(cy; digits=1))" r="$(round(obj_size; digits=1))" fill="currentColor" fill-opacity="0.1" stroke="currentColor" stroke-width="1.5"/>""")
    end

    # Dot at center
    push!(parts, """<circle cx="$(round(cx; digits=1))" cy="$(round(cy; digits=1))" r="2.5" fill="currentColor"/>""")

    # Force arrows
    placed = _BBox[]
    max_mag = isempty(fbd._forces) ? 1.0 : maximum(m for (m, _, _) in fbd._forces)
    max_mag == 0 && (max_mag = 1)

    for (mag, angle_deg, label) in fbd._forces
        θ = angle_deg * π / 180
        arrow_len = 30 + (mag / max_mag) * 45  # scale length 30-75 px
        start_offset = obj_size + 4
        x1 = cx + start_offset * cos(θ)
        y1 = cy - start_offset * sin(θ)
        x2 = cx + (start_offset + arrow_len) * cos(θ)
        y2 = cy - (start_offset + arrow_len) * sin(θ)

        push!(parts, """<line x1="$(round(x1; digits=1))" y1="$(round(y1; digits=1))" x2="$(round(x2; digits=1))" y2="$(round(y2; digits=1))" stroke="currentColor" stroke-width="2" marker-end="url(#fbd-ah)"/>""")

        if !isempty(label)
            # Label at arrow tip, offset outward
            lx = x2 + 14 * cos(θ)
            ly = y2 - 14 * sin(θ)
            flx, fly = _nudge_label(lx, ly, 0.0, 0.0, placed; text_len=length(label))
            # Clamp within viewBox
            flx = clamp(flx, 10.0, w - 10.0)
            fly = clamp(fly, 16.0, h - 4.0)
            push!(parts, """<text x="$(round(flx; digits=1))" y="$(round(fly; digits=1))" font-size="13" fill="currentColor" text-anchor="middle" dominant-baseline="central" font-style="italic">$(label)</text>""")
        end
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
