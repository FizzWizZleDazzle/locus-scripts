# calculus - u_substitution (easy)
# Generated: 2026-03-08T20:45:22.531524

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x u begin
    set_topic!("calculus/u_substitution")
    
    # Choose problem type randomly
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: ∫ (ax+b)^n dx where n ≠ -1
        # Pick clean answer first
        a = nonzero(-5, 5)
        b = randint(-15, 15)
        n = choice([2, 3, 4, 5])
        
        inner = a*x + b
        integrand = inner^n
        
        # Antiderivative: (ax+b)^(n+1) / (a(n+1)) + C
        antideriv = inner^(n+1) / (a*(n+1))
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(inner)), then du = $(a) dx",
                "Rewrite: \\int u^{$(n)} \\cdot \\frac{1}{$(a)} du = \\frac{1}{$(a)} \\cdot \\frac{u^{$(n+1)}}{$(n+1)} + C",
                sol("Substitute back", antideriv)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: ∫ f'(x) * [f(x)]^n dx
        # Example: ∫ 2x(x²+c)^n dx
        a = choice([2, 3, 4])
        c = randint(-10, 10)
        n = choice([2, 3, 4])
        
        inner = x^2 + c
        integrand = a*x * inner^n
        
        # u = x² + c, du = 2x dx
        # Answer: (x²+c)^(n+1) / (2(n+1)) * a + C
        antideriv = inner^(n+1) * a / (2*(n+1))
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(inner)), then du = $(tex(2*x)) dx",
                "Rewrite: \\int u^{$(n)} \\cdot \\frac{$(a)}{2} du = \\frac{$(a)}{2} \\cdot \\frac{u^{$(n+1)}}{$(n+1)} + C",
                sol("Substitute back", antideriv)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Type 3: ∫ 1/(ax+b) dx
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        
        inner = a*x + b
        integrand = 1/inner
        
        # Answer: ln|ax+b|/a + C
        # We'll format as string since ln needs special handling
        answer_str = "\\frac{1}{$(a)}\\ln|$(tex(inner))|"
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=answer_str,
            difficulty=(900, 1100),
            answer_type="expression",
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(inner)), then du = $(a) dx",
                "Rewrite: \\int \\frac{1}{u} \\cdot \\frac{1}{$(a)} du = \\frac{1}{$(a)} \\ln|u| + C",
                "Substitute back: \\frac{1}{$(a)}\\ln|$(tex(inner))| + C"
            ),
            time=120
        )
        
    else
        # Type 4: ∫ (ax+b)^n * cx dx where cx is NOT the derivative of (ax+b)
        # Requires algebraic manipulation before substitution
        a = choice([2, 3])
        b = randint(-8, 8)
        c = nonzero(-4, 4)
        n = choice([2, 3])
        
        inner = a*x + b
        integrand = c*x * inner^n
        
        # u = ax+b, x = (u-b)/a, dx = du/a
        # ∫ c*(u-b)/a * u^n * (1/a) du = (c/a²) ∫ (u^(n+1) - b*u^n) du
        # = (c/a²)[u^(n+2)/(n+2) - b*u^(n+1)/(n+1)] + C
        
        term1_coef = c // (a^2 * (n+2))
        term2_coef = -c*b // (a^2 * (n+1))
        antideriv = term1_coef * inner^(n+2) + term2_coef * inner^(n+1)
        
        problem(
            question="Evaluate \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(inner)), then x = \\frac{u - $(b)}{$(a)} and dx = \\frac{1}{$(a)} du",
                "Substitute: \\int $(c) \\cdot \\frac{u-$(b)}{$(a)} \\cdot u^{$(n)} \\cdot \\frac{1}{$(a)} du",
                "Expand and integrate term by term",
                sol("Substitute back", antideriv)
            ),
            time=180
        )
    end
end