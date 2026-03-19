# arithmetic - ratios_proportions (medium)
# Generated: 2026-03-08T19:51:47.015102

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/ratios_proportions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Direct proportion word problem (1200-1400)
        item = choice(["pencils", "notebooks", "erasers", "markers", "books", "pens"])
        cost_per = randint(2, 15)
        qty1 = randint(3, 12)
        cost1 = cost_per * qty1
        qty2 = randint(15, 40)
        ans = cost_per * qty2
        
        problem(
            question="If $(qty1) $(item) cost \$$(cost1), how much will $(qty2) $(item) cost at the same rate?",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Set up proportion: \\frac{$(cost1)}{$(qty1)} = \\frac{x}{$(qty2)}",
                "Cross multiply: $(qty1)x = $(cost1) \\times $(qty2) = $(cost1 * qty2)",
                sol("Solve for x", "x = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Ratio simplification with three quantities (1300-1500)
        gcd_val = randint(2, 8)
        a_simple = randint(2, 9)
        b_simple = randint(2, 9)
        c_simple = randint(2, 9)
        a = a_simple * gcd_val
        b = b_simple * gcd_val
        c = c_simple * gcd_val
        
        ans = "$(a_simple):$(b_simple):$(c_simple)"
        
        problem(
            question="Simplify the ratio $(a):$(b):$(c) to its lowest terms.",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Find GCD of $(a), $(b), and $(c)",
                "GCD = $(gcd_val)",
                sol("Divide each term by $(gcd_val)", "$(a)÷$(gcd_val) : $(b)÷$(gcd_val) : $(c)÷$(gcd_val) = $(a_simple):$(b_simple):$(c_simple)")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Mixture/mixture ratio problem (1400-1600)
        total = randint(40, 120)
        ratio_a = randint(2, 7)
        ratio_b = randint(2, 7)
        ratio_sum = ratio_a + ratio_b
        
        # Ensure divisibility
        total = (total ÷ ratio_sum) * ratio_sum
        
        ans = (ratio_a * total) ÷ ratio_sum
        
        liquid1 = choice(["red paint", "water", "juice", "solution A", "acid"])
        liquid2 = choice(["blue paint", "concentrate", "syrup", "solution B", "base"])
        
        problem(
            question="A mixture of $(liquid1) and $(liquid2) is made in the ratio $(ratio_a):$(ratio_b). If the total volume is $(total) mL, how many mL of $(liquid1) are needed?",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                "Total parts in ratio: $(ratio_a) + $(ratio_b) = $(ratio_sum)",
                "Value per part: $(total) ÷ $(ratio_sum) = $(total ÷ ratio_sum)",
                sol("Amount of $(liquid1)", "$(ratio_a) × $(total ÷ ratio_sum) = $(ans) mL")
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Scale/map problem (1400-1700)
        scale_num = randint(1, 5)
        scale_denom = choice([100, 200, 250, 500, 1000]) * scale_num
        map_distance = randint(8, 30)
        
        ans = (map_distance * scale_denom) ÷ scale_num
        
        problem(
            question="On a map, the scale is $(scale_num):$(scale_denom). If two cities are $(map_distance) cm apart on the map, what is the actual distance between them in cm?",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                "Set up proportion: \\frac{$(scale_num)}{$(scale_denom)} = \\frac{$(map_distance)}{x}",
                "Cross multiply: $(scale_num)x = $(map_distance) × $(scale_denom) = $(map_distance * scale_denom)",
                sol("Solve for x", "x = $(ans) cm")
            ),
            time=150
        )
        
    elseif problem_type == 5
        # Inverse proportion (1500-1700)
        workers1 = randint(4, 12)
        days1 = randint(8, 25)
        workers2 = randint(15, 40)
        
        # workers1 × days1 = workers2 × days2
        total_work = workers1 * days1
        ans_num = total_work
        ans_denom = workers2
        
        if ans_num % ans_denom == 0
            ans = ans_num ÷ ans_denom
        else
            ans = "$(ans_num)//$(ans_denom)"
        end
        
        problem(
            question="If $(workers1) workers can complete a job in $(days1) days, how many days will it take $(workers2) workers to complete the same job (assuming they work at the same rate)?",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Inverse proportion: workers × days = constant",
                "$(workers1) × $(days1) = $(workers2) × x",
                sol("Solve for x", "x = \\frac{$(total_work)}{$(workers2)} = $(ans)")
            ),
            time=150
        )
        
    else
        # Partitioning problem with ratio (1500-1800)
        total_amount = randint(200, 800)
        ratio_a = randint(3, 9)
        ratio_b = randint(3, 9)
        ratio_c = randint(3, 9)
        ratio_sum = ratio_a + ratio_b + ratio_c
        
        # Ensure divisibility
        total_amount = (total_amount ÷ ratio_sum) * ratio_sum
        
        person_of_interest = choice([1, 2, 3])
        if person_of_interest == 1
            ans = (ratio_a * total_amount) ÷ ratio_sum
            person_name = "Alice"
        elseif person_of_interest == 2
            ans = (ratio_b * total_amount) ÷ ratio_sum
            person_name = "Bob"
        else
            ans = (ratio_c * total_amount) ÷ ratio_sum
            person_name = "Carol"
        end
        
        problem(
            question="Alice, Bob, and Carol share \$$(total_amount) in the ratio $(ratio_a):$(ratio_b):$(ratio_c). How much money does $(person_name) receive?",
            answer=ans,
            difficulty=(1500, 1800),
            solution=steps(
                "Total parts: $(ratio_a) + $(ratio_b) + $(ratio_c) = $(ratio_sum)",
                "Value per part: \$$(total_amount) ÷ $(ratio_sum) = \$$(total_amount ÷ ratio_sum)",
                sol("$(person_name)'s share", "\$$(total_amount ÷ ratio_sum) × $(person_of_interest == 1 ? ratio_a : person_of_interest == 2 ? ratio_b : ratio_c) = \$$(ans)")
            ),
            time=180
        )
    end
end