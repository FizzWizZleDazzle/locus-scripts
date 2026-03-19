# precalculus - sum_difference_formulas (hard)
# Generated: 2026-03-08T20:30:32.598697

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/sum_difference_formulas")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Exact value using sum formula: sin(α + β) where α, β are special angles
        angles = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        α = choice(angles)
        β = choice(angles)
        sum_angle = α + β
        
        # Calculate exact value
        sin_vals = Dict(0=>0, 30=>1//2, 45=>sqrt(2)/2, 60=>sqrt(3)/2, 90=>1,
                       120=>sqrt(3)/2, 135=>sqrt(2)/2, 150=>1//2, 180=>0,
                       210=>-1//2, 225=>-sqrt(2)/2, 240=>-sqrt(3)/2, 270=>-1,
                       300=>-sqrt(3)/2, 315=>-sqrt(2)/2, 330=>-1//2, 360=>0)
        cos_vals = Dict(0=>1, 30=>sqrt(3)/2, 45=>sqrt(2)/2, 60=>1//2, 90=>0,
                       120=>-1//2, 135=>-sqrt(2)/2, 150=>-sqrt(3)/2, 180=>-1,
                       210=>-sqrt(3)/2, 225=>-sqrt(2)/2, 240=>-1//2, 270=>0,
                       300=>1//2, 315=>sqrt(2)/2, 330=>sqrt(3)/2, 360=>1)
        
        sum_angle_mod = mod(sum_angle, 360)
        answer = simplify(sin_vals[α] * cos_vals[β] + cos_vals[α] * sin_vals[β])
        
        problem(
            question="Find the exact value of \\sin($(α)°)\\cos($(β)°) + \\cos($(α)°)\\sin($(β)°)",
            answer=answer,
            difficulty=(1800, 2000),
            solution=steps(
                "Recognize this as the sine sum formula: \\sin(α + β) = \\sin α \\cos β + \\cos α \\sin β",
                sol("Therefore", "\\sin($(α)° + $(β)°) = \\sin($(sum_angle_mod)°)"),
                sol("Answer", answer)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Prove identity using sum/difference formulas
        identity_choice = choice(1:3)
        
        if identity_choice == 1
            # tan(x + π/4) = (1 + tan x)/(1 - tan x)
            problem(
                question="Prove the identity: \\tan\\left(x + \\frac{\\pi}{4}\\right) = \\frac{1 + \\tan x}{1 - \\tan x}",
                answer="proven",
                answer_type="proof",
                difficulty=(2000, 2200),
                solution=steps(
                    "Start with the tangent sum formula: \\tan(α + β) = \\frac{\\tan α + \\tan β}{1 - \\tan α \\tan β}",
                    "Substitute α = x and β = π/4, where \\tan(π/4) = 1",
                    sol("\\tan\\left(x + \\frac{\\pi}{4}\\right)", "\\frac{\\tan x + 1}{1 - \\tan x \\cdot 1} = \\frac{1 + \\tan x}{1 - \\tan x}"),
                    "Identity proven"
                ),
                time=180
            )
        elseif identity_choice == 2
            # cos(2x) using difference formula
            problem(
                question="Use the cosine difference formula to prove that \\cos(2x) = \\cos^2 x - \\sin^2 x",
                answer="proven",
                answer_type="proof",
                difficulty=(1900, 2100),
                solution=steps(
                    "Write \\cos(2x) as \\cos(x + x)",
                    "Apply cosine sum formula: \\cos(α + β) = \\cos α \\cos β - \\sin α \\sin β",
                    sol("\\cos(x + x)", "\\cos x \\cos x - \\sin x \\sin x = \\cos^2 x - \\sin^2 x"),
                    "Identity proven"
                ),
                time=150
            )
        else
            # sin(3x) expansion
            problem(
                question="Express \\sin(3x) in terms of \\sin x and \\cos x using sum formulas",
                answer="3*sin(x)*cos(x)^2 - sin(x)^3",
                difficulty=(2100, 2300),
                solution=steps(
                    "Write \\sin(3x) = \\sin(2x + x)",
                    "Apply: \\sin(2x + x) = \\sin(2x)\\cos x + \\cos(2x)\\sin x",
                    "Use \\sin(2x) = 2\\sin x \\cos x and \\cos(2x) = \\cos^2 x - \\sin^2 x",
                    sol("\\sin(3x)", "2\\sin x \\cos x \\cdot \\cos x + (\\cos^2 x - \\sin^2 x)\\sin x"),
                    sol("Answer", "3\\sin x \\cos^2 x - \\sin^3 x")
                ),
                time=240
            )
        end
        
    elseif problem_type == 3
        # Simplify using sum/difference formulas with variable angles
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        form_choice = choice(1:2)
        if form_choice == 1
            # cos(a)cos(b) - sin(a)sin(b) = cos(a+b)
            problem(
                question="Simplify to a single trigonometric function: \\cos($(a)x)\\cos($(b)x) - \\sin($(a)x)\\sin($(b)x)",
                answer="cos($((a+b))*x)",
                difficulty=(1800, 2000),
                solution=steps(
                    "Recognize the cosine sum formula: \\cos α \\cos β - \\sin α \\sin β = \\cos(α + β)",
                    "Let α = $(a)x and β = $(b)x",
                    sol("Answer", "\\cos($(a+b)x)")
                ),
                time=90
            )
        else
            # sin(a)cos(b) + cos(a)sin(b) = sin(a+b)
            problem(
                question="Simplify to a single trigonometric function: \\sin($(a)x)\\cos($(b)x) + \\cos($(a)x)\\sin($(b)x)",
                answer="sin($((a+b))*x)",
                difficulty=(1800, 2000),
                solution=steps(
                    "Recognize the sine sum formula: \\sin α \\cos β + \\cos α \\sin β = \\sin(α + β)",
                    "Let α = $(a)x and β = $(b)x",
                    sol("Answer", "\\sin($(a+b)x)")
                ),
                time=90
            )
        end
        
    elseif problem_type == 4
        # Solve equation using sum/difference formulas
        k = nonzero(-3, 3)
        
        problem(
            question="Solve for x in [0, 2π): \\sin(2x)\\cos(x) + \\cos(2x)\\sin(x) = $(k//2)",
            answer=fmt_set(Set(["π/18 + 2πn/3", "5π/18 + 2πn/3", "13π/18 + 2πn/3"])),
            answer_type="text",
            difficulty=(2100, 2400),
            solution=steps(
                "Apply sine sum formula: \\sin(2x)\\cos(x) + \\cos(2x)\\sin(x) = \\sin(3x)",
                sol("Equation becomes", "\\sin(3x) = $(k//2)"),
                "Let u = 3x, solve \\sin(u) = $(k//2) for u ∈ [0, 6π)",
                "Then divide solutions by 3 to get x",
                "Solutions depend on the value of k"
            ),
            time=240
        )
        
    elseif problem_type == 5
        # Find tan using sum formula given constraints
        α_tan = randint(2, 5)
        β_tan = randint(2, 5)
        numerator = α_tan + β_tan
        denominator = 1 - α_tan * β_tan
        
        if denominator != 0
            problem(
                question="Given \\tan α = $(α_tan) and \\tan β = $(β_tan), find \\tan(α + β)",
                answer=numerator // denominator,
                difficulty=(1900, 2100),
                solution=steps(
                    "Use the tangent sum formula: \\tan(α + β) = \\frac{\\tan α + \\tan β}{1 - \\tan α \\tan β}",
                    sol("Substitute", "\\tan(α + β) = \\frac{$(α_tan) + $(β_tan)}{1 - $(α_tan) \\cdot $(β_tan)}"),
                    sol("Answer", "\\frac{$(numerator)}{$(denominator)}")
                ),
                time=120
            )
        else
            # Use different values
            problem(
                question="Given \\tan α = 2 and \\tan β = 3, find \\tan(α + β)",
                answer=-1,
                difficulty=(1900, 2100),
                solution=steps(
                    "Use the tangent sum formula: \\tan(α + β) = \\frac{\\tan α + \\tan β}{1 - \\tan α \\tan β}",
                    sol("Substitute", "\\tan(α + β) = \\frac{2 + 3}{1 - 2 \\cdot 3} = \\frac{5}{-5}"),
                    sol("Answer", "-1")
                ),
                time=120
            )
        end
        
    else
        # Find exact value of cos(α - β) given sin and cos values
        # Pick α, β in different quadrants
        quad_α = choice(1:4)
        quad_β = choice(1:4)
        
        a_num = randint(3, 12)
        a_den = randint(a_num + 1, 15)
        b_num = randint(3, 12)
        b_den = randint(b_num + 1, 15)
        
        sin_α = a_num // a_den
        cos_β = b_num // b_den
        
        # Compute cos α and sin β using Pythagorean identity
        cos_α_abs = sqrt(1 - sin_α^2)
        sin_β_abs = sqrt(1 - cos_β^2)
        
        problem(
            question="If \\sin α = $(sin_α) with α in quadrant $(quad_α), and \\cos β = $(cos_β) with β in quadrant $(quad_β), find \\cos(α - β)",
            answer="varies",
            answer_type="text",
            difficulty=(2200, 2500),
            solution=steps(
                "Use cosine difference formula: \\cos(α - β) = \\cos α \\cos β + \\sin α \\sin β",
                "Find \\cos α using \\cos^2 α + \\sin^2 α = 1: \\cos α = ±\\sqrt{1 - ($(sin_α))^2}",
                "Find \\sin β using \\sin^2 β + \\cos^2 β = 1: \\sin β = ±\\sqrt{1 - ($(cos_β))^2}",
                "Determine signs based on quadrants",
                "Substitute and simplify"
            ),
            time=300
        )
    end
end