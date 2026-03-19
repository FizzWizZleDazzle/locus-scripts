# arithmetic - ratios_proportions (easy)
# Generated: 2026-03-08T19:51:32.041224

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/ratios_proportions")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Simple ratio simplification (700-850 ELO)
        a = randint(2, 12)
        b = randint(2, 12)
        scale = randint(2, 8)
        given_a = a * scale
        given_b = b * scale
        g = gcd(given_a, given_b)
        simp_a = given_a ÷ g
        simp_b = given_b ÷ g
        
        problem(
            question="Simplify the ratio \\\$$(given_a):$(given_b)\\\$ to lowest terms.",
            answer="$(simp_a):$(simp_b)",
            difficulty=(700, 850),
            answer_type="text",
            solution=steps(
                "Given ratio: \\\$$(given_a):$(given_b)\\\$",
                "Find GCD of $(given_a) and $(given_b): GCD = $(g)",
                "Divide both terms by $(g): \\\$\\frac{$(given_a)}{$(g)}:\\frac{$(given_b)}{$(g)} = $(simp_a):$(simp_b)\\\$"
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Solving proportion with one unknown (750-950 ELO)
        a = nonzero(-15, 15)
        b = nonzero(-15, 15)
        c = nonzero(-15, 15)
        x_val = (b * c) // a
        
        if denominator(x_val) == 1
            ans = numerator(x_val)
        else
            ans = x_val
        end
        
        problem(
            question="Solve for \\\$x\\\$: \\\$\\frac{$(a)}{$(b)} = \\frac{$(c)}{x}\\\$",
            answer=ans,
            difficulty=(750, 950),
            solution=steps(
                "Given proportion: \\\$\\frac{$(a)}{$(b)} = \\frac{$(c)}{x}\\\$",
                "Cross multiply: \\\$$(a) \\cdot x = $(b) \\cdot $(c)\\\$",
                "Simplify: \\\$$(a)x = $(b * c)\\\$",
                "Divide by $(a): \\\$x = \\frac{$(b * c)}{$(a)} = $(ans)\\\$"
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Ratio word problem - sharing/dividing (850-1050 ELO)
        ratio_a = randint(2, 7)
        ratio_b = randint(2, 7)
        total_units = ratio_a + ratio_b
        scale = randint(5, 20)
        total = total_units * scale
        
        share_a = ratio_a * scale
        share_b = ratio_b * scale
        
        names = choice([("Alice", "Bob"), ("Maria", "John"), ("Sam", "Taylor"), ("Alex", "Jordan")])
        
        problem(
            question="$(names[1]) and $(names[2]) share \\\$$(total) in the ratio \\\$$(ratio_a):$(ratio_b)\\\$. How much money does $(names[1]) receive?",
            answer=share_a,
            difficulty=(850, 1050),
            solution=steps(
                "Ratio $(names[1]):$(names[2]) = \\\$$(ratio_a):$(ratio_b)\\\$",
                "Total parts = \\\$$(ratio_a) + $(ratio_b) = $(total_units)\\\$ parts",
                "Value per part = \\\$\\frac{\\\$$(total)}{$(total_units)} = \\\$$(scale)\\\$",
                "$(names[1])'s share = \\\$$(ratio_a) \\times \\\$$(scale) = \\\$$(share_a)\\\$"
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Finding missing term in proportion (800-1000 ELO)
        a = nonzero(2, 20)
        b = nonzero(2, 20)
        c = nonzero(2, 20)
        x_val = (a * c) // b
        
        if denominator(x_val) == 1
            ans = numerator(x_val)
        else
            ans = x_val
        end
        
        problem(
            question="If \\\$\\frac{x}{$(c)} = \\frac{$(a)}{$(b)}\\\$, find the value of \\\$x\\\$.",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Given proportion: \\\$\\frac{x}{$(c)} = \\frac{$(a)}{$(b)}\\\$",
                "Cross multiply: \\\$x \\cdot $(b) = $(a) \\cdot $(c)\\\$",
                "Simplify: \\\$$(b)x = $(a * c)\\\$",
                "Divide by $(b): \\\$x = \\frac{$(a * c)}{$(b)} = $(ans)\\\$"
            ),
            time=90
        )
        
    else
        # Part-to-whole ratio problem (900-1200 ELO)
        part_ratio = randint(3, 12)
        whole_ratio = randint(part_ratio + 2, 25)
        actual_part = randint(10, 50)
        scale = actual_part // part_ratio
        
        if denominator(scale) == 1
            actual_whole = whole_ratio * numerator(scale)
            ans = actual_whole
        else
            actual_whole = whole_ratio * scale
            ans = actual_whole
        end
        
        items = choice(["students", "books", "apples", "coins", "marbles"])
        
        problem(
            question="In a collection, the ratio of red $(items) to total $(items) is \\\$$(part_ratio):$(whole_ratio)\\\$. If there are $(actual_part) red $(items), how many $(items) are there in total?",
            answer=ans,
            difficulty=(900, 1200),
            solution=steps(
                "Ratio red:total = \\\$$(part_ratio):$(whole_ratio)\\\$",
                "Set up proportion: \\\$\\frac{$(part_ratio)}{$(whole_ratio)} = \\frac{$(actual_part)}{x}\\\$",
                "Cross multiply: \\\$$(part_ratio) \\cdot x = $(whole_ratio) \\cdot $(actual_part)\\\$",
                "Solve: \\\$x = \\frac{$(whole_ratio * actual_part)}{$(part_ratio)} = $(ans)\\\$"
            ),
            time=120
        )
    end
end