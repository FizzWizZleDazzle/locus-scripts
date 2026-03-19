# arithmetic - long_division (medium)
# Generated: 2026-03-08T19:47:15.310002

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/long_division")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Three-digit by one-digit with remainder (1200-1400)
        divisor = randint(3, 9)
        quotient = randint(25, 95)
        remainder = randint(1, divisor - 1)
        dividend = divisor * quotient + remainder
        
        problem(
            question="Divide $(dividend) by $(divisor). Express your answer as a quotient and remainder in the form Q R R (e.g., \"42 R 3\").",
            answer="$(quotient) R $(remainder)",
            difficulty=(1200, 1350),
            solution=steps(
                "Perform long division: \\($(dividend) \\div $(divisor)\\)",
                "\\($(divisor) \\times $(quotient) = $(divisor * quotient)\\)",
                "Remainder: \\($(dividend) - $(divisor * quotient) = $(remainder)\\)",
                sol("Answer", "$(quotient) R $(remainder)")
            ),
            time=90
        )
    elseif problem_type == 2
        # Type 2: Four-digit by two-digit (1300-1500)
        divisor = randint(12, 89)
        quotient = randint(15, 85)
        remainder = randint(0, divisor - 1)
        dividend = divisor * quotient + remainder
        
        if remainder == 0
            ans_text = "$(quotient)"
            question_text = "Divide $(dividend) by $(divisor). What is the quotient?"
        else
            ans_text = "$(quotient) R $(remainder)"
            question_text = "Divide $(dividend) by $(divisor). Express your answer as a quotient and remainder in the form Q R R."
        end
        
        problem(
            question=question_text,
            answer=ans_text,
            difficulty=(1300, 1500),
            solution=steps(
                "Set up long division: \\($(dividend) \\div $(divisor)\\)",
                "Determine how many times $(divisor) goes into $(dividend)",
                "\\($(divisor) \\times $(quotient) = $(divisor * quotient)\\)",
                remainder == 0 ? sol("Answer", quotient) : "Remainder: \\($(dividend) - $(divisor * quotient) = $(remainder)\\), so answer is $(ans_text)"
            ),
            time=120
        )
    elseif problem_type == 3
        # Type 3: Express as mixed number or decimal (1400-1600)
        divisor = randint(4, 15)
        whole_part = randint(8, 45)
        numerator_part = randint(1, divisor - 1)
        dividend = divisor * whole_part + numerator_part
        
        use_mixed = choice([true, false])
        
        if use_mixed
            ans_text = "$(whole_part) $(numerator_part)/$(divisor)"
            problem(
                question="Divide $(dividend) by $(divisor) and express your answer as a mixed number in the form \"W N/D\" (e.g., \"5 2/3\").",
                answer=ans_text,
                difficulty=(1400, 1550),
                solution=steps(
                    "Perform long division: \\($(dividend) \\div $(divisor)\\)",
                    "Quotient: $(whole_part), Remainder: $(numerator_part)",
                    "Express as mixed number: \\($(whole_part)\\frac{$(numerator_part)}{$(divisor)}\\)",
                    sol("Answer", ans_text)
                ),
                time=120
            )
        else
            decimal_answer = round(dividend / divisor, digits=3)
            problem(
                question="Divide $(dividend) by $(divisor) and express your answer as a decimal rounded to 3 decimal places.",
                answer=decimal_answer,
                difficulty=(1400, 1550),
                calculator="scientific",
                solution=steps(
                    "Perform long division: \\($(dividend) \\div $(divisor)\\)",
                    "Convert to decimal: \\($(dividend) \\div $(divisor) = $(decimal_answer)\\)",
                    sol("Answer", decimal_answer)
                ),
                time=100
            )
        end
    else
        # Type 4: Word problem requiring long division setup (1500-1800)
        context = choice([
            "students", "books", "cookies", "pencils", "chairs", 
            "apples", "boxes", "tickets", "bags", "toys"
        ])
        
        per_group = randint(8, 35)
        num_groups = randint(12, 48)
        leftover = randint(1, per_group - 1)
        total = per_group * num_groups + leftover
        
        scenarios = [
            ("A teacher has $(total) $(context) to distribute equally among $(per_group) students. How many $(context) does each student receive, and how many are left over?", "$(num_groups) R $(leftover)"),
            ("A factory packs $(total) items into boxes of $(per_group) each. How many full boxes can be made, and how many items remain?", "$(num_groups) R $(leftover)"),
            ("There are $(total) $(context) to be divided equally among $(per_group) groups. What is the quotient and remainder?", "$(num_groups) R $(leftover)")
        ]
        
        question_text, answer_format = choice(scenarios)
        
        problem(
            question=question_text * " Express as Q R R.",
            answer=answer_format,
            difficulty=(1500, 1750),
            solution=steps(
                "Set up division problem: \\($(total) \\div $(per_group)\\)",
                "Perform long division",
                "\\($(per_group) \\times $(num_groups) = $(per_group * num_groups)\\)",
                "Remainder: \\($(total) - $(per_group * num_groups) = $(leftover)\\)",
                sol("Answer", "$(num_groups) R $(leftover)")
            ),
            time=150
        )
    end
end