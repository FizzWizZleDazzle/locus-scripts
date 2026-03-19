# precalculus - law_of_sines_cosines (medium)
# Generated: 2026-03-08T20:32:06.883014

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/law_of_sines_cosines")
    
    problem_type = choice([:law_of_sines_ASA, :law_of_sines_AAS, :law_of_cosines_SAS, :law_of_cosines_SSS, :ambiguous_case, :area_formula])
    
    if problem_type == :law_of_sines_ASA
        # Given two angles and included side, find another side
        angle_A = randint(25, 80)
        angle_B = randint(25, 80)
        angle_C = 180 - angle_A - angle_B
        
        if angle_C <= 0 || angle_C >= 180
            angle_B = randint(25, 180 - angle_A - 10)
            angle_C = 180 - angle_A - angle_B
        end
        
        side_b = randint(8, 25)
        
        # Using law of sines: a/sin(A) = b/sin(B)
        side_a = side_b * sind(angle_A) / sind(angle_B)
        
        problem(
            question="In triangle ABC, angle A = $(angle_A)°, angle B = $(angle_B)°, and side b = $(side_b). Find the length of side a. Round to two decimal places.",
            answer=round(side_a, digits=2),
            difficulty=(1200, 1400),
            solution=steps(
                "Given: ∠A = $(angle_A)°, ∠B = $(angle_B)°, b = $(side_b)",
                "Find ∠C = 180° - $(angle_A)° - $(angle_B)° = $(angle_C)°",
                "Use Law of Sines: \\(\\frac{a}{\\sin A} = \\frac{b}{\\sin B}\\)",
                sol("a = b \\cdot \\frac{\\sin A}{\\sin B} = $(side_b) \\cdot \\frac{\\sin $(angle_A)°}{\\sin $(angle_B)°}"),
                sol("Answer", round(side_a, digits=2))
            ),
            calculator="scientific",
            time=120
        )
        
    elseif problem_type == :law_of_sines_AAS
        # Given two angles and non-included side, find another side
        angle_A = randint(30, 75)
        angle_B = randint(30, 75)
        angle_C = 180 - angle_A - angle_B
        
        if angle_C <= 0 || angle_C >= 180
            angle_B = randint(30, 180 - angle_A - 20)
            angle_C = 180 - angle_A - angle_B
        end
        
        side_a = randint(10, 30)
        
        # Find side c using law of sines
        side_c = side_a * sind(angle_C) / sind(angle_A)
        
        problem(
            question="In triangle ABC, angle A = $(angle_A)°, angle C = $(angle_C)°, and side a = $(side_a). Find the length of side c. Round to two decimal places.",
            answer=round(side_c, digits=2),
            difficulty=(1200, 1400),
            solution=steps(
                "Given: ∠A = $(angle_A)°, ∠C = $(angle_C)°, a = $(side_a)",
                "Find ∠B = 180° - $(angle_A)° - $(angle_C)° = $(angle_B)°",
                "Use Law of Sines: \\(\\frac{a}{\\sin A} = \\frac{c}{\\sin C}\\)",
                sol("c = a \\cdot \\frac{\\sin C}{\\sin A} = $(side_a) \\cdot \\frac{\\sin $(angle_C)°}{\\sin $(angle_A)°}"),
                sol("Answer", round(side_c, digits=2))
            ),
            calculator="scientific",
            time=120
        )
        
    elseif problem_type == :law_of_cosines_SAS
        # Given two sides and included angle, find third side
        side_a = randint(8, 25)
        side_b = randint(8, 25)
        angle_C = randint(30, 150)
        
        # Law of cosines: c² = a² + b² - 2ab*cos(C)
        side_c_sq = side_a^2 + side_b^2 - 2*side_a*side_b*cosd(angle_C)
        side_c = sqrt(side_c_sq)
        
        problem(
            question="In triangle ABC, side a = $(side_a), side b = $(side_b), and angle C = $(angle_C)°. Find the length of side c. Round to two decimal places.",
            answer=round(side_c, digits=2),
            difficulty=(1300, 1500),
            solution=steps(
                "Given: a = $(side_a), b = $(side_b), ∠C = $(angle_C)°",
                "Use Law of Cosines: \\(c^2 = a^2 + b^2 - 2ab \\cos C\\)",
                sol("c^2 = $(side_a)^2 + $(side_b)^2 - 2($(side_a))($(side_b))\\cos $(angle_C)°"),
                sol("c^2 = $(round(side_c_sq, digits=2))"),
                sol("Answer: c", round(side_c, digits=2))
            ),
            calculator="scientific",
            time=150
        )
        
    elseif problem_type == :law_of_cosines_SSS
        # Given three sides, find an angle
        side_a = randint(10, 20)
        side_b = randint(10, 20)
        side_c = randint(abs(side_a - side_b) + 1, side_a + side_b - 1)
        
        # Law of cosines: cos(C) = (a² + b² - c²)/(2ab)
        cos_C = (side_a^2 + side_b^2 - side_c^2) / (2*side_a*side_b)
        angle_C = acosd(cos_C)
        
        problem(
            question="In triangle ABC, side a = $(side_a), side b = $(side_b), and side c = $(side_c). Find the measure of angle C in degrees. Round to two decimal places.",
            answer=round(angle_C, digits=2),
            difficulty=(1400, 1600),
            solution=steps(
                "Given: a = $(side_a), b = $(side_b), c = $(side_c)",
                "Use Law of Cosines: \\(\\cos C = \\frac{a^2 + b^2 - c^2}{2ab}\\)",
                sol("\\cos C = \\frac{$(side_a)^2 + $(side_b)^2 - $(side_c)^2}{2($(side_a))($(side_b))}"),
                sol("\\cos C = $(round(cos_C, digits=4))"),
                sol("Answer: C = \\cos^{-1}($(round(cos_C, digits=4)))", round(angle_C, digits=2) * 1.0, "°")
            ),
            calculator="scientific",
            time=180
        )
        
    elseif problem_type == :ambiguous_case
        # SSA case - check for number of triangles
        side_a = randint(12, 25)
        angle_A = randint(25, 55)
        side_b = randint(floor(Int, side_a * sind(angle_A)) + 2, side_a - 2)
        
        # Calculate angle B using law of sines
        sin_B = side_b * sind(angle_A) / side_a
        
        if sin_B > 1
            side_b = randint(8, floor(Int, side_a * sind(angle_A)) - 1)
            sin_B = side_b * sind(angle_A) / side_a
        end
        
        angle_B1 = asind(sin_B)
        angle_B2 = 180 - angle_B1
        
        # Check if second triangle is valid
        angle_C2 = 180 - angle_A - angle_B2
        
        if angle_C2 > 0
            num_triangles = 2
            ans = 2
        else
            num_triangles = 1
            ans = 1
        end
        
        problem(
            question="In triangle ABC, side a = $(side_a), side b = $(side_b), and angle A = $(angle_A)°. How many distinct triangles can be formed with these measurements?",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Given: a = $(side_a), b = $(side_b), ∠A = $(angle_A)° (SSA case - ambiguous)",
                "Use Law of Sines: \\(\\frac{\\sin B}{b} = \\frac{\\sin A}{a}\\)",
                sol("\\sin B = \\frac{b \\sin A}{a} = \\frac{$(side_b) \\sin $(angle_A)°}{$(side_a)} = $(round(sin_B, digits=4))"),
                "∠B₁ = $(round(angle_B1, digits=2))°, ∠B₂ = $(round(angle_B2, digits=2))°",
                angle_C2 > 0 ? "Both angles yield valid triangles (∠C₂ = $(round(angle_C2, digits=2))° > 0)" : "Second angle invalid (∠C₂ would be negative)",
                sol("Answer", ans)
            ),
            calculator="scientific",
            time=180
        )
        
    else  # area_formula
        # Area using (1/2)ab*sin(C)
        side_a = randint(8, 30)
        side_b = randint(8, 30)
        angle_C = randint(25, 155)
        
        area = 0.5 * side_a * side_b * sind(angle_C)
        
        problem(
            question="Find the area of triangle ABC if side a = $(side_a), side b = $(side_b), and angle C = $(angle_C)°. Round to two decimal places.",
            answer=round(area, digits=2),
            difficulty=(1300, 1500),
            solution=steps(
                "Given: a = $(side_a), b = $(side_b), ∠C = $(angle_C)°",
                "Use area formula: \\(\\text{Area} = \\frac{1}{2}ab\\sin C\\)",
                sol("\\text{Area} = \\frac{1}{2}($(side_a))($(side_b))\\sin $(angle_C)°"),
                sol("\\text{Area} = $(round(0.5 * side_a * side_b, digits=2)) \\cdot \\sin $(angle_C)°"),
                sol("Answer", round(area, digits=2))
            ),
            calculator="scientific",
            time=120
        )
    end
end