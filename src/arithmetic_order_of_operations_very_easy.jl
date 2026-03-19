# arithmetic - order_of_operations (very_easy)
# Generated: 2026-03-08T19:50:36.473636

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/order_of_operations")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # Simple two-operation: addition and multiplication
        # ELO: 300-500
        a = randint(2, 9)
        b = randint(2, 9)
        c = randint(1, 9)
        ans = a * b + c
        
        problem(
            question="Calculate: \$$(a) \\times $(b) + $(c)\$",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "Apply order of operations (PEMDAS/BODMAS)",
                sol("Multiply first", "$(a) \\times $(b) = $(a*b)"),
                sol("Then add", "$(a*b) + $(c) = $(ans)")
            ),
            time=45
        )
        
    elseif prob_type == 2
        # Two operations with parentheses
        # ELO: 400-600
        a = randint(2, 12)
        b = randint(1, 10)
        c = randint(2, 8)
        ans = (a + b) * c
        
        problem(
            question="Calculate: \$($(a) + $(b)) \\times $(c)\$",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Parentheses first (PEMDAS)",
                sol("Inside parentheses", "$(a) + $(b) = $(a+b)"),
                sol("Then multiply", "$(a+b) \\times $(c) = $(ans)")
            ),
            time=50
        )
        
    elseif prob_type == 3
        # Three operations: subtraction, multiplication, addition
        # ELO: 500-700
        a = randint(10, 25)
        b = randint(2, 6)
        c = randint(2, 8)
        d = randint(3, 12)
        ans = a - b * c + d
        
        problem(
            question="Calculate: \$$(a) - $(b) \\times $(c) + $(d)\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Apply order of operations: multiplication before addition/subtraction",
                sol("Multiply first", "$(b) \\times $(c) = $(b*c)"),
                sol("Then subtract and add left to right", "$(a) - $(b*c) + $(d) = $(ans)")
            ),
            time=60
        )
        
    elseif prob_type == 4
        # Division and addition
        # ELO: 450-650
        a = randint(3, 8)
        b = randint(2, 6)
        c = randint(4, 15)
        product = a * b
        ans = product ÷ a + c
        
        problem(
            question="Calculate: \$$(product) \\div $(a) + $(c)\$",
            answer=ans,
            difficulty=(450, 650),
            solution=steps(
                "Division comes before addition",
                sol("Divide first", "$(product) \\div $(a) = $(product ÷ a)"),
                sol("Then add", "$(product ÷ a) + $(c) = $(ans)")
            ),
            time=55
        )
        
    else
        # Mixed operations with parentheses
        # ELO: 550-700
        a = randint(5, 15)
        b = randint(2, 8)
        c = randint(1, 6)
        d = randint(2, 9)
        ans = a + b * (c + d)
        
        problem(
            question="Calculate: \$$(a) + $(b) \\times ($(c) + $(d))\$",
            answer=ans,
            difficulty=(550, 700),
            solution=steps(
                "Parentheses first, then multiplication, then addition",
                sol("Inside parentheses", "$(c) + $(d) = $(c+d)"),
                sol("Then multiply", "$(b) \\times $(c+d) = $(b*(c+d))"),
                sol("Finally add", "$(a) + $(b*(c+d)) = $(ans)")
            ),
            time=70
        )
    end
end