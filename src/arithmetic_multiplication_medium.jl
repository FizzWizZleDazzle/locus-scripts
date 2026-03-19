# arithmetic - multiplication (medium)
# Generated: 2026-03-08T19:46:39.897075

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/multiplication")
    
    problem_type = choice([
        :multi_digit_product,
        :word_problem_area,
        :word_problem_rate,
        :distributive_property,
        :pattern_recognition,
        :multi_step_calculation,
        :multiplication_with_fractions,
        :scaling_problem
    ])
    
    if problem_type == :multi_digit_product
        # Multi-digit multiplication requiring strategic thinking
        a = randint(23, 147)
        b = randint(12, 89)
        ans = a * b
        
        problem(
            question="Calculate \$$(a) \\times $(b)\$",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Set up the multiplication: \$$(a) \\times $(b)\$",
                "Break down using place value or use standard algorithm",
                "Multiply and add partial products",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == :word_problem_area
        # Area calculation requiring setup
        length = randint(15, 48)
        width = randint(12, 35)
        ans = length * width
        
        problem(
            question="A rectangular garden has a length of $(length) feet and a width of $(width) feet. What is the area of the garden in square feet?",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Identify the formula: Area = length × width",
                sol("Substitute values", "$(length) \\times $(width)"),
                "Calculate the product",
                sol("Answer", "$(ans) \\text{ square feet}")
            ),
            time=90
        )
        
    elseif problem_type == :word_problem_rate
        # Rate problem requiring equation setup
        rate = randint(12, 45)
        time = randint(8, 25)
        ans = rate * time
        
        problem(
            question="A factory produces $(rate) widgets per hour. How many widgets are produced in $(time) hours?",
            answer=ans,
            difficulty=(1250, 1450),
            solution=steps(
                "Set up the relationship: Total = rate × time",
                sol("Substitute", "$(rate) \\times $(time)"),
                "Calculate the product",
                sol("Answer", "$(ans) \\text{ widgets}")
            ),
            time=100
        )
        
    elseif problem_type == :distributive_property
        # Using distributive property strategically
        a = randint(8, 23)
        b = randint(5, 15)
        c = randint(3, 12)
        ans = a * (b + c)
        
        problem(
            question="Calculate \$$(a) \\times ($(b) + $(c))\$ using the distributive property.",
            answer=ans,
            difficulty=(1300, 1600),
            solution=steps(
                sol("Apply distributive property", "$(a) \\times $(b) + $(a) \\times $(c)"),
                sol("Calculate each product", "$(a * b) + $(a * c)"),
                "Add the results",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == :pattern_recognition
        # Pattern in multiplication requiring insight
        base = randint(7, 18)
        multiplier1 = randint(4, 12)
        multiplier2 = randint(2, 8)
        product1 = base * multiplier1
        ans = product1 * multiplier2
        
        problem(
            question="If \$$(base) \\times $(multiplier1) = $(product1)\$, what is \$$(product1) \\times $(multiplier2)\$?",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                "Recognize that \$$(product1) \\times $(multiplier2) = ($(base) \\times $(multiplier1)) \\times $(multiplier2)\$",
                sol("Use associative property", "$(base) \\times ($(multiplier1) \\times $(multiplier2))"),
                sol("Calculate", "$(base) \\times $(multiplier1 * multiplier2) = $(ans)"),
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == :multi_step_calculation
        # Multi-step word problem
        price = randint(15, 65)
        quantity1 = randint(5, 15)
        quantity2 = randint(3, 12)
        ans = price * (quantity1 + quantity2)
        
        problem(
            question="A store sells notebooks for \\\$$(price) each. Maria buys $(quantity1) notebooks and John buys $(quantity2) notebooks. What is the total cost of all the notebooks purchased?",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                "Find total number of notebooks: \$$(quantity1) + $(quantity2) = $(quantity1 + quantity2)\$",
                sol("Set up multiplication", "$(price) \\times $(quantity1 + quantity2)"),
                "Calculate the total cost",
                sol("Answer", "\\\$$(ans)")
            ),
            time=120
        )
        
    elseif problem_type == :multiplication_with_fractions
        # Integer result from fraction multiplication
        whole = randint(8, 24)
        denom = choice([2, 3, 4, 5, 6])
        numer = randint(denom + 1, 4 * denom)
        ans = (whole * numer) ÷ denom
        
        # Ensure integer result
        numer = ans * denom ÷ whole
        
        problem(
            question="Calculate \$$(whole) \\times \\frac{$(numer)}{$(denom)}\$",
            answer=ans,
            difficulty=(1350, 1650),
            solution=steps(
                sol("Rewrite as fraction", "\\frac{$(whole) \\times $(numer)}{$(denom)}"),
                sol("Multiply numerator", "\\frac{$(whole * numer)}{$(denom)}"),
                "Divide to simplify",
                sol("Answer", ans)
            ),
            time=130
        )
        
    else  # scaling_problem
        # Scaling/ratio problem
        original = randint(12, 35)
        scale = randint(4, 15)
        ans = original * scale
        
        problem(
            question="A recipe calls for $(original) ounces of flour. If you want to make $(scale) times the recipe, how many ounces of flour do you need?",
            answer=ans,
            difficulty=(1300, 1600),
            solution=steps(
                "Identify the scaling factor: $(scale)",
                sol("Set up multiplication", "$(original) \\times $(scale)"),
                "Calculate the scaled amount",
                sol("Answer", "$(ans) \\text{ ounces}")
            ),
            time=110
        )
    end
end