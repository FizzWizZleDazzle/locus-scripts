# arithmetic - order_of_operations (hard)
# Generated: 2026-03-08T19:51:07.068187

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("arithmetic/order_of_operations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Complex nested expression with exponents and multiple operations
        a = randint(2, 5)
        b = randint(2, 4)
        c = randint(3, 7)
        d = randint(2, 6)
        e = randint(10, 25)
        f = randint(2, 8)
        
        ans = a^b * (c + d) - e * f
        expr_str = "$(a)^{$(b)} \\cdot ($(c) + $(d)) - $(e) \\cdot $(f)"
        
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "First evaluate the exponent: \$$(a)^{$(b)} = $(a^b)\$",
                "Evaluate parentheses: \$($(c) + $(d)) = $(c + d)\$",
                "Perform multiplications: \$$(a^b) \\cdot $(c + d) = $(a^b * (c + d))\$ and \$$(e) \\cdot $(f) = $(e * f)\$",
                "Subtract: \$$(a^b * (c + d)) - $(e * f) = $(ans)\$"
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Fraction with nested operations and exponents
        a = randint(2, 4)
        b = randint(2, 3)
        c = randint(5, 12)
        d = randint(2, 8)
        e = randint(2, 5)
        f = randint(1, 4)
        
        numerator = a^b + c * d
        denominator = e^f
        ans = numerator // denominator
        
        expr_str = "\\frac{$(a)^{$(b)} + $(c) \\cdot $(d)}{$(e)^{$(f)}}"
        
        problem(
            question="Evaluate and simplify: \$$(expr_str)\$",
            answer=ans,
            difficulty=(1850, 2050),
            solution=steps(
                "Evaluate numerator exponent: \$$(a)^{$(b)} = $(a^b)\$",
                "Multiply in numerator: \$$(c) \\cdot $(d) = $(c * d)\$",
                "Add numerator: \$$(a^b) + $(c * d) = $(numerator)\$",
                "Evaluate denominator: \$$(e)^{$(f)} = $(denominator)\$",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Multiple nested parentheses with exponents
        a = randint(2, 4)
        b = randint(3, 8)
        c = randint(2, 5)
        d = randint(4, 9)
        e = randint(2, 6)
        f = randint(2, 3)
        
        ans = (a * (b - c) + d)^f - e
        expr_str = "\\left($(a) \\cdot ($(b) - $(c)) + $(d)\\right)^{$(f)} - $(e)"
        
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Innermost parentheses: \$($(b) - $(c)) = $(b - c)\$",
                "Multiply: \$$(a) \\cdot $(b - c) = $(a * (b - c))\$",
                "Add inside brackets: \$$(a * (b - c)) + $(d) = $(a * (b - c) + d)\$",
                "Apply exponent: \$($(a * (b - c) + d))^{$(f)} = $((a * (b - c) + d)^f)\$",
                "Subtract: \$$(( a * (b - c) + d)^f) - $(e) = $(ans)\$"
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Complex expression with division and multiple operations
        a = randint(3, 8)
        b = randint(2, 5)
        c = randint(6, 15)
        d = randint(2, 4)
        e = randint(3, 9)
        f = randint(2, 6)
        g = randint(10, 30)
        
        ans = a * b^d + c ÷ e - f * g
        expr_str = "$(a) \\cdot $(b)^{$(d)} + $(c) \\div $(e) - $(f) \\cdot $(g)"
        
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "Evaluate exponent: \$$(b)^{$(d)} = $(b^d)\$",
                "Perform multiplications and division left to right: \$$(a) \\cdot $(b^d) = $(a * b^d)\$, \$$(c) \\div $(e) = $(c ÷ e)\$, \$$(f) \\cdot $(g) = $(f * g)\$",
                "Add and subtract left to right: \$$(a * b^d) + $(c ÷ e) = $(a * b^d + c ÷ e)\$",
                "Final subtraction: \$$(a * b^d + c ÷ e) - $(f * g) = $(ans)\$"
            ),
            time=150
        )
        
    elseif problem_type == 5
        # Triple nested expression with exponents
        a = randint(2, 4)
        b = randint(2, 3)
        c = randint(5, 12)
        d = randint(2, 7)
        e = randint(3, 8)
        f = randint(2, 5)
        g = randint(1, 3)
        
        ans = a^b * ((c - d) * e + f^g)
        expr_str = "$(a)^{$(b)} \\cdot \\left(($(c) - $(d)) \\cdot $(e) + $(f)^{$(g)}\\right)"
        
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(2100, 2300),
            solution=steps(
                "Evaluate exponents: \$$(a)^{$(b)} = $(a^b)\$ and \$$(f)^{$(g)} = $(f^g)\$",
                "Innermost parentheses: \$($(c) - $(d)) = $(c - d)\$",
                "Multiply: \$($(c - d)) \\cdot $(e) = $((c - d) * e)\$",
                "Add inside brackets: \$$(( c - d) * e) + $(f^g) = $((c - d) * e + f^g)\$",
                "Final multiplication: \$$(a^b) \\cdot $((c - d) * e + f^g) = $(ans)\$"
            ),
            time=180
        )
        
    else
        # Advanced: Expression with fraction bar acting as grouping
        a = randint(2, 5)
        b = randint(3, 8)
        c = randint(2, 6)
        d = randint(4, 10)
        e = randint(2, 4)
        f = randint(3, 7)
        g = randint(2, 3)
        
        numerator = a * b^g - c * d
        denominator = e + f
        ans = numerator // denominator
        
        expr_str = "\\frac{$(a) \\cdot $(b)^{$(g)} - $(c) \\cdot $(d)}{$(e) + $(f)}"
        
        problem(
            question="Evaluate and simplify: \$$(expr_str)\$",
            answer=ans,
            difficulty=(2200, 2400),
            solution=steps(
                "Evaluate exponent in numerator: \$$(b)^{$(g)} = $(b^g)\$",
                "Perform multiplications in numerator: \$$(a) \\cdot $(b^g) = $(a * b^g)\$ and \$$(c) \\cdot $(d) = $(c * d)\$",
                "Subtract in numerator: \$$(a * b^g) - $(c * d) = $(numerator)\$",
                "Add in denominator: \$$(e) + $(f) = $(denominator)\$",
                "Divide: \$\\frac{$(numerator)}{$(denominator)} = $(ans)\$"
            ),
            time=180
        )
    end
end