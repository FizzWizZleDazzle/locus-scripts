# precalculus - law_of_sines_cosines (competition)
# Generated: 2026-03-08T20:32:38.009629

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/law_of_sines_cosines")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad-level: Triangle with constraints requiring deep law of cosines insight
        # Given: sides a, b and angle C, but with additional constraint that the triangle
        # has a special property (e.g., one angle is twice another)
        
        # Pick a clean configuration: angle B = 2*angle A
        angle_A_deg = randint(20, 40)
        angle_A = angle_A_deg * π / 180
        angle_B = 2 * angle_A
        angle_C = π - angle_A - angle_B
        angle_C_deg = round(Int, angle_C * 180 / π)
        
        # Choose side a (opposite to angle A)
        a = randint(15, 35)
        
        # Use law of sines: a/sin(A) = b/sin(B) = c/sin(C)
        k = a / sin(angle_A)
        b = k * sin(angle_B)
        c = k * sin(angle_C)
        
        # Now construct problem: given b, c, angle A, find a
        # This requires recognizing the double angle relationship
        
        b_rounded = round(b, digits=2)
        c_rounded = round(c, digits=2)
        a_answer = round(a, digits=2)
        
        question_text = "In triangle ABC, side b = $(b_rounded), side c = $(c_rounded), and angle A = $(angle_A_deg)°. Additionally, it is known that angle B = 2·angle A. Find the length of side a to two decimal places."
        
        solution_text = steps(
            "Given: b = $(b_rounded), c = $(c_rounded), ∠A = $(angle_A_deg)°, ∠B = 2∠A",
            "Since ∠B = 2∠A = $(round(Int, 2*angle_A_deg))°, we have ∠C = 180° - ∠A - ∠B = $(angle_C_deg)°",
            "Apply law of sines: \\(\\frac{a}{\\sin A} = \\frac{b}{\\sin B} = \\frac{c}{\\sin C}\\)",
            "From \\(\\frac{a}{\\sin $(angle_A_deg)°} = \\frac{$(b_rounded)}{\\sin $(round(Int, 2*angle_A_deg))°}\\)",
            "Using double angle formula: sin(2A) = 2sin(A)cos(A)",
            "Therefore: \\(a = \\frac{$(b_rounded) \\sin $(angle_A_deg)°}{2\\sin $(angle_A_deg)° \\cos $(angle_A_deg)°} = \\frac{$(b_rounded)}{2\\cos $(angle_A_deg)°}\\)",
            sol("Answer", "a ≈ $(a_answer)")
        )
        
        problem(
            question=question_text,
            answer=a_answer,
            difficulty=(3500, 4000),
            solution=solution_text,
            calculator="scientific",
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Cyclic quadrilateral with law of cosines
        # Given a cyclic quadrilateral ABCD, find diagonal using Ptolemy's theorem variant
        
        # For a cyclic quadrilateral, opposite angles sum to 180°
        angle_A_deg = randint(65, 95)
        angle_C_deg = 180 - angle_A_deg
        angle_B_deg = randint(70, 100)
        angle_D_deg = 180 - angle_B_deg
        
        # Choose sides
        a = randint(18, 28)  # side AB
        b = randint(20, 32)  # side BC
        c = randint(16, 26)  # side CD
        d = randint(22, 30)  # side DA
        
        angle_B_rad = angle_B_deg * π / 180
        angle_D_rad = angle_D_deg * π / 180
        
        # Find diagonal AC using law of cosines in triangle ABC
        AC_sq = a^2 + b^2 - 2*a*b*cos(angle_B_rad)
        AC = sqrt(AC_sq)
        
        # Find diagonal BD using law of cosines in triangle BCD
        angle_C_rad = angle_C_deg * π / 180
        BD_sq = b^2 + c^2 - 2*b*c*cos(angle_C_rad)
        BD = sqrt(BD_sq)
        
        AC_answer = round(AC, digits=2)
        BD_answer = round(BD, digits=2)
        
        question_text = "Cyclic quadrilateral ABCD has sides AB = $(a), BC = $(b), CD = $(c), DA = $(d). Angle ABC = $(angle_B_deg)° and angle CDA = $(angle_D_deg)°. Find the length of diagonal AC to two decimal places."
        
        solution_text = steps(
            "Given: Cyclic quadrilateral with AB=$(a), BC=$(b), CD=$(c), DA=$(d)",
            "∠ABC = $(angle_B_deg)°, ∠CDA = $(angle_D_deg)°",
            "In cyclic quadrilateral, opposite angles sum to 180°, so ∠DAB = $(angle_A_deg)°, ∠BCD = $(angle_C_deg)°",
            "Apply law of cosines in triangle ABC:",
            "\\(AC^2 = AB^2 + BC^2 - 2 \\cdot AB \\cdot BC \\cdot \\cos(\\angle ABC)\\)",
            "\\(AC^2 = $(a)^2 + $(b)^2 - 2($(a))($(b))\\cos($(angle_B_deg)°)\\)",
            "\\(AC^2 = $(a^2) + $(b^2) - $(2*a*b)\\cos($(angle_B_deg)°)\\)",
            sol("Answer", "AC ≈ $(AC_answer)")
        )
        
        problem(
            question=question_text,
            answer=AC_answer,
            difficulty=(3800, 4300),
            solution=solution_text,
            calculator="scientific",
            time=360
        )
        
    elseif problem_type == 3
        # Olympiad: Proving identity using law of sines/cosines
        # Given triangle with specific angle relationship, prove area formula variant
        
        # Triangle with angles A, B, C where C = 90° - A/2
        angle_A_deg = randint(40, 80)
        angle_A_rad = angle_A_deg * π / 180
        angle_C_rad = π/2 - angle_A_rad/2
        angle_B_rad = π - angle_A_rad - angle_C_rad
        
        angle_B_deg = round(Int, angle_B_rad * 180 / π)
        angle_C_deg = round(Int, angle_C_rad * 180 / π)
        
        # Given side a, find the ratio b²/c²
        # Using law of sines: a/sin(A) = b/sin(B) = c/sin(C)
        # b/c = sin(B)/sin(C)
        
        ratio_val = (sin(angle_B_rad) / sin(angle_C_rad))^2
        ratio_answer = round(ratio_val, digits=3)
        
        question_text = "In triangle ABC, angle A = $(angle_A_deg)° and angle C = 90° - A/2. Express the ratio \\(\\frac{b^2}{c^2}\\) in terms of the given angles, where b and c are the sides opposite to angles B and C respectively. Calculate the numerical value to three decimal places."
        
        solution_text = steps(
            "Given: ∠A = $(angle_A_deg)°, ∠C = 90° - A/2 = $(angle_C_deg)°",
            "Therefore: ∠B = 180° - A - C = $(angle_B_deg)°",
            "By law of sines: \\(\\frac{b}{\\sin B} = \\frac{c}{\\sin C}\\)",
            "Thus: \\(\\frac{b}{c} = \\frac{\\sin B}{\\sin C} = \\frac{\\sin $(angle_B_deg)°}{\\sin $(angle_C_deg)°}\\)",
            "Squaring both sides:",
            "\\(\\frac{b^2}{c^2} = \\left(\\frac{\\sin $(angle_B_deg)°}{\\sin $(angle_C_deg)°}\\right)^2\\)",
            sol("Answer", "\\(\\frac{b^2}{c^2}\\) ≈ $(ratio_answer)")
        )
        
        problem(
            question=question_text,
            answer=ratio_answer,
            difficulty=(3600, 4100),
            solution=solution_text,
            calculator="scientific",
            time=300
        )
        
    else
        # Research-adjacent: Generalized law of cosines with constraint optimization
        # Find maximum area of triangle with two sides and constraint on third side
        
        side_a = randint(25, 45)
        side_b = randint(30, 50)
        
        # For maximum area with fixed sides a and b, angle C should be 90°
        # But we add constraint: side c must satisfy certain relationship
        
        # Maximum area when C = 90°
        max_area = side_a * side_b / 2
        
        # But ask: what is the area when the angle C is such that c = a + b - k for some k
        k = randint(15, 25)
        target_c = side_a + side_b - k
        
        # Use law of cosines to find angle C: c² = a² + b² - 2ab·cos(C)
        # cos(C) = (a² + b² - c²)/(2ab)
        cos_C = (side_a^2 + side_b^2 - target_c^2) / (2 * side_a * side_b)
        
        # Clamp to valid range
        if cos_C > 1
            cos_C = 0.99
        elseif cos_C < -1
            cos_C = -0.99
        end
        
        angle_C_rad = acos(cos_C)
        
        # Area = (1/2)ab·sin(C)
        area_val = 0.5 * side_a * side_b * sin(angle_C_rad)
        area_answer = round(area_val, digits=2)
        
        question_text = "A triangle has two sides of length a = $(side_a) and b = $(side_b). The third side c satisfies the constraint c = a + b - $(k). Find the area of this triangle to two decimal places."
        
        solution_text = steps(
            "Given: a = $(side_a), b = $(side_b), c = a + b - $(k) = $(target_c)",
            "Use law of cosines to find angle C (opposite to side c):",
            "\\(c^2 = a^2 + b^2 - 2ab\\cos C\\)",
            "\\(\\cos C = \\frac{a^2 + b^2 - c^2}{2ab} = \\frac{$(side_a^2) + $(side_b^2) - $(target_c^2)}{$(2*side_a*side_b)}\\)",
            "\\(\\cos C = $(round(cos_C, digits=4))\\)",
            "\\(\\sin C = \\sqrt{1 - \\cos^2 C}\\)",
            "Area = \\(\\frac{1}{2}ab\\sin C = \\frac{1}{2}($(side_a))($(side_b))\\sin C\\)",
            sol("Answer", "Area ≈ $(area_answer)")
        )
        
        problem(
            question=question_text,
            answer=area_answer,
            difficulty=(4000, 4500),
            solution=solution_text,
            calculator="scientific",
            time=360
        )
    end
end