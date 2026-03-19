# algebra1 - multi_step_equations (easy)
# Generated: 2026-03-08T19:53:25.414565

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/multi_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: a(x + b) = c format (700-900 ELO)
        ans = randint(-15, 15)
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        c = a * (ans + b)
        lhs = a * (x + b)
        
        problem(
            question="Solve for \\(x\\): \\($(tex(lhs)) = $(c)\\)",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", lhs ~ c),
                "Divide both sides by $(a): \\(x + $(b) = $(c // a)\\)",
                "Subtract $(b) from both sides",
                sol("Answer", x ~ ans)
            ),
            time=75
        )
        
    elseif problem_type == 2
        # Type 2: ax + b = cx + d format (800-1000 ELO)
        ans = randint(-20, 20)
        a = nonzero(-8, 8)
        c = nonzero(-8, 8)
        while a == c
            c = nonzero(-8, 8)
        end
        b = randint(-15, 15)
        d = c * ans + b - a * ans
        
        lhs = a * x + b
        rhs = c * x + d
        
        problem(
            question="Solve for \\(x\\): \\($(tex(lhs)) = $(tex(rhs))\\)",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Collect x terms on one side: \\($(tex((a - c) * x)) = $(d - b)\\)",
                "Divide both sides by $(a - c)",
                sol("Answer", x ~ ans)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Type 3: a(x + b) + c = d format (850-1050 ELO)
        ans = randint(-18, 18)
        a = nonzero(-7, 7)
        b = randint(-10, 10)
        c = randint(-15, 15)
        d = a * (ans + b) + c
        
        lhs = a * (x + b) + c
        
        problem(
            question="Solve for \\(x\\): \\($(tex(lhs)) = $(d)\\)",
            answer=ans,
            difficulty=(850, 1050),
            solution=steps(
                sol("Given", lhs ~ d),
                "Subtract $(c) from both sides: \\($(tex(a * (x + b))) = $(d - c)\\)",
                "Divide by $(a): \\(x + $(b) = $(rationalize((d - c) // a))\\)",
                "Subtract $(b) from both sides",
                sol("Answer", x ~ ans)
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Type 4: a(x + b) = c(x + d) format (900-1100 ELO)
        ans = randint(-22, 22)
        a = nonzero(-6, 6)
        c = nonzero(-6, 6)
        while a == c
            c = nonzero(-6, 6)
        end
        b = randint(-12, 12)
        d = (a * (ans + b) - c * ans) // c
        
        lhs = a * (x + b)
        rhs = c * (x + d)
        
        problem(
            question="Solve for \\(x\\): \\($(tex(lhs)) = $(tex(rhs))\\)",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Expand both sides: \\($(tex(expand(lhs))) = $(tex(expand(rhs)))\\)",
                "Collect x terms: \\($(tex((a - c) * x)) = $(tex(c * d - a * b))\\)",
                "Divide by $(a - c)",
                sol("Answer", x ~ ans)
            ),
            time=120
        )
        
    else
        # Type 5: a(x + b) + c(x + d) = e format (950-1200 ELO)
        ans = randint(-25, 25)
        a = nonzero(-5, 5)
        c = nonzero(-5, 5)
        b = randint(-10, 10)
        d = randint(-10, 10)
        e = a * (ans + b) + c * (ans + d)
        
        lhs = a * (x + b) + c * (x + d)
        
        problem(
            question="Solve for \\(x\\): \\($(tex(lhs)) = $(e)\\)",
            answer=ans,
            difficulty=(950, 1200),
            solution=steps(
                sol("Given", lhs ~ e),
                "Expand: \\($(tex(expand(lhs))) = $(e)\\)",
                "Combine like terms: \\($(tex((a + c) * x + a * b + c * d)) = $(e)\\)",
                "Subtract $(a * b + c * d) from both sides: \\($(tex((a + c) * x)) = $(e - a * b - c * d)\\)",
                "Divide by $(a + c)",
                sol("Answer", x ~ ans)
            ),
            time=150
        )
    end
end