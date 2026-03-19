# arithmetic - multiplication (very_easy)
# Generated: 2026-03-08T19:46:14.398785

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/multiplication")
    
    # Randomly choose problem type based on difficulty
    problem_type = choice([:single_digit, :two_digit, :with_zero, :powers_of_ten])
    
    if problem_type == :single_digit
        # 100-400 ELO: Single digit multiplication
        a = randint(2, 9)
        b = randint(2, 9)
        ans = a * b
        
        problem(
            question="What is \\($(a) \\times $(b)\\)?",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Multiply $(a) and $(b)",
                "$(a) × $(b) = $(ans)",
                sol("Answer", ans)
            ),
            time=30
        )
    elseif problem_type == :two_digit
        # 400-700 ELO: Two-digit by one-digit multiplication
        a = randint(11, 25)
        b = randint(2, 9)
        ans = a * b
        
        # Show breakdown
        tens = (a ÷ 10) * 10
        ones = a % 10
        partial1 = tens * b
        partial2 = ones * b
        
        problem(
            question="Calculate \\($(a) \\times $(b)\\)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Break down $(a) as $(tens) + $(ones)",
                "$(tens) × $(b) = $(partial1), and $(ones) × $(b) = $(partial2)",
                "$(partial1) + $(partial2) = $(ans)",
                sol("Answer", ans)
            ),
            time=60
        )
    elseif problem_type == :with_zero
        # 300-500 ELO: Multiplication with zero
        a = randint(5, 50)
        if choice([true, false])
            # Multiply by zero
            problem(
                question="What is \\($(a) \\times 0\\)?",
                answer=0,
                difficulty=(300, 500),
                solution=steps(
                    "Any number multiplied by 0 equals 0",
                    "$(a) × 0 = 0",
                    sol("Answer", 0)
                ),
                time=30
            )
        else
            # Multiply by one
            problem(
                question="What is \\($(a) \\times 1\\)?",
                answer=a,
                difficulty=(200, 400),
                solution=steps(
                    "Any number multiplied by 1 equals itself",
                    "$(a) × 1 = $(a)",
                    sol("Answer", a)
                ),
                time=30
            )
        end
    else
        # 500-700 ELO: Powers of ten
        a = randint(2, 99)
        power = choice([10, 100])
        ans = a * power
        
        problem(
            question="Calculate \\($(a) \\times $(power)\\)",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "When multiplying by $(power), add $(power == 10 ? "one" : "two") zero(s) to the end",
                "$(a) × $(power) = $(ans)",
                sol("Answer", ans)
            ),
            time=45
        )
    end
end