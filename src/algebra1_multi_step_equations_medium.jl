# algebra1 - multi_step_equations (medium)
# Generated: 2026-03-08T19:53:32.384866

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/multi_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type: a(x - b) + c = d, solve for x
        ans = randint(-15, 15)
        a = nonzero(-8, 8)
        b = randint(-12, 12)
        c = randint(-20, 20)
        d = a * (ans - b) + c
        lhs = expand(a * (x - b) + c)
        
        problem(
            question = "Solve for \\(x\\): \\[$(tex(lhs)) = $(d)\\]",
            answer = ans,
            difficulty = (1200, 1400),
            solution = steps(
                sol("Given equation", lhs ~ d),
                "Expand: \\($(tex(a*x - a*b + c)) = $(d)\\)",
                "Subtract $(c) from both sides: \\($(tex(a*x - a*b)) = $(d - c)\\)",
                "Add $(a*b) to both sides: \\($(tex(a*x)) = $(d - c + a*b)\\)",
                "Divide by $(a): \\(x = $(ans)\\)",
                sol("Answer", ans)
            ),
            time = 120
        )
        
    elseif problem_type == 2
        # Type: a(x + b) - c(x + d) = e, solve for x
        ans = randint(-18, 18)
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        e = a * (ans + b) - c * (ans + d)
        lhs = expand(a * (x + b) - c * (x + d))
        
        problem(
            question = "Solve for \\(x\\): \\[$(a)(x + $(b)) - $(c)(x + $(d)) = $(e)\\]",
            answer = ans,
            difficulty = (1300, 1500),
            solution = steps(
                "Expand left side: \\($(tex(a*x + a*b)) - $(tex(c*x + c*d)) = $(e)\\)",
                "Combine like terms: \\($(tex(lhs)) = $(e)\\)",
                "Isolate variable terms on one side",
                "Solve for \\(x\\)",
                sol("Answer", ans)
            ),
            time = 150
        )
        
    elseif problem_type == 3
        # Type: (ax + b)/c = (dx + e)/f, solve for x
        ans = randint(-12, 12)
        a = nonzero(-7, 7)
        b = randint(-15, 15)
        c = nonzero(-5, 5)
        d = nonzero(-7, 7)
        e = randint(-15, 15)
        f = nonzero(-5, 5)
        
        # Ensure both sides evaluate to same value when x = ans
        lhs_val = (a * ans + b) // c
        e = d * ans + f * lhs_val - d * ans
        
        problem(
            question = "Solve for \\(x\\): \\[\\frac{$(tex(a*x + b))}{$(c)} = \\frac{$(tex(d*x + e))}{$(f)}\\]",
            answer = ans,
            difficulty = (1400, 1600),
            solution = steps(
                "Cross multiply: \\($(f)($(tex(a*x + b))) = $(c)($(tex(d*x + e)))\\)",
                "Expand both sides: \\($(tex(f*a*x + f*b)) = $(tex(c*d*x + c*e))\\)",
                "Move all \\(x\\) terms to one side",
                "Combine and solve for \\(x\\)",
                sol("Answer", ans)
            ),
            time = 180
        )
        
    elseif problem_type == 4
        # Type: a(bx + c) + d(ex + f) = g, solve for x
        ans = randint(-20, 20)
        a = nonzero(-5, 5)
        b = nonzero(-4, 4)
        c = randint(-12, 12)
        d = nonzero(-5, 5)
        e = nonzero(-4, 4)
        f = randint(-12, 12)
        g = a * (b * ans + c) + d * (e * ans + f)
        lhs = expand(a * (b * x + c) + d * (e * x + f))
        
        problem(
            question = "Solve for \\(x\\): \\[$(a)($(tex(b*x + c))) + $(d)($(tex(e*x + f))) = $(g)\\]",
            answer = ans,
            difficulty = (1300, 1500),
            solution = steps(
                "Expand first term: \\($(tex(a*b*x + a*c))\\)",
                "Expand second term: \\($(tex(d*e*x + d*f))\\)",
                "Combine like terms: \\($(tex(lhs)) = $(g)\\)",
                "Subtract $(a*c + d*f) from both sides and divide by $(a*b + d*e)",
                sol("Answer", ans)
            ),
            time = 150
        )
        
    else
        # Type: ax + b = c(dx - e) + f, solve for x
        ans = randint(-16, 16)
        a = nonzero(-7, 7)
        b = randint(-18, 18)
        c = nonzero(-6, 6)
        d = nonzero(-5, 5)
        e = randint(-12, 12)
        f = randint(-18, 18)
        
        # Make sure equation is consistent
        rhs_expanded = c * d * ans - c * e + f
        b = a * ans - rhs_expanded + b
        
        problem(
            question = "Solve for \\(x\\): \\[$(tex(a*x + b)) = $(c)($(tex(d*x - e))) + $(f)\\]",
            answer = ans,
            difficulty = (1250, 1450),
            solution = steps(
                sol("Given equation", a*x + b ~ c*(d*x - e) + f),
                "Expand right side: \\($(tex(a*x + b)) = $(tex(c*d*x - c*e + f))\\)",
                "Move all \\(x\\) terms to left side",
                "Combine constants and solve",
                sol("Answer", ans)
            ),
            time = 140
        )
    end
end