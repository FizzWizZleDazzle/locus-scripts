# precalculus - sum_difference_formulas (easy)
# Generated: 2026-03-08T20:30:24.571112

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/sum_difference_formulas")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Direct application: sin(A + B) = sin(A)cos(B) + cos(A)sin(B)
        angles = [30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        A = choice(angles)
        B = choice(angles)
        sum_angle = A + B
        
        # Calculate exact values
        sin_vals = Dict(0=>0, 30=>1//2, 45=>sqrt(2)//2, 60=>sqrt(3)//2, 90=>1, 
                       120=>sqrt(3)//2, 135=>sqrt(2)//2, 150=>1//2, 180=>0,
                       210=>-1//2, 225=>-sqrt(2)//2, 240=>-sqrt(3)//2, 270=>-1,
                       300=>-sqrt(3)//2, 315=>-sqrt(2)//2, 330=>-1//2, 360=>0)
        cos_vals = Dict(0=>1, 30=>sqrt(3)//2, 45=>sqrt(2)//2, 60=>1//2, 90=>0,
                       120=>-1//2, 135=>-sqrt(2)//2, 150=>-sqrt(3)//2, 180=>-1,
                       210=>-sqrt(3)//2, 225=>-sqrt(2)//2, 240=>-1//2, 270=>0,
                       300=>1//2, 315=>sqrt(2)//2, 330=>sqrt(3)//2, 360=>1)
        
        result = simplify(sin_vals[A] * cos_vals[B] + cos_vals[A] * sin_vals[B])
        
        problem(
            question="Use the sum formula to find the exact value of \\sin($(A)° + $(B)°)",
            answer=result,
            difficulty=(700, 900),
            solution=steps(
                "Use \\sin(A + B) = \\sin(A)\\cos(B) + \\cos(A)\\sin(B)",
                sol("\\sin($(A)°)\\cos($(B)°) + \\cos($(A)°)\\sin($(B)°)", 
                    sin_vals[A] * cos_vals[B] + cos_vals[A] * sin_vals[B]),
                sol("Simplified", result)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # cos(A - B) = cos(A)cos(B) + sin(A)sin(B)
        angles = [30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        A = choice(angles)
        B = choice(filter(x -> x < A, angles))
        
        sin_vals = Dict(0=>0, 30=>1//2, 45=>sqrt(2)//2, 60=>sqrt(3)//2, 90=>1, 
                       120=>sqrt(3)//2, 135=>sqrt(2)//2, 150=>1//2, 180=>0,
                       210=>-1//2, 225=>-sqrt(2)//2, 240=>-sqrt(3)//2, 270=>-1,
                       300=>-sqrt(3)//2, 315=>-sqrt(2)//2, 330=>-1//2, 360=>0)
        cos_vals = Dict(0=>1, 30=>sqrt(3)//2, 45=>sqrt(2)//2, 60=>1//2, 90=>0,
                       120=>-1//2, 135=>-sqrt(2)//2, 150=>-sqrt(3)//2, 180=>-1,
                       210=>-sqrt(3)//2, 225=>-sqrt(2)//2, 240=>-1//2, 270=>0,
                       300=>1//2, 315=>sqrt(2)//2, 330=>sqrt(3)//2, 360=>1)
        
        result = simplify(cos_vals[A] * cos_vals[B] + sin_vals[A] * sin_vals[B])
        
        problem(
            question="Use the difference formula to find the exact value of \\cos($(A)° - $(B)°)",
            answer=result,
            difficulty=(700, 900),
            solution=steps(
                "Use \\cos(A - B) = \\cos(A)\\cos(B) + \\sin(A)\\sin(B)",
                sol("\\cos($(A)°)\\cos($(B)°) + \\sin($(A)°)\\sin($(B)°)",
                    cos_vals[A] * cos_vals[B] + sin_vals[A] * sin_vals[B]),
                sol("Simplified", result)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Simplify using sum/difference formulas
        angle1 = choice([15, 75, 105, 165, 195, 255, 285, 345])
        
        decompositions = Dict(
            15 => (45, 30, "-"),
            75 => (45, 30, "+"),
            105 => (60, 45, "+"),
            165 => (120, 45, "+"),
            195 => (150, 45, "+"),
            255 => (210, 45, "+"),
            285 => (240, 45, "+"),
            345 => (315, 30, "+")
        )
        
        A, B, op = decompositions[angle1]
        
        sin_vals = Dict(0=>0, 30=>1//2, 45=>sqrt(2)//2, 60=>sqrt(3)//2, 90=>1, 
                       120=>sqrt(3)//2, 135=>sqrt(2)//2, 150=>1//2, 180=>0,
                       210=>-1//2, 225=>-sqrt(2)//2, 240=>-sqrt(3)//2, 270=>-1,
                       300=>-sqrt(3)//2, 315=>-sqrt(2)//2, 330=>-1//2, 360=>0)
        cos_vals = Dict(0=>1, 30=>sqrt(3)//2, 45=>sqrt(2)//2, 60=>1//2, 90=>0,
                       120=>-1//2, 135=>-sqrt(2)//2, 150=>-sqrt(3)//2, 180=>-1,
                       210=>-sqrt(3)//2, 225=>-sqrt(2)//2, 240=>-1//2, 270=>0,
                       300=>1//2, 315=>sqrt(2)//2, 330=>sqrt(3)//2, 360=>1)
        
        if op == "+"
            result = simplify(sin_vals[A] * cos_vals[B] + cos_vals[A] * sin_vals[B])
        else
            result = simplify(sin_vals[A] * cos_vals[B] - cos_vals[A] * sin_vals[B])
        end
        
        problem(
            question="Find the exact value of \\sin($(angle1)°) by writing it as \\sin($(A)° $(op) $(B)°)",
            answer=result,
            difficulty=(800, 1000),
            solution=steps(
                "Write \\sin($(angle1)°) = \\sin($(A)° $(op) $(B)°)",
                "Apply sum/difference formula",
                sol("\\sin($(A)°)\\cos($(B)°) $(op == "+" ? "+" : "-") \\cos($(A)°)\\sin($(B)°)",
                    sin_vals[A] * cos_vals[B] + (op == "+" ? 1 : -1) * cos_vals[A] * sin_vals[B]),
                sol("Simplified", result)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # tan(A + B) formula
        angles = [30, 45, 60, 120, 135, 150, 210, 225, 240, 300, 315, 330]
        A = choice(angles)
        B = choice(angles)
        
        tan_vals = Dict(30=>1//sqrt(3), 45=>1, 60=>sqrt(3), 90=>Inf,
                       120=>-sqrt(3), 135=>-1, 150=>-1//sqrt(3),
                       210=>1//sqrt(3), 225=>1, 240=>sqrt(3),
                       300=>-sqrt(3), 315=>-1, 330=>-1//sqrt(3))
        
        tan_A = tan_vals[A]
        tan_B = tan_vals[B]
        result = simplify((tan_A + tan_B) / (1 - tan_A * tan_B))
        
        problem(
            question="Use the sum formula for tangent to find \\tan($(A)° + $(B)°)",
            answer=result,
            difficulty=(900, 1100),
            solution=steps(
                "Use \\tan(A + B) = \\frac{\\tan(A) + \\tan(B)}{1 - \\tan(A)\\tan(B)}",
                sol("\\frac{\\tan($(A)°) + \\tan($(B)°)}{1 - \\tan($(A)°)\\tan($(B)°)}",
                    (tan_A + tan_B) / (1 - tan_A * tan_B)),
                sol("Simplified", result)
            ),
            time=120
        )
        
    else
        # Given sin and cos of angles, find sin(A+B)
        quad_A = choice(1:4)
        quad_B = choice(1:4)
        
        denom_A = choice([5, 13, 17])
        denom_B = choice([5, 13, 17])
        
        if quad_A == 1
            sin_A = choice([3//5, 5//13, 8//17])
            cos_A = sqrt(1 - sin_A^2)
        elseif quad_A == 2
            sin_A = choice([3//5, 5//13, 8//17])
            cos_A = -sqrt(1 - sin_A^2)
        elseif quad_A == 3
            sin_A = -choice([3//5, 5//13, 8//17])
            cos_A = -sqrt(1 - sin_A^2)
        else
            sin_A = -choice([3//5, 5//13, 8//17])
            cos_A = sqrt(1 - sin_A^2)
        end
        
        if quad_B == 1
            sin_B = choice([3//5, 5//13, 8//17])
            cos_B = sqrt(1 - sin_B^2)
        elseif quad_B == 2
            sin_B = choice([3//5, 5//13, 8//17])
            cos_B = -sqrt(1 - sin_B^2)
        elseif quad_B == 3
            sin_B = -choice([3//5, 5//13, 8//17])
            cos_B = -sqrt(1 - sin_B^2)
        else
            sin_B = -choice([3//5, 5//13, 8//17])
            cos_B = sqrt(1 - sin_B^2)
        end
        
        result = simplify(sin_A * cos_B + cos_A * sin_B)
        
        problem(
            question="If \\sin(A) = $(tex(sin_A)) and \\sin(B) = $(tex(sin_B)), with A in quadrant $(quad_A) and B in quadrant $(quad_B), find \\sin(A + B)",
            answer=result,
            difficulty=(1000, 1200),
            solution=steps(
                "Find \\cos(A) = $(tex(cos_A)) and \\cos(B) = $(tex(cos_B)) using the Pythagorean identity",
                "Apply \\sin(A + B) = \\sin(A)\\cos(B) + \\cos(A)\\sin(B)",
                sol("($(tex(sin_A)))($(tex(cos_B))) + ($(tex(cos_A)))($(tex(sin_B)))", 
                    sin_A * cos_B + cos_A * sin_B),
                sol("Simplified", result)
            ),
            time=180
        )
    end
end