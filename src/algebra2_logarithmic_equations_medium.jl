# algebra2 - logarithmic_equations (medium)
# Generated: 2026-03-08T20:21:08.326002

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/logarithmic_equations")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Type 1: log_b(ax + c) = d, solve for x (ELO ~1200-1400)
        base = choice([2, 3, 4, 5, 10])
        d = randint(1, 4)
        target = base^d
        a = nonzero(-5, 5)
        c = randint(-20, 20)
        # Ensure ax + c = target has integer solution
        ans = (target - c) // a
        if denominator(ans) != 1
            ans = randint(-15, 15)
            c = target - a * ans
        else
            ans = numerator(ans)
        end
        
        lhs_arg = a*x + c
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$(base)}($(tex(lhs_arg))) = $(d)\\)",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", "\\log_{$(base)}($(tex(lhs_arg))) = $(d)"),
                "Convert to exponential form: \\($(tex(lhs_arg)) = $(base)^{$(d)} = $(target)\\)",
                sol("Solve", a*x + c ~ target),
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Type 2: log(x) + log(y) = k, word problem style (ELO ~1400-1600)
        base = choice([2, 10])
        k = randint(2, 5)
        product = base^k
        # Find two factors
        factors = []
        for i in 2:isqrt(product)
            if product % i == 0
                push!(factors, (i, product ÷ i))
            end
        end
        if isempty(factors)
            factors = [(1, product)]
        end
        factor_pair = choice(factors)
        a_val, b_val = factor_pair
        
        if base == 10
            log_notation = "\\log"
        else
            log_notation = "\\log_{$(base)}"
        end
        
        problem(
            question="Solve for \\(x\\): \\($(log_notation)(x) + $(log_notation)($(b_val)) = $(k)\\)",
            answer=a_val,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", "$(log_notation)(x) + $(log_notation)($(b_val)) = $(k)"),
                "Use logarithm product rule: \\($(log_notation)(x \\cdot $(b_val)) = $(k)\\)",
                "Convert to exponential form: \\(x \\cdot $(b_val) = $(base)^{$(k)} = $(product)\\)",
                sol("Solve for x", "x = \\frac{$(product)}{$(b_val)} = $(a_val)")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Type 3: log_b(x) - log_b(y) = k (ELO ~1400-1600)
        base = choice([2, 3, 5, 10])
        k = randint(1, 3)
        ratio = base^k
        denominator_val = nonzero(2, 12)
        numerator_val = ratio * denominator_val
        
        if base == 10
            log_notation = "\\log"
        else
            log_notation = "\\log_{$(base)}"
        end
        
        problem(
            question="Solve for \\(x\\): \\($(log_notation)(x) - $(log_notation)($(denominator_val)) = $(k)\\)",
            answer=numerator_val,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", "$(log_notation)(x) - $(log_notation)($(denominator_val)) = $(k)"),
                "Use logarithm quotient rule: \\($(log_notation)\\left(\\frac{x}{$(denominator_val)}\\right) = $(k)\\)",
                "Convert to exponential form: \\(\\frac{x}{$(denominator_val)} = $(base)^{$(k)} = $(ratio)\\)",
                sol("Solve for x", "x = $(ratio) \\cdot $(denominator_val) = $(numerator_val)")
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Type 4: Exponential equation requiring logs (ELO ~1500-1700)
        base = choice([2, 3, 5, 7])
        exponent_coeff = nonzero(-3, 3)
        power = randint(2, 5)
        rhs = base^power
        # base^(exponent_coeff * x) = rhs
        ans = power // exponent_coeff
        if denominator(ans) != 1
            ans_display = "\\frac{$(numerator(ans))}{$(denominator(ans))}"
            ans_val = float(ans)
        else
            ans_display = "$(numerator(ans))"
            ans_val = numerator(ans)
        end
        
        exponent_display = exponent_coeff == 1 ? "x" : exponent_coeff == -1 ? "-x" : "$(exponent_coeff)x"
        
        problem(
            question="Solve for \\(x\\): \\($(base)^{$(exponent_display)} = $(rhs)\\)",
            answer=ans_val,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", "$(base)^{$(exponent_display)} = $(rhs)"),
                "Rewrite RHS as power of $(base): \\($(rhs) = $(base)^{$(power)}\\)",
                "Equate exponents: \\($(exponent_display) = $(power)\\)",
                sol("Solve for x", "x = $(ans_display)")
            ),
            time=150
        )
        
    else
        # Type 5: log equation with quadratic substitution (ELO ~1600-1800)
        base = choice([2, 3, 10])
        # (log_b(x))^2 + a*log_b(x) + c = 0
        # Let u = log_b(x), solve u^2 + au + c = 0
        root1 = randint(1, 4)
        root2 = randint(1, 4)
        a_coeff = -(root1 + root2)
        c_coeff = root1 * root2
        
        x1 = base^root1
        x2 = base^root2
        
        if base == 10
            log_notation = "\\log"
        else
            log_notation = "\\log_{$(base)}"
        end
        
        middle_term = a_coeff == 0 ? "" : a_coeff > 0 ? " + $(a_coeff)$(log_notation)(x)" : " - $(abs(a_coeff))$(log_notation)(x)"
        constant_term = c_coeff == 0 ? "" : c_coeff > 0 ? " + $(c_coeff)" : " - $(abs(c_coeff))"
        
        problem(
            question="Solve for \\(x\\): \\(($(log_notation)(x))^2$(middle_term)$(constant_term) = 0\\)",
            answer=fmt_set(Set([x1, x2])),
            difficulty=(1600, 1800),
            answer_type="set",
            solution=steps(
                sol("Given", "($(log_notation)(x))^2$(middle_term)$(constant_term) = 0"),
                "Let \\(u = $(log_notation)(x)\\), then \\(u^2 + $(a_coeff)u + $(c_coeff) = 0\\)",
                "Factor: \\((u - $(root1))(u - $(root2)) = 0\\), so \\(u = $(root1)\\) or \\(u = $(root2)\\)",
                "Convert back: \\($(log_notation)(x) = $(root1) \\Rightarrow x = $(base)^{$(root1)} = $(x1)\\)",
                "And: \\($(log_notation)(x) = $(root2) \\Rightarrow x = $(base)^{$(root2)} = $(x2)\\)",
                sol("Solution set", "\\{$(x1), $(x2)\\}")
            ),
            time=180
        )
    end
end