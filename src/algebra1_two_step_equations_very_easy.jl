# algebra1 - two_step_equations (very_easy)
# Generated: 2026-03-08T19:52:30.644441

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/two_step_equations")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type: ax + b = c (very basic, 100-400 ELO)
        ans = randint(-15, 15)
        a = choice([1, 2, 3, 5])
        b = randint(-20, 20)
        c = a * ans + b
        
        problem(
            question="Solve for \\(x\\): \$$(a)x + $(b) = $(c)\$",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", a*x + b ~ c),
                "Subtract $(b) from both sides: \$$(a)x = $(c - b)\$",
                "Divide both sides by $(a): \$x = $(ans)\$"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Type: ax - b = c (400-550 ELO)
        ans = randint(-20, 20)
        a = nonzero(-8, 8)
        b = randint(-25, 25)
        c = a * ans - b
        
        problem(
            question="Solve for \\(x\\): \$$(tex(a*x - b)) = $(c)\$",
            answer=ans,
            difficulty=(400, 550),
            solution=steps(
                sol("Given", a*x - b ~ c),
                "Add $(b) to both sides: \$$(tex(a*x)) = $(c + b)\$",
                "Divide both sides by $(a): \$x = $(ans)\$"
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Type: b + ax = c (mixed order, 450-600 ELO)
        ans = randint(-25, 25)
        a = nonzero(-10, 10)
        b = randint(-30, 30)
        c = b + a * ans
        
        problem(
            question="Solve for \\(x\\): \$$(b) + $(tex(a*x)) = $(c)\$",
            answer=ans,
            difficulty=(450, 600),
            solution=steps(
                sol("Given", b + a*x ~ c),
                "Subtract $(b) from both sides: \$$(tex(a*x)) = $(c - b)\$",
                "Divide both sides by $(a): \$x = $(ans)\$"
            ),
            time=80
        )
        
    else
        # Type: fractional coefficient ax/d + b = c (550-700 ELO)
        ans = randint(-20, 20)
        d = choice([2, 3, 4, 5])
        a = nonzero(-12, 12)
        b = randint(-15, 15)
        c = (a * ans) // d + b
        
        problem(
            question="Solve for \\(x\\): \$\\frac{$(a)x}{$(d)} + $(b) = $(tex(c))\$",
            answer=ans,
            difficulty=(550, 700),
            solution=steps(
                "Given: \$\\frac{$(a)x}{$(d)} + $(b) = $(tex(c))\$",
                "Subtract $(b) from both sides: \$\\frac{$(a)x}{$(d)} = $(tex(c - b))\$",
                "Multiply both sides by $(d): \$$(a)x = $(tex(d * (c - b)))\$",
                "Divide both sides by $(a): \$x = $(ans)\$"
            ),
            time=90
        )
    end
end