# arithmetic - subtraction (easy)
# Generated: 2026-03-08T19:45:58.383006

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("arithmetic/subtraction")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Basic multi-digit subtraction (700-850 ELO)
        a = randint(100, 999)
        b = randint(50, a - 1)
        ans = a - b
        
        problem(
            question="Calculate: \$$(a) - $(b)\$",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                "Set up the subtraction: \$$(a) - $(b)\$",
                "Subtract digit by digit from right to left, borrowing when needed",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Subtraction with borrowing across zeros (800-950 ELO)
        a = randint(1000, 9000)
        b = randint(100, a - 1)
        ans = a - b
        
        problem(
            question="Calculate: \$$(a) - $(b)\$",
            answer=ans,
            difficulty=(800, 950),
            solution=steps(
                "Set up the subtraction: \$$(a) - $(b)\$",
                "Borrow across zeros when necessary",
                sol("Answer", ans)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Word problem with subtraction (900-1100 ELO)
        initial = randint(500, 2000)
        spent = randint(100, initial - 50)
        ans = initial - spent
        
        contexts = [
            ("dollars in savings", "spent on a laptop"),
            ("students at a school", "graduated this year"),
            ("books in a library", "were checked out"),
            ("apples in an orchard", "were picked"),
            ("gallons of water in a tank", "were used")
        ]
        
        ctx = choice(contexts)
        
        problem(
            question="A store had $(initial) $(ctx[1]). If $(spent) $(ctx[2]), how many remain?",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Initial amount: \$$(initial)\$",
                "Amount removed: \$$(spent)\$",
                sol("Remaining", "$(initial) - $(spent) = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Two-step subtraction problem (1000-1150 ELO)
        start = randint(1000, 5000)
        first_subtract = randint(200, start ÷ 3)
        second_subtract = randint(100, (start - first_subtract) ÷ 2)
        ans = start - first_subtract - second_subtract
        
        problem(
            question="Start with $(start). Subtract $(first_subtract), then subtract $(second_subtract). What is the result?",
            answer=ans,
            difficulty=(1000, 1150),
            solution=steps(
                "First subtraction: \$$(start) - $(first_subtract) = $(start - first_subtract)\$",
                "Second subtraction: \$$(start - first_subtract) - $(second_subtract) = $(ans)\$",
                sol("Final Answer", ans)
            ),
            time=90
        )
        
    else
        # Mixed operations with subtraction focus (1050-1200 ELO)
        a = randint(100, 500)
        b = randint(50, 200)
        c = randint(20, 100)
        d = randint(10, 50)
        ans = a - b + c - d
        
        problem(
            question="Evaluate: \$$(a) - $(b) + $(c) - $(d)\$",
            answer=ans,
            difficulty=(1050, 1200),
            solution=steps(
                "Perform operations from left to right",
                "\$$(a) - $(b) = $(a - b)\$",
                "\$$(a - b) + $(c) = $(a - b + c)\$",
                sol("Final", "$(a - b + c) - $(d) = $(ans)")
            ),
            time=120
        )
    end
end