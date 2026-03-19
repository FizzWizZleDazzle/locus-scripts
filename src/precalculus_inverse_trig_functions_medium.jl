# precalculus - inverse_trig_functions (medium)
# Generated: 2026-03-08T20:31:11.023928

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/inverse_trig_functions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Evaluate arcsin/arccos/arctan of special values
        func = choice([:arcsin, :arccos, :arctan])
        
        if func == :arcsin
            values = [(-1, -π//2), (-1//2, -π//6), (0, 0), (1//2, π//6), (1, π//2)]
            val, ans = choice(values)
            problem(
                question="Evaluate \\arcsin\\left($(val)\\right). Give your answer in radians as a multiple of \\pi.",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "Recall that \\arcsin(x) returns the angle \\theta \\in [-\\pi/2, \\pi/2] such that \\sin(\\theta) = x",
                    "We need \\sin(\\theta) = $(val)",
                    sol("Answer", ans)
                ),
                time=90
            )
        elseif func == :arccos
            values = [(-1, π), (-1//2, 2π//3), (0, π//2), (1//2, π//3), (1, 0)]
            val, ans = choice(values)
            problem(
                question="Evaluate \\arccos\\left($(val)\\right). Give your answer in radians as a multiple of \\pi.",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "Recall that \\arccos(x) returns the angle \\theta \\in [0, \\pi] such that \\cos(\\theta) = x",
                    "We need \\cos(\\theta) = $(val)",
                    sol("Answer", ans)
                ),
                time=90
            )
        else  # arctan
            values = [(-1, -π//4), (0, 0), (1, π//4)]
            val, ans = choice(values)
            problem(
                question="Evaluate \\arctan\\left($(val)\\right). Give your answer in radians as a multiple of \\pi.",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "Recall that \\arctan(x) returns the angle \\theta \\in (-\\pi/2, \\pi/2) such that \\tan(\\theta) = x",
                    "We need \\tan(\\theta) = $(val)",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    elseif problem_type == 2
        # Simplify sin(arcsin(x)) or arcsin(sin(x))
        direction = rand(1:2)
        
        if direction == 1
            # sin(arcsin(x)) = x for x in [-1, 1]
            a = randint(-20, 20)
            b = nonzero(-20, 20)
            ans = a // b
            if abs(ans) > 1
                ans = ans / abs(ans)  # Clamp to [-1, 1]
            end
            problem(
                question="Simplify \\sin\\left(\\arcsin\\left(\\frac{$(a)}{$(b)}\\right)\\right), assuming the argument is in the domain of \\arcsin.",
                answer=ans,
                difficulty=(1300, 1500),
                solution=steps(
                    "Recall that \\sin(\\arcsin(x)) = x for all x \\in [-1, 1]",
                    "Check that \\left|\\frac{$(a)}{$(b)}\\right| \\leq 1",
                    sol("Answer", ans)
                ),
                time=60
            )
        else
            # arcsin(sin(x)) - need x in [-π/2, π/2]
            numerators = [-1, 0, 1]
            denominators = [6, 4, 3, 2]
            num = choice(numerators)
            denom = choice(denominators)
            x_val = num * π // denom
            ans = x_val
            problem(
                question="Simplify \\arcsin\\left(\\sin\\left(\\frac{$(num)\\pi}{$(denom)}\\right)\\right). Give your answer in radians as a multiple of \\pi.",
                answer=ans,
                difficulty=(1400, 1600),
                solution=steps(
                    "Recall that \\arcsin(\\sin(x)) = x when x \\in [-\\pi/2, \\pi/2]",
                    "Check that \\frac{$(num)\\pi}{$(denom)} is in this range",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    elseif problem_type == 3
        # Find domain of compositions like arcsin(2x) or arccos(x-1)
        func = choice([:arcsin, :arccos])
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        
        if func == :arcsin || func == :arccos
            # Need -1 ≤ ax + b ≤ 1
            left = (-1 - b) // a
            right = (1 - b) // a
            if a > 0
                ans = fmt_interval(left, right, true, true)
            else
                ans = fmt_interval(right, left, true, true)
            end
            
            func_name = func == :arcsin ? "\\arcsin" : "\\arccos"
            problem(
                question="Find the domain of f(x) = $(func_name)($(a)x + $(b)). Express your answer in interval notation.",
                answer=ans,
                answer_type="interval",
                difficulty=(1400, 1600),
                solution=steps(
                    "For $(func_name)(u) to be defined, we need -1 \\leq u \\leq 1",
                    "So we need -1 \\leq $(a)x + $(b) \\leq 1",
                    "Solving: $(left) \\leq x \\leq $(right)",
                    "Domain: $(ans)"
                ),
                time=120
            )
        end
        
    elseif problem_type == 4
        # Solve equations like arcsin(x) = π/6
        func = choice([:arcsin, :arccos, :arctan])
        
        if func == :arcsin
            angles = [(π//6, 1//2), (π//4, 1//2), (-π//6, -1//2), (0, 0)]
            angle, ans = choice(angles)
            problem(
                question="Solve \\arcsin(x) = \\frac{$(numerator(angle))\\pi}{$(denominator(angle))}",
                answer=ans,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given equation", "\\arcsin(x) = \\frac{$(numerator(angle))\\pi}{$(denominator(angle))}"),
                    "Take sine of both sides: x = \\sin\\left(\\frac{$(numerator(angle))\\pi}{$(denominator(angle))}\\right)",
                    sol("Answer", ans)
                ),
                time=90
            )
        elseif func == :arccos
            angles = [(π//3, 1//2), (π//4, 1//2), (2π//3, -1//2), (0, 1)]
            angle, ans = choice(angles)
            problem(
                question="Solve \\arccos(x) = \\frac{$(numerator(angle))\\pi}{$(denominator(angle))}",
                answer=ans,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given equation", "\\arccos(x) = \\frac{$(numerator(angle))\\pi}{$(denominator(angle))}"),
                    "Take cosine of both sides: x = \\cos\\left(\\frac{$(numerator(angle))\\pi}{$(denominator(angle))}\\right)",
                    sol("Answer", ans)
                ),
                time=90
            )
        else  # arctan
            angles = [(π//4, 1), (-π//4, -1), (0, 0)]
            angle, ans = choice(angles)
            problem(
                question="Solve \\arctan(x) = \\frac{$(numerator(angle))\\pi}{$(denominator(angle))}",
                answer=ans,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given equation", "\\arctan(x) = \\frac{$(numerator(angle))\\pi}{$(denominator(angle))}"),
                    "Take tangent of both sides: x = \\tan\\left(\\frac{$(numerator(angle))\\pi}{$(denominator(angle))}\\right)",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    elseif problem_type == 5
        # Compute compositions like sin(arccos(x))
        # sin(arccos(x)) = √(1-x²)
        a = randint(1, 12)
        b = randint(a+1, 15)
        x_val = a // b
        ans = sqrt(1 - x_val^2)
        
        problem(
            question="Evaluate \\sin\\left(\\arccos\\left(\\frac{$(a)}{$(b)}\\right)\\right). Simplify your answer.",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Let \\theta = \\arccos\\left(\\frac{$(a)}{$(b)}\\right), so \\cos(\\theta) = \\frac{$(a)}{$(b)}",
                "We want \\sin(\\theta). Use the identity \\sin^2(\\theta) + \\cos^2(\\theta) = 1",
                "\\sin(\\theta) = \\sqrt{1 - \\cos^2(\\theta)} = \\sqrt{1 - \\frac{$(a^2)}{$(b^2)}} = \\sqrt{\\frac{$(b^2 - a^2)}{$(b^2)}}",
                sol("Answer", ans)
            ),
            time=150
        )
        
    else  # problem_type == 6
        # Range questions
        func = choice([:arcsin, :arccos, :arctan])
        
        if func == :arcsin
            ans = fmt_interval(-π//2, π//2, true, true)
            problem(
                question="What is the range of f(x) = \\arcsin(x)? Express your answer in interval notation.",
                answer=ans,
                answer_type="interval",
                difficulty=(1200, 1400),
                solution=steps(
                    "The function \\arcsin(x) is defined as the inverse of \\sin(x) restricted to [-\\pi/2, \\pi/2]",
                    "Therefore, the range of \\arcsin(x) is the domain of the restricted sine function",
                    "Range: $(ans)"
                ),
                time=90
            )
        elseif func == :arccos
            ans = fmt_interval(0, π, true, true)
            problem(
                question="What is the range of f(x) = \\arccos(x)? Express your answer in interval notation.",
                answer=ans,
                answer_type="interval",
                difficulty=(1200, 1400),
                solution=steps(
                    "The function \\arccos(x) is defined as the inverse of \\cos(x) restricted to [0, \\pi]",
                    "Therefore, the range of \\arccos(x) is the domain of the restricted cosine function",
                    "Range: $(ans)"
                ),
                time=90
            )
        else  # arctan
            ans = fmt_interval(-π//2, π//2, false, false)
            problem(
                question="What is the range of f(x) = \\arctan(x)? Express your answer in interval notation.",
                answer=ans,
                answer_type="interval",
                difficulty=(1200, 1400),
                solution=steps(
                    "The function \\arctan(x) is defined as the inverse of \\tan(x) restricted to (-\\pi/2, \\pi/2)",
                    "Therefore, the range of \\arctan(x) is the domain of the restricted tangent function",
                    "Range: $(ans)"
                ),
                time=90
            )
        end
    end
end