# precalculus - trig_identities (medium)
# Generated: 2026-03-08T20:29:05.391086

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/trig_identities")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simplify using Pythagorean identity
        trig_func = choice(["sin", "cos"])
        angle = choice(["x", "θ", "t", "α"])
        
        if trig_func == "sin"
            question = "Simplify: \$1 - \\cos^2($angle)\$"
            answer = "sin^2($angle)"
            solution_steps = steps(
                "Recall the Pythagorean identity: \$\\sin^2($angle) + \\cos^2($angle) = 1\$",
                "Rearrange: \$\\sin^2($angle) = 1 - \\cos^2($angle)\$",
                sol("Answer", "\\sin^2($angle)")
            )
        else
            question = "Simplify: \$1 - \\sin^2($angle)\$"
            answer = "cos^2($angle)"
            solution_steps = steps(
                "Recall the Pythagorean identity: \$\\sin^2($angle) + \\cos^2($angle) = 1\$",
                "Rearrange: \$\\cos^2($angle) = 1 - \\sin^2($angle)\$",
                sol("Answer", "\\cos^2($angle)")
            )
        end
        difficulty = (1200, 1400)
        time = 90
        
    elseif problem_type == 2
        # Simplify tan/cot in terms of sin/cos
        angle = choice(["x", "θ", "t", "α"])
        variant = rand(1:3)
        
        if variant == 1
            question = "Simplify: \$\\frac{\\sin($angle)}{\\cos($angle)}\$"
            answer = "tan($angle)"
            solution_steps = steps(
                "Recall the quotient identity: \$\\tan($angle) = \\frac{\\sin($angle)}{\\cos($angle)}\$",
                "The expression is already in this form",
                sol("Answer", "\\tan($angle)")
            )
        elseif variant == 2
            question = "Simplify: \$\\frac{\\cos($angle)}{\\sin($angle)}\$"
            answer = "cot($angle)"
            solution_steps = steps(
                "Recall the quotient identity: \$\\cot($angle) = \\frac{\\cos($angle)}{\\sin($angle)}\$",
                "The expression is already in this form",
                sol("Answer", "\\cot($angle)")
            )
        else
            question = "Express \$\\tan($angle)\$ in terms of sine and cosine"
            answer = "sin($angle)/cos($angle)"
            solution_steps = steps(
                "Recall the quotient identity: \$\\tan($angle) = \\frac{\\sin($angle)}{\\cos($angle)}\$",
                "This is the definition of tangent",
                sol("Answer", "\\frac{\\sin($angle)}{\\cos($angle)}")
            )
        end
        difficulty = (1000, 1300)
        time = 75
        
    elseif problem_type == 3
        # Verify or simplify identity with sec/csc
        angle = choice(["x", "θ", "t", "α"])
        variant = rand(1:4)
        
        if variant == 1
            question = "Simplify: \$\\sec^2($angle) - 1\$"
            answer = "tan^2($angle)"
            solution_steps = steps(
                "Recall the Pythagorean identity: \$1 + \\tan^2($angle) = \\sec^2($angle)\$",
                "Rearrange: \$\\sec^2($angle) - 1 = \\tan^2($angle)\$",
                sol("Answer", "\\tan^2($angle)")
            )
        elseif variant == 2
            question = "Simplify: \$\\csc^2($angle) - 1\$"
            answer = "cot^2($angle)"
            solution_steps = steps(
                "Recall the Pythagorean identity: \$1 + \\cot^2($angle) = \\csc^2($angle)\$",
                "Rearrange: \$\\csc^2($angle) - 1 = \\cot^2($angle)\$",
                sol("Answer", "\\cot^2($angle)")
            )
        elseif variant == 3
            question = "Simplify: \$\\frac{1}{\\cos($angle)}\$"
            answer = "sec($angle)"
            solution_steps = steps(
                "Recall the reciprocal identity: \$\\sec($angle) = \\frac{1}{\\cos($angle)}\$",
                "The expression matches this definition",
                sol("Answer", "\\sec($angle)")
            )
        else
            question = "Simplify: \$\\frac{1}{\\sin($angle)}\$"
            answer = "csc($angle)"
            solution_steps = steps(
                "Recall the reciprocal identity: \$\\csc($angle) = \\frac{1}{\\sin($angle)}\$",
                "The expression matches this definition",
                sol("Answer", "\\csc($angle)")
            )
        end
        difficulty = (1200, 1400)
        time = 90
        
    elseif problem_type == 4
        # Simplify complex fraction with trig
        angle = choice(["x", "θ", "t", "α"])
        variant = rand(1:3)
        
        if variant == 1
            question = "Simplify: \$\\frac{\\sin($angle)}{\\cos($angle)} \\cdot \\cos($angle)\$"
            answer = "sin($angle)"
            solution_steps = steps(
                "Multiply the fractions: \$\\frac{\\sin($angle) \\cdot \\cos($angle)}{\\cos($angle)}\$",
                "Cancel \$\\cos($angle)\$ from numerator and denominator",
                sol("Answer", "\\sin($angle)")
            )
        elseif variant == 2
            question = "Simplify: \$\\frac{\\tan($angle)}{\\sec($angle)}\$"
            answer = "sin($angle)"
            solution_steps = steps(
                "Rewrite in terms of sine and cosine: \$\\frac{\\sin($angle)/\\cos($angle)}{1/\\cos($angle)}\$",
                "Simplify: \$\\frac{\\sin($angle)}{\\cos($angle)} \\cdot \\cos($angle) = \\sin($angle)\$",
                sol("Answer", "\\sin($angle)")
            )
        else
            question = "Simplify: \$\\frac{1}{\\tan($angle) \\cdot \\cos($angle)}\$"
            answer = "csc($angle)"
            solution_steps = steps(
                "Substitute \$\\tan($angle) = \\frac{\\sin($angle)}{\\cos($angle)}\$: \$\\frac{1}{\\frac{\\sin($angle)}{\\cos($angle)} \\cdot \\cos($angle)}\$",
                "Simplify: \$\\frac{1}{\\sin($angle)}\$",
                sol("Answer", "\\csc($angle)")
            )
        end
        difficulty = (1300, 1600)
        time = 120
        
    elseif problem_type == 5
        # Simplify using multiple identities
        angle = choice(["x", "θ", "t"])
        variant = rand(1:3)
        
        if variant == 1
            question = "Simplify: \$\\frac{\\sin^2($angle) + \\cos^2($angle)}{\\cos($angle)}\$"
            answer = "sec($angle)"
            solution_steps = steps(
                "Apply Pythagorean identity: \$\\sin^2($angle) + \\cos^2($angle) = 1\$",
                "Expression becomes: \$\\frac{1}{\\cos($angle)}\$",
                sol("Answer", "\\sec($angle)")
            )
        elseif variant == 2
            question = "Simplify: \$\\tan($angle) \\cdot \\cos($angle)\$"
            answer = "sin($angle)"
            solution_steps = steps(
                "Substitute \$\\tan($angle) = \\frac{\\sin($angle)}{\\cos($angle)}\$",
                "Expression becomes: \$\\frac{\\sin($angle)}{\\cos($angle)} \\cdot \\cos($angle)\$",
                sol("Answer", "\\sin($angle)")
            )
        else
            question = "Simplify: \$\\sec^2($angle) - \\tan^2($angle)\$"
            answer = "1"
            solution_steps = steps(
                "Recall the Pythagorean identity: \$1 + \\tan^2($angle) = \\sec^2($angle)\$",
                "Rearrange: \$\\sec^2($angle) - \\tan^2($angle) = 1\$",
                sol("Answer", "1")
            )
        end
        difficulty = (1300, 1600)
        time = 120
        
    else
        # Multi-step simplification
        angle = choice(["x", "θ"])
        variant = rand(1:2)
        
        if variant == 1
            question = "Simplify: \$\\frac{1 - \\sin^2($angle)}{\\sin($angle) \\cdot \\cos($angle)}\$"
            answer = "cot($angle)"
            solution_steps = steps(
                "Apply Pythagorean identity to numerator: \$1 - \\sin^2($angle) = \\cos^2($angle)\$",
                "Expression becomes: \$\\frac{\\cos^2($angle)}{\\sin($angle) \\cdot \\cos($angle)}\$",
                "Cancel \$\\cos($angle)\$: \$\\frac{\\cos($angle)}{\\sin($angle)}\$",
                sol("Answer", "\\cot($angle)")
            )
        else
            question = "Simplify: \$\\frac{\\sec($angle)}{\\tan($angle)}\$"
            answer = "csc($angle)"
            solution_steps = steps(
                "Rewrite in terms of sine and cosine: \$\\frac{1/\\cos($angle)}{\\sin($angle)/\\cos($angle)}\$",
                "Simplify: \$\\frac{1}{\\cos($angle)} \\cdot \\frac{\\cos($angle)}{\\sin($angle)} = \\frac{1}{\\sin($angle)}\$",
                sol("Answer", "\\csc($angle)")
            )
        end
        difficulty = (1400, 1700)
        time = 150
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution_steps,
        time=time,
        answer_type="expression"
    )
end