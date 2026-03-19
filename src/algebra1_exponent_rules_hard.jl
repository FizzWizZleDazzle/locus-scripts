# algebra1 - exponent_rules (hard)
# Generated: 2026-03-08T19:58:48.473851

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/exponent_rules")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Simplify product of powers with same base
        base = choice([2, 3, 5, 7])
        exp1 = randint(3, 8)
        exp2 = randint(3, 8)
        exp3 = randint(2, 6)
        total_exp = exp1 + exp2 + exp3
        
        problem(
            question="Simplify \\($(base)^{$(exp1)} \\cdot $(base)^{$(exp2)} \\cdot $(base)^{$(exp3)}\\) and express as a single power.",
            answer="$(base)^$(total_exp)",
            difficulty=(1800, 2000),
            solution=steps(
                "Given: \\($(base)^{$(exp1)} \\cdot $(base)^{$(exp2)} \\cdot $(base)^{$(exp3)}\\)",
                "Apply the product rule: \\(a^m \\cdot a^n = a^{m+n}\\)",
                "Add exponents: \\($(exp1) + $(exp2) + $(exp3) = $(total_exp)\\)",
                sol("Answer", "$(base)^{$(total_exp)}")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Power of a power with algebraic expressions
        coef = nonzero(-5, 5)
        inner_exp = randint(2, 5)
        outer_exp = randint(2, 4)
        final_exp = inner_exp * outer_exp
        final_coef = coef^outer_exp
        
        problem(
            question="Simplify \\(($(coef)x^{$(inner_exp)})^{$(outer_exp)}\\) and express in the form \\(ax^n\\).",
            answer="$(final_coef)x^$(final_exp)",
            difficulty=(1900, 2100),
            solution=steps(
                "Given: \\(($(coef)x^{$(inner_exp)})^{$(outer_exp)}\\)",
                "Apply the power rule: \\((ab)^n = a^n b^n\\) and \\((a^m)^n = a^{mn}\\)",
                "Coefficient: \\($(coef)^{$(outer_exp)} = $(final_coef)\\)",
                "Exponent: \\($(inner_exp) \\cdot $(outer_exp) = $(final_exp)\\)",
                sol("Answer", "$(final_coef)x^{$(final_exp)}")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Quotient of powers with simplification
        base = choice([2, 3, 5])
        numerator_exp = randint(8, 15)
        denominator_exp = randint(4, 8)
        result_exp = numerator_exp - denominator_exp
        
        problem(
            question="Simplify \\(\\frac{$(base)^{$(numerator_exp)}}{$(base)^{$(denominator_exp)}}\\) and express as a single power.",
            answer="$(base)^$(result_exp)",
            difficulty=(1850, 2050),
            solution=steps(
                "Given: \\(\\frac{$(base)^{$(numerator_exp)}}{$(base)^{$(denominator_exp)}}\\)",
                "Apply the quotient rule: \\(\\frac{a^m}{a^n} = a^{m-n}\\)",
                "Subtract exponents: \\($(numerator_exp) - $(denominator_exp) = $(result_exp)\\)",
                sol("Answer", "$(base)^{$(result_exp)}")
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Complex expression with multiple variables
        a_exp = randint(3, 7)
        b_exp = randint(2, 6)
        c_exp = randint(2, 5)
        power = randint(2, 4)
        
        final_a = a_exp * power
        final_b = b_exp * power
        final_c = c_exp * power
        
        problem(
            question="Simplify \\((x^{$(a_exp)} y^{$(b_exp)} z^{$(c_exp)})^{$(power)}\\) and express in the form \\(x^a y^b z^c\\).",
            answer="x^$(final_a)*y^$(final_b)*z^$(final_c)",
            difficulty=(2000, 2200),
            solution=steps(
                "Given: \\((x^{$(a_exp)} y^{$(b_exp)} z^{$(c_exp)})^{$(power)}\\)",
                "Apply the power rule to each variable: \\((a^m)^n = a^{mn}\\)",
                "\\(x: $(a_exp) \\cdot $(power) = $(final_a)\\)",
                "\\(y: $(b_exp) \\cdot $(power) = $(final_b)\\)",
                "\\(z: $(c_exp) \\cdot $(power) = $(final_c)\\)",
                sol("Answer", "x^{$(final_a)} y^{$(final_b)} z^{$(final_c)}")
            ),
            time=150
        )
        
    elseif problem_type == 5
        # Negative and zero exponents with fractions
        base_num = choice([2, 3, 5, 7])
        base_den = choice([2, 3, 5, 7])
        while base_den == base_num
            base_den = choice([2, 3, 5, 7])
        end
        
        exp = randint(3, 6)
        ans_num = base_den^exp
        ans_den = base_num^exp
        
        problem(
            question="Simplify \\(\\left(\\frac{$(base_num)}{$(base_den)}\\right)^{-$(exp)}\\) and express as a simplified fraction.",
            answer="$(ans_num)/$(ans_den)",
            difficulty=(2100, 2300),
            solution=steps(
                "Given: \\(\\left(\\frac{$(base_num)}{$(base_den)}\\right)^{-$(exp)}\\)",
                "Apply the negative exponent rule: \\(a^{-n} = \\frac{1}{a^n}\\)",
                "This gives: \\(\\left(\\frac{$(base_den)}{$(base_num)}\\right)^{$(exp)}\\)",
                "Apply power to numerator and denominator: \\(\\frac{$(base_den)^{$(exp)}}{$(base_num)^{$(exp)}} = \\frac{$(ans_num)}{$(ans_den)}\\)",
                sol("Answer", "\\frac{$(ans_num)}{$(ans_den)}")
            ),
            time=180
        )
        
    else  # problem_type == 6
        # Multi-step simplification combining rules
        coef1 = nonzero(-4, 4)
        coef2 = nonzero(-4, 4)
        exp1 = randint(4, 8)
        exp2 = randint(3, 7)
        exp3 = randint(2, 4)
        
        final_coef = coef1 * coef2^exp3
        final_exp = exp1 + exp2 * exp3
        
        problem(
            question="Simplify \\($(coef1)x^{$(exp1)} \\cdot ($(coef2)x^{$(exp2)})^{$(exp3)}\\) and express in the form \\(ax^n\\).",
            answer="$(final_coef)x^$(final_exp)",
            difficulty=(2200, 2400),
            solution=steps(
                "Given: \\($(coef1)x^{$(exp1)} \\cdot ($(coef2)x^{$(exp2)})^{$(exp3)}\\)",
                "First simplify the power: \\(($(coef2)x^{$(exp2)})^{$(exp3)} = $(coef2^exp3)x^{$(exp2 * exp3)}\\)",
                "Now multiply: \\($(coef1)x^{$(exp1)} \\cdot $(coef2^exp3)x^{$(exp2 * exp3)}\\)",
                "Combine coefficients: \\($(coef1) \\cdot $(coef2^exp3) = $(final_coef)\\)",
                "Add exponents: \\($(exp1) + $(exp2 * exp3) = $(final_exp)\\)",
                sol("Answer", "$(final_coef)x^{$(final_exp)}")
            ),
            time=200
        )
    end
end