# algebra2 - rational_equations (very_easy)
# Generated: 2026-03-08T20:16:03.613139

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # ELO 200-400: Simple rational expression evaluation
        a = nonzero(-10, 10)
        b = nonzero(-10, 10)
        c = nonzero(-10, 10)
        x_val = nonzero(-8, 8)
        
        # Make sure denominator is not zero
        for _attempt in 1:1000
            a * x_val + b == 0 || break
            x_val = nonzero(-8, 8)
        end
        
        expr = c // (a * x + b)
        ans = c // (a * x_val + b)
        
        problem(
            question="Evaluate \\($(tex(expr))\\) when \\(x = $(x_val)\\)",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", expr),
                "Substitute \\(x = $(x_val)\\)",
                sol("Denominator", a * x_val + b),
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # ELO 300-500: Find value that makes denominator zero (undefined value)
        a = nonzero(-8, 8)
        b = nonzero(-15, 15)
        c = nonzero(-10, 10)
        
        expr = c // (a * x + b)
        ans = -b // a
        
        problem(
            question="For what value of \\(x\\) is \\($(tex(expr))\\) undefined?",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", expr),
                "The expression is undefined when the denominator equals zero",
                sol("Set denominator to zero", a * x + b ~ 0),
                sol("Solve for x", ans)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # ELO 400-600: Simple rational equation (one fraction = constant)
        a = nonzero(-8, 8)
        b = nonzero(-15, 15)
        c = nonzero(-12, 12)
        k = nonzero(-10, 10)
        
        # Solve: c/(ax+b) = k
        # c = k(ax+b)
        # c = kax + kb
        # c - kb = kax
        # x = (c - kb)/(ka)
        
        ans_num = c - k * b
        ans_den = k * a
        
        # Make sure we get a nice solution
        for _attempt in 1:1000
            (ans_den == 0 || ans_num % ans_den != 0) || break
            k = nonzero(-10, 10)
            ans_num = c - k * b
            ans_den = k * a
        end
        
        ans = ans_num // ans_den
        
        expr = c // (a * x + b)
        
        problem(
            question="Solve for \\(x\\): \\($(tex(expr)) = $(k)\\)",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                sol("Given equation", expr ~ k),
                "Multiply both sides by \\($(tex(a*x + b))\\)",
                sol("Simplified", c ~ k * (a * x + b)),
                "Expand and solve for \\(x\\)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    else
        # ELO 500-700: Rational equation with variable in numerator
        a = nonzero(-6, 6)
        b = nonzero(-12, 12)
        c = nonzero(-8, 8)
        k = nonzero(-10, 10)
        
        # Solve: (ax+b)/c = k
        # ax + b = ck
        # ax = ck - b
        # x = (ck - b)/a
        
        ans_num = c * k - b
        
        # Make sure we get a nice solution
        for _attempt in 1:1000
            ans_num % a != 0 || break
            k = nonzero(-10, 10)
            ans_num = c * k - b
        end
        
        ans = ans_num // a
        
        expr = (a * x + b) // c
        
        problem(
            question="Solve for \\(x\\): \\($(tex(expr)) = $(k)\\)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given equation", expr ~ k),
                "Multiply both sides by \\($(c)\\)",
                sol("Simplified", a * x + b ~ c * k),
                "Subtract \\($(b)\\) from both sides and divide by \\($(a)\\)",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end