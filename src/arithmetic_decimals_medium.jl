# arithmetic - decimals (medium)
# Generated: 2026-03-08T19:49:34.651120

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/decimals")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Multi-step decimal arithmetic with order of operations
        a = round(rand() * 20 + 5, digits=2)
        b = round(rand() * 15 + 3, digits=2)
        c = round(rand() * 10 + 2, digits=2)
        d = round(rand() * 8 + 1, digits=2)
        
        ans = round(a * b - c + d, digits=2)
        
        problem(
            question="Calculate: \$$(a) \\times $(b) - $(c) + $(d)\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Apply order of operations (multiplication first)",
                sol("Step 1", "$(a) × $(b) = $(round(a*b, digits=2))"),
                sol("Step 2", "$(round(a*b, digits=2)) - $(c) = $(round(a*b - c, digits=2))"),
                sol("Step 3", "$(round(a*b - c, digits=2)) + $(d) = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Decimal division with multiple steps
        dividend = round(rand() * 150 + 50, digits=2)
        divisor1 = round(rand() * 5 + 2, digits=1)
        divisor2 = round(rand() * 3 + 1.5, digits=1)
        
        ans = round(dividend / divisor1 / divisor2, digits=3)
        
        problem(
            question="Calculate: \$\\frac{$(dividend)}{$(divisor1) \\times $(divisor2)}\$",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "First compute the denominator",
                sol("Denominator", "$(divisor1) × $(divisor2) = $(round(divisor1 * divisor2, digits=2))"),
                "Now divide the numerator by the denominator",
                sol("Answer", "$(dividend) ÷ $(round(divisor1 * divisor2, digits=2)) = $(ans)")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Word problem: calculating unit price and total cost
        item_cost = round(rand() * 8 + 3, digits=2)
        quantity = rand(15:45)
        discount_rate = round(rand() * 0.2 + 0.1, digits=2)
        
        subtotal = round(item_cost * quantity, digits=2)
        discount = round(subtotal * discount_rate, digits=2)
        ans = round(subtotal - discount, digits=2)
        
        problem(
            question="A store sells items for \\\$$(item_cost) each. You buy $(quantity) items and receive a $(Int(round(discount_rate * 100)))% discount. What is the final cost?",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                "Calculate the subtotal before discount",
                sol("Subtotal", "\$$(item_cost) × $(quantity) = \$$(subtotal)"),
                "Calculate the discount amount",
                sol("Discount", "\$$(subtotal) × $(discount_rate) = \$$(discount)"),
                "Subtract discount from subtotal",
                sol("Final Cost", "\$$(subtotal) - \$$(discount) = \$$(ans)")
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Complex expression with nested operations
        a = round(rand() * 12 + 4, digits=1)
        b = round(rand() * 8 + 2, digits=1)
        c = round(rand() * 6 + 1, digits=1)
        d = round(rand() * 4 + 1, digits=1)
        
        inner = round((a + b) / c, digits=3)
        ans = round(inner * d, digits=2)
        
        problem(
            question="Evaluate: \$\\left(\\frac{$(a) + $(b)}{$(c)}\\right) \\times $(d)\$",
            answer=ans,
            difficulty=(1250, 1450),
            solution=steps(
                "Simplify the numerator inside parentheses",
                sol("Numerator", "$(a) + $(b) = $(round(a+b, digits=1))"),
                "Divide by the denominator",
                sol("Division", "$(round(a+b, digits=1)) ÷ $(c) = $(inner)"),
                "Multiply by $(d)",
                sol("Answer", "$(inner) × $(d) = $(ans)")
            ),
            time=120
        )
        
    elseif problem_type == 5
        # Ratio and proportion word problem
        rate = round(rand() * 15 + 5, digits=2)
        time_hours = round(rand() * 4 + 2, digits=1)
        additional_time = round(rand() * 3 + 1, digits=1)
        
        initial_amount = round(rate * time_hours, digits=2)
        total_time = round(time_hours + additional_time, digits=1)
        ans = round(rate * total_time, digits=2)
        
        problem(
            question="A machine produces $(rate) units per hour. After $(time_hours) hours, it has produced $(initial_amount) units. How many units will it produce after $(total_time) hours total?",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Verify the rate is correct",
                sol("Check", "$(initial_amount) ÷ $(time_hours) = $(rate) units/hour"),
                "Calculate total production after $(total_time) hours",
                sol("Total Production", "$(rate) × $(total_time) = $(ans) units"),
                "Answer: $(ans) units"
            ),
            time=180
        )
        
    else
        # Percent change with decimals
        original = round(rand() * 80 + 30, digits=2)
        increase_rate = round(rand() * 0.35 + 0.15, digits=2)
        decrease_rate = round(rand() * 0.25 + 0.1, digits=2)
        
        after_increase = round(original * (1 + increase_rate), digits=2)
        ans = round(after_increase * (1 - decrease_rate), digits=2)
        
        increase_pct = Int(round(increase_rate * 100))
        decrease_pct = Int(round(decrease_rate * 100))
        
        problem(
            question="A price starts at \\\$$(original). It increases by $(increase_pct)%, then decreases by $(decrease_pct)%. What is the final price?",
            answer=ans,
            difficulty=(1600, 1800),
            solution=steps(
                "Calculate the price after $(increase_pct)% increase",
                sol("After Increase", "\$$(original) × $(round(1 + increase_rate, digits=2)) = \$$(after_increase)"),
                "Calculate the price after $(decrease_pct)% decrease",
                sol("After Decrease", "\$$(after_increase) × $(round(1 - decrease_rate, digits=2)) = \$$(ans)"),
                "Final price: \$$(ans)"
            ),
            time=180
        )
    end
end