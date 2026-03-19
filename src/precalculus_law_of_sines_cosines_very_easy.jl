# precalculus - law_of_sines_cosines (very_easy)
# Generated: 2026-03-08T20:31:29.932231

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("precalculus/law_of_sines_cosines")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Simple Law of Sines identification (ELO 200-400)
        a = randint(5, 15)
        A_deg = randint(30, 80)
        b = randint(5, 15)
        
        problem(
            question="In triangle ABC, if side a = $(a), angle A = $(A_deg)°, and side b = $(b), which equation correctly applies the Law of Sines to find angle B?",
            answer="\\frac{\\sin(B)}{$(b)} = \\frac{\\sin($(A_deg)°)}{$(a)}",
            difficulty=(200, 400),
            answer_type="expression",
            solution=steps(
                "The Law of Sines states: \\(\\frac{a}{\\sin(A)} = \\frac{b}{\\sin(B)} = \\frac{c}{\\sin(C)}\\)",
                "Given: a = $(a), A = $(A_deg)°, b = $(b)",
                sol("Answer", "\\frac{\\sin(B)}{$(b)} = \\frac{\\sin($(A_deg)°)}{$(a)}")
            ),
            calculator="none",
            time=45
        )
        
    elseif problem_type == 2
        # Simple Law of Cosines identification (ELO 300-500)
        a = randint(6, 12)
        b = randint(6, 12)
        C_deg = randint(40, 100)
        
        problem(
            question="In triangle ABC, if side a = $(a), side b = $(b), and angle C = $(C_deg)°, which equation correctly applies the Law of Cosines to find side c?",
            answer="c^2 = $(a)^2 + $(b)^2 - 2($(a))($(b))\\cos($(C_deg)°)",
            difficulty=(300, 500),
            answer_type="expression",
            solution=steps(
                "The Law of Cosines states: \\(c^2 = a^2 + b^2 - 2ab\\cos(C)\\)",
                "Given: a = $(a), b = $(b), C = $(C_deg)°",
                sol("Answer", "c^2 = $(a)^2 + $(b)^2 - 2($(a))($(b))\\cos($(C_deg)°)")
            ),
            calculator="none",
            time=50
        )
        
    elseif problem_type == 3
        # Direct calculation with Law of Sines (ELO 400-600)
        a = randint(8, 20)
        A_deg = choice([30, 45, 60])  # Use special angles
        B_deg = choice([30, 45, 60])
        
        # Calculate b using Law of Sines
        sin_A = sind(A_deg)
        sin_B = sind(B_deg)
        b_exact = round(a * sin_B / sin_A, digits=2)
        
        problem(
            question="In triangle ABC, if side a = $(a), angle A = $(A_deg)°, and angle B = $(B_deg)°, find the length of side b. Round to two decimal places.",
            answer=b_exact,
            difficulty=(400, 600),
            solution=steps(
                "Apply Law of Sines: \\(\\frac{a}{\\sin(A)} = \\frac{b}{\\sin(B)}\\)",
                "Substitute: \\(\\frac{$(a)}{\\sin($(A_deg)°)} = \\frac{b}{\\sin($(B_deg)°)}\\)",
                "Solve: \\(b = $(a) \\cdot \\frac{\\sin($(B_deg)°)}{\\sin($(A_deg)°)}\\)",
                sol("Answer", b_exact)
            ),
            calculator="scientific",
            time=90
        )
        
    else
        # Direct calculation with Law of Cosines (ELO 500-700)
        a = randint(5, 12)
        b = randint(5, 12)
        C_deg = choice([60, 90, 120])  # Use special angles for cleaner arithmetic
        
        # Calculate c using Law of Cosines
        cos_C = cosd(C_deg)
        c_squared = a^2 + b^2 - 2*a*b*cos_C
        c_exact = round(sqrt(c_squared), digits=2)
        
        problem(
            question="In triangle ABC, if side a = $(a), side b = $(b), and angle C = $(C_deg)°, find the length of side c. Round to two decimal places.",
            answer=c_exact,
            difficulty=(500, 700),
            solution=steps(
                "Apply Law of Cosines: \\(c^2 = a^2 + b^2 - 2ab\\cos(C)\\)",
                "Substitute: \\(c^2 = $(a)^2 + $(b)^2 - 2($(a))($(b))\\cos($(C_deg)°)\\)",
                "Calculate: \\(c^2 = $(a^2) + $(b^2) - $(2*a*b) \\cdot $(cos_C) = $(c_squared)\\)",
                sol("Answer", "c = \\sqrt{$(c_squared)} \\approx $(c_exact)")
            ),
            calculator="scientific",
            time=120
        )
    end
end