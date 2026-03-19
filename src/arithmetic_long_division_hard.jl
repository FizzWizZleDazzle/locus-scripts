# arithmetic - long_division (hard)
# Generated: 2026-03-08T19:47:24.643583

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("arithmetic/long_division")
    
    # Generate expert-level long division problems (1800-2500 ELO)
    # These require multi-step reasoning, pattern recognition, or special properties
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Division with large numbers requiring careful tracking
        # Finding quotient and remainder of large dividend
        divisor = randint(47, 157)
        quotient = randint(234, 876)
        remainder = randint(1, divisor - 1)
        dividend = divisor * quotient + remainder
        
        question = "Compute the quotient and remainder when $(dividend) is divided by $(divisor). Express your answer as Q with remainder R."
        answer = "$(quotient) R $(remainder)"
        
        sol_text = steps(
            "Perform long division of $(dividend) ÷ $(divisor)",
            "$(divisor) × $(quotient) = $(divisor * quotient)",
            "$(dividend) - $(divisor * quotient) = $(remainder)",
            sol("Answer", "Quotient = $(quotient), Remainder = $(remainder)")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1800, 2000),
            solution=sol_text,
            time=180
        )
        
    elseif problem_type == 2
        # Type 2: Finding missing digit in division problem
        # Reverse engineering from quotient/remainder
        divisor = randint(23, 89)
        quotient = randint(45, 99)
        remainder = randint(5, divisor - 5)
        dividend = divisor * quotient + remainder
        
        # Hide one digit and ask to find it
        div_str = string(dividend)
        hide_pos = rand(2:length(div_str))
        hidden_digit = div_str[hide_pos]
        masked = div_str[1:hide_pos-1] * "□" * div_str[hide_pos+1:end]
        
        question = "In the division problem $(masked) ÷ $(divisor), the quotient is $(quotient) with remainder $(remainder). Find the missing digit □."
        answer = parse(Int, string(hidden_digit))
        
        sol_text = steps(
            "We know: $(masked) = $(divisor) × $(quotient) + $(remainder)",
            "Calculate: $(divisor) × $(quotient) + $(remainder) = $(dividend)",
            "The complete dividend is $(dividend)",
            sol("Answer", "The missing digit is $(hidden_digit)")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2000, 2200),
            solution=sol_text,
            time=240
        )
        
    elseif problem_type == 3
        # Type 3: Division with special remainder properties
        # Find dividend given divisor, quotient constraint, and remainder property
        divisor = randint(31, 97)
        quotient = randint(40, 120)
        
        # Remainder is a specific fraction of divisor
        frac_num = rand([1, 2, 3])
        frac_den = rand([3, 4, 5])
        remainder = div(divisor * frac_num, frac_den)
        dividend = divisor * quotient + remainder
        
        question = "When $(dividend) is divided by $(divisor), find the quotient Q and verify that the remainder R satisfies R = $(frac_num)/$(frac_den) × $(divisor). What is Q + R?"
        answer = quotient + remainder
        
        sol_text = steps(
            "Perform division: $(dividend) ÷ $(divisor)",
            "Quotient Q = $(quotient), Remainder R = $(remainder)",
            "Check: $(frac_num)/$(frac_den) × $(divisor) = $(remainder) ✓",
            sol("Answer", "Q + R = $(quotient) + $(remainder) = $(answer)")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1900, 2100),
            solution=sol_text,
            time=200
        )
        
    elseif problem_type == 4
        # Type 4: System involving multiple divisions
        # Two related division problems
        divisor1 = randint(29, 73)
        q1 = randint(50, 150)
        r1 = randint(3, divisor1 - 3)
        n1 = divisor1 * q1 + r1
        
        # Second number is related
        n2 = n1 + randint(100, 500)
        q2 = div(n2, divisor1)
        r2 = n2 % divisor1
        
        question = "When $(n1) is divided by d, the quotient is $(q1) with remainder $(r1). When $(n2) is divided by the same divisor d, the remainder is $(r2). Find the quotient in the second division."
        answer = q2
        
        sol_text = steps(
            "From first division: $(n1) = d × $(q1) + $(r1)",
            "Solve for d: d = ($(n1) - $(r1)) ÷ $(q1) = $(divisor1)",
            "Second division: $(n2) ÷ $(divisor1)",
            "Quotient = $(div(n2, divisor1)) = $(q2)",
            sol("Answer", q2)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2100, 2300),
            solution=sol_text,
            time=270
        )
        
    else
        # Type 5: Division with digit sum constraint
        # Find quotient when dividend has special digit properties
        divisor = randint(37, 83)
        quotient = randint(60, 140)
        remainder = randint(7, divisor - 7)
        dividend = divisor * quotient + remainder
        
        digit_sum = sum(parse(Int, string(d)) for d in string(dividend))
        
        question = "A number N has a digit sum of $(digit_sum). When N is divided by $(divisor), the remainder is $(remainder). If N = $(dividend), find the quotient."
        answer = quotient
        
        sol_text = steps(
            "Given: N = $(dividend) with digit sum $(digit_sum)",
            "Perform division: $(dividend) ÷ $(divisor)",
            "$(dividend) = $(divisor) × Q + $(remainder)",
            "Solve: Q = ($(dividend) - $(remainder)) ÷ $(divisor) = $(quotient)",
            sol("Answer", quotient)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(1850, 2050),
            solution=sol_text,
            time=210
        )
    end
end