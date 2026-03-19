# arithmetic - addition (medium)
# Generated: 2026-03-08T19:45:29.376454

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/addition")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Multi-step addition with grouping (1200-1400)
        a = randint(15, 99)
        b = randint(15, 99)
        c = randint(15, 99)
        d = randint(15, 99)
        
        ans = a + b + c + d
        
        problem(
            question="Calculate: \\($(a) + $(b) + $(c) + $(d)\\)",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Group the numbers strategically",
                sol("First pair", "$(a) + $(b) = $(a + b)"),
                sol("Second pair", "$(c) + $(d) = $(c + d)"),
                sol("Final sum", "$(a + b) + $(c + d) = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Addition with carries and missing digits (1300-1500)
        digit1 = randint(3, 8)
        digit2 = randint(5, 9)
        digit3 = randint(2, 7)
        
        num1 = randint(200, 800)
        num2 = randint(150, 600)
        total = num1 + num2
        
        tens_digit = div(total, 10) % 10
        
        problem(
            question="If \\($(num1) + $(num2) = $(total)\\), what is the tens digit of the sum?",
            answer=tens_digit,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Calculate the sum", "$(num1) + $(num2) = $(total)"),
                "Identify the tens place in $(total)",
                sol("The tens digit is", tens_digit)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # Word problem with addition (1400-1600)
        initial = randint(1200, 3500)
        deposit1 = randint(200, 800)
        deposit2 = randint(300, 900)
        withdrawal = randint(100, 500)
        
        final_balance = initial + deposit1 + deposit2 - withdrawal
        
        problem(
            question="Sarah's bank account has \\\$$(initial). She deposits \\\$$(deposit1) on Monday and \\\$$(deposit2) on Wednesday. On Friday, she withdraws \\\$$(withdrawal). What is her final account balance?",
            answer=final_balance,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Starting balance", "\\\$$(initial)"),
                sol("After deposits", "\\\$$(initial) + \\\$$(deposit1) + \\\$$(deposit2) = \\\$$(initial + deposit1 + deposit2)"),
                sol("After withdrawal", "\\\$$(initial + deposit1 + deposit2) - \\\$$(withdrawal) = \\\$$(final_balance)")
            ),
            time=120
        )
        
    else
        # Pattern-based addition sequence (1500-1700)
        start = randint(50, 150)
        diff1 = randint(10, 30)
        diff2 = randint(5, 20)
        
        term1 = start
        term2 = term1 + diff1
        term3 = term2 + diff1 + diff2
        term4 = term3 + diff1 + 2*diff2
        term5 = term4 + diff1 + 3*diff2
        
        ans = term1 + term2 + term3 + term4 + term5
        
        problem(
            question="Find the sum of the sequence: $(term1), $(term2), $(term3), $(term4), $(term5)",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "List all terms: $(term1), $(term2), $(term3), $(term4), $(term5)",
                sol("Add consecutively", "$(term1) + $(term2) = $(term1 + term2), then add $(term3) = $(term1 + term2 + term3)"),
                sol("Continue", "$(term1 + term2 + term3) + $(term4) = $(term1 + term2 + term3 + term4)"),
                sol("Final sum", "$(term1 + term2 + term3 + term4) + $(term5) = $(ans)")
            ),
            time=150
        )
    end
end