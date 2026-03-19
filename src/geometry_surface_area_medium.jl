# geometry - surface_area (medium)
# Generated: 2026-03-08T20:09:36.600254

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/surface_area")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Rectangular prism surface area
        l = randint(3, 15)
        w = randint(3, 15)
        h = randint(3, 15)
        
        sa = 2*(l*w + l*h + w*h)
        
        d = DiagramObj(width=400, height=300)
        
        # Draw 3D rectangular prism in isometric view
        scale = 15
        x0, y0 = 200, 200
        
        # Front face
        polygon!(d, [
            (x0, y0),
            (x0 + l*scale, y0),
            (x0 + l*scale, y0 - h*scale),
            (x0, y0 - h*scale)
        ], fill="lightblue", stroke="black", stroke_width=2)
        
        # Top face (isometric)
        polygon!(d, [
            (x0, y0 - h*scale),
            (x0 + l*scale, y0 - h*scale),
            (x0 + l*scale + w*scale*0.5, y0 - h*scale - w*scale*0.4),
            (x0 + w*scale*0.5, y0 - h*scale - w*scale*0.4)
        ], fill="lightcoral", stroke="black", stroke_width=2)
        
        # Right face
        polygon!(d, [
            (x0 + l*scale, y0),
            (x0 + l*scale + w*scale*0.5, y0 - w*scale*0.4),
            (x0 + l*scale + w*scale*0.5, y0 - h*scale - w*scale*0.4),
            (x0 + l*scale, y0 - h*scale)
        ], fill="lightgreen", stroke="black", stroke_width=2)
        
        # Labels
        text!(d, x0 + l*scale/2, y0 + 15, "$(l)", font_size=14, font_weight="bold")
        text!(d, x0 - 15, y0 - h*scale/2, "$(h)", font_size=14, font_weight="bold")
        text!(d, x0 + l*scale + w*scale*0.25 + 15, y0 - w*scale*0.2, "$(w)", font_size=14, font_weight="bold")
        
        problem(
            question="Find the surface area of the rectangular prism shown in the diagram.",
            answer=sa,
            difficulty=(1200, 1400),
            solution=steps(
                "Surface area formula: \$SA = 2(lw + lh + wh)\$",
                sol("Substitute dimensions", "SA = 2($l \\cdot $w + $l \\cdot $h + $w \\cdot $h)"),
                sol("Calculate", "SA = 2($(l*w) + $(l*h) + $(w*h)) = 2($(l*w + l*h + w*h))"),
                sol("Answer", sa)
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 2
        # Cylinder surface area
        r = randint(3, 12)
        h = randint(5, 20)
        
        sa_exact = 2*r*h + 2*r^2
        
        d = DiagramObj(width=400, height=350)
        
        # Draw cylinder
        cx, cy = 200, 250
        
        # Top ellipse
        arc!(d, cx, cy - h*12, r*15, r*6, 0, 360, fill="lightblue", stroke="black", stroke_width=2)
        
        # Bottom ellipse
        arc!(d, cx, cy, r*15, r*6, 0, 180, fill="none", stroke="black", stroke_width=2, stroke_dasharray="none")
        arc!(d, cx, cy, r*15, r*6, 180, 360, fill="lightblue", stroke="black", stroke_width=2, stroke_dasharray="5,5")
        
        # Sides
        line!(d, cx - r*15, cy - h*12, cx - r*15, cy, stroke="black", stroke_width=2)
        line!(d, cx + r*15, cy - h*12, cx + r*15, cy, stroke="black", stroke_width=2)
        
        # Labels
        text!(d, cx + r*15 + 20, cy - h*6, "h = $(h)", font_size=14, font_weight="bold")
        line!(d, cx, cy, cx + r*15, cy, stroke="red", stroke_width=2)
        text!(d, cx + r*7.5, cy + 15, "r = $(r)", font_size=14, font_weight="bold", fill="red")
        
        problem(
            question="Find the surface area of the cylinder shown in the diagram. Give your answer in terms of π.",
            answer="$(sa_exact)π",
            difficulty=(1300, 1500),
            solution=steps(
                "Surface area formula: \$SA = 2\\pi r h + 2\\pi r^2\$",
                sol("Substitute values", "SA = 2\\pi($r)($h) + 2\\pi($r)^2"),
                sol("Simplify", "SA = $(2*r*h)\\pi + $(2*r^2)\\pi"),
                sol("Answer", "$(sa_exact)\\pi")
            ),
            image=render(d),
            time=150
        )
        
    elseif problem_type == 3
        # Cone surface area
        r = randint(4, 12)
        s = randint(r+2, 20)  # slant height must be > radius
        
        sa_exact = r*s + r^2
        
        d = DiagramObj(width=400, height=350)
        
        # Draw cone
        cx, cy_base = 200, 280
        cy_apex = 80
        
        # Base circle
        arc!(d, cx, cy_base, r*15, r*6, 0, 180, fill="none", stroke="black", stroke_width=2)
        arc!(d, cx, cy_base, r*15, r*6, 180, 360, fill="lightblue", stroke="black", stroke_width=2, stroke_dasharray="5,5")
        
        # Sides
        line!(d, cx - r*15, cy_base, cx, cy_apex, stroke="black", stroke_width=2)
        line!(d, cx + r*15, cy_base, cx, cy_apex, stroke="black", stroke_width=2)
        
        # Slant height
        line!(d, cx, cy_apex, cx + r*15, cy_base, stroke="red", stroke_width=2)
        text!(d, cx + r*7.5 + 10, (cy_apex + cy_base)/2, "s = $(s)", font_size=14, font_weight="bold", fill="red")
        
        # Radius
        line!(d, cx, cy_base, cx + r*15, cy_base, stroke="blue", stroke_width=2)
        text!(d, cx + r*7.5, cy_base + 15, "r = $(r)", font_size=14, font_weight="bold", fill="blue")
        
        problem(
            question="Find the surface area of the cone shown in the diagram, where s is the slant height. Give your answer in terms of π.",
            answer="$(sa_exact)π",
            difficulty=(1400, 1600),
            solution=steps(
                "Surface area formula: \$SA = \\pi r s + \\pi r^2\$ (lateral area + base)",
                sol("Substitute values", "SA = \\pi($r)($s) + \\pi($r)^2"),
                sol("Simplify", "SA = $(r*s)\\pi + $(r^2)\\pi"),
                sol("Answer", "$(sa_exact)\\pi")
            ),
            image=render(d),
            time=150
        )
        
    else
        # Composite solid: cylinder with hemisphere on top
        r = randint(3, 10)
        h_cyl = randint(6, 18)
        
        # SA = curved surface of cylinder + base + hemisphere
        # = 2πrh + πr² + 2πr²
        sa_exact = 2*r*h_cyl + 3*r^2
        
        d = DiagramObj(width=400, height=400)
        
        cx, cy_base = 200, 320
        cy_top_cyl = cy_base - h_cyl*12
        
        # Bottom of cylinder
        arc!(d, cx, cy_base, r*15, r*6, 0, 180, fill="none", stroke="black", stroke_width=2)
        arc!(d, cx, cy_base, r*15, r*6, 180, 360, fill="lightblue", stroke="black", stroke_width=2, stroke_dasharray="5,5")
        
        # Cylinder sides
        line!(d, cx - r*15, cy_base, cx - r*15, cy_top_cyl, stroke="black", stroke_width=2)
        line!(d, cx + r*15, cy_base, cx + r*15, cy_top_cyl, stroke="black", stroke_width=2)
        
        # Top circle of cylinder (where hemisphere attaches)
        arc!(d, cx, cy_top_cyl, r*15, r*6, 0, 360, fill="none", stroke="black", stroke_width=1, stroke_dasharray="3,3")
        
        # Hemisphere
        arc!(d, cx, cy_top_cyl, r*15, r*15, 180, 360, fill="lightcoral", stroke="black", stroke_width=2)
        
        # Labels
        text!(d, cx + r*15 + 25, (cy_base + cy_top_cyl)/2, "h = $(h_cyl)", font_size=14, font_weight="bold")
        line!(d, cx, cy_top_cyl, cx + r*15, cy_top_cyl, stroke="red", stroke_width=2)
        text!(d, cx + r*7.5, cy_top_cyl + 15, "r = $(r)", font_size=14, font_weight="bold", fill="red")
        
        problem(
            question="Find the surface area of the composite solid shown in the diagram, which consists of a cylinder with a hemisphere on top. Give your answer in terms of π.",
            answer="$(sa_exact)π",
            difficulty=(1500, 1800),
            solution=steps(
                "The surface consists of: curved cylinder surface + circular base + hemisphere surface",
                sol("Formulas", "SA = 2\\pi r h + \\pi r^2 + 2\\pi r^2"),
                sol("Substitute r=$(r), h=$(h_cyl)", "SA = 2\\pi($r)($h_cyl) + \\pi($r)^2 + 2\\pi($r)^2"),
                sol("Simplify", "SA = $(2*r*h_cyl)\\pi + $(r^2)\\pi + $(2*r^2)\\pi = $(sa_exact)\\pi"),
                sol("Answer", "$(sa_exact)\\pi")
            ),
            image=render(d),
            time=180
        )
    end
end