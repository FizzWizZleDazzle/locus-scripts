# calculus - limits_at_infinity (hard)
# Generated: 2026-03-08T20:37:36.166604

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/limits_at_infinity")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Rational function with equal degrees - limit is ratio of leading coefficients
        a_num = nonzero(-8, 8)
        a_den = nonzero(-8, 8)
        
        deg = rand(2:4)
        
        # Generate numerator polynomial
        num_coeffs = [randint(-5, 5) for _ in 1:(deg-1)]
        push!(num_coeffs, a_num)
        num_expr = sum(c * x^(deg - i) for (i, c) in enumerate(num_coeffs) if c != 0)
        
        # Generate denominator polynomial
        den_coeffs = [randint(-5, 5) for _ in 1:(deg-1)]
        push!(den_coeffs, a_den)
        den_expr = sum(c * x^(deg - i) for (i, c) in enumerate(den_coeffs) if c != 0)
        
        ans = a_num // a_den
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(num_expr))}{$(tex(den_expr))}",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(num_expr))}{$(tex(den_expr))}"),
                "Degrees are equal (both degree $deg). Divide numerator and denominator by \\(x^{$deg}\\)",
                "Leading coefficients: numerator has $a_num, denominator has $a_den",
                sol("Limit", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Rational with numerator degree < denominator degree -> 0
        num_deg = rand(1:3)
        den_deg = num_deg + rand(1:2)
        
        a_num = nonzero(-6, 6)
        num_coeffs = [randint(-5, 5) for _ in 1:(num_deg-1)]
        push!(num_coeffs, a_num)
        num_expr = sum(c * x^(num_deg - i) for (i, c) in enumerate(num_coeffs) if c != 0)
        
        a_den = nonzero(-6, 6)
        den_coeffs = [randint(-5, 5) for _ in 1:(den_deg-1)]
        push!(den_coeffs, a_den)
        den_expr = sum(c * x^(den_deg - i) for (i, c) in enumerate(den_coeffs) if c != 0)
        
        ans = 0
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(num_expr))}{$(tex(den_expr))}",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(num_expr))}{$(tex(den_expr))}"),
                "Numerator degree ($num_deg) < Denominator degree ($den_deg)",
                "Divide by \\(x^{$den_deg}\\): numerator terms vanish faster than denominator",
                sol("Limit", 0)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Square root rational: sqrt(ax^2 + ...) / (bx + c)
        a = rand(1:9)
        b = nonzero(-8, 8)
        c = randint(-15, 15)
        d = randint(-15, 15)
        
        num_expr = sqrt(a*x^2 + b*x + c)
        den_expr = d*x + randint(-10, 10)
        
        # For x -> infinity, sqrt(ax^2 + bx + c) ~ sqrt(a)*x
        ans = sqrt(a) / abs(d)
        if d < 0
            ans = -ans
        end
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{\\sqrt{$(a)x^2 + $(b)x + $(c)}}{$(tex(den_expr))}",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{\\sqrt{$(a)x^2 + $(b)x + $(c)}}{$(tex(den_expr))}"),
                "Factor \\(x^2\\) from under the square root: \\(\\sqrt{x^2($(a) + \\frac{$(b)}{x} + \\frac{$(c)}{x^2})} = |x|\\sqrt{$(a) + \\frac{$(b)}{x} + \\frac{$(c)}{x^2}}\\)",
                "For \\(x \\to \\infty\\), \\(|x| = x\\) and terms with \\(\\frac{1}{x}\\) vanish",
                "Limit becomes \\(\\frac{x\\sqrt{$(a)}}{$(d)x} = \\frac{\\sqrt{$(a)}}{$(d)}\\)",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Exponential dominated: (ax^n + ...) / e^(bx)
        a = nonzero(-8, 8)
        n = rand(2:5)
        b = rand(1:3)
        
        poly_coeffs = [randint(-5, 5) for _ in 1:(n-1)]
        push!(poly_coeffs, a)
        poly_expr = sum(c * x^(n - i) for (i, c) in enumerate(poly_coeffs) if c != 0)
        
        ans = 0
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(poly_expr))}{e^{$(b)x}}",
            answer=ans,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(poly_expr))}{e^{$(b)x}}"),
                "Exponential functions grow faster than any polynomial",
                "Apply L'Hôpital's rule $n times (or recognize exponential dominance)",
                "After repeated differentiation, numerator becomes constant while denominator remains exponential",
                sol("Limit", 0)
            ),
            time=180
        )
        
    else
        # Difference of square roots: sqrt(ax^2 + bx + c) - sqrt(dx^2 + ex + f)
        a = rand(1:6)
        b = randint(-12, 12)
        c = randint(-20, 20)
        d = a  # Same leading coefficient for interesting limit
        e = randint(-12, 12)
        f = randint(-20, 20)
        
        # Limit will be (b - e) / (2*sqrt(a))
        ans = (b - e) // (2 * isqrt(a))
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\left(\\sqrt{$(a)x^2 + $(b)x + $(c)} - \\sqrt{$(d)x^2 + $(e)x + $(f)}\\right)",
            answer=ans,
            difficulty=(2200, 2400),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\left(\\sqrt{$(a)x^2 + $(b)x + $(c)} - \\sqrt{$(d)x^2 + $(e)x + $(f)}\\right)"),
                "Multiply by conjugate: \\(\\frac{\\sqrt{$(a)x^2 + $(b)x + $(c)} + \\sqrt{$(d)x^2 + $(e)x + $(f)}}{\\sqrt{$(a)x^2 + $(b)x + $(c)} + \\sqrt{$(d)x^2 + $(e)x + $(f)}}\\)",
                "Numerator becomes: \\(($(a)x^2 + $(b)x + $(c)) - ($(d)x^2 + $(e)x + $(f)) = $(b-e)x + $(c-f)\\)",
                "Denominator: \\(\\sqrt{$(a)x^2 + $(b)x + $(c)} + \\sqrt{$(d)x^2 + $(e)x + $(f)} \\sim 2\\sqrt{$(a)}x\\) as \\(x \\to \\infty\\)",
                "Limit: \\(\\frac{$(b-e)x}{2\\sqrt{$(a)}x} = \\frac{$(b-e)}{$(2*isqrt(a))}\\)",
                sol("Answer", ans)
            ),
            time=240
        )
    end
end