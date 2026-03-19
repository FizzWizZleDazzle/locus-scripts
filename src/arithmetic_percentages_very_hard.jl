# arithmetic - percentages (very_hard)
# Generated: 2026-03-08T19:50:38.482974

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/percentages")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Compound percentage problem with constraints (2500-2800)
        # A number is increased by p1%, then decreased by p2%, resulting in net change c%
        # Find relationship or solve for unknown
        
        p1 = randint(15, 45)
        p2 = randint(15, 45)
        
        # Net multiplier: (1 + p1/100)(1 - p2/100) = 1 + net_change/100
        net_multiplier = (100 + p1) * (100 - p2) // 10000
        net_change = net_multiplier - 1
        net_pct = round(Float64(net_change * 100), digits=2)
        
        # Ask: what initial value gives final value of F after these operations?
        final_val = randint(800, 2000)
        initial_val = round(Float64(final_val) / Float64(net_multiplier), digits=2)
        
        problem(
            question="A quantity is first increased by $(p1)%, then the result is decreased by $(p2)%. If the final value is $(final_val), what was the original value? (Round to 2 decimal places)",
            answer=initial_val,
            difficulty=(2500, 2800),
            solution=steps(
                "Let the original value be \\(x\\)",
                "After $(p1)% increase: \\(x \\cdot \\frac{$(100+p1)}{100}\\)",
                "After $(p2)% decrease: \\(x \\cdot \\frac{$(100+p1)}{100} \\cdot \\frac{$(100-p2)}{100} = x \\cdot \\frac{$((100+p1)*(100-p2))}{10000} = $(final_val)\\)",
                "Solving: \\(x = \\frac{$(final_val) \\cdot 10000}{$((100+p1)*(100-p2))} = $(initial_val)\\)"
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Percentage with algebraic constraint (2700-3000)
        # Find percentage such that specific algebraic condition holds
        
        base = randint(200, 800)
        target_diff = randint(50, 200)
        
        # Find p such that base * (1 + p/100) - base * (1 - p/100) = target_diff
        # base * 2p/100 = target_diff
        # p = 50 * target_diff / base
        
        ans_p = round(Float64(50 * target_diff) / Float64(base), digits=2)
        
        problem(
            question="What percent \\(p\\) satisfies the following condition: when $(base) is increased by \\(p\\)% and also decreased by \\(p\\)%, the difference between these two results equals $(target_diff)? (Round to 2 decimal places)",
            answer=ans_p,
            difficulty=(2700, 3000),
            solution=steps(
                "Let the percentage be \\(p\\)",
                "Increased value: \\($(base) \\cdot \\left(1 + \\frac{p}{100}\\right)\\)",
                "Decreased value: \\($(base) \\cdot \\left(1 - \\frac{p}{100}\\right)\\)",
                "Difference: \\($(base) \\cdot \\frac{2p}{100} = $(target_diff)\\)",
                "Solving: \\(p = \\frac{$(target_diff) \\cdot 100}{$(2*base)} = $(ans_p)\\)"
            ),
            time=270
        )
        
    elseif problem_type == 3
        # Multi-stage percentage problem (2800-3200)
        # Three consecutive percentage changes with constraint
        
        p1 = randint(10, 30)
        p2 = randint(10, 30)
        p3 = randint(10, 30)
        
        # Net multiplier
        m1 = 100 + p1
        m2 = 100 - p2
        m3 = 100 + p3
        net_mult = (m1 * m2 * m3) // 1000000
        
        # Choose final value, compute initial
        final_val = randint(500, 1500)
        initial_val = round(Float64(final_val * 1000000) / Float64(m1 * m2 * m3), digits=2)
        
        problem(
            question="A stock price undergoes three consecutive changes: first it increases by $(p1)%, then decreases by $(p2)%, then increases by $(p3)%. If the final price is \\\$$(final_val), what was the initial price? (Round to 2 decimal places)",
            answer=initial_val,
            difficulty=(2800, 3200),
            solution=steps(
                "Let initial price be \\(x\\)",
                "After first change: \\(x \\cdot \\frac{$(m1)}{100}\\)",
                "After second change: \\(x \\cdot \\frac{$(m1)}{100} \\cdot \\frac{$(m2)}{100}\\)",
                "After third change: \\(x \\cdot \\frac{$(m1) \\cdot $(m2) \\cdot $(m3)}{1000000} = $(final_val)\\)",
                "Solving: \\(x = \\frac{$(final_val) \\cdot 1000000}{$(m1 * m2 * m3)} = $(initial_val)\\)"
            ),
            time=300
        )
        
    else
        # Percentage inequality problem (3000-3400)
        # Find range of percentages satisfying compound condition
        
        base = randint(100, 500)
        lower_bound = randint(base + 50, base + 200)
        upper_bound = randint(lower_bound + 100, lower_bound + 300)
        
        # base * (1 + p1/100) * (1 + p2/100) must be in [lower_bound, upper_bound]
        # where p2 = 2*p1 (constraint)
        # base * (1 + p1/100)^2 * (1 + 2*p1/100) in range (approximately)
        
        # Simplified: find p such that base(1 + p/100)^2 is in range
        p_lower = round(100 * (sqrt(Float64(lower_bound) / Float64(base)) - 1), digits=2)
        p_upper = round(100 * (sqrt(Float64(upper_bound) / Float64(base)) - 1), digits=2)
        
        ans = fmt_interval(p_lower, p_upper, true, true)
        
        problem(
            question="A quantity of $(base) is increased by \\(p\\)% twice consecutively. For what values of \\(p\\) will the final result be between $(lower_bound) and $(upper_bound) inclusive? Express your answer as an interval \\([a, b]\\), rounding \\(a\\) and \\(b\\) to 2 decimal places.",
            answer=ans,
            answer_type="interval",
            difficulty=(3000, 3400),
            solution=steps(
                "After two \\(p\\)% increases: \\($(base) \\cdot \\left(1 + \\frac{p}{100}\\right)^2\\)",
                "Condition: \\($(lower_bound) \\leq $(base) \\cdot \\left(1 + \\frac{p}{100}\\right)^2 \\leq $(upper_bound)\\)",
                "Dividing by $(base): \\(\\frac{$(lower_bound)}{$(base)} \\leq \\left(1 + \\frac{p}{100}\\right)^2 \\leq \\frac{$(upper_bound)}{$(base)}\\)",
                "Taking square roots: \\(\\sqrt{\\frac{$(lower_bound)}{$(base)}} \\leq 1 + \\frac{p}{100} \\leq \\sqrt{\\frac{$(upper_bound)}{$(base)}}\\)",
                "Solving for \\(p\\): \\([$(p_lower), $(p_upper)]\\)"
            ),
            time=300
        )
    end
end