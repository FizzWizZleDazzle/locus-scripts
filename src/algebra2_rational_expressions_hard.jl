# algebra2 - rational_expressions (hard)
# Generated: 2026-03-08T20:15:45.417115

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/rational_expressions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simplify rational expression with polynomial factoring
        r1, r2 = nonzero(-8, 8), nonzero(-8, 8)
        r3 = nonzero(-8, 8)
        while r3 == r1 || r3 == r2
            r3 = nonzero(-8, 8)
        end
        
        numerator = expand((x - r1) * (x - r2))
        denominator = expand((x - r1) * (x - r3))
        
        simplified_num = x - r2
        simplified_den = x - r3
        
        ans = simplified_num / simplified_den
        
        problem(
            question="Simplify the rational expression: \$\\frac{$(tex(numerator))}{$(tex(denominator))}\$",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor numerator: \$$(tex((x - r1) * (x - r2)))\$",
                "Factor denominator: \$$(tex((x - r1) * (x - r3)))\$",
                "Cancel common factor \$(x - $(r1))\$",
                sol("Answer", ans),
                "Restriction: \$x \\neq $(r1), $(r3)\$"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Add/subtract rational expressions with different denominators
        r1, r2 = nonzero(-10, 10), nonzero(-10, 10)
        while r2 == r1
            r2 = nonzero(-10, 10)
        end
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # a/(x-r1) + b/(x-r2)
        num1 = a
        den1 = x - r1
        num2 = b
        den2 = x - r2
        
        # Common denominator: (x-r1)(x-r2)
        common_den = expand((x - r1) * (x - r2))
        combined_num = expand(a * (x - r2) + b * (x - r1))
        
        ans = combined_num / common_den
        
        operation = choice(["+", "-"])
        if operation == "-"
            num2 = -b
            combined_num = expand(a * (x - r2) - b * (x - r1))
            ans = combined_num / common_den
        end
        
        problem(
            question="Simplify: \$\\frac{$(a)}{$(tex(den1))} $(operation) \\frac{$(abs(b))}{$(tex(den2))}\$",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Find common denominator: \$$(tex(common_den))\$",
                "Rewrite first fraction: \$\\frac{$(a) \\cdot $(tex(x - r2))}{$(tex(common_den))}\$",
                "Rewrite second fraction: \$\\frac{$(operation == "+" ? b : -b) \\cdot $(tex(x - r1))}{$(tex(common_den))}\$",
                "Combine numerators: \$$(tex(combined_num))\$",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Solve rational equation
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        while r2 == r1
            r2 = nonzero(-10, 10)
        end
        
        ans = nonzero(-15, 15)
        while ans == r1 || ans == r2
            ans = nonzero(-15, 15)
        end
        
        a = nonzero(-6, 6)
        # a/(x-r1) = (x-r2)/(x-r1)
        # Cross multiply: a(x-r1) = (x-r2)(x-r1)
        # We want solution to be ans
        # So: a = x - r2 evaluated at x = ans
        a = ans - r2
        
        lhs = a / (x - r1)
        rhs = (x - r2) / (x - r1)
        
        problem(
            question="Solve for x: \$\\frac{$(a)}{$(tex(x - r1))} = \\frac{$(tex(x - r2))}{$(tex(x - r1))}\$",
            answer=ans,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Since denominators are equal, numerators must be equal",
                sol(a ~ (x - r2)),
                "Solve for x: \$x = $(a + r2)\$",
                "Check: \$x \\neq $(r1)\$ (restriction)",
                sol("Answer", ans)
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Complex fraction simplification
        r1, r2 = nonzero(-7, 7), nonzero(-7, 7)
        while r2 == r1
            r2 = nonzero(-7, 7)
        end
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # (a + b/x) / (1 - r1/x) = (ax + b) / (x - r1)
        numerator_top = a*x + b
        numerator_bottom = x - r1
        
        ans = numerator_top / numerator_bottom
        
        problem(
            question="Simplify the complex fraction: \$\\frac{$(a) + \\frac{$(b)}{x}}{1 - \\frac{$(r1)}{x}}\$",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "Multiply numerator and denominator by \$x\$",
                "Numerator becomes: \$$(a)x + $(b)\$",
                "Denominator becomes: \$x - $(r1)\$",
                sol("Answer", ans),
                "Restriction: \$x \\neq 0, $(r1)\$"
            ),
            time=220
        )
        
    else
        # Rational function domain with multiple restrictions
        r1 = nonzero(-12, 12)
        r2 = nonzero(-12, 12)
        while r2 == r1
            r2 = nonzero(-12, 12)
        end
        r3 = nonzero(-12, 12)
        while r3 == r1 || r3 == r2
            r3 = nonzero(-12, 12)
        end
        
        # Function: (x - r3) / [(x - r1)(x - r2)]
        numerator = x - r3
        denominator = expand((x - r1) * (x - r2))
        
        restrictions = sort([r1, r2])
        
        # Domain is all reals except r1, r2
        ans = "(-\\infty, $(restrictions[1])) \\cup ($(restrictions[1]), $(restrictions[2])) \\cup ($(restrictions[2]), \\infty)"
        
        problem(
            question="Find the domain of \$f(x) = \\frac{$(tex(numerator))}{$(tex(denominator))}\$. Express in interval notation.",
            answer=ans,
            difficulty=(2100, 2300),
            answer_type="interval",
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor denominator: \$$(tex((x - r1) * (x - r2)))\$",
                "Denominator equals zero when \$x = $(r1)\$ or \$x = $(r2)\$",
                "These values must be excluded from the domain",
                sol("Domain", ans)
            ),
            time=180
        )
    end
end