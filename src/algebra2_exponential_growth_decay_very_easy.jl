# algebra2 - exponential_growth_decay (very_easy)
# Generated: 2026-03-08T20:18:14.606407

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/exponential_growth_decay")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Simple exponential evaluation (ELO 200-400)
        base = choice([2, 3, 4, 5])
        exponent = randint(0, 4)
        ans = base^exponent
        
        problem(
            question="Evaluate \$$(base)^{$(exponent)}\$",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", base^exponent),
                "Calculate: \$$(base)^{$(exponent)}\$",
                sol("Answer", ans)
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Identify growth vs decay (ELO 300-500)
        base_num = choice([2, 3, 5])
        base_denom = choice([2, 3, 4, 5])
        is_growth = base_num > base_denom
        
        if rand() < 0.5
            base_val = base_num
            ans = "growth"
        else
            base_val = Rational(base_num, base_denom)
            if base_num > base_denom
                ans = "growth"
            else
                ans = "decay"
            end
        end
        
        problem(
            question="Does \$y = $(base_val)^x\$ represent exponential growth or decay?",
            answer=ans,
            difficulty=(300, 500),
            answer_type="text",
            solution=steps(
                "Given: \$y = $(base_val)^x\$",
                "Base is $(base_val)",
                ans == "growth" ? "Since base > 1, this is exponential growth" : "Since 0 < base < 1, this is exponential decay"
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Simple growth/decay with initial value (ELO 400-600)
        initial = choice([10, 20, 50, 100, 200, 500])
        base = choice([2, 3])
        time_val = randint(1, 3)
        ans = initial * base^time_val
        
        problem(
            question="A population starts at $(initial) and doubles every year. What is the population after $(time_val) year$(time_val > 1 ? "s" : "")?",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Initial population: $(initial)",
                "Growth formula: \$P = $(initial) \\cdot 2^t\$",
                "After $(time_val) year$(time_val > 1 ? "s" : ""): \$P = $(initial) \\cdot 2^{$(time_val)} = $(initial) \\cdot $(2^time_val) = $(ans)\$"
            ),
            time=60
        )
        
    else
        # Evaluate exponential expression at a point (ELO 500-700)
        a = choice([2, 3, 4, 5, 10])
        b = choice([2, 3, 4])
        x_val = randint(0, 3)
        ans = a * b^x_val
        
        problem(
            question="Evaluate \$y = $(a) \\cdot $(b)^x\$ when \$x = $(x_val)\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", a * b^x),
                "Substitute \$x = $(x_val)\$",
                sol("Answer", ans)
            ),
            time=60
        )
    end
end