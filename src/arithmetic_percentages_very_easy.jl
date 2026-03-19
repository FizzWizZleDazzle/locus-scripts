# arithmetic - percentages (very_easy)
# Generated: 2026-03-08T19:49:51.347742

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/percentages")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Basic percentage recognition (100-300 ELO)
        value = randint(1, 100)
        total = choice([10, 20, 25, 50, 100])
        percent = (value / total) * 100
        
        problem(
            question="What percent is $value out of $total?",
            answer=percent,
            difficulty=(200, 400),
            solution=steps(
                "Calculate the fraction: \\frac{$value}{$total}",
                "Multiply by 100 to convert to percentage",
                sol("Answer", "$(percent)\\%")
            ),
            time=45
        )
    elseif problem_type == 2
        # Find percentage of a number (300-500 ELO)
        percent = choice([10, 20, 25, 50, 75])
        number = randint(20, 200)
        ans = (percent / 100) * number
        
        problem(
            question="What is $percent% of $number?",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "Convert percentage to decimal: $percent% = $(percent/100)",
                "Multiply: $(percent/100) × $number",
                sol("Answer", ans)
            ),
            time=60
        )
    elseif problem_type == 3
        # Simple percentage calculation (400-600 ELO)
        base = randint(10, 100)
        percent = randint(5, 95)
        ans = round((percent / 100) * base, digits=2)
        
        problem(
            question="Calculate $percent% of $base.",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Convert $percent% to decimal: $(percent/100)",
                "Multiply by base: $(percent/100) × $base",
                sol("Answer", ans)
            ),
            time=60
        )
    elseif problem_type == 4
        # What percent is X of Y (500-700 ELO)
        part = randint(5, 50)
        whole = randint(part + 10, 100)
        ans = round((part / whole) * 100, digits=2)
        
        problem(
            question="$part is what percent of $whole? (Round to 2 decimal places if needed)",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Set up the equation: \\frac{$part}{$whole} × 100",
                "Calculate: $(round(part/whole, digits=4)) × 100",
                sol("Answer", "$(ans)\\%")
            ),
            time=75
        )
    elseif problem_type == 5
        # Percentage increase/decrease (600-700 ELO)
        original = randint(50, 200)
        percent_change = choice([10, 20, 25, 50])
        is_increase = rand(Bool)
        
        if is_increase
            ans = original + (percent_change / 100) * original
            word = "increase"
        else
            ans = original - (percent_change / 100) * original
            word = "decrease"
        end
        
        problem(
            question="A number is $original. After a $percent_change% $word, what is the new value?",
            answer=ans,
            difficulty=(600, 700),
            solution=steps(
                "Calculate the change: $(percent_change/100) × $original = $((percent_change/100) * original)",
                is_increase ? "Add to original: $original + $((percent_change/100) * original)" : "Subtract from original: $original - $((percent_change/100) * original)",
                sol("Answer", ans)
            ),
            time=90
        )
    else
        # Find the whole given part and percent (500-700 ELO)
        percent = choice([10, 20, 25, 40, 50])
        part = randint(10, 100)
        whole = (part / percent) * 100
        
        problem(
            question="$part is $percent% of what number?",
            answer=whole,
            difficulty=(500, 700),
            solution=steps(
                "Set up equation: $percent% × ? = $part",
                "Divide both sides by $(percent/100): ? = $part ÷ $(percent/100)",
                sol("Answer", whole)
            ),
            time=90
        )
    end
end