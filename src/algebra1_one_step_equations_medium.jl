# algebra1 - one_step_equations (medium)
# Generated: 2026-03-08T19:52:17.260008

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/one_step_equations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # ax = b style (division)
        ans = randint(-25, 25)
        a = nonzero(-12, 12)
        b = a * ans
        
        problem(
            question="Solve for \\(x\\): \$$(a)x = $(b)\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", a*x ~ b),
                "Divide both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time=60
        )
    elseif problem_type == 2
        # x + a = b style (subtraction)
        ans = randint(-30, 30)
        a = randint(-25, 25)
        b = ans + a
        
        problem(
            question="Solve for \\(x\\): \$x + $(a) = $(b)\$",
            answer=ans,
            difficulty=(1200, 1300),
            solution=steps(
                sol("Given", x + a ~ b),
                "Subtract $(a) from both sides",
                sol("Answer", x ~ ans)
            ),
            time=45
        )
    elseif problem_type == 3
        # x/a = b style (multiplication)
        ans = randint(-20, 20)
        a = nonzero(-10, 10)
        b = ans // a
        
        problem(
            question="Solve for \\(x\\): \$\\frac{x}{$(a)} = $(tex(b))\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", x/a ~ b),
                "Multiply both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time=60
        )
    elseif problem_type == 4
        # ax + b = c style (two-step)
        ans = randint(-20, 20)
        a = nonzero(-8, 8)
        b = randint(-30, 30)
        c = a * ans + b
        
        problem(
            question="Solve for \\(x\\): \$$(a)x + $(b) = $(c)\$",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", a*x + b ~ c),
                "Subtract $(b) from both sides: \$$(a)x = $(c - b)\$",
                "Divide both sides by $(a)",
                sol("Answer", x ~ ans)
            ),
            time=90
        )
    elseif problem_type == 5
        # Fractional coefficient: (a/b)x = c
        ans = randint(-15, 15)
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = (a * ans) // b
        
        problem(
            question="Solve for \\(x\\): \$\\frac{$(a)}{$(b)}x = $(tex(c))\$",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", (a//b)*x ~ c),
                "Multiply both sides by the reciprocal \$\\frac{$(b)}{$(a)}\$",
                "Simplify: \$x = $(tex(c)) \\cdot \\frac{$(b)}{$(a)}\$",
                sol("Answer", x ~ ans)
            ),
            time=90
        )
    else
        # Word problem requiring equation setup
        ans = randint(5, 40)
        item_cost = nonzero(2, 15)
        fixed_cost = randint(10, 50)
        total = item_cost * ans + fixed_cost
        
        items = choice(["books", "shirts", "tickets", "notebooks", "pencils", "toys"])
        
        problem(
            question="A store charges \$$(fixed_cost) for shipping plus \$$(item_cost) per item. If the total cost is \$$(total), how many items were purchased?",
            answer=ans,
            difficulty=(1600, 1800),
            solution=steps(
                "Let \\(x\\) = number of items",
                sol("Equation", item_cost*x + fixed_cost ~ total),
                "Subtract $(fixed_cost) from both sides: \$$(item_cost)x = $(total - fixed_cost)\$",
                "Divide both sides by $(item_cost)",
                sol("Answer", x ~ ans)
            ),
            time=120
        )
    end
end