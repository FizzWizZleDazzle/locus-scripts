# arithmetic - percentages (easy)
# Generated: 2026-03-08T19:50:03.381970

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/percentages")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Find percentage of a number (700-850 ELO)
        percent = rand([10, 15, 20, 25, 30, 40, 50, 60, 75, 80])
        number = randint(20, 200)
        ans = (percent * number) // 100
        
        problem(
            question="What is $(percent)% of $(number)?",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                "Convert percentage to decimal: $(percent)% = $(percent/100)",
                "Multiply: $(percent/100) × $(number)",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # What percent is X of Y? (750-900 ELO)
        whole = randint(40, 200)
        percent = rand([10, 15, 20, 25, 30, 40, 50, 60, 75, 80])
        part = (percent * whole) // 100
        
        problem(
            question="$(part) is what percent of $(whole)?",
            answer=percent,
            difficulty=(750, 900),
            solution=steps(
                "Set up equation: \\frac{$(part)}{$(whole)} = \\frac{x}{100}",
                "Solve: x = \\frac{$(part) × 100}{$(whole)}",
                sol("Answer", "$(percent)%")
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Percent increase/decrease (850-1000 ELO)
        original = randint(50, 300)
        percent_change = rand([10, 15, 20, 25, 30, 40, 50])
        is_increase = rand(Bool)
        
        if is_increase
            ans = original + (percent_change * original) // 100
            verb = "increase"
        else
            ans = original - (percent_change * original) // 100
            verb = "decrease"
        end
        
        problem(
            question="A quantity starts at $(original). After a $(percent_change)% $(verb), what is the new value?",
            answer=ans,
            difficulty=(850, 1000),
            solution=steps(
                "Calculate the change: $(percent_change)% of $(original) = $(abs(ans - original))",
                is_increase ? "Add to original: $(original) + $(abs(ans - original))" : "Subtract from original: $(original) - $(abs(ans - original))",
                sol("Answer", ans)
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Find original value after percent change (900-1050 ELO)
        percent = rand([10, 20, 25, 50])
        is_increase = rand(Bool)
        original = randint(40, 200)
        
        if is_increase
            final_val = original + (percent * original) // 100
            verb = "increase"
            multiplier = 1 + percent/100
        else
            final_val = original - (percent * original) // 100
            verb = "decrease"
            multiplier = 1 - percent/100
        end
        
        problem(
            question="After a $(percent)% $(verb), a value became $(final_val). What was the original value?",
            answer=original,
            difficulty=(900, 1050),
            solution=steps(
                "Set up equation: original × $(multiplier) = $(final_val)",
                "Solve for original: original = \\frac{$(final_val)}{$(multiplier)}",
                sol("Answer", original)
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Calculate percent change (800-950 ELO)
        original = randint(50, 200)
        percent = rand([10, 20, 25, 30, 40, 50])
        is_increase = rand(Bool)
        
        if is_increase
            new_val = original + (percent * original) // 100
        else
            new_val = original - (percent * original) // 100
        end
        
        change = abs(new_val - original)
        ans = percent
        
        problem(
            question="A value changes from $(original) to $(new_val). What is the percent change?",
            answer=ans,
            difficulty=(800, 950),
            solution=steps(
                "Find the change: |$(new_val) - $(original)| = $(change)",
                "Calculate percent: \\frac{$(change)}{$(original)} × 100",
                sol("Answer", "$(ans)%")
            ),
            time=75
        )
        
    else
        # Two successive percent changes (1000-1200 ELO)
        original = randint(100, 400)
        percent1 = rand([10, 20, 25, 50])
        percent2 = rand([10, 20, 25, 50])
        
        after_first = original + (percent1 * original) // 100
        ans = after_first - (percent2 * after_first) // 100
        
        problem(
            question="A price starts at \\\$$(original). It increases by $(percent1)%, then decreases by $(percent2)%. What is the final price?",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                "After first change: $(original) + $(percent1)% of $(original) = $(after_first)",
                "After second change: $(after_first) - $(percent2)% of $(after_first)",
                sol("Final price", "\\\$$(ans)")
            ),
            time=120
        )
    end
end