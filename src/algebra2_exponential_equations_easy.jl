# algebra2 - exponential_equations (easy)
# Generated: 2026-03-08T20:19:39.377525

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/exponential_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple exponential equation: b^x = b^k
        base = choice([2, 3, 4, 5])
        ans = randint(-5, 8)
        rhs = base^ans
        
        problem(
            question="Solve for \\(x\\): \$$(base)^x = $(rhs)\$",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                sol("Given", base^x ~ rhs),
                "Express $(rhs) as a power of $(base): \$$(rhs) = $(base)^{$(ans)}\$",
                "Since bases are equal, exponents must be equal",
                sol("Answer", x ~ ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Exponential with same base on both sides: b^(ax+c) = b^(dx+e)
        base = choice([2, 3, 5])
        ans = randint(-8, 12)
        a = nonzero(-4, 4)
        d = nonzero(-4, 4)
        while a == d
            d = nonzero(-4, 4)
        end
        c = randint(-10, 10)
        e = Int(a * ans + c - d * ans)
        
        lhs_exp = a*x + c
        rhs_exp = d*x + e
        
        problem(
            question="Solve for \\(x\\): \$$(base)^{$(tex(lhs_exp))} = $(base)^{$(tex(rhs_exp))}\$",
            answer=ans,
            difficulty=(800, 950),
            solution=steps(
                sol("Given", base^lhs_exp ~ base^rhs_exp),
                "Since bases are equal, set exponents equal",
                sol(tex(lhs_exp) ~ tex(rhs_exp)),
                "Solve for x: \$$(tex(a*x)) - $(tex(d*x)) = $(e) - $(c)\$",
                sol("Answer", x ~ ans)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Exponential requiring factoring out common base: b^x * b^k = b^m
        base = choice([2, 3, 5])
        ans = randint(-6, 10)
        k = randint(2, 8)
        m = ans + k
        
        problem(
            question="Solve for \\(x\\): \$$(base)^x \\cdot $(base)^{$(k)} = $(base)^{$(m)}\$",
            answer=ans,
            difficulty=(850, 1000),
            solution=steps(
                sol("Given", base^x * base^k ~ base^m),
                "Apply product rule: \$a^m \\cdot a^n = a^{m+n}\$",
                sol(base^(x+k) ~ base^m),
                "Set exponents equal: \$x + $(k) = $(m)\$",
                sol("Answer", x ~ ans)
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Quadratic exponential: (b^x)^2 + c*b^x + d = 0
        base = choice([2, 3])
        # Let y = base^x, solve ay^2 + by + c = 0
        r1 = choice([2, 4, 8, 16])  # Nice powers
        r2 = choice([2, 4, 8, 16])
        while r1 == r2
            r2 = choice([2, 4, 8, 16])
        end
        
        # y = r1 or y = r2, so base^x = r1 or base^x = r2
        if base^1 == r1 || base^2 == r1 || base^3 == r1 || base^4 == r1
            ans1_found = false
            for i in -5:5
                if base^i == r1
                    ans1 = i
                    ans1_found = true
                    break
                end
            end
            if !ans1_found
                ans1 = 2
                r1 = base^2
            end
        else
            ans1 = 2
            r1 = base^2
        end
        
        if base^1 == r2 || base^2 == r2 || base^3 == r2 || base^4 == r2
            ans2_found = false
            for i in -5:5
                if base^i == r2
                    ans2 = i
                    ans2_found = true
                    break
                end
            end
            if !ans2_found
                ans2 = 3
                r2 = base^3
            end
        else
            ans2 = 3
            r2 = base^3
        end
        
        while ans1 == ans2
            ans2 = ans2 + 1
            r2 = base^ans2
        end
        
        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        
        @variables y
        quad_expr = y^2 + b_coef*y + c_coef
        
        problem(
            question="Solve for \\(x\\): \$($(base)^x)^2 $(b_coef >= 0 ? "+" : "") $(b_coef) \\cdot $(base)^x $(c_coef >= 0 ? "+" : "") $(c_coef) = 0\$",
            answer=fmt_set(Set([ans1, ans2])),
            difficulty=(1000, 1200),
            answer_type="set",
            solution=steps(
                "Let \$y = $(base)^x\$, then the equation becomes",
                sol(quad_expr ~ 0),
                "Factor: \$(y - $(r1))(y - $(r2)) = 0\$",
                "So \$$(base)^x = $(r1)\$ or \$$(base)^x = $(r2)\$",
                "This gives \$x = $(ans1)\$ or \$x = $(ans2)\$",
                sol("Answer", Set([ans1, ans2]))
            ),
            time=120
        )
        
    else  # problem_type == 5
        # Division of exponentials: b^(ax+c) / b^(dx+e) = b^k
        base = choice([2, 3, 5])
        ans = randint(-7, 10)
        a = nonzero(-3, 5)
        d = nonzero(-3, 5)
        while a == d
            d = nonzero(-3, 5)
        end
        c = randint(-8, 8)
        k = randint(-6, 6)
        e = Int(a * ans + c - d * ans - k)
        
        lhs_exp = a*x + c
        rhs_exp = d*x + e
        
        problem(
            question="Solve for \\(x\\): \$\\frac{$(base)^{$(tex(lhs_exp))}}{$(base)^{$(tex(rhs_exp))}} = $(base)^{$(k)}\$",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", base^lhs_exp / base^rhs_exp ~ base^k),
                "Apply quotient rule: \$\\frac{a^m}{a^n} = a^{m-n}\$",
                sol(base^(lhs_exp - rhs_exp) ~ base^k),
                "Simplify exponent: \$$(tex(lhs_exp - rhs_exp))\$",
                "Set exponents equal and solve for x",
                sol("Answer", x ~ ans)
            ),
            time=100
        )
    end
end