# geometry - volume (hard)
# Generated: 2026-03-08T20:11:04.733066

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("geometry/volume")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Composite solid volume (cylinder with hemisphere)
        r = randint(3, 12)
        h = randint(8, 25)
        
        V_cyl = rationalize(π * r^2 * h)
        V_hemi = rationalize(2//3 * π * r^3)
        V_total = V_cyl + V_hemi
        
        d = DiagramObj(width=400, height=500)
        
        # Draw cylinder
        polygon!(d, [150, 200, 250, 200], [150, 130, 130, 150], fill="lightblue", stroke="black", stroke_width=2)
        polygon!(d, [150, 200, 200, 150], [150, 130, 350, 370], fill="skyblue", stroke="black", stroke_width=2)
        polygon!(d, [200, 250, 250, 200], [130, 150, 370, 350], fill="lightsteelblue", stroke="black", stroke_width=2)
        
        # Top hemisphere
        arc!(d, 200, 150, r*4, 0, 180, fill="lightcoral", stroke="black", stroke_width=2)
        line!(d, [150, 250], [150, 150], stroke="black", stroke_width=2)
        
        # Labels
        text!(d, 270, 250, "h = $(h)", font_size=16)
        text!(d, 130, 180, "r = $(r)", font_size=16)
        
        arrow!(d, [260, 225], [250, 250], stroke="black", stroke_width=1.5)
        arrow!(d, [140, 165], [150, 160], stroke="black", stroke_width=1.5)
        
        problem(
            question="A solid consists of a right circular cylinder with radius $(r) units and height $(h) units, topped with a hemisphere of the same radius. Find the exact volume of the solid in cubic units.",
            answer=tex(V_total),
            difficulty=(1850, 2050),
            solution=steps(
                "Volume = Volume of cylinder + Volume of hemisphere",
                sol("V_{cylinder}", π * r^2 * h),
                sol("V_{hemisphere}", rationalize(2//3) * π * r^3),
                sol("V_{total}", V_total)
            ),
            time=180,
            image=render(d)
        )
        
    elseif problem_type == 2
        # Frustum of cone
        r1 = randint(4, 10)
        r2 = randint(r1 + 3, r1 + 10)
        h = randint(6, 18)
        
        V = rationalize(π * h * (r1^2 + r1*r2 + r2^2) // 3)
        
        d = DiagramObj(width=450, height=400)
        
        # Draw frustum
        top_y = 100
        bottom_y = 320
        center_x = 225
        
        # Top circle (smaller)
        for i in 0:20
            angle = 2π * i / 20
            x1 = center_x + r1 * 8 * cos(angle)
            y1 = top_y - r1 * 3 * sin(angle) * 0.3
            if i > 0
                x2 = center_x + r1 * 8 * cos(2π * (i-1) / 20)
                y2 = top_y - r1 * 3 * sin(2π * (i-1) / 20) * 0.3
                line!(d, [x1, x2], [y1, y2], stroke="black", stroke_width=2)
            end
        end
        
        # Bottom circle (larger)
        for i in 0:20
            angle = 2π * i / 20
            x1 = center_x + r2 * 8 * cos(angle)
            y1 = bottom_y - r2 * 3 * sin(angle) * 0.3
            if i > 0
                x2 = center_x + r2 * 8 * cos(2π * (i-1) / 20)
                y2 = bottom_y - r2 * 3 * sin(2π * (i-1) / 20) * 0.3
                line!(d, [x1, x2], [y1, y2], stroke="black", stroke_width=2)
            end
        end
        
        # Side lines
        line!(d, [center_x - r1*8, center_x - r2*8], [top_y, bottom_y], stroke="black", stroke_width=2)
        line!(d, [center_x + r1*8, center_x + r2*8], [top_y, bottom_y], stroke="black", stroke_width=2)
        
        # Labels
        text!(d, center_x - 50, top_y - 20, "r₁ = $(r1)", font_size=14)
        text!(d, center_x - 50, bottom_y + 30, "r₂ = $(r2)", font_size=14)
        text!(d, center_x + r2*8 + 30, (top_y + bottom_y)/2, "h = $(h)", font_size=14)
        
        problem(
            question="Find the exact volume of a frustum of a cone with top radius $(r1) units, bottom radius $(r2) units, and height $(h) units. Use the formula V = (πh/3)(r₁² + r₁r₂ + r₂²).",
            answer=tex(V),
            difficulty=(1900, 2150),
            solution=steps(
                sol("Formula", rationalize(π * h // 3) * (r1^2 + r1*r2 + r2^2)),
                "Substitute values: r₁=$(r1), r₂=$(r2), h=$(h)",
                sol("Calculate", rationalize(π * h // 3) * "($(r1^2) + $(r1*r2) + $(r2^2))"),
                sol("V", V)
            ),
            time=210,
            image=render(d)
        )
        
    elseif problem_type == 3
        # Sphere with inscribed cube
        s = randint(4, 12)
        space_diag = s * sqrt(3)
        r = rationalize(s * sqrt(3) // 2)
        V_sphere = rationalize(4//3 * π * (s * sqrt(3) // 2)^3)
        V_cube = s^3
        V_diff = V_sphere - V_cube
        
        d = DiagramObj(width=450, height=450)
        
        # Draw sphere
        circle!(d, 225, 225, 120, fill="none", stroke="blue", stroke_width=2, opacity=0.3)
        
        # Draw inscribed cube (isometric view)
        cx, cy = 225, 225
        offset = 60
        
        # Front face
        polygon!(d, 
            [cx-offset, cx+offset, cx+offset, cx-offset],
            [cy-offset*0.5, cy-offset*0.5, cy+offset*1.2, cy+offset*1.2],
            fill="lightgreen", stroke="black", stroke_width=2, opacity=0.7)
        
        # Top face
        polygon!(d,
            [cx-offset, cx+offset, cx+offset*0.3, cx-offset*0.3],
            [cy-offset*0.5, cy-offset*0.5, cy-offset*1.5, cy-offset*1.5],
            fill="darkgreen", stroke="black", stroke_width=2, opacity=0.7)
        
        # Side face
        polygon!(d,
            [cx+offset, cx+offset*0.3, cx+offset*0.3, cx+offset],
            [cy-offset*0.5, cy-offset*1.5, cy+offset*0.2, cy+offset*1.2],
            fill="mediumseagreen", stroke="black", stroke_width=2, opacity=0.7)
        
        text!(d, 150, 380, "Cube side = $(s)", font_size=16)
        text!(d, 150, 410, "Sphere contains cube", font_size=14)
        
        problem(
            question="A cube with side length $(s) units is inscribed in a sphere (all vertices touch the sphere). Find the exact volume of the region between the sphere and the cube. The space diagonal of a cube with side s is s√3.",
            answer=tex(V_diff),
            difficulty=(2100, 2350),
            solution=steps(
                "Space diagonal of cube = $(s)√3, which equals sphere diameter",
                sol("Sphere radius", rationalize(s // 2) * sqrt(3)),
                sol("V_{sphere}", rationalize(4//3) * π * (rationalize(s // 2) * sqrt(3))^3),
                sol("V_{cube}", s^3),
                sol("V_{difference}", V_diff)
            ),
            time=240,
            image=render(d)
        )
        
    elseif problem_type == 4
        # Volume of revolution (disk method)
        a = randint(2, 6)
        b = randint(1, 4)
        x_max = randint(3, 8)
        
        V = rationalize(π * (a^2 * x_max^3 // 3 + 2*a*b * x_max^2 // 2 + b^2 * x_max))
        
        d = DiagramObj(width=500, height=400)
        g = GraphObj(d, x_range=(-1, x_max+2), y_range=(-2, a*x_max + b + 3), 
                     width=450, height=350, origin_x=50, origin_y=300)
        
        plot!(g, a*x + b, stroke="blue", stroke_width=2.5)
        plot!(g, 0, stroke="black", stroke_width=1.5)
        
        vline!(g, x_max, stroke="red", stroke_width=1.5, stroke_dasharray="5,5")
        
        text!(d, 250, 30, "Rotate about x-axis: 0 ≤ x ≤ $(x_max)", font_size=15)
        text!(d, 380, 120, "y = $(a)x + $(b)", font_size=14, fill="blue")
        
        problem(
            question="Find the exact volume of the solid obtained by rotating the region bounded by y = $(a)x + $(b), the x-axis, x = 0, and x = $(x_max) about the x-axis using the disk method.",
            answer=tex(V),
            difficulty=(2000, 2250),
            solution=steps(
                sol("Formula", π * "\\int_0^{$(x_max)} ($(a)x + $(b))^2 \\, dx"),
                "Expand: $(tex((a*x + b)^2))",
                sol("Integrate", π * "($(tex(rationalize(a^2 // 3) * x^3)) + $(tex(a*b * x^2)) + $(tex(b^2 * x)))|_0^{$(x_max)}"),
                sol("V", V)
            ),
            time=270,
            image=render(g)
        )
        
    else
        # Rectangular prism with rectangular hole
        L = randint(12, 25)
        W = randint(10, 20)
        H = randint(8, 18)
        
        l = randint(3, min(8, L-4))
        w = randint(3, min(7, W-4))
        
        V_total = L * W * H
        V_hole = l * w * H
        V_remaining = V_total - V_hole
        
        d = DiagramObj(width=500, height=450)
        
        # Draw outer prism (isometric)
        cx, cy = 150, 250
        
        # Front face
        polygon!(d, [cx, cx+L*6, cx+L*6, cx], 
                 [cy, cy, cy+H*8, cy+H*8],
                 fill="lightblue", stroke="black", stroke_width=2)
        
        # Top face
        polygon!(d, [cx, cx+L*6, cx+L*6+W*3, cx+W*3],
                 [cy, cy, cy-W*2, cy-W*2],
                 fill="steelblue", stroke="black", stroke_width=2)
        
        # Side face
        polygon!(d, [cx+L*6, cx+L*6+W*3, cx+L*6+W*3, cx+L*6],
                 [cy, cy-W*2, cy+H*8-W*2, cy+H*8],
                 fill="skyblue", stroke="black", stroke_width=2)
        
        # Draw hole (darker)
        hole_x = cx + 20
        hole_y = cy + 30
        polygon!(d, [hole_x, hole_x+l*6, hole_x+l*6, hole_x],
                 [hole_y, hole_y, hole_y+H*8, hole_y+H*8],
                 fill="darkslategray", stroke="red", stroke_width=2)
        
        # Labels
        text!(d, cx + L*3, cy + H*8 + 30, "L = $(L)", font_size=14)
        text!(d, cx + L*6 + W*3 + 10, cy + H*4, "W = $(W)", font_size=14)
        text!(d, cx - 30, cy + H*4, "H = $(H)", font_size=14)
        text!(d, hole_x + l*3, hole_y - 15, "$(l)×$(w)", font_size=12, fill="red")
        
        problem(
            question="A rectangular prism with dimensions $(L) × $(W) × $(H) has a rectangular hole of dimensions $(l) × $(w) drilled completely through it parallel to the height. What is the volume of the remaining solid?",
            answer=V_remaining,
            difficulty=(1800, 2000),
            solution=steps(
                sol("V_{prism}", L * W * H),
                sol("V_{hole}", l * w * H),
                "Subtract hole volume from total",
                sol("V_{remaining}", V_remaining)
            ),
            time=150,
            image=render(d)
        )
    end
end