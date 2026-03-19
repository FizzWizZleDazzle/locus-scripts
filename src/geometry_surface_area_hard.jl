# geometry - surface_area (hard)
# Generated: 2026-03-08T20:09:59.157156

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/surface_area")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Composite solid: cylinder with hemisphere on top
        r = randint(3, 12)
        h = randint(8, 20)
        
        d = DiagramObj(width=400, height=500)
        
        # Draw cylinder
        cyl_bottom_y = 350
        cyl_top_y = cyl_bottom_y - 15*h
        cyl_width = 12*r
        
        # Cylinder body (rectangle for front face)
        line!(d, 200 - cyl_width/2, cyl_top_y, 200 + cyl_width/2, cyl_top_y, :black, 2)
        line!(d, 200 - cyl_width/2, cyl_bottom_y, 200 + cyl_width/2, cyl_bottom_y, :black, 2)
        line!(d, 200 - cyl_width/2, cyl_top_y, 200 - cyl_width/2, cyl_bottom_y, :black, 2)
        line!(d, 200 + cyl_width/2, cyl_top_y, 200 + cyl_width/2, cyl_bottom_y, :black, 2)
        
        # Top ellipse (cylinder top)
        for i in 0:100
            angle1 = 2π * i / 100
            angle2 = 2π * (i+1) / 100
            x1 = 200 + cyl_width/2 * cos(angle1)
            y1 = cyl_top_y + 8 * sin(angle1)
            x2 = 200 + cyl_width/2 * cos(angle2)
            y2 = cyl_top_y + 8 * sin(angle2)
            line!(d, x1, y1, x2, y2, :black, 1)
        end
        
        # Hemisphere on top
        hemisphere_center_y = cyl_top_y
        for i in 0:100
            angle1 = π * i / 100
            angle2 = π * (i+1) / 100
            x1 = 200 + cyl_width/2 * cos(angle1)
            y1 = hemisphere_center_y - cyl_width/2 * sin(angle1)
            x2 = 200 + cyl_width/2 * cos(angle2)
            y2 = hemisphere_center_y - cyl_width/2 * sin(angle2)
            line!(d, x1, y1, x2, y2, :black, 2)
        end
        
        # Labels
        text!(d, 200 + cyl_width/2 + 30, (cyl_top_y + cyl_bottom_y)/2, "h = $h", 14)
        text!(d, 200, cyl_top_y + 15, "r = $r", 14)
        text!(d, 200, cyl_bottom_y + 30, "Cylinder with hemisphere", 12)
        
        # Surface area calculation
        # Hemisphere curved surface: 2πr²
        # Cylinder lateral surface: 2πrh
        # Cylinder bottom base: πr²
        # Total = 2πr² + 2πrh + πr² = 3πr² + 2πrh
        
        sa = 3 * r^2 + 2 * r * h
        
        problem(
            question="Find the total surface area of the composite solid shown, which consists of a cylinder of radius $r and height $h topped with a hemisphere of radius $r. Express your answer as a coefficient times π.",
            answer=sa,
            difficulty=(1900, 2100),
            image=render(d),
            solution=steps(
                "The solid has three surfaces to consider:",
                "1. Hemisphere curved surface: \\(2\\pi r^2 = 2\\pi ($r)^2 = $(2*r^2)\\pi\\)",
                "2. Cylinder lateral surface: \\(2\\pi r h = 2\\pi ($r)($h) = $(2*r*h)\\pi\\)",
                "3. Cylinder bottom base: \\(\\pi r^2 = \\pi ($r)^2 = $(r^2)\\pi\\)",
                sol("Total Surface Area", "$(sa)\\pi")
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Cone frustum (truncated cone)
        r1 = randint(4, 10)  # bottom radius
        r2 = randint(2, r1-1)  # top radius
        h = randint(6, 15)
        
        # Calculate slant height
        l_squared = h^2 + (r1 - r2)^2
        
        d = DiagramObj(width=400, height=450)
        
        # Draw frustum
        bottom_y = 380
        top_y = bottom_y - 18*h
        bottom_width = 20*r1
        top_width = 20*r2
        
        # Trapezoid outline
        line!(d, 200 - top_width/2, top_y, 200 + top_width/2, top_y, :black, 2)
        line!(d, 200 - bottom_width/2, bottom_y, 200 + bottom_width/2, bottom_y, :black, 2)
        line!(d, 200 - top_width/2, top_y, 200 - bottom_width/2, bottom_y, :black, 2)
        line!(d, 200 + top_width/2, top_y, 200 + bottom_width/2, bottom_y, :black, 2)
        
        # Top ellipse
        for i in 0:100
            angle1 = 2π * i / 100
            angle2 = 2π * (i+1) / 100
            x1 = 200 + top_width/2 * cos(angle1)
            y1 = top_y + 6 * sin(angle1)
            x2 = 200 + top_width/2 * cos(angle2)
            y2 = top_y + 6 * sin(angle2)
            line!(d, x1, y1, x2, y2, :black, 1)
        end
        
        # Bottom ellipse (dashed)
        for i in 0:50
            angle1 = 2π * (2*i) / 100
            angle2 = 2π * (2*i+1) / 100
            x1 = 200 + bottom_width/2 * cos(angle1)
            y1 = bottom_y + 10 * sin(angle1)
            x2 = 200 + bottom_width/2 * cos(angle2)
            y2 = bottom_y + 10 * sin(angle2)
            line!(d, x1, y1, x2, y2, :gray, 1)
        end
        
        # Labels
        text!(d, 200 + bottom_width/2 + 40, (top_y + bottom_y)/2, "h = $h", 14)
        text!(d, 200, top_y - 20, "r₂ = $r2", 14)
        text!(d, 200, bottom_y + 30, "r₁ = $r1", 14)
        
        # Surface area: π(r1² + r2² + (r1+r2)√(h² + (r1-r2)²))
        # Lateral area: π(r1+r2)l where l = √(h² + (r1-r2)²)
        
        sa_bases = r1^2 + r2^2
        lateral_coeff = r1 + r2
        
        problem(
            question="A frustum of a cone has bottom radius $r1, top radius $r2, and height $h. Find the total surface area. Express your answer in the form \\(a\\pi + b\\pi\\sqrt{c}\\) where a, b, c are integers and c is square-free. What is a + b + c?",
            answer=sa_bases + lateral_coeff + l_squared,
            difficulty=(2100, 2400),
            image=render(d),
            solution=steps(
                "Surface area = bottom base + top base + lateral surface",
                "Bottom base: \\(\\pi r_1^2 = $(r1^2)\\pi\\)",
                "Top base: \\(\\pi r_2^2 = $(r2^2)\\pi\\)",
                "Slant height: \\(l = \\sqrt{h^2 + (r_1-r_2)^2} = \\sqrt{$(h^2) + $(r1-r2)^2} = \\sqrt{$(l_squared)}\\)",
                "Lateral area: \\(\\pi(r_1+r_2)l = $(lateral_coeff)\\pi\\sqrt{$(l_squared)}\\)",
                sol("Total", "$(sa_bases)\\pi + $(lateral_coeff)\\pi\\sqrt{$(l_squared)}"),
                sol("Answer (a+b+c)", "$(sa_bases) + $(lateral_coeff) + $(l_squared) = $(sa_bases + lateral_coeff + l_squared)")
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Regular pyramid inscribed in sphere
        n = choice([3, 4, 6])  # triangular, square, or hexagonal base
        base_side = randint(6, 14)
        slant_height = randint(base_side + 2, base_side + 10)
        
        d = DiagramObj(width=400, height=450)
        
        if n == 4
            # Square pyramid
            base_y = 350
            apex_y = 150
            base_size = 140
            
            # Base square
            polygon!(d, [200-base_size/2, 200+base_size/2, 200+base_size/2, 200-base_size/2],
                       [base_y, base_y, base_y, base_y], :lightgray, :black, 1)
            
            # Edges to apex
            line!(d, 200-base_size/2, base_y, 200, apex_y, :black, 2)
            line!(d, 200+base_size/2, base_y, 200, apex_y, :black, 2)
            line!(d, 200-base_size/2, base_y, 200, apex_y, :black, 2)
            line!(d, 200+base_size/2, base_y, 200, apex_y, :black, 2)
            
            # Apex
            circle!(d, 200, apex_y, 4, :black, :black)
            
            text!(d, 200 - base_size/2 - 50, base_y, "s = $base_side", 14)
            text!(d, 200 + base_size/2 + 30, (apex_y + base_y)/2, "l = $slant_height", 14)
            
            # Calculate apothem and height
            apothem = base_side / 2
            h_squared = slant_height^2 - apothem^2
            
            # Surface area = base + 4 * (1/2 * base_side * slant_height)
            sa_coefficient = base_side^2 + 2*base_side*slant_height
            
            problem(
                question="A regular square pyramid has base edge length $base_side and slant height $slant_height. Find its total surface area.",
                answer=sa_coefficient,
                difficulty=(1850, 2050),
                image=render(d),
                solution=steps(
                    "Surface area = base area + lateral area",
                    sol("Base area", "$(base_side)^2 = $(base_side^2)"),
                    "Lateral area = 4 triangular faces, each with base $base_side and height $slant_height",
                    sol("Lateral area", "4 \\cdot \\frac{1}{2} \\cdot $(base_side) \\cdot $(slant_height) = $(2*base_side*slant_height)"),
                    sol("Total Surface Area", "$(base_side^2) + $(2*base_side*slant_height) = $(sa_coefficient)")
                ),
                time=150
            )
        else
            # Triangular pyramid (tetrahedron style)
            base_y = 350
            apex_y = 180
            base_size = 150
            
            # Equilateral triangle base
            x1, y1 = 200, base_y - base_size*0.58
            x2, y2 = 200 - base_size/2, base_y
            x3, y3 = 200 + base_size/2, base_y
            
            polygon!(d, [x1, x2, x3], [y1, y2, y3], :lightgray, :black, 2)
            
            # Edges to apex
            line!(d, x1, y1, 200, apex_y, :black, 2)
            line!(d, x2, y2, 200, apex_y, :black, 2)
            line!(d, x3, y3, 200, apex_y, :black, 2)
            
            circle!(d, 200, apex_y, 4, :black, :black)
            
            text!(d, 200, base_y + 30, "s = $base_side", 14)
            text!(d, 200 + base_size/2 + 40, (apex_y + base_y)/2, "l = $slant_height", 14)
            
            # Surface area = base + 3 lateral faces
            # Base area = (√3/4)s²
            # Each lateral face = (1/2) * s * l
            
            base_area_coeff = 3 * base_side^2  # coefficient of √3/4
            lateral_area = 3 * base_side * slant_height  # needs /2
            
            problem(
                question="A regular triangular pyramid has base edge length $base_side and slant height $slant_height. The surface area can be written as \\(\\frac{\\sqrt{3}}{4}a + \\frac{b}{2}\\). Find a + b.",
                answer=base_area_coeff + lateral_area,
                difficulty=(2000, 2300),
                image=render(d),
                solution=steps(
                    "Surface area = base area + 3 lateral faces",
                    sol("Base area (equilateral triangle)", "\\frac{\\sqrt{3}}{4}s^2 = \\frac{\\sqrt{3}}{4}($(base_side))^2 = \\frac{$(base_side^2)\\sqrt{3}}{4}"),
                    "Each lateral face area: \\(\\frac{1}{2} \\cdot $(base_side) \\cdot $(slant_height) = $(div(base_side*slant_height, 1))\\)",
                    sol("Total lateral area", "3 \\cdot \\frac{$(base_side) \\cdot $(slant_height)}{2} = \\frac{$(3*base_side*slant_height)}{2}"),
                    sol("In form \\frac{\\sqrt{3}}{4}a + \\frac{b}{2}", "a = $(base_area_coeff), b = $(lateral_area)"),
                    sol("Answer", base_area_coeff + lateral_area)
                ),
                time=210
            )
        end
    end
end
