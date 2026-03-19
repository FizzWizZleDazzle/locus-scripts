# geometry - similar_triangles (competition)
# Generated: 2026-03-08T20:05:41.869115

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/similar_triangles")
    
    # Problem type selection
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Advanced angle chasing with similar triangles in a cyclic configuration
        # ELO: 3500-3800
        
        # Create a complex configuration: triangle ABC with cevians creating similar triangles
        a_len = randint(8, 15)
        b_len = randint(8, 15)
        ratio = choice([2//3, 3//4, 4//5, 5//6])
        
        # Point D on AB such that triangles are similar
        d_pos = ratio
        
        # Angle setup for similarity
        angle_A = randint(40, 70)
        angle_BCD = angle_A  # Key similarity condition
        
        # Compute other angles
        angle_ABC = randint(50, 80)
        angle_ACB = 180 - angle_A - angle_ABC
        
        # The target is to find a specific length using similarity
        target_segment = (a_len * b_len * sin(deg2rad(angle_A))) / (a_len + b_len * d_pos)
        target_segment = round(target_segment, digits=3)
        
        d = DiagramObj(600, 500)
        
        # Draw main triangle ABC
        A = (100, 400)
        B = (500, 400)
        C = (250, 100)
        
        polygon!(d, [A, B, C], stroke="black", stroke_width=2, fill="none")
        
        # Point D on AB
        D = (A[1] + (B[1] - A[1]) * Float64(d_pos), A[2])
        
        # Draw cevian CD
        line!(d, C, D, stroke="blue", stroke_width=2)
        
        # Additional construction: point E on AC
        E_param = ratio
        E = (A[1] + (C[1] - A[1]) * Float64(E_param), A[2] + (C[2] - A[2]) * Float64(E_param))
        
        line!(d, B, E, stroke="blue", stroke_width=2)
        
        # Intersection point P
        P = (300, 280)
        
        # Label points
        point!(d, A..., label="A", label_offset=(-15, 5))
        point!(d, B..., label="B", label_offset=(10, 5))
        point!(d, C..., label="C", label_offset=(0, -15))
        point!(d, D..., label="D", label_offset=(0, 15))
        point!(d, E..., label="E", label_offset=(-15, -5))
        point!(d, P..., label="P", label_offset=(10, -10))
        
        # Label sides
        segment_label!(d, A, B, "$(a_len)", offset=15)
        segment_label!(d, A, C, "$(b_len)", offset=-15)
        
        # Mark angles
        angle_arc!(d, B, A, C, radius=30, label="$(angle_A)°")
        angle_arc!(d, C, B, A, radius=30, label="$(angle_ABC)°")
        
        question_text = "In triangle ABC, AB = $(a_len) and AC = $(b_len). Point D lies on AB such that AD:DB = $(numerator(ratio)):$(denominator(ratio) - numerator(ratio)). Point E lies on AC such that AE:EC = $(numerator(ratio)):$(denominator(ratio) - numerator(ratio)). If ∠BAC = $(angle_A)° and ∠ABC = $(angle_ABC)°, and cevians CD and BE intersect at point P, prove that triangles ADE and ABC are similar, and find the ratio of their areas."
        
        area_ratio = Float64(ratio^2)
        
        problem(
            question=question_text,
            answer=round(area_ratio, digits=4),
            difficulty=(3500, 3800),
            solution=steps(
                "Given: AB = $(a_len), AC = $(b_len), AD:DB = $(numerator(ratio)):$(denominator(ratio) - numerator(ratio)), AE:EC = $(numerator(ratio)):$(denominator(ratio) - numerator(ratio))",
                "Since AD/AB = AE/AC = $(Float64(ratio)) and ∠DAE = ∠BAC (common angle), triangles ADE and ABC are similar by SAS similarity",
                "The ratio of similarity is k = $(Float64(ratio))",
                "The ratio of areas equals k² = $(Float64(ratio))² = $(round(area_ratio, digits=4))",
                sol("Area ratio", area_ratio)
            ),
            image=render(d),
            time=300
        )
        
    elseif problem_type == 2
        # Menelaus theorem with similar triangles - USAMO level
        # ELO: 3700-4000
        
        # Create configuration with transversal
        a = randint(10, 18)
        b = randint(10, 18)
        c = randint(10, 18)
        
        # Ratios for Menelaus
        r1 = choice([2//3, 3//5, 4//7])
        r2 = choice([3//4, 5//6, 7//8])
        
        # Menelaus theorem: (BD/DC) * (CE/EA) * (AF/FB) = 1
        r3 = 1 // (r1 * r2)
        
        target_ratio = Float64(r3)
        
        d = DiagramObj(600, 550)
        
        # Triangle ABC
        A = (100, 450)
        B = (500, 450)
        C = (300, 100)
        
        polygon!(d, [A, B, C], stroke="black", stroke_width=2.5, fill="none")
        
        # Point D on BC
        D_param = Float64(r1) / (1 + Float64(r1))
        D = (B[1] + (C[1] - B[1]) * D_param, B[2] + (C[2] - B[2]) * D_param)
        
        # Point E on CA
        E_param = Float64(r2) / (1 + Float64(r2))
        E = (C[1] + (A[1] - C[1]) * E_param, C[2] + (A[2] - C[2]) * E_param)
        
        # Point F on AB (extended if needed)
        F_param = Float64(r3) / (1 + Float64(r3))
        F = (A[1] + (B[1] - A[1]) * F_param, A[2])
        
        # Draw transversal through D, E, F
        line!(d, D, F, stroke="red", stroke_width=2, stroke_dasharray="5,5")
        line!(d, E, F, stroke="red", stroke_width=2, stroke_dasharray="5,5")
        
        # Label points
        point!(d, A..., label="A", label_offset=(-15, 5))
        point!(d, B..., label="B", label_offset=(15, 5))
        point!(d, C..., label="C", label_offset=(0, -15))
        point!(d, D..., label="D", label_offset=(10, -10))
        point!(d, E..., label="E", label_offset=(-15, 0))
        point!(d, F..., label="F", label_offset=(0, 15))
        
        # Label sides
        segment_label!(d, A, B, "c = $(c)", offset=15)
        segment_label!(d, B, C, "a = $(a)", offset=15)
        segment_label!(d, C, A, "b = $(b)", offset=-15)
        
        question_text = "In triangle ABC with sides BC = a = $(a), CA = b = $(b), and AB = c = $(c), a transversal line intersects BC at D, CA at E, and AB at F. Given that BD:DC = $(numerator(r1)):$(denominator(r1)) and CE:EA = $(numerator(r2)):$(denominator(r2)), use Menelaus' theorem to find the ratio AF:FB."
        
        problem(
            question=question_text,
            answer=round(target_ratio, digits=4),
            difficulty=(3700, 4000),
            solution=steps(
                "By Menelaus' theorem for triangle ABC and transversal DEF: (BD/DC) · (CE/EA) · (AF/FB) = 1",
                sol("Substituting known ratios", "($(numerator(r1))/$(denominator(r1))) · ($(numerator(r2))/$(denominator(r2))) · (AF/FB) = 1"),
                "Solving: AF/FB = 1/[($(numerator(r1))/$(denominator(r1))) · ($(numerator(r2))/$(denominator(r2)))]",
                sol("AF/FB = ", round(target_ratio, digits=4))
            ),
            image=render(d),
            time=360
        )
        
    elseif problem_type == 3
        # Spiral similarity with complex ratio computation
        # ELO: 3800-4200
        
        k = choice([sqrt(2), sqrt(3), (1 + sqrt(5))/2])
        theta = choice([30, 45, 60])
        
        side1 = randint(6, 12)
        
        # After spiral similarity
        side2 = side1 * Float64(k)
        
        # Distance between corresponding points
        dist = sqrt(side1^2 + side2^2 - 2*side1*side2*cos(deg2rad(theta)))
        
        d = DiagramObj(600, 600)
        
        # Original triangle
        A1 = (150, 400)
        B1 = (150 + side1 * 30, 400)
        C1 = (150 + side1 * 15, 400 - side1 * 25)
        
        polygon!(d, [A1, B1, C1], stroke="blue", stroke_width=2, fill="lightblue", fill_opacity=0.3)
        
        # Rotated and scaled triangle (spiral similarity)
        center = (300, 300)
        angle_rad = deg2rad(theta)
        
        # Transform points
        transform_point(p, c, k, θ) = (
            c[1] + k * ((p[1] - c[1]) * cos(θ) - (p[2] - c[2]) * sin(θ)),
            c[2] + k * ((p[1] - c[1]) * sin(θ) + (p[2] - c[2]) * cos(θ))
        )
        
        A2 = transform_point(A1, center, Float64(k), angle_rad)
        B2 = transform_point(B1, center, Float64(k), angle_rad)
        C2 = transform_point(C1, center, Float64(k), angle_rad)
        
        polygon!(d, [A2, B2, C2], stroke="red", stroke_width=2, fill="lightcoral", fill_opacity=0.3)
        
        # Draw lines from center
        line!(d, center, A1, stroke="gray", stroke_width=1, stroke_dasharray="3,3")
        line!(d, center, A2, stroke="gray", stroke_width=1, stroke_dasharray="3,3")
        
        # Label points
        point!(d, A1..., label="A", label_offset=(-15, 0))
        point!(d, B1..., label="B", label_offset=(15, 0))
        point!(d, C1..., label="C", label_offset=(0, -15))
        point!(d, A2..., label="A'", label_offset=(-15, 0))
        point!(d, B2..., label="B'", label_offset=(15, 0))
        point!(d, C2..., label="C'", label_offset=(0, -15))
        point!(d, center..., label="O", label_offset=(-15, -15))
        
        text!(d, 200, 50, "Spiral Similarity: k = $(round(Float64(k), digits=3)), θ = $(theta)°", font_size=16)
        
        k_str = k == sqrt(2) ? "√2" : (k == sqrt(3) ? "√3" : "φ")
        
        question_text = "Triangle ABC undergoes a spiral similarity centered at point O with ratio k = $(k_str) and rotation angle θ = $(theta)° to produce triangle A'B'C'. If AB = $(side1), find the exact value of k² + 2k·cos($(theta)°) + 1, which appears in the distance formula for corresponding points under spiral similarity."
        
        # The answer is related to |AA'|²/(AB)² 
        ans_value = Float64(k)^2 + 2*Float64(k)*cos(deg2rad(theta)) + 1
        
        problem(
            question=question_text,
            answer=round(ans_value, digits=4),
            difficulty=(3800, 4200),
            solution=steps(
                "For spiral similarity with ratio k and angle θ, the distance |AA'| from a point to its image satisfies: |AA'|² = |OA|²(k² - 2k·cos(θ) + 1)",
                "The expression k² + 2k·cos(θ) + 1 represents the squared distance ratio with modified sign",
                sol("Substituting k", "$(k_str)² + 2·$(k_str)·cos($(theta)°) + 1"),
                sol("Computing", "$(Float64(k)^2) + 2·$(Float64(k))·$(round(cos(deg2rad(theta)), digits=4)) + 1"),
                sol("Answer", round(ans_value, digits=4))
            ),
            image=render(d),
            time=420
        )
        
    else
        # Nested similar triangles with radical expressions - IMO level
        # ELO: 4000-4500
        
        n = choice([3, 4, 5])
        base_ratio = choice([1//2, 2//3, 3//4])
        
        initial_side = randint(16, 24)
        
        # Compute nested sum
        total_height = 0.0
        current = Float64(initial_side)
        for i in 1:n
            total_height += current * sqrt(3)/2
            current *= Float64(base_ratio)
        end
        
        # Geometric series formula for exact answer
        r = Float64(base_ratio)
        exact_sum = Float64(initial_side) * sqrt(3)/2 * (1 - r^n)/(1 - r)
        
        d = DiagramObj(600, 600)
        
        # Draw nested equilateral triangles
        y_offset = 500
        x_center = 300
        
        current_side = Float64(initial_side) * 20  # Scale for visualization
        
        for i in 1:n
            half_side = current_side / 2
            height = current_side * sqrt(3) / 2
            
            A = (x_center - half_side, y_offset)
            B = (x_center + half_side, y_offset)
            C = (x_center, y_offset - height)
            
            color = i == 1 ? "blue" : (i == 2 ? "green" : (i == 3 ? "red" : "purple"))
            
            polygon!(d, [50, 250, 150], [50, 250, 50], stroke="blue", stroke_width=2, fill="none")

            current_side *= Float64(base_ratio)
        end

        problem(
            question="$(n) similar triangles are nested with ratio $(Float64(base_ratio)). The outermost has side $(initial_side). Find the sum of all perimeters, rounded to 2 decimal places.",
            answer=round(exact_sum, digits=2),
            difficulty=(3500, 3900),
            solution=steps(
                "Perimeters form a geometric series with ratio $(Float64(base_ratio))",
                "Sum = $(initial_side)*3 * (1 - $(Float64(base_ratio))^$(n))/(1 - $(Float64(base_ratio)))",
                sol("Answer", round(exact_sum, digits=2))
            ),
            image=render(d),
            time=300
        )
    end
end
