# calculus - limits_at_infinity (very_easy)
# Generated: 2026-03-08T20:37:03.536873

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/limits_at_infinity")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple polynomial limit (ELO 200-400)
        # lim (x→∞) of constant or linear polynomial
        choice_type = rand(1:2)
        if choice_type == 1
            # Constant
            c = randint(-20, 20)
            expr = c
            ans = c
            sol_text = steps(
                sol("Given", "\\lim_{x \\to \\infty} $(tex(expr))"),
                "A constant function has the same value for all x",
                sol("Answer", ans)
            )
            diff_range = (100, 300)
        else
            # Linear going to ±∞
            a = nonzero(-8, 8)
            b = randint(-15, 15)
            expr = a*x + b
            ans = a > 0 ? "\\infty" : "-\\infty"
            sol_text = steps(
                sol("Given", "\\lim_{x \\to \\infty} $(tex(expr))"),
                "As x → ∞, the linear term $(a)x dominates",
                sol("Answer", ans)
            )
            diff_range = (200, 500)
        end
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} $(tex(expr))",
            answer=ans,
            difficulty=diff_range,
            solution=sol_text,
            time=45
        )
        
    elseif problem_type == 2
        # Simple rational function with same degree (ELO 400-600)
        # lim (x→∞) (ax+b)/(cx+d) = a/c
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        c = nonzero(-8, 8)
        d = randint(-15, 15)
        
        num = a*x + b
        den = c*x + d
        ans = a // c
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(num))}{$(tex(den))}",
            answer=ans,
            difficulty=(400, 650),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(num))}{$(tex(den))}"),
                "Divide numerator and denominator by x (highest power)",
                "\\lim_{x \\to \\infty} \\frac{$(a) + \\frac{$(b)}{x}}{$(c) + \\frac{$(d)}{x}}",
                "As x → ∞, terms with x in denominator approach 0",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Rational with numerator higher degree (ELO 500-700)
        # lim (x→∞) (ax²+bx+c)/(dx+e) = ±∞
        q = rand_quadratic(x; a=(-6,6))
        d = nonzero(-7, 7)
        e = randint(-12, 12)
        
        den = d*x + e
        leading_coeff = q.a
        
        # Determine sign of infinity
        if (leading_coeff > 0 && d > 0) || (leading_coeff < 0 && d < 0)
            ans = "\\infty"
        else
            ans = "-\\infty"
        end
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(q.expr))}{$(tex(den))}",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(q.expr))}{$(tex(den))}"),
                "Numerator has degree 2, denominator has degree 1",
                "Numerator grows faster than denominator",
                "Leading term ratio: \\frac{$(q.a)x^2}{$(d)x} = \\frac{$(q.a)}{$(d)}x → $(ans)",
                sol("Answer", ans)
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Rational with denominator higher degree (ELO 400-600)
        # lim (x→∞) (ax+b)/(cx²+dx+e) = 0
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        q = rand_quadratic(x; a=(-6,6))
        
        num = a*x + b
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(num))}{$(tex(q.expr))}",
            answer=0,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(num))}{$(tex(q.expr))}"),
                "Numerator has degree 1, denominator has degree 2",
                "Denominator grows faster than numerator",
                "Divide by x²: \\lim_{x \\to \\infty} \\frac{\\frac{$(a)}{x} + \\frac{$(b)}{x^2}}{$(q.a) + \\frac{$(q.b)}{x} + \\frac{$(q.c)}{x^2}} → \\frac{0}{$(q.a)}",
                sol("Answer", 0)
            ),
            time=75
        )
        
    else
        # Simple exponential or reciprocal (ELO 300-600)
        choice_exp = rand(1:2)
        if choice_exp == 1
            # lim (x→∞) 1/x^n = 0
            n = randint(1, 4)
            expr = 1 // (x^n)
            
            problem(
                question="Evaluate \\lim_{x \\to \\infty} $(tex(expr))",
                answer=0,
                difficulty=(300, 550),
                solution=steps(
                    sol("Given", "\\lim_{x \\to \\infty} \\frac{1}{x^$(n)}"),
                    "As x → ∞, x^$(n) → ∞",
                    "Therefore \\frac{1}{x^$(n)} → 0",
                    sol("Answer", 0)
                ),
                time=50
            )
        else
            # lim (x→∞) k/x = 0
            k = nonzero(-20, 20)
            expr = k // x
            
            problem(
                question="Evaluate \\lim_{x \\to \\infty} $(tex(expr))",
                answer=0,
                difficulty=(250, 500),
                solution=steps(
                    sol("Given", "\\lim_{x \\to \\infty} \\frac{$(k)}{x}"),
                    "As x → ∞, the denominator grows without bound",
                    "A constant divided by an unbounded value approaches 0",
                    sol("Answer", 0)
                ),
                time=45
            )
        end
    end
end