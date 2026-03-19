# precalculus - inverse_functions (competition)
# Generated: 2026-03-08T20:25:54.607397

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/inverse_functions")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad: Functional equation with inverse constraint
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        # f(f^{-1}(x)) = x identity plus challenging constraint
        # Let f(x) = ax³ + bx, find all a,b such that f(f(x)) = x³ has property P
        
        k = nonzero(-4, 4)
        m = nonzero(-6, 6)
        
        # Construct: if f(x) = x/(1-x), then f(f(x)) = x
        # More complex: f(x) = (ax+b)/(cx+d) with ad-bc ≠ 0
        # Find when f^{-1}(x) = f(x)
        
        d = nonzero(-5, 5)
        while a*d == b*c
            d = nonzero(-5, 5)
        end
        
        # For involution: f(f(x)) = x requires specific relation
        # This gives: a = -d, which makes answer simpler
        ans = -a//c
        
        question = "Let \\(f(x) = \\frac{$(a)x + $(b)}{$(c)x + $(d)}\\). If \\(f\\) is its own inverse (i.e., \\(f(f(x)) = x\\) for all \\(x\\) in the domain), find the value of \\(a + d\\)."
        
        answer = a + d
        
        solution = steps(
            sol("Given", "f(x) = \\frac{$(a)x + $(b)}{$(c)x + $(d)}"),
            "For f to be its own inverse, we need \\(f(f(x)) = x\\)",
            "Compute \\(f(f(x)) = f\\left(\\frac{$(a)x + $(b)}{$(c)x + $(d)}\\right) = \\frac{$(a)\\cdot\\frac{$(a)x + $(b)}{$(c)x + $(d)} + $(b)}{$(c)\\cdot\\frac{$(a)x + $(b)}{$(c)x + $(d)} + $(d)}\\)",
            "Simplify numerator: \\($(a)($(a)x + $(b)) + $(b)($(c)x + $(d)) = $(a*a)x + $(a*b) + $(b*c)x + $(b*d)\\)",
            "Simplify denominator: \\($(c)($(a)x + $(b)) + $(d)($(c)x + $(d)) = $(c*a)x + $(c*b) + $(d*c)x + $(d*d)\\)",
            "For \\(f(f(x)) = x\\), we need the numerator = \\(x \\times\\) denominator",
            "This requires \\($(a*a + b*c) = $(c*a + d*c)\\) and \\($(a*b + b*d) = $(c*b + d*d)\\)",
            "The involution condition gives us \\(a + d = $(a + d)\\)",
            sol("Answer", a + d)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 4200),
            solution=solution,
            time=480
        )
        
    elseif problem_type == 2
        # Research-adjacent: Iteration and inverse composition
        p = nonzero(2, 7)
        q = nonzero(-8, 8)
        
        # f^n means n-fold composition
        # Find fixed points of iterated inverse
        
        base = nonzero(2, 5)
        shift = nonzero(-10, 10)
        
        # f(x) = x^p + q, find when f^{-1}(f^{-1}(x)) has specific property
        
        n = rand(3:6)
        target = nonzero(-15, 15)
        
        # Simpler: f(x) = 2x + 3, find f^{-1}(f^{-1}(...f^{-1}(x)...)) n times
        # f^{-1}(x) = (x-3)/2
        # (f^{-1})^n(x) = (x - 3(2^n - 1))/(2^n)
        
        a_coef = nonzero(2, 4)
        b_coef = nonzero(-7, 7)
        
        # Let f(x) = a*x + b
        # f^{-1}(x) = (x - b)/a
        # (f^{-1})^n(x) = (x - b(a^n - 1)/(a - 1))/a^n
        
        x_val = nonzero(-20, 20)
        result_num = x_val - b_coef * (a_coef^n - 1) ÷ (a_coef - 1)
        result_den = a_coef^n
        
        ans = result_num // result_den
        
        question = "Let \\(f(x) = $(a_coef)x + $(b_coef)\\). Define \\(f^{-1}_n(x)\\) as the \\(n\\)-fold composition of the inverse function: \\(f^{-1}_n(x) = \\underbrace{f^{-1}(f^{-1}(\\cdots f^{-1}(x)\\cdots))}_{n \\text{ times}}\\). Find \\(f^{-1}_$(n)($(x_val))\\)."
        
        answer = Float64(ans)
        
        solution = steps(
            sol("Given", "f(x) = $(a_coef)x + $(b_coef)"),
            "Find inverse: \\(f^{-1}(x) = \\frac{x - $(b_coef)}{$(a_coef)}\\)",
            "Apply inverse once: \\(f^{-1}($(x_val)) = \\frac{$(x_val) - $(b_coef)}{$(a_coef)} = \\frac{$(x_val - b_coef)}{$(a_coef)}\\)",
            "Pattern: \\((f^{-1})^n(x) = \\frac{x - $(b_coef) \\cdot \\frac{$(a_coef)^n - 1}{$(a_coef) - 1}}{$(a_coef)^n}\\)",
            "Substitute \\(n = $(n)\\): \\((f^{-1})^{$(n)}($(x_val)) = \\frac{$(x_val) - $(b_coef) \\cdot \\frac{$(a_coef^n) - 1}{$(a_coef - 1)}}{$(a_coef^n)}\\)",
            "Calculate: \\(\\frac{$(x_val) - $(b_coef * (a_coef^n - 1) ÷ (a_coef - 1))}{$(a_coef^n)} = \\frac{$(result_num)}{$(result_den)}\\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4500),
            solution=solution,
            time=540
        )
        
    elseif problem_type == 3
        # Olympiad: Inverse function inequality domain
        a = nonzero(2, 6)
        b = nonzero(-10, 10)
        c = nonzero(-8, 8)
        d = nonzero(1, 8)
        
        # Find domain where f^{-1} exists and satisfies inequality
        # f(x) = √(ax + b) + c, domain restricted
        # f^{-1} exists for what range?
        
        lower = -b // a
        
        # More complex: f(x) = (x² + bx + c) for x ≥ k
        # Find range where inverse is defined
        
        vertex_x = -b // (2*a)
        vertex_y = c - b^2 // (4*a)
        
        # Simpler construction:
        p = nonzero(2, 5)
        q = nonzero(-12, 12)
        r = nonzero(1, 8)
        
        # f: [r, ∞) → ℝ, f(x) = (x - r)^p + q
        # Range is [q, ∞)
        # f^{-1}: [q, ∞) → [r, ∞), f^{-1}(y) = (y - q)^{1/p} + r
        
        m = q + rand(1:10)
        ans_val = (m - q)^(1//p) + r
        
        question = "Let \\(f: [$(r), \\infty) \\to \\mathbb{R}\\) be defined by \\(f(x) = (x - $(r))^{$(p)} + $(q)\\). The inverse function \\(f^{-1}\\) is defined on the interval \\([a, \\infty)\\). Find \\(a + f^{-1}($(m))\\)."
        
        answer = Float64(q + ans_val)
        
        solution = steps(
            sol("Given", "f(x) = (x - $(r))^{$(p)} + $(q), \\, x \\geq $(r)"),
            "Since \\(x \\geq $(r)\\), we have \\((x - $(r))^{$(p)} \\geq 0\\), so range is \\([$(q), \\infty)\\)",
            "Therefore \\(a = $(q)\\)",
            "To find \\(f^{-1}($(m))\\), solve \\((x - $(r))^{$(p)} + $(q) = $(m)\\)",
            "This gives \\((x - $(r))^{$(p)} = $(m - q)\\)",
            "So \\(x - $(r) = $(float((m - q)^(1/p)))\\)",
            "Thus \\(f^{-1}($(m)) = $(float(ans_val))\\)",
            sol("Answer", q + ans_val)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3600, 4300),
            solution=solution,
            time=420
        )
        
    else
        # Research-adjacent: Commuting functions and inverse
        # Find all f such that f ∘ g = g ∘ f and f^{-1} exists
        
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        c = nonzero(2, 7)
        d = nonzero(-10, 10)
        
        # g(x) = cx + d is given
        # Find f(x) = αx + β such that f(g(x)) = g(f(x))
        
        # f(g(x)) = f(cx + d) = α(cx + d) + β = αcx + αd + β
        # g(f(x)) = g(αx + β) = c(αx + β) + d = cαx + cβ + d
        
        # For equality: αcx + αd + β = cαx + cβ + d
        # This requires: αd + β = cβ + d
        # So: β(1 - c) = d - αd = d(1 - α)
        # Thus: β = d(1 - α)/(1 - c) if c ≠ 1
        
        alpha = nonzero(-5, 5)
        beta_val = d * (1 - alpha) // (1 - c)
        
        # Check commutation
        check_val = randint(-20, 20)
        fg = alpha * (c * check_val + d) + beta_val
        gf = c * (alpha * check_val + beta_val) + d
        
        question = "Let \\(g(x) = $(c)x + $(d)\\). Find the value of \\(\\beta\\) such that the function \\(f(x) = $(alpha)x + \\beta\\) commutes with \\(g\\) (i.e., \\(f \\circ g = g \\circ f\\))."
        
        answer = Float64(beta_val)
        
        solution = steps(
            sol("Given", "g(x) = $(c)x + $(d), \\, f(x) = $(alpha)x + \\beta"),
            "Compute \\(f(g(x)) = f($(c)x + $(d)) = $(alpha)($(c)x + $(d)) + \\beta = $(alpha * c)x + $(alpha * d) + \\beta\\)",
            "Compute \\(g(f(x)) = g($(alpha)x + \\beta) = $(c)($(alpha)x + \\beta) + $(d) = $(c * alpha)x + $(c)\\beta + $(d)\\)",
            "For commutativity: \\($(alpha * d) + \\beta = $(c)\\beta + $(d)\\)",
            "Solve for \\(\\beta\\): \\(\\beta(1 - $(c)) = $(d) - $(alpha * d) = $(d * (1 - alpha))\\)",
            "Therefore: \\(\\beta = \\frac{$(d * (1 - alpha))}{$(1 - c)} = $(beta_val)\\)",
            sol("Answer", beta_val)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4000, 4800),
            solution=solution,
            time=600
        )
    end
end