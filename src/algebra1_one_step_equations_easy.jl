# algebra1 - one_step_equations (easy)
# Generated: 2026-03-08T19:52:08.561582

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/one_step_equations")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Simple addition: x + a = b
        ans = randint(-25, 25)
        a = randint(-30, 30)
        b = ans + a
        problem(
            question="Solve for \\(x\\): \$$(tex(x + a)) = $(b)\$",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                sol("Given", x + a ~ b),
                "Subtract $(a) from both sides",
                sol(x, ans)
            ),
            time=45
        )
    elseif problem_type == 2
        # Simple multiplication: ax = b
        ans = randint(-20, 20)
        a = nonzero(-8, 8)
        b = a * ans
        problem(
            question="Solve for \\(x\\): \$$(tex(a*x)) = $(b)\$",
            answer=ans,
            difficulty=(750, 900),
            solution=steps(
                sol("Given", a*x ~ b),
                "Divide both sides by $(a)",
                sol(x, ans)
            ),
            time=50
        )
    elseif problem_type == 3
        # Division: x/a = b
        ans = randint(-30, 30)
        a = nonzero(-10, 10)
        b = ans // a
        problem(
            question="Solve for \\(x\\): \$$(tex(x/a)) = $(tex(b))\$",
            answer=ans,
            difficulty=(800, 950),
            solution=steps(
                sol("Given", x/a ~ b),
                "Multiply both sides by $(a)",
                sol(x, ans)
            ),
            time=55
        )
    elseif problem_type == 4
        # Subtraction: x - a = b
        ans = randint(-25, 25)
        a = randint(-30, 30)
        b = ans - a
        problem(
            question="Solve for \\(x\\): \$$(tex(x - a)) = $(b)\$",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                sol("Given", x - a ~ b),
                "Add $(a) to both sides",
                sol(x, ans)
            ),
            time=45
        )
    else
        # Two-step equation: ax + b = c
        ans = randint(-20, 20)
        a = nonzero(-7, 7)
        b = randint(-25, 25)
        c = a * ans + b
        problem(
            question="Solve for \\(x\\): \$$(tex(a*x + b)) = $(c)\$",
            answer=ans,
            difficulty=(900, 1200),
            solution=steps(
                sol("Given", a*x + b ~ c),
                "Subtract $(b) from both sides: \$$(tex(a*x)) = $(c - b)\$",
                "Divide both sides by $(a)",
                sol(x, ans)
            ),
            time=70
        )
    end
end