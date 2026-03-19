# algebra1 - one_step_equations (hard)
# Generated: 2026-03-08T19:52:23.236896

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/one_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Fractional coefficient with large denominators (1800-2000)
        ans = randint(-50, 50)
        num = nonzero(-15, 15)
        den = choice([7, 9, 11, 13, 17, 19, 23])
        rhs = randint(-100, 100)
        coeff = num // den
        lhs_val = coeff * ans
        
        question_str = "Solve \\\$\\frac{$(num)}{$(den)}x = $(tex(lhs_val))\\\$"
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", (num//den)*x ~ lhs_val),
                "Multiply both sides by \\\$\\frac{$(den)}{$(num)}\\\$",
                sol("Simplify", x ~ ans),
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Equation with nested radicals (1900-2100)
        ans = choice([4, 9, 16, 25, 36, 49, 64, 81, 100, 121, 144])
        inner = randint(2, 8)
        k = nonzero(-12, 12)
        
        outer_val = inner * sqrt(ans) + k
        
        question_str = "Solve \\\$\\sqrt{x} = \\frac{$(tex(outer_val)) - $(k)}{$(inner)}\\\$"
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Given: \\\$\\sqrt{x} = \\frac{$(tex(outer_val)) - $(k)}{$(inner)}\\\$",
                "Simplify right side: \\\$\\sqrt{x} = $(tex(sqrt(ans)))\\\$",
                "Square both sides",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Absolute value with fractional result (2000-2200)
        ans_num = randint(-30, 30)
        ans_den = choice([3, 5, 7, 9, 11])
        ans = ans_num // ans_den
        abs_ans = abs(ans)
        
        k = nonzero(-20, 20)
        rhs = abs_ans + k
        
        question_str = "Solve \\\$|x| + $(k) = $(tex(rhs))\\\$"
        
        ans_set = fmt_set(Set([ans, -ans]))
        
        problem(
            question=question_str,
            answer=ans_set,
            answer_type="set",
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", "|x| + $(k)" ~ rhs),
                "Subtract $(k) from both sides: \\\$|x| = $(tex(abs_ans))\\\$",
                "Absolute value gives two solutions",
                sol("Answer", ans_set)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Exponential equation requiring logarithm insight (2100-2300)
        base = choice([2, 3, 5, 7])
        ans = randint(4, 12)
        value = base^ans
        
        question_str = "Solve \\\$$(base)^x = $(value)\\\$"
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", "$(base)^x" ~ value),
                "Recognize that \\\$$(value) = $(base)^{$(ans)}\\\$",
                "Since bases are equal, exponents must be equal",
                sol("Answer", ans)
            ),
            time=180
        )
        
    else
        # Rational equation with large coefficients (2200-2400)
        ans = nonzero(-25, 25)
        a = nonzero(-15, 15)
        b = nonzero(-30, 30)
        
        # a/(x) = b/ans, so a*ans = b*x
        # We want x = ans, so we need a*ans = b*ans, which means we set the RHS appropriately
        rhs_num = a * ans
        rhs_den = b
        
        question_str = "Solve \\\$\\frac{$(a)}{x} = \\frac{$(rhs_num)}{$(b*ans)}\\\$"
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(2200, 2400),
            solution=steps(
                sol("Given", "\\frac{$(a)}{x}" ~ "\\frac{$(rhs_num)}{$(b*ans)}"),
                "Cross multiply: \\\$$(a) \\cdot $(b*ans) = $(rhs_num) \\cdot x\\\$",
                "Simplify: \\\$$(a * b * ans) = $(rhs_num) x\\\$",
                "Divide both sides by $(rhs_num)",
                sol("Answer", ans)
            ),
            time=200
        )
    end
end