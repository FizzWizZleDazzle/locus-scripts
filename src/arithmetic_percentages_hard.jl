# arithmetic - percentages (hard)
# Generated: 2026-03-08T19:50:29.482967

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/percentages")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Compound percentage changes (Expert level)
        initial = randint(100, 500) * 10
        pct1 = randint(15, 40)
        pct2 = randint(10, 35)
        pct3 = randint(5, 25)
        
        after1 = initial * (1 + pct1/100)
        after2 = after1 * (1 - pct2/100)
        final_val = after2 * (1 + pct3/100)
        
        # What single percentage change from initial?
        net_change = ((final_val - initial) / initial) * 100
        ans = round(net_change, digits=2)
        
        problem(
            question="A product initially costs \\\$$initial. It increases by $pct1%, then decreases by $pct2%, then increases by $pct3%. What is the net percentage change from the original price? (Round to 2 decimal places)",
            answer=ans,
            difficulty=(1850, 2050),
            solution=steps(
                "After $pct1% increase: \\\$$initial × $(1 + pct1/100) = \\\$$(round(after1, digits=2))",
                "After $pct2% decrease: \\\$$(round(after1, digits=2)) × $(1 - pct2/100) = \\\$$(round(after2, digits=2))",
                "After $pct3% increase: \\\$$(round(after2, digits=2)) × $(1 + pct3/100) = \\\$$(round(final_val, digits=2))",
                "Net change: \\\$\\frac{$(round(final_val - initial, digits=2))}{$initial} × 100 = $ans\\%\\\$"
            ),
            time=180,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # Reverse percentage problem with constraints
        final_price = randint(80, 300)
        discount_pct = randint(25, 55)
        
        original = final_price / (1 - discount_pct/100)
        ans = round(original, digits=2)
        
        problem(
            question="After a $discount_pct% discount, an item costs \\\$$final_price. What was the original price? (Round to 2 decimal places)",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Let original price = \\\$x\\\$",
                "After $discount_pct% discount: \\\$x(1 - $(discount_pct/100)) = $final_price\\\$",
                "Solve: \\\$x × $(1 - discount_pct/100) = $final_price\\\$",
                sol("Answer", "\\\$$(ans)")
            ),
            time=150,
            calculator="scientific"
        )
        
    elseif problem_type == 3
        # Percentage of percentage with comparison
        total = randint(500, 2000)
        pct_A = randint(40, 70)
        pct_of_A = randint(15, 45)
        
        amount_A = total * (pct_A / 100)
        amount_B = amount_A * (pct_of_A / 100)
        ans = round(amount_B, digits=2)
        
        problem(
            question="A city has a population of $total people. $pct_A% are adults. Of the adults, $pct_of_A% have graduate degrees. How many people in the city have graduate degrees? (Round to 2 decimal places if needed)",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Number of adults: \\\$$(total) × \\frac{$(pct_A)}{100} = $(round(amount_A, digits=2))\\\$",
                "Adults with graduate degrees: \\\$$(round(amount_A, digits=2)) × \\frac{$(pct_of_A)}{100}\\\$",
                sol("Answer", "$(ans) people")
            ),
            time=120,
            calculator="scientific"
        )
        
    elseif problem_type == 4
        # Finding what percent one number is of another with algebra
        a = randint(12, 35)
        b = randint(8, 25)
        c = randint(100, 300)
        
        # a% of X = b% of c, find X
        X = (b * c) / a
        ans = round(X, digits=2)
        
        problem(
            question="If $a% of a number equals $b% of $c, what is the number? (Round to 2 decimal places)",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "Let the number be \\\$x\\\$",
                "Set up equation: \\\$\\frac{$a}{100}x = \\frac{$b}{100} × $c\\\$",
                "Simplify: \\\$$(a)x = $(b * c)\\\$",
                sol("Answer", "\\\$x = $(ans)\\\$")
            ),
            time=180,
            calculator="scientific"
        )
        
    else
        # Complex percentage increase/decrease to reach target
        start = randint(200, 600)
        target = randint(start + 100, start + 400)
        first_increase_pct = randint(20, 50)
        
        after_first = start * (1 + first_increase_pct/100)
        needed_increase = ((target - after_first) / after_first) * 100
        ans = round(needed_increase, digits=2)
        
        problem(
            question="A stock price starts at \\\$$start. It increases by $first_increase_pct%. What additional percentage increase is needed to reach \\\$$target? (Round to 2 decimal places)",
            answer=ans,
            difficulty=(2100, 2300),
            solution=steps(
                "After first increase: \\\$$start × $(1 + first_increase_pct/100) = \\\$$(round(after_first, digits=2))",
                "Amount needed: \\\$$target - \\\$$(round(after_first, digits=2)) = \\\$$(round(target - after_first, digits=2))",
                "Additional percentage: \\\$\\frac{$(round(target - after_first, digits=2))}{$(round(after_first, digits=2))} × 100\\\$",
                sol("Answer", "$ans%")
            ),
            time=200,
            calculator="scientific"
        )
    end
end