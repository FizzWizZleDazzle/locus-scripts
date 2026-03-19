# geometry - surface_area (easy)
# Generated: 2026-03-08T20:09:35.270884

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/surface_area")
    
    shape_type = choice([:rectangular_prism, :cylinder, :sphere, :cone, :cube])
    
    if shape_type == :rectangular_prism
        l = randint(3, 15)
        w = randint(3, 15)
        h = randint(3, 15)
        
        sa = 2*(l*w + l*h + w*h)
        
        d = DiagramObj(width=400, height=300)
        
        # Draw a 3D rectangular prism (isometric view)
        x_base = 100
        y_base = 200
        x_offset = 40
        y_offset = 25
        
        # Front face
        polygon!(d, [x_base, y_base, x_base + w*8, y_base, x_base + w*8, y_base - h*8, x_base, y_base - h*8], 
                fill="#87CEEB", stroke="black", stroke_width=2)
        
        # Top face
        polygon!(d, [x_base, y_base - h*8, x_base + w*8, y_base - h*8, 
                    x_base + w*8 + x_offset, y_base - h*8 - y_offset,
                    x_base + x_offset, y_base - h*8 - y_offset],
                fill="#B0E0E6", stroke="black", stroke_width=2)
        
        # Right face
        polygon!(d, [x_base + w*8, y_base, x_base + w*8 + x_offset, y_base - y_offset,
                    x_base + w*8 + x_offset, y_base - h*8 - y_offset,
                    x_base + w*8, y_base - h*8],
                fill="#ADD8E6", stroke="black", stroke_width=2)
        
        # Labels
        text!(d, x_base + w*4, y_base + 20, "$(w)", font_size=14)
        text!(d, x_base - 20, y_base - h*4, "$(h)", font_size=14)
        text!(d, x_base + w*8 + x_offset + 20, y_base - h*4 - y_offset//2, "$(l)", font_size=14)
        
        svg = render(d)
        
        problem(
            question="Find the surface area of the rectangular prism shown below.",
            answer=sa,
            difficulty=(700, 900),
            solution=steps(
                "Surface area formula: SA = 2(lw + lh + wh)",
                sol("Given dimensions: l = $(l), w = $(w), h = $(h)"),
                "SA = 2($(l)·$(w) + $(l)·$(h) + $(w)·$(h))",
                "SA = 2($(l*w) + $(l*h) + $(w*h))",
                sol("Answer", sa)
            ),
            time=90,
            image=svg
        )
        
    elseif shape_type == :cylinder
        r = randint(3, 12)
        h = randint(4, 18)
        
        sa_exact = 2*r*h + 2*r^2
        
        d = DiagramObj(width=400, height=350)
        
        # Draw cylinder
        cx = 200
        cy_top = 100
        cy_bottom = 100 + h*10
        width_ellipse = r*15
        height_ellipse = r*4
        
        # Top ellipse
        circle!(d, cx, cy_top, width_ellipse, height_ellipse, fill="#87CEEB", stroke="black", stroke_width=2)
        
        # Side lines
        line!(d, cx - width_ellipse, cy_top, cx - width_ellipse, cy_bottom, stroke="black", stroke_width=2)
        line!(d, cx + width_ellipse, cy_top, cx + width_ellipse, cy_bottom, stroke="black", stroke_width=2)
        
        # Bottom ellipse (partial - back arc)
        arc!(d, cx, cy_bottom, width_ellipse, height_ellipse, 0, 180, stroke="black", stroke_width=2, stroke_dasharray="5,5")
        arc!(d, cx, cy_bottom, width_ellipse, height_ellipse, 180, 360, stroke="black", stroke_width=2, fill="#ADD8E6")
        
        # Labels
        text!(d, cx, cy_top - 15, "r = $(r)", font_size=14)
        text!(d, cx + width_ellipse + 30, (cy_top + cy_bottom)//2, "h = $(h)", font_size=14)
        
        svg = render(d)
        
        problem(
            question="Find the surface area of the cylinder shown below. Express your answer in terms of π.",
            answer="$(sa_exact)π",
            difficulty=(900, 1100),
            solution=steps(
                "Surface area formula: SA = 2πrh + 2πr²",
                sol("Given: r = $(r), h = $(h)"),
                "SA = 2π($(r))($(h)) + 2π($(r))²",
                "SA = $(2*r*h)π + $(2*r^2)π",
                sol("Answer", "$(sa_exact)π")
            ),
            time=120,
            image=svg
        )
        
    elseif shape_type == :sphere
        r = randint(4, 15)
        
        sa_exact = 4*r^2
        
        d = DiagramObj(width=400, height=400)
        
        cx = 200
        cy = 200
        radius_draw = r*12
        
        # Draw sphere as circle
        circle!(d, cx, cy, radius_draw, radius_draw, fill="#87CEEB", stroke="black", stroke_width=2)
        
        # Add radius line
        line!(d, cx, cy, cx + radius_draw, cy, stroke="black", stroke_width=2, stroke_dasharray="5,5")
        point!(d, cx, cy, label="", radius=4, fill="black")
        
        # Label
        text!(d, cx + radius_draw//2, cy - 15, "r = $(r)", font_size=14)
        
        svg = render(d)
        
        problem(
            question="Find the surface area of the sphere shown below. Express your answer in terms of π.",
            answer="$(sa_exact)π",
            difficulty=(700, 900),
            solution=steps(
                "Surface area formula: SA = 4πr²",
                sol("Given: r = $(r)"),
                "SA = 4π($(r))²",
                "SA = 4π($(r^2))",
                sol("Answer", "$(sa_exact)π")
            ),
            time=90,
            image=svg
        )
        
    elseif shape_type == :cone
        r = randint(3, 12)
        h = randint(4, 15)
        l = Int(round(sqrt(r^2 + h^2)))
        
        sa_exact = r*l + r^2
        
        d = DiagramObj(width=400, height=400)
        
        cx = 200
        cy_base = 320
        cy_apex = cy_base - h*15
        width_base = r*15
        
        # Draw cone
        # Base ellipse
        circle!(d, cx, cy_base, width_base, width_base//4, fill="#ADD8E6", stroke="black", stroke_width=2)
        
        # Side lines
        line!(d, cx, cy_apex, cx - width_base, cy_base, stroke="black", stroke_width=2)
        line!(d, cx, cy_apex, cx + width_base, cy_base, stroke="black", stroke_width=2)
        
        # Apex point
        point!(d, cx, cy_apex, label="", radius=4, fill="black")
        
        # Height line
        line!(d, cx, cy_apex, cx, cy_base, stroke="black", stroke_width=1, stroke_dasharray="5,5")
        
        # Labels
        text!(d, cx + 20, (cy_apex + cy_base)//2, "h = $(h)", font_size=14)
        text!(d, cx, cy_base + 20, "r = $(r)", font_size=14)
        text!(d, cx - width_base//2 - 20, (cy_apex + cy_base)//2, "l = $(l)", font_size=14)
        
        svg = render(d)
        
        problem(
            question="Find the surface area of the cone shown below (including the base). Express your answer in terms of π.",
            answer="$(sa_exact)π",
            difficulty=(1000, 1200),
            solution=steps(
                "Surface area formula: SA = πrl + πr² (lateral area + base)",
                sol("Given: r = $(r), h = $(h), l = $(l)"),
                "SA = π($(r))($(l)) + π($(r))²",
                "SA = $(r*l)π + $(r^2)π",
                sol("Answer", "$(sa_exact)π")
            ),
            time=120,
            image=svg
        )
        
    else  # cube
        s = randint(4, 18)
        
        sa = 6*s^2
        
        d = DiagramObj(width=400, height=300)
        
        # Draw a 3D cube (isometric view)
        x_base = 100
        y_base = 200
        x_offset = 50
        y_offset = 30
        side = s*8
        
        # Front face
        polygon!(d, [x_base, y_base, x_base + side, y_base, 
                    x_base + side, y_base - side, x_base, y_base - side], 
                fill="#87CEEB", stroke="black", stroke_width=2)
        
        # Top face
        polygon!(d, [x_base, y_base - side, x_base + side, y_base - side, 
                    x_base + side + x_offset, y_base - side - y_offset,
                    x_base + x_offset, y_base - side - y_offset],
                fill="#B0E0E6", stroke="black", stroke_width=2)
        
        # Right face
        polygon!(d, [x_base + side, y_base, x_base + side + x_offset, y_base - y_offset,
                    x_base + side + x_offset, y_base - side - y_offset,
                    x_base + side, y_base - side],
                fill="#ADD8E6", stroke="black", stroke_width=2)
        
        # Label
        text!(d, x_base + side//2, y_base + 20, "s = $(s)", font_size=14)
        
        svg = render(d)
        
        problem(
            question="Find the surface area of the cube shown below.",
            answer=sa,
            difficulty=(700, 850),
            solution=steps(
                "Surface area formula for a cube: SA = 6s²",
                sol("Given: s = $(s)"),
                "SA = 6($(s))²",
                "SA = 6($(s^2))",
                sol("Answer", sa)
            ),
            time=75,
            image=svg
        )
    end
end