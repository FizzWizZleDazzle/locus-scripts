# arithmetic - ratios_proportions (very_easy)
# Generated: 2026-03-08T19:51:26.181676

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/ratios_proportions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple ratio recognition (ELO 100-300)
        a = randint(1, 10)
        b = randint(1, 10)
        ans = "$a:$b"
        
        problem(
            question="A bag contains $a red marbles and $b blue marbles. What is the ratio of red marbles to blue marbles?",
            answer=ans,
            difficulty=(150, 300),
            answer_type="text",
            solution=steps(
                "Count red marbles: $a",
                "Count blue marbles: $b",
                sol("Ratio red:blue", ans)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Simplify a ratio (ELO 300-500)
        gcd_val = randint(2, 6)
        a = gcd_val * randint(2, 8)
        b = gcd_val * randint(2, 8)
        ans_a = a ÷ gcd_val
        ans_b = b ÷ gcd_val
        ans = "$ans_a:$ans_b"
        
        problem(
            question="Simplify the ratio $a:$b to lowest terms.",
            answer=ans,
            difficulty=(300, 500),
            answer_type="text",
            solution=steps(
                "Find GCD of $a and $b: $gcd_val",
                "Divide both by $gcd_val: $(a÷gcd_val) : $(b÷gcd_val)",
                sol("Simplified ratio", ans)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Find missing value in proportion (ELO 400-600)
        a = randint(2, 12)
        b = randint(2, 12)
        k = randint(2, 8)
        c = a * k
        ans = b * k
        
        problem(
            question="Solve for x: \\frac{$a}{$b} = \\frac{$c}{x}",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                sol("Given proportion", "\\frac{$a}{$b} = \\frac{$c}{x}"),
                "Cross multiply: $(a)x = $(b) \\cdot $(c)",
                "Solve: x = \\frac{$(b*c)}{$a} = $ans"
            ),
            time=75
        )
        
    elseif problem_type == 4
        # Part-to-whole ratio (ELO 450-650)
        part = randint(2, 10)
        other_part = randint(2, 10)
        total = part + other_part
        ans = total
        
        problem(
            question="In a class, the ratio of boys to girls is $part:$other_part. If there are $(part) boys, how many total students are in the class?",
            answer=ans,
            difficulty=(450, 650),
            solution=steps(
                "Boys: $part",
                "Girls: $other_part",
                sol("Total students", "$part + $other_part = $ans")
            ),
            time=60
        )
        
    elseif problem_type == 5
        # Scale ratio problem (ELO 500-700)
        ratio_a = randint(2, 6)
        ratio_b = randint(2, 6)
        multiplier = randint(3, 12)
        given_val = ratio_a * multiplier
        ans = ratio_b * multiplier
        
        problem(
            question="Two quantities are in the ratio $ratio_a:$ratio_b. If the first quantity is $given_val, what is the second quantity?",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Ratio is $ratio_a:$ratio_b",
                "First quantity = $given_val = $ratio_a × $multiplier",
                sol("Second quantity", "$ratio_b × $multiplier = $ans")
            ),
            time=90
        )
        
    else
        # Divide quantity in given ratio (ELO 550-700)
        ratio_a = randint(2, 7)
        ratio_b = randint(2, 7)
        parts = ratio_a + ratio_b
        multiplier = randint(3, 10)
        total = parts * multiplier
        ans = ratio_a * multiplier
        
        problem(
            question="Divide $total into two parts in the ratio $ratio_a:$ratio_b. What is the larger part?",
            answer=max(ratio_a * multiplier, ratio_b * multiplier),
            difficulty=(550, 700),
            solution=steps(
                "Total parts in ratio: $ratio_a + $ratio_b = $parts",
                "Each part represents: $total ÷ $parts = $multiplier",
                sol("Larger part", "$(max(ratio_a, ratio_b)) × $multiplier = $(max(ratio_a * multiplier, ratio_b * multiplier))")
            ),
            time=90
        )
    end
end