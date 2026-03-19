# precalculus - inverse_trig_functions (easy)
# Generated: 2026-03-08T20:30:49.512157

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/inverse_trig_functions")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Basic arcsin evaluation with standard values
        values = [(-1, -90), (-1//2, -30), (0, 0), (1//2, 30), (1, 90)]
        val, ans_deg = choice(values)
        ans_rad = ans_deg * π // 180
        
        problem(
            question="Evaluate \\arcsin\\left($(val)\\right) in radians.",
            answer=ans_rad,
            difficulty=(700, 900),
            solution=steps(
                "Recall that \\arcsin(x) returns the angle θ where \\sin(θ) = x and θ ∈ [-π/2, π/2]",
                "We need the angle whose sine is $(val)",
                sol("Answer", ans_rad)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Basic arccos evaluation with standard values
        values = [(-1, 180), (-1//2, 120), (0, 90), (1//2, 60), (1, 0)]
        val, ans_deg = choice(values)
        ans_rad = ans_deg * π // 180
        
        problem(
            question="Evaluate \\arccos\\left($(val)\\right) in radians.",
            answer=ans_rad,
            difficulty=(700, 900),
            solution=steps(
                "Recall that \\arccos(x) returns the angle θ where \\cos(θ) = x and θ ∈ [0, π]",
                "We need the angle whose cosine is $(val)",
                sol("Answer", ans_rad)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Basic arctan evaluation
        values = [(-1, -45), (0, 0), (1, 45)]
        val, ans_deg = choice(values)
        ans_rad = ans_deg * π // 180
        
        problem(
            question="Evaluate \\arctan\\left($(val)\\right) in radians.",
            answer=ans_rad,
            difficulty=(700, 900),
            solution=steps(
                "Recall that \\arctan(x) returns the angle θ where \\tan(θ) = x and θ ∈ (-π/2, π/2)",
                "We need the angle whose tangent is $(val)",
                sol("Answer", ans_rad)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Composition: sin(arcsin(x))
        x_val = randint(-10, 10) // choice([2, 4, 5, 10])
        if abs(x_val) > 1
            x_val = x_val // 10
        end
        
        problem(
            question="Simplify \\sin\\left(\\arcsin\\left($(x_val)\\right)\\right).",
            answer=x_val,
            difficulty=(800, 1000),
            solution=steps(
                "For x in the domain of arcsin ([-1, 1]), \\sin(\\arcsin(x)) = x",
                "Since $(x_val) is in [-1, 1], we can apply this identity",
                sol("Answer", x_val)
            ),
            time=45
        )
        
    elseif problem_type == 5
        # Composition: arcsin(sin(θ)) where θ is in range
        angles_deg = [-90, -60, -45, -30, 0, 30, 45, 60, 90]
        theta_deg = choice(angles_deg)
        theta_rad = theta_deg * π // 180
        
        problem(
            question="Evaluate \\arcsin\\left(\\sin\\left($(tex(theta_rad))\\right)\\right).",
            answer=theta_rad,
            difficulty=(900, 1100),
            solution=steps(
                "Since $(tex(theta_rad)) is in the range [-π/2, π/2], we have \\arcsin(\\sin(θ)) = θ",
                "The angle $(tex(theta_rad)) is within the principal range of arcsin",
                sol("Answer", theta_rad)
            ),
            time=75
        )
        
    else
        # tan(arcsin(x)) - requires drawing right triangle
        numerator = randint(1, 4)
        denominator = randint(numerator + 1, 5)
        x_val = numerator // denominator
        
        # In right triangle: opposite = numerator, hypotenuse = denominator
        # adjacent = sqrt(denominator^2 - numerator^2)
        adjacent_sq = denominator^2 - numerator^2
        
        problem(
            question="Evaluate \\tan\\left(\\arcsin\\left(\\frac{$(numerator)}{$(denominator)}\\right)\\right).",
            answer=numerator // isqrt(adjacent_sq),
            difficulty=(1000, 1200),
            solution=steps(
                "Let θ = \\arcsin($(numerator)/$(denominator)), so \\sin(θ) = $(numerator)/$(denominator)",
                "Draw a right triangle: opposite = $(numerator), hypotenuse = $(denominator)",
                "Using Pythagorean theorem: adjacent = \\sqrt{$(denominator)^2 - $(numerator)^2} = \\sqrt{$(adjacent_sq)} = $(isqrt(adjacent_sq))",
                "Therefore \\tan(θ) = opposite/adjacent = $(numerator)/$(isqrt(adjacent_sq))",
                sol("Answer", numerator // isqrt(adjacent_sq))
            ),
            time=120
        )
    end
end