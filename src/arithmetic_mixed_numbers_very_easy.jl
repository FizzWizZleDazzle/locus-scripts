# arithmetic - mixed_numbers (very_easy)
# Generated: 2026-03-08T19:48:23.469830

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/mixed_numbers")
    
    problem_type = choice([:add_mixed, :subtract_mixed, :multiply_mixed, :convert_to_improper, :convert_to_mixed, :simplify_mixed])
    
    if problem_type == :add_mixed
        # Addition of mixed numbers
        whole1 = randint(1, 8)
        whole2 = randint(1, 8)
        denom = choice([2, 3, 4, 5, 6, 8])
        num1 = randint(1, denom - 1)
        num2 = randint(1, denom - 1)
        
        # Calculate answer
        total_num = whole1 * denom + num1 + whole2 * denom + num2
        ans_whole = div(total_num, denom)
        ans_num = mod(total_num, denom)
        
        # Simplify if needed
        g = gcd(ans_num, denom)
        ans_num_simp = div(ans_num, g)
        ans_denom_simp = div(denom, g)
        
        if ans_num_simp == 0
            answer = "$(ans_whole)"
        else
            answer = "$(ans_whole) $(ans_num_simp)/$(ans_denom_simp)"
        end
        
        problem(
            question="Add: \\($(whole1)\\frac{$(num1)}{$(denom)} + $(whole2)\\frac{$(num2)}{$(denom)}\\)",
            answer=answer,
            difficulty=(400, 600),
            solution=steps(
                "Convert to improper fractions: \\(\\frac{$(whole1 * denom + num1)}{$(denom)} + \\frac{$(whole2 * denom + num2)}{$(denom)}\\)",
                "Add numerators: \\(\\frac{$(total_num)}{$(denom)}\\)",
                "Convert to mixed number and simplify: \\($(answer)\\)"
            ),
            time=90
        )
        
    elseif problem_type == :subtract_mixed
        # Subtraction of mixed numbers
        whole1 = randint(3, 10)
        whole2 = randint(1, whole1 - 1)
        denom = choice([2, 3, 4, 5, 6, 8])
        num1 = randint(1, denom - 1)
        num2 = randint(1, denom - 1)
        
        # Calculate answer
        total_num = (whole1 * denom + num1) - (whole2 * denom + num2)
        ans_whole = div(total_num, denom)
        ans_num = mod(total_num, denom)
        
        # Simplify
        g = gcd(ans_num, denom)
        ans_num_simp = div(ans_num, g)
        ans_denom_simp = div(denom, g)
        
        if ans_num_simp == 0
            answer = "$(ans_whole)"
        else
            answer = "$(ans_whole) $(ans_num_simp)/$(ans_denom_simp)"
        end
        
        problem(
            question="Subtract: \\($(whole1)\\frac{$(num1)}{$(denom)} - $(whole2)\\frac{$(num2)}{$(denom)}\\)",
            answer=answer,
            difficulty=(500, 650),
            solution=steps(
                "Convert to improper fractions: \\(\\frac{$(whole1 * denom + num1)}{$(denom)} - \\frac{$(whole2 * denom + num2)}{$(denom)}\\)",
                "Subtract numerators: \\(\\frac{$(total_num)}{$(denom)}\\)",
                "Convert to mixed number and simplify: \\($(answer)\\)"
            ),
            time=90
        )
        
    elseif problem_type == :multiply_mixed
        # Multiplication of mixed numbers
        whole1 = randint(1, 5)
        whole2 = randint(1, 5)
        denom1 = choice([2, 3, 4, 5])
        denom2 = choice([2, 3, 4, 5])
        num1 = randint(1, denom1 - 1)
        num2 = randint(1, denom2 - 1)
        
        # Convert to improper
        improper1_num = whole1 * denom1 + num1
        improper2_num = whole2 * denom2 + num2
        
        # Multiply
        result_num = improper1_num * improper2_num
        result_denom = denom1 * denom2
        
        # Simplify
        g = gcd(result_num, result_denom)
        result_num = div(result_num, g)
        result_denom = div(result_denom, g)
        
        ans_whole = div(result_num, result_denom)
        ans_num = mod(result_num, result_denom)
        
        if ans_num == 0
            answer = "$(ans_whole)"
        else
            answer = "$(ans_whole) $(ans_num)/$(result_denom)"
        end
        
        problem(
            question="Multiply: \\($(whole1)\\frac{$(num1)}{$(denom1)} \\times $(whole2)\\frac{$(num2)}{$(denom2)}\\)",
            answer=answer,
            difficulty=(600, 700),
            solution=steps(
                "Convert to improper fractions: \\(\\frac{$(improper1_num)}{$(denom1)} \\times \\frac{$(improper2_num)}{$(denom2)}\\)",
                "Multiply: \\(\\frac{$(improper1_num * improper2_num)}{$(denom1 * denom2)}\\)",
                "Simplify and convert to mixed number: \\($(answer)\\)"
            ),
            time=120
        )
        
    elseif problem_type == :convert_to_improper
        # Convert mixed to improper
        whole = randint(2, 12)
        denom = choice([2, 3, 4, 5, 6, 8, 10])
        num = randint(1, denom - 1)
        
        improper_num = whole * denom + num
        answer = "$(improper_num)/$(denom)"
        
        problem(
            question="Convert to an improper fraction: \\($(whole)\\frac{$(num)}{$(denom)}\\)",
            answer=answer,
            difficulty=(200, 400),
            solution=steps(
                "Multiply whole number by denominator: \\($(whole) \\times $(denom) = $(whole * denom)\\)",
                "Add the numerator: \\($(whole * denom) + $(num) = $(improper_num)\\)",
                "Write as improper fraction: \\(\\frac{$(improper_num)}{$(denom)}\\)"
            ),
            time=60
        )
        
    elseif problem_type == :convert_to_mixed
        # Convert improper to mixed
        denom = choice([2, 3, 4, 5, 6, 8])
        whole = randint(2, 10)
        num_part = randint(1, denom - 1)
        improper_num = whole * denom + num_part
        
        answer = "$(whole) $(num_part)/$(denom)"
        
        problem(
            question="Convert to a mixed number: \\(\\frac{$(improper_num)}{$(denom)}\\)",
            answer=answer,
            difficulty=(300, 500),
            solution=steps(
                "Divide numerator by denominator: \\($(improper_num) \\div $(denom) = $(whole)\\) remainder \\($(num_part)\\)",
                "Whole number is \\($(whole)\\), remainder becomes numerator",
                "Mixed number: \\($(whole)\\frac{$(num_part)}{$(denom)}\\)"
            ),
            time=60
        )
        
    else  # simplify_mixed
        # Simplify a mixed number
        whole = randint(1, 8)
        denom_base = choice([2, 3, 4, 5, 6])
        multiplier = choice([2, 3, 4])
        denom = denom_base * multiplier
        num = randint(1, denom - 1) * multiplier
        
        g = gcd(num, denom)
        num_simp = div(num, g)
        denom_simp = div(denom, g)
        
        answer = "$(whole) $(num_simp)/$(denom_simp)"
        
        problem(
            question="Simplify: \\($(whole)\\frac{$(num)}{$(denom)}\\)",
            answer=answer,
            difficulty=(300, 500),
            solution=steps(
                "Find GCD of \\($(num)\\) and \\($(denom)\\): GCD = \\($(g)\\)",
                "Divide both numerator and denominator by \\($(g)\\)",
                "Simplified form: \\($(whole)\\frac{$(num_simp)}{$(denom_simp)}\\)"
            ),
            time=60
        )
    end
end