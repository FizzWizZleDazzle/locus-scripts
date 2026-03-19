# algebra2 - rational_expressions (very_easy)
# Generated: 2026-03-08T20:15:17.021657

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_expressions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simplify a simple rational expression (200-400 ELO)
        a = nonzero(-12, 12)
        b = nonzero(-12, 12)
        c = nonzero(2, 8)
        numerator = c * a
        denominator = c * b
        simplified_num = a
        simplified_den = b
        
        problem(
            question="Simplify: \$\\frac{$(numerator)}{$(denominator)}\$",
            answer=simplified_num // simplified_den,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", numerator // denominator),
                "Factor out the common factor $(c) from numerator and denominator",
                sol("Simplified form", simplified_num // simplified_den)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Simplify (x+a)/(x+a) type expression (300-500 ELO)
        a = nonzero(-15, 15)
        numerator = x + a
        denominator = x + a
        
        problem(
            question="Simplify: \$\\frac{$(tex(numerator))}{$(tex(denominator))}\$",
            answer=1,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", numerator / denominator),
                "The numerator and denominator are identical",
                sol("Answer", 1)
            ),
            time=30
        )
        
    elseif problem_type == 3
        # Evaluate a rational expression at a specific value (400-600 ELO)
        a = nonzero(-10, 10)
        b = nonzero(-10, 10)
        x_val = nonzero(-8, 8)
        # Make sure denominator is not zero
        while a * x_val + b == 0
            x_val = nonzero(-8, 8)
        end
        
        numerator = x + a
        denominator = a * x + b
        num_value = x_val + a
        den_value = a * x_val + b
        answer = num_value // den_value
        
        problem(
            question="Evaluate \$\\frac{$(tex(numerator))}{$(tex(denominator))}\$ when \$x = $(x_val)\$",
            answer=answer,
            difficulty=(400, 600),
            solution=steps(
                sol("Given expression", numerator / denominator),
                "Substitute \$x = $(x_val)\$: \$\\frac{$(num_value)}{$(den_value)}\$",
                sol("Answer", answer)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Multiply two simple rational expressions (500-700 ELO)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        frac1_num = a
        frac1_den = b
        frac2_num = c
        frac2_den = d
        
        result_num = a * c
        result_den = b * d
        
        # Find GCD to simplify
        g = gcd(abs(result_num), abs(result_den))
        simplified_num = result_num ÷ g
        simplified_den = result_den ÷ g
        
        problem(
            question="Multiply and simplify: \$\\frac{$(frac1_num)}{$(frac1_den)} \\cdot \\frac{$(frac2_num)}{$(frac2_den)}\$",
            answer=simplified_num // simplified_den,
            difficulty=(500, 700),
            solution=steps(
                "Multiply numerators and denominators: \$\\frac{$(result_num)}{$(result_den)}\$",
                g > 1 ? "Simplify by dividing by GCD $(g)" : "Expression is already simplified",
                sol("Answer", simplified_num // simplified_den)
            ),
            time=75
        )
        
    else
        # Add two rational expressions with same denominator (600-700 ELO)
        denom = nonzero(-10, 10)
        num1 = nonzero(-12, 12)
        num2 = nonzero(-12, 12)
        
        result_num = num1 + num2
        result_den = denom
        
        # Simplify
        g = gcd(abs(result_num), abs(result_den))
        simplified_num = result_num ÷ g
        simplified_den = result_den ÷ g
        
        problem(
            question="Add and simplify: \$\\frac{$(num1)}{$(denom)} + \\frac{$(num2)}{$(denom)}\$",
            answer=simplified_num // simplified_den,
            difficulty=(600, 700),
            solution=steps(
                "Since denominators are the same, add numerators: \$\\frac{$(result_num)}{$(result_den)}\$",
                g > 1 ? "Simplify by dividing by GCD $(g)" : "Expression is already simplified",
                sol("Answer", simplified_num // simplified_den)
            ),
            time=60
        )
    end
end