# arithmetic - decimals (very_easy)
# Generated: 2026-03-08T19:49:09.217066

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/decimals")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple decimal addition (ELO 200-400)
        a = round(rand() * 10, digits=1)
        b = round(rand() * 10, digits=1)
        ans = a + b
        problem(
            question="What is \$$(a) + $(b)\$?",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Add the decimals",
                "\$$(a) + $(b)\$",
                sol("Answer", ans)
            ),
            time=30
        )
    elseif problem_type == 2
        # Simple decimal subtraction (ELO 200-400)
        b = round(rand() * 10, digits=1)
        a = b + round(rand() * 10, digits=1)
        ans = a - b
        problem(
            question="What is \$$(a) - $(b)\$?",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Subtract the decimals",
                "\$$(a) - $(b)\$",
                sol("Answer", ans)
            ),
            time=30
        )
    elseif problem_type == 3
        # Decimal multiplication by whole number (ELO 400-600)
        a = round(rand() * 5 + 0.1, digits=2)
        b = randint(2, 9)
        ans = round(a * b, digits=2)
        problem(
            question="Calculate \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Multiply the decimal by the whole number",
                "\$$(a) \\times $(b)\$",
                sol("Answer", ans)
            ),
            time=45
        )
    elseif problem_type == 4
        # Two decimal addition (ELO 300-500)
        a = round(rand() * 20, digits=2)
        b = round(rand() * 20, digits=2)
        ans = round(a + b, digits=2)
        problem(
            question="Add \$$(a) + $(b)\$",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "Line up the decimal points",
                "\$$(a) + $(b)\$",
                sol("Answer", ans)
            ),
            time=45
        )
    elseif problem_type == 5
        # Decimal multiplication (ELO 500-700)
        a = round(rand() * 5 + 0.1, digits=1)
        b = round(rand() * 5 + 0.1, digits=1)
        ans = round(a * b, digits=2)
        problem(
            question="Multiply \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Multiply the decimals",
                "\$$(a) \\times $(b)\$",
                sol("Answer", ans)
            ),
            time=60
        )
    else
        # Decimal division (ELO 500-700)
        b = round(rand() * 4 + 1, digits=1)
        ans = round(rand() * 8 + 1, digits=1)
        a = round(ans * b, digits=2)
        problem(
            question="Divide \$$(a) \\div $(b)\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Divide the decimals",
                "\$$(a) \\div $(b)\$",
                sol("Answer", ans)
            ),
            time=60
        )
    end
end