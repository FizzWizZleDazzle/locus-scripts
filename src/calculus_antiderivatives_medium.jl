# calculus - antiderivatives (medium)
# Generated: 2026-03-08T20:44:51.793074

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/antiderivatives")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Basic polynomial antiderivative (1200-1400)
        n = randint(2, 6)
        a = nonzero(-15, 15)
        b = nonzero(-20, 20)
        expr = a * x^n + b
        antideriv = a * x^(n+1) / (n+1) + b*x
        
        problem(
            question="Find \\int ($(tex(expr))) \\, dx",
            answer=antideriv,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", expr),
                "Apply power rule: \\int x^n \\, dx = \\frac{x^{n+1}}{n+1} + C",
                sol("Antiderivative", antideriv),
                "Don't forget +C for the constant of integration"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Multi-term polynomial (1300-1500)
        a = nonzero(-12, 12)
        b = nonzero(-15, 15)
        c = nonzero(-20, 20)
        n1 = randint(3, 7)
        n2 = randint(2, n1-1)
        expr = a * x^n1 + b * x^n2 + c
        antideriv = a * x^(n1+1) / (n1+1) + b * x^(n2+1) / (n2+1) + c*x
        
        problem(
            question="Find \\int ($(tex(expr))) \\, dx",
            answer=antideriv,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", expr),
                "Integrate term by term using power rule",
                sol("\\int $(tex(a*x^n1)) \\, dx", a*x^(n1+1)/(n1+1)),
                sol("\\int $(tex(b*x^n2)) \\, dx", b*x^(n2+1)/(n2+1)),
                sol("\\int $(c) \\, dx", c*x),
                sol("Final answer", antideriv),
                "Plus constant C"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Antiderivative with negative/fractional exponents (1400-1600)
        a = nonzero(-10, 10)
        b = nonzero(-15, 15)
        power = choice([-3, -2, -1, 1//2, 1//3, 2//3, 3//2, 5//2])
        expr = a * x^power + b
        antideriv = a * x^(power+1) / (power+1) + b*x
        
        problem(
            question="Find \\int ($(tex(expr))) \\, dx",
            answer=antideriv,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", expr),
                "Use power rule: \\int x^n \\, dx = \\frac{x^{n+1}}{n+1} + C for n \\neq -1",
                "For the first term: n = $(tex(power)), so n+1 = $(tex(power+1))",
                sol("Antiderivative", antideriv),
                "Plus constant C"
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Definite integral of polynomial (1400-1700)
        a = nonzero(-8, 8)
        n = randint(2, 5)
        b = nonzero(-12, 12)
        expr = a * x^n + b
        
        lower = randint(-5, 3)
        upper = randint(lower+2, lower+8)
        
        F_upper = a * upper^(n+1) / (n+1) + b*upper
        F_lower = a * lower^(n+1) / (n+1) + b*lower
        ans = F_upper - F_lower
        
        problem(
            question="Evaluate \\int_{$(lower)}^{$(upper)} ($(tex(expr))) \\, dx",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                sol("Given", expr),
                "Find antiderivative: F(x) = $(tex(a * x^(n+1) / (n+1) + b*x))",
                sol("F($(upper))", F_upper),
                sol("F($(lower))", F_lower),
                sol("F($(upper)) - F($(lower))", ans)
            ),
            time=180
        )
        
    elseif problem_type == 5
        # Antiderivative requiring expansion (1500-1700)
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        expr_factored = (x - r1) * (x - r2)
        expr_expanded = expand(expr_factored)
        
        # Manually compute antiderivative
        # expr_expanded = x^2 - (r1+r2)x + r1*r2
        coef_x2 = 1
        coef_x = -(r1 + r2)
        coef_const = r1 * r2
        
        antideriv = x^3/3 + coef_x * x^2 / 2 + coef_const * x
        
        problem(
            question="Find \\int ($(tex(expr_factored))) \\, dx",
            answer=antideriv,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", expr_factored),
                "Expand the product",
                sol("Expanded form", expr_expanded),
                "Integrate term by term",
                sol("Antiderivative", antideriv),
                "Plus constant C"
            ),
            time=180
        )
        
    else
        # Initial value problem (1600-1800)
        a = nonzero(-10, 10)
        n = randint(2, 5)
        b = nonzero(-15, 15)
        f_prime = a * x^n + b
        
        x0 = randint(-3, 3)
        y0 = randint(-20, 20)
        
        # General antiderivative
        general = a * x^(n+1) / (n+1) + b*x
        
        # Find C using initial condition
        C_val = y0 - (a * x0^(n+1) / (n+1) + b*x0)
        
        particular = general + C_val
        
        problem(
            question="Find f(x) given that f'(x) = $(tex(f_prime)) and f($(x0)) = $(y0)",
            answer=particular,
            difficulty=(1600, 1800),
            solution=steps(
                sol("Given f'(x)", f_prime),
                "Integrate to find general solution",
                sol("f(x)", general),
                "Note: f(x) = $(tex(general)) + C",
                "Apply initial condition f($(x0)) = $(y0)",
                sol("$(y0)", substitute(general, x => x0)),
                "Solve for C: C = $(tex(C_val))",
                sol("Final answer: f(x)", particular)
            ),
            time=240
        )
    end
end