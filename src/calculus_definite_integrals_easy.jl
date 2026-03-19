# calculus - definite_integrals (easy)
# Generated: 2026-03-08T20:46:58.950565

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/definite_integrals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple polynomial integral with nice limits (700-900 ELO)
        a = nonzero(-8, 8)
        b = randint(-12, 12)
        lower = randint(-5, 2)
        upper = randint(lower + 1, 8)
        
        f = a*x + b
        antideriv = (a//2)*x^2 + b*x
        
        upper_val = substitute(antideriv, x => upper)
        lower_val = substitute(antideriv, x => lower)
        ans = simplify(upper_val - lower_val)
        
        problem(
            question="Evaluate \\int_{$(lower)}^{$(upper)} ($(tex(f))) \\, dx",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("Integrand", f),
                sol("Antiderivative", antideriv),
                "Evaluate at bounds: \\left[$(tex(antideriv))\\right]_{$(lower)}^{$(upper)}",
                "= ($(tex(upper_val))) - ($(tex(lower_val)))",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Quadratic integral (800-1000 ELO)
        a = nonzero(-4, 4)
        b = randint(-8, 8)
        c = randint(-10, 10)
        lower = randint(-4, 1)
        upper = randint(lower + 1, 5)
        
        f = a*x^2 + b*x + c
        antideriv = (a//3)*x^3 + (b//2)*x^2 + c*x
        
        upper_val = substitute(antideriv, x => upper)
        lower_val = substitute(antideriv, x => lower)
        ans = simplify(upper_val - lower_val)
        
        problem(
            question="Evaluate \\int_{$(lower)}^{$(upper)} ($(tex(f))) \\, dx",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Integrand", f),
                "Apply power rule for integration",
                sol("Antiderivative", antideriv),
                "Evaluate at bounds: \\left[$(tex(antideriv))\\right]_{$(lower)}^{$(upper)}",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Power rule with single term (700-850 ELO)
        n = randint(2, 5)
        a = nonzero(-6, 6)
        lower = randint(0, 2)
        upper = randint(lower + 1, 4)
        
        f = a*x^n
        antideriv = (a//(n+1))*x^(n+1)
        
        upper_val = substitute(antideriv, x => upper)
        lower_val = substitute(antideriv, x => lower)
        ans = simplify(upper_val - lower_val)
        
        problem(
            question="Evaluate \\int_{$(lower)}^{$(upper)} $(tex(f)) \\, dx",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                sol("Integrand", f),
                "Power rule: \\int x^n dx = \\frac{x^{n+1}}{n+1}",
                sol("Antiderivative", antideriv),
                "Evaluate: \\left[$(tex(antideriv))\\right]_{$(lower)}^{$(upper)}",
                sol("Answer", ans)
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Sum of terms (900-1100 ELO)
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = randint(-10, 10)
        lower = randint(-3, 0)
        upper = randint(lower + 2, 4)
        
        f = a*x^2 + b*x + c
        antideriv = (a//3)*x^3 + (b//2)*x^2 + c*x
        
        upper_val = substitute(antideriv, x => upper)
        lower_val = substitute(antideriv, x => lower)
        ans = simplify(upper_val - lower_val)
        
        problem(
            question="Calculate \\int_{$(lower)}^{$(upper)} ($(tex(f))) \\, dx",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given integral", f),
                "Integrate term by term",
                sol("Antiderivative", antideriv),
                "Apply fundamental theorem: F($(upper)) - F($(lower))",
                "= $(tex(upper_val)) - ($(tex(lower_val)))",
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Cubic polynomial (1000-1200 ELO)
        a = nonzero(-3, 3)
        b = randint(-6, 6)
        c = randint(-8, 8)
        d = randint(-10, 10)
        lower = randint(-2, 0)
        upper = randint(lower + 1, 3)
        
        f = a*x^3 + b*x^2 + c*x + d
        antideriv = (a//4)*x^4 + (b//3)*x^3 + (c//2)*x^2 + d*x
        
        upper_val = substitute(antideriv, x => upper)
        lower_val = substitute(antideriv, x => lower)
        ans = simplify(upper_val - lower_val)
        
        problem(
            question="Evaluate \\int_{$(lower)}^{$(upper)} ($(tex(f))) \\, dx",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Integrand", f),
                "Apply power rule to each term",
                sol("Antiderivative", antideriv),
                "Fundamental Theorem of Calculus:",
                "F($(upper)) - F($(lower)) = $(tex(upper_val)) - ($(tex(lower_val)))",
                sol("Answer", ans)
            ),
            time=150
        )
    end
end