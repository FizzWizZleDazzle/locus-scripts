# precalculus - trig_identities (hard)
# Generated: 2026-03-08T20:29:25.200467

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/trig_identities")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Prove a double angle identity with specific angle
        angle_mult = choice([2, 3, 4])
        base_angle = choice([15, 18, 22, 30, 36, 45])
        
        # Choose identity type
        identity_choice = rand(1:3)
        
        if identity_choice == 1
            # sin(2θ) = 2sin(θ)cos(θ)
            lhs_expr = "\\sin($(angle_mult * base_angle)^\\circ)"
            if angle_mult == 2
                rhs_expr = "2\\sin($(base_angle)^\\circ)\\cos($(base_angle)^\\circ)"
            else
                rhs_expr = "\\sin(2 \\cdot $(div(angle_mult * base_angle, 2))^\\circ)"
            end
        elseif identity_choice == 2
            # cos(2θ) = cos²(θ) - sin²(θ)
            lhs_expr = "\\cos($(angle_mult * base_angle)^\\circ)"
            if angle_mult == 2
                rhs_expr = "\\cos^2($(base_angle)^\\circ) - \\sin^2($(base_angle)^\\circ)"
            else
                rhs_expr = "\\cos(2 \\cdot $(div(angle_mult * base_angle, 2))^\\circ)"
            end
        else
            # tan(2θ) = 2tan(θ)/(1-tan²(θ))
            lhs_expr = "\\tan($(angle_mult * base_angle)^\\circ)"
            if angle_mult == 2
                rhs_expr = "\\frac{2\\tan($(base_angle)^\\circ)}{1 - \\tan^2($(base_angle)^\\circ)}"
            else
                rhs_expr = "\\tan(2 \\cdot $(div(angle_mult * base_angle, 2))^\\circ)"
            end
        end
        
        problem(
            question="Verify the identity: \$$(lhs_expr) = $(rhs_expr)\$. Enter 'verified' when complete.",
            answer="verified",
            difficulty=(1850, 2100),
            answer_type="text",
            calculator="scientific",
            solution=steps(
                "Apply the appropriate double angle or sum formula",
                "Simplify both sides to confirm they are equal",
                "The identity is verified"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Simplify complex trig expression using sum/difference formulas
        a = choice([30, 45, 60])
        b = choice([15, 30, 45])
        
        operation = choice(["+", "-"])
        
        trig_func = choice(["\\sin", "\\cos", "\\tan"])
        
        if trig_func == "\\sin"
            if operation == "+"
                answer_angle = a + b
                formula = "\\sin(A+B) = \\sin A \\cos B + \\cos A \\sin B"
            else
                answer_angle = a - b
                formula = "\\sin(A-B) = \\sin A \\cos B - \\cos A \\sin B"
            end
        elseif trig_func == "\\cos"
            if operation == "+"
                answer_angle = a + b
                formula = "\\cos(A+B) = \\cos A \\cos B - \\sin A \\sin B"
            else
                answer_angle = a - b
                formula = "\\cos(A-B) = \\cos A \\cos B + \\sin A \\sin B"
            end
        else
            if operation == "+"
                answer_angle = a + b
                formula = "\\tan(A+B) = \\frac{\\tan A + \\tan B}{1 - \\tan A \\tan B}"
            else
                answer_angle = a - b
                formula = "\\tan(A-B) = \\frac{\\tan A - \\tan B}{1 + \\tan A \\tan B}"
            end
        end
        
        answer = "$(trig_func)($(answer_angle)°)"
        
        problem(
            question="Simplify \$$(trig_func)($(a)^\\circ $(operation) $(b)^\\circ)\$ to the form \$$(trig_func)(\\theta^\\circ)\$ where \$\\theta\$ is a single angle. Enter your answer as $(trig_func)(angle°).",
            answer=answer,
            difficulty=(1900, 2200),
            answer_type="text",
            solution=steps(
                "Use the formula: \$$(formula)\$",
                "Substitute \$A = $(a)^\\circ\$ and \$B = $(b)^\\circ\$",
                "Result: \$$(answer)\$"
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Product-to-sum or sum-to-product conversion
        conversion_type = rand(1:2)
        
        if conversion_type == 1
            # Product to sum: sin(A)cos(B) = [sin(A+B) + sin(A-B)]/2
            a = choice([3, 4, 5, 6, 7]) * 15
            b = choice([1, 2, 3]) * 15
            
            sum_angle = a + b
            diff_angle = a - b
            
            answer_num = sum_angle + diff_angle
            answer_den = 2
            
            problem(
                question="Use a product-to-sum formula to express \$\\sin($(a)^\\circ)\\cos($(b)^\\circ)\$ as a sum or difference of sines and/or cosines. What is the sum of the two angles (in degrees) that appear in your final answer?",
                answer=answer_num,
                difficulty=(2000, 2300),
                solution=steps(
                    "Apply: \$\\sin A \\cos B = \\frac{1}{2}[\\sin(A+B) + \\sin(A-B)]\$",
                    "Substitute: \$\\sin($(a)^\\circ)\\cos($(b)^\\circ) = \\frac{1}{2}[\\sin($(sum_angle)^\\circ) + \\sin($(diff_angle)^\\circ)]\$",
                    "Sum of angles: \$$(sum_angle) + $(diff_angle) = $(answer_num)\$"
                ),
                time=200
            )
        else
            # Sum to product: sin(A) + sin(B) = 2sin((A+B)/2)cos((A-B)/2)
            a = choice([60, 75, 90, 105, 120])
            b = choice([15, 30, 45, 60])
            
            avg_angle = div(a + b, 2)
            half_diff = div(a - b, 2)
            
            answer = avg_angle
            
            problem(
                question="Use a sum-to-product formula to express \$\\sin($(a)^\\circ) + \\sin($(b)^\\circ)\$ as a product. What is the argument (in degrees) of the sine term in the factored form?",
                answer=answer,
                difficulty=(2050, 2350),
                solution=steps(
                    "Apply: \$\\sin A + \\sin B = 2\\sin\\left(\\frac{A+B}{2}\\right)\\cos\\left(\\frac{A-B}{2}\\right)\$",
                    "Calculate: \$\\frac{$(a)+$(b)}{2} = $(avg_angle)^\\circ\$ and \$\\frac{$(a)-$(b)}{2} = $(half_diff)^\\circ\$",
                    "The sine argument is \$$(avg_angle)^\\circ\$"
                ),
                time=180
            )
        end
        
    elseif problem_type == 4
        # Half-angle formula application
        angle = choice([90, 120, 150, 180, 210, 240])
        half = div(angle, 2)
        
        func_choice = choice(["sin", "cos", "tan"])
        
        if func_choice == "sin"
            formula = "\\sin\\left(\\frac{\\theta}{2}\\right) = \\pm\\sqrt{\\frac{1-\\cos\\theta}{2}}"
        elseif func_choice == "cos"
            formula = "\\cos\\left(\\frac{\\theta}{2}\\right) = \\pm\\sqrt{\\frac{1+\\cos\\theta}{2}}"
        else
            formula = "\\tan\\left(\\frac{\\theta}{2}\\right) = \\frac{\\sin\\theta}{1+\\cos\\theta}"
        end
        
        answer_expr = "$(func_choice)($(half)°)"
        other_func = func_choice == "tan" ? "sin" : "cos"

        problem(
            question="Use a half-angle formula to express \$\\$(func_choice)($(half)^\\circ)\$ in terms of \$\\$(other_func)($(angle)^\\circ)\$. Enter your final simplified answer in the form $(func_choice)(angle°).",
            answer="$(func_choice)($(half)°)",
            difficulty=(1950, 2250),
            answer_type="text",
            calculator="scientific",
            solution=steps(
                "Use the half-angle formula: \$$(formula)\$",
                "Substitute \$\\theta = $(angle)^\\circ\$",
                "Simplify to get \$$(answer_expr)\$"
            ),
            time=210
        )
        
    else
        # Complex identity simplification
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # Create an identity like: (sin²x + cos²x) + a·sin(2x) = 1 + a·sin(2x)
        # Answer is the coefficient of the remaining term
        
        identity_type = rand(1:3)
        
        if identity_type == 1
            # sin²x + cos²x = 1 based
            coeff = nonzero(-8, 8)
            answer = abs(coeff)
            
            problem(
                question="Simplify the expression \$$(coeff)(\\sin^2 x + \\cos^2 x) - \\sin^2 x - \\cos^2 x\$ completely. What is the absolute value of the resulting constant?",
                answer=answer,
                difficulty=(1800, 2000),
                solution=steps(
                    "Recognize that \$\\sin^2 x + \\cos^2 x = 1\$",
                    "Substitute: \$$(coeff)(1) - 1 = $(coeff - 1)\$",
                    "Absolute value: \$|$(coeff - 1)| = $(answer)\$"
                ),
                time=120
            )
        elseif identity_type == 2
            # 1 + tan²x = sec²x based
            k = nonzero(-6, 6)
            answer = abs(k)
            
            problem(
                question="Given that \$1 + \\tan^2 x = \\sec^2 x\$, simplify \$$(k)\\sec^2 x - $(k)\\tan^2 x\$ completely. What is the absolute value of the result?",
                answer=answer,
                difficulty=(1850, 2100),
                solution=steps(
                    "Factor: \$$(k)(\\sec^2 x - \\tan^2 x)\$",
                    "Use identity \$\\sec^2 x - \\tan^2 x = 1\$",
                    "Result: \$$(k) \\cdot 1 = $(k)\$, absolute value is \$$(answer)\$"
                ),
                time=150
            )
        else
            # Double angle with coefficient
            m = nonzero(-7, 7)
            target = 2 * m
            
            problem(
                question="If \$\\sin(2x) = 2\\sin x \\cos x\$, and we have \$$(m)\\sin x \\cos x\$, what coefficient \$k\$ satisfies \$$(m)\\sin x \\cos x = k\\sin(2x)\$?",
                answer=m // 2,
                difficulty=(1900, 2150),
                solution=steps(
                    "Use the double angle formula: \$\\sin(2x) = 2\\sin x \\cos x\$",
                    "Therefore: \$\\sin x \\cos x = \\frac{1}{2}\\sin(2x)\$",
                    "So \$$(m)\\sin x \\cos x = \\frac{$(m)}{2}\\sin(2x)\$, giving \$k = $(m//2)\$"
                ),
                time=180
            )
        end
    end
end