# arithmetic - order_of_operations (easy)
# Generated: 2026-03-08T19:50:43.616964

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/order_of_operations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Simple: a + b × c (700-850 ELO)
        a = randint(2, 15)
        b = randint(2, 12)
        c = randint(2, 9)
        expr_str = "$(a) + $(b) \\times $(c)"
        ans = a + b * c
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                "Given: \$$(expr_str)\$",
                "Multiplication before addition: \$$(a) + $(b * c)\$",
                sol("Answer", ans)
            ),
            time=45
        )
    elseif problem_type == 2
        # Parentheses: (a + b) × c - d (800-950 ELO)
        a = randint(3, 18)
        b = randint(2, 15)
        c = randint(2, 8)
        d = randint(5, 20)
        expr_str = "($(a) + $(b)) \\times $(c) - $(d)"
        ans = (a + b) * c - d
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(800, 950),
            solution=steps(
                "Given: \$$(expr_str)\$",
                "Parentheses first: \$($(a + b)) \\times $(c) - $(d)\$",
                "Multiplication: \$$(((a + b) * c)) - $(d)\$",
                sol("Answer", ans)
            ),
            time=60
        )
    elseif problem_type == 3
        # Division and subtraction: a - b ÷ c + d (850-1000 ELO)
        c = choice([2, 3, 4, 5, 6])
        b = c * randint(3, 15)
        a = randint(10, 40)
        d = randint(5, 25)
        expr_str = "$(a) - $(b) \\div $(c) + $(d)"
        ans = a - div(b, c) + d
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(850, 1000),
            solution=steps(
                "Given: \$$(expr_str)\$",
                "Division first: \$$(a) - $(div(b, c)) + $(d)\$",
                "Left to right: \$$(a - div(b, c)) + $(d)\$",
                sol("Answer", ans)
            ),
            time=75
        )
    else
        # Complex: a × (b + c) - d ÷ e + f (950-1200 ELO)
        a = randint(2, 9)
        b = randint(3, 15)
        c = randint(4, 18)
        e = choice([2, 3, 4, 5])
        d = e * randint(4, 12)
        f = randint(5, 30)
        expr_str = "$(a) \\times ($(b) + $(c)) - $(d) \\div $(e) + $(f)"
        ans = a * (b + c) - div(d, e) + f
        problem(
            question="Evaluate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(950, 1200),
            solution=steps(
                "Given: \$$(expr_str)\$",
                "Parentheses first: \$$(a) \\times $(b + c) - $(d) \\div $(e) + $(f)\$",
                "Multiplication and division: \$$(a * (b + c)) - $(div(d, e)) + $(f)\$",
                "Left to right: \$$(a * (b + c) - div(d, e)) + $(f)\$",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end