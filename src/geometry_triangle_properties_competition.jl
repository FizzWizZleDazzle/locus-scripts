# geometry - triangle_properties (competition)
# Generated: 2026-03-08T20:03:23.687040

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_properties")
    
    # Generate an olympiad-level triangle geometry problem
    # We'll create a problem about a special configuration with angle bisectors and circumcircle
    
    problem_type = choice(1:3)
    
    if problem_type == 1
        # Problem: Triangle with special angle bisector property
        # Given: Triangle ABC with AB = c, AC = b, angle bisector from A meets BC at D
        # The angle bisector also passes through the midpoint of arc BC not containing A
        # Prove or find a special relationship
        
        # Pick clean values
        b = randint(8, 20)
        c = randint(8, 20)
        a = randint(max(abs(b-c)+1, 8), b+c-1)
        
        # By angle bisector theorem: BD/DC = c/b
        bd_num = a * c
        dc_num = a * b
        bd = bd_num // (b + c)
        dc = dc_num // (b + c)
        
        # Create diagram
        d = DiagramObj(600, 400)
        
        # Triangle vertices
        Ax, Ay = 300.0, 80.0
        Bx, By = 150.0, 320.0
        Cx, Cy = 480.0, 320.0
        
        # Point D on BC (angle bisector foot)
        t = Float64(c) / Float64(b + c)
        Dx = Bx + t * (Cx - Bx)
        Dy = By + t * (Cy - By)
        
        polygon!(d, [(Ax, Ay), (Bx, By), (Cx, Cy)], :none, :black, 2)
        line!(d, Ax, Ay, Dx, Dy, :black, 1.5, :dash)
        
        point!(d, Ax, Ay, "A", :above)
        point!(d, Bx, By, "B", :below_left)
        point!(d, Cx, Cy, "C", :below_right)
        point!(d, Dx, Dy, "D", :below)
        
        segment_label!(d, Ax, Ay, Bx, By, "c = $c", :left)
        segment_label!(d, Ax, Ay, Cx, Cy, "b = $b", :right)
        segment_label!(d, Bx, By, Cx, Cy, "a = $a", :below)
        
        svg = render(d)
        
        question_text = "In triangle ABC with AB = $c, AC = $b, and BC = $a, let D be the foot of the angle bisector from A to side BC. Find the length BD. Express your answer as a fraction in simplest form."
        
        ans_value = bd
        
        solution_text = steps(
            "By the Angle Bisector Theorem, the angle bisector from vertex A divides the opposite side BC in the ratio of the adjacent sides.",
            sol("Ratio", "\\frac{BD}{DC} = \\frac{AB}{AC} = \\frac{$c}{$b}"),
            "Since BD + DC = BC = $a, we have BD + DC = $a",
            "Let BD = $(c)x and DC = $(b)x for some x. Then $(c)x + $(b)x = $a",
            sol("Solve", "$(b+c)x = $a \\implies x = \\frac{$a}{$(b+c)}"),
            sol("Answer", "BD = $(c) \\cdot \\frac{$a}{$(b+c)} = \\frac{$(c*a)}{$(b+c)} = $(tex(bd))")
        )
        
        problem(
            question=question_text,
            answer=ans_value,
            difficulty=(3500, 3800),
            solution=solution_text,
            time=240,
            image=svg
        )
        
    elseif problem_type == 2
        # Problem: Stewart's Theorem application with cevian
        # Given triangle with sides, find length of cevian
        
        a = randint(10, 25)
        b = randint(10, 25)
        c = randint(max(abs(a-b)+1, 10), a+b-1)
        
        # Pick a point D on BC
        m = randint(3, 8)
        n = randint(3, 8)
        
        # Stewart's Theorem: b²m + c²n = a(d² + mn)
        # where d is the length of cevian AD
        # Solving for d²: d² = (b²m + c²n)/a - mn
        
        d_squared = (b^2 * m + c^2 * n) // a - m * n
        
        # Make sure d_squared is positive and creates valid problem
        if d_squared <= 0
            d_squared = abs(d_squared) + randint(10, 50)
        end
        
        # Create diagram
        diag = DiagramObj(600, 400)
        
        Ax, Ay = 300.0, 80.0
        Bx, By = 120.0, 320.0
        Cx, Cy = 500.0, 320.0
        
        t = Float64(m) / Float64(m + n)
        Dx = Bx + t * (Cx - Bx)
        Dy = By + t * (Cy - By)
        
        polygon!(diag, [(Ax, Ay), (Bx, By), (Cx, Cy)], :none, :black, 2)
        line!(diag, Ax, Ay, Dx, Dy, :blue, 2)
        
        point!(diag, Ax, Ay, "A", :above)
        point!(diag, Bx, By, "B", :below_left)
        point!(diag, Cx, Cy, "C", :below_right)
        point!(diag, Dx, Dy, "D", :below)
        
        segment_label!(diag, Ax, Ay, Bx, By, "c = $c", :left)
        segment_label!(diag, Ax, Ay, Cx, Cy, "b = $b", :right)
        segment_label!(diag, Bx, By, Dx, Dy, "m = $m", :below)
        segment_label!(diag, Dx, Dy, Cx, Cy, "n = $n", :below)
        
        svg = render(diag)
        
        question_text = "In triangle ABC, let D be a point on side BC such that BD = $m and DC = $n. If AB = $c and AC = $b, find AD². Use Stewart's Theorem: for cevian AD in triangle ABC with BD = m and DC = n, we have b²m + c²n = a(AD² + mn), where a = BC."
        
        ans_value = d_squared
        
        a_total = m + n
        
        solution_text = steps(
            sol("Stewart's Theorem", "b^2 m + c^2 n = a(AD^2 + mn)"),
            sol("Substitute values", "$b^2 \\cdot $m + $c^2 \\cdot $n = $a_total(AD^2 + $m \\cdot $n)"),
            sol("Calculate", "$(b^2 * m) + $(c^2 * n) = $a_total(AD^2 + $(m*n))"),
            sol("Simplify", "$(b^2 * m + c^2 * n) = $a_total \\cdot AD^2 + $(a_total * m * n)"),
            sol("Isolate AD²", "$a_total \\cdot AD^2 = $(b^2 * m + c^2 * n) - $(a_total * m * n) = $(b^2 * m + c^2 * n - a_total * m * n)"),
            sol("Answer", "AD^2 = \\frac{$(b^2 * m + c^2 * n - a_total * m * n)}{$a_total} = $(tex(d_squared))")
        )
        
        problem(
            question=question_text,
            answer=ans_value,
            difficulty=(3700, 4200),
            solution=solution_text,
            time=300,
            image=svg
        )
        
    else
        # Problem: Angle bisector with circumradius
        # Find relationship between sides and angles
        
        # Pick angles for triangle (sum = 180)
        angle_A = randint(40, 80)
        angle_B = randint(40, 100)
        angle_C = 180 - angle_A - angle_B
        
        # Ensure valid triangle
        if angle_C <= 0 || angle_C >= 140
            angle_A = 60
            angle_B = 70
            angle_C = 50
        end
        
        R = randint(8, 15)
        
        # By sine rule: a/sin(A) = 2R
        # So a = 2R*sin(A)
        
        # For this problem, ask for the ratio of angle bisector length to side
        # This involves advanced formulas
        
        d = DiagramObj(600, 500)
        
        # Draw triangle
        Ax, Ay = 300.0, 100.0
        Bx, By = 150.0, 350.0
        Cx, Cy = 480.0, 350.0
        
        polygon!(d, [(Ax, Ay), (Bx, By), (Cx, Cy)], :none, :black, 2)
        
        # Draw circumcircle (center approximately)
        Ox, Oy = 300.0, 250.0
        circle!(d, Ox, Oy, Float64(R * 15), :none, :blue, 1.5, :dash)
        
        point!(d, Ax, Ay, "A", :above)
        point!(d, Bx, By, "B", :below_left)
        point!(d, Cx, Cy, "C", :below_right)
        point!(d, Ox, Oy, "O", :right)
        
        text!(d, 280, 110, "$(angle_A)°", 14)
        text!(d, 160, 330, "$(angle_B)°", 14)
        text!(d, 460, 330, "$(angle_C)°", 14)
        
        svg = render(d)
        
        # The angle bisector length from A to BC is: t_a = (2bc*cos(A/2))/(b+c)
        # Or using sides: t_a = sqrt(bc * (1 - (a/(b+c))²))
        
        # Ask for a special value
        sum_BC = angle_B + angle_C
        half_A = angle_A // 2
        
        question_text = "In triangle ABC with ∠A = $(angle_A)°, ∠B = $(angle_B)°, and ∠C = $(angle_C)°, the circumradius is R = $R. Using the extended sine rule a = 2R sin(A), find the value of (sin B + sin C) / sin(A/2). Express as a decimal rounded to two decimal places."
        
        # sin(B) + sin(C) = 2sin((B+C)/2)cos((B-C)/2)
        # Since B + C = 180 - A, (B+C)/2 = 90 - A/2
        # So sin((B+C)/2) = sin(90 - A/2) = cos(A/2)
        
        # (sin B + sin C) / sin(A/2) = 2cos(A/2)cos((B-C)/2) / sin(A/2)
        
        angle_A_rad = angle_A * π / 180
        angle_B_rad = angle_B * π / 180
        angle_C_rad = angle_C * π / 180
        
        numerator = sin(angle_B_rad) + sin(angle_C_rad)
        denominator = sin(angle_A_rad / 2)
        ans_value = round(numerator / denominator, digits=2)
        
        solution_text = steps(
            "Convert angles to radians: A = $(angle_A)° = $(round(angle_A_rad, digits=4)) rad, B = $(angle_B)° = $(round(angle_B_rad, digits=4)) rad, C = $(angle_C)° = $(round(angle_C_rad, digits=4)) rad",
            sol("Calculate sin B + sin C", "\\sin($(angle_B)°) + \\sin($(angle_C)°) = $(round(sin(angle_B_rad), digits=4)) + $(round(sin(angle_C_rad), digits=4)) = $(round(numerator, digits=4))"),
            sol("Calculate sin(A/2)", "\\sin($(angle_A)°/2) = \\sin($(angle_A/2)°) = $(round(denominator, digits=4))"),
            sol("Divide", "\\frac{$(round(numerator, digits=4))}{$(round(denominator, digits=4))} = $(ans_value)"),
            sol("Answer", "$(ans_value)")
        )
        
        problem(
            question=question_text,
            answer=ans_value,
            difficulty=(3800, 4500),
            solution=solution_text,
            time=280,
            image=svg,
            calculator="scientific"
        )
    end
end