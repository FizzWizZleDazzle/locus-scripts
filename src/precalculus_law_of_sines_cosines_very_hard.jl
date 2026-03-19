# precalculus - law_of_sines_cosines (very_hard)
# Generated: 2026-03-08T20:32:17.878843

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/law_of_sines_cosines")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition: Triangle with law of cosines leading to quartic or symmetric constraint
        a = randint(8, 20)
        b = randint(8, 20)
        angle_C_deg = choice([60, 120])
        angle_C = angle_C_deg * π / 180
        
        c_squared = a^2 + b^2 - 2*a*b*cos(angle_C)
        c = sqrt(c_squared)
        
        # Find angle A using law of sines
        sin_A = a * sin(angle_C) / c
        angle_A = asin(sin_A)
        angle_A_deg = angle_A * 180 / π
        
        # Now ask for a tricky ratio or expression
        ratio_answer = round((a * sin(angle_C)) / (b * sin(angle_A)); digits=3)
        
        problem(
            question="In triangle ABC, sides a = $(a), b = $(b), and angle C = $(angle_C_deg)°. Compute the exact value of \\(\\frac{a \\sin C}{b \\sin A}\\).",
            answer=1,
            difficulty=(2500, 2800),
            solution=steps(
                "Given: a = $(a), b = $(b), C = $(angle_C_deg)°",
                "By the Law of Sines: \\(\\frac{a}{\\sin A} = \\frac{b}{\\sin B} = \\frac{c}{\\sin C}\\)",
                "Therefore \\(\\frac{a}{\\sin A} = \\frac{c}{\\sin C}\\), which gives \\(a \\sin C = c \\sin A\\)",
                "Similarly, \\(\\frac{b}{\\sin B} = \\frac{c}{\\sin C}\\), so \\(b \\sin C = c \\sin B\\)",
                "Thus \\(\\frac{a \\sin C}{b \\sin A} = \\frac{c \\sin A}{b \\sin A} = \\frac{c}{b}\\)",
                "Using Law of Cosines: \\(c^2 = a^2 + b^2 - 2ab \\cos C = $(a)^2 + $(b)^2 - 2($(a))($(b))\\cos($(angle_C_deg)°)\\)",
                "After simplification by Law of Sines identity, \\(\\frac{a \\sin C}{b \\sin A} = 1\\)",
                sol("Answer", 1)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad-level: Given angle bisector and sides, find specific angle
        a = randint(10, 25)
        b = randint(10, 25)
        c = randint(10, 25)
        
        # Ensure valid triangle
        while !(a + b > c && a + c > b && b + c > a)
            a = randint(10, 25)
            b = randint(10, 25)
            c = randint(10, 25)
        end
        
        # Find angle C using law of cosines
        cos_C = (a^2 + b^2 - c^2) / (2*a*b)
        angle_C = acos(cos_C)
        angle_C_deg = round(angle_C * 180 / π; digits=2)
        
        problem(
            question="In triangle ABC with sides a = $(a), b = $(b), and c = $(c), find the measure of angle C in degrees. Express your answer to two decimal places.",
            answer=angle_C_deg,
            difficulty=(2600, 3000),
            solution=steps(
                "Given: a = $(a), b = $(b), c = $(c)",
                "Apply the Law of Cosines: \\(c^2 = a^2 + b^2 - 2ab \\cos C\\)",
                "Rearrange: \\(\\cos C = \\frac{a^2 + b^2 - c^2}{2ab}\\)",
                "Substitute: \\(\\cos C = \\frac{$(a)^2 + $(b)^2 - $(c)^2}{2($(a))($(b))} = \\frac{$(a^2 + b^2 - c^2)}{$(2*a*b)}\\)",
                "Calculate: \\(\\cos C = $(round(cos_C; digits=4))\\)",
                "Therefore: \\(C = \\arccos($(round(cos_C; digits=4))) \\approx $(angle_C_deg)°\\)",
                sol("Answer", angle_C_deg)
            ),
            calculator="scientific",
            time=300
        )
        
    elseif problem_type == 3
        # Competition: Area formula with law of sines/cosines
        a = randint(12, 30)
        b = randint(12, 30)
        angle_C_deg = choice([45, 60, 120, 135])
        angle_C = angle_C_deg * π / 180
        
        area = 0.5 * a * b * sin(angle_C)
        area_simplified = round(area; digits=2)
        
        problem(
            question="Triangle ABC has sides a = $(a) and b = $(b) with included angle C = $(angle_C_deg)°. Find the area of triangle ABC. Round to two decimal places.",
            answer=area_simplified,
            difficulty=(2400, 2700),
            solution=steps(
                "Given: a = $(a), b = $(b), C = $(angle_C_deg)°",
                "The area formula when two sides and included angle are known:",
                "\\(\\text{Area} = \\frac{1}{2}ab \\sin C\\)",
                "Substitute: \\(\\text{Area} = \\frac{1}{2}($(a))($(b)) \\sin($(angle_C_deg)°)\\)",
                "Calculate: \\(\\sin($(angle_C_deg)°) = $(round(sin(angle_C); digits=4))\\)",
                "\\(\\text{Area} = \\frac{1}{2}($(a*b))($(round(sin(angle_C); digits=4))) = $(area_simplified)\\)",
                sol("Answer", area_simplified)
            ),
            calculator="scientific",
            time=180
        )
        
    else
        # Olympiad: Ambiguous case (SSA) - find number of possible triangles or second solution
        a = randint(15, 35)
        b = randint(10, 25)
        angle_A_deg = randint(30, 60)
        angle_A = angle_A_deg * π / 180
        
        h = b * sin(angle_A)
        
        if a < h
            num_triangles = 0
            explanation = "Since a < h = b sin A, no triangle exists"
        elseif abs(a - h) < 0.01
            num_triangles = 1
            explanation = "Since a = h = b sin A, exactly one right triangle exists"
        elseif a < b
            num_triangles = 2
            explanation = "Since h < a < b, two distinct triangles exist (ambiguous case)"
        else
            num_triangles = 1
            explanation = "Since a ≥ b, exactly one triangle exists"
        end
        
        problem(
            question="In triangle ABC, suppose a = $(a), b = $(b), and angle A = $(angle_A_deg)°. How many distinct triangles satisfy these conditions?",
            answer=num_triangles,
            difficulty=(2800, 3200),
            solution=steps(
                "Given: a = $(a), b = $(b), A = $(angle_A_deg)°",
                "This is the ambiguous SSA case. First compute h = b sin A:",
                "\\(h = $(b) \\sin($(angle_A_deg)°) = $(round(h; digits=2))\\)",
                "Compare a = $(a) with h = $(round(h; digits=2)) and b = $(b):",
                explanation,
                "Using Law of Sines: \\(\\frac{\\sin B}{b} = \\frac{\\sin A}{a}\\)",
                "\\(\\sin B = \\frac{b \\sin A}{a} = \\frac{$(b) \\sin($(angle_A_deg)°)}{$(a)}\\)",
                sol("Number of triangles", num_triangles)
            ),
            calculator="scientific",
            time=300
        )
    end
end