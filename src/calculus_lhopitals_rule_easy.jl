# calculus - lhopitals_rule (easy)
# Generated: 2026-03-08T20:43:55.183146

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/lhopitals_rule")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # 0/0 form: (x - a) / (x - a) with polynomials
        a = randint(-8, 8)
        k = nonzero(-5, 5)
        m = nonzero(-3, 3)
        
        # Numerator: k(x - a)
        num = expand(k * (x - a))
        # Denominator: m(x - a)
        den = expand(m * (x - a))
        
        num_deriv = diff(num, x)
        den_deriv = diff(den, x)
        
        limit_val = substitute(num_deriv / den_deriv, x => a)
        
        problem(
            question = "Evaluate \\lim_{x \\to $(a)} \\frac{$(tex(num))}{$(tex(den))} using L'Hôpital's rule.",
            answer = limit_val,
            difficulty = (700, 900),
            solution = steps(
                sol("Given", "\\lim_{x \\to $(a)} \\frac{$(tex(num))}{$(tex(den))}"),
                "This is \\frac{0}{0} form. Apply L'Hôpital's rule: differentiate numerator and denominator.",
                sol("Numerator derivative", num_deriv),
                sol("Denominator derivative", den_deriv),
                sol("Limit", "\\frac{$(tex(num_deriv))}{$(tex(den_deriv))} = $(limit_val)")
            ),
            time = 90
        )
        
    elseif problem_type == 2
        # 0/0 form: (x^2 - a^2) / (x - a)
        a = randint(-6, 6)
        
        num = expand(x^2 - a^2)
        den = x - a
        
        num_deriv = diff(num, x)
        den_deriv = diff(den, x)
        
        limit_val = substitute(num_deriv / den_deriv, x => a)
        
        problem(
            question = "Evaluate \\lim_{x \\to $(a)} \\frac{$(tex(num))}{$(tex(den))} using L'Hôpital's rule.",
            answer = limit_val,
            difficulty = (750, 950),
            solution = steps(
                sol("Given", "\\lim_{x \\to $(a)} \\frac{$(tex(num))}{$(tex(den))}"),
                "Substituting x = $(a) gives \\frac{0}{0}. Apply L'Hôpital's rule.",
                sol("\\frac{d}{dx}[$(tex(num))]", num_deriv),
                sol("\\frac{d}{dx}[$(tex(den))]", den_deriv),
                sol("Answer", "\\lim_{x \\to $(a)} \\frac{$(tex(num_deriv))}{$(tex(den_deriv))} = $(limit_val)")
            ),
            time = 100
        )
        
    elseif problem_type == 3
        # Polynomial over polynomial at infinity (leading coefficients)
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        
        num = expand(a*x + b)
        den = expand(c*x + d)
        
        num_deriv = diff(num, x)
        den_deriv = diff(den, x)
        
        limit_val = a // c
        
        problem(
            question = "Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(num))}{$(tex(den))} using L'Hôpital's rule.",
            answer = limit_val,
            difficulty = (800, 1000),
            solution = steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(num))}{$(tex(den))}"),
                "This is \\frac{\\infty}{\\infty} form. Apply L'Hôpital's rule.",
                sol("Numerator derivative", num_deriv),
                sol("Denominator derivative", den_deriv),
                sol("Answer", "\\lim_{x \\to \\infty} \\frac{$(a)}{$(c)} = $(limit_val)")
            ),
            time = 90
        )
        
    elseif problem_type == 4
        # Quadratic over linear 0/0 form
        a = randint(-5, 5)
        k = nonzero(-4, 4)
        
        num = expand(k * (x - a) * (x + randint(-5, 5)))
        den = x - a
        
        num_deriv = diff(num, x)
        den_deriv = diff(den, x)
        
        limit_val = substitute(num_deriv / den_deriv, x => a)
        
        problem(
            question = "Evaluate \\lim_{x \\to $(a)} \\frac{$(tex(num))}{$(tex(den))} using L'Hôpital's rule.",
            answer = limit_val,
            difficulty = (850, 1050),
            solution = steps(
                sol("Given", "\\lim_{x \\to $(a)} \\frac{$(tex(num))}{$(tex(den))}"),
                "Substituting gives \\frac{0}{0}. Apply L'Hôpital's rule.",
                sol("f'(x)", num_deriv),
                sol("g'(x)", den_deriv),
                sol("Answer", "\\lim_{x \\to $(a)} \\frac{$(tex(num_deriv))}{$(tex(den_deriv))} = $(limit_val)")
            ),
            time = 120
        )
        
    else
        # (x^n - a^n) / (x - a) form
        a = choice([1, 2, 3, 4])
        n = choice([2, 3, 4])
        
        num = expand(x^n - a^n)
        den = x - a
        
        num_deriv = diff(num, x)
        den_deriv = diff(den, x)
        
        limit_val = substitute(num_deriv / den_deriv, x => a)
        
        problem(
            question = "Evaluate \\lim_{x \\to $(a)} \\frac{x^{$(n)} - $(a^n)}{x - $(a)} using L'Hôpital's rule.",
            answer = limit_val,
            difficulty = (900, 1100),
            solution = steps(
                sol("Given", "\\lim_{x \\to $(a)} \\frac{x^{$(n)} - $(a^n)}{x - $(a)}"),
                "This is \\frac{0}{0} indeterminate form. Apply L'Hôpital's rule.",
                sol("Numerator derivative", num_deriv),
                sol("Denominator derivative", den_deriv),
                sol("Answer", "\\lim_{x \\to $(a)} \\frac{$(tex(num_deriv))}{$(tex(den_deriv))} = $(limit_val)")
            ),
            time = 110
        )
    end
end