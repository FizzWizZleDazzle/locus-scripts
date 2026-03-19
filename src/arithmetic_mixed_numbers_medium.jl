# arithmetic - mixed_numbers (medium)
# Generated: 2026-03-08T19:49:00.110713

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/mixed_numbers")
    
    prob_type = rand(1:6)
    
    if prob_type == 1
        # Addition of mixed numbers requiring regrouping
        whole1 = randint(2, 8)
        whole2 = randint(2, 8)
        num1 = randint(1, 7)
        num2 = randint(1, 7)
        denom = choice([3, 4, 5, 6, 8, 10, 12])
        
        # Ensure addition requires regrouping
        num1 = randint(denom ÷ 2, denom - 1)
        num2 = randint(denom ÷ 2, denom - 1)
        
        sum_num = num1 + num2
        extra_wholes = sum_num ÷ denom
        final_num = sum_num % denom
        final_whole = whole1 + whole2 + extra_wholes
        
        # Simplify if needed
        g = gcd(final_num, denom)
        final_num_simp = final_num ÷ g
        final_denom = denom ÷ g
        
        answer = final_num_simp == 0 ? "$final_whole" : "$(final_whole) $(final_num_simp)/$(final_denom)"
        
        problem(
            question="Add and simplify: \$$(whole1)\\frac{$(num1)}{$(denom)} + $(whole2)\\frac{$(num2)}{$(denom)}\$",
            answer=answer,
            difficulty=(1200, 1400),
            solution=steps(
                "Add whole numbers: \$$(whole1) + $(whole2) = $(whole1 + whole2)\$",
                "Add fractions: \$\\frac{$(num1)}{$(denom)} + \\frac{$(num2)}{$(denom)} = \\frac{$(sum_num)}{$(denom)}\$",
                "Convert improper fraction: \$\\frac{$(sum_num)}{$(denom)} = $(extra_wholes)\\frac{$(final_num)}{$(denom)}\$",
                "Combine: \$$(whole1 + whole2) + $(extra_wholes)\\frac{$(final_num)}{$(denom)} = $(final_whole)\\frac{$(final_num)}{$(denom)}\$",
                g > 1 ? "Simplify: \$$(answer)\$" : "Answer: \$$(answer)\$"
            ),
            time=120
        )
        
    elseif prob_type == 2
        # Subtraction of mixed numbers requiring borrowing
        whole1 = randint(5, 12)
        whole2 = randint(2, whole1 - 2)
        denom = choice([4, 5, 6, 8, 10, 12])
        num1 = randint(1, denom - 1)
        num2 = randint(num1 + 1, denom - 1)  # Force borrowing
        
        # Convert to improper fractions
        imp1 = whole1 * denom + num1
        imp2 = whole2 * denom + num2
        result = imp1 - imp2
        
        final_whole = result ÷ denom
        final_num = result % denom
        
        g = gcd(final_num, denom)
        final_num_simp = final_num ÷ g
        final_denom = denom ÷ g
        
        answer = final_num_simp == 0 ? "$final_whole" : "$(final_whole) $(final_num_simp)/$(final_denom)"
        
        problem(
            question="Subtract and simplify: \$$(whole1)\\frac{$(num1)}{$(denom)} - $(whole2)\\frac{$(num2)}{$(denom)}\$",
            answer=answer,
            difficulty=(1300, 1500),
            solution=steps(
                "Convert to improper fractions: \$\\frac{$(imp1)}{$(denom)} - \\frac{$(imp2)}{$(denom)}\$",
                "Subtract: \$\\frac{$(result)}{$(denom)}\$",
                "Convert to mixed number: \$$(final_whole)\\frac{$(final_num)}{$(denom)}\$",
                g > 1 ? "Simplify: \$$(answer)\$" : "Answer: \$$(answer)\$"
            ),
            time=150
        )
        
    elseif prob_type == 3
        # Multiplication of mixed numbers
        whole1 = randint(2, 6)
        whole2 = randint(2, 6)
        denom1 = choice([2, 3, 4, 5, 6, 8])
        denom2 = choice([2, 3, 4, 5, 6, 8])
        num1 = randint(1, denom1 - 1)
        num2 = randint(1, denom2 - 1)
        
        imp1 = whole1 * denom1 + num1
        imp2 = whole2 * denom2 + num2
        
        result_num = imp1 * imp2
        result_denom = denom1 * denom2
        
        final_whole = result_num ÷ result_denom
        final_num = result_num % result_denom
        
        g = gcd(final_num, result_denom)
        final_num_simp = final_num ÷ g
        final_denom = result_denom ÷ g
        
        answer = final_num_simp == 0 ? "$final_whole" : "$(final_whole) $(final_num_simp)/$(final_denom)"
        
        problem(
            question="Multiply and simplify: \$$(whole1)\\frac{$(num1)}{$(denom1)} \\times $(whole2)\\frac{$(num2)}{$(denom2)}\$",
            answer=answer,
            difficulty=(1400, 1600),
            solution=steps(
                "Convert to improper fractions: \$\\frac{$(imp1)}{$(denom1)} \\times \\frac{$(imp2)}{$(denom2)}\$",
                "Multiply: \$\\frac{$(result_num)}{$(result_denom)}\$",
                "Simplify and convert: \$$(answer)\$"
            ),
            time=180
        )
        
    elseif prob_type == 4
        # Division of mixed numbers
        whole1 = randint(2, 7)
        whole2 = randint(1, 5)
        denom1 = choice([2, 3, 4, 5, 6])
        denom2 = choice([2, 3, 4, 5, 6])
        num1 = randint(1, denom1 - 1)
        num2 = randint(1, denom2 - 1)
        
        imp1 = whole1 * denom1 + num1
        imp2 = whole2 * denom2 + num2
        
        result_num = imp1 * denom2
        result_denom = denom1 * imp2
        
        final_whole = result_num ÷ result_denom
        final_num = result_num % result_denom
        
        g = gcd(final_num, result_denom)
        final_num_simp = final_num ÷ g
        final_denom = result_denom ÷ g
        
        answer = final_num_simp == 0 ? "$final_whole" : "$(final_whole) $(final_num_simp)/$(final_denom)"
        
        problem(
            question="Divide and simplify: \$$(whole1)\\frac{$(num1)}{$(denom1)} \\div $(whole2)\\frac{$(num2)}{$(denom2)}\$",
            answer=answer,
            difficulty=(1500, 1700),
            solution=steps(
                "Convert to improper fractions: \$\\frac{$(imp1)}{$(denom1)} \\div \\frac{$(imp2)}{$(denom2)}\$",
                "Multiply by reciprocal: \$\\frac{$(imp1)}{$(denom1)} \\times \\frac{$(denom2)}{$(imp2)}\$",
                "Multiply: \$\\frac{$(result_num)}{$(result_denom)}\$",
                "Simplify and convert: \$$(answer)\$"
            ),
            time=180
        )
        
    elseif prob_type == 5
        # Addition with unlike denominators
        whole1 = randint(1, 6)
        whole2 = randint(1, 6)
        denom1 = choice([3, 4, 6])
        denom2 = choice([2, 5, 8])
        num1 = randint(1, denom1 - 1)
        num2 = randint(1, denom2 - 1)
        
        lcd = lcm(denom1, denom2)
        new_num1 = num1 * (lcd ÷ denom1)
        new_num2 = num2 * (lcd ÷ denom2)
        
        sum_num = new_num1 + new_num2
        extra_wholes = sum_num ÷ lcd
        final_num = sum_num % lcd
        final_whole = whole1 + whole2 + extra_wholes
        
        g = gcd(final_num, lcd)
        final_num_simp = final_num ÷ g
        final_denom = lcd ÷ g
        
        answer = final_num_simp == 0 ? "$final_whole" : "$(final_whole) $(final_num_simp)/$(final_denom)"
        
        problem(
            question="Add and simplify: \$$(whole1)\\frac{$(num1)}{$(denom1)} + $(whole2)\\frac{$(num2)}{$(denom2)}\$",
            answer=answer,
            difficulty=(1400, 1600),
            solution=steps(
                "Find LCD of $(denom1) and $(denom2): LCD = $(lcd)",
                "Convert fractions: \$\\frac{$(num1)}{$(denom1)} = \\frac{$(new_num1)}{$(lcd)}\$ and \$\\frac{$(num2)}{$(denom2)} = \\frac{$(new_num2)}{$(lcd)}\$",
                "Add: \$$(whole1) + $(whole2) + \\frac{$(sum_num)}{$(lcd)}\$",
                "Simplify: \$$(answer)\$"
            ),
            time=180
        )
        
    else
        # Complex word problem with mixed numbers
        recipe_mult = choice([2, 3, 4])
        denom = choice([2, 3, 4])
        whole = randint(1, 3)
        num = randint(1, denom - 1)
        
        total_improper = recipe_mult * (whole * denom + num)
        total_whole = total_improper ÷ denom
        total_num = total_improper % denom
        
        g = gcd(total_num, denom)
        total_num_simp = total_num ÷ g
        total_denom = denom ÷ g
        
        answer = total_num_simp == 0 ? "$total_whole" : "$(total_whole) $(total_num_simp)/$(total_denom)"
        
        problem(
            question="A recipe calls for \$$(whole)\\frac{$(num)}{$(denom)}\$ cups of flour. If you want to make $(recipe_mult) batches of the recipe, how many cups of flour do you need?",
            answer=answer,
            difficulty=(1500, 1800),
            solution=steps(
                "Multiply the amount by number of batches: \$$(recipe_mult) \\times $(whole)\\frac{$(num)}{$(denom)}\$",
                "Convert to improper fraction: \$$(recipe_mult) \\times \\frac{$(whole * denom + num)}{$(denom)}\$",
                "Multiply: \$\\frac{$(total_improper)}{$(denom)}\$",
                "Convert and simplify: \$$(answer)\$ cups"
            ),
            time=200
        )
    end
end