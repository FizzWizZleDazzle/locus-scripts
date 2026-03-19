# algebra2 - rational_expressions (medium)
# Generated: 2026-03-08T20:15:49.013458

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_expressions")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # Simplify rational expression by factoring
        r1, r2 = nonzero(-8, 8), nonzero(-8, 8)
        for _attempt in 1:1000
            r1 == r2 || break
            r2 = nonzero(-8, 8)
        end
        common_factor = nonzero(-5, 5)
        
        num = expand(common_factor * (x - r1) * (x - r2))
        denom = expand(common_factor * (x - r1))
        
        ans = simplify((x - r2))
        
        problem(
            question="Simplify the rational expression: \$\\frac{$(tex(num))}{$(tex(denom))}\$. State any restrictions on \$x\$.",
            answer="$(tex(ans)), x ≠ $(r1)",
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", num // denom),
                "Factor numerator: \$$(tex(common_factor*(x - r1)*(x - r2)))\$",
                "Factor denominator: \$$(tex(common_factor*(x - r1)))\$",
                "Cancel common factor \$(tex((x - r1)))\$, noting \$x \\neq $(r1)\$",
                sol("Simplified", ans)
            ),
            time=120
        )
        
    elseif prob_type == 2
        # Add/subtract rational expressions with different denominators
        r1 = nonzero(-6, 6)
        r2 = nonzero(-6, 6)
        for _attempt in 1:1000
            (r1 == r2 || r1 == -r2) || break
            r2 = nonzero(-6, 6)
        end
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # LCD is (x - r1)(x - r2)
        num1 = a
        denom1 = x - r1
        num2 = b
        denom2 = x - r2
        
        # Result: [a(x-r2) + b(x-r1)] / [(x-r1)(x-r2)]
        result_num = expand(a*(x - r2) + b*(x - r1))
        result_denom = expand((x - r1)*(x - r2))
        
        operation = rand(["+", "-"])
        if operation == "-"
            result_num = expand(a*(x - r2) - b*(x - r1))
            num2_display = b
        else
            num2_display = b
        end
        
        problem(
            question="Add the rational expressions and simplify: \$\\frac{$(a)}{$(tex(denom1))} $(operation) \\frac{$(num2_display)}{$(tex(denom2))}\$",
            answer=result_num // result_denom,
            difficulty=(1400, 1600),
            solution=steps(
                "Find LCD: \$$(tex(result_denom))\$",
                "Multiply first fraction by \$\\frac{$(tex(x - r2))}{$(tex(x - r2))}\$: \$\\frac{$(tex(a*(x - r2)))}{$(tex(result_denom))}\$",
                "Multiply second fraction by \$\\frac{$(tex(x - r1))}{$(tex(x - r1))}\$: \$\\frac{$(tex(b*(x - r1)))}{$(tex(result_denom))}\$",
                operation == "+" ? "Add numerators: \$$(tex(result_num))\$" : "Subtract numerators: \$$(tex(result_num))\$",
                sol("Answer", result_num // result_denom)
            ),
            time=180
        )
        
    elseif prob_type == 3
        # Solve rational equation
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        # Create equation: a/(x+b) = c
        # Solution: a = c(x+b), x = a/c - b
        if c != 0
            ans = a // c - b
            
            problem(
                question="Solve for \$x\$: \$\\frac{$(a)}{x + $(b)} = $(c)\$",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", a // (x + b) ~ c),
                    "Multiply both sides by \$(tex(x + b))\$: \$$(a) = $(c)(x + $(b))\$",
                    "Expand: \$$(a) = $(tex(expand(c*x + c*b)))\$",
                    "Solve for \$x\$",
                    sol("Answer", ans)
                ),
                time=120
            )
        else
            # Fallback
            ans = randint(-10, 10)
            problem(
                question="Solve for \$x\$: \$\\frac{$(a)}{x + $(b)} = \\frac{$(a)}{$(ans + b)}\$",
                answer=ans,
                difficulty=(1000, 1200),
                solution=steps(
                    "Since numerators are equal and non-zero, denominators must be equal",
                    sol("Set denominators equal", x + b ~ ans + b),
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    elseif prob_type == 4
        # Multiply rational expressions
        r1 = nonzero(-7, 7)
        r2 = nonzero(-7, 7)
        r3 = nonzero(-7, 7)
        for _attempt in 1:1000
            (r2 == r1 || r3 == r1 || r3 == r2) || break
            r3 = nonzero(-7, 7)
        end
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # (x - r1) / (x - r2) * (x - r3) / (x - r1) = (x - r3) / (x - r2)
        ans_num = x - r3
        ans_denom = x - r2
        
        problem(
            question="Multiply and simplify: \$\\frac{x - $(r1)}{x - $(r2)} \\cdot \\frac{x - $(r3)}{x - $(r1)}\$. State restrictions.",
            answer="$(tex(ans_num // ans_denom)), x ≠ $(r1), $(r2)",
            difficulty=(1300, 1500),
            solution=steps(
                "Multiply numerators and denominators",
                sol("Product", (x - r1)*(x - r3) // ((x - r2)*(x - r1))),
                "Cancel common factor \$(tex(x - r1))\$, noting \$x \\neq $(r1)\$",
                "Restrictions: \$x \\neq $(r1), $(r2)\$",
                sol("Simplified", ans_num // ans_denom)
            ),
            time=150
        )
        
    else
        # Complex fraction
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-6, 6)
        
        # Simplify: (a/x) / (b/x + c) = a / (b + cx)
        ans_num = a
        ans_denom = expand(b + c*x)
        
        problem(
            question="Simplify the complex fraction: \$\\frac{\\frac{$(a)}{x}}{\\frac{$(b)}{x} + $(c)}\$",
            answer=ans_num // ans_denom,
            difficulty=(1500, 1700),
            solution=steps(
                "Rewrite denominator with common denominator \$x\$: \$\\frac{$(b)}{x} + $(c) = \\frac{$(b) + $(c)x}{x}\$",
                "Rewrite as division: \$\\frac{$(a)}{x} \\div \\frac{$(tex(ans_denom))}{x}\$",
                "Multiply by reciprocal: \$\\frac{$(a)}{x} \\cdot \\frac{x}{$(tex(ans_denom))}\$",
                "Cancel \$x\$",
                sol("Answer", ans_num // ans_denom)
            ),
            time=180
        )
    end
end