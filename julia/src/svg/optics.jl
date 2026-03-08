#= OpticsRay — ray diagrams for lenses and mirrors =#

"""
Ray diagram for a thin lens or mirror with object, image, and principal rays.

    od = OpticsRay(; element=:converging_lens, f=10, d_o=20, h_o=3)
    svg = render(od)
"""
mutable struct OpticsRay
    _element::Symbol   # :converging_lens, :diverging_lens, :concave_mirror, :convex_mirror
    _f::Float64        # focal length (positive for converging)
    _d_o::Float64      # object distance (positive = real)
    _h_o::Float64      # object height
    _width::Int
    _height::Int
    _padding::Int

    function OpticsRay(; element::Symbol=:converging_lens, f::Real=10, d_o::Real=20, h_o::Real=3,
                        width::Int=360, height::Int=200, padding::Int=30)
        element in (:converging_lens, :diverging_lens, :concave_mirror, :convex_mirror) ||
            error("element must be :converging_lens, :diverging_lens, :concave_mirror, or :convex_mirror")
        new(element, Float64(f), Float64(d_o), Float64(h_o), width, height, padding)
    end
end

function render(od::OpticsRay)
    parts = String[]
    pad = od._padding
    w, h = od._width, od._height
    inner_w = w - 2 * pad
    inner_h = h - 2 * pad

    f = od._f
    d_o = od._d_o
    h_o = od._h_o

    # Compute image distance and magnification
    d_i = 1.0 / (1.0 / f - 1.0 / d_o)
    mag = -d_i / d_o
    h_i = mag * h_o

    # Determine coordinate range
    x_extent = max(abs(d_o), abs(d_i), 2 * abs(f)) * 1.3
    y_extent = max(abs(h_o), abs(h_i), abs(f) * 0.5) * 1.5
    y_extent = max(y_extent, 3.0)

    # Coordinate transforms (lens/mirror at origin)
    to_sx(x) = round(pad + (x + x_extent) / (2 * x_extent) * inner_w; digits=1)
    to_sy(y) = round(pad + (y_extent - y) / (2 * y_extent) * inner_h; digits=1)

    # Principal axis
    push!(parts, """<line x1="$(pad)" y1="$(to_sy(0))" x2="$(pad + inner_w)" y2="$(to_sy(0))" stroke="currentColor" stroke-width="1" stroke-opacity="0.5"/>""")

    is_lens = od._element in (:converging_lens, :diverging_lens)

    if is_lens
        # Draw lens as vertical line with arrows
        lens_half = y_extent * 0.7
        lx = to_sx(0)
        ly_top = to_sy(lens_half)
        ly_bot = to_sy(-lens_half)
        push!(parts, """<line x1="$(lx)" y1="$(ly_top)" x2="$(lx)" y2="$(ly_bot)" stroke="currentColor" stroke-width="2"/>""")

        if od._element == :converging_lens
            # Inward arrows at tips
            push!(parts, """<polygon points="$(round(lx - 5; digits=1)),$(ly_top) $(lx),$(round(ly_top + 8; digits=1)) $(round(lx + 5; digits=1)),$(ly_top)" fill="currentColor"/>""")
            push!(parts, """<polygon points="$(round(lx - 5; digits=1)),$(ly_bot) $(lx),$(round(ly_bot - 8; digits=1)) $(round(lx + 5; digits=1)),$(ly_bot)" fill="currentColor"/>""")
        else
            # Outward arrows at tips
            push!(parts, """<polygon points="$(round(lx - 5; digits=1)),$(round(ly_top + 8; digits=1)) $(lx),$(ly_top) $(round(lx + 5; digits=1)),$(round(ly_top + 8; digits=1))" fill="currentColor"/>""")
            push!(parts, """<polygon points="$(round(lx - 5; digits=1)),$(round(ly_bot - 8; digits=1)) $(lx),$(ly_bot) $(round(lx + 5; digits=1)),$(round(ly_bot - 8; digits=1))" fill="currentColor"/>""")
        end
    else
        # Draw curved mirror
        mirror_half = y_extent * 0.7
        mx = to_sx(0)
        R = 2 * abs(f)
        # Approximate with an arc
        n_arc = 20
        arc_pts = String[]
        for i in 0:n_arc
            θ = -0.4 + 0.8 * i / n_arc  # small angle range
            py = mirror_half * (2 * i / n_arc - 1)
            if od._element == :concave_mirror
                px = -py^2 / (4 * abs(f))  # parabolic approx, opening left
            else
                px = py^2 / (4 * abs(f))   # opening right
            end
            push!(arc_pts, "$(to_sx(px)),$(to_sy(py))")
        end
        push!(parts, """<polyline points="$(join(arc_pts, " "))" fill="none" stroke="currentColor" stroke-width="2"/>""")
    end

    # Focal points
    for fx in [-f, f]
        fpx = to_sx(fx)
        fpy = to_sy(0)
        push!(parts, """<circle cx="$(fpx)" cy="$(fpy)" r="3" fill="currentColor"/>""")
        push!(parts, """<text x="$(fpx)" y="$(round(fpy + 16; digits=1))" font-size="10" fill="currentColor" text-anchor="middle">F</text>""")
    end

    # Object (upward arrow at -d_o)
    obj_x = to_sx(-d_o)
    obj_base = to_sy(0)
    obj_top = to_sy(h_o)
    push!(parts, """<line x1="$(obj_x)" y1="$(obj_base)" x2="$(obj_x)" y2="$(obj_top)" stroke="#3b82f6" stroke-width="2.5"/>""")
    push!(parts, """<polygon points="$(round(obj_x - 4; digits=1)),$(round(obj_top + 6; digits=1)) $(obj_x),$(obj_top) $(round(obj_x + 4; digits=1)),$(round(obj_top + 6; digits=1))" fill="#3b82f6"/>""")
    push!(parts, """<text x="$(round(obj_x - 8; digits=1))" y="$(to_sy(h_o / 2))" font-size="10" fill="#3b82f6" text-anchor="end">obj</text>""")

    # Image (if real, draw solid; if virtual, draw dashed)
    if isfinite(d_i) && abs(d_i) < x_extent * 2
        img_x = to_sx(d_i)
        img_base = to_sy(0)
        img_top = to_sy(h_i)
        dash = d_i < 0 ? " stroke-dasharray=\"4,3\"" : ""
        push!(parts, """<line x1="$(img_x)" y1="$(img_base)" x2="$(img_x)" y2="$(img_top)" stroke="#ef4444" stroke-width="2.5"$(dash)/>""")
        arr_dir = h_i > 0 ? -1 : 1
        push!(parts, """<polygon points="$(round(img_x - 4; digits=1)),$(round(img_top + arr_dir * 6; digits=1)) $(img_x),$(img_top) $(round(img_x + 4; digits=1)),$(round(img_top + arr_dir * 6; digits=1))" fill="#ef4444" fill-opacity="$(d_i < 0 ? "0.5" : "1")"/>""")
        push!(parts, """<text x="$(round(img_x + 8; digits=1))" y="$(to_sy(h_i / 2))" font-size="10" fill="#ef4444">img</text>""")

        # Ray 1: parallel to axis → through focal point (or appears to come from)
        # From object top, horizontal to lens, then to image top
        push!(parts, """<line x1="$(obj_x)" y1="$(obj_top)" x2="$(to_sx(0))" y2="$(obj_top)" stroke="#10b981" stroke-width="1" stroke-opacity="0.7"/>""")
        push!(parts, """<line x1="$(to_sx(0))" y1="$(obj_top)" x2="$(img_x)" y2="$(img_top)" stroke="#10b981" stroke-width="1" stroke-opacity="0.7"/>""")

        # Ray 2: through center of lens (undeviated)
        push!(parts, """<line x1="$(obj_x)" y1="$(obj_top)" x2="$(img_x)" y2="$(img_top)" stroke="#f59e0b" stroke-width="1" stroke-opacity="0.7"/>""")

        # Ray 3: through focal point → parallel after lens
        push!(parts, """<line x1="$(obj_x)" y1="$(obj_top)" x2="$(to_sx(0))" y2="$(to_sy(h_i))" stroke="#8b5cf6" stroke-width="1" stroke-opacity="0.7"/>""")
        push!(parts, """<line x1="$(to_sx(0))" y1="$(to_sy(h_i))" x2="$(img_x)" y2="$(img_top)" stroke="#8b5cf6" stroke-width="1" stroke-opacity="0.7"/>""")
    end

    vb = "0 0 $(w) $(h)"
    body = join(parts)
    return """<svg xmlns="http://www.w3.org/2000/svg" viewBox="$(vb)" style="max-width:$(w)px">$(body)</svg>"""
end
