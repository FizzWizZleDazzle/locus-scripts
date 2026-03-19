# arithmetic - fractions (hard)
# Generated: 2026-03-08T19:48:15.742070

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/fractions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Complex fraction addition with large denominators requiring LCM
        a = randint(3, 15)
        b = randint(3, 15)
        c = randint(3, 15)
        d = randint(3, 15)
        
        # Ensure denominators are coprime for interesting LCM
        denom1 = randint(7, 25)
        denom2 = randint(7, 25)
        while gcd(denom1, denom2) > 1
            denom2 = randint(7, 25)
        end
        
        num1 = a * denom2 + b * denom1
        num2 = c * denom2 - d * denom1
        denom = denom1 * denom2
        
        ans_num = num1 + num2
        ans_denom = denom
        g = gcd(ans_num, ans_denom)
        ans_num = ans_num ÷ g
        ans_denom = ans_denom ÷ g
        
        problem(
            question="Simplify: \\frac{$(a)}{$(denom1)} + \\frac{$(b)}{$(denom2)} + \\frac{$(c)}{$(denom1)} - \\frac{$(d)}{$(denom2)}",
            answer="$(ans_num)/$(ans_denom)",
            difficulty=(1800, 2000),
            solution=steps(
                "Given: \\frac{$(a)}{$(denom1)} + \\frac{$(b)}{$(denom2)} + \\frac{$(c)}{$(denom1)} - \\frac{$(d)}{$(denom2)}",
                "Group terms: \\frac{$(a) + $(c)}{$(denom1)} + \\frac{$(b) - $(d)}{$(denom2)}",
                "LCM of $(denom1) and $(denom2) is $(denom)",
                "Convert to common denominator: \\frac{$(num1)}{$(denom)} + \\frac{$(num2)}{$(denom)}",
                "Add: \\frac{$(ans_num * g)}{$(ans_denom * g)}",
                sol("Simplified", "\\frac{$(ans_num)}{$(ans_denom)}")
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Nested fraction simplification
        a = randint(2, 12)
        b = randint(2, 12)
        c = randint(2, 12)
        d = randint(2, 12)
        e = randint(2, 12)
        f = randint(2, 12)
        
        # Build (a + b/c) / (d + e/f)
        top_num = a * c + b
        top_denom = c
        bot_num = d * f + e
        bot_denom = f
        
        # Simplify: (top_num/top_denom) / (bot_num/bot_denom) = (top_num * bot_denom) / (top_denom * bot_num)
        ans_num = top_num * bot_denom
        ans_denom = top_denom * bot_num
        g = gcd(ans_num, ans_denom)
        ans_num = ans_num ÷ g
        ans_denom = ans_denom ÷ g
        
        problem(
            question="Simplify the complex fraction: \\frac{$(a) + \\frac{$(b)}{$(c)}}{$(d) + \\frac{$(e)}{$(f)}}",
            answer="$(ans_num)/$(ans_denom)",
            difficulty=(1900, 2100),
            solution=steps(
                "Given: \\frac{$(a) + \\frac{$(b)}{$(c)}}{$(d) + \\frac{$(e)}{$(f)}}",
                "Simplify numerator: $(a) + \\frac{$(b)}{$(c)} = \\frac{$(top_num)}{$(top_denom)}",
                "Simplify denominator: $(d) + \\frac{$(e)}{$(f)} = \\frac{$(bot_num)}{$(bot_denom)}",
                "Divide fractions: \\frac{$(top_num)}{$(top_denom)} ÷ \\frac{$(bot_num)}{$(bot_denom)} = \\frac{$(top_num)}{$(top_denom)} \\times \\frac{$(bot_denom)}{$(bot_num)}",
                "Multiply: \\frac{$(top_num * bot_denom)}{$(top_denom * bot_num)}",
                sol("Simplified", "\\frac{$(ans_num)}{$(ans_denom)}")
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Fraction equation with multiple terms
        x_num = randint(5, 20)
        x_denom = randint(3, 12)
        
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 8)
        denom1 = randint(3, 15)
        denom2 = randint(3, 15)
        while gcd(denom1, denom2) > 1
            denom2 = randint(3, 15)
        end
        
        # Construct: a*x/denom1 + b/denom2 = c
        # Solution: x = (c - b/denom2) * denom1/a
        lcm_val = lcm(denom1, denom2)
        
        # Solve for x_num/x_denom
        # a*x/denom1 = c - b/denom2
        rhs_num = c * denom2 - b
        rhs_denom = denom2
        
        # x = (rhs_num/rhs_denom) * (denom1/a)
        ans_num = rhs_num * denom1
        ans_denom = rhs_denom * a
        g = gcd(ans_num, ans_denom)
        ans_num = ans_num ÷ g
        ans_denom = ans_denom ÷ g
        
        problem(
            question="Solve for x: \\frac{$(a)x}{$(denom1)} + \\frac{$(b)}{$(denom2)} = $(c)",
            answer="$(ans_num)/$(ans_denom)",
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given", "\\frac{$(a)x}{$(denom1)} + \\frac{$(b)}{$(denom2)} = $(c)"),
                "Subtract \\frac{$(b)}{$(denom2)} from both sides: \\frac{$(a)x}{$(denom1)} = $(c) - \\frac{$(b)}{$(denom2)}",
                "Simplify right side: \\frac{$(a)x}{$(denom1)} = \\frac{$(rhs_num)}{$(rhs_denom)}",
                "Multiply both sides by \\frac{$(denom1)}{$(a)}: x = \\frac{$(rhs_num)}{$(rhs_denom)} \\times \\frac{$(denom1)}{$(a)}",
                "Simplify: x = \\frac{$(rhs_num * denom1)}{$(rhs_denom * a)}",
                sol("Answer", "x = \\frac{$(ans_num)}{$(ans_denom)}")
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Fraction word problem with multiple operations
        total = randint(100, 500)
        frac1_num = randint(1, 5)
        frac1_denom = randint(frac1_num + 2, 12)
        frac2_num = randint(1, 5)
        frac2_denom = randint(frac2_num + 2, 12)
        
        amount1 = (total * frac1_num) ÷ frac1_denom
        amount2 = (total * frac2_num) ÷ frac2_denom
        remaining = total - amount1 - amount2
        
        # Recalculate to ensure exact division
        while (total * frac1_num) % frac1_denom != 0 || (total * frac2_num) % frac2_denom != 0
            total = randint(100, 500)
        end
        
        amount1 = (total * frac1_num) ÷ frac1_denom
        amount2 = (total * frac2_num) ÷ frac2_denom
        remaining = total - amount1 - amount2
        
        problem(
            question="A charity receives \\\$$(total). They spend \\frac{$(frac1_num)}{$(frac1_denom)} on food and \\frac{$(frac2_num)}{$(frac2_denom)} on medical supplies. What fraction of the total remains?",
            answer="$(remaining)/$(total)",
            difficulty=(2000, 2200),
            solution=steps(
                "Calculate food spending: \\frac{$(frac1_num)}{$(frac1_denom)} \\times $(total) = \\\$$(amount1)",
                "Calculate medical spending: \\frac{$(frac2_num)}{$(frac2_denom)} \\times $(total) = \\\$$(amount2)",
                "Total spent: \\\$$(amount1 + amount2)",
                "Remaining: \\\$$(total) - \\\$$(amount1 + amount2) = \\\$$(remaining)",
                "Fraction remaining: \\frac{$(remaining)}{$(total)}",
                sol("Simplified", "\\frac{$(remaining ÷ gcd(remaining, total))}{$(total ÷ gcd(remaining, total))}")
            ),
            time=240
        )
        
    else
        # Fraction with exponents and multiplication
        base_num = randint(2, 7)
        base_denom = randint(2, 7)
        exp1 = randint(2, 5)
        exp2 = randint(2, 5)
        
        mult_num = randint(2, 8)
        mult_denom = randint(2, 8)
        
        # (base_num/base_denom)^exp1 * (mult_num/mult_denom) / (base_num/base_denom)^exp2
        # = (base_num/base_denom)^(exp1-exp2) * (mult_num/mult_denom)
        
        exp_diff = exp1 - exp2
        
        if exp_diff >= 0
            result_num = (base_num^exp_diff) * mult_num
            result_denom = (base_denom^exp_diff) * mult_denom
        else
            result_num = (base_denom^(-exp_diff)) * mult_num
            result_denom = (base_num^(-exp_diff)) * mult_denom
        end
        
        g = gcd(result_num, result_denom)
        ans_num = result_num ÷ g
        ans_denom = result_denom ÷ g
        
        problem(
            question="Simplify: \\left(\\frac{$(base_num)}{$(base_denom)}\\right)^{$(exp1)} \\times \\frac{$(mult_num)}{$(mult_denom)} \\div \\left(\\frac{$(base_num)}{$(base_denom)}\\right)^{$(exp2)}",
            answer="$(ans_num)/$(ans_denom)",
            difficulty=(2100, 2400),
            solution=steps(
                "Apply exponent rule: \\left(\\frac{a}{b}\\right)^m \\div \\left(\\frac{a}{b}\\right)^n = \\left(\\frac{a}{b}\\right)^{m-n}",
                "Simplify: \\left(\\frac{$(base_num)}{$(base_denom)}\\right)^{$(exp1) - $(exp2)} \\times \\frac{$(mult_num)}{$(mult_denom)}",
                "Calculate: \\left(\\frac{$(base_num)}{$(base_denom)}\\right)^{$(exp_diff)} \\times \\frac{$(mult_num)}{$(mult_denom)}",
                exp_diff >= 0 ? "Evaluate: \\frac{$(base_num^exp_diff)}{$(base_denom^exp_diff)} \\times \\frac{$(mult_num)}{$(mult_denom)}" : "Evaluate: \\frac{$(base_denom^(-exp_diff))}{$(base_num^(-exp_diff))} \\times \\frac{$(mult_num)}{$(mult_denom)}",
                "Multiply: \\frac{$(result_num)}{$(result_denom)}",
                sol("Simplified", "\\frac{$(ans_num)}{$(ans_denom)}")
            ),
            time=200
        )
    end
end