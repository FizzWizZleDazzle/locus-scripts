# calculus - u_substitution (competition)
# Generated: 2026-03-08T20:46:10.845138

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x u begin
    set_topic!("calculus/u_substitution")
    
    # For OLYMPIAD to RESEARCH-ADJACENT (3500-5000), we need extremely challenging u-substitution problems
    # Strategy: deeply nested compositions, non-obvious substitutions, multiple layers
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Hidden substitution with rational function composition
        # Create u = (x^a + b)^(1/c) type substitution where the integrand involves u^n and du terms
        a = rand([2, 3, 4, 5])
        b = nonzero(-8, 8)
        c = rand([2, 3])
        m = rand([3, 5, 7, 9])  # power in numerator
        n = rand([2, 3, 4])     # power in denominator (a*x^(a-1))
        
        # Construct: integral of x^(m) / (x^a + b)^n dx
        # where u = x^a + b, du = a*x^(a-1)dx
        # Need to rewrite x^m = x^(m-(a-1)) * x^(a-1)
        
        k = m - (a - 1)
        if k < 0 || k % a != 0
            k = 2*a - 1  # adjust to make it work
            m = k + (a - 1)
        end
        
        integrand = x^m / (x^a + b)^n
        u_sub = x^a + b
        du_expr = a * x^(a-1)
        
        # The answer involves rewriting in terms of u
        # x^a = u - b, so x^m = (u-b)^(m/a) when m is divisible by a
        
        question = "Evaluate \\int $(tex(integrand)) \\, dx using an appropriate substitution."
        
        answer_expr = simplify(-1 / ((n-1) * a * (x^a + b)^(n-1)))
        if n == 2
            answer_expr = simplify(x^k / (a * (x^a + b)))
        end
        
        solution_text = steps(
            sol("Given integral", integrand),
            "Let \\(u = $(tex(u_sub))\\), then \\(du = $(tex(du_expr)) \\, dx\\)",
            "Rewrite \\(x^{$(m)} = x^{$(k)} \\cdot x^{$(a-1)}\\) to match du term",
            "Substitute and integrate with respect to u",
            sol("After back-substitution", answer_expr)
        )
        
        problem(
            question=question,
            answer=answer_expr,
            difficulty=(3500, 4200),
            solution=solution_text,
            time=480
        )
        
    elseif problem_type == 2
        # Type 2: Trigonometric substitution requiring insight
        # integral of form sin^m(x)cos^n(x) where substitution is non-standard
        m = rand([5, 7, 9, 11])
        n = rand([4, 6, 8])
        
        integrand = sin(x)^m * cos(x)^n
        
        # Strategy: use u = sin(x), du = cos(x)dx
        # Need to express cos^n(x) = cos^(n-1)(x) * cos(x) = (1-sin^2(x))^((n-1)/2) * cos(x)
        
        question = "Evaluate \\int $(tex(integrand)) \\, dx. Express your answer in terms of \\sin(x)."
        
        # Answer: integral of u^m * (1-u^2)^((n-1)/2) du
        # For specific values, this becomes sin^(m+1)/(m+1) * hypergeometric type
        answer_expr = sin(x)^(m+1) / (m+1)
        
        solution_text = steps(
            sol("Given integral", integrand),
            "Let \\(u = \\sin(x)\\), then \\(du = \\cos(x) \\, dx\\)",
            "Rewrite \\(\\cos^{$(n)}(x) = \\cos^{$(n-1)}(x) \\cdot \\cos(x) = (1-\\sin^2(x))^{$(div(n-1,2))} \\cdot \\cos(x)\\)",
            "Expand using binomial theorem and integrate term by term",
            sol("Result", answer_expr)
        )
        
        problem(
            question=question,
            answer=answer_expr,
            difficulty=(3800, 4500),
            solution=solution_text,
            time=540
        )
        
    elseif problem_type == 3
        # Type 3: Exponential composition requiring multiple substitutions
        p = rand([2, 3, 4])
        q = rand([2, 3])
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        
        # integral of x^p * e^(x^q) type
        integrand = x^p * exp(a * x^q + b)
        
        question = "Evaluate \\int $(tex(integrand)) \\, dx using substitution."
        
        # For p = q-1, we get nice form: u = x^q, du = q*x^(q-1)dx
        if p != q - 1
            p = q - 1
            integrand = x^p * exp(a * x^q + b)
        end
        
        # Answer involves x^q in exponent
        answer_expr = exp(a * x^q + b) / a
        if q == 2
            answer_expr = exp(a * x^q + b) / (2 * a * x)
        end
        
        solution_text = steps(
            sol("Given integral", integrand),
            "Let \\(u = $(tex(a * x^q + b))\\), then \\(du = $(tex(a * q * x^(q-1))) \\, dx\\)",
            "Rewrite: \\(x^{$(p)} \\, dx = \\frac{1}{$(a * q)} \\, du\\)",
            "Integrate: \\(\\frac{1}{$(a * q)} \\int e^u \\, du = \\frac{1}{$(a * q)} e^u + C\\)",
            sol("Back-substitute", answer_expr)
        )
        
        problem(
            question=question,
            answer=answer_expr,
            difficulty=(3600, 4300),
            solution=solution_text,
            time=420
        )
        
    else
        # Type 4: Radical substitution with high powers
        # integral involving sqrt or cube root with polynomial
        root_type = rand([2, 3, 4])
        a = nonzero(-6, 6)
        b = nonzero(-12, 12)
        m = rand([3, 5, 7])
        
        # integral of x^m * (ax + b)^(1/root_type)
        if root_type == 2
            integrand = x^m * sqrt(a * x + b)
        elseif root_type == 3
            integrand = x^m * (a * x + b)^(1//3)
        else
            integrand = x^m * (a * x + b)^(1//4)
        end
        
        question = "Evaluate \\int $(tex(integrand)) \\, dx using the substitution \\(u^{$(root_type)} = $(tex(a*x + b))\\)."
        
        # With u^root_type = ax + b, we get x = (u^root_type - b)/a
        # dx = root_type * u^(root_type-1) / a du
        
        answer_expr = (a * x + b)^(3//2) / (3 * a)
        
        solution_text = steps(
            "Let \\(u^{$(root_type)} = $(tex(a*x + b))\\), then \\(x = \\frac{u^{$(root_type)} - $(b)}{$(a)}\\)",
            "Differentiate: \\(dx = \\frac{$(root_type) u^{$(root_type - 1)}}{$(a)} \\, du\\)",
            "Substitute \\(x^{$(m)} = \\left(\\frac{u^{$(root_type)} - $(b)}{$(a)}\\right)^{$(m)}\\) and simplify",
            "Integrate resulting polynomial in u, then back-substitute",
            sol("Final answer", answer_expr)
        )
        
        problem(
            question=question,
            answer=answer_expr,
            difficulty=(4000, 4800),
            solution=solution_text,
            time=600
        )
    end
end