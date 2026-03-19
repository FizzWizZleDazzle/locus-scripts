# algebra1 - two_step_equations (easy)
# Generated: 2026-03-08T19:52:39.412935

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/two_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Basic two-step: ax + b = c
        ans = randint(-15, 15)
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        c = a * ans + b
        
        problem(
            question = "Solve for \\(x\\): \$$(a)x + $(b) = $(c)\$",
            answer = ans,
            difficulty = (700, 850),
            solution = steps(
                sol("Given", a*x + b ~ c),
                "Subtract $(b) from both sides: \$$(a)x = $(c - b)\$",
                "Divide both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time = 60
        )
        
    elseif problem_type == 2
        # With fractions: x/a + b = c
        ans = randint(-20, 20)
        a = nonzero(-6, 6)
        b = randint(-15, 15)
        c = ans // a + b
        
        problem(
            question = "Solve for \\(x\\): \$\\frac{x}{$(a)} + $(b) = $(tex(c))\$",
            answer = ans,
            difficulty = (800, 950),
            solution = steps(
                sol("Given", x/a + b ~ c),
                "Subtract $(b) from both sides: \$\\frac{x}{$(a)} = $(tex(c - b))\$",
                "Multiply both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time = 75
        )
        
    elseif problem_type == 3
        # With parentheses: a(x + b) = c
        ans = randint(-12, 12)
        a = nonzero(-7, 7)
        b = randint(-10, 10)
        c = a * (ans + b)
        
        problem(
            question = "Solve for \\(x\\): \$$(a)(x + $(b)) = $(c)\$",
            answer = ans,
            difficulty = (850, 1000),
            solution = steps(
                sol("Given", a*(x + b) ~ c),
                "Divide both sides by $(a): \$x + $(b) = $(c // a)\$",
                "Subtract $(b) from both sides",
                sol("Answer", x ~ ans)
            ),
            time = 75
        )
        
    elseif problem_type == 4
        # Distributive: a(x - b) + c = d
        ans = randint(-15, 15)
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        c = randint(-18, 18)
        d = a * (ans - b) + c
        
        lhs = expand(a*(x - b) + c)
        
        problem(
            question = "Solve for \\(x\\): \$$(a)(x - $(b)) + $(c) = $(d)\$",
            answer = ans,
            difficulty = (900, 1100),
            solution = steps(
                sol("Given", a*(x - b) + c ~ d),
                "Distribute: \$$(tex(lhs)) = $(d)\$",
                "Subtract $(c) from both sides: \$$(a*x - a*b) = $(d - c)\$",
                "Add $(a*b) to both sides: \$$(a)x = $(d - c + a*b)\$",
                "Divide by $(a)",
                sol("Answer", x ~ ans)
            ),
            time = 90
        )
        
    else
        # Variables on both sides requiring two steps: ax + b = cx + d
        ans = randint(-18, 18)
        a = nonzero(-7, 7)
        b = randint(-25, 25)
        c = nonzero(-7, 7)
        while c == a
            c = nonzero(-7, 7)
        end
        d = (a - c) * ans + b
        
        problem(
            question = "Solve for \\(x\\): \$$(a)x + $(b) = $(c)x + $(d)\$",
            answer = ans,
            difficulty = (1000, 1200),
            solution = steps(
                sol("Given", a*x + b ~ c*x + d),
                "Subtract $(c)x from both sides: \$$(a - c)x + $(b) = $(d)\$",
                "Subtract $(b) from both sides: \$$(a - c)x = $(d - b)\$",
                "Divide by $(a - c)",
                sol("Answer", x ~ ans)
            ),
            time = 90
        )
    end
end