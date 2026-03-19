# calculus - limits_at_infinity (medium)
# Generated: 2026-03-08T20:37:33.085009

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/limits_at_infinity")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Rational function: limit at infinity (leading coefficient ratio)
        # ELO: 1200-1400
        deg_num = rand(1:3)
        deg_den = rand(1:3)
        
        a_num = nonzero(-8, 8)
        a_den = nonzero(-8, 8)
        
        num_coeffs = [a_num; [randint(-5, 5) for _ in 1:deg_num]]
        den_coeffs = [a_den; [randint(-5, 5) for _ in 1:deg_den]]
        
        num = sum(num_coeffs[i] * x^(deg_num - i + 1) for i in 1:length(num_coeffs))
        den = sum(den_coeffs[i] * x^(deg_den - i + 1) for i in 1:length(den_coeffs))
        
        f = num // den
        
        if deg_num > deg_den
            ans = "\\infty"
            explanation = "Degree of numerator ($(deg_num)) > degree of denominator ($(deg_den)), so limit is \\(\\infty\\) or \\(-\\infty\\)"
        elseif deg_num < deg_den
            ans = "0"
            explanation = "Degree of numerator ($(deg_num)) < degree of denominator ($(deg_den)), so limit is 0"
        else
            ans = string(a_num // a_den)
            explanation = "Degrees equal, so limit is ratio of leading coefficients: \\(\\frac{$(a_num)}{$(a_den)} = $(a_num // a_den)\\)"
        end
        
        problem(
            question = "Find \\(\\lim_{x \\to \\infty} $(tex(f))\\)",
            answer = ans,
            difficulty = (1200, 1400),
            solution = steps(
                sol("Given", f),
                "Compare degrees of numerator and denominator",
                explanation,
                sol("Answer", ans)
            ),
            time = 90
        )
        
    elseif problem_type == 2
        # Rational with square roots
        # ELO: 1400-1600
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        
        num = sqrt(a^2 * x^2 + b*x)
        den = c*x + d
        
        ans = string(abs(a) // abs(c))
        
        problem(
            question = "Find \\(\\lim_{x \\to \\infty} \\frac{\\sqrt{$(a^2)x^2 + $(b)x}}{$(c)x + $(d)}\\)",
            answer = ans,
            difficulty = (1400, 1600),
            solution = steps(
                "Factor \\(x^2\\) from inside the square root: \\(\\sqrt{x^2($(a^2) + \\frac{$(b)}{x})}\\)",
                "Simplify: \\(\\frac{|x|\\sqrt{$(a^2) + \\frac{$(b)}{x}}}{$(c)x + $(d)}\\)",
                "As \\(x \\to \\infty\\), \\(|x| = x\\), divide by \\(x\\)",
                "\\(\\lim_{x \\to \\infty} \\frac{\\sqrt{$(a^2) + \\frac{$(b)}{x}}}{$(c) + \\frac{$(d)}{x}} = \\frac{$(abs(a))}{$(abs(c))}\\)",
                sol("Answer", ans)
            ),
            time = 120
        )
        
    elseif problem_type == 3
        # Exponential dominance
        # ELO: 1300-1500
        a = nonzero(-5, 5)
        n = rand(2:5)
        b = nonzero(-8, 8)
        
        sign_choice = rand(1:2)
        if sign_choice == 1
            ans = "\\infty"
            expr_str = "$(a)e^x + $(b)x^$(n)"
        else
            ans = "-\\infty"
            expr_str = "$(a)e^x - $(b)x^$(n)"
        end
        
        problem(
            question = "Find \\(\\lim_{x \\to \\infty} ($(expr_str))\\)",
            answer = ans,
            difficulty = (1300, 1500),
            solution = steps(
                sol("Given", expr_str),
                "Exponential functions grow faster than polynomial functions",
                "The \\(e^x\\) term dominates as \\(x \\to \\infty\\)",
                "Since \\($(a)e^x \\to $(a > 0 ? "\\infty" : "-\\infty")\\), the limit is $(ans)",
                sol("Answer", ans)
            ),
            time = 90
        )
        
    elseif problem_type == 4
        # Two square roots (rationalize)
        # ELO: 1500-1700
        a1 = rand(1:6)
        b1 = randint(-8, 8)
        a2 = rand(1:6)
        b2 = randint(-8, 8)
        
        while a1 == a2
            a2 = rand(1:6)
        end
        
        ans = string((a1 - a2) // (2 * sqrt(max(a1, a2))))
        
        problem(
            question = "Find \\(\\lim_{x \\to \\infty} (\\sqrt{$(a1)x + $(b1)} - \\sqrt{$(a2)x + $(b2)})\\)",
            answer = a1 == a2 ? "0" : (a1 > a2 ? "\\infty" : "-\\infty"),
            difficulty = (1500, 1700),
            solution = steps(
                sol("Given", "\\sqrt{$(a1)x + $(b1)} - \\sqrt{$(a2)x + $(b2)}"),
                "Factor \\(x\\) from each square root: \\(\\sqrt{x}(\\sqrt{$(a1) + \\frac{$(b1)}{x}} - \\sqrt{$(a2) + \\frac{$(b2)}{x}})\\)",
                "As \\(x \\to \\infty\\), terms with \\(\\frac{1}{x}\\) vanish",
                "\\(\\lim_{x \\to \\infty} \\sqrt{x}(\\sqrt{$(a1)} - \\sqrt{$(a2)})\\)",
                a1 == a2 ? "Since \\(\\sqrt{$(a1)} = \\sqrt{$(a2)}\\), limit is 0" : "Since \\(\\sqrt{$(a1)} $(a1 > a2 ? ">" : "<") \\sqrt{$(a2)}\\), limit is $(a1 > a2 ? "\\infty" : "-\\infty")",
                sol("Answer", a1 == a2 ? "0" : (a1 > a2 ? "\\infty" : "-\\infty"))
            ),
            time = 150
        )
        
    else
        # Rational with absolute value
        # ELO: 1400-1600
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        
        ans = string(-abs(a) // c)
        
        problem(
            question = "Find \\(\\lim_{x \\to -\\infty} \\frac{$(a)x + $(b)}{$(c)x + $(d)}\\)",
            answer = string(a // c),
            difficulty = (1400, 1600),
            solution = steps(
                sol("Given", "\\frac{$(a)x + $(b)}{$(c)x + $(d)}"),
                "Divide numerator and denominator by \\(x\\)",
                "\\(\\lim_{x \\to -\\infty} \\frac{$(a) + \\frac{$(b)}{x}}{$(c) + \\frac{$(d)}{x}}\\)",
                "As \\(x \\to -\\infty\\), terms with \\(\\frac{1}{x}\\) approach 0",
                sol("Answer", string(a // c))
            ),
            time = 90
        )
    end
end