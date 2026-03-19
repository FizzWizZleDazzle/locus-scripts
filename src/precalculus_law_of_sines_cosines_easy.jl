# precalculus - law_of_sines_cosines (easy)
# Generated: 2026-03-08T20:31:54.511086

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/law_of_sines_cosines")
    
    problem_type = choice([:law_of_sines_asa, :law_of_sines_aas, :law_of_cosines_sas, :law_of_cosines_sss])
    
    if problem_type == :law_of_sines_asa
        # Given two angles and included side, find another side
        # ASA: angle-side-angle
        angle_A = randint(25, 80)
        angle_B = randint(25, 80)
        angle_C = 180 - angle_A - angle_B
        
        # Make sure triangle is valid
        if angle_C <= 0 || angle_C >= 180
            angle_B = randint(25, 180 - angle_A - 10)
            angle_C = 180 - angle_A - angle_B
        end
        
        side_b = randint(8, 25)
        
        # Use law of sines: a/sin(A) = b/sin(B)
        # a = b * sin(A) / sin(B)
        sin_A = sin(deg2rad(angle_A))
        sin_B = sin(deg2rad(angle_B))
        side_a = side_b * sin_A / sin_B
        
        ans = round(side_a, digits=2)
        
        problem(
            question="In triangle ABC, angle A = $(angle_A)°, angle B = $(angle_B)°, and side b = $(side_b). Find the length of side a. Round to two decimal places.",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Given: ∠A = $(angle_A)°, ∠B = $(angle_B)°, b = $(side_b)",
                "Find ∠C = 180° - $(angle_A)° - $(angle_B)° = $(angle_C)°",
                "Use Law of Sines: \\frac{a}{\\sin A} = \\frac{b}{\\sin B}",
                "a = b \\cdot \\frac{\\sin A}{\\sin B} = $(side_b) \\cdot \\frac{\\sin $(angle_A)°}{\\sin $(angle_B)°}",
                sol("Answer", ans)
            ),
            calculator="scientific",
            time=90
        )
        
    elseif problem_type == :law_of_sines_aas
        # Given two angles and non-included side, find another side
        # AAS: angle-angle-side
        angle_A = randint(30, 75)
        angle_B = randint(30, 75)
        angle_C = 180 - angle_A - angle_B
        
        if angle_C <= 0 || angle_C >= 180
            angle_B = randint(30, 180 - angle_A - 10)
            angle_C = 180 - angle_A - angle_B
        end
        
        side_a = randint(10, 30)
        
        # Find side c using law of sines: c/sin(C) = a/sin(A)
        sin_A = sin(deg2rad(angle_A))
        sin_C = sin(deg2rad(angle_C))
        side_c = side_a * sin_C / sin_A
        
        ans = round(side_c, digits=2)
        
        problem(
            question="In triangle ABC, angle A = $(angle_A)°, angle B = $(angle_B)°, and side a = $(side_a). Find the length of side c. Round to two decimal places.",
            answer=ans,
            difficulty=(750, 950),
            solution=steps(
                "Given: ∠A = $(angle_A)°, ∠B = $(angle_B)°, a = $(side_a)",
                "Find ∠C = 180° - $(angle_A)° - $(angle_B)° = $(angle_C)°",
                "Use Law of Sines: \\frac{c}{\\sin C} = \\frac{a}{\\sin A}",
                "c = a \\cdot \\frac{\\sin C}{\\sin A} = $(side_a) \\cdot \\frac{\\sin $(angle_C)°}{\\sin $(angle_A)°}",
                sol("Answer", ans)
            ),
            calculator="scientific",
            time=90
        )
        
    elseif problem_type == :law_of_cosines_sas
        # Given two sides and included angle, find third side
        # SAS: side-angle-side
        side_a = randint(8, 20)
        side_b = randint(8, 20)
        angle_C = randint(35, 120)
        
        # Use law of cosines: c² = a² + b² - 2ab*cos(C)
        cos_C = cos(deg2rad(angle_C))
        c_squared = side_a^2 + side_b^2 - 2*side_a*side_b*cos_C
        side_c = sqrt(c_squared)
        
        ans = round(side_c, digits=2)
        
        problem(
            question="In triangle ABC, side a = $(side_a), side b = $(side_b), and angle C = $(angle_C)°. Find the length of side c. Round to two decimal places.",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Given: a = $(side_a), b = $(side_b), ∠C = $(angle_C)°",
                "Use Law of Cosines: c² = a² + b² - 2ab\\cos C",
                "c² = $(side_a)² + $(side_b)² - 2($(side_a))($(side_b))\\cos $(angle_C)°",
                "c² = $(side_a^2) + $(side_b^2) - $(2*side_a*side_b)\\cos $(angle_C)°",
                "c = \\sqrt{c²}",
                sol("Answer", ans)
            ),
            calculator="scientific",
            time=120
        )
        
    else  # law_of_cosines_sss
        # Given three sides, find an angle
        # SSS: side-side-side
        side_a = randint(8, 18)
        side_b = randint(8, 18)
        side_c = randint(8, 18)
        
        # Ensure triangle inequality
        if side_a + side_b <= side_c || side_a + side_c <= side_b || side_b + side_c <= side_a
            side_c = randint(max(abs(side_a - side_b) + 1, 8), side_a + side_b - 1)
        end
        
        # Use law of cosines: cos(C) = (a² + b² - c²) / (2ab)
        cos_C = (side_a^2 + side_b^2 - side_c^2) / (2 * side_a * side_b)
        
        # Ensure valid cosine value
        if cos_C < -1 || cos_C > 1
            cos_C = max(-1, min(1, cos_C))
        end
        
        angle_C = rad2deg(acos(cos_C))
        
        ans = round(angle_C, digits=2)
        
        problem(
            question="In triangle ABC, side a = $(side_a), side b = $(side_b), and side c = $(side_c). Find the measure of angle C in degrees. Round to two decimal places.",
            answer=ans,
            difficulty=(850, 1100),
            solution=steps(
                "Given: a = $(side_a), b = $(side_b), c = $(side_c)",
                "Use Law of Cosines: \\cos C = \\frac{a² + b² - c²}{2ab}",
                "\\cos C = \\frac{$(side_a)² + $(side_b)² - $(side_c)²}{2($(side_a))($(side_b))}",
                "\\cos C = \\frac{$(side_a^2) + $(side_b^2) - $(side_c^2)}{$(2*side_a*side_b)}",
                "C = \\cos^{-1}(\\cos C)",
                sol("Answer", "$(ans)°")
            ),
            calculator="scientific",
            time=120
        )
    end
end