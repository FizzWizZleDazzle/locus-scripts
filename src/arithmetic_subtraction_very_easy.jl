# arithmetic - subtraction (very_easy)
# Generated: 2026-03-08T19:45:41.949413

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/subtraction")
    
    difficulty_level = randint(1, 4)
    
    if difficulty_level == 1
        # ELO 100-300: Single digit subtraction
        a = randint(5, 9)
        b = randint(1, a)
        ans = a - b
        
        problem(
            question="What is \\($(a) - $(b)\\)?",
            answer=ans,
            difficulty=(150, 300),
            solution=steps(
                "We need to subtract $(b) from $(a)",
                "Count backward from $(a) by $(b)",
                sol("Answer", ans)
            ),
            time=30
        )
    elseif difficulty_level == 2
        # ELO 300-500: Two digit subtraction (no borrowing)
        tens = randint(2, 9)
        ones_a = randint(4, 9)
        ones_b = randint(1, ones_a)
        a = tens * 10 + ones_a
        b = randint(10, tens * 10 - 10) + ones_b
        ans = a - b
        
        problem(
            question="Calculate \\($(a) - $(b)\\)",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", "$(a) - $(b)"),
                "Subtract ones place: $(ones_a) - $(ones_b) = $(ones_a - ones_b)",
                "Subtract tens place and combine",
                sol("Answer", ans)
            ),
            time=45
        )
    elseif difficulty_level == 3
        # ELO 400-600: Two digit subtraction with borrowing
        a = randint(30, 99)
        b = randint(10, a - 1)
        # Force borrowing by ensuring ones digit of a < ones digit of b
        ones_a = a % 10
        ones_b = b % 10
        if ones_a >= ones_b
            b = (b ÷ 10) * 10 + randint(ones_a + 1, 9)
            if b > a
                b = randint(10, a - 1)
            end
        end
        ans = a - b
        
        problem(
            question="Solve \\($(a) - $(b)\\)",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", "$(a) - $(b)"),
                "Borrow from tens place if needed",
                "Subtract ones, then tens",
                sol("Answer", ans)
            ),
            time=60
        )
    else
        # ELO 500-700: Three digit subtraction with borrowing
        a = randint(200, 999)
        b = randint(50, a - 1)
        ans = a - b
        
        problem(
            question="Calculate \\($(a) - $(b)\\)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "$(a) - $(b)"),
                "Align digits by place value",
                "Subtract starting from ones place, borrowing as needed",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end