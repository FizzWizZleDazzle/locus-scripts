# precalculus - trig_identities (easy)
# Generated: 2026-03-08T20:29:09.339093

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/trig_identities")
    
    problem_type = choice([
        :simplify_pythagorean,
        :simplify_double_angle,
        :verify_identity_simple,
        :simplify_reciprocal,
        :simplify_quotient,
        :evaluate_identity
    ])
    
    if problem_type == :simplify_pythagorean
        # Simplify expressions using sin²x + cos²x = 1
        variant = choice([1, 2, 3, 4])
        
        if variant == 1
            # sin²x + cos²x
            question = "Simplify: \$\\sin^2(x) + \\cos^2(x)\$"
            answer = 1
            solution = steps(
                "Use the Pythagorean identity: \$\\sin^2(x) + \\cos^2(x) = 1\$",
                sol("Answer", 1)
            )
            difficulty = (700, 850)
        elseif variant == 2
            # 1 - sin²x
            question = "Simplify: \$1 - \\sin^2(x)\$"
            answer = "cos^2(x)"
            solution = steps(
                "Use the Pythagorean identity: \$\\sin^2(x) + \\cos^2(x) = 1\$",
                "Rearrange: \$\\cos^2(x) = 1 - \\sin^2(x)\$",
                sol("Answer", "\\cos^2(x)")
            )
            difficulty = (750, 900)
        elseif variant == 3
            # 1 - cos²x
            question = "Simplify: \$1 - \\cos^2(x)\$"
            answer = "sin^2(x)"
            solution = steps(
                "Use the Pythagorean identity: \$\\sin^2(x) + \\cos^2(x) = 1\$",
                "Rearrange: \$\\sin^2(x) = 1 - \\cos^2(x)\$",
                sol("Answer", "\\sin^2(x)")
            )
            difficulty = (750, 900)
        else
            # 2 - sin²x - cos²x
            question = "Simplify: \$2 - \\sin^2(x) - \\cos^2(x)\$"
            answer = 1
            solution = steps(
                "Group the trig terms: \$2 - (\\sin^2(x) + \\cos^2(x))\$",
                "Use the Pythagorean identity: \$\\sin^2(x) + \\cos^2(x) = 1\$",
                "Substitute: \$2 - 1 = 1\$",
                sol("Answer", 1)
            )
            difficulty = (850, 1000)
        end
        
    elseif problem_type == :simplify_double_angle
        # Simplify using double angle formulas
        variant = choice([1, 2, 3])
        
        if variant == 1
            # 2sin(x)cos(x)
            question = "Simplify: \$2\\sin(x)\\cos(x)\$"
            answer = "sin(2x)"
            solution = steps(
                "Use the double angle identity for sine: \$\\sin(2x) = 2\\sin(x)\\cos(x)\$",
                sol("Answer", "\\sin(2x)")
            )
            difficulty = (800, 950)
        elseif variant == 2
            # cos²x - sin²x
            question = "Simplify: \$\\cos^2(x) - \\sin^2(x)\$"
            answer = "cos(2x)"
            solution = steps(
                "Use the double angle identity for cosine: \$\\cos(2x) = \\cos^2(x) - \\sin^2(x)\$",
                sol("Answer", "\\cos(2x)")
            )
            difficulty = (800, 950)
        else
            # 1 - 2sin²x
            question = "Simplify: \$1 - 2\\sin^2(x)\$"
            answer = "cos(2x)"
            solution = steps(
                "Use the double angle identity: \$\\cos(2x) = 1 - 2\\sin^2(x)\$",
                sol("Answer", "\\cos(2x)")
            )
            difficulty = (850, 1000)
        end
        
    elseif problem_type == :simplify_reciprocal
        # Simplify using reciprocal identities
        variant = choice([1, 2, 3, 4])
        
        if variant == 1
            # 1/sin(x)
            question = "Simplify: \$\\frac{1}{\\sin(x)}\$"
            answer = "csc(x)"
            solution = steps(
                "Use the reciprocal identity: \$\\csc(x) = \\frac{1}{\\sin(x)}\$",
                sol("Answer", "\\csc(x)")
            )
            difficulty = (700, 850)
        elseif variant == 2
            # 1/cos(x)
            question = "Simplify: \$\\frac{1}{\\cos(x)}\$"
            answer = "sec(x)"
            solution = steps(
                "Use the reciprocal identity: \$\\sec(x) = \\frac{1}{\\cos(x)}\$",
                sol("Answer", "\\sec(x)")
            )
            difficulty = (700, 850)
        elseif variant == 3
            # sin(x)/1/sin(x) = sin²(x)
            question = "Simplify: \$\\sin(x) \\cdot \\csc(x)\$"
            answer = 1
            solution = steps(
                "Use the reciprocal identity: \$\\csc(x) = \\frac{1}{\\sin(x)}\$",
                "Multiply: \$\\sin(x) \\cdot \\frac{1}{\\sin(x)} = 1\$",
                sol("Answer", 1)
            )
            difficulty = (750, 900)
        else
            # tan(x)cot(x)
            question = "Simplify: \$\\tan(x) \\cdot \\cot(x)\$"
            answer = 1
            solution = steps(
                "Use the reciprocal identity: \$\\cot(x) = \\frac{1}{\\tan(x)}\$",
                "Multiply: \$\\tan(x) \\cdot \\frac{1}{\\tan(x)} = 1\$",
                sol("Answer", 1)
            )
            difficulty = (750, 900)
        end
        
    elseif problem_type == :simplify_quotient
        # Simplify using quotient identities
        variant = choice([1, 2, 3, 4])
        
        if variant == 1
            # sin(x)/cos(x)
            question = "Simplify: \$\\frac{\\sin(x)}{\\cos(x)}\$"
            answer = "tan(x)"
            solution = steps(
                "Use the quotient identity: \$\\tan(x) = \\frac{\\sin(x)}{\\cos(x)}\$",
                sol("Answer", "\\tan(x)")
            )
            difficulty = (700, 850)
        elseif variant == 2
            # cos(x)/sin(x)
            question = "Simplify: \$\\frac{\\cos(x)}{\\sin(x)}\$"
            answer = "cot(x)"
            solution = steps(
                "Use the quotient identity: \$\\cot(x) = \\frac{\\cos(x)}{\\sin(x)}\$",
                sol("Answer", "\\cot(x)")
            )
            difficulty = (700, 850)
        elseif variant == 3
            # sin²x/cos²x
            question = "Simplify: \$\\frac{\\sin^2(x)}{\\cos^2(x)}\$"
            answer = "tan^2(x)"
            solution = steps(
                "Split the fraction: \$\\left(\\frac{\\sin(x)}{\\cos(x)}\\right)^2\$",
                "Use the quotient identity: \$\\tan(x) = \\frac{\\sin(x)}{\\cos(x)}\$",
                sol("Answer", "\\tan^2(x)")
            )
            difficulty = (850, 1000)
        else
            # (sin x + cos x)/cos x
            question = "Simplify: \$\\frac{\\sin(x) + \\cos(x)}{\\cos(x)}\$"
            answer = "tan(x) + 1"
            solution = steps(
                "Split the fraction: \$\\frac{\\sin(x)}{\\cos(x)} + \\frac{\\cos(x)}{\\cos(x)}\$",
                "Simplify each term: \$\\tan(x) + 1\$",
                sol("Answer", "\\tan(x) + 1")
            )
            difficulty = (900, 1050)
        end
        
    elseif problem_type == :verify_identity_simple
        # Simple identity verification
        variant = choice([1, 2, 3])
        
        if variant == 1
            # sec²x - tan²x = 1
            question = "Verify the identity: \$\\sec^2(x) - \\tan^2(x) = 1\$. What is the right side?"
            answer = 1
            solution = steps(
                "Use the Pythagorean identity: \$\\sec^2(x) = 1 + \\tan^2(x)\$",
                "Rearrange: \$\\sec^2(x) - \\tan^2(x) = 1\$",
                sol("Answer", 1)
            )
            difficulty = (900, 1100)
        elseif variant == 2
            # csc²x - cot²x = 1
            question = "Verify the identity: \$\\csc^2(x) - \\cot^2(x) = 1\$. What is the right side?"
            answer = 1
            solution = steps(
                "Use the Pythagorean identity: \$\\csc^2(x) = 1 + \\cot^2(x)\$",
                "Rearrange: \$\\csc^2(x) - \\cot^2(x) = 1\$",
                sol("Answer", 1)
            )
            difficulty = (900, 1100)
        else
            # tan²x + 1 = sec²x
            question = "Simplify: \$\\tan^2(x) + 1\$"
            answer = "sec^2(x)"
            solution = steps(
                "Use the Pythagorean identity: \$1 + \\tan^2(x) = \\sec^2(x)\$",
                sol("Answer", "\\sec^2(x)")
            )
            difficulty = (850, 1000)
        end
        
    else  # :evaluate_identity
        # Evaluate using identities
        variant = choice([1, 2, 3])
        
        if variant == 1
            # If sin x = 3/5, find cos²x
            num = randint(2, 4)
            den = randint(num + 1, 6)
            answer_num = den^2 - num^2
            question = "If \$\\sin(x) = \\frac{$(num)}{$(den)}\$, find \$\\cos^2(x)\$. (Express as a fraction)"
            answer = answer_num // den^2
            solution = steps(
                sol("Given", "\\sin(x) = \\frac{$(num)}{$(den)}"),
                "Use Pythagorean identity: \$\\sin^2(x) + \\cos^2(x) = 1\$",
                "Square sine: \$\\sin^2(x) = \\frac{$(num^2)}{$(den^2)}\$",
                "Solve: \$\\cos^2(x) = 1 - \\frac{$(num^2)}{$(den^2)} = \\frac{$(answer_num)}{$(den^2)}\$",
                sol("Answer", "\\frac{$(answer_num)}{$(den^2)}")
            )
            difficulty = (1000, 1200)
        elseif variant == 2
            # If tan x = a, find sec²x
            a = randint(2, 8)
            answer = 1 + a^2
            question = "If \$\\tan(x) = $(a)\$, find \$\\sec^2(x)\$"
            answer = answer
            solution = steps(
                sol("Given", "\\tan(x) = $(a)"),
                "Use Pythagorean identity: \$\\sec^2(x) = 1 + \\tan^2(x)\$",
                "Substitute: \$\\sec^2(x) = 1 + $(a)^2 = 1 + $(a^2) = $(answer)\$",
                sol("Answer", answer)
            )
            difficulty = (950, 1150)
        else
            # Simplify (sin²x + cos²x)²
            question = "Simplify: \$(\\sin^2(x) + \\cos^2(x))^2\$"
            answer = 1
            solution = steps(
                "Use Pythagorean identity: \$\\sin^2(x) + \\cos^2(x) = 1\$",
                "Substitute: \$(1)^2 = 1\$",
                sol("Answer", 1)
            )
            difficulty = (800, 950)
        end
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution,
        time=90
    )
end