# arithmetic - order_of_operations (competition)
# Generated: 2026-03-08T19:51:20.109066

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("arithmetic/order_of_operations")
    
    # For Olympiad/Research-Adjacent level (3500-5000 ELO), we need extremely complex order of operations
    # that require deep pattern recognition, clever grouping, and non-obvious simplifications
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Nested exponentials with factorial-like patterns
        # Example: ((2^3)^2)^2 - (2^(3^2))^2 + 2^(2^(3+1))
        a = randint(2, 5)
        b = randint(2, 4)
        c = randint(2, 4)
        d = randint(1, 3)
        e = randint(1, 3)
        
        term1 = ((a^b)^c)^d
        term2 = (a^(b^c))^e
        term3 = a^(b^(c+d))
        term4 = (a^b)^(c*d)
        
        # Create a complex expression with strategic cancellations
        ans = term1 - term2 + term3 - term4
        
        question_expr = "(($(a)^{$(b)})^{$(c)})^{$(d)} - ($(a)^{$(b)^{$(c)}})^{$(e)} + $(a)^{$(b)^{$(c)+$(d)}} - ($(a)^{$(b)})^{$(c) \\cdot $(d)}"
        
        solution_text = steps(
            sol("Given expression", question_expr),
            "Simplify exponents using power rules: \$(a^m)^n = a^{mn}\$ and \$a^{m^n} \\neq (a^m)^n\$",
            sol("Term 1", "(($(a)^{$(b)})^{$(c)})^{$(d)} = $(a)^{$(b*c*d)} = $(term1)"),
            sol("Term 2", "($(a)^{$(b)^{$(c)}})^{$(e)} = ($(a)^{$(b^c)})^{$(e)} = $(a)^{$(b^c * e)} = $(term2)"),
            sol("Term 3", "$(a)^{$(b)^{$(c)+$(d)}} = $(a)^{$(b^(c+d))} = $(term3)"),
            sol("Term 4", "($(a)^{$(b)})^{$(c) \\cdot $(d)} = $(a)^{$(b*c*d)} = $(term4)"),
            "Combine: \$$(term1) - $(term2) + $(term3) - $(term4)\$",
            sol("Final Answer", ans)
        )
        
    elseif problem_type == 2
        # Type 2: Deeply nested fractions with distributed operations
        a = randint(3, 8)
        b = randint(2, 6)
        c = randint(2, 5)
        d = randint(3, 7)
        e = randint(2, 4)
        
        # ((a + b/c) * d - e) / (a - b/c) evaluated carefully
        numerator_part = (a + b//c) * d - e
        denominator_part = a - b//c
        main_result = numerator_part / denominator_part
        
        # Add nested exponentiation
        f = randint(2, 3)
        ans_frac = main_result^f
        ans = Float64(ans_frac)
        
        question_expr = "\\left(\\frac{($(a) + \\frac{$(b)}{$(c)}) \\cdot $(d) - $(e)}{$(a) - \\frac{$(b)}{$(c)}}\\right)^{$(f)}"
        
        solution_text = steps(
            sol("Given expression", question_expr),
            "Evaluate innermost fractions: \$\\frac{$(b)}{$(c)} = $(b//c)\$",
            sol("Numerator", "($(a) + $(b//c)) \\cdot $(d) - $(e) = $(a + b//c) \\cdot $(d) - $(e) = $(numerator_part)"),
            sol("Denominator", "$(a) - $(b//c) = $(denominator_part)"),
            sol("Division", "\\frac{$(numerator_part)}{$(denominator_part)} = $(main_result)"),
            sol("Final exponentiation", "($(main_result))^{$(f)} = $(ans_frac)"),
            sol("Answer", ans)
        )
        
    elseif problem_type == 3
        # Type 3: Mixed radicals and rational exponents with strategic grouping
        a = randint(2, 4)
        b = randint(2, 5)
        c = randint(3, 6)
        d = randint(2, 4)
        
        # Expression: (a^(b/c))^c + a^b - (a^d)^(b/d)
        term1 = (a^(b//c))^c
        term2 = a^b
        term3 = (a^d)^(b//d)
        
        ans = round(Int, term1 + term2 - term3)

        question_expr = "($(a)^{\\frac{$(b)}{$(c)}})^{$(c)} + $(a)^{$(b)} - ($(a)^{$(d)})^{\\frac{$(b)}{$(d)}}"
        
        solution_text = steps(
            sol("Given expression", question_expr),
            "Apply exponent rule: \$(a^{m/n})^n = a^m\$ and \$(a^m)^{p/q} = a^{mp/q}\$",
            sol("Term 1", "($(a)^{\\frac{$(b)}{$(c)}})^{$(c)} = $(a)^{$(b)} = $(term1)"),
            sol("Term 2", "$(a)^{$(b)} = $(term2)"),
            sol("Term 3", "($(a)^{$(d)})^{\\frac{$(b)}{$(d)}} = $(a)^{$(b)} = $(term3)"),
            "Combine: \$$(term1) + $(term2) - $(term3)\$",
            sol("Final Answer", ans)
        )
        
    else
        # Type 4: Complex nested operations with hidden algebraic structure
        a = randint(3, 7)
        b = randint(2, 5)
        c = randint(2, 4)
        d = randint(1, 3)
        
        # ((a^b - a^(b-1))/(a-1))^c - a^(b*c-1)/(a^(c-1))
        numerator1 = a^b - a^(b-1)
        denominator1 = a - 1
        ratio1 = numerator1 // denominator1
        term1 = ratio1^c
        
        numerator2 = a^(b*c-1)
        denominator2 = a^(c-1)
        term2 = numerator2 // denominator2
        
        ans = round(Int, term1 - term2)

        question_expr = "\\left(\\frac{$(a)^{$(b)} - $(a)^{$(b-1)}}{$(a) - 1}\\right)^{$(c)} - \\frac{$(a)^{$(b*c-1)}}{$(a)^{$(c-1)}}"
        
        solution_text = steps(
            sol("Given expression", question_expr),
            "Simplify first fraction: factor numerator as \$$(a)^{$(b-1)}($(a) - 1)\$",
            sol("Simplification", "\\frac{$(a)^{$(b-1)}($(a) - 1)}{$(a) - 1} = $(a)^{$(b-1)} = $(a^(b-1))"),
            sol("First term", "($(a^(b-1)))^{$(c)} = $(a)^{$(Int((b-1)*c))} = $(term1)"),
            sol("Second term", "\\frac{$(a)^{$(b*c-1)}}{$(a)^{$(c-1)}} = $(a)^{$(b*c-1-c+1)} = $(a)^{$(b*c-c)} = $(term2)"),
            "Combine: \$$(term1) - $(term2)\$",
            sol("Final Answer", ans)
        )
    end
    
    problem(
        question="Evaluate the following expression without a calculator:\n\n\$\$$(question_expr)\$\$",
        answer=ans,
        difficulty=(3500, 5000),
        solution=solution_text,
        calculator="none",
        time=300
    )
end