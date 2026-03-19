# arithmetic - long_division (very_easy)
# Generated: 2026-03-08T19:46:58.291961

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/long_division")
    
    # Generate foundational/elementary long division problems (100-700 ELO)
    # Pick difficulty level for this problem
    difficulty_level = rand([1, 2, 3])
    
    if difficulty_level == 1
        # ELO 100-300: Simple division, single digit divisor, no remainder
        divisor = randint(2, 9)
        quotient = randint(2, 9)
        dividend = divisor * quotient
        remainder = 0
        elo = (100, 300)
        time_limit = 45
    elseif difficulty_level == 2
        # ELO 300-500: Two-digit dividend, single digit divisor, possible remainder
        divisor = randint(2, 9)
        quotient = randint(3, 12)
        remainder = rand([0, 0, randint(1, divisor - 1)])  # 2/3 chance no remainder
        dividend = divisor * quotient + remainder
        elo = (300, 500)
        time_limit = 60
    else
        # ELO 500-700: Larger numbers, two-digit dividend, possible two-digit divisor
        if rand() < 0.5
            # Single digit divisor with larger dividend
            divisor = randint(3, 9)
            quotient = randint(10, 25)
            remainder = rand([0, 0, randint(1, divisor - 1)])
            dividend = divisor * quotient + remainder
        else
            # Two-digit divisor
            divisor = randint(11, 25)
            quotient = randint(2, 8)
            remainder = rand([0, 0, randint(1, divisor - 1)])
            dividend = divisor * quotient + remainder
        end
        elo = (500, 700)
        time_limit = 90
    end
    
    # Format answer based on remainder
    if remainder == 0
        answer_str = string(quotient)
        solution_text = steps(
            "Set up the division: \\\$$dividend \\div $divisor\\\$",
            "Divide: \\\$$dividend \\div $divisor = $quotient\\\$",
            sol("Answer", quotient)
        )
    else
        answer_str = "$quotient R$remainder"
        solution_text = steps(
            "Set up the division: \\\$$dividend \\div $divisor\\\$",
            "Divide: \\\$$divisor \\times $quotient = $(divisor * quotient)\\\$",
            "Remainder: \\\$$dividend - $(divisor * quotient) = $remainder\\\$",
            sol("Answer", "$(quotient) \\text{ R}$remainder")
        )
    end
    
    problem(
        question = "Divide: \\\$$dividend \\div $divisor\\\$",
        answer = answer_str,
        difficulty = elo,
        solution = solution_text,
        time = time_limit,
        answer_type = "string"
    )
end