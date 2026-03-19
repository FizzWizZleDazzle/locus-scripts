# arithmetic - multiplication (easy)
# Generated: 2026-03-08T19:46:27.786967

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/multiplication")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Two-digit by one-digit multiplication (700-900 ELO)
        a = randint(10, 99)
        b = randint(2, 9)
        ans = a * b
        problem(
            question="Calculate: \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                sol("Problem", "$(a) × $(b)"),
                "Break down: $(a) = $(div(a, 10) * 10) + $(a % 10)",
                "$(div(a, 10) * 10) × $(b) = $(div(a, 10) * 10 * b), and $(a % 10) × $(b) = $((a % 10) * b)",
                sol("Answer", ans)
            ),
            time=60
        )
    elseif problem_type == 2
        # Two-digit by two-digit multiplication (800-1000 ELO)
        a = randint(11, 49)
        b = randint(11, 49)
        ans = a * b
        problem(
            question="Calculate: \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Problem", "$(a) × $(b)"),
                "Use standard multiplication algorithm",
                "$(a) × $(b % 10) = $(a * (b % 10))",
                "$(a) × $(div(b, 10) * 10) = $(a * div(b, 10) * 10)",
                sol("Answer", ans)
            ),
            time=90
        )
    elseif problem_type == 3
        # Three-digit by one-digit multiplication (750-950 ELO)
        a = randint(100, 999)
        b = randint(2, 9)
        ans = a * b
        problem(
            question="Calculate: \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(750, 950),
            solution=steps(
                sol("Problem", "$(a) × $(b)"),
                "Multiply each digit by $(b) from right to left",
                "Apply carrying as needed",
                sol("Answer", ans)
            ),
            time=90
        )
    elseif problem_type == 4
        # Multiplication with a multiple of 10 (700-850 ELO)
        a = randint(12, 99)
        b = randint(2, 9) * 10
        ans = a * b
        problem(
            question="Calculate: \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                sol("Problem", "$(a) × $(b)"),
                "Notice that $(b) = $(div(b, 10)) × 10",
                "First: $(a) × $(div(b, 10)) = $(a * div(b, 10))",
                "Then multiply by 10: $(a * div(b, 10)) × 10 = $(ans)",
                sol("Answer", ans)
            ),
            time=75
        )
    else
        # Word problem with multiplication (900-1200 ELO)
        items_per_box = randint(12, 48)
        num_boxes = randint(5, 25)
        ans = items_per_box * num_boxes
        
        item_names = ["pencils", "markers", "erasers", "notebooks", "crayons", "pens"]
        item = choice(item_names)
        
        problem(
            question="A store has $(num_boxes) boxes of $(item). Each box contains $(items_per_box) $(item). How many $(item) does the store have in total?",
            answer=ans,
            difficulty=(900, 1200),
            solution=steps(
                "Identify the multiplication needed: number of boxes × items per box",
                sol("Calculation", "$(num_boxes) × $(items_per_box)"),
                "Perform the multiplication",
                sol("Answer", "$(ans) $(item)")
            ),
            time=120
        )
    end
end