# calculus - u_substitution (very_easy)
# Generated: 2026-03-08T20:45:12.074062

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x u begin
    set_topic!("calculus/u_substitution")
    
    # Choose problem type randomly
    problem_type = choice([1, 2, 3, 4])
    
    if problem_type == 1
        # Type 1: ∫ (ax+b)^n dx where n is a simple integer (FOUNDATIONAL: 100-400)
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        n = choice([2, 3, 4, 5])
        
        integrand = (a*x + b)^n
        
        # Answer: (ax+b)^(n+1) / (a(n+1)) + C
        antideriv = (a*x + b)^(n+1) / (a*(n+1))
        
        problem(
            question="Find \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(a*x + b)), then du = $(a) dx",
                "Rewrite: \\int u^{$n} \\cdot \\frac{1}{$a} du = \\frac{1}{$a} \\cdot \\frac{u^{$(n+1)}}{$(n+1)} + C",
                sol("Substitute back", antideriv)
            ),
            time=90
        )
    elseif problem_type == 2
        # Type 2: ∫ 2x(x^2 + c)^n dx (ELEMENTARY: 400-700)
        c = randint(-8, 8)
        n = choice([1, 2, 3])
        
        integrand = 2*x*(x^2 + c)^n
        
        # Answer: (x^2+c)^(n+1) / (n+1) + C
        antideriv = (x^2 + c)^(n+1) / (n+1)
        
        problem(
            question="Find \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(450, 650),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(x^2 + c)), then du = $(tex(2*x)) dx",
                "Rewrite: \\int u^{$n} du = \\frac{u^{$(n+1)}}{$(n+1)} + C",
                sol("Substitute back", antideriv)
            ),
            time=120
        )
    elseif problem_type == 3
        # Type 3: ∫ (ax)(bx^2 + c)^n dx (ELEMENTARY: 500-700)
        a = nonzero(-4, 4)
        b = nonzero(-3, 3)
        c = randint(-10, 10)
        n = choice([2, 3])
        
        integrand = a*x*(b*x^2 + c)^n
        
        # Answer: a/(2b) * (bx^2+c)^(n+1) / (n+1) + C
        coeff = a // (2*b*(n+1))
        antideriv = coeff * (b*x^2 + c)^(n+1)
        
        problem(
            question="Find \\int $(tex(integrand)) \\, dx",
            answer=antideriv,
            difficulty=(550, 700),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(b*x^2 + c)), then du = $(tex(2*b*x)) dx",
                "Rewrite: $(tex(a*x)) dx = \\frac{$a}{$(2*b)} du",
                "\\int u^{$n} \\cdot \\frac{$a}{$(2*b)} du = $(tex(coeff)) \\cdot \\frac{u^{$(n+1)}}{1} + C",
                sol("Substitute back", antideriv)
            ),
            time=150
        )
    else
        # Type 4: ∫ 1/(ax+b) dx (FOUNDATIONAL/ELEMENTARY: 300-500)
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        
        integrand = 1 // (a*x + b)
        
        # Answer: (1/a) * ln|ax+b| + C
        # We'll express as symbolic for grading
        antideriv_expr = simplify(1//a * log(abs(a*x + b)))
        
        problem(
            question="Find \\int $(tex(integrand)) \\, dx",
            answer=antideriv_expr,
            difficulty=(350, 550),
            solution=steps(
                sol("Given", integrand),
                "Let u = $(tex(a*x + b)), then du = $a dx, so dx = \\frac{1}{$a} du",
                "Rewrite: \\int \\frac{1}{u} \\cdot \\frac{1}{$a} du = \\frac{1}{$a} \\ln|u| + C",
                sol("Substitute back", antideriv_expr)
            ),
            time=120
        )
    end
end