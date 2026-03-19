# algebra1 - two_step_equations (hard)
# Generated: 2026-03-08T19:53:07.021103

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/two_step_equations")
    
    # Random problem type selector
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Equation with fractions requiring LCD (1800-2000)
        ans = randint(-15, 15)
        d1 = rand([2, 3, 4, 5, 6])
        d2 = rand([2, 3, 4, 5, 6])
        while gcd(d1, d2) == d1 || gcd(d1, d2) == d2
            d2 = rand([2, 3, 4, 5, 6])
        end
        lcd = lcm(d1, d2)
        
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        c = nonzero(-8, 8)
        d = randint(-20, 20)
        
        # Construct so that (a*ans + b)/d1 + (c*ans + d)/d2 = some value
        lhs_val = (a*ans + b)//d1 + (c*ans + d)//d2
        rhs = numerator(lhs_val) // denominator(lhs_val)
        
        problem(
            question="Solve for \\(x\\): \\(\\frac{$(a)x + $(b)}{$(d1)} + \\frac{$(c)x + $(d)}{$(d2)} = $(tex(rhs))\\)",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Given: \\(\\frac{$(a)x + $(b)}{$(d1)} + \\frac{$(c)x + $(d)}{$(d2)} = $(tex(rhs))\\)",
                "Multiply both sides by LCD = $(lcd)",
                "Simplify and combine like terms",
                "Isolate \\(x\\)",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Type 2: Nested operations with distribution (1900-2100)
        ans = randint(-12, 12)
        a = nonzero(-7, 7)
        b = nonzero(-6, 6)
        c = nonzero(-8, 8)
        d = randint(-15, 15)
        
        # a(b(x - ans) + c) + d = some value
        inner = b*(x - ans) + c
        expr = expand(a*inner + d)
        rhs = d
        
        problem(
            question="Solve for \\(x\\): \\($(tex(expr)) = $(rhs)\\)",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", expr ~ rhs),
                "Expand and simplify: \\($(a*b)x + $(a*c - a*b*ans + d) = $(rhs)\\)",
                "Subtract $(a*c - a*b*ans + d) from both sides",
                "Divide by $(a*b)",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Type 3: Equation with variable on both sides requiring strategic grouping (2000-2200)
        ans = randint(-10, 10)
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        c = nonzero(-5, 5)
        while abs(a - c) <= 1
            c = nonzero(-5, 5)
        end
        d = randint(-12, 12)
        
        # a*x + b = c*x + d, solving gives x = (d-b)/(a-c)
        # Reverse engineer so ans = (d-b)/(a-c)
        # So d - b = ans*(a - c)
        d = ans*(a - c) + b
        
        lhs = a*x + b
        rhs = c*x + d
        
        problem(
            question="Solve for \\(x\\): \\($(tex(lhs)) = $(tex(rhs))\\)",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Move all \\(x\\) terms to one side: \\($(a-c)x = $(d-b)\\)",
                "Divide both sides by $(a-c)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Type 4: Equation with absolute value requiring case analysis (2100-2300)
        ans = randint(3, 18)
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        k = randint(5, 25)
        
        # |a*x + b| = k where x = ans is one solution
        # This means either a*ans + b = k or a*ans + b = -k
        val = a*ans + b
        if rand(Bool)
            k = abs(val)
        else
            k = abs(val)
        end
        
        # Solutions: x = (k-b)/a and x = (-k-b)/a
        sol1 = (k - b) // a
        sol2 = (-k - b) // a
        
        sols = Set([sol1, sol2])
        
        problem(
            question="Solve for \\(x\\): \\(|$(a)x + $(b)| = $(k)\\)",
            answer=fmt_set(sols),
            answer_type="set",
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", "|$(a)x + $(b)| = $(k)"),
                "Split into two cases:",
                "Case 1: \\($(a)x + $(b) = $(k)\\) gives \\(x = $(tex(sol1))\\)",
                "Case 2: \\($(a)x + $(b) = $(-k)\\) gives \\(x = $(tex(sol2))\\)",
                "Solution set: $(fmt_set(sols))"
            ),
            time=200
        )
        
    else
        # Type 5: Rational equation requiring common denominator (2200-2400)
        ans = nonzero(-8, 8)
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-5, 5)
        
        # (a*x + b)/x = c
        # Solve: a*x + b = c*x, so x = b/(c-a)
        # Reverse: make ans = b/(c-a), so b = ans*(c-a)
        while c - a == 0
            c = nonzero(-5, 5)
        end
        b = ans*(c - a)
        
        problem(
            question="Solve for \\(x\\): \\(\\frac{$(a)x + $(b)}{x} = $(c)\\) (where \\(x \\neq 0\\))",
            answer=ans,
            difficulty=(2200, 2400),
            solution=steps(
                sol("Given", "\\frac{$(a)x + $(b)}{x} = $(c)"),
                "Multiply both sides by \\(x\\) (noting \\(x \\neq 0\\))",
                "\\($(a)x + $(b) = $(c)x\\)",
                "Rearrange: \\($(a-c)x = $(-b)\\)",
                sol("Answer", ans)
            ),
            time=180
        )
    end
end