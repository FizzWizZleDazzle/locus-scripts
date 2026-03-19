# arithmetic - addition (easy)
# Generated: 2026-03-08T19:45:27.644873

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/addition")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Two-step addition with carrying (700-900 ELO)
        a = randint(47, 98)
        b = randint(35, 87)
        ans = a + b
        
        problem(
            question="Calculate: \$$(a) + $(b)\$",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Add the ones place: $(a % 10) + $(b % 10) = $((a % 10) + (b % 10))",
                "Add the tens place with any carry: $(div(a, 10)) + $(div(b, 10))$(((a % 10) + (b % 10) >= 10) ? " + 1" : "")",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Three-number addition (800-1000 ELO)
        a = randint(23, 89)
        b = randint(31, 76)
        c = randint(18, 64)
        ans = a + b + c
        
        problem(
            question="Calculate: \$$(a) + $(b) + $(c)\$",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("First add", "$a + $b = $(a + b)"),
                sol("Then add", "$(a + b) + $c = $(ans)"),
                sol("Answer", ans)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Addition with three-digit numbers (850-1050 ELO)
        a = randint(134, 487)
        b = randint(156, 523)
        ans = a + b
        
        problem(
            question="Calculate: \$$(a) + $(b)\$",
            answer=ans,
            difficulty=(850, 1050),
            solution=steps(
                "Add ones place: $(a % 10) + $(b % 10) = $((a % 10) + (b % 10))",
                "Add tens place with carry: $(div(a, 10) % 10) + $(div(b, 10) % 10)$(((a % 10) + (b % 10) >= 10) ? " + 1" : "") = $(div(ans, 10) % 10 + ((a % 10) + (b % 10) >= 10 ? 10 : 0))",
                sol("Add hundreds place with carry, final answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Multi-step addition with regrouping (900-1100 ELO)
        a = randint(247, 678)
        b = randint(189, 543)
        c = randint(67, 234)
        ans = a + b + c
        
        problem(
            question="Calculate: \$$(a) + $(b) + $(c)\$",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("First", "$a + $b = $(a + b)"),
                sol("Then", "$(a + b) + $c"),
                sol("Answer", ans)
            ),
            time=100
        )
        
    else
        # Four-number addition challenge (950-1200 ELO)
        a = randint(78, 234)
        b = randint(123, 289)
        c = randint(56, 167)
        d = randint(91, 198)
        ans = a + b + c + d
        
        problem(
            question="Calculate: \$$(a) + $(b) + $(c) + $(d)\$",
            answer=ans,
            difficulty=(950, 1200),
            solution=steps(
                sol("Add first two", "$a + $b = $(a + b)"),
                sol("Add third", "$(a + b) + $c = $(a + b + c)"),
                sol("Add fourth", "$(a + b + c) + $d = $(ans)")
            ),
            time=120
        )
    end
end