# geometry - perimeter (very_hard)
# Generated: 2026-03-08T20:09:06.849024

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/perimeter")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition-level: Triangle with angle bisector and perimeter constraint
        # ELO 2500-2800
        a = randint(8, 20)
        b = randint(8, 20)
        c = randint(max(abs(a-b)+1, 8), min(a+b-1, 25))
        
        # By angle bisector theorem, if AD bisects angle A in triangle ABC with D on BC,
        # then BD/DC = AB/AC
        # Let BD = x, DC = y, then x/y = c/b and x + y = a
        ratio_num = c
        ratio_den = b
        gcd_val = gcd(ratio_num, ratio_den)
        ratio_num = ratio_num ÷ gcd_val
        ratio_den = ratio_den ÷ gcd_val
        
        BD = (a * ratio_num) // (ratio_num + ratio_den)
        DC = (a * ratio_den) // (ratio_num + ratio_den)
        
        perimeter = a + b + c
        
        d = DiagramObj(width=500, height=400)
        Ax, Ay = 100, 350
        Bx, By = 400, 350
        Cx, Cy = 150 + rand(50:200), 80
        
        # Point D on BC
        t = Float64(BD) / Float64(a)
        Dx = Bx + t * (Cx - Bx)
        Dy = By + t * (Cy - By)
        
        line!(d, Ax, Ay, Bx, By, stroke="black", stroke_width=2)
        line!(d, Bx, By, Cx, Cy, stroke="black", stroke_width=2)
        line!(d, Cx, Cy, Ax, Ay, stroke="black", stroke_width=2)
        line!(d, Ax, Ay, Dx, Dy, stroke="blue", stroke_width=1.5, stroke_dasharray="5,5")
        
        point!(d, Ax, Ay, label="A", label_pos="below")
        point!(d, Bx, By, label="B", label_pos="below")
        point!(d, Cx, Cy, label="C", label_pos="above")
        point!(d, Dx, Dy, label="D", label_pos="below")
        
        segment_label!(d, Cx, Cy, Ax, Ay, "$(b)", offset=15)
        segment_label!(d, Ax, Ay, Bx, By, "$(a)", offset=-20)
        segment_label!(d, Bx, By, Cx, Cy, "$(c)", offset=15)
        
        problem(
            question="In triangle ABC, side AB = $(a), side BC = $(c), and side CA = $(b). The angle bisector from vertex A meets side BC at point D. If the ratio BD:DC can be expressed in lowest terms as m:n, find the perimeter of triangle ABC plus m + n.",
            answer=perimeter + ratio_num + ratio_den,
            difficulty=(2500, 2800),
            solution=steps(
                "By the Angle Bisector Theorem, BD/DC = AB/AC = $(c)/$(b)",
                sol("Simplify ratio", "BD:DC = $(ratio_num):$(ratio_den)"),
                sol("Perimeter", perimeter),
                sol("Answer", perimeter + ratio_num + ratio_den)
            ),
            image=render(d),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad-level: Cyclic quadrilateral with tangent properties
        # ELO 3000-3400
        r = randint(8, 16)
        
        # Inscribed quadrilateral in circle, with specific angle properties
        angle_A = randint(60, 100)
        angle_C = 180 - angle_A
        
        # Sides computed from inscribed quadrilateral properties
        a = randint(10, 24)
        b = randint(10, 24)
        c = randint(10, 24)
        
        # For a tangential quadrilateral: a + c = b + d
        d = a + c - b
        
        if d <= 0
            d = randint(10, 24)
        end
        
        perimeter = a + b + c + d
        
        d_obj = DiagramObj(width=500, height=500)
        cx, cy = 250, 250
        circle!(d_obj, cx, cy, 150, stroke="blue", stroke_width=2, fill="none")
        
        # Quadrilateral vertices on circle
        theta1 = 20
        theta2 = 110
        theta3 = 200
        theta4 = 290
        
        x1 = cx + 150 * cosd(theta1)
        y1 = cy - 150 * sind(theta1)
        x2 = cx + 150 * cosd(theta2)
        y2 = cy - 150 * sind(theta2)
        x3 = cx + 150 * cosd(theta3)
        y3 = cy - 150 * sind(theta3)
        x4 = cx + 150 * cosd(theta4)
        y4 = cy - 150 * sind(theta4)
        
        polygon!(d_obj, [x1, x2, x3, x4], [y1, y2, y3, y4], stroke="black", stroke_width=2, fill="none")
        
        point!(d_obj, x1, y1, label="A", label_pos="right")
        point!(d_obj, x2, y2, label="B", label_pos="left")
        point!(d_obj, x3, y3, label="C", label_pos="left")
        point!(d_obj, x4, y4, label="D", label_pos="right")
        
        segment_label!(d_obj, x1, y1, x2, y2, "$(a)", offset=15)
        segment_label!(d_obj, x2, y2, x3, y3, "$(b)", offset=15)
        segment_label!(d_obj, x3, y3, x4, y4, "$(c)", offset=15)
        segment_label!(d_obj, x4, y4, x1, y1, "$(d)", offset=15)
        
        text!(d_obj, cx, cy-10, "O", font_size=14)
        point!(d_obj, cx, cy)
        
        problem(
            question="Cyclic quadrilateral ABCD is inscribed in a circle with center O and radius $(r). The sides are AB = $(a), BC = $(b), CD = $(c), and DA = $(d). A circle is inscribed in the quadrilateral (tangent to all four sides) if and only if the sum of opposite sides are equal. Verify this property holds and find the perimeter.",
            answer=perimeter,
            difficulty=(3000, 3400),
            solution=steps(
                "For a tangential quadrilateral, opposite sides satisfy: AB + CD = BC + DA",
                sol("Check", "$(a) + $(c) = $(a+c), $(b) + $(d) = $(b+d)"),
                "Property " * (a + c == b + d ? "holds" : "requires adjustment"),
                sol("Perimeter", "$(a) + $(b) + $(c) + $(d) = $(perimeter)")
            ),
            image=render(d_obj),
            time=300
        )
        
    elseif problem_type == 3
        # Competition: Pentagon with spiral perimeter construction
        # ELO 2600-3000
        s1 = randint(5, 15)
        ratio = rand([2, 3, 5])
        
        s2 = s1 * ratio
        s3 = s2 * ratio
        s4 = s3 * ratio
        s5 = s4 * ratio
        
        total_perimeter = s1 + s2 + s3 + s4 + s5
        
        d_obj = DiagramObj(width=600, height=500)
        
        x1, y1 = 100, 400
        x2, y2 = x1 + s1*10, y1
        x3, y3 = x2 + s2*10*0.3, y2 - s2*10*0.9
        x4, y4 = x3 - s3*10*0.6, y3 - s3*10*0.3
        x5, y5 = x4 - s4*10*0.5, y4 + s4*10*0.4
        
        polygon!(d_obj, [x1, x2, x3, x4, x5], [y1, y2, y3, y4, y5], stroke="black", stroke_width=2, fill="lightblue", fill_opacity=0.3)
        
        point!(d_obj, x1, y1, label="A")
        point!(d_obj, x2, y2, label="B")
        point!(d_obj, x3, y3, label="C")
        point!(d_obj, x4, y4, label="D")
        point!(d_obj, x5, y5, label="E")
        
        segment_label!(d_obj, x1, y1, x2, y2, "$(s1)", offset=-20)
        segment_label!(d_obj, x2, y2, x3, y3, "$(s2)", offset=15)
        segment_label!(d_obj, x3, y3, x4, y4, "$(s3)", offset=15)
        segment_label!(d_obj, x4, y4, x5, y5, "$(s4)", offset=15)
        segment_label!(d_obj, x5, y5, x1, y1, "$(s5)", offset=15)
        
        problem(
            question="Pentagon ABCDE has sides that form a geometric sequence. If AB = $(s1) and each subsequent side is $(ratio) times the previous side, find the perimeter of the pentagon.",
            answer=total_perimeter,
            difficulty=(2600, 3000),
            solution=steps(
                sol("Sides", "AB = $(s1), BC = $(s2), CD = $(s3), DE = $(s4), EA = $(s5)"),
                "Each side is $(ratio) times the previous: geometric sequence with ratio $(ratio)",
                sol("Sum", "$(s1) + $(s2) + $(s3) + $(s4) + $(s5)"),
                sol("Perimeter", total_perimeter)
            ),
            image=render(d_obj),
            time=200
        )
        
    else
        # Olympiad: Triangle with special cevian and perimeter optimization
        # ELO 3200-3500
        a = randint(12, 25)
        b = randint(12, 25)
        
        # Ensure triangle inequality with tight constraint
        c = randint(max(abs(a-b)+1, 10), min(a+b-1, 30))
        
        # Stewart's theorem application
        m = randint(5, 15)  # cevian length
        
        perimeter = a + b + c
        semiperimeter = perimeter // 2
        
        # Using Heron's formula for area
        s = perimeter / 2
        area_squared = s * (s - a) * (s - b) * (s - c)
        
        d_obj = DiagramObj(width=550, height=450)
        
        Ax, Ay = 100, 380
        Bx, By = 450, 380
        Cx, Cy = 200 + rand(50:150), 100
        
        # Median from A to midpoint M of BC
        Mx = (Bx + Cx) / 2
        My = (By + Cy) / 2
        
        line!(d_obj, Ax, Ay, Bx, By, stroke="black", stroke_width=2)
        line!(d_obj, Bx, By, Cx, Cy, stroke="black", stroke_width=2)
        line!(d_obj, Cx, Cy, Ax, Ay, stroke="black", stroke_width=2)
        line!(d_obj, Ax, Ay, Mx, My, stroke="red", stroke_width=2, stroke_dasharray="5,5")
        
        point!(d_obj, Ax, Ay, label="A", label_pos="below")
        point!(d_obj, Bx, By, label="B", label_pos="below")
        point!(d_obj, Cx, Cy, label="C", label_pos="above")
        point!(d_obj, Mx, My, label="M", label_pos="right")
        
        segment_label!(d_obj, Cx, Cy, Ax, Ay, "$(b)", offset=15)
        segment_label!(d_obj, Ax, Ay, Bx, By, "$(a)", offset=-20)
        segment_label!(d_obj, Bx, By, Cx, Cy, "$(c)", offset=15)
        segment_label!(d_obj, Ax, Ay, Mx, My, "m", offset=-15)
        
        # Median length formula: m_a^2 = (2b^2 + 2c^2 - a^2)/4
        median_squared_formula = (2*b^2 + 2*c^2 - a^2) // 4
        
        problem(
            question="In triangle ABC with sides AB = $(a), BC = $(c), and CA = $(b), let M be the midpoint of BC. The median AM has length m. Using the median length formula m² = (2b² + 2c² - a²)/4, find the perimeter of triangle ABC given that 4m² = $(4*median_squared_formula).",
            answer=perimeter,
            difficulty=(3200, 3500),
            solution=steps(
                sol("Median formula", "m² = (2b² + 2c² - a²)/4"),
                "Substitute: 4m² = 2($(b))² + 2($(c))² - ($(a))² = $(4*median_squared_formula)",
                sol("Sides verified", "a = $(a), b = $(b), c = $(c)"),
                sol("Perimeter", "$(a) + $(b) + $(c) = $(perimeter)")
            ),
            image=render(d_obj),
            time=300
        )
    end
end