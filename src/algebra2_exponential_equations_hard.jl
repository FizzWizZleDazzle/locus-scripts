# algebra2 - exponential_equations (hard)
# Generated: 2026-03-08T20:19:48.536055

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/exponential_equations")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # Type: a^(mx+b) = a^(nx+c), same base
        base = choice([2, 3, 5, 7])
        m = nonzero(-5, 5)
        b = randint(-15, 15)
        n = nonzero(-5, 5)
        c = randint(-15, 15)
        
        # Solve mx + b = nx + c
        ans = (c - b) // (m - n)
        
        lhs = base^(m*x + b)
        rhs = base^(n*x + c)
        
        problem(
            question="Solve for \\(x\\): \\[$(tex(lhs)) = $(tex(rhs))\\]",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Since the bases are equal, set exponents equal: \\($(m)x + $(b) = $(n)x + $(c)\\)",
                "Solve: \\($(m - n)x = $(c - b)\\)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif prob_type == 2
        # Type: a^(x^2) = a^(polynomial), quadratic exponent
        base = choice([2, 3, 5])
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        
        # x^2 = (x-r1)(x-r2) expanded, solve for x
        poly_expr = expand((x - r1) * (x - r2))
        
        lhs = base^(x^2)
        rhs = base^poly_expr
        
        sols = solve(x^2 ~ poly_expr, x)
        ans = fmt_set(Set(sols))
        
        problem(
            question="Solve for \\(x\\): \\[$(tex(lhs)) = $(tex(rhs))\\]",
            answer=ans,
            difficulty=(1900, 2100),
            answer_type="set",
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Set exponents equal: \\(x^2 = $(tex(poly_expr))\\)",
                "Rearrange to \\($(tex(x^2 - poly_expr)) = 0\\)",
                "Factor and solve to get \\(x \\in $(ans)\\)",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif prob_type == 3
        # Type: a^x + b*a^x = c, factoring out exponential
        base = choice([2, 3, 5])
        b = randint(2, 8)
        target = choice([16, 27, 32, 64, 81, 125, 243])
        
        # (1 + b) * base^x = target
        # base^x = target / (1 + b)
        
        factor = 1 + b
        if target % factor == 0
            value = target ÷ factor
            # Check if value is a power of base
            log_val = log(value) / log(base)
            if abs(log_val - round(log_val)) < 0.01
                ans = Int(round(log_val))
            else
                ans = log_val
            end
        else
            ans = log(target / factor) / log(base)
        end
        
        problem(
            question="Solve for \\(x\\): \\[$(base)^x + $(b) \\cdot $(base)^x = $(target)\\]",
            answer=ans,
            difficulty=(1850, 2050),
            solution=steps(
                "Factor out \\($(base)^x\\): \\((1 + $(b)) \\cdot $(base)^x = $(target)\\)",
                "Simplify: \\($(factor) \\cdot $(base)^x = $(target)\\)",
                "Divide: \\($(base)^x = $(target / factor)\\)",
                "Take logarithm base $(base)",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif prob_type == 4
        # Type: a^(2x) - b*a^x + c = 0, substitution u = a^x
        base = choice([2, 3, 5])
        r1 = randint(1, 5)
        r2 = randint(1, 5)
        
        # (a^x - r1)(a^x - r2) = 0
        # a^(2x) - (r1+r2)a^x + r1*r2 = 0
        
        b_coeff = r1 + r2
        c_coeff = r1 * r2
        
        # Solutions: a^x = r1 or a^x = r2
        # x = log_a(r1) or x = log_a(r2)
        
        ans1 = log(r1) / log(base)
        ans2 = log(r2) / log(base)
        ans = fmt_set(Set([ans1, ans2]))
        
        problem(
            question="Solve for \\(x\\): \\[$(base)^{2x} - $(b_coeff) \\cdot $(base)^x + $(c_coeff) = 0\\]",
            answer=ans,
            difficulty=(2000, 2200),
            answer_type="set",
            solution=steps(
                "Let \\(u = $(base)^x\\), then \\(u^2 - $(b_coeff)u + $(c_coeff) = 0\\)",
                "Factor: \\((u - $(r1))(u - $(r2)) = 0\\)",
                "So \\($(base)^x = $(r1)\\) or \\($(base)^x = $(r2)\\)",
                "Taking logarithms: \\(x = \\log_{$(base)}($(r1))\\) or \\(x = \\log_{$(base)}($(r2))\\)",
                sol("Answer", ans)
            ),
            time=200
        )
        
    else
        # Type: Different bases that are powers of same base
        # b1^x = b2^(mx+n) where b1 = a^p, b2 = a^q
        
        base_a = choice([2, 3])
        p = randint(2, 4)
        q = randint(2, 4)
        m = nonzero(-3, 3)
        n = randint(-10, 10)
        
        b1 = base_a^p
        b2 = base_a^q
        
        # a^(px) = a^(q(mx+n))
        # px = q(mx + n)
        # px = qmx + qn
        # x(p - qm) = qn
        
        ans = (q * n) // (p - q * m)
        
        lhs = b1^x
        rhs = b2^(m*x + n)
        
        problem(
            question="Solve for \\(x\\): \\[$(tex(lhs)) = $(tex(rhs))\\]",
            answer=ans,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Rewrite in terms of base $(base_a): \\(($(base_a)^{$(p)})^x = ($(base_a)^{$(q)})^{$(m)x + $(n)}\\)",
                "Simplify exponents: \\($(base_a)^{$(p)x} = $(base_a)^{$(q)($(m)x + $(n))}\\)",
                "Set exponents equal: \\($(p)x = $(q * m)x + $(q * n)\\)",
                "Solve for x: \\($(p - q * m)x = $(q * n)\\)",
                sol("Answer", ans)
            ),
            time=180
        )
    end
end