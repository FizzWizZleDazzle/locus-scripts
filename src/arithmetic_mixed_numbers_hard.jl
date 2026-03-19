# arithmetic - mixed_numbers (hard)
# Generated: 2026-03-08T19:48:56.981663

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/mixed_numbers")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Complex multiplication with large mixed numbers
        whole1 = randint(8, 25)
        num1 = randint(1, 19)
        den1 = randint(num1 + 1, 24)
        
        whole2 = randint(7, 20)
        num2 = randint(1, 17)
        den2 = randint(num2 + 1, 22)
        
        # Convert to improper fractions
        imp1 = whole1 + num1 // den1
        imp2 = whole2 + num2 // den2
        
        product = imp1 * imp2
        
        ans_whole = floor(Int, product)
        ans_num = numerator(product - ans_whole)
        ans_den = denominator(product - ans_whole)
        
        if ans_num == 0
            answer = string(ans_whole)
        else
            answer = "$(ans_whole) $(ans_num)/$(ans_den)"
        end
        
        problem(
            question="Calculate: \\($(whole1)\\frac{$(num1)}{$(den1)} \\times $(whole2)\\frac{$(num2)}{$(den2)}\\). Express your answer as a mixed number in lowest terms.",
            answer=answer,
            difficulty=(1850, 2100),
            solution=steps(
                "Convert to improper fractions: \\(\\frac{$(whole1 * den1 + num1)}{$(den1)} \\times \\frac{$(whole2 * den2 + num2)}{$(den2)}\\)",
                "Multiply numerators and denominators: \\(\\frac{$((whole1 * den1 + num1) * (whole2 * den2 + num2))}{$(den1 * den2)}\\)",
                "Simplify and convert to mixed number",
                "Answer: \\($(ans_whole)\\frac{$(ans_num)}{$(ans_den)}\\)"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Complex division with strategic cancellation
        whole1 = randint(10, 30)
        num1 = randint(2, 15)
        den1 = randint(num1 + 2, 20)
        
        whole2 = randint(3, 12)
        num2 = randint(1, 11)
        den2 = randint(num2 + 1, 16)
        
        imp1 = whole1 + num1 // den1
        imp2 = whole2 + num2 // den2
        
        quotient = imp1 / imp2
        
        ans_whole = floor(Int, quotient)
        ans_num = numerator(quotient - ans_whole)
        ans_den = denominator(quotient - ans_whole)
        
        if ans_num == 0
            answer = string(ans_whole)
        else
            answer = "$(ans_whole) $(ans_num)/$(ans_den)"
        end
        
        problem(
            question="Calculate: \\($(whole1)\\frac{$(num1)}{$(den1)} \\div $(whole2)\\frac{$(num2)}{$(den2)}\\). Express your answer as a mixed number in lowest terms.",
            answer=answer,
            difficulty=(1900, 2200),
            solution=steps(
                "Convert to improper fractions: \\(\\frac{$(whole1 * den1 + num1)}{$(den1)} \\div \\frac{$(whole2 * den2 + num2)}{$(den2)}\\)",
                "Multiply by reciprocal: \\(\\frac{$(whole1 * den1 + num1)}{$(den1)} \\times \\frac{$(den2)}{$(whole2 * den2 + num2)}\\)",
                "Simplify and convert to mixed number",
                "Answer: \\($(ans_whole)\\frac{$(ans_num)}{$(ans_den)}\\)"
            ),
            time=200
        )
        
    elseif problem_type == 3
        # Chain operations requiring multiple conversions
        whole1 = randint(5, 18)
        num1 = randint(1, 13)
        den1 = randint(num1 + 1, 16)
        
        whole2 = randint(4, 15)
        num2 = randint(1, 11)
        den2 = randint(num2 + 1, 14)
        
        whole3 = randint(3, 12)
        num3 = randint(1, 9)
        den3 = randint(num3 + 1, 12)
        
        imp1 = whole1 + num1 // den1
        imp2 = whole2 + num2 // den2
        imp3 = whole3 + num3 // den3
        
        result = (imp1 * imp2) - imp3
        
        ans_whole = floor(Int, result)
        ans_num = numerator(result - ans_whole)
        ans_den = denominator(result - ans_whole)
        
        if ans_num == 0
            answer = string(ans_whole)
        else
            answer = "$(ans_whole) $(ans_num)/$(ans_den)"
        end
        
        problem(
            question="Evaluate: \\($(whole1)\\frac{$(num1)}{$(den1)} \\times $(whole2)\\frac{$(num2)}{$(den2)} - $(whole3)\\frac{$(num3)}{$(den3)}\\). Express your answer as a mixed number in lowest terms.",
            answer=answer,
            difficulty=(2000, 2300),
            solution=steps(
                "Convert all to improper fractions",
                "First multiply: \\(\\frac{$(whole1 * den1 + num1)}{$(den1)} \\times \\frac{$(whole2 * den2 + num2)}{$(den2)}\\)",
                "Then subtract \\(\\frac{$(whole3 * den3 + num3)}{$(den3)}\\) using common denominators",
                "Simplify and convert to mixed number",
                "Answer: \\($(ans_whole)\\frac{$(ans_num)}{$(ans_den)}\\)"
            ),
            time=240
        )
        
    else
        # Complex word problem with mixed numbers
        rate_whole = randint(12, 28)
        rate_num = randint(1, 7)
        rate_den = choice([2, 4, 8])
        
        time_whole = randint(3, 9)
        time_num = randint(1, 5)
        time_den = choice([2, 4, 6])
        
        rate = rate_whole + rate_num // rate_den
        time_val = time_whole + time_num // time_den
        
        distance = rate * time_val
        
        ans_whole = floor(Int, distance)
        ans_num = numerator(distance - ans_whole)
        ans_den = denominator(distance - ans_whole)
        
        if ans_num == 0
            answer = string(ans_whole)
        else
            answer = "$(ans_whole) $(ans_num)/$(ans_den)"
        end
        
        problem(
            question="A cyclist travels at a constant speed of \\($(rate_whole)\\frac{$(rate_num)}{$(rate_den)}\\) miles per hour for \\($(time_whole)\\frac{$(time_num)}{$(time_den)}\\) hours. How many miles does the cyclist travel? Express your answer as a mixed number in lowest terms.",
            answer=answer,
            difficulty=(1850, 2150),
            solution=steps(
                "Use distance = rate × time",
                "Convert to improper fractions: \\(\\frac{$(rate_whole * rate_den + rate_num)}{$(rate_den)} \\times \\frac{$(time_whole * time_den + time_num)}{$(time_den)}\\)",
                "Multiply: \\(\\frac{$((rate_whole * rate_den + rate_num) * (time_whole * time_den + time_num))}{$(rate_den * time_den)}\\)",
                "Simplify and convert to mixed number",
                "Answer: \\($(ans_whole)\\frac{$(ans_num)}{$(ans_den)}\\) miles"
            ),
            time=210
        )
    end
end