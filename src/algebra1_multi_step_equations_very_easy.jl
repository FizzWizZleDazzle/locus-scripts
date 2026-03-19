# algebra1 - multi_step_equations (very_easy)
# Generated: 2026-03-08T19:53:08.903840

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/multi_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple one-step: x + a = b (ELO 100-400)
        ans = randint(-15, 15)
        a = randint(-20, 20)
        b = ans + a
        
        problem(
            question="Solve for \\(x\\): \$x + $(a) = $(b)\$",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", x + a ~ b),
                "Subtract $(a) from both sides",
                sol("Answer", x ~ ans)
            ),
            time=30
        )
        
    elseif problem_type == 2
        # One-step with multiplication: ax = b (ELO 300-500)
        ans = randint(-12, 12)
        a = nonzero(-8, 8)
        b = a * ans
        
        problem(
            question="Solve for \\(x\\): \$$(a)x = $(b)\$",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", a*x ~ b),
                "Divide both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Two-step: ax + b = c (ELO 400-700)
        ans = randint(-10, 10)
        a = nonzero(-7, 7)
        b = randint(-15, 15)
        c = a * ans + b
        
        problem(
            question="Solve for \\(x\\): \$$(a)x + $(b) = $(c)\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", a*x + b ~ c),
                "Subtract $(b) from both sides: \$$(a)x = $(c - b)\$",
                "Divide both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Simple variable on both sides: ax + b = cx + d (ELO 600-700)
        ans = randint(-8, 8)
        a = nonzero(-5, 5)
        c = nonzero(-5, 5)
        while c == a
            c = nonzero(-5, 5)
        end
        b = randint(-10, 10)
        d = c * ans + b - a * ans
        
        lhs = a*x + b
        rhs = c*x + d
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=ans,
            difficulty=(600, 700),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Move variables to left: \$$(tex((a-c)*x)) = $(d - b)\$",
                "Divide both sides by $(a-c)",
                sol("Answer", x ~ ans)
            ),
            time=75
        )
        
    else
        # Fraction form: x/a = b (ELO 400-600)
        ans = randint(-15, 15)
        a = nonzero(-8, 8)
        b = ans // a
        
        problem(
            question="Solve for \\(x\\): \$\\frac{x}{$(a)} = $(b)\$",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Given: \$\\frac{x}{$(a)} = $(b)\$",
                "Multiply both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time=50
        )
    end
end