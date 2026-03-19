# precalculus - inverse_trig_functions (very_hard)
# Generated: 2026-03-08T20:31:32.008063

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("precalculus/inverse_trig_functions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Exact value composition with nested inverse trig
        # e.g., arcsin(cos(arctan(sqrt(3))))
        inner_val = choice([1//2, sqrt(3)//2, 1//sqrt(2), sqrt(3), 1//sqrt(3), sqrt(3)//3])
        outer_choice = rand(1:3)
        
        if inner_val == sqrt(3)
            inner_angle = π//3
            inner_sin = sqrt(3)//2
            inner_cos = 1//2
            inner_tan = sqrt(3)
        elseif inner_val == 1//sqrt(3) || inner_val == sqrt(3)//3
            inner_angle = π//6
            inner_sin = 1//2
            inner_cos = sqrt(3)//2
            inner_tan = 1//sqrt(3)
        elseif inner_val == 1//2
            inner_angle = π//6
            inner_sin = 1//2
            inner_cos = sqrt(3)//2
            inner_tan = 1//sqrt(3)
        elseif inner_val == sqrt(3)//2
            inner_angle = π//3
            inner_sin = sqrt(3)//2
            inner_cos = 1//2
            inner_tan = sqrt(3)
        else  # 1/sqrt(2)
            inner_angle = π//4
            inner_sin = 1//sqrt(2)
            inner_cos = 1//sqrt(2)
            inner_tan = 1
        end
        
        if outer_choice == 1
            ans = inner_sin
            q_text = "\\arcsin\\left(\\cos\\left(\\arctan\\left($(tex(inner_val))\\right)\\right)\\right)"
            sol_text = steps(
                "Let \\(\\theta = \\arctan($(tex(inner_val)))\\), so \\(\\tan(\\theta) = $(tex(inner_val))\\)",
                "Construct a right triangle: opposite = \\($(tex(inner_val))\\), adjacent = 1, hypotenuse = \\(\\sqrt{$(tex(inner_val^2 + 1))}\\)",
                "Therefore \\(\\cos(\\theta) = \\frac{1}{\\sqrt{$(tex(inner_val^2 + 1))}}\\)",
                sol("Answer", ans)
            )
        elseif outer_choice == 2
            ans = inner_cos
            q_text = "\\arccos\\left(\\sin\\left(\\arctan\\left($(tex(inner_val))\\right)\\right)\\right)"
            sol_text = steps(
                "Let \\(\\theta = \\arctan($(tex(inner_val)))\\)",
                "From the right triangle with tan = $(tex(inner_val)), we get \\(\\sin(\\theta) = \\frac{$(tex(inner_val))}{\\sqrt{$(tex(inner_val^2 + 1))}}\\)",
                "Then \\(\\arccos\\left(\\sin(\\theta)\\right) = \\arccos\\left(\\frac{$(tex(inner_val))}{\\sqrt{$(tex(inner_val^2 + 1))}}\\right)\\)",
                sol("Answer", ans)
            )
        else
            ans = inner_tan
            q_text = "\\tan\\left(\\arcsin\\left(\\frac{$(tex(inner_val))}{\\sqrt{$(tex(inner_val^2 + 1))}}\\right)\\right)"
            sol_text = steps(
                "Let \\(\\theta = \\arcsin\\left(\\frac{$(tex(inner_val))}{\\sqrt{$(tex(inner_val^2 + 1))}}\\right)\\)",
                "Then \\(\\sin(\\theta) = \\frac{$(tex(inner_val))}{\\sqrt{$(tex(inner_val^2 + 1))}}\\), so opposite = $(tex(inner_val)), hypotenuse = \\(\\sqrt{$(tex(inner_val^2 + 1))}\\)",
                "Adjacent = 1, therefore \\(\\tan(\\theta) = $(tex(inner_val))\\)",
                sol("Answer", ans)
            )
        end
        
        problem(
            question="Evaluate: \\(" * q_text * "\\)",
            answer=ans,
            difficulty=(2500, 2900),
            solution=sol_text,
            time=240
        )
        
    elseif problem_type == 2
        # Solve inverse trig equation with algebraic manipulation
        # e.g., arcsin(2x) + arcsin(x) = π/2
        k = choice([2, 3, 4])
        target = choice([π//2, π//3, π//4, π//6])
        
        # For arcsin(kx) + arcsin(x) = target
        # Let α = arcsin(kx), β = arcsin(x)
        # sin(α + β) = sin(target)
        # sin(α)cos(β) + cos(α)sin(β) = sin(target)
        
        ans = 1//(2*k)
        
        problem(
            question="Solve for \\(x\\): \\(\\arcsin($(k)x) + \\arcsin(x) = \\frac{\\pi}{2}\\)",
            answer=ans,
            difficulty=(2700, 3200),
            solution=steps(
                "Let \\(\\alpha = \\arcsin($(k)x)\\) and \\(\\beta = \\arcsin(x)\\), so \\(\\alpha + \\beta = \\frac{\\pi}{2}\\)",
                "This means \\(\\alpha = \\frac{\\pi}{2} - \\beta\\), so \\(\\sin(\\alpha) = \\cos(\\beta)\\)",
                "Therefore \\($(k)x = \\sqrt{1-x^2}\\), squaring gives \\($(k^2)x^2 = 1-x^2\\)",
                "Solving: \\($(k^2+1)x^2 = 1\\), so \\(x^2 = \\frac{1}{$(k^2+1)}\\)",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Find domain of composition with inverse trig
        # e.g., arcsin(2x-1) + arccos(x)
        a = choice([2, 3, 4])
        b = randint(-3, 3)
        
        # Domain of arcsin(ax+b): -1 ≤ ax+b ≤ 1
        # Domain of arccos(x): -1 ≤ x ≤ 1
        
        left1 = (-1 - b) // a
        right1 = (1 - b) // a
        if a < 0
            left1, right1 = right1, left1
        end
        
        left_final = max(left1, -1)
        right_final = min(right1, 1)
        
        ans = fmt_interval(left_final, right_final, false, false)
        
        problem(
            question="Find the domain of \\(f(x) = \\arcsin($(a)x + $(b)) + \\arccos(x)\\)",
            answer=ans,
            difficulty=(2400, 2800),
            answer_type="interval",
            solution=steps(
                "For \\(\\arcsin($(a)x + $(b))\\): \\(-1 \\leq $(a)x + $(b) \\leq 1\\)",
                "This gives \\($(tex(left1)) \\leq x \\leq $(tex(right1))\\)",
                "For \\(\\arccos(x)\\): \\(-1 \\leq x \\leq 1\\)",
                "Intersection: \\([$(tex(left_final)), $(tex(right_final))]\\)",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Prove identity involving inverse trig
        # e.g., arctan(x) + arctan(1/x) = π/2 for x > 0
        
        problem(
            question="Prove that for \\(x > 1\\): \\(\\arctan(x) + \\arctan\\left(\\frac{1}{x}\\right) = \\frac{\\pi}{2}\\)",
            answer="\\frac{\\pi}{2}",
            difficulty=(2800, 3300),
            solution=steps(
                "Let \\(\\alpha = \\arctan(x)\\) and \\(\\beta = \\arctan\\left(\\frac{1}{x}\\right)\\)",
                "Then \\(\\tan(\\alpha) = x\\) and \\(\\tan(\\beta) = \\frac{1}{x}\\)",
                "Using the tangent addition formula: \\(\\tan(\\alpha + \\beta) = \\frac{\\tan(\\alpha) + \\tan(\\beta)}{1 - \\tan(\\alpha)\\tan(\\beta)} = \\frac{x + \\frac{1}{x}}{1 - x \\cdot \\frac{1}{x}}\\)",
                "The denominator is \\(1 - 1 = 0\\), so \\(\\tan(\\alpha + \\beta)\\) is undefined",
                "This means \\(\\alpha + \\beta = \\frac{\\pi}{2}\\) (since both angles are in the first quadrant)",
                sol("Therefore", "\\arctan(x) + \\arctan\\left(\\frac{1}{x}\\right) = \\frac{\\pi}{2}")
            ),
            time=300
        )
        
    else  # problem_type == 5
        # Sum of arctangents using addition formula
        # arctan(a) + arctan(b) = arctan((a+b)/(1-ab))
        a = randint(2, 5)
        b = randint(2, 5)
        
        if a*b == 1
            b = b + 1
        end
        
        if a*b > 1
            # Result will involve π
            numerator = a + b
            denominator = 1 - a*b
            ans_val = atan(numerator // denominator)
            
            problem(
                question="Express \\(\\arctan($(a)) + \\arctan($(b))\\) in the form \\(\\arctan(r) + k\\pi\\) where \\(-\\frac{\\pi}{2} < \\arctan(r) < \\frac{\\pi}{2}\\). Find \\(r\\).",
                answer=numerator // denominator,
                difficulty=(2600, 3100),
                solution=steps(
                    "Use the formula: \\(\\arctan(a) + \\arctan(b) = \\arctan\\left(\\frac{a+b}{1-ab}\\right) + k\\pi\\)",
                    "Here \\(a = $(a)\\), \\(b = $(b)\\), so \\(ab = $(a*b) > 1\\)",
                    "Calculate: \\(\\frac{$(a) + $(b)}{1 - $(a*b)} = \\frac{$(numerator)}{$(denominator)}\\)",
                    "Since \\(ab > 1\\), we add \\(\\pi\\) to bring the result into the principal range",
                    sol("r", numerator // denominator)
                ),
                time=270
            )
        else
            numerator = a + b
            denominator = 1 - a*b
            ans = numerator // denominator
            
            problem(
                question="Simplify \\(\\arctan($(a)) + \\arctan($(b))\\) to \\(\\arctan(r)\\). Find \\(r\\).",
                answer=ans,
                difficulty=(2500, 2900),
                solution=steps(
                    "Use the arctangent addition formula: \\(\\arctan(a) + \\arctan(b) = \\arctan\\left(\\frac{a+b}{1-ab}\\right)\\)",
                    "Substitute \\(a = $(a)\\) and \\(b = $(b)\\)",
                    "Calculate: \\(\\frac{$(a) + $(b)}{1 - $(a) \\cdot $(b)} = \\frac{$(numerator)}{$(denominator)}\\)",
                    sol("r", ans)
                ),
                time=240
            )
        end
    end
end