# precalculus - inverse_functions (hard)
# Generated: 2026-03-08T20:25:33.573945

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/inverse_functions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Find inverse of a linear fractional function
        a = nonzero(-8, 8)
        b = nonzero(-12, 12)
        c = nonzero(-8, 8)
        d = nonzero(-12, 12)
        
        # Ensure ad - bc ≠ 0 (invertible)
        while a*d == b*c
            d = nonzero(-12, 12)
        end
        
        f_expr = (a*x + b) / (c*x + d)
        
        # Compute inverse: solve y = (ax+b)/(cx+d) for x
        # y(cx+d) = ax+b
        # ycx + yd = ax + b
        # ycx - ax = b - yd
        # x(yc - a) = b - yd
        # x = (b - yd)/(yc - a) = (-dy + b)/(cy - a)
        
        inv_expr = (-d*y + b) / (c*y - a)
        
        problem(
            question="Find the inverse function \\(f^{-1}(x)\\) of \\(f(x) = $(tex(f_expr))\\).",
            answer=substitute(inv_expr, y => x),
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", "f(x) = " * tex(f_expr)),
                "Set \\(y = $(tex(f_expr))\\) and solve for \\(x\\)",
                "\\(y($(tex(c*x + d))) = $(tex(a*x + b))\\)",
                "\\($(tex(c*y))x + $(tex(d*y)) = $(tex(a))x + $(tex(b))\\)",
                "\\($(tex(c*y - a))x = $(tex(b - d*y))\\)",
                sol("f^{-1}(x)", substitute(inv_expr, y => x))
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Composition f(f^{-1}(x)) verification with polynomial
        root1 = randint(-10, 10)
        root2 = randint(-10, 10)
        while root2 == root1
            root2 = randint(-10, 10)
        end
        a = nonzero(-3, 3)
        
        f_expr = expand(a*(x - root1)*(x - root2))
        
        # For restricted domain, ask about specific value
        test_val = randint(-15, 15)
        while test_val == root1 || test_val == root2
            test_val = randint(-15, 15)
        end
        
        f_test = substitute(f_expr, x => test_val)
        ans = test_val
        
        problem(
            question="Let \\(f(x) = $(tex(f_expr))\\) with domain \\(x \\geq $(max(root1, root2))\\). If \\(f^{-1}($(f_test)) = k\\), find \\(k\\).",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", "f(x) = " * tex(f_expr)),
                "Since \\(f^{-1}($(f_test)) = k\\), we have \\(f(k) = $(f_test)\\)",
                "Solve \\($(tex(f_expr)) = $(f_test)\\)",
                "The solution in the domain \\(x \\geq $(max(root1, root2))\\) is \\(k = $(ans)\\)",
                sol("Answer", ans)
            ),
            time=210
        )
        
    elseif problem_type == 3
        # Inverse of exponential/logarithmic combination
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        
        # f(x) = a*log(x) + b, so f^{-1}(x) = e^((x-b)/a)
        
        problem(
            question="Find the inverse function of \\(f(x) = $(a) \\ln(x) + $(b)\\) for \\(x > 0\\).",
            answer="e^((x - $(b))/$(a))",
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given", "f(x) = $(a)\\ln(x) + $(b)"),
                "Set \\(y = $(a)\\ln(x) + $(b)\\)",
                "\\(y - $(b) = $(a)\\ln(x)\\)",
                "\\(\\ln(x) = \\frac{y - $(b)}{$(a)}\\)",
                "\\(x = e^{(y - $(b))/$(a)}\\)",
                sol("f^{-1}(x)", "e^{(x - $(b))/$(a)}")
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Domain/range relationship for inverse
        lower = randint(-15, 5)
        upper = randint(lower + 5, 20)
        m = nonzero(-4, 4)
        b = randint(-10, 10)
        
        # f(x) = mx + b with domain [lower, upper]
        range_lower = m * lower + b
        range_upper = m * upper + b
        
        if m < 0
            range_lower, range_upper = range_upper, range_lower
        end
        
        ans = fmt_interval(range_lower, range_upper, false, false)
        
        problem(
            question="If \\(f(x) = $(tex(m*x + b))\\) has domain \\([$(lower), $(upper)]\\), what is the domain of \\(f^{-1}(x)\\)?",
            answer=ans,
            answer_type="interval",
            difficulty=(1800, 1950),
            solution=steps(
                sol("Given", "f(x) = $(tex(m*x + b)), \\text{ domain } [$(lower), $(upper)]"),
                "The domain of \\(f^{-1}\\) equals the range of \\(f\\)",
                "Range of \\(f\\): \\(f($(lower)) = $(m*lower + b)\\), \\(f($(upper)) = $(m*upper + b)\\)",
                "Range: \\([$(range_lower), $(range_upper)]\\)",
                sol("Domain of f^{-1}", ans)
            ),
            time=120
        )
        
    elseif problem_type == 5
        # Inverse of cube root function with linear inside
        a = nonzero(-6, 6)
        b = nonzero(-12, 12)
        
        # f(x) = ∛(ax + b), so f^{-1}(x) = (x^3 - b)/a
        inv_expr = (x^3 - b) / a
        
        problem(
            question="Find the inverse of \\(f(x) = \\sqrt[3]{$(tex(a*x + b))}\\).",
            answer=inv_expr,
            difficulty=(1850, 2000),
            solution=steps(
                sol("Given", "f(x) = \\sqrt[3]{$(tex(a*x + b))}"),
                "Set \\(y = \\sqrt[3]{$(tex(a*x + b))}\\)",
                "Cube both sides: \\(y^3 = $(tex(a*x + b))\\)",
                "\\($(a)x = y^3 - $(b)\\)",
                "\\(x = \\frac{y^3 - $(b)}{$(a)}\\)",
                sol("f^{-1}(x)", inv_expr)
            ),
            time=150
        )
        
    else
        # Prove two functions are inverses via composition
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-5, 5)
        
        # f(x) = a*x^3 + b, g(x) = ∛((x-b)/a)
        # Need to verify f(g(x)) = x
        
        result_expr = expand(a * ((x - b) / a) + b)
        
        problem(
            question="Verify that \\(f(x) = $(a)x^3 + $(b)\\) and \\(g(x) = \\sqrt[3]{\\frac{x - $(b)}{$(a)}}\\) are inverse functions by computing \\(f(g(x))\\).",
            answer=x,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", "f(x) = $(a)x^3 + $(b), \\quad g(x) = \\sqrt[3]{\\frac{x - $(b)}{$(a)}}"),
                "Compute \\(f(g(x)) = $(a)\\left(\\sqrt[3]{\\frac{x - $(b)}{$(a)}}\\right)^3 + $(b)\\)",
                "\\(= $(a) \\cdot \\frac{x - $(b)}{$(a)} + $(b)\\)",
                "\\(= x - $(b) + $(b) = x\\)",
                sol("Conclusion", "f(g(x)) = x, \\text{ so they are inverses}")
            ),
            time=180
        )
    end
end