# algebra1 - two_step_equations (medium)
# Generated: 2026-03-08T19:52:51.339963

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/two_step_equations")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Basic two-step: ax + b = c
        ans = randint(-25, 25)
        a = nonzero(-8, 8)
        b = randint(-30, 30)
        c = a * ans + b
        
        problem(
            question = "Solve for \\(x\\): \$$(a)x + $(b) = $(c)\$",
            answer = ans,
            difficulty = (1200, 1400),
            solution = steps(
                sol("Given", a*x + b ~ c),
                "Subtract $(b) from both sides: \$$(a)x = $(c - b)\$",
                "Divide both sides by $(a): \$x = $(ans)\$",
                sol("Answer", ans)
            ),
            time = 90
        )
        
    elseif problem_type == 2
        # Fraction form: (x + b)/a = c
        ans = randint(-20, 20)
        a = nonzero(2, 8)
        b = randint(-25, 25)
        c = (ans + b) // a
        
        problem(
            question = "Solve for \\(x\\): \$\\frac{x + $(b)}{$(a)} = $(c)\$",
            answer = ans,
            difficulty = (1300, 1500),
            solution = steps(
                sol("Given", (x + b)/a ~ c),
                "Multiply both sides by $(a): \$x + $(b) = $(c * a)\$",
                "Subtract $(b) from both sides: \$x = $(c * a - b)\$",
                sol("Answer", ans)
            ),
            time = 120
        )
        
    elseif problem_type == 3
        # Distribution: a(x + b) = c
        ans = randint(-18, 18)
        a = nonzero(-6, 6)
        b = randint(-20, 20)
        c = a * (ans + b)
        
        problem(
            question = "Solve for \\(x\\): \$$(a)(x + $(b)) = $(c)\$",
            answer = ans,
            difficulty = (1300, 1500),
            solution = steps(
                sol("Given", a*(x + b) ~ c),
                "Distribute: \$$(a)x + $(a*b) = $(c)\$",
                "Subtract $(a*b) from both sides: \$$(a)x = $(c - a*b)\$",
                "Divide by $(a): \$x = $(ans)\$",
                sol("Answer", ans)
            ),
            time = 120
        )
        
    elseif problem_type == 4
        # Both sides with variables: ax + b = cx + d
        ans = randint(-22, 22)
        a = nonzero(-7, 7)
        c = nonzero(-7, 7)
        while c == a
            c = nonzero(-7, 7)
        end
        b = randint(-30, 30)
        d = c * ans + b - a * ans
        
        problem(
            question = "Solve for \\(x\\): \$$(a)x + $(b) = $(c)x + $(d)\$",
            answer = ans,
            difficulty = (1400, 1600),
            solution = steps(
                sol("Given", a*x + b ~ c*x + d),
                "Subtract $(c)x from both sides: \$$(a - c)x + $(b) = $(d)\$",
                "Subtract $(b) from both sides: \$$(a - c)x = $(d - b)\$",
                "Divide by $(a - c): \$x = $(ans)\$",
                sol("Answer", ans)
            ),
            time = 150
        )
        
    elseif problem_type == 5
        # Nested distribution: a(bx + c) + d = e
        ans = randint(-15, 15)
        a = nonzero(-5, 5)
        b = nonzero(-4, 4)
        c = randint(-12, 12)
        d = randint(-20, 20)
        e = a * (b * ans + c) + d
        
        problem(
            question = "Solve for \\(x\\): \$$(a)($(b)x + $(c)) + $(d) = $(e)\$",
            answer = ans,
            difficulty = (1500, 1700),
            solution = steps(
                sol("Given", a*(b*x + c) + d ~ e),
                "Distribute: \$$(a*b)x + $(a*c) + $(d) = $(e)\$",
                "Combine constants: \$$(a*b)x + $(a*c + d) = $(e)\$",
                "Subtract $(a*c + d): \$$(a*b)x = $(e - a*c - d)\$",
                "Divide by $(a*b): \$x = $(ans)\$",
                sol("Answer", ans)
            ),
            time = 180
        )
        
    else
        # Complex with fractions: (ax + b)/c + d = e
        ans = randint(-16, 16)
        a = nonzero(-6, 6)
        b = randint(-20, 20)
        c = nonzero(2, 6)
        d = randint(-15, 15)
        e_num = a * ans + b + c * d
        e = e_num // c
        
        problem(
            question = "Solve for \\(x\\): \$\\frac{$(a)x + $(b)}{$(c)} + $(d) = $(e)\$",
            answer = ans,
            difficulty = (1600, 1800),
            solution = steps(
                sol("Given", (a*x + b)/c + d ~ e),
                "Subtract $(d) from both sides: \$\\frac{$(a)x + $(b)}{$(c)} = $(e - d)\$",
                "Multiply both sides by $(c): \$$(a)x + $(b) = $(c * (e - d))\$",
                "Subtract $(b): \$$(a)x = $(c * (e - d) - b)\$",
                "Divide by $(a): \$x = $(ans)\$",
                sol("Answer", ans)
            ),
            time = 180
        )
    end
end