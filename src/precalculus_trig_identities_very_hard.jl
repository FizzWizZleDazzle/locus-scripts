# precalculus - trig_identities (very_hard)
# Generated: 2026-03-08T20:29:50.819388

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/trig_identities")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Complex identity proving problem (2500-2900 ELO)
        # Prove an identity involving multiple angle formulas
        
        k = rand(2:4)
        angles = ["\\alpha", "\\beta", "\\gamma", "\\theta"]
        angle_choice = choice(angles)
        
        # Generate a non-trivial identity
        identity_type = rand(1:3)
        
        if identity_type == 1
            # Prove: sin(3θ) = 3sin(θ) - 4sin³(θ)
            lhs_tex = "\\sin(3$(angle_choice))"
            rhs_tex = "3\\sin($(angle_choice)) - 4\\sin^3($(angle_choice))"
            
            solution_text = steps(
                "Start with the left-hand side: \$\\sin(3$(angle_choice))\$",
                "Use angle addition: \$\\sin(3$(angle_choice)) = \\sin(2$(angle_choice) + $(angle_choice))\$",
                "Apply \$\\sin(A+B) = \\sin A \\cos B + \\cos A \\sin B\$:",
                "\$= \\sin(2$(angle_choice))\\cos($(angle_choice)) + \\cos(2$(angle_choice))\\sin($(angle_choice))\$",
                "Substitute \$\\sin(2$(angle_choice)) = 2\\sin($(angle_choice))\\cos($(angle_choice))\$ and \$\\cos(2$(angle_choice)) = 1 - 2\\sin^2($(angle_choice))\$:",
                "\$= 2\\sin($(angle_choice))\\cos^2($(angle_choice)) + (1-2\\sin^2($(angle_choice)))\\sin($(angle_choice))\$",
                "Expand: \$= 2\\sin($(angle_choice))\\cos^2($(angle_choice)) + \\sin($(angle_choice)) - 2\\sin^3($(angle_choice))\$",
                "Substitute \$\\cos^2($(angle_choice)) = 1 - \\sin^2($(angle_choice))\$:",
                "\$= 2\\sin($(angle_choice))(1-\\sin^2($(angle_choice))) + \\sin($(angle_choice)) - 2\\sin^3($(angle_choice))\$",
                "Simplify: \$= 2\\sin($(angle_choice)) - 2\\sin^3($(angle_choice)) + \\sin($(angle_choice)) - 2\\sin^3($(angle_choice))\$",
                sol("Final form", "3\\sin($(angle_choice)) - 4\\sin^3($(angle_choice))")
            )
            
            problem(
                question="Prove the identity: \$$(lhs_tex) = $(rhs_tex)\$",
                answer="proven",
                difficulty=(2500, 2900),
                answer_type="proof",
                solution=solution_text,
                time=300
            )
            
        elseif identity_type == 2
            # Prove: (sin(x) + cos(x))² = 1 + sin(2x)
            lhs_tex = "(\\sin($(angle_choice)) + \\cos($(angle_choice)))^2"
            rhs_tex = "1 + \\sin(2$(angle_choice))"
            
            solution_text = steps(
                "Start with LHS: \$(\\sin($(angle_choice)) + \\cos($(angle_choice)))^2\$",
                "Expand: \$\\sin^2($(angle_choice)) + 2\\sin($(angle_choice))\\cos($(angle_choice)) + \\cos^2($(angle_choice))\$",
                "Use Pythagorean identity \$\\sin^2($(angle_choice)) + \\cos^2($(angle_choice)) = 1\$:",
                "\$= 1 + 2\\sin($(angle_choice))\\cos($(angle_choice))\$",
                "Recognize double angle formula \$\\sin(2$(angle_choice)) = 2\\sin($(angle_choice))\\cos($(angle_choice))\$:",
                sol("Final form", "1 + \\sin(2$(angle_choice))")
            )
            
            problem(
                question="Prove the identity: \$$(lhs_tex) = $(rhs_tex)\$",
                answer="proven",
                difficulty=(2200, 2600),
                answer_type="proof",
                solution=solution_text,
                time=240
            )
            
        else
            # Prove: cos(4θ) = 8cos⁴(θ) - 8cos²(θ) + 1
            lhs_tex = "\\cos(4$(angle_choice))"
            rhs_tex = "8\\cos^4($(angle_choice)) - 8\\cos^2($(angle_choice)) + 1"
            
            solution_text = steps(
                "Start with \$\\cos(4$(angle_choice)) = \\cos(2 \\cdot 2$(angle_choice))\$",
                "Apply double angle formula: \$\\cos(2A) = 2\\cos^2(A) - 1\$:",
                "\$\\cos(4$(angle_choice)) = 2\\cos^2(2$(angle_choice)) - 1\$",
                "Apply double angle again to \$\\cos(2$(angle_choice)) = 2\\cos^2($(angle_choice)) - 1\$:",
                "\$= 2(2\\cos^2($(angle_choice)) - 1)^2 - 1\$",
                "Expand: \$= 2(4\\cos^4($(angle_choice)) - 4\\cos^2($(angle_choice)) + 1) - 1\$",
                "Simplify: \$= 8\\cos^4($(angle_choice)) - 8\\cos^2($(angle_choice)) + 2 - 1\$",
                sol("Final form", "8\\cos^4($(angle_choice)) - 8\\cos^2($(angle_choice)) + 1")
            )
            
            problem(
                question="Prove the identity: \$$(lhs_tex) = $(rhs_tex)\$",
                answer="proven",
                difficulty=(2700, 3200),
                answer_type="proof",
                solution=solution_text,
                time=360
            )
        end
        
    elseif problem_type == 2
        # Product-to-sum formula problem (2600-3100 ELO)
        
        m = randint(2, 7)
        n = randint(2, 7)
        while n == m
            n = randint(2, 7)
        end
        
        angle = choice(["x", "\\theta", "\\alpha"])
        
        # Express sin(mx)cos(nx) as a sum
        expr_tex = "\\sin($(m)$(angle))\\cos($(n)$(angle))"
        
        sum_plus = m + n
        sum_minus = abs(m - n)
        sign = m > n ? "+" : (m < n ? "-" : "+")
        
        ans_tex = "\\frac{1}{2}\\left[\\sin($(sum_plus)$(angle)) $(sign) \\sin($(sum_minus)$(angle))\\right]"
        
        solution_text = steps(
            "Use the product-to-sum identity:",
            "\$\\sin(A)\\cos(B) = \\frac{1}{2}[\\sin(A+B) + \\sin(A-B)]\$",
            "Let \$A = $(m)$(angle)\$ and \$B = $(n)$(angle)\$:",
            "\$\\sin($(m)$(angle))\\cos($(n)$(angle)) = \\frac{1}{2}[\\sin($(m)$(angle) + $(n)$(angle)) + \\sin($(m)$(angle) - $(n)$(angle))]\$",
            "Simplify the arguments:",
            sol("Final answer", ans_tex)
        )
        
        problem(
            question="Express \$$(expr_tex)\$ as a sum or difference of trigonometric functions.",
            answer=ans_tex,
            difficulty=(2600, 3100),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 3
        # Olympiad-level identity with constraints (3000-3500 ELO)
        
        # Given tan(α) + tan(β) = a and tan(α)tan(β) = b, find tan(α+β)
        a_val = randint(3, 9)
        b_val = randint(2, 5)
        while b_val >= a_val
            b_val = randint(2, 5)
        end
        
        # tan(α+β) = (tan(α) + tan(β))/(1 - tan(α)tan(β))
        numerator = a_val
        denominator = 1 - b_val
        
        if denominator != 0
            ans_val = numerator // denominator
        else
            ans_val = "undefined"
        end
        
        solution_text = steps(
            "Given: \$\\tan(\\alpha) + \\tan(\\beta) = $(a_val)\$ and \$\\tan(\\alpha)\\tan(\\beta) = $(b_val)\$",
            "Recall the angle addition formula:",
            "\$\\tan(\\alpha + \\beta) = \\frac{\\tan(\\alpha) + \\tan(\\beta)}{1 - \\tan(\\alpha)\\tan(\\beta)}\$",
            "Substitute the given values:",
            "\$\\tan(\\alpha + \\beta) = \\frac{$(a_val)}{1 - $(b_val)}\$",
            "Simplify:",
            sol("Answer", "\\tan(\\alpha + \\beta) = $(denominator != 0 ? tex(ans_val) : "\\text{undefined}")")
        )
        
        problem(
            question="If \$\\tan(\\alpha) + \\tan(\\beta) = $(a_val)\$ and \$\\tan(\\alpha)\\tan(\\beta) = $(b_val)\$, find \$\\tan(\\alpha + \\beta)\$.",
            answer=denominator != 0 ? ans_val : "undefined",
            difficulty=(3000, 3400),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 4
        # Complex simplification using half-angle formulas (2800-3300 ELO)
        
        angle = choice(["\\alpha", "\\theta", "x"])
        sign_choice = rand(["+", "-"])
        
        # Simplify sqrt((1 ± cos(2θ))/2)
        expr_tex = "\\sqrt{\\frac{1 $(sign_choice) \\cos(2$(angle))}{2}}"
        
        if sign_choice == "+"
            ans_tex = "|\\cos($(angle))|"
            formula_used = "half-angle formula: \$\\cos^2($(angle)) = \\frac{1 + \\cos(2$(angle))}{2}\$"
        else
            ans_tex = "|\\sin($(angle))|"
            formula_used = "half-angle formula: \$\\sin^2($(angle)) = \\frac{1 - \\cos(2$(angle))}{2}\$"
        end
        
        solution_text = steps(
            "Start with: \$$(expr_tex)\$",
            "Recognize the $(formula_used)",
            "Therefore: \$\\frac{1 $(sign_choice) \\cos(2$(angle))}{2} = $(sign_choice == "+" ? "\\cos^2($(angle))" : "\\sin^2($(angle))")\$",
            "Take the square root:",
            "\$\\sqrt{$(sign_choice == "+" ? "\\cos^2($(angle))" : "\\sin^2($(angle))")} = $(ans_tex)\$",
            sol("Final answer", ans_tex)
        )
        
        problem(
            question="Simplify: \$$(expr_tex)\$",
            answer=ans_tex,
            difficulty=(2800, 3300),
            solution=solution_text,
            time=270
        )
        
    else
        # High-level proof involving multiple identities (3200-3500 ELO)
        
        # Prove: (1 + cos(θ) + cos(2θ))/(sin(θ) + sin(2θ)) = cot(θ)
        
        solution_text = steps(
            "Start with LHS: \$\\frac{1 + \\cos(\\theta) + \\cos(2\\theta)}{\\sin(\\theta) + \\sin(2\\theta)}\$",
            "Substitute \$\\cos(2\\theta) = 2\\cos^2(\\theta) - 1\$ and \$\\sin(2\\theta) = 2\\sin(\\theta)\\cos(\\theta)\$:",
            "\$= \\frac{1 + \\cos(\\theta) + 2\\cos^2(\\theta) - 1}{\\sin(\\theta) + 2\\sin(\\theta)\\cos(\\theta)}\$",
            "Simplify numerator: \$= \\frac{\\cos(\\theta) + 2\\cos^2(\\theta)}{\\sin(\\theta) + 2\\sin(\\theta)\\cos(\\theta)}\$",
            "Factor numerator and denominator:",
            "\$= \\frac{\\cos(\\theta)(1 + 2\\cos(\\theta))}{\\sin(\\theta)(1 + 2\\cos(\\theta))}\$",
            "Cancel common factor \$(1 + 2\\cos(\\theta))\$:",
            "\$= \\frac{\\cos(\\theta)}{\\sin(\\theta)}\$",
            sol("Final result", "\\cot(\\theta)")
        )
        
        problem(
            question="Prove the identity: \$\\frac{1 + \\cos(\\theta) + \\cos(2\\theta)}{\\sin(\\theta) + \\sin(2\\theta)} = \\cot(\\theta)\$",
            answer="proven",
            difficulty=(3200, 3500),
            answer_type="proof",
            solution=solution_text,
            time=360
        )
    end
end