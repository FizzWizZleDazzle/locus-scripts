# precalculus - sum_difference_formulas (medium)
# Generated: 2026-03-08T20:30:27.314294

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/sum_difference_formulas")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Evaluate sin(A+B) given sin(A), cos(A), sin(B), cos(B)
        # Choose angles in first quadrant for simplicity
        sin_a_num = randint(3, 12)
        sin_a_den = randint(sin_a_num + 1, 15)
        cos_a = sqrt(sin_a_den^2 - sin_a_num^2) // sin_a_den
        
        sin_b_num = randint(4, 11)
        sin_b_den = randint(sin_b_num + 1, 16)
        cos_b = sqrt(sin_b_den^2 - sin_b_num^2) // sin_b_den
        
        sin_a = sin_a_num // sin_a_den
        sin_b = sin_b_num // sin_b_den
        
        ans = sin_a * cos_b + cos_a * sin_b
        
        problem(
            question="If \\(\\sin(A) = $(tex(sin_a))\\) and \\(\\cos(A) = $(tex(cos_a))\\), and \\(\\sin(B) = $(tex(sin_b))\\) and \\(\\cos(B) = $(tex(cos_b))\\), find \\(\\sin(A + B)\\).",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Use the sum formula: \\(\\sin(A + B) = \\sin(A)\\cos(B) + \\cos(A)\\sin(B)\\)",
                sol("Substitute", sin_a * cos_b + cos_a * sin_b),
                sol("Simplify", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Evaluate cos(A-B) given sin and cos values
        cos_a_num = randint(5, 12)
        cos_a_den = randint(cos_a_num + 1, 15)
        sin_a = sqrt(cos_a_den^2 - cos_a_num^2) // cos_a_den
        cos_a = cos_a_num // cos_a_den
        
        cos_b_num = randint(6, 11)
        cos_b_den = randint(cos_b_num + 1, 16)
        sin_b = sqrt(cos_b_den^2 - cos_b_num^2) // cos_b_den
        cos_b = cos_b_num // cos_b_den
        
        ans = cos_a * cos_b + sin_a * sin_b
        
        problem(
            question="If \\(\\sin(A) = $(tex(sin_a))\\), \\(\\cos(A) = $(tex(cos_a))\\), \\(\\sin(B) = $(tex(sin_b))\\), and \\(\\cos(B) = $(tex(cos_b))\\), find \\(\\cos(A - B)\\).",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Use the difference formula: \\(\\cos(A - B) = \\cos(A)\\cos(B) + \\sin(A)\\sin(B)\\)",
                sol("Substitute", cos_a * cos_b + sin_a * sin_b),
                sol("Simplify", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Exact value using sum/difference: sin(75°) = sin(45° + 30°)
        angles = [
            (75, 45, 30, "sin", "+"),
            (15, 45, 30, "sin", "-"),
            (75, 45, 30, "cos", "-"),
            (105, 60, 45, "sin", "+"),
            (15, 60, 45, "cos", "+")
        ]
        
        angle, a1, a2, func, op = choice(angles)
        
        if func == "sin"
            if op == "+"
                if angle == 75
                    ans_expr = "\\frac{\\sqrt{6} + \\sqrt{2}}{4}"
                else  # 105
                    ans_expr = "\\frac{\\sqrt{6} + \\sqrt{2}}{4}"
                end
            else  # op == "-"
                ans_expr = "\\frac{\\sqrt{6} - \\sqrt{2}}{4}"
            end
        else  # cos
            if op == "+"
                ans_expr = "\\frac{\\sqrt{6} - \\sqrt{2}}{4}"
            else
                ans_expr = "\\frac{\\sqrt{6} + \\sqrt{2}}{4}"
            end
        end
        
        problem(
            question="Find the exact value of \\(\\\$(func)($(angle)°)\\) using sum or difference formulas.",
            answer=ans_expr,
            difficulty=(1400, 1600),
            answer_type="expression",
            solution=steps(
                "Write \\($(angle)° = $(a1)° $(op) $(a2)°\\)",
                "Apply the $(func == "sin" ? "sine" : "cosine") $(op == "+" ? "sum" : "difference") formula",
                "Substitute known values and simplify to get \\($(ans_expr)\\)"
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Simplify using sum/difference formula
        a = randint(2, 8) * 15
        b = randint(1, 6) * 15
        
        if rand(Bool)
            # sin(a)cos(b) + cos(a)sin(b)
            ans = a + b
            problem(
                question="Simplify using sum or difference formulas: \\(\\sin($(a)°)\\cos($(b)°) + \\cos($(a)°)\\sin($(b)°)\\)",
                answer="\\sin($(ans)°)",
                difficulty=(1300, 1500),
                answer_type="expression",
                solution=steps(
                    "Recognize the sine sum formula: \\(\\sin(A + B) = \\sin(A)\\cos(B) + \\cos(A)\\sin(B)\\)",
                    "Here \\(A = $(a)°\\) and \\(B = $(b)°\\)",
                    sol("Answer", "\\sin($(ans)°)")
                ),
                time=90
            )
        else
            # cos(a)cos(b) - sin(a)sin(b)
            ans = a + b
            problem(
                question="Simplify using sum or difference formulas: \\(\\cos($(a)°)\\cos($(b)°) - \\sin($(a)°)\\sin($(b)°)\\)",
                answer="\\cos($(ans)°)",
                difficulty=(1300, 1500),
                answer_type="expression",
                solution=steps(
                    "Recognize the cosine sum formula: \\(\\cos(A + B) = \\cos(A)\\cos(B) - \\sin(A)\\sin(B)\\)",
                    "Here \\(A = $(a)°\\) and \\(B = $(b)°\\)",
                    sol("Answer", "\\cos($(ans)°)")
                ),
                time=90
            )
        end
        
    elseif problem_type == 5
        # tan(A+B) or tan(A-B) formula
        tan_a = randint(2, 8)
        tan_b = randint(2, 7)
        
        if rand(Bool)
            # tan(A+B)
            ans_num = tan_a + tan_b
            ans_den = 1 - tan_a * tan_b
            
            if ans_den != 0
                ans = ans_num // ans_den
                problem(
                    question="If \\(\\tan(A) = $(tan_a)\\) and \\(\\tan(B) = $(tan_b)\\), find \\(\\tan(A + B)\\).",
                    answer=ans,
                    difficulty=(1300, 1600),
                    solution=steps(
                        "Use the tangent sum formula: \\(\\tan(A + B) = \\frac{\\tan(A) + \\tan(B)}{1 - \\tan(A)\\tan(B)}\\)",
                        sol("Substitute", "\\frac{$(tan_a) + $(tan_b)}{1 - $(tan_a) \\cdot $(tan_b)} = \\frac{$(ans_num)}{$(ans_den)}"),
                        sol("Answer", ans)
                    ),
                    time=120
                )
            else
                ans_num = tan_a - tan_b
                ans_den = 1 + tan_a * tan_b
                ans = ans_num // ans_den
                problem(
                    question="If \\(\\tan(A) = $(tan_a)\\) and \\(\\tan(B) = $(tan_b)\\), find \\(\\tan(A - B)\\).",
                    answer=ans,
                    difficulty=(1300, 1600),
                    solution=steps(
                        "Use the tangent difference formula: \\(\\tan(A - B) = \\frac{\\tan(A) - \\tan(B)}{1 + \\tan(A)\\tan(B)}\\)",
                        sol("Substitute", "\\frac{$(tan_a) - $(tan_b)}{1 + $(tan_a) \\cdot $(tan_b)} = \\frac{$(ans_num)}{$(ans_den)}"),
                        sol("Answer", ans)
                    ),
                    time=120
                )
            end
        else
            # tan(A-B)
            ans_num = tan_a - tan_b
            ans_den = 1 + tan_a * tan_b
            ans = ans_num // ans_den
            
            problem(
                question="If \\(\\tan(A) = $(tan_a)\\) and \\(\\tan(B) = $(tan_b)\\), find \\(\\tan(A - B)\\).",
                answer=ans,
                difficulty=(1300, 1600),
                solution=steps(
                    "Use the tangent difference formula: \\(\\tan(A - B) = \\frac{\\tan(A) - \\tan(B)}{1 + \\tan(A)\\tan(B)}\\)",
                    sol("Substitute", "\\frac{$(tan_a) - $(tan_b)}{1 + $(tan_a) \\cdot $(tan_b)} = \\frac{$(ans_num)}{$(ans_den)}"),
                    sol("Answer", ans)
                ),
                time=120
            )
        end
        
    else  # problem_type == 6
        # Verify identity or prove using sum/difference formulas
        coeff = choice([2, 3, 4])
        
        if rand(Bool)
            problem(
                question="Use sum formulas to prove that \\(\\sin(x + \\pi) = -\\sin(x)\\).",
                answer="Proven",
                difficulty=(1500, 1700),
                answer_type="proof",
                solution=steps(
                    "Apply sine sum formula: \\(\\sin(x + \\pi) = \\sin(x)\\cos(\\pi) + \\cos(x)\\sin(\\pi)\\)",
                    "Substitute \\(\\cos(\\pi) = -1\\) and \\(\\sin(\\pi) = 0\\)",
                    "Simplify: \\(\\sin(x)(-1) + \\cos(x)(0) = -\\sin(x)\\)"
                ),
                time=150
            )
        else
            problem(
                question="Use sum formulas to prove that \\(\\cos(x + \\frac{\\pi}{2}) = -\\sin(x)\\).",
                answer="Proven",
                difficulty=(1500, 1700),
                answer_type="proof",
                solution=steps(
                    "Apply cosine sum formula: \\(\\cos(x + \\frac{\\pi}{2}) = \\cos(x)\\cos(\\frac{\\pi}{2}) - \\sin(x)\\sin(\\frac{\\pi}{2})\\)",
                    "Substitute \\(\\cos(\\frac{\\pi}{2}) = 0\\) and \\(\\sin(\\frac{\\pi}{2}) = 1\\)",
                    "Simplify: \\(\\cos(x)(0) - \\sin(x)(1) = -\\sin(x)\\)"
                ),
                time=150
            )
        end
    end
end