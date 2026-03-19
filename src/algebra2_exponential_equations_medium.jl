# algebra2 - exponential_equations (medium)
# Generated: 2026-03-08T20:19:41.300831

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/exponential_equations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple exponential equation: b^x = b^k
        base = choice([2, 3, 4, 5])
        ans = randint(-8, 8)
        rhs = base^ans
        
        problem(
            question="Solve for \\(x\\): \$$(base)^x = $(rhs)\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", base^x ~ rhs),
                "Express $(rhs) as a power of $(base): \$$(rhs) = $(base)^{$(ans)}\$",
                "Since the bases are equal: \$x = $(ans)\$",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Exponential equation with coefficients: a*b^x = c
        base = choice([2, 3, 5])
        ans = randint(2, 6)
        a = nonzero(-10, 10)
        c = a * base^ans
        
        problem(
            question="Solve for \\(x\\): \$$(a) \\cdot $(base)^x = $(c)\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", a * base^x ~ c),
                "Divide both sides by $(a): \$$(base)^x = $(c÷a)\$",
                "Express $(c÷a) as a power of $(base): \$$(c÷a) = $(base)^{$(ans)}\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Same base both sides: b^(ax+c) = b^(dx+e)
        base = choice([2, 3, 5, 7])
        ans = randint(-10, 10)
        a = nonzero(-5, 5)
        d = nonzero(-5, 5)
        while a == d
            d = nonzero(-5, 5)
        end
        c = randint(-15, 15)
        e = d * ans + c - a * ans
        
        lhs_exp = a * ans + c
        rhs_exp = d * ans + e
        
        problem(
            question="Solve for \\(x\\): \$$(base)^{$(tex(a*x + c))} = $(base)^{$(tex(d*x + e))}\$",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", base^(a*x + c) ~ base^(d*x + e)),
                "Since bases are equal, set exponents equal: \$$(tex(a*x + c)) = $(tex(d*x + e))\$",
                "Solve: \$$(a)x - $(d)x = $(e) - $(c)\$",
                "Simplify: \$$(a-d)x = $(e-c)\$",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Quadratic form: b^(2x) + a*b^x + c = 0
        base = choice([2, 3])
        r1 = randint(1, 4)
        r2 = randint(1, 4)
        
        # Let y = base^x, then y^2 - (r1+r2)y + r1*r2 = 0
        # Solutions y = r1, r2, so x = log_base(r1), log_base(r2)
        a_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        # Choose which solution
        ans = choice([r1, r2])
        ans_log = log(base, ans)
        
        # Only use integer solutions
        if base^round(Int, ans_log) == ans
            ans = round(Int, ans_log)
            other = base == 2 && r1 != r2 ? (ans == log(base, r1) ? round(Int, log(base, r2)) : round(Int, log(base, r1))) : ans
            
            problem(
                question="Solve for \\(x\\): \$$(base)^{2x} + $(a_coeff) \\cdot $(base)^x + $(c_coeff) = 0\$",
                answer=fmt_set(Set(filter(x -> base^x in [r1, r2], [round(Int, log(base, r1)), round(Int, log(base, r2))]))),
                answer_type="set",
                difficulty=(1500, 1700),
                solution=steps(
                    "Let \$y = $(base)^x\$, then the equation becomes: \$y^2 + $(a_coeff)y + $(c_coeff) = 0\$",
                    "Factor: \$(y - $(r1))(y - $(r2)) = 0\$",
                    "Solutions: \$y = $(r1)\$ or \$y = $(r2)\$",
                    "Therefore: \$$(base)^x = $(r1)\$ or \$$(base)^x = $(r2)\$",
                    sol("Answer", fmt_set(Set(filter(x -> base^x in [r1, r2], [round(Int, log(base, r1)), round(Int, log(base, r2))]))))
                ),
                time=180
            )
        else
            # Fallback to simpler problem
            base = choice([2, 3, 5])
            ans = randint(-6, 6)
            rhs = base^ans
            
            problem(
                question="Solve for \\(x\\): \$$(base)^x = $(rhs)\$",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", base^x ~ rhs),
                    "Express $(rhs) as a power of $(base): \$$(rhs) = $(base)^{$(ans)}\$",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    elseif problem_type == 5
        # Product of exponentials: b^x * b^y = b^k with constraint
        base = choice([2, 3, 5])
        x_val = randint(2, 8)
        y_val = randint(2, 8)
        k = x_val + y_val
        
        problem(
            question="If \$$(base)^x \\cdot $(base)^{$(y_val)} = $(base)^{$(k)}\$, find \\(x\\).",
            answer=x_val,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", base^x * base^y_val ~ base^k),
                "Use product rule: \$$(base)^{x + $(y_val)} = $(base)^{$(k)}\$",
                "Set exponents equal: \$x + $(y_val) = $(k)\$",
                sol("Answer", x_val)
            ),
            time=100
        )
        
    else
        # Division of exponentials: b^x / b^y = b^k
        base = choice([2, 3, 5])
        x_val = randint(3, 12)
        y_val = randint(1, 6)
        k = x_val - y_val
        
        problem(
            question="If \$\\frac{$(base)^x}{$(base)^{$(y_val)}} = $(base)^{$(k)}\$, find \\(x\\).",
            answer=x_val,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", base^x / base^y_val ~ base^k),
                "Use quotient rule: \$$(base)^{x - $(y_val)} = $(base)^{$(k)}\$",
                "Set exponents equal: \$x - $(y_val) = $(k)\$",
                sol("Answer", x_val)
            ),
            time=100
        )
    end
end