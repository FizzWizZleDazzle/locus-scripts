# algebra1 - factoring_trinomials (medium)
# Generated: 2026-03-08T20:00:36.602912

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_trinomials")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple factorable trinomial: (x + a)(x + b) = x^2 + (a+b)x + ab
        # ELO: 1200-1400 (textbook factoring)
        r1 = nonzero(-12, 12)
        r2 = nonzero(-12, 12)
        expr = expand((x - r1) * (x - r2))
        
        problem(
            question="Factor the trinomial: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(1200, 1400),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Find two numbers that multiply to $(r1 * r2) and add to $(-(r1 + r2))",
                "The numbers are $(r1) and $(r2)",
                sol("Factored form", (x - r1) * (x - r2))
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Leading coefficient a ≠ 1: a(x - r1)(x - r2)
        # ELO: 1400-1600 (requires more strategic thinking)
        a = choice([2, 3, 4, 5, 6])
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        expr = expand(a * (x - r1) * (x - r2))
        
        problem(
            question="Factor completely: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(1400, 1600),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Factor out the GCF of $(a)",
                "Inside the parentheses, find factors of $(r1 * r2) that add to $(-(r1 + r2))",
                "The roots are $(r1) and $(r2)",
                sol("Factored form", a * (x - r1) * (x - r2))
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Perfect square trinomial: (x ± a)^2
        # ELO: 1300-1500 (recognize pattern)
        a = nonzero(-15, 15)
        expr = expand((x - a)^2)
        
        problem(
            question="Factor the perfect square trinomial: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(1300, 1500),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Recognize this is a perfect square: first term is \$x^2\$, last term is \$$(a^2)\$ which is \$($(abs(a)))^2\$",
                "Check middle term: \$2 \\cdot x \\cdot $(abs(a)) = $(2*abs(a))x\$",
                sol("Factored form", (x - a)^2)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Difference of squares disguised as trinomial with b=0
        # ELO: 1350-1550
        a = choice([4, 9, 16, 25, 36, 49, 64])
        root_a = isqrt(a)
        c_val = nonzero(-20, 20)
        while c_val^2 == a
            c_val = nonzero(-20, 20)
        end
        
        # Create ax^2 + c where we can factor out leading coefficient
        lead = choice([1, 2, 3, 4])
        r_sq = nonzero(-10, 10)
        expr = expand(lead * (x^2 - r_sq^2))
        
        problem(
            question="Factor completely: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(1350, 1550),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                lead > 1 ? "Factor out $(lead)" : "Recognize difference of squares pattern",
                "Apply \$a^2 - b^2 = (a-b)(a+b)\$ with \$a = x\$ and \$b = $(abs(r_sq))\$",
                sol("Factored form", lead * (x - r_sq) * (x + r_sq))
            ),
            time=150
        )
        
    else
        # Mixed problem: factor after grouping or challenging coefficients
        # ELO: 1500-1700
        a = choice([2, 3, 5, 6])
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        
        # Make sure it's genuinely harder
        while abs(r1) <= 2 && abs(r2) <= 2
            r1 = nonzero(-8, 8)
            r2 = nonzero(-8, 8)
        end
        
        expr = expand(a * (x - r1) * (x - r2))
        
        # Extract coefficients for solution explanation
        coeff_x2 = a
        coeff_x = -a * (r1 + r2)
        coeff_const = a * r1 * r2
        
        problem(
            question="Factor completely: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(1500, 1700),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Factor out GCF of $(a): \$$(a)(x^2 + $(tex(Num(-r1-r2)))x + $(r1*r2))\$",
                "For the quadratic inside, find two numbers that multiply to $(r1*r2) and add to $(-(r1+r2))",
                "These numbers are $(r1) and $(r2)",
                sol("Factored form", a * (x - r1) * (x - r2))
            ),
            time=210
        )
    end
end