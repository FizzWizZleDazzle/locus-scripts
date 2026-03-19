# precalculus - trig_identities (very_easy)
# Generated: 2026-03-08T20:28:33.359678

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/trig_identities")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Recognize basic Pythagorean identity: sin²(x) + cos²(x) = 1
        difficulty = randint(100, 300)
        question = "What is the value of \\(\\sin^2(x) + \\cos^2(x)\\) for any angle \\(x\\)?"
        answer = 1
        solution = steps(
            "Recall the Pythagorean identity",
            "\\(\\sin^2(x) + \\cos^2(x) = 1\\) for all angles \\(x\\)",
            sol("Answer", 1)
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            time=30
        )
        
    elseif problem_type == 2
        # Simple substitution: If sin(x) = a, find sin²(x)
        a_num = randint(1, 9)
        a_den = randint(a_num + 1, 12)
        a = a_num // a_den
        ans = a^2
        
        difficulty = randint(200, 400)
        question = "If \\(\\sin(x) = \\frac{$(a_num)}{$(a_den)}\\), what is \\(\\sin^2(x)\\)?"
        solution = steps(
            sol("Given", "\\sin(x) = \\frac{$(a_num)}{$(a_den)}"),
            "Square both sides",
            sol("\\sin^2(x)", "\\left(\\frac{$(a_num)}{$(a_den)}\\right)^2 = \\frac{$(numerator(ans))}{$(denominator(ans))}")
        )
        problem(
            question=question,
            answer=ans,
            difficulty=difficulty,
            solution=solution,
            time=45
        )
        
    elseif problem_type == 3
        # Use Pythagorean identity: If sin(x) = a, find cos²(x)
        a_num = randint(1, 7)
        a_den = randint(a_num + 2, 10)
        a = a_num // a_den
        ans = 1 - a^2
        
        difficulty = randint(300, 500)
        question = "If \\(\\sin(x) = \\frac{$(a_num)}{$(a_den)}\\), what is \\(\\cos^2(x)\\)?"
        solution = steps(
            sol("Given", "\\sin(x) = \\frac{$(a_num)}{$(a_den)}"),
            "Use Pythagorean identity: \\(\\sin^2(x) + \\cos^2(x) = 1\\)",
            sol("\\cos^2(x)", "1 - \\sin^2(x) = 1 - \\frac{$(numerator(a^2))}{$(denominator(a^2))} = \\frac{$(numerator(ans))}{$(denominator(ans))}")
        )
        problem(
            question=question,
            answer=ans,
            difficulty=difficulty,
            solution=solution,
            time=60
        )
        
    elseif problem_type == 4
        # Recognize tan identity: tan(x) = sin(x)/cos(x)
        difficulty = randint(200, 400)
        question = "Which trigonometric identity expresses \\(\\tan(x)\\) in terms of \\(\\sin(x)\\) and \\(\\cos(x)\\)?"
        answer = "\\frac{\\sin(x)}{\\cos(x)}"
        solution = steps(
            "Recall the definition of tangent",
            "\\(\\tan(x) = \\frac{\\sin(x)}{\\cos(x)}\\)",
            sol("Answer", "\\frac{\\sin(x)}{\\cos(x)}")
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            answer_type="expression",
            time=30
        )
        
    elseif problem_type == 5
        # Compute tan(x) given sin and cos
        s_num = randint(1, 6)
        c_num = randint(1, 6)
        denom = randint(max(s_num, c_num) + 1, 10)
        sin_val = s_num // denom
        cos_val = c_num // denom
        ans = sin_val / cos_val
        
        difficulty = randint(400, 600)
        question = "If \\(\\sin(x) = \\frac{$(s_num)}{$(denom)}\\) and \\(\\cos(x) = \\frac{$(c_num)}{$(denom)}\\), what is \\(\\tan(x)\\)?"
        solution = steps(
            sol("Given", "\\sin(x) = \\frac{$(s_num)}{$(denom)}, \\cos(x) = \\frac{$(c_num)}{$(denom)}"),
            "Use identity: \\(\\tan(x) = \\frac{\\sin(x)}{\\cos(x)}\\)",
            sol("\\tan(x)", "\\frac{$(s_num)/$(denom)}{$(c_num)/$(denom)} = \\frac{$(s_num)}{$(c_num)} = \\frac{$(numerator(ans))}{$(denominator(ans))}")
        )
        problem(
            question=question,
            answer=ans,
            difficulty=difficulty,
            solution=solution,
            time=60
        )
        
    else
        # Simple algebraic manipulation: Solve sin²(x) + cos²(x) = 1 for sin²(x)
        difficulty = randint(300, 500)
        question = "Solve the Pythagorean identity \\(\\sin^2(x) + \\cos^2(x) = 1\\) for \\(\\sin^2(x)\\)."
        answer = "1 - \\cos^2(x)"
        solution = steps(
            sol("Given", "\\sin^2(x) + \\cos^2(x) = 1"),
            "Subtract \\(\\cos^2(x)\\) from both sides",
            sol("\\sin^2(x)", "1 - \\cos^2(x)")
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            answer_type="expression",
            time=45
        )
    end
end