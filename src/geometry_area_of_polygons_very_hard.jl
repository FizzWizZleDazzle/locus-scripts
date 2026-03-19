# geometry - area_of_polygons (very_hard)
# Generated: 2026-03-08T20:08:13.630194

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/area_of_polygons")
    
    # Generate a competition/olympiad level problem (2500-3500 ELO)
    # Problem: Complex polygon with circle inscribed in a trapezoid
    
    problem_type = rand(1:3)
    
    if problem_type == 1
        # Hard problem: Trapezoid with inscribed circle
        # Key insight: In a tangential trapezoid, sum of parallel sides equals sum of legs
        a = randint(8, 20)  # longer base
        b = randint(4, a-2)  # shorter base
        # For tangential trapezoid: a + b = 2*leg
        leg = (a + b) // 2
        h = randint(6, 15)  # height
        r = h // 2  # inradius
        
        # Area of trapezoid
        trap_area = (a + b) * h // 2
        # Area of inscribed circle
        circle_area = π * r^2
        
        # Create diagram
        d = DiagramObj(width=400, height=300)
        # Draw trapezoid with horizontal bases
        y_bottom = 50
        y_top = y_bottom + h * 10
        x_left_bottom = 50
        x_right_bottom = x_left_bottom + a * 10
        x_left_top = x_left_bottom + (a - b) * 5
        x_right_top = x_left_top + b * 10
        
        polygon!(d, [
            (x_left_bottom, y_bottom),
            (x_right_bottom, y_bottom),
            (x_right_top, y_top),
            (x_left_top, y_top)
        ]; fill="lightblue", opacity=0.3)
        
        # Draw inscribed circle
        cx = (x_left_bottom + x_right_bottom) / 2
        cy = (y_bottom + y_top) / 2
        circle!(d, cx, cy, r * 10; fill="lightyellow", opacity=0.5)
        
        # Labels
        segment_label!(d, (x_left_bottom + x_right_bottom)/2, y_bottom - 15, "$(a)")
        segment_label!(d, (x_left_top + x_right_top)/2, y_top + 15, "$(b)")
        segment_label!(d, x_left_bottom - 20, (y_bottom + y_top)/2, "h=$(h)")
        text!(d, cx, cy, "r=$(r)"; fontsize=12)
        
        shaded_area = trap_area - circle_area
        
        problem(
            question="A trapezoid with parallel sides of length $(a) and $(b) has height $(h). A circle with radius $(r) is inscribed in the trapezoid (tangent to all four sides). Find the area of the region inside the trapezoid but outside the circle. Express your answer in the form \\(A - B\\pi\\) where \\(A\\) and \\(B\\) are integers.",
            answer="$(trap_area) - $(r^2)π",
            difficulty=(2500, 2900),
            solution=steps(
                "The trapezoid has bases $(a) and $(b) with height $(h)",
                sol("Area of trapezoid", "\\frac{1}{2}($(a) + $(b)) \\cdot $(h) = $(trap_area)"),
                "The inscribed circle has radius $(r)",
                sol("Area of circle", "\\pi r^2 = \\pi \\cdot $(r)^2 = $(r^2)\\pi"),
                sol("Shaded area", "$(trap_area) - $(r^2)\\pi")
            ),
            image=render(d),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad problem: Regular polygon with internal structure
        n = choice([5, 6, 8])  # pentagon, hexagon, or octagon
        s = randint(8, 16)  # side length
        
        # For regular n-gon with side s, area = (n*s^2)/(4*tan(π/n))
        # Use exact expressions
        if n == 6
            # Hexagon: area = (3√3/2)s²
            area_coeff_num = 3 * s^2
            area_coeff_denom = 2
            radical = 3
            area_expr = "\\frac{$(area_coeff_num)\\sqrt{$(radical)}}{$(area_coeff_denom)}"
            numerical_area = (3 * sqrt(3) / 2) * s^2
        elseif n == 5
            # Pentagon is more complex, use approximation
            numerical_area = (5 * s^2) / (4 * tan(π/5))
            area_expr = "\\frac{5 \\cdot $(s)^2}{4\\tan(\\pi/5)}"
        else  # n == 8
            # Octagon: area = 2(1+√2)s²
            numerical_area = 2 * (1 + sqrt(2)) * s^2
            area_expr = "2(1 + \\sqrt{2}) \\cdot $(s)^2"
        end
        
        # Create diagram
        d = DiagramObj(width=400, height=400)
        cx, cy = 200, 200
        radius = s * 40 / (2 * sin(π/n))
        
        points = []
        for i in 0:(n-1)
            angle = 2π * i / n - π/2
            px = cx + radius * cos(angle)
            py = cy + radius * sin(angle)
            push!(points, (px, py))
        end
        
        polygon!(d, points; fill="lightgreen", opacity=0.3)
        
        # Draw lines from center to vertices
        for pt in points
            line!(d, cx, cy, pt[1], pt[2]; stroke="gray", opacity=0.5, dash="5,5")
        end
        
        # Label side
        segment_label!(d, (points[1][1] + points[2][1])/2, (points[1][2] + points[2][2])/2 - 20, "$(s)")
        
        # Number of triangles formed
        num_triangles = n
        
        problem(
            question="A regular $(n)-gon has side length $(s). The polygon is divided into $(num_triangles) congruent triangles by drawing segments from the center to each vertex. Find the total area of the $(n)-gon.",
            answer=round(numerical_area, digits=2),
            difficulty=(2800, 3200),
            solution=steps(
                "A regular $(n)-gon with side length $(s) can be divided into $(n) congruent isosceles triangles",
                "Each triangle has base $(s) and the apex angle is \\(\\frac{2\\pi}{$(n)}\\)",
                "The area formula for a regular $(n)-gon is \\(A = $(area_expr)\\)",
                sol("Total area", "$(round(numerical_area, digits=2))")
            ),
            image=render(d),
            time=300,
            calculator="scientific"
        )
        
    else
        # Hard composition problem: Square with inscribed and circumscribed circles
        s = randint(10, 24)
        
        # Square with side s
        square_area = s^2
        # Inscribed circle radius = s/2
        r_in = s // 2
        inscribed_area = π * r_in^2
        # Circumscribed circle radius = s*√2/2
        # Area between square and circumscribed circle
        r_out_sq = s^2 // 2  # (s√2/2)² = s²/2
        circumscribed_area = π * r_out_sq
        
        # Create diagram
        d = DiagramObj(width=400, height=400)
        cx, cy = 200, 200
        half_s = s * 10
        
        # Circumscribed circle
        r_circ = half_s * sqrt(2)
        circle!(d, cx, cy, r_circ; fill="lightcoral", opacity=0.2)
        
        # Square
        polygon!(d, [
            (cx - half_s, cy - half_s),
            (cx + half_s, cy - half_s),
            (cx + half_s, cy + half_s),
            (cx - half_s, cy + half_s)
        ]; fill="lightblue", opacity=0.4)
        
        # Inscribed circle
        circle!(d, cx, cy, half_s; fill="lightyellow", opacity=0.6)
        
        segment_label!(d, cx, cy - half_s - 15, "$(s)")
        
        # Area between circumscribed circle and square
        area_outside = circumscribed_area - square_area
        # Area between square and inscribed circle  
        area_inside = square_area - inscribed_area
        
        # Total shaded area (both regions)
        ratio_num = s^2
        ratio_denom = 2
        
        problem(
            question="A square with side length $(s) has a circle inscribed in it (tangent to all sides) and a circle circumscribed around it (passing through all vertices). Find the ratio of the area between the square and its inscribed circle to the area between the circumscribed circle and the square. Express your answer as a simplified fraction.",
            answer="$(2*r_in^2) / $(ratio_num)",
            difficulty=(2600, 3000),
            solution=steps(
                "Square has side $(s), so area = $(s^2)",
                "Inscribed circle has radius \\(r = $(s)/2\\), area = \\(\\pi ($(s)/2)^2 = \\frac{$(s^2)\\pi}{4}\\)",
                "Area between square and inscribed circle: \\($(s^2) - \\frac{$(s^2)\\pi}{4}\\)",
                "Circumscribed circle has radius \\(R = \\frac{$(s)\\sqrt{2}}{2}\\), area = \\(\\pi \\cdot \\frac{$(s^2)}{2} = \\frac{$(s^2)\\pi}{2}\\)",
                "Area between circumscribed and square: \\(\\frac{$(s^2)\\pi}{2} - $(s^2)\\)",
                sol("Ratio", "\\frac{$(s^2) - \\frac{$(s^2)\\pi}{4}}{\\frac{$(s^2)\\pi}{2} - $(s^2)} = \\frac{4 - \\pi}{2\\pi - 4}")
            ),
            image=render(d),
            time=300
        )
    end
end