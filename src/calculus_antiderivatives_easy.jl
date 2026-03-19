# calculus - antiderivatives (easy)
# Generated: 2026-03-08T20:44:37.593002

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/antiderivatives")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Basic power rule: integrate x^n
        n = choice([2, 3, 4, 5])
        expr = x^n
        antideriv = x^(n+1) / (n+1)
        
        problem(
            question="Find \\(\\int $(tex(expr)) \\, dx\\)",
            answer=antideriv,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", expr),
                "Apply power rule: \\(\\int x^n \\, dx = \\frac{x^{n+1}}{n+1} + C\\)",
                sol("Answer", antideriv)
            ),
            time=60,
            grading_mode="antiderivative"
        )
        
    elseif problem_type == 2
        # Polynomial antiderivative
        q = rand_quadratic(x; a=(-8,8), b=(-12,12), c=(-15,15))
        expr = q.expr
        antideriv = q.a * x^3 / 3 + q.b * x^2 / 2 + q.c * x
        
        problem(
            question="Find \\(\\int ($(tex(expr))) \\, dx\\)",
            answer=antideriv,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", expr),
                "Integrate term by term using power rule",
                sol("\\int $(q.a)x^2 \\, dx", q.a * x^3 / 3),
                sol("\\int $(q.b)x \\, dx", q.b * x^2 / 2),
                sol("\\int $(q.c) \\, dx", q.c * x),
                sol("Answer", antideriv)
            ),
            time=90,
            grading_mode="antiderivative"
        )
        
    elseif problem_type == 3
        # Linear combination with constants
        a = nonzero(-10, 10)
        b = nonzero(-10, 10)
        n = choice([2, 3, 4])
        expr = a * x^n + b
        antideriv = a * x^(n+1) / (n+1) + b * x
        
        problem(
            question="Evaluate \\(\\int ($(tex(expr))) \\, dx\\)",
            answer=antideriv,
            difficulty=(750, 950),
            solution=steps(
                sol("Given", expr),
                "Apply power rule to each term",
                sol("\\int $(a)x^$(n) \\, dx", a * x^(n+1) / (n+1)),
                sol("\\int $(b) \\, dx", b * x),
                sol("Answer", antideriv)
            ),
            time=75,
            grading_mode="antiderivative"
        )
        
    elseif problem_type == 4
        # Cubic polynomial
        p = rand_poly(x, 3; coeff=(-6, 6))
        expr = p.expr
        a, b, c, d = length(p.coeffs) >= 4 ? (p.coeffs[1], p.coeffs[2], p.coeffs[3], p.coeffs[4]) : (p.coeffs[1], length(p.coeffs) >= 2 ? p.coeffs[2] : 0, length(p.coeffs) >= 3 ? p.coeffs[3] : 0, 0)
        antideriv = a * x^4 / 4 + b * x^3 / 3 + c * x^2 / 2 + d * x
        
        problem(
            question="Find the antiderivative: \\(\\int ($(tex(expr))) \\, dx\\)",
            answer=antideriv,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", expr),
                "Integrate each term using \\(\\int x^n \\, dx = \\frac{x^{n+1}}{n+1} + C\\)",
                "Apply power rule term by term",
                sol("Answer", antideriv)
            ),
            time=120,
            grading_mode="antiderivative"
        )
        
    else
        # Mix of terms with different powers
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-12, 12)
        n1 = choice([3, 4, 5])
        n2 = choice([1, 2])
        expr = a * x^n1 + b * x^n2 + c
        antideriv = a * x^(n1+1) / (n1+1) + b * x^(n2+1) / (n2+1) + c * x
        
        problem(
            question="Calculate \\(\\int ($(tex(expr))) \\, dx\\)",
            answer=antideriv,
            difficulty=(850, 1050),
            solution=steps(
                sol("Given", expr),
                "Use power rule on each term: \\(\\int x^n \\, dx = \\frac{x^{n+1}}{n+1} + C\\)",
                sol("First term", a * x^(n1+1) / (n1+1)),
                sol("Second term", b * x^(n2+1) / (n2+1)),
                sol("Third term", c * x),
                sol("Answer", antideriv)
            ),
            time=100,
            grading_mode="antiderivative"
        )
    end
end