# precalculus - unit_circle (very_easy)
# Generated: 2026-03-08T20:26:52.931325

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script θ begin
    set_topic!("precalculus/unit_circle")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Find angle given exact trig value (100-400 ELO)
        angles = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        angle_deg = choice(angles)
        angle_rad = angle_deg * π // 180
        
        trig_func = choice(["sin", "cos", "tan"])
        
        if trig_func == "sin"
            values = Dict(0=>0, 30=>1//2, 45=>sqrt(2)//2, 60=>sqrt(3)//2, 90=>1,
                         120=>sqrt(3)//2, 135=>sqrt(2)//2, 150=>1//2, 180=>0,
                         210=>-1//2, 225=>-sqrt(2)//2, 240=>-sqrt(3)//2, 270=>-1,
                         300=>-sqrt(3)//2, 315=>-sqrt(2)//2, 330=>-1//2)
            val = values[angle_deg]
            problem(
                question="Find the angle θ in degrees (0° ≤ θ < 360°) where \\sin(θ) = $(tex(val))",
                answer=angle_deg,
                difficulty=(200, 400),
                solution=steps(
                    "Recall unit circle values for sine",
                    "\\sin(θ) = $(tex(val))",
                    sol("Answer", "θ = $(angle_deg)°")
                ),
                time=45
            )
        elseif trig_func == "cos"
            values = Dict(0=>1, 30=>sqrt(3)//2, 45=>sqrt(2)//2, 60=>1//2, 90=>0,
                         120=>-1//2, 135=>-sqrt(2)//2, 150=>-sqrt(3)//2, 180=>-1,
                         210=>-sqrt(3)//2, 225=>-sqrt(2)//2, 240=>-1//2, 270=>0,
                         300=>1//2, 315=>sqrt(2)//2, 330=>sqrt(3)//2)
            val = values[angle_deg]
            problem(
                question="Find the angle θ in degrees (0° ≤ θ < 360°) where \\cos(θ) = $(tex(val))",
                answer=angle_deg,
                difficulty=(200, 400),
                solution=steps(
                    "Recall unit circle values for cosine",
                    "\\cos(θ) = $(tex(val))",
                    sol("Answer", "θ = $(angle_deg)°")
                ),
                time=45
            )
        else
            # tan is slightly harder, only use certain angles
            valid_tan = [0, 30, 45, 60, 135, 150, 180, 210, 225, 240, 315, 330]
            angle_deg = choice(valid_tan)
            values = Dict(0=>0, 30=>sqrt(3)//3, 45=>1, 60=>sqrt(3),
                         135=>-1, 150=>-sqrt(3)//3, 180=>0,
                         210=>sqrt(3)//3, 225=>1, 240=>-sqrt(3),
                         315=>-1, 330=>-sqrt(3)//3)
            val = values[angle_deg]
            problem(
                question="Find the angle θ in degrees (0° ≤ θ < 360°) where \\tan(θ) = $(tex(val))",
                answer=angle_deg,
                difficulty=(300, 500),
                solution=steps(
                    "Recall unit circle values for tangent",
                    "\\tan(θ) = $(tex(val))",
                    sol("Answer", "θ = $(angle_deg)°")
                ),
                time=60
            )
        end
        
    elseif problem_type == 2
        # Evaluate trig function at special angle (100-300 ELO)
        angles = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        angle_deg = choice(angles)
        
        trig_func = choice(["\\sin", "\\cos", "\\tan"])
        
        if trig_func == "\\sin"
            values = Dict(0=>0, 30=>1//2, 45=>sqrt(2)//2, 60=>sqrt(3)//2, 90=>1,
                         120=>sqrt(3)//2, 135=>sqrt(2)//2, 150=>1//2, 180=>0,
                         210=>-1//2, 225=>-sqrt(2)//2, 240=>-sqrt(3)//2, 270=>-1,
                         300=>-sqrt(3)//2, 315=>-sqrt(2)//2, 330=>-1//2)
            ans = values[angle_deg]
        elseif trig_func == "\\cos"
            values = Dict(0=>1, 30=>sqrt(3)//2, 45=>sqrt(2)//2, 60=>1//2, 90=>0,
                         120=>-1//2, 135=>-sqrt(2)//2, 150=>-sqrt(3)//2, 180=>-1,
                         210=>-sqrt(3)//2, 225=>-sqrt(2)//2, 240=>-1//2, 270=>0,
                         300=>1//2, 315=>sqrt(2)//2, 330=>sqrt(3)//2)
            ans = values[angle_deg]
        else
            valid_tan = [0, 30, 45, 60, 135, 150, 180, 210, 225, 240, 315, 330]
            angle_deg = choice(valid_tan)
            values = Dict(0=>0, 30=>sqrt(3)//3, 45=>1, 60=>sqrt(3),
                         135=>-1, 150=>-sqrt(3)//3, 180=>0,
                         210=>sqrt(3)//3, 225=>1, 240=>-sqrt(3),
                         315=>-1, 330=>-sqrt(3)//3)
            ans = values[angle_deg]
        end
        
        problem(
            question="Evaluate $(trig_func)($(angle_deg)°)",
            answer=ans,
            difficulty=(100, 300),
            solution=steps(
                "Locate $(angle_deg)° on the unit circle",
                "Read the $(trig_func == "\\sin" ? "y" : trig_func == "\\cos" ? "x" : "y/x")-coordinate",
                sol("Answer", ans)
            ),
            time=30
        )
        
    elseif problem_type == 3
        # Convert degrees to radians (400-600 ELO)
        angles_deg = [30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330, 360]
        angle_deg = choice(angles_deg)
        angle_rad = angle_deg * π // 180
        
        problem(
            question="Convert $(angle_deg)° to radians. Express as a multiple of π.",
            answer=angle_rad,
            difficulty=(400, 600),
            solution=steps(
                "Use conversion: radians = degrees × \\frac{π}{180}",
                sol("Calculation", "$(angle_deg) \\times \\frac{π}{180} = $(tex(angle_rad))"),
                sol("Answer", angle_rad)
            ),
            time=45
        )
        
    elseif problem_type == 4
        # Convert radians to degrees (400-600 ELO)
        rads = [π//6, π//4, π//3, π//2, 2π//3, 3π//4, 5π//6, π, 7π//6, 5π//4, 4π//3, 3π//2, 5π//3, 7π//4, 11π//6, 2π]
        angle_rad = choice(rads)
        angle_deg = round(Int, 180 * angle_rad / π)
        
        problem(
            question="Convert \$$(tex(angle_rad))\$ radians to degrees.",
            answer=angle_deg,
            difficulty=(400, 600),
            solution=steps(
                "Use conversion: degrees = radians × \\frac{180}{π}",
                sol("Calculation", "$(tex(angle_rad)) \\times \\frac{180}{π} = $(angle_deg)°"),
                sol("Answer", "$(angle_deg)°")
            ),
            time=45
        )
        
    elseif problem_type == 5
        # Find coordinates on unit circle (300-500 ELO)
        angles = [0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330]
        angle_deg = choice(angles)
        
        cos_values = Dict(0=>1, 30=>sqrt(3)//2, 45=>sqrt(2)//2, 60=>1//2, 90=>0,
                         120=>-1//2, 135=>-sqrt(2)//2, 150=>-sqrt(3)//2, 180=>-1,
                         210=>-sqrt(3)//2, 225=>-sqrt(2)//2, 240=>-1//2, 270=>0,
                         300=>1//2, 315=>sqrt(2)//2, 330=>sqrt(3)//2)
        sin_values = Dict(0=>0, 30=>1//2, 45=>sqrt(2)//2, 60=>sqrt(3)//2, 90=>1,
                         120=>sqrt(3)//2, 135=>sqrt(2)//2, 150=>1//2, 180=>0,
                         210=>-1//2, 225=>-sqrt(2)//2, 240=>-sqrt(3)//2, 270=>-1,
                         300=>-sqrt(3)//2, 315=>-sqrt(2)//2, 330=>-1//2)
        
        x_coord = cos_values[angle_deg]
        y_coord = sin_values[angle_deg]
        
        problem(
            question="Find the coordinates (x, y) of the point on the unit circle at angle $(angle_deg)°.",
            answer=fmt_tuple((x_coord, y_coord)),
            difficulty=(300, 500),
            answer_type="tuple",
            solution=steps(
                "On the unit circle, x = cos(θ) and y = sin(θ)",
                "x = \\cos($(angle_deg)°) = $(tex(x_coord))",
                "y = \\sin($(angle_deg)°) = $(tex(y_coord))",
                sol("Answer", fmt_tuple((x_coord, y_coord)))
            ),
            time=60
        )
        
    else
        # Identify quadrant (200-400 ELO)
        angle_deg = randint(0, 359)
        
        if 0 <= angle_deg < 90
            quadrant = 1
        elseif 90 <= angle_deg < 180
            quadrant = 2
        elseif 180 <= angle_deg < 270
            quadrant = 3
        else
            quadrant = 4
        end
        
        problem(
            question="In which quadrant (1, 2, 3, or 4) does the angle $(angle_deg)° lie?",
            answer=quadrant,
            difficulty=(200, 400),
            solution=steps(
                "Quadrant I: 0° to 90°",
                "Quadrant II: 90° to 180°",
                "Quadrant III: 180° to 270°",
                "Quadrant IV: 270° to 360°",
                sol("Answer", "Quadrant $(quadrant)")
            ),
            time=30
        )
    end
end