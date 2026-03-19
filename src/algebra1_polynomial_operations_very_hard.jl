# algebra1 - polynomial_operations (very_hard)
# Generated: 2026-03-08T19:59:39.470198

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/polynomial_operations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition-level: Find polynomial P(x) such that P(P(x)) has specific properties
        # ELO 2500-3000
        a = nonzero(-3, 3)
        b = nonzero(-5, 5)
        # P(x) = ax + b
        # P(P(x)) = a(ax + b) + b = a²x + ab + b
        pp_expr = expand(a^2 * x + a*b + b)
        
        # Ask for the original polynomial given P(P(x))
        problem(
            question="Let \\(P(x)\\) be a linear polynomial with integer coefficients. If \\(P(P(x)) = $(tex(pp_expr))\\), find \\(P(x)\\). Express your answer in the form \\(ax + b\\) where \\(a > 0\\).",
            answer=abs(a)*x + b,
            difficulty=(2500, 2800),
            solution=steps(
                "Let \\(P(x) = mx + n\\) for some integers \\(m, n\\)",
                "Then \\(P(P(x)) = P(mx + n) = m(mx + n) + n = m^2x + mn + n\\)",
                sol("Given", pp_expr),
                "Matching coefficients: \\(m^2 = $(a^2)\\) and \\(mn + n = $(a*b + b)\\)",
                "From \\(m^2 = $(a^2)\\), we get \\(m = \\pm $(abs(a))\\)",
                "From \\(mn + n = n(m+1) = $(a*b + b)\\), if \\(m = $(abs(a))\\), then \\(n = $(b)\\)",
                sol("Answer", abs(a)*x + b)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad-level: Polynomial division with remainder having special form
        # ELO 3000-3500
        r = nonzero(-8, 8)
        s = nonzero(-8, 8)
        while s == r
            s = nonzero(-8, 8)
        end
        
        # We want P(x) = (x-r)(x-s)Q(x) + k(x-r) for some constant k
        # So P(r) = 0 and P(s) = k(s-r)
        k = nonzero(-12, 12)
        
        # Build a polynomial: P(x) = (x-r)(x-s)(x-t) + k(x-r)
        t = nonzero(-6, 6)
        divisor = expand((x - r) * (x - s))
        quotient = x - t
        remainder = k * (x - r)
        
        P_expr = expand(divisor * quotient + remainder)
        
        problem(
            question="When the polynomial \\(P(x) = $(tex(P_expr))\\) is divided by \\($(tex(divisor))\\), the remainder is of the form \\(c(x - $(r))\\) for some constant \\(c\\). Find \\(c\\).",
            answer=k,
            difficulty=(3000, 3400),
            solution=steps(
                sol("Given polynomial", P_expr),
                sol("Divisor", divisor),
                "By polynomial division theorem: \\(P(x) = ($(tex(divisor)))Q(x) + R(x)\\) where \\(\\deg R < 2\\)",
                "So \\(R(x) = ax + b\\) for some constants \\(a, b\\)",
                "Since \\(P($(r)) = R($(r))\\), evaluate: \\(P($(r)) = $(substitute(P_expr, x => r))\\)",
                "Since \\(P($(s)) = R($(s))\\), evaluate: \\(P($(s)) = $(substitute(P_expr, x => s))\\)",
                "From \\(R($(r)) = 0\\) and \\(R($(s)) = $(k*(s-r))\\), we get \\(R(x) = $(k)(x - $(r))\\)",
                sol("Answer", k)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Competition-level: Symmetric polynomial problem
        # ELO 2600-3200
        p = nonzero(-7, 7)
        q = nonzero(-9, 9)
        
        # Roots are r1, r2, r3 with r1+r2+r3 = -p, r1*r2*r3 = -q
        # Find r1² + r2² + r3²
        # Using (r1+r2+r3)² = r1² + r2² + r3² + 2(r1*r2 + r1*r3 + r2*r3)
        
        # We need r1*r2 + r1*r3 + r2*r3
        # Let's pick specific roots and build backward
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        r3 = -(r1 + r2) - p  # ensures sum = -p
        
        poly_expr = expand((x - r1) * (x - r2) * (x - r3))
        
        sum_squares = r1^2 + r2^2 + r3^2
        
        problem(
            question="The polynomial \\(P(x) = $(tex(poly_expr))\\) has three real roots \\(r_1, r_2, r_3\\). Find \\(r_1^2 + r_2^2 + r_3^2\\).",
            answer=sum_squares,
            difficulty=(2600, 3000),
            solution=steps(
                sol("Given", poly_expr),
                "By Vieta's formulas for \\(x^3 + px^2 + qx + r = 0\\):",
                "\\(r_1 + r_2 + r_3 = $(-(substitute(poly_expr - x^3, x => 0) |> c -> coeff(c, x, 2) |> Int))\\)",
                "\\(r_1r_2 + r_1r_3 + r_2r_3 = $(substitute(poly_expr - x^3, x => 0) |> c -> coeff(c, x, 1) |> Int)\\)",
                "Use identity: \\((r_1 + r_2 + r_3)^2 = r_1^2 + r_2^2 + r_3^2 + 2(r_1r_2 + r_1r_3 + r_2r_3)\\)",
                "\\(r_1^2 + r_2^2 + r_3^2 = (r_1 + r_2 + r_3)^2 - 2(r_1r_2 + r_1r_3 + r_2r_3)\\)",
                sol("Answer", sum_squares)
            ),
            time=270
        )
        
    else
        # Olympiad-level: Functional equation with polynomials
        # ELO 3200-3500
        a = nonzero(2, 5)
        b = nonzero(-6, 6)
        
        # P(x²) = (P(x))² has solution P(x) = x^a + b when a is even, or simpler forms
        # Use P(x) = x + c type solution: P(x²) should equal (x+c)² = x² + 2cx + c²
        # But P(x²) = x² + c, so need c = 0 or special structure
        
        # Better: P satisfies P(x+1) - P(x) = 2ax + b
        # This means P is quadratic: P(x) = ax² + bx + c
        # P(x+1) = a(x+1)² + b(x+1) + c = ax² + 2ax + a + bx + b + c
        # P(x+1) - P(x) = 2ax + a + b
        # So we need a + b = constant term
        
        const_term = nonzero(-8, 8)
        c = const_term - b
        
        P_expr = a*x^2 + b*x + c
        diff_expr = 2*a*x + (a + b)
        
        problem(
            question="Find the quadratic polynomial \\(P(x)\\) with integer coefficients such that \\(P(x+1) - P(x) = $(tex(diff_expr))\\) and \\(P(0) = $(c)\\). Express your answer in the form \\(ax^2 + bx + c\\).",
            answer=P_expr,
            difficulty=(3200, 3500),
            solution=steps(
                "Let \\(P(x) = mx^2 + nx + p\\) where \\(m, n, p\\) are integers",
                "Then \\(P(x+1) = m(x+1)^2 + n(x+1) + p = mx^2 + 2mx + m + nx + n + p\\)",
                "\\(P(x+1) - P(x) = 2mx + (m + n)\\)",
                sol("Given condition", diff_expr),
                "Matching coefficients: \\(2m = $(2*a)\\) so \\(m = $(a)\\)",
                "And \\(m + n = $(a + b)\\) so \\(n = $(b)\\)",
                "From \\(P(0) = p = $(c)\\)",
                sol("Answer", P_expr)
            ),
            time=300
        )
    end
end