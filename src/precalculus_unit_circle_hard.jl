# precalculus - unit_circle (hard)
# Generated: 2026-03-08T20:27:38.114217

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x t θ begin
    set_topic!("precalculus/unit_circle")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Exact value problem with sum/difference of special angles
        angles = [0, π/6, π/4, π/3, π/2, 2π/3, 3π/4, 5π/6, π, 7π/6, 5π/4, 4π/3, 3π/2, 5π/3, 7π/4, 11π/6]
        α = choice(angles)
        β = choice(angles)
        operation = choice(["+", "-"])
        trig_func = choice(["sin", "cos"])
        
        if operation == "+"
            if trig_func == "sin"
                ans = sin(α + β)
                formula = "\\sin(α + β) = \\sin α \\cos β + \\cos α \\sin β"
                expr_str = "\\sin\\left($(tex(α)) + $(tex(β))\\right)"
            else
                ans = cos(α + β)
                formula = "\\cos(α + β) = \\cos α \\cos β - \\sin α \\sin β"
                expr_str = "\\cos\\left($(tex(α)) + $(tex(β))\\right)"
            end
        else
            if trig_func == "sin"
                ans = sin(α - β)
                formula = "\\sin(α - β) = \\sin α \\cos β - \\cos α \\sin β"
                expr_str = "\\sin\\left($(tex(α)) - $(tex(β))\\right)"
            else
                ans = cos(α - β)
                formula = "\\cos(α - β) = \\cos α \\cos β + \\sin α \\sin β"
                expr_str = "\\cos\\left($(tex(α)) - $(tex(β))\\right)"
            end
        end
        
        problem(
            question="Find the exact value of \\\$$(expr_str)\\\$",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Use the $(trig_func) $(operation == "+" ? "sum" : "difference") formula",
                formula,
                "Substitute α = $(tex(α)), β = $(tex(β))",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Double angle problem with parametric constraint
        # Given sin(θ) = a/b in quadrant II, find sin(2θ)
        b = randint(5, 15)
        a = randint(1, b-1)
        quadrant = choice([1, 2, 3, 4])
        
        if quadrant == 1
            sign_sin = 1
            sign_cos = 1
            quad_desc = "I (0 < θ < π/2)"
        elseif quadrant == 2
            sign_sin = 1
            sign_cos = -1
            quad_desc = "II (π/2 < θ < π)"
        elseif quadrant == 3
            sign_sin = -1
            sign_cos = -1
            quad_desc = "III (π < θ < 3π/2)"
        else
            sign_sin = -1
            sign_cos = 1
            quad_desc = "IV (3π/2 < θ < 2π)"
        end
        
        sin_val = sign_sin * a // b
        cos_val = sign_cos * sqrt(b^2 - a^2) // b
        ans = 2 * sin_val * cos_val
        
        problem(
            question="If \\\$\\sin θ = $(sign_sin == 1 ? "" : "-")\\frac{$(a)}{$(b)}\\\$ and θ is in quadrant $(quad_desc), find \\\$\\sin(2θ)\\\$",
            answer=ans,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given", "\\sin θ = $(sign_sin == 1 ? "" : "-")\\frac{$(a)}{$(b)}"),
                "Use Pythagorean identity: \\\$\\cos^2 θ = 1 - \\sin^2 θ = 1 - \\frac{$(a^2)}{$(b^2)} = \\frac{$(b^2 - a^2)}{$(b^2)}\\\$",
                "In quadrant $(quad_desc), \\\$\\cos θ = $(sign_cos == 1 ? "" : "-")\\frac{\\sqrt{$(b^2 - a^2)}}{$(b)}\\\$",
                "Double angle formula: \\\$\\sin(2θ) = 2\\sin θ \\cos θ\\\$",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Solve trigonometric equation on unit circle
        # sin(2x) = cos(x) on [0, 2π)
        eqn_type = choice([1, 2, 3])
        
        if eqn_type == 1
            # sin(2x) = cos(x)
            # 2sin(x)cos(x) = cos(x)
            # cos(x)(2sin(x) - 1) = 0
            # x = π/2, 3π/2, π/6, 5π/6
            ans = fmt_set(Set([π/2, 3π/2, π/6, 5π/6]))
            problem(
                question="Find all solutions to \\\$\\sin(2x) = \\cos(x)\\\$ on \\\$[0, 2π)\\\$",
                answer=ans,
                difficulty=(1900, 2100),
                answer_type="set",
                solution=steps(
                    "Use double angle formula: \\\$2\\sin(x)\\cos(x) = \\cos(x)\\\$",
                    "Factor: \\\$\\cos(x)(2\\sin(x) - 1) = 0\\\$",
                    "\\\$\\cos(x) = 0\\\$ gives \\\$x = \\frac{π}{2}, \\frac{3π}{2}\\\$",
                    "\\\$\\sin(x) = \\frac{1}{2}\\\$ gives \\\$x = \\frac{π}{6}, \\frac{5π}{6}\\\$",
                    sol("Answer", "\\left\\{\\frac{π}{6}, \\frac{π}{2}, \\frac{5π}{6}, \\frac{3π}{2}\\right\\}")
                ),
                time=240
            )
        elseif eqn_type == 2
            # cos(2x) + cos(x) = 0
            # 2cos²(x) - 1 + cos(x) = 0
            # 2cos²(x) + cos(x) - 1 = 0
            # (2cos(x) - 1)(cos(x) + 1) = 0
            # x = π/3, 5π/3, π
            ans = fmt_set(Set([π/3, π, 5π/3]))
            problem(
                question="Find all solutions to \\\$\\cos(2x) + \\cos(x) = 0\\\$ on \\\$[0, 2π)\\\$",
                answer=ans,
                difficulty=(1950, 2150),
                answer_type="set",
                solution=steps(
                    "Use double angle formula: \\\$2\\cos^2(x) - 1 + \\cos(x) = 0\\\$",
                    "Rearrange: \\\$2\\cos^2(x) + \\cos(x) - 1 = 0\\\$",
                    "Factor: \$(2\\cos(x) - 1)(\\cos(x) + 1) = 0\\\$",
                    "\\\$\\cos(x) = \\frac{1}{2}\\\$ gives \\\$x = \\frac{π}{3}, \\frac{5π}{3}\\\$; \\\$\\cos(x) = -1\\\$ gives \\\$x = π\\\$",
                    sol("Answer", "\\left\\{\\frac{π}{3}, π, \\frac{5π}{3}\\right\\}")
                ),
                time=240
            )
        else
            # sin²(x) - cos²(x) = 1/2
            # -cos(2x) = 1/2
            # cos(2x) = -1/2
            # 2x = 2π/3, 4π/3, 8π/3, 10π/3
            # x = π/3, 2π/3, 4π/3, 5π/3
            ans = fmt_set(Set([π/3, 2π/3, 4π/3, 5π/3]))
            problem(
                question="Find all solutions to \\\$\\sin^2(x) - \\cos^2(x) = \\frac{1}{2}\\\$ on \\\$[0, 2π)\\\$",
                answer=ans,
                difficulty=(2000, 2200),
                answer_type="set",
                solution=steps(
                    "Recognize: \\\$\\sin^2(x) - \\cos^2(x) = -\\cos(2x)\\\$",
                    "So \\\$-\\cos(2x) = \\frac{1}{2}\\\$, thus \\\$\\cos(2x) = -\\frac{1}{2}\\\$",
                    "On \\\$[0, 4π)\\\$: \\\$2x = \\frac{2π}{3}, \\frac{4π}{3}, \\frac{8π}{3}, \\frac{10π}{3}\\\$",
                    "Divide by 2: \\\$x = \\frac{π}{3}, \\frac{2π}{3}, \\frac{4π}{3}, \\frac{5π}{3}\\\$",
                    sol("Answer", "\\left\\{\\frac{π}{3}, \\frac{2π}{3}, \\frac{4π}{3}, \\frac{5π}{3}\\right\\}")
                ),
                time=270
            )
        end
        
    elseif problem_type == 4
        # Evaluate sum/product involving unit circle
        # Find sin(π/12) using half-angle or difference formulas
        func = choice(["sin", "cos"])

        if func == "sin"
            ans = (sqrt(6) - sqrt(2)) // 4
            problem(
                question="Find the exact value of \\\$\\sin\\left(\\frac{π}{12}\\right)\\\$",
                answer=ans,
                difficulty=(1950, 2100),
                solution=steps(
                    "Write \\\$\\frac{π}{12} = \\frac{π}{3} - \\frac{π}{4}\\\$",
                    "Use difference formula: \\\$\\sin(α - β) = \\sin α \\cos β - \\cos α \\sin β\\\$",
                    "\\\$\\sin\\left(\\frac{π}{12}\\right) = \\sin\\left(\\frac{π}{3}\\right)\\cos\\left(\\frac{π}{4}\\right) - \\cos\\left(\\frac{π}{3}\\right)\\sin\\left(\\frac{π}{4}\\right)\\\$",
                    "\\\$= \\frac{\\sqrt{3}}{2} \\cdot \\frac{\\sqrt{2}}{2} - \\frac{1}{2} \\cdot \\frac{\\sqrt{2}}{2}\\\$",
                    sol("Answer", ans)
                ),
                time=240
            )
        else
            ans = (sqrt(6) + sqrt(2)) // 4
            problem(
                question="Find the exact value of \\\$\\cos\\left(\\frac{π}{12}\\right)\\\$",
                answer=ans,
                difficulty=(1950, 2100),
                solution=steps(
                    "Write \\\$\\frac{π}{12} = \\frac{π}{3} - \\frac{π}{4}\\\$",
                    "Use difference formula: \\\$\\cos(α - β) = \\cos α \\cos β + \\sin α \\sin β\\\$",
                    "\\\$\\cos\\left(\\frac{π}{12}\\right) = \\cos\\left(\\frac{π}{3}\\right)\\cos\\left(\\frac{π}{4}\\right) + \\sin\\left(\\frac{π}{3}\\right)\\sin\\left(\\frac{π}{4}\\right)\\\$",
                    "\\\$= \\frac{1}{2} \\cdot \\frac{\\sqrt{2}}{2} + \\frac{\\sqrt{3}}{2} \\cdot \\frac{\\sqrt{2}}{2}\\\$",
                    sol("Answer", ans)
                ),
                time=240
            )
        end
        
    elseif problem_type == 5
        # Verify trigonometric identity with unit circle reasoning
        # Prove: tan(θ) + cot(θ) = sec(θ)csc(θ)
        problem(
            question="Verify the identity: \\\$\\tan θ + \\cot θ = \\sec θ \\csc θ\\\$",
            answer="sec(θ)*csc(θ)",
            difficulty=(1800, 2000),
            grading_mode="symbolic",
            solution=steps(
                "Start with left side: \\\$\\tan θ + \\cot θ = \\frac{\\sin θ}{\\cos θ} + \\frac{\\cos θ}{\\sin θ}\\\$",
                "Common denominator: \\\$= \\frac{\\sin^2 θ + \\cos^2 θ}{\\sin θ \\cos θ}\\\$",
                "Use Pythagorean identity: \\\$= \\frac{1}{\\sin θ \\cos θ}\\\$",
                "Simplify using trig identities",
                sol("Answer", "Identity verified")
            ),
            time=240
        )
    end
end
