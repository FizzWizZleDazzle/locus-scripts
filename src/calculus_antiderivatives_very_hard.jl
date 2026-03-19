# calculus - antiderivatives (very_hard)
# Generated: 2026-03-08T20:45:04.560301

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t begin
    set_topic!("calculus/antiderivatives")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition: Tricky trigonometric antiderivative with substitution
        a = nonzero(-5, 5)
        b = nonzero(2, 8)
        n = rand(2:5)
        
        # Construct f(x) = a·sin^n(bx)·cos(bx) so antiderivative involves u-substitution
        integrand = a * sin(b*x)^n * cos(b*x)
        
        # Answer: a/(b(n+1)) · sin^(n+1)(bx) + C
        antideriv = (a//(b*(n+1))) * sin(b*x)^(n+1)
        
        problem(
            question="Find the antiderivative: \\\$\\int $(tex(integrand)) \\, dx\\\$",
            answer=antideriv,
            difficulty=(2400, 2800),
            solution=steps(
                sol("Given", integrand),
                "Let \\\$u = \\sin($(b)x)\\\$, then \\\$du = $(b)\\cos($(b)x) \\, dx\\\$",
                "Rewrite: \\\$\\int $(tex(a)) u^{$(n)} \\cdot \\frac{1}{$(b)} \\, du = \\frac{$(a)}{$(b)} \\int u^{$(n)} \\, du\\\$",
                "Integrate: \\\$\\frac{$(a)}{$(b)} \\cdot \\frac{u^{$(n+1)}}{$(n+1)} + C = \\frac{$(a)}{$(b*(n+1))} u^{$(n+1)} + C\\\$",
                sol("Answer", antideriv, "+ C")
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Competition/Olympiad: Rational function requiring partial fractions
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        A = nonzero(-6, 6)
        B = nonzero(-6, 6)
        
        # Construct numerator: A(x-r2) + B(x-r1)
        numerator = expand(A*(x - r2) + B*(x - r1))
        denominator = expand((x - r1)*(x - r2))
        
        # Antiderivative: A·ln|x-r1| + B·ln|x-r2| + C
        # For answer checking, we'll use the expanded form
        antideriv_terms = A*log(abs(x - r1)) + B*log(abs(x - r2))
        
        problem(
            question="Find \\\$\\int \\frac{$(tex(numerator))}{$(tex(denominator))} \\, dx\\\$",
            answer=antideriv_terms,
            difficulty=(2600, 3200),
            solution=steps(
                sol("Given", numerator / denominator),
                "Use partial fractions: \\\$\\frac{$(tex(numerator))}{$(tex(denominator))} = \\frac{$(A)}{x - $(r1)} + \\frac{$(B)}{x - $(r2)}\\\$",
                "Integrate term by term: \\\$\\int \\frac{$(A)}{x - $(r1)} \\, dx + \\int \\frac{$(B)}{x - $(r2)} \\, dx\\\$",
                sol("Answer", "$(A)\\ln|x - $(r1)| + $(B)\\ln|x - $(r2)| + C")
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Integration by parts with polynomial and exponential
        n = rand(2:4)
        k = nonzero(-4, 4)
        a = nonzero(-8, 8)
        
        # f(x) = a·x^n·e^(kx)
        integrand = a * x^n * exp(k*x)
        
        problem(
            question="Find \\\$\\int $(tex(integrand)) \\, dx\\\$ using integration by parts $(n) times.",
            answer="Use repeated integration by parts",
            difficulty=(3000, 3600),
            grading_mode="proof",
            solution=steps(
                sol("Given", integrand),
                "Apply integration by parts with \\\$u = $(tex(a*x^n))\\\$, \\\$dv = e^{$(k)x} dx\\\$",
                "Then \\\$du = $(tex(a*n*x^(n-1))) dx\\\$, \\\$v = \\frac{1}{$(k)}e^{$(k)x}\\\$",
                "This gives: \\\$\\frac{$(a)}{$(k)}x^{$(n)}e^{$(k)x} - \\frac{$(a*n)}{$(k)} \\int x^{$(n-1)}e^{$(k)x} \\, dx\\\$",
                "Continue applying integration by parts $(n-1) more time(s)",
                "The final result is a sum of terms involving \\\$x^{$(n)}, x^{$(n-1)}, \\ldots, x, 1\\\$ each multiplied by \\\$e^{$(k)x}\\\$"
            ),
            time=360
        )
        
    else
        # Competition: Trigonometric substitution with radicals
        a = rand(2:9)
        b = nonzero(-7, 7)
        
        # ∫ dx/sqrt(a^2 - (x-b)^2)
        # Answer: arcsin((x-b)/a) + C
        
        radical = sqrt(a^2 - (x - b)^2)
        integrand = 1 / radical
        antideriv = asin((x - b) / a)
        
        problem(
            question="Find \\\$\\int \\frac{1}{\\sqrt{$(a^2) - (x - $(b))^2}} \\, dx\\\$",
            answer=antideriv,
            difficulty=(2500, 3000),
            solution=steps(
                sol("Given", integrand),
                "Let \\\$u = x - $(b)\\\$, then \\\$du = dx\\\$",
                "Substitute: \\\$\\int \\frac{1}{\\sqrt{$(a^2) - u^2}} \\, du\\\$",
                "This is the standard form \\\$\\int \\frac{1}{\\sqrt{a^2 - u^2}} \\, du = \\arcsin\\left(\\frac{u}{a}\\right) + C\\\$",
                sol("Answer", "\\arcsin\\left(\\frac{x - $(b)}{$(a)}\\right) + C")
            ),
            time=280
        )
    end
end