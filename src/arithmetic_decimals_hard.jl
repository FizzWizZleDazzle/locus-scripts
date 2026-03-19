# arithmetic - decimals (hard)
# Generated: 2026-03-08T19:49:40.864315

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("arithmetic/decimals")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Decimal equation with strategic manipulation (ELO 1800-2000)
        a = round(rand() * 9 + 1, digits=2)
        b = round(rand() * 15 + 5, digits=2)
        c = round(rand() * 20 + 10, digits=2)
        
        ans = round((c - b) / a, digits=3)
        
        problem(
            question="Solve for x: \$$(a)x + $(b) = $(c)\$",
            answer=ans,
            difficulty=(1800, 1950),
            solution=steps(
                sol("Given", "$(a)x + $(b) = $(c)"),
                "Subtract $(b) from both sides: \$$(a)x = $(round(c - b, digits=2))\$",
                "Divide both sides by $(a)",
                sol("Answer", "x = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Complex decimal fraction chain (ELO 1900-2100)
        d1 = round(rand() * 8 + 2, digits=2)
        d2 = round(rand() * 6 + 1, digits=2)
        d3 = round(rand() * 10 + 5, digits=2)
        d4 = round(rand() * 4 + 1, digits=2)
        
        ans = round((d1 * d2 + d3) / d4, digits=4)
        
        problem(
            question="Calculate: \$\\frac{$(d1) \\times $(d2) + $(d3)}{$(d4)}\$",
            answer=ans,
            difficulty=(1900, 2050),
            solution=steps(
                "First compute the numerator: \$$(d1) \\times $(d2) = $(round(d1 * d2, digits=2))\$",
                "Add to get: \$$(round(d1 * d2, digits=2)) + $(d3) = $(round(d1 * d2 + d3, digits=2))\$",
                "Divide by denominator: \$\\frac{$(round(d1 * d2 + d3, digits=2))}{$(d4)}\$",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Decimal system of equations (ELO 2000-2200)
        x_ans = round(rand() * 15 + 3, digits=2)
        y_ans = round(rand() * 12 + 2, digits=2)
        
        a1 = round(rand() * 4 + 1, digits=1)
        b1 = round(rand() * 3 + 1, digits=1)
        c1 = round(a1 * x_ans + b1 * y_ans, digits=2)
        
        a2 = round(rand() * 3 + 1, digits=1)
        b2 = round(rand() * 4 + 1, digits=1)
        c2 = round(a2 * x_ans + b2 * y_ans, digits=2)
        
        problem(
            question="Solve the system: \$$(a1)x + $(b1)y = $(c1)\$ and \$$(a2)x + $(b2)y = $(c2)\$. What is x?",
            answer=x_ans,
            difficulty=(2000, 2200),
            solution=steps(
                sol("System", "$(a1)x + $(b1)y = $(c1), \\quad $(a2)x + $(b2)y = $(c2)"),
                "Multiply first equation by $(a2) and second by $(a1) to eliminate x",
                "After elimination and substitution: \$y = $(y_ans)\$",
                "Substitute back to find x",
                sol("Answer", "x = $(x_ans)")
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Decimal percentage compound problem (ELO 1850-2050)
        principal = round(rand() * 5000 + 1000, digits=2)
        rate = round(rand() * 0.08 + 0.02, digits=4)
        time_years = rand(3:8)
        
        ans = round(principal * (1 + rate)^time_years, digits=2)
        
        problem(
            question="An investment of \$$(principal) grows at $(round(rate * 100, digits=2))% per year compounded annually for $(time_years) years. What is the final amount?",
            answer=ans,
            difficulty=(1850, 2000),
            solution=steps(
                sol("Formula", "A = P(1 + r)^t"),
                "Substitute: \$A = $(principal)(1 + $(rate))^{$(time_years)}\$",
                "Calculate: \$A = $(principal) \\times $(round((1 + rate)^time_years, digits=6))\$",
                sol("Answer", "\$$(ans)")
            ),
            time=150,
            calculator="scientific"
        )
        
    else
        # Decimal ratio optimization (ELO 2100-2400)
        target = round(rand() * 50 + 20, digits=2)
        ratio_a = round(rand() * 3 + 1, digits=2)
        ratio_b = round(rand() * 2 + 1, digits=2)
        
        x_ans = round(target / (ratio_a + ratio_b), digits=3)
        part_a = round(ratio_a * x_ans, digits=3)
        part_b = round(ratio_b * x_ans, digits=3)
        
        problem(
            question="Two quantities in ratio \$$(ratio_a):$(ratio_b)\$ sum to $(target). Find the smaller quantity.",
            answer=min(part_a, part_b),
            difficulty=(2100, 2300),
            solution=steps(
                sol("Setup", "Let parts be $(ratio_a)x and $(ratio_b)x"),
                "Total: \$$(ratio_a)x + $(ratio_b)x = $(target)\$",
                "Simplify: \$$(round(ratio_a + ratio_b, digits=2))x = $(target)\$",
                "Solve: \$x = $(x_ans)\$",
                "Parts are $(part_a) and $(part_b)",
                sol("Answer", min(part_a, part_b))
            ),
            time=180
        )
    end
end