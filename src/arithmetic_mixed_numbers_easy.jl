# arithmetic - mixed_numbers (easy)
# Generated: 2026-03-08T19:48:45.906106

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/mixed_numbers")
    
    problem_type = choice(["add", "subtract", "multiply", "divide", "simplify", "convert_to_improper", "convert_to_mixed"])
    
    if problem_type == "add"
        # Addition of two mixed numbers
        whole1 = randint(1, 8)
        num1 = randint(1, 12)
        denom1 = randint(num1 + 1, 15)
        
        whole2 = randint(1, 8)
        num2 = randint(1, 12)
        denom2 = denom1  # Same denominator for easier problems
        
        # Calculate answer
        total_whole = whole1 + whole2
        total_num = num1 + num2
        
        if total_num >= denom1
            total_whole += total_num ÷ denom1
            total_num = total_num % denom1
        end
        
        # Simplify the fraction part
        g = gcd(total_num, denom1)
        total_num = total_num ÷ g
        final_denom = denom1 ÷ g
        
        if total_num == 0
            answer = string(total_whole)
        else
            answer = string(total_whole, " ", total_num, "/", final_denom)
        end
        
        problem(
            question="Add and simplify: \$$(whole1)\\frac{$(num1)}{$(denom1)} + $(whole2)\\frac{$(num2)}{$(denom2)}\$",
            answer=answer,
            difficulty=(700, 900),
            solution=steps(
                "Convert to improper fractions: \$\\frac{$(whole1 * denom1 + num1)}{$(denom1)} + \\frac{$(whole2 * denom2 + num2)}{$(denom2)}\$",
                "Add the fractions: \$\\frac{$(whole1 * denom1 + num1 + whole2 * denom2 + num2)}{$(denom1)}\$",
                "Convert back to mixed number and simplify: \$$(answer)\$"
            ),
            time=90
        )
        
    elseif problem_type == "subtract"
        # Subtraction of mixed numbers (ensure first is larger)
        whole1 = randint(3, 10)
        num1 = randint(1, 10)
        denom1 = randint(num1 + 1, 12)
        
        whole2 = randint(1, whole1 - 1)
        num2 = randint(1, 10)
        denom2 = denom1
        
        # Calculate
        improper1 = whole1 * denom1 + num1
        improper2 = whole2 * denom2 + num2
        diff = improper1 - improper2
        
        result_whole = diff ÷ denom1
        result_num = diff % denom1
        
        g = gcd(result_num, denom1)
        result_num = result_num ÷ g
        final_denom = denom1 ÷ g
        
        if result_num == 0
            answer = string(result_whole)
        else
            answer = string(result_whole, " ", result_num, "/", final_denom)
        end
        
        problem(
            question="Subtract and simplify: \$$(whole1)\\frac{$(num1)}{$(denom1)} - $(whole2)\\frac{$(num2)}{$(denom2)}\$",
            answer=answer,
            difficulty=(800, 1000),
            solution=steps(
                "Convert to improper fractions: \$\\frac{$(improper1)}{$(denom1)} - \\frac{$(improper2)}{$(denom2)}\$",
                "Subtract: \$\\frac{$(diff)}{$(denom1)}\$",
                "Convert to mixed number and simplify: \$$(answer)\$"
            ),
            time=100
        )
        
    elseif problem_type == "multiply"
        # Multiplication of mixed numbers
        whole1 = randint(1, 5)
        num1 = randint(1, 8)
        denom1 = randint(num1 + 1, 10)
        
        whole2 = randint(1, 5)
        num2 = randint(1, 8)
        denom2 = randint(num2 + 1, 10)
        
        improper1 = whole1 * denom1 + num1
        improper2 = whole2 * denom2 + num2
        
        prod_num = improper1 * improper2
        prod_denom = denom1 * denom2
        
        result_whole = prod_num ÷ prod_denom
        result_num = prod_num % prod_denom
        
        g = gcd(result_num, prod_denom)
        result_num = result_num ÷ g
        final_denom = prod_denom ÷ g
        
        if result_num == 0
            answer = string(result_whole)
        else
            answer = string(result_whole, " ", result_num, "/", final_denom)
        end
        
        problem(
            question="Multiply and simplify: \$$(whole1)\\frac{$(num1)}{$(denom1)} \\times $(whole2)\\frac{$(num2)}{$(denom2)}\$",
            answer=answer,
            difficulty=(900, 1100),
            solution=steps(
                "Convert to improper fractions: \$\\frac{$(improper1)}{$(denom1)} \\times \\frac{$(improper2)}{$(denom2)}\$",
                "Multiply: \$\\frac{$(prod_num)}{$(prod_denom)}\$",
                "Convert to mixed number and simplify: \$$(answer)\$"
            ),
            time=120
        )
        
    elseif problem_type == "divide"
        # Division of mixed numbers
        whole1 = randint(2, 6)
        num1 = randint(1, 7)
        denom1 = randint(num1 + 1, 10)
        
        whole2 = randint(1, 4)
        num2 = randint(1, 6)
        denom2 = randint(num2 + 1, 8)
        
        improper1 = whole1 * denom1 + num1
        improper2 = whole2 * denom2 + num2
        
        quot_num = improper1 * denom2
        quot_denom = denom1 * improper2
        
        result_whole = quot_num ÷ quot_denom
        result_num = quot_num % quot_denom
        
        g = gcd(result_num, quot_denom)
        result_num = result_num ÷ g
        final_denom = quot_denom ÷ g
        
        if result_num == 0
            answer = string(result_whole)
        else
            answer = string(result_whole, " ", result_num, "/", final_denom)
        end
        
        problem(
            question="Divide and simplify: \$$(whole1)\\frac{$(num1)}{$(denom1)} \\div $(whole2)\\frac{$(num2)}{$(denom2)}\$",
            answer=answer,
            difficulty=(1000, 1200),
            solution=steps(
                "Convert to improper fractions: \$\\frac{$(improper1)}{$(denom1)} \\div \\frac{$(improper2)}{$(denom2)}\$",
                "Multiply by reciprocal: \$\\frac{$(improper1)}{$(denom1)} \\times \\frac{$(denom2)}{$(improper2)} = \\frac{$(quot_num)}{$(quot_denom)}\$",
                "Convert to mixed number and simplify: \$$(answer)\$"
            ),
            time=120
        )
        
    elseif problem_type == "convert_to_improper"
        # Convert mixed number to improper fraction
        whole = randint(2, 12)
        num = randint(1, 15)
        denom = randint(num + 1, 20)
        
        improper = whole * denom + num
        g = gcd(improper, denom)
        improper = improper ÷ g
        final_denom = denom ÷ g
        
        answer = string(improper, "/", final_denom)
        
        problem(
            question="Convert to an improper fraction: \$$(whole)\\frac{$(num)}{$(denom)}\$",
            answer=answer,
            difficulty=(700, 850),
            solution=steps(
                "Multiply whole number by denominator: \$$(whole) \\times $(denom) = $(whole * denom)\$",
                "Add the numerator: \$$(whole * denom) + $(num) = $(whole * denom + num)\$",
                "Simplify: \$\\frac{$(improper)}{$(final_denom)}\$"
            ),
            time=60
        )
        
    else  # convert_to_mixed
        # Convert improper fraction to mixed number
        num = randint(25, 100)
        denom = randint(3, 15)
        while num <= denom
            num = randint(25, 100)
        end
        
        whole = num ÷ denom
        remainder = num % denom
        
        g = gcd(remainder, denom)
        remainder = remainder ÷ g
        final_denom = denom ÷ g
        
        if remainder == 0
            answer = string(whole)
        else
            answer = string(whole, " ", remainder, "/", final_denom)
        end
        
        problem(
            question="Convert to a mixed number: \$\\frac{$(num)}{$(denom)}\$",
            answer=answer,
            difficulty=(700, 850),
            solution=steps(
                "Divide numerator by denominator: \$$(num) \\div $(denom) = $(whole)\$ R \$$(num % denom)\$",
                "Write as mixed number: \$$(whole)\\frac{$(num % denom)}{$(denom)}\$",
                "Simplify: \$$(answer)\$"
            ),
            time=60
        )
    end
end