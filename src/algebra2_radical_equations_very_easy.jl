# algebra2 - radical_equations (very_easy)
# Generated: 2026-03-08T20:17:29.735040

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/radical_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # ELO 100-300: Simplify a basic square root (recognize perfect squares)
        perfect_squares = [1, 4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144, 169, 196, 225]
        val = choice(perfect_squares)
        ans = isqrt(val)
        
        problem(
            question="What is \\(\\sqrt{$(val)}\\)?",
            answer=ans,
            difficulty=(150, 350),
            solution=steps(
                "Recognize that $(val) is a perfect square",
                "Find the number that when multiplied by itself equals $(val)",
                sol("Answer", ans)
            ),
            time=30
        )
    elseif problem_type == 2
        # ELO 300-500: Solve sqrt(x) = constant
        ans = randint(2, 15)
        rhs = ans^2
        
        problem(
            question="Solve \\(\\sqrt{x} = $(ans)\\)",
            answer=rhs,
            difficulty=(350, 500),
            solution=steps(
                sol("Given", "\\sqrt{x} = $(ans)"),
                "Square both sides: \\(x = $(ans)^2\\)",
                sol("Answer", rhs)
            ),
            time=45
        )
    elseif problem_type == 3
        # ELO 400-600: Solve sqrt(x + a) = b
        ans = randint(1, 20)
        a = randint(-15, 15)
        b = randint(2, 12)
        
        # sqrt(x + a) = b means x + a = b^2, so x = b^2 - a
        actual_ans = b^2 - a
        
        problem(
            question="Solve \\(\\sqrt{x + $(a)} = $(b)\\)",
            answer=actual_ans,
            difficulty=(450, 650),
            solution=steps(
                sol("Given", "\\sqrt{x + $(a)} = $(b)"),
                "Square both sides: \\(x + $(a) = $(b^2)\\)",
                "Subtract $(a) from both sides",
                sol("Answer", actual_ans)
            ),
            time=60
        )
    else
        # ELO 500-700: Solve sqrt(ax) = c
        a = nonzero(2, 8)
        c = randint(3, 10)
        # sqrt(ax) = c means ax = c^2, so x = c^2/a
        ans_num = c^2
        
        if ans_num % a == 0
            ans = ans_num ÷ a
            problem(
                question="Solve \\(\\sqrt{$(a)x} = $(c)\\)",
                answer=ans,
                difficulty=(500, 700),
                solution=steps(
                    sol("Given", "\\sqrt{$(a)x} = $(c)"),
                    "Square both sides: \\($(a)x = $(c^2)\\)",
                    "Divide both sides by $(a)",
                    sol("Answer", ans)
                ),
                time=75
            )
        else
            ans = ans_num // a
            problem(
                question="Solve \\(\\sqrt{$(a)x} = $(c)\\)",
                answer=ans,
                difficulty=(550, 700),
                solution=steps(
                    sol("Given", "\\sqrt{$(a)x} = $(c)"),
                    "Square both sides: \\($(a)x = $(c^2)\\)",
                    "Divide both sides by $(a)",
                    sol("Answer", "x = \\frac{$(ans_num)}{$(a)}")
                ),
                time=75
            )
        end
    end
end