# arithmetic - decimals (easy)
# Generated: 2026-03-08T19:49:16.958641

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/decimals")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Addition of decimals (700-900 ELO)
        a = round(rand() * 100, digits=2)
        b = round(rand() * 100, digits=2)
        ans = round(a + b, digits=2)
        
        problem(
            question="Calculate: \$$(a) + $(b)\$",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Align the decimal points:",
                "\$$(a) + $(b)\$",
                "Add column by column from right to left",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Subtraction of decimals (700-900 ELO)
        a = round(rand() * 100 + 20, digits=2)
        b = round(rand() * a, digits=2)
        ans = round(a - b, digits=2)
        
        problem(
            question="Calculate: \$$(a) - $(b)\$",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Align the decimal points:",
                "\$$(a) - $(b)\$",
                "Subtract column by column from right to left",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Multiplication of decimals (800-1000 ELO)
        a = round(rand() * 20 + 1, digits=1)
        b = round(rand() * 10 + 1, digits=1)
        ans = round(a * b, digits=2)
        
        problem(
            question="Calculate: \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Multiply as whole numbers: \$$(a) \\times $(b)\$",
                "Count total decimal places in both factors",
                "Place decimal point in the product",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Division of decimals (900-1100 ELO)
        divisor = round(rand() * 8 + 2, digits=1)
        quotient = round(rand() * 15 + 5, digits=1)
        dividend = round(divisor * quotient, digits=2)
        ans = round(dividend / divisor, digits=2)
        
        problem(
            question="Calculate: \$$(dividend) \\div $(divisor)\$",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Set up division: \$$(dividend) \\div $(divisor)\$",
                "Move decimal point in divisor to make it a whole number",
                "Move decimal point same number of places in dividend",
                "Divide and place decimal point",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 5
        # Multi-step with decimals (1000-1200 ELO)
        a = round(rand() * 15 + 5, digits=1)
        b = round(rand() * 10 + 2, digits=1)
        c = round(rand() * 8 + 1, digits=1)
        ans = round(a * b - c, digits=2)
        
        problem(
            question="Calculate: \$$(a) \\times $(b) - $(c)\$",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                "Follow order of operations (multiply first)",
                sol("Multiply", a * b),
                "Then subtract \$$(c)\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Decimal and fraction conversion (900-1100 ELO)
        numerator = randint(1, 20)
        denominator = choice([2, 4, 5, 8, 10, 20, 25])
        ans = round(numerator / denominator, digits=4)
        
        problem(
            question="Convert the fraction \$\\frac{$(numerator)}{$(denominator)}\$ to a decimal.",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given fraction", "\\frac{$(numerator)}{$(denominator)}"),
                "Divide numerator by denominator",
                sol("\$$(numerator) \\div $(denominator)\$", ""),
                sol("Answer", ans)
            ),
            time=90
        )
    end
end