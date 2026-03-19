# calculus - limits_at_infinity (very_hard)
# Generated: 2026-03-08T20:37:56.373101

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("calculus/limits_at_infinity")
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Rational function with polynomial numerator and denominator
        # Pick degrees to create interesting behavior
        deg_num = randint(2, 5)
        deg_den = randint(2, 5)
        
        # Generate leading coefficients
        a_n = nonzero(-8, 8)
        b_n = nonzero(-8, 8)
        
        # Generate numerator polynomial
        num_coeffs = [randint(-10, 10) for _ in 1:(deg_num-1)]
        pushfirst!(num_coeffs, a_n)
        numerator = sum([c * x^(deg_num - i) for (i, c) in enumerate(num_coeffs)])
        
        # Generate denominator polynomial
        den_coeffs = [randint(-10, 10) for _ in 1:(deg_den-1)]
        pushfirst!(den_coeffs, b_n)
        denominator = sum([c * x^(deg_den - i) for (i, c) in enumerate(den_coeffs)])
        
        expr = numerator / denominator
        
        if deg_num < deg_den
            answer = "0"
            solution_text = steps(
                sol("Given", expr),
                "Degree of numerator: $deg_num, Degree of denominator: $deg_den",
                "Since degree of numerator < degree of denominator, limit approaches 0",
                sol("Answer", 0)
            )
        elseif deg_num == deg_den
            answer = a_n // b_n
            solution_text = steps(
                sol("Given", expr),
                "Degree of numerator: $deg_num, Degree of denominator: $deg_den",
                "Since degrees are equal, divide leading coefficients: $(a_n)/$(b_n)",
                sol("Answer", answer)
            )
        else
            answer = "DNE"
            solution_text = steps(
                sol("Given", expr),
                "Degree of numerator: $deg_num, Degree of denominator: $deg_den",
                "Since degree of numerator > degree of denominator, limit is ±∞ (does not exist)",
                sol("Answer", "DNE")
            )
        end
        
        problem(
            question="Find \\lim_{x \\to \\infty} $(tex(expr))",
            answer=answer,
            difficulty=(2500, 2900),
            solution=solution_text,
            time=180
        )
        
    elseif prob_type == 2
        # Limit involving nested radicals
        a = nonzero(-12, 12)
        b = nonzero(-15, 15)
        c = nonzero(-12, 12)
        d = nonzero(-15, 15)
        
        # sqrt(ax^2 + bx) - sqrt(cx^2 + dx)
        expr1 = sqrt(a*x^2 + b*x)
        expr2 = sqrt(c*x^2 + d*x)
        expr = expr1 - expr2
        
        # For x -> infinity, factor out x from each sqrt
        # sqrt(ax^2 + bx) = |x|*sqrt(a + b/x) -> |x|*sqrt(a) as x->∞
        # For x->∞, x is positive, so |x| = x
        
        if a > 0 && c > 0
            answer = (sqrt(a) - sqrt(c))
            if abs(answer) < 0.0001
                answer = "0"
                solution_text = steps(
                    sol("Given", expr),
                    "Factor x² from each radical: \\sqrt{x^2($(a) + $(b)/x)} - \\sqrt{x^2($(c) + $(d)/x)}",
                    "For x > 0: x\\sqrt{$(a) + $(b)/x} - x\\sqrt{$(c) + $(d)/x}",
                    "As x → ∞: x(\\sqrt{$(a)} - \\sqrt{$(c)}) = x(0) → 0",
                    sol("Answer", 0)
                )
            else
                answer = "DNE"
                solution_text = steps(
                    sol("Given", expr),
                    "Factor x² from each radical: \\sqrt{x^2($(a) + $(b)/x)} - \\sqrt{x^2($(c) + $(d)/x)}",
                    "For x > 0: x(\\sqrt{$(a)} - \\sqrt{$(c)})",
                    "As x → ∞, this approaches ±∞ (does not exist)",
                    sol("Answer", "DNE")
                )
            end
        else
            answer = "DNE"
            solution_text = steps(
                sol("Given", expr),
                "One or both radicals have negative leading coefficients",
                "For large x, expressions under radicals become negative",
                sol("Answer", "DNE (not defined for large x)")
            )
        end
        
        problem(
            question="Find \\lim_{x \\to \\infty} \\left($(tex(expr1)) - $(tex(expr2))\\right)",
            answer=answer,
            difficulty=(2800, 3200),
            solution=solution_text,
            time=240
        )
        
    elseif prob_type == 3
        # Exponential with polynomial ratio
        k = nonzero(-5, 5)
        deg = randint(3, 6)
        a = nonzero(-8, 8)
        
        coeffs = [randint(-10, 10) for _ in 1:(deg-1)]
        pushfirst!(coeffs, a)
        poly = sum([c * x^(deg - i) for (i, c) in enumerate(coeffs)])
        
        if k > 0
            expr = poly / (ℯ^(k*x))
            answer = "0"
            solution_text = steps(
                sol("Given", poly / (ℯ^(k*x))),
                "Exponential ℯ^{$(k)x} grows faster than any polynomial",
                "By L'Hôpital's rule applied $(deg) times, or by comparison",
                sol("Answer", 0)
            )
        else
            expr = (ℯ^(k*x)) / poly
            answer = "0"
            solution_text = steps(
                sol("Given", (ℯ^(k*x)) / poly),
                "Since k = $(k) < 0, ℯ^{$(k)x} → 0 as x → ∞",
                "Numerator approaches 0, denominator grows without bound",
                sol("Answer", 0)
            )
        end
        
        problem(
            question="Find \\lim_{x \\to \\infty} $(tex(expr))",
            answer=answer,
            difficulty=(2600, 3100),
            solution=solution_text,
            time=200
        )
        
    else
        # Logarithmic limit with polynomial
        deg = randint(2, 5)
        a = nonzero(-8, 8)
        b = randint(1, 4)
        
        coeffs = [randint(-10, 10) for _ in 1:(deg-1)]
        pushfirst!(coeffs, a)
        poly = sum([c * x^(deg - i) for (i, c) in enumerate(coeffs)])
        
        # ln(x^b) / polynomial or polynomial / ln(x^b)
        if rand(Bool)
            expr = log(x^b) / poly
            answer = "0"
            solution_text = steps(
                sol("Given", log(x^b) / poly),
                "Rewrite: $(b)\\ln(x) / ($(tex(poly)))",
                "Polynomial grows faster than logarithm",
                "By L'Hôpital or growth comparison: limit is 0",
                sol("Answer", 0)
            )
        else
            expr = poly / log(x^b)
            answer = "DNE"
            if a > 0
                solution_text = steps(
                    sol("Given", poly / log(x^b)),
                    "Rewrite: ($(tex(poly))) / ($(b)\\ln(x))",
                    "Polynomial of degree $(deg) grows faster than logarithm",
                    "Limit approaches +∞ or -∞ depending on sign",
                    sol("Answer", "DNE")
                )
            else
                solution_text = steps(
                    sol("Given", poly / log(x^b)),
                    "Rewrite: ($(tex(poly))) / ($(b)\\ln(x))",
                    "Leading coefficient is negative, polynomial → -∞",
                    "Limit approaches -∞ (does not exist)",
                    sol("Answer", "DNE")
                )
            end
        end
        
        problem(
            question="Find \\lim_{x \\to \\infty} $(tex(expr))",
            answer=answer,
            difficulty=(2700, 3300),
            solution=solution_text,
            time=220
        )
    end
end