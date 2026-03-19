# arithmetic - mixed_numbers (very_hard)
# Generated: 2026-03-08T19:49:33.857133

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/mixed_numbers")
    
    # Competition to Olympiad level (2500-3500): 
    # Complex nested operations with mixed numbers, requiring deep insight
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Nested fraction expressions with mixed numbers requiring pattern recognition
        a = randint(3, 8)
        b = randint(2, 7)
        c = randint(2, 6)
        d = randint(3, 9)
        e = randint(2, 5)
        f = randint(1, 4)
        
        # Create: (a + b/c) / (d - e/f)
        num_whole = a
        num_frac_num = b
        num_frac_den = c
        den_whole = d
        den_frac_num = e
        den_frac_den = f
        
        # Convert to improper fractions
        num_improper_num = a * c + b
        num_improper_den = c
        den_improper_num = d * f - e
        den_improper_den = f
        
        # Result: (num_improper_num/num_improper_den) / (den_improper_num/den_improper_den)
        #       = (num_improper_num * den_improper_den) / (num_improper_den * den_improper_num)
        result_num = num_improper_num * den_improper_den
        result_den = num_improper_den * den_improper_num
        
        # Simplify
        g = gcd(result_num, result_den)
        result_num = result_num ÷ g
        result_den = result_den ÷ g
        
        # Convert to mixed number if needed
        if result_num >= result_den
            whole_part = result_num ÷ result_den
            frac_part_num = result_num % result_den
            if frac_part_num == 0
                answer_str = string(whole_part)
            else
                answer_str = string(whole_part) * " " * string(frac_part_num) * "/" * string(result_den)
            end
        else
            answer_str = string(result_num) * "/" * string(result_den)
        end
        
        question_str = "Simplify: \\frac{$(a)\\frac{$(b)}{$(c)}}{$(d) - \\frac{$(e)}{$(f)}}"
        
        solution_str = steps(
            "Convert mixed numbers to improper fractions",
            sol("Numerator", "$(a)\\frac{$(b)}{$(c)} = \\frac{$(num_improper_num)}{$(num_improper_den)}"),
            sol("Denominator", "$(d) - \\frac{$(e)}{$(f)} = \\frac{$(d*f) - $(e)}{$(f)} = \\frac{$(den_improper_num)}{$(den_improper_den)}"),
            "Divide fractions: multiply by reciprocal",
            sol("\\frac{$(num_improper_num)}{$(num_improper_den)} \\div \\frac{$(den_improper_num)}{$(den_improper_den)}", "\\frac{$(num_improper_num) \\times $(den_improper_den)}{$(num_improper_den) \\times $(den_improper_num)} = \\frac{$(result_num*g)}{$(result_den*g)}"),
            "Simplify by dividing by GCD = $(g)",
            sol("Answer", answer_str)
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(2500, 3000),
            solution=solution_str,
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Equation solving with complex mixed number coefficients
        # Solve: (a + b/c)x - (d + e/f) = (g + h/i)
        a = randint(2, 6)
        b = randint(1, a-1)
        c = randint(2, 5)
        d = randint(3, 8)
        e = randint(1, d-1)
        f = randint(2, 6)
        
        # Choose answer first
        ans_whole = randint(2, 7)
        ans_num = randint(1, 5)
        ans_den = randint(2, 6)
        
        # ans as improper fraction
        ans_improper_num = ans_whole * ans_den + ans_num
        ans_improper_den = ans_den
        
        # coeff as improper
        coeff_num = a * c + b
        coeff_den = c
        
        # const1 as improper
        const1_num = d * f + e
        const1_den = f
        
        # Calculate RHS: coeff * ans - const1
        # (coeff_num/coeff_den) * (ans_improper_num/ans_improper_den) - (const1_num/const1_den)
        prod_num = coeff_num * ans_improper_num
        prod_den = coeff_den * ans_improper_den
        
        # Find common denominator for subtraction
        common_den = lcm(prod_den, const1_den)
        prod_scaled_num = prod_num * (common_den ÷ prod_den)
        const1_scaled_num = const1_num * (common_den ÷ const1_den)
        
        rhs_num = prod_scaled_num - const1_scaled_num
        rhs_den = common_den
        
        # Simplify RHS
        g_rhs = gcd(abs(rhs_num), rhs_den)
        rhs_num = rhs_num ÷ g_rhs
        rhs_den = rhs_den ÷ g_rhs
        
        # Convert RHS to mixed number
        if abs(rhs_num) >= rhs_den
            rhs_whole = rhs_num ÷ rhs_den
            rhs_frac = abs(rhs_num) % rhs_den
            if rhs_frac == 0
                rhs_str = string(rhs_whole)
            else
                rhs_str = string(rhs_whole) * "\\frac{$(rhs_frac)}{$(rhs_den)}"
            end
        else
            rhs_str = "\\frac{$(rhs_num)}{$(rhs_den)}"
        end
        
        answer_str = string(ans_whole) * " " * string(ans_num) * "/" * string(ans_den)
        
        question_str = "Solve for \\(x\\): \\(($(a)\\frac{$(b)}{$(c)})x - $(d)\\frac{$(e)}{$(f)} = $(rhs_str)\\)"
        
        solution_str = steps(
            "Convert all mixed numbers to improper fractions",
            sol("$(a)\\frac{$(b)}{$(c)}", "\\frac{$(coeff_num)}{$(coeff_den)}"),
            sol("$(d)\\frac{$(e)}{$(f)}", "\\frac{$(const1_num)}{$(const1_den)}"),
            "Add \\(\\frac{$(const1_num)}{$(const1_den)}\\) to both sides and solve",
            "Multiply both sides by reciprocal of coefficient",
            sol("Answer", answer_str)
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(2800, 3200),
            solution=solution_str,
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: System with mixed numbers (Olympiad-style)
        # a*x + b*y = c and d*x + e*y = f where coefficients are mixed numbers
        
        # Choose solution first
        x_whole = randint(1, 4)
        x_num = randint(1, 3)
        x_den = randint(2, 5)
        y_whole = randint(1, 4)
        y_num = randint(1, 3)
        y_den = randint(2, 5)
        
        x_val_num = x_whole * x_den + x_num
        x_val_den = x_den
        y_val_num = y_whole * y_den + y_num
        y_val_den = y_den
        
        # Create coefficients
        a_w = randint(2, 5)
        a_n = randint(1, 3)
        a_d = randint(2, 4)
        b_w = randint(1, 4)
        b_n = randint(1, 3)
        b_d = randint(2, 4)
        
        a_num = a_w * a_d + a_n
        a_den = a_d
        b_num = b_w * b_d + b_n
        b_den = b_d
        
        # Calculate c = a*x + b*y
        term1_num = a_num * x_val_num
        term1_den = a_den * x_val_den
        term2_num = b_num * y_val_num
        term2_den = b_den * y_val_den
        
        common_c = lcm(term1_den, term2_den)
        c_num = term1_num * (common_c ÷ term1_den) + term2_num * (common_c ÷ term2_den)
        c_den = common_c
        g_c = gcd(c_num, c_den)
        c_num = c_num ÷ g_c
        c_den = c_den ÷ g_c
        
        # Second equation
        d_w = randint(1, 4)
        d_n = randint(1, 2)
        d_d = randint(2, 4)
        e_w = randint(2, 5)
        e_n = randint(1, 3)
        e_d = randint(2, 4)
        
        d_num = d_w * d_d + d_n
        d_den = d_d
        e_num = e_w * e_d + e_n
        e_den = e_d
        
        # Calculate f
        term3_num = d_num * x_val_num
        term3_den = d_den * x_val_den
        term4_num = e_num * y_val_num
        term4_den = e_den * y_val_den
        
        common_f = lcm(term3_den, term4_den)
        f_num = term3_num * (common_f ÷ term3_den) + term4_num * (common_f ÷ term4_den)
        f_den = common_f
        g_f = gcd(f_num, f_den)
        f_num = f_num ÷ g_f
        f_den = f_den ÷ g_f
        
        answer_str = "($(x_whole) $(x_num)/$(x_den), $(y_whole) $(y_num)/$(y_den))"
        
        question_str = "Solve the system: \\($(a_w)\\frac{$(a_n)}{$(a_d)}x + $(b_w)\\frac{$(b_n)}{$(b_d)}y = \\frac{$(c_num)}{$(c_den)}\\) and \\($(d_w)\\frac{$(d_n)}{$(d_d)}x + $(e_w)\\frac{$(e_n)}{$(e_d)}y = \\frac{$(f_num)}{$(f_den)}\\)"
        
        solution_str = steps(
            "Convert all mixed numbers to improper fractions",
            "Use elimination or substitution method",
            "Solve for x and y systematically",
            "Convert back to mixed number form",
            sol("Answer", "(x, y) = " * answer_str)
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(3200, 3500),
            solution=solution_str,
            answer_type="tuple",
            time=360
        )
        
    else
        # Type 4: Continued fraction with mixed numbers
        # Evaluate: a + 1/(b + 1/(c + d/e))
        a = randint(2, 6)
        b = randint(2, 5)
        c = randint(1, 4)
        d = randint(1, 3)
        e = randint(2, 5)
        
        # Work from inside out
        # c + d/e
        inner_num = c * e + d
        inner_den = e
        
        # b + 1/(c + d/e) = b + 1/(inner_num/inner_den) = b + inner_den/inner_num
        middle_num = b * inner_num + inner_den
        middle_den = inner_num
        
        # a + 1/(middle) = a + middle_den/middle_num
        final_num = a * middle_num + middle_den
        final_den = middle_num
        
        # Simplify
        g = gcd(final_num, final_den)
        final_num = final_num ÷ g
        final_den = final_den ÷ g
        
        # Convert to mixed
        if final_num >= final_den
            whole = final_num ÷ final_den
            frac = final_num % final_den
            if frac == 0
                answer_str = string(whole)
            else
                answer_str = string(whole) * " " * string(frac) * "/" * string(final_den)
            end
        else
            answer_str = string(final_num) * "/" * string(final_den)
        end
        
        question_str = "Evaluate the continued fraction: \\($(a) + \\cfrac{1}{$(b) + \\cfrac{1}{$(c) + \\frac{$(d)}{$(e)}}}\\)"
        
        solution_str = steps(
            "Work from the innermost fraction outward",
            sol("$(c) + \\frac{$(d)}{$(e)}", "\\frac{$(inner_num)}{$(inner_den)}"),
            sol("$(b) + \\cfrac{1}{\\frac{$(inner_num)}{$(inner_den)}}", "$(b) + \\frac{$(inner_den)}{$(inner_num)} = \\frac{$(middle_num)}{$(middle_den)}"),
            sol("$(a) + \\cfrac{1}{\\frac{$(middle_num)}{$(middle_den)}}", "$(a) + \\frac{$(middle_den)}{$(middle_num)} = \\frac{$(final_num*g)}{$(final_den*g)}"),
            "Simplify",
            sol("Answer", answer_str)
        )
        
        problem(
            question=question_str,
            answer=answer_str,
            difficulty=(3000, 3400),
            solution=solution_str,
            time=300
        )
    end
end