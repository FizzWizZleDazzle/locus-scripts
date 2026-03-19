# arithmetic - percentages (medium)
# Generated: 2026-03-08T19:50:12.387625

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/percentages")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Finding percentage of a number with multi-step setup
        original = randint(150, 800)
        pct = choice([15, 20, 25, 30, 35, 40, 45, 60, 75, 80])
        result = original * pct // 100
        
        problem(
            question="A store originally had $(original) items in stock. After a sale, $(pct)% of the items were sold. How many items were sold?",
            answer=result,
            difficulty=(1200, 1400),
            solution=steps(
                "Convert percentage to decimal: $(pct)% = $(pct/100)",
                sol("Calculate", "$(original) × $(pct/100) = $(original) × $(pct)//100"),
                sol("Answer", result)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Percent increase/decrease with original value
        original = randint(200, 1000)
        pct_change = choice([12, 15, 18, 20, 25, 30, 35, 40])
        is_increase = choice([true, false])
        
        if is_increase
            new_val = original * (100 + pct_change) // 100
            word = "increase"
        else
            new_val = original * (100 - pct_change) // 100
            word = "decrease"
        end
        
        problem(
            question="A company's revenue was \$$(original) last year. This year, revenue $(word)d by $(pct_change)%. What is the new revenue?",
            answer=new_val,
            difficulty=(1300, 1500),
            solution=steps(
                "$(is_increase ? "Increase" : "Decrease") of $(pct_change)% means multiply by $(is_increase ? "1 + $(pct_change/100)" : "1 - $(pct_change/100)") = $(is_increase ? (100+pct_change)/100 : (100-pct_change)/100)",
                sol("Calculate", "$(original) × $(is_increase ? (100+pct_change) : (100-pct_change))//100"),
                sol("Answer", "\$$(new_val)")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Finding original value after percentage change
        pct_change = choice([20, 25, 30, 40, 50, 60])
        original = randint(100, 600)
        is_increase = choice([true, false])
        
        if is_increase
            final = original * (100 + pct_change) // 100
            multiplier = (100 + pct_change) // 100
        else
            final = original * (100 - pct_change) // 100
            multiplier = (100 - pct_change) // 100
        end
        
        problem(
            question="After a $(pct_change)% $(is_increase ? "increase" : "decrease"), a quantity became $(final). What was the original value?",
            answer=original,
            difficulty=(1400, 1600),
            solution=steps(
                "Let x be the original value",
                "After $(pct_change)% $(is_increase ? "increase" : "decrease"): x × $(multiplier) = $(final)",
                sol("Solve", "x = $(final) ÷ $(multiplier) = $(original)")
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Successive percentage changes
        original = randint(400, 1200)
        pct1 = choice([10, 15, 20, 25, 30])
        pct2 = choice([10, 15, 20, 25])
        
        after_first = original * (100 + pct1) // 100
        final = after_first * (100 - pct2) // 100
        
        problem(
            question="A price of \$$(original) first increased by $(pct1)%, then decreased by $(pct2)%. What is the final price?",
            answer=final,
            difficulty=(1500, 1700),
            solution=steps(
                sol("After $(pct1)% increase", "$(original) × $(100+pct1)//100 = $(after_first)"),
                sol("After $(pct2)% decrease", "$(after_first) × $(100-pct2)//100 = $(final)"),
                sol("Final price", "\$$(final)")
            ),
            time=180
        )
        
    else
        # Finding what percent one number is of another with context
        part = randint(45, 180)
        multiplier = randint(3, 8)
        whole = part * multiplier
        pct = 100 // multiplier
        
        problem(
            question="In a class of $(whole) students, $(part) students passed an exam. What percentage of students passed?",
            answer=pct,
            difficulty=(1200, 1400),
            solution=steps(
                "Set up ratio: $(part) out of $(whole)",
                sol("Convert to percentage", "($(part) ÷ $(whole)) × 100%"),
                sol("Answer", "$(pct)%")
            ),
            time=90
        )
    end
end