# calculus - antiderivatives (very_easy)
# Generated: 2026-03-08T20:44:31.581935

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/antiderivatives")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Simple power rule: ∫x^n dx where n is small positive integer
        n = randint(1, 4)
        integrand = x^n
        antideriv = x^(n+1) / (n+1)
        
        problem(
            question="Find the antiderivative: \$\\int $(tex(integrand)) \\, dx\$",
            answer=antideriv,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", integrand),
                "Apply power rule: \\(\\int x^n \\, dx = \\frac{x^{n+1}}{n+1} + C\\)",
                sol("Answer", antideriv)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Constant multiple: ∫k dx
        k = nonzero(-10, 10)
        integrand = k
        antideriv = k*x
        
        problem(
            question="Find the antiderivative: \$\\int $(k) \\, dx\$",
            answer=antideriv,
            difficulty=(100, 300),
            solution=steps(
                sol("Given", integrand),
                "The antiderivative of a constant \\(k\\) is \\(kx + C\\)",
                sol("Answer", antideriv)
            ),
            time=30
        )
        
    elseif problem_type == 3
        # Simple constant coefficient: ∫kx^n dx
        k = nonzero(-8, 8)
        n = randint(2, 5)
        integrand = k * x^n
        antideriv = k * x^(n+1) / (n+1)
        
        problem(
            question="Find the antiderivative: \$\\int $(tex(integrand)) \\, dx\$",
            answer=antideriv,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", integrand),
                "Pull out constant: \\($(k) \\int x^{$(n)} \\, dx\\)",
                "Apply power rule: \\($(k) \\cdot \\frac{x^{$(n+1)}}{$(n+1)} + C\\)",
                sol("Answer", antideriv)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Sum of two power terms: ∫(ax^m + bx^n) dx
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        m = randint(1, 3)
        n = randint(1, 3)
        while n == m
            n = randint(1, 3)
        end
        integrand = a*x^m + b*x^n
        antideriv = a*x^(m+1)/(m+1) + b*x^(n+1)/(n+1)
        
        problem(
            question="Find the antiderivative: \$\\int ($(tex(integrand))) \\, dx\$",
            answer=antideriv,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", integrand),
                "Integrate term by term using power rule",
                "\\(\\int $(tex(a*x^m)) \\, dx = $(tex(a*x^(m+1)/(m+1)))\\)",
                "\\(\\int $(tex(b*x^n)) \\, dx = $(tex(b*x^(n+1)/(n+1)))\\)",
                sol("Answer", antideriv)
            ),
            time=75
        )
        
    else
        # Three term polynomial: ∫(ax^2 + bx + c) dx
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-10, 10)
        integrand = a*x^2 + b*x + c
        antideriv = a*x^3/3 + b*x^2/2 + c*x
        
        problem(
            question="Find the antiderivative: \$\\int ($(tex(integrand))) \\, dx\$",
            answer=antideriv,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", integrand),
                "Integrate each term separately using power rule",
                "\\(\\int $(tex(a*x^2)) \\, dx = $(tex(a*x^3/3))\\)",
                "\\(\\int $(tex(b*x)) \\, dx = $(tex(b*x^2/2))\\)",
                "\\(\\int $(c) \\, dx = $(tex(c*x))\\)",
                sol("Answer", antideriv)
            ),
            time=90
        )
    end
end