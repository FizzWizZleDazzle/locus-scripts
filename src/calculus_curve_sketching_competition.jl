# calculus - curve_sketching (competition)
# Generated: 2026-03-08T20:43:03.441084

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/curve_sketching")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad-level: Find all functions satisfying f''(x) = f(x) with specific symmetry/periodicity constraints
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        k = choice([1, 2, 3, 4])
        
        # Function of form f(x) = a*exp(x) + b*exp(-x) with critical point constraints
        question_text = "Let \\(f(x)\\) be a twice-differentiable function on \\(\\mathbb{R}\\) satisfying \\(f''(x) = f(x)\\) for all \\(x\\), with \\(f(0) = $(a+b)\\) and \\(f'(0) = $(a-b)\\). Determine the \\(x\\)-coordinate of the leftmost critical point of \\(f(x)\\) in the interval \\((-\\infty, 0)\\), or prove that no such critical point exists."
        
        if a == b
            ans_val = "DNE"
            solution_text = steps(
                "Given: \\(f''(x) = f(x)\\), \\(f(0) = $(a+b)\\), \\(f'(0) = $(a-b) = 0\\)",
                "General solution: \\(f(x) = Ae^x + Be^{-x}\\)",
                "From \\(f(0) = A + B = $(a+b)\\) and \\(f'(0) = A - B = 0\\), we get \\(A = B = $(a)\\)",
                sol("Thus \\(f(x) = $(a)(e^x + e^{-x}) = $(2*a)\\cosh(x)\\)"),
                "Since \\(f'(x) = $(2*a)\\sinh(x)\\), the only critical point is at \\(x = 0\\)",
                sol("Answer", "No critical points exist in \\((-\\infty, 0)\\)")
            )
        else
            ans_val = "ln($(abs(b)))-ln($(abs(a)))"
            cp_val = log(abs(b//a))
            solution_text = steps(
                "Given: \\(f''(x) = f(x)\\), \\(f(0) = $(a+b)\\), \\(f'(0) = $(a-b)\\)",
                "General solution: \\(f(x) = Ae^x + Be^{-x}\\)",
                "From initial conditions: \\(A = $(a)\\), \\(B = $(b)\\)",
                sol("\\(f'(x) = $(a)e^x - $(b)e^{-x} = 0\\) when \\(e^{2x} = $(b//a)\\)"),
                sol("Critical point at \\(x = \\frac{1}{2}\\ln\\left(\\frac{$(b)}{$(a)}\\right) = $(round(cp_val, digits=4))\\)"),
                "Answer: " * (cp_val < 0 ? "\\(x = \\ln($(abs(b))) - \\ln($(abs(a)))\\)" : "No critical points in \\((-\\infty, 0)\\)")
            )
            if cp_val >= 0
                ans_val = "DNE"
            end
        end
        
        problem(
            question=question_text,
            answer=ans_val,
            difficulty=(3500, 4200),
            solution=solution_text,
            time=480
        )
        
    elseif problem_type == 2
        # Research-adjacent: Implicit curve sketching with singularities
        m = nonzero(-4, 4)
        n = nonzero(-4, 4)
        p = choice([2, 3, 4])
        q = choice([2, 3, 4])
        
        question_text = "Consider the algebraic curve defined by \\((x^2 + y^2)^$(p) = $(abs(m))x^$(q)y^$(q)\\). Determine the number of distinct tangent lines to this curve that pass through the origin."
        
        # Folium-like curves have specific tangent structure
        if p == 2 && q == 2
            ans_val = 3
            solution_text = steps(
                sol("Given curve: \\((x^2 + y^2)^2 = $(abs(m))x^2y^2\\)"),
                "Rewrite in polar: \\(r^4 = $(abs(m))r^4\\cos^2\\theta\\sin^2\\theta\\)",
                "Simplifies to \\(4\\cos^2\\theta\\sin^2\\theta = \\frac{4}{$(abs(m))}\\), i.e., \\(\\sin^2(2\\theta) = \\frac{4}{$(abs(m))}\\)",
                "The curve passes through origin with tangent slopes determined by \\(\\theta\\) where \\(r \\to 0\\)",
                "Analysis shows the curve has a node at origin with 2 branches, plus the trivial tangent",
                sol("Answer", "3 distinct tangent lines")
            )
        else
            ans_val = p + 1
            solution_text = steps(
                sol("Given curve: \\((x^2 + y^2)^$(p) = $(abs(m))x^$(q)y^$(q)\\)"),
                "Convert to polar: \\(r^$(2*p) = $(abs(m))r^$(2*q)\\cos^$(q)\\theta\\sin^$(q)\\theta\\)",
                "For \\(r \\neq 0\\): \\(r^$(2*p - 2*q) = $(abs(m))\\cos^$(q)\\theta\\sin^$(q)\\theta\\)",
                "Near origin, curve behavior depends on \\((2p - 2q)\\) and symmetry",
                "The origin is a singular point of order \\($(p)\\), yielding \\($(p+1)\\) tangent directions",
                sol("Answer", "$(p+1) distinct tangent lines")
            )
        end
        
        problem(
            question=question_text,
            answer=ans_val,
            difficulty=(3800, 4500),
            solution=solution_text,
            time=540
        )
        
    elseif problem_type == 3
        # Olympiad: envelope of family of curves
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        question_text = "Consider the family of curves \\(C_t: y = tx + \\frac{$(a)}{t} + $(b)\\) for \\(t > 0\\). Find the equation of the envelope of this family (the curve tangent to all members of the family). Express your answer in the form \\(y = f(x)\\)."
        
        # Envelope found by eliminating t from F(x,y,t) = 0 and ∂F/∂t = 0
        # Here: tx - y + a/t + b = 0 and x - a/t² = 0
        # From second: t² = a/x, so t = sqrt(a/x) (taking positive root)
        # Substituting: y = x*sqrt(a/x) + sqrt(a*x) + b = 2*sqrt(a*x) + b
        
        if a > 0
            ans_val = "2*sqrt($(a)*x)+$(b)"
            envelope_expr = "2\\sqrt{$(a)x} + $(b)"
        else
            ans_val = "2*sqrt($(abs(a))*(-x))+$(b)"
            envelope_expr = "2\\sqrt{$(abs(a))(-x)} + $(b)"
        end
        
        solution_text = steps(
            sol("Family: \\(y = tx + \\frac{$(a)}{t} + $(b)\\)"),
            "Envelope condition: \\(\\frac{\\partial}{\\partial t}\\left[tx + \\frac{$(a)}{t} + $(b) - y\\right] = 0\\)",
            sol("This gives: \\(x - \\frac{$(a)}{t^2} = 0\\), so \\(t^2 = \\frac{$(a)}{x}\\)"),
            "Taking \\(t = \\sqrt{\\frac{$(a)}{x}}\\) (positive root for \\(t > 0\\))",
            "Substitute back: \\(y = x \\cdot \\frac{\\sqrt{$(a)}}{\\sqrt{x}} + \\frac{\\sqrt{$(a)x}}{1} + $(b)\\)",
            sol("Envelope", "y = $(envelope_expr)")
        )
        
        problem(
            question=question_text,
            answer=ans_val,
            difficulty=(3600, 4300),
            solution=solution_text,
            time=420
        )
        
    else
        # Research-adjacent: inflection point locus with parameter
        k = choice([2, 3, 4, 5])
        m = nonzero(-3, 3)
        
        question_text = "For each \\(a > 0\\), consider the function \\(f_a(x) = x^$(k) - ax^2 + $(m)x\\). As \\(a\\) varies over all positive reals, the inflection points of \\(f_a(x)\\) trace out a curve in the \\(xy\\)-plane. Find the equation of this curve. Express your answer in the form \\(y = g(x)\\)."
        
        # f''(x) = k(k-1)x^(k-2) - 2a = 0
        # So x^(k-2) = 2a/(k(k-1)), thus a = k(k-1)x^(k-2)/2
        # Inflection at x_0 where f''(x_0) = 0
        # y = x_0^k - a*x_0^2 + m*x_0
        # Substitute a: y = x^k - [k(k-1)x^(k-2)/2]*x^2 + m*x
        # y = x^k - k(k-1)x^k/2 + m*x = x^k[1 - k(k-1)/2] + m*x
        
        coeff = 1 - k*(k-1)//2
        
        ans_val = "$(coeff)*x^$(k)+$(m)*x"
        locus_expr = "$(coeff)x^{$(k)} + $(m)x"
        
        solution_text = steps(
            sol("Given: \\(f_a(x) = x^$(k) - ax^2 + $(m)x\\)"),
            sol("\\(f_a''(x) = $(k*(k-1))x^$(k-2) - 2a = 0\\) at inflection points"),
            "Thus \\(a = \\frac{$(k*(k-1))}{2}x^$(k-2)\\) at inflection \\(x\\)",
            "Substitute into \\(y = f_a(x)\\):",
            sol("\\(y = x^$(k) - \\frac{$(k*(k-1))}{2}x^$(k-2) \\cdot x^2 + $(m)x = $(coeff)x^{$(k)} + $(m)x\\)"),
            sol("Locus", "y = $(locus_expr)")
        )
        
        problem(
            question=question_text,
            answer=ans_val,
            difficulty=(3900, 4700),
            solution=solution_text,
            time=600
        )
    end
end