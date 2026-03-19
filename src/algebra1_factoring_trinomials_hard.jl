# algebra1 - factoring_trinomials (hard)
# Generated: 2026-03-08T20:00:40.411487

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_trinomials")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Expert level: Factor with larger coefficients and strategic grouping
        # ELO 1800-2000
        r1 = nonzero(-15, 15)
        r2 = nonzero(-15, 15)
        a = choice([2, 3, 4, 5, 6])
        
        expr = expand(a * (x - r1) * (x - r2))
        
        # Extract coefficients using coeff()
        A = Int(coeff(expr, x, 2))
        B = Int(coeff(expr, x, 1))
        C = Int(substitute(expr, x => 0))
        
        factored = a * (x - r1) * (x - r2)
        
        problem(
            question = "Factor completely: \$$(tex(expr))\$",
            answer = expr,
            difficulty = (1800, 2000),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Find two numbers that multiply to \$(A \\cdot C = $(A*C))\$ and add to \$B = $B\$",
                "The numbers are $(A*r1) and $(A*r2)",
                "Factor by grouping or use factored form",
                sol("Answer", factored)
            ),
            time = 180
        )
        
    elseif problem_type == 2
        # Competition entry: Non-monic with tricky coefficients
        # ELO 2000-2200
        a = choice([6, 8, 10, 12, 15])
        r1 = nonzero(-12, 12)
        r2 = nonzero(-12, 12)
        
        # Create (ax - b)(cx - d) where ac = leading coeff
        b1 = choice([2, 3, 4])
        b2 = a ÷ b1
        
        factor1 = b1 * x - b1 * r1
        factor2 = b2 * x - b2 * r2
        
        expr = expand(factor1 * factor2)
        
        problem(
            question = "Factor completely: \$$(tex(expr))\$",
            answer = expr,
            difficulty = (2000, 2200),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Leading coefficient is $(b1 * b2), constant term is $(b1*r1 * b2*r2)",
                "Use AC method: find factors of \$($(b1*b2) \\cdot $(b1*r1*b2*r2))\$ that add to middle coefficient",
                "Group terms and factor",
                sol("Answer", factor1 * factor2)
            ),
            time = 240
        )
        
    elseif problem_type == 3
        # Expert: Difference of squares disguised
        # ELO 1850-2050
        r = randint(3, 20)
        a = choice([1, 4, 9, 16])
        
        expr = expand(a * x^2 - r^2)
        factored = sqrt(a) * x - r * sqrt(a) * x + r
        
        problem(
            question = "Factor completely: \$$(tex(expr))\$",
            answer = expr,
            difficulty = (1850, 2050),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Recognize as difference of squares: \$(\\sqrt{$(a)}x)^2 - $(r)^2\$",
                "Apply \$a^2 - b^2 = (a-b)(a+b)\$",
                sol("Answer", (sqrt(a)*x - r)*(sqrt(a)*x + r))
            ),
            time = 150
        )
        
    elseif problem_type == 4
        # Competition: Factor then solve with constraint
        # ELO 2100-2300
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        while r1 == r2
            r2 = nonzero(-10, 10)
        end
        
        a = choice([2, 3, 4, 5])
        expr = expand(a * (x - r1) * (x - r2))
        
        # Ask for positive root only or root in range
        roots = sort([r1, r2])
        constraint_type = choice(1:2)
        
        if constraint_type == 1
            if r1 > 0 && r2 > 0
                ans = min(r1, r2)
                constraint = "Find the smallest positive solution"
            elseif r1 > 0 || r2 > 0
                ans = max(r1, r2)
                constraint = "Find the positive solution"
            else
                ans = max(r1, r2)
                constraint = "Find the largest solution"
            end
        else
            ans = max(r1, r2)
            constraint = "Find the larger solution"
        end
        
        problem(
            question = "Factor \$$(tex(expr)) = 0\$ and $constraint.",
            answer = ans,
            difficulty = (2100, 2300),
            solution = steps(
                sol("Given", expr ~ 0),
                "Factor: \$$(tex(a*(x - r1)*(x - r2))) = 0\$",
                "Solutions are \$x = $r1\$ and \$x = $r2\$",
                sol("Answer", ans)
            ),
            time = 200
        )
        
    else
        # Expert: Perfect square trinomial with coefficient
        # ELO 1900-2100
        r = nonzero(-12, 12)
        a = choice([1, 4, 9])
        
        expr = expand(a * (x - r)^2)
        
        problem(
            question = "Factor completely: \$$(tex(expr))\$",
            answer = expr,
            difficulty = (1900, 2100),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Recognize as perfect square trinomial",
                "Middle term is \$2 \\cdot \\sqrt{$(a)} \\cdot x \\cdot $(r)\$",
                sol("Answer", a*(x - r)^2)
            ),
            time = 180
        )
    end
end