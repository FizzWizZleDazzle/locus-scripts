# arithmetic - order_of_operations (medium)
# Generated: 2026-03-08T19:51:05.864097

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("arithmetic/order_of_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Multi-step with parentheses, exponents, and multiple operations
        # (a + b)^2 - c * d + e
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 6)
        d = randint(3, 9)
        e = randint(5, 20)
        
        step1_val = a + b
        step2_val = step1_val^2
        step3_val = c * d
        step4_val = step2_val - step3_val
        ans = step4_val + e
        
        question_str = "Evaluate: \$($a + $b)^2 - $c \\times $d + $e\$"
        
        solution_text = steps(
            "Step 1: Parentheses first: \$$a + $b = $step1_val\$",
            "Step 2: Exponent: \$$(step1_val)^2 = $step2_val\$",
            "Step 3: Multiplication: \$$c \\times $d = $step3_val\$",
            "Step 4: Left to right: \$$step2_val - $step3_val + $e = $step4_val + $e = $ans\$"
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(1200, 1400),
            solution=solution_text,
            time=120
        )
        
    elseif problem_type == 2
        # Nested parentheses with division
        # a * (b + c * (d - e)) / f
        a = randint(2, 5)
        b = randint(4, 12)
        c = randint(2, 6)
        d = randint(10, 20)
        e = randint(3, 9)
        
        # Ensure division works cleanly
        inner = d - e
        middle = b + c * inner
        numerator = a * middle
        
        # Pick f to divide evenly
        divisors = [i for i in 2:10 if numerator % i == 0]
        f = length(divisors) > 0 ? choice(divisors) : 1
        ans = div(numerator, f)
        
        question_str = "Evaluate: \$$a \\times ($b + $c \\times ($d - $e)) \\div $f\$"
        
        solution_text = steps(
            "Step 1: Innermost parentheses: \$$d - $e = $inner\$",
            "Step 2: Multiplication inside parentheses: \$$c \\times $inner = $(c * inner)\$",
            "Step 3: Addition inside parentheses: \$$b + $(c * inner) = $middle\$",
            "Step 4: Multiplication: \$$a \\times $middle = $numerator\$",
            "Step 5: Division: \$$numerator \\div $f = $ans\$"
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(1400, 1600),
            solution=solution_text,
            time=150
        )
        
    elseif problem_type == 3
        # Mixed operations with exponents
        # a^2 + b * c - (d + e)^2 / f
        a = randint(3, 9)
        b = randint(2, 7)
        c = randint(3, 8)
        d = randint(2, 6)
        e = randint(2, 6)
        
        step1 = a^2
        step2 = b * c
        step3 = d + e
        step4 = step3^2
        
        # Ensure division works
        divisors = [i for i in 2:10 if step4 % i == 0]
        f = length(divisors) > 0 ? choice(divisors) : 1
        step5 = div(step4, f)
        ans = step1 + step2 - step5
        
        question_str = "Evaluate: \$$a^2 + $b \\times $c - ($d + $e)^2 \\div $f\$"
        
        solution_text = steps(
            "Step 1: Exponent: \$$a^2 = $step1\$",
            "Step 2: Parentheses: \$$d + $e = $step3\$",
            "Step 3: Exponent: \$$(step3)^2 = $step4\$",
            "Step 4: Multiplication: \$$b \\times $c = $step2\$",
            "Step 5: Division: \$$step4 \\div $f = $step5\$",
            "Step 6: Left to right: \$$step1 + $step2 - $step5 = $ans\$"
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(1500, 1700),
            solution=solution_text,
            time=180
        )
        
    elseif problem_type == 4
        # Complex expression with multiple groupings
        # (a * b + c) * d - (e^2 - f * g)
        a = randint(2, 6)
        b = randint(3, 7)
        c = randint(4, 12)
        d = randint(2, 5)
        e = randint(3, 7)
        f = randint(2, 6)
        g = randint(3, 8)
        
        step1 = a * b
        step2 = step1 + c
        step3 = step2 * d
        step4 = e^2
        step5 = f * g
        step6 = step4 - step5
        ans = step3 - step6
        
        question_str = "Evaluate: \$($a \\times $b + $c) \\times $d - ($e^2 - $f \\times $g)\$"
        
        solution_text = steps(
            "Step 1: First parentheses, multiply: \$$a \\times $b = $step1\$",
            "Step 2: First parentheses, add: \$$step1 + $c = $step2\$",
            "Step 3: Multiply result: \$$step2 \\times $d = $step3\$",
            "Step 4: Second parentheses, exponent: \$$e^2 = $step4\$",
            "Step 5: Second parentheses, multiply: \$$f \\times $g = $step5\$",
            "Step 6: Second parentheses, subtract: \$$step4 - $step5 = $step6\$",
            "Step 7: Final subtraction: \$$step3 - $step6 = $ans\$"
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(1600, 1800),
            solution=solution_text,
            time=180
        )
        
    else
        # Triple nested with multiple operations
        # a + b * (c - (d + e * f) / g)
        a = randint(5, 15)
        e = randint(2, 5)
        f = randint(2, 6)
        d = randint(3, 10)
        
        product = e * f
        inner_sum = d + product
        
        # Ensure division works
        divisors = [i for i in 2:8 if inner_sum % i == 0]
        g = length(divisors) > 0 ? choice(divisors) : 1
        quotient = div(inner_sum, g)
        
        c = randint(quotient + 5, quotient + 20)
        difference = c - quotient
        
        b = randint(2, 6)
        product2 = b * difference
        ans = a + product2
        
        question_str = "Evaluate: \$$a + $b \\times ($c - ($d + $e \\times $f) \\div $g)\$"
        
        solution_text = steps(
            "Step 1: Innermost operation: \$$e \\times $f = $product\$",
            "Step 2: Innermost parentheses: \$$d + $product = $inner_sum\$",
            "Step 3: Division: \$$inner_sum \\div $g = $quotient\$",
            "Step 4: Middle parentheses: \$$c - $quotient = $difference\$",
            "Step 5: Multiplication: \$$b \\times $difference = $product2\$",
            "Step 6: Final addition: \$$a + $product2 = $ans\$"
        )
        
        problem(
            question=question_str,
            answer=ans,
            difficulty=(1500, 1750),
            solution=solution_text,
            time=200
        )
    end
end