# calculus - limits_at_infinity (easy)
# Generated: 2026-03-08T20:37:22.981782

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/limits_at_infinity")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Simple polynomial limit at infinity (700-900 ELO)
        # lim_{x→∞} (ax^n + lower terms) = ±∞ or constant
        n = randint(1, 3)
        a = nonzero(-8, 8)
        
        if n == 1
            b = randint(-15, 15)
            expr = a*x + b
            if a > 0
                ans = "\\infty"
            else
                ans = "-\\infty"
            end
            sol_text = "Leading term is $(a)x, which dominates as x→∞"
        else
            p = rand_poly(x, n; coeff=(-8, 8))
            expr = p.expr
            leading_coeff = p.coeffs[1]
            if n % 2 == 0
                ans = leading_coeff > 0 ? "\\infty" : "-\\infty"
            else
                ans = leading_coeff > 0 ? "\\infty" : "-\\infty"
            end
            sol_text = "Leading term is $(leading_coeff)x^$(n), which dominates"
        end
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} $(tex(expr))",
            answer=ans,
            difficulty=(700, 900),
            answer_type="text",
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} " * tex(expr)),
                sol_text,
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Rational function with equal degrees (800-1000 ELO)
        # lim_{x→∞} (ax^n + ...)/(bx^n + ...) = a/b
        a_num = nonzero(-9, 9)
        b_num = randint(-12, 12)
        a_den = nonzero(-9, 9)
        b_den = randint(-12, 12)
        
        numerator = a_num*x + b_num
        denominator = a_den*x + b_den
        
        ans = a_num // a_den
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{" * tex(numerator) * "}{" * tex(denominator) * "}"),
                "Divide numerator and denominator by x",
                "\\lim_{x \\to \\infty} \\frac{$(a_num) + \\frac{$(b_num)}{x}}{$(a_den) + \\frac{$(b_den)}{x}}",
                "As x→∞, the fractions approach 0",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Rational function: numerator degree > denominator (900-1100 ELO)
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = randint(-10, 10)
        d = nonzero(-8, 8)
        e = randint(-12, 12)
        
        numerator = a*x^2 + b*x + c
        denominator = d*x + e
        
        leading_ratio = a // d
        if leading_ratio > 0
            ans = "\\infty"
        else
            ans = "-\\infty"
        end
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(900, 1100),
            answer_type="text",
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{" * tex(numerator) * "}{" * tex(denominator) * "}"),
                "Numerator degree (2) > denominator degree (1)",
                "Divide by highest power in denominator: x",
                "\\lim_{x \\to \\infty} \\frac{$(a)x + $(b) + \\frac{$(c)}{x}}{$(d) + \\frac{$(e)}{x}}",
                "The numerator grows without bound",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Rational function: numerator degree < denominator (700-900 ELO)
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        e = randint(-10, 10)
        
        numerator = a*x + b
        denominator = c*x^2 + d*x + e
        
        ans = 0
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{" * tex(numerator) * "}{" * tex(denominator) * "}"),
                "Denominator degree (2) > numerator degree (1)",
                "Divide by x²: \\lim_{x \\to \\infty} \\frac{\\frac{$(a)}{x} + \\frac{$(b)}{x^2}}{$(c) + \\frac{$(d)}{x} + \\frac{$(e)}{x^2}}",
                "All fractions with x in denominator approach 0",
                sol("Answer", 0)
            ),
            time=90
        )
        
    else
        # Quadratic rational with equal degrees (900-1200 ELO)
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        c = randint(-12, 12)
        d = nonzero(-5, 5)
        e = randint(-8, 8)
        f = randint(-12, 12)
        
        numerator = a*x^2 + b*x + c
        denominator = d*x^2 + e*x + f
        
        ans = a // d
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(900, 1200),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{" * tex(numerator) * "}{" * tex(denominator) * "}"),
                "Both numerator and denominator have degree 2",
                "Divide by x²: \\lim_{x \\to \\infty} \\frac{$(a) + \\frac{$(b)}{x} + \\frac{$(c)}{x^2}}{$(d) + \\frac{$(e)}{x} + \\frac{$(f)}{x^2}}",
                "Terms with x in denominator approach 0",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end