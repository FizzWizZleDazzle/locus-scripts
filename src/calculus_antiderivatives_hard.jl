# calculus - antiderivatives (hard)
# Generated: 2026-03-08T20:45:00.179078

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/antiderivatives")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Polynomial antiderivative with substitution
        inner = rand_linear(x; a=(-5,5), b=(-12,12))
        n = rand(3:7)
        integrand = expand(inner.expr^n * inner.a)
        
        # Compute antiderivative
        antider = simplify((inner.expr^(n+1)) / (n+1))
        
        problem(
            question="Find \\int $(tex(integrand)) \\, dx",
            answer=antider,
            difficulty=(1800, 2100),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(inner.expr)), then du = $(inner.a) dx",
                "Integral becomes: \\int u^{$(n)} \\, du = \\frac{u^{$(n+1)}}{$(n+1)} + C",
                sol("Substituting back", antider)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Rational function requiring partial fractions or clever manipulation
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        # Create integrand of form 1/((x-r1)(x-r2))
        denom = expand((x - r1) * (x - r2))
        
        # Antiderivative involves logarithms
        # ∫ 1/((x-r1)(x-r2)) dx = (1/(r2-r1))[ln|x-r2| - ln|x-r1|] + C
        
        problem(
            question="Find \\int \\frac{1}{$(tex(denom))} \\, dx",
            answer="\\frac{1}{$(r2-r1)}\\ln\\left|\\frac{x-$(r2)}{x-$(r1)}\\right| + C",
            difficulty=(2000, 2300),
            grading_mode="symbolic_equiv",
            solution=steps(
                sol("Given", 1/denom),
                "Factor denominator: (x - $(r1))(x - $(r2))",
                "Use partial fractions: \\frac{1}{(x-$(r1))(x-$(r2))} = \\frac{A}{x-$(r1)} + \\frac{B}{x-$(r2)}",
                "Solving: A = \\frac{1}{$(r1-r2)}, B = \\frac{1}{$(r2-r1)}",
                "Integrate: \\frac{1}{$(r1-r2)}\\ln|x-$(r1)| + \\frac{1}{$(r2-r1)}\\ln|x-$(r2)| + C",
                sol("Simplify", "\\frac{1}{$(r2-r1)}\\ln\\left|\\frac{x-$(r2)}{x-$(r1)}\\right| + C")
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Trigonometric substitution or integration by parts
        a = nonzero(2, 6)
        b = randint(-10, 10)
        
        # Integrand like x * (ax + b)^n
        n = rand(4:8)
        inner = a*x + b
        integrand = expand(x * inner^n)
        
        # Use integration by parts or substitution
        # Let u = ax + b, x = (u - b)/a
        # ∫ x(ax+b)^n dx = ∫ (u-b)/a * u^n * (1/a) du = (1/a²)[∫u^(n+1) - b*u^n du]
        
        term1_coef = 1 // (a^2 * (n+2))
        term2_coef = -b // (a^2 * (n+1))
        
        antider_expr = simplify(term1_coef * inner^(n+2) + term2_coef * inner^(n+1))
        
        problem(
            question="Find \\int $(tex(integrand)) \\, dx",
            answer=antider_expr,
            difficulty=(1900, 2200),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(inner)), then x = \\frac{u - $(b)}{$(a)} and du = $(a) dx",
                "Substituting: \\int \\frac{u-$(b)}{$(a)} \\cdot u^{$(n)} \\cdot \\frac{1}{$(a)} \\, du",
                "= \\frac{1}{$(a^2)}\\int (u^{$(n+1)} - $(b)u^{$(n)}) \\, du",
                "= \\frac{1}{$(a^2)}\\left[\\frac{u^{$(n+2)}}{$(n+2)} - \\frac{$(b)u^{$(n+1)}}{$(n+1)}\\right] + C",
                sol("Substituting back", antider_expr)
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Definite integral with bounds that give clean answer
        a = nonzero(2, 5)
        lower = randint(-8, -1)
        upper = randint(1, 8)
        
        # Integrand: ax^2
        integrand = a * x^2
        antider = a * x^3 // 3
        
        val_upper = a * upper^3 // 3
        val_lower = a * lower^3 // 3
        ans = val_upper - val_lower
        
        problem(
            question="Evaluate \\int_{$(lower)}^{$(upper)} $(tex(integrand)) \\, dx",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", integrand),
                "Antiderivative: F(x) = $(tex(antider))",
                "Evaluate: F($(upper)) - F($(lower))",
                "= $(tex(val_upper)) - ($(tex(val_lower)))",
                sol("Answer", ans)
            ),
            time=150
        )
        
    else  # problem_type == 5
        # Composite function requiring chain rule in reverse
        outer_pow = rand(3:6)
        inner = rand_quadratic(x; a=(-4,4), b=(-8,8), c=(-12,12))
        inner_deriv = diff(inner.expr, x)
        
        integrand = expand(inner.expr^outer_pow * inner_deriv)
        antider = simplify(inner.expr^(outer_pow + 1) / (outer_pow + 1))
        
        problem(
            question="Find \\int $(tex(integrand)) \\, dx",
            answer=antider,
            difficulty=(1900, 2200),
            solution=steps(
                sol("Given", integrand),
                "Notice that $(tex(inner_deriv)) is the derivative of $(tex(inner.expr))",
                "Let u = $(tex(inner.expr)), then du = $(tex(inner_deriv)) dx",
                "Integral becomes: \\int u^{$(outer_pow)} \\, du = \\frac{u^{$(outer_pow+1)}}{$(outer_pow+1)} + C",
                sol("Substituting back", antider)
            ),
            time=200
        )
    end
end