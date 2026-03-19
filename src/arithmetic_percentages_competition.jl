# arithmetic - percentages (competition)
# Generated: 2026-03-08T19:50:46.218694

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z n begin
    set_topic!("arithmetic/percentages")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Compound percentage problem with nested operations
        P = randint(10000, 100000)
        r1 = randint(15, 45)
        r2 = randint(10, 35)
        r3 = randint(5, 25)
        n_years = randint(8, 20)
        
        # First n_years with r1%, then decrease by r2%, then increase by r3%
        A1 = P * (1 + r1/100)^n_years
        A2 = A1 * (1 - r2/100)
        A3 = A2 * (1 + r3/100)
        
        ans = round(Int, A3)
        
        problem(
            question="An investment of \\\$$(P) grows at $(r1)% per year for $(n_years) years. It then decreases by $(r2)%, and finally increases by $(r3)%. What is the final value (rounded to the nearest dollar)?",
            answer=ans,
            difficulty=(3500, 3800),
            solution=steps(
                "Initial investment: \\\$$(P)",
                sol("After $(n_years) years at $(r1)%", "$(P) \\times (1 + $(r1)/100)^{$(n_years)} = $(round(Int, A1))"),
                sol("After $(r2)% decrease", "$(round(Int, A1)) \\times (1 - $(r2)/100) = $(round(Int, A2))"),
                sol("After $(r3)% increase", "$(round(Int, A2)) \\times (1 + $(r3)/100) = $(ans)"),
                "Final value: \\\$$(ans)"
            ),
            time=240,
            calculator="scientific"
        )
    elseif problem_type == 2
        # Percentage change optimization
        base = randint(500, 2000)
        target_ratio = rand([3//2, 5//3, 7//4, 9//5, 11//6])
        target = round(Int, base * target_ratio)
        
        # Find minimum number of equal percentage increases to exceed target
        pct = randint(8, 18)
        
        n_steps = 0
        current = base
        while current < target
            current = current * (1 + pct/100)
            n_steps += 1
        end
        
        ans = n_steps
        
        problem(
            question="A quantity starts at $(base). What is the minimum number of successive $(pct)% increases needed for the quantity to exceed $(target)?",
            answer=ans,
            difficulty=(3600, 3900),
            solution=steps(
                "Initial value: $(base), Target: > $(target)",
                "After n increases: $(base) × (1 + $(pct)/100)^n > $(target)",
                "Solve: (1.$(lpad(pct, 2, '0')))^n > $(Float64(target_ratio))",
                "Taking logarithms: n > log($(Float64(target_ratio))) / log(1.$(lpad(pct, 2, '0')))",
                sol("Minimum n", ans)
            ),
            time=270,
            calculator="scientific"
        )
    elseif problem_type == 3
        # Reverse percentage problem with constraints
        final_val = randint(800, 3000)
        pct1 = randint(20, 50)
        pct2 = randint(15, 40)
        
        # After increase by pct1%, then decrease by pct2%, we get final_val
        # x * (1 + pct1/100) * (1 - pct2/100) = final_val
        original = final_val / ((1 + pct1/100) * (1 - pct2/100))
        ans = round(Int, original)
        
        problem(
            question="A number is increased by $(pct1)%, then decreased by $(pct2)%, resulting in $(final_val). What was the original number (rounded to the nearest integer)?",
            answer=ans,
            difficulty=(3700, 4000),
            solution=steps(
                "Let the original number be x",
                sol("After $(pct1)% increase", "x \\times (1 + $(pct1)/100) = x \\times $(1 + pct1/100)"),
                sol("After $(pct2)% decrease", "x \\times $(1 + pct1/100) \\times $(1 - pct2/100) = $(final_val)"),
                "Solve: x × $((1 + pct1/100) * (1 - pct2/100)) = $(final_val)",
                sol("Original number", ans)
            ),
            time=240,
            calculator="scientific"
        )
    elseif problem_type == 4
        # Percentage mixture problem
        total = randint(1000, 5000)
        pct_A = randint(15, 45)
        pct_B = randint(50, 85)
        target_pct = randint(pct_A + 5, pct_B - 5)
        
        # x liters at pct_A%, (total-x) liters at pct_B%, mixture at target_pct%
        # (x * pct_A + (total-x) * pct_B) / total = target_pct
        # x * pct_A + total * pct_B - x * pct_B = total * target_pct
        # x * (pct_A - pct_B) = total * (target_pct - pct_B)
        x = total * (target_pct - pct_B) / (pct_A - pct_B)
        ans = round(Int, x)
        
        problem(
            question="A chemist has two solutions: one is $(pct_A)% acid, the other is $(pct_B)% acid. How many liters of the $(pct_A)% solution must be mixed with the $(pct_B)% solution to create $(total) liters of a $(target_pct)% acid solution? Round to the nearest liter.",
            answer=ans,
            difficulty=(3800, 4200),
            solution=steps(
                "Let x = liters of $(pct_A)% solution, then $(total) - x = liters of $(pct_B)% solution",
                sol("Acid equation", "\\frac{$(pct_A)x + $(pct_B)($(total) - x)}{$(total)} = $(target_pct)"),
                "Simplify: $(pct_A)x + $(pct_B * total) - $(pct_B)x = $(target_pct * total)",
                "$(pct_A - pct_B)x = $(target_pct * total - pct_B * total)",
                sol("Solution", "x = $(ans) \\text{ liters}")
            ),
            time=300,
            calculator="scientific"
        )
    else
        # Multi-stage percentage growth/decay with exponents
        P = randint(5000, 25000)
        r_growth = randint(12, 28)
        years_growth = randint(5, 12)
        r_decay = randint(8, 20)
        years_decay = randint(4, 10)
        r_final = randint(5, 15)
        years_final = randint(3, 8)
        
        A1 = P * (1 + r_growth/100)^years_growth
        A2 = A1 * (1 - r_decay/100)^years_decay
        A3 = A2 * (1 + r_final/100)^years_final
        
        ans = round(Int, A3)
        
        problem(
            question="A population starts at $(P). It grows at $(r_growth)% per year for $(years_growth) years, then decays at $(r_decay)% per year for $(years_decay) years, then grows at $(r_final)% per year for $(years_final) years. What is the final population (rounded to the nearest integer)?",
            answer=ans,
            difficulty=(3900, 4400),
            solution=steps(
                "Initial population: $(P)",
                sol("After growth phase", "$(P) \\times (1.$(lpad(r_growth, 2, '0')))^{$(years_growth)} \\approx $(round(Int, A1))"),
                sol("After decay phase", "$(round(Int, A1)) \\times (1 - 0.$(lpad(r_decay, 2, '0')))^{$(years_decay)} \\approx $(round(Int, A2))"),
                sol("After final growth", "$(round(Int, A2)) \\times (1.$(lpad(r_final, 2, '0')))^{$(years_final)} \\approx $(ans)"),
                "Final population: $(ans)"
            ),
            time=300,
            calculator="scientific"
        )
    end
end