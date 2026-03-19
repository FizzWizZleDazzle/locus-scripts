# algebra2 - radical_expressions (easy)
# Generated: 2026-03-08T20:17:05.395895

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/radical_expressions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simplify sqrt(a*b) where b is a perfect square
        perfect_squares = [4, 9, 16, 25, 36, 49, 64, 81, 100]
        b = choice(perfect_squares)
        a = randint(2, 12)
        radicand = a * b
        sqrt_b = Int(sqrt(b))
        ans_expr = sqrt_b * sqrt(a)
        
        problem(
            question="Simplify \\(\\sqrt{$(radicand)}\\)",
            answer="$(sqrt_b)√$(a)",
            difficulty=(700, 900),
            solution=steps(
                sol("Given", sqrt(radicand)),
                "Factor: \\(\\sqrt{$(radicand)} = \\sqrt{$(a) \\cdot $(b)}\\)",
                "Since \\(\\sqrt{$(b)} = $(sqrt_b)\\), we get \\($(sqrt_b)\\sqrt{$(a)}\\)",
                sol("Answer", "$(sqrt_b)√$(a)")
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Solve sqrt(ax + b) = c
        c = randint(2, 8)
        a = nonzero(-5, 5)
        # Work backward: x should be an integer
        x_ans = randint(-15, 15)
        b = c^2 - a * x_ans
        
        problem(
            question="Solve \\(\\sqrt{$(tex(a*x + b))} = $(c)\\)",
            answer=x_ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", "\\sqrt{$(tex(a*x + b))} = $(c)"),
                "Square both sides: \\($(tex(a*x + b)) = $(c^2)\\)",
                "Solve for x: \\($(a)x = $(c^2 - b)\\)",
                sol("Answer", x_ans)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Rationalize denominator: a / sqrt(b)
        a = nonzero(-12, 12)
        b = choice([2, 3, 5, 6, 7, 10, 11])
        
        problem(
            question="Rationalize the denominator: \\(\\frac{$(a)}{\\sqrt{$(b)}}\\)",
            answer="$(a)√$(b)/$(b)",
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", "\\frac{$(a)}{\\sqrt{$(b)}}"),
                "Multiply by \\(\\frac{\\sqrt{$(b)}}{\\sqrt{$(b)}}\\)",
                "\\(\\frac{$(a)\\sqrt{$(b)}}{$(b)}\\)",
                sol("Answer", "\\frac{$(a)\\sqrt{$(b)}}{$(b)}")
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Add/subtract radicals: a*sqrt(c) + b*sqrt(c)
        c = choice([2, 3, 5, 6, 7])
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        while a + b == 0
            b = nonzero(-8, 8)
        end
        ans_coef = a + b
        
        problem(
            question="Simplify \\($(a)\\sqrt{$(c)} + $(b)\\sqrt{$(c)}\\)",
            answer="$(ans_coef)√$(c)",
            difficulty=(700, 900),
            solution=steps(
                sol("Given", "$(a)\\sqrt{$(c)} + $(b)\\sqrt{$(c)}"),
                "Combine like terms (both have \\(\\sqrt{$(c)}\\))",
                "\\(($(a) + $(b))\\sqrt{$(c)} = $(ans_coef)\\sqrt{$(c)}\\)",
                sol("Answer", "$(ans_coef)√$(c)")
            ),
            time=60
        )
        
    else
        # Solve sqrt(ax + b) + c = d
        d = randint(5, 12)
        c = randint(1, 6)
        sqrt_val = d - c
        a = nonzero(-4, 4)
        x_ans = randint(-20, 20)
        b = sqrt_val^2 - a * x_ans
        
        problem(
            question="Solve \\(\\sqrt{$(tex(a*x + b))} + $(c) = $(d)\\)",
            answer=x_ans,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Given", "\\sqrt{$(tex(a*x + b))} + $(c) = $(d)"),
                "Subtract $(c) from both sides: \\(\\sqrt{$(tex(a*x + b))} = $(sqrt_val)\\)",
                "Square both sides: \\($(tex(a*x + b)) = $(sqrt_val^2)\\)",
                "Solve: \\($(a)x = $(sqrt_val^2 - b)\\)",
                sol("Answer", x_ans)
            ),
            time=120
        )
    end
end