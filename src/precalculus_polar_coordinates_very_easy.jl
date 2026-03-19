# precalculus - polar_coordinates (very_easy)
# Generated: 2026-03-08T20:32:33.706533

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_coordinates")
    
    problem_type = randint(1, 8)
    
    if problem_type == 1
        # Convert simple polar point to rectangular
        r_val = randint(1, 8)
        θ_val = choice([0, 30, 45, 60, 90, 120, 135, 150, 180, 210, 225, 240, 270, 300, 315, 330])
        θ_rad = θ_val * π / 180
        
        x_val = round(r_val * cos(θ_rad), digits=2)
        y_val = round(r_val * sin(θ_rad), digits=2)
        
        ans = fmt_tuple([x_val, y_val])
        
        problem(
            question="Convert the polar coordinates \$($(r_val), $(θ_val)°)\$ to rectangular coordinates (x, y). Round to 2 decimal places if needed.",
            answer=ans,
            answer_type="tuple",
            difficulty=(200, 400),
            solution=steps(
                "Given polar coordinates: \$(r, θ) = ($(r_val), $(θ_val)°)\$",
                "Use conversion formulas: \$x = r\\cos(θ)\$ and \$y = r\\sin(θ)\$",
                sol("Answer", "x = $(x_val), y = $(y_val)")
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Identify which quadrant a polar point is in
        θ_val = randint(0, 359)
        
        if 0 <= θ_val < 90
            quadrant = 1
        elseif 90 <= θ_val < 180
            quadrant = 2
        elseif 180 <= θ_val < 270
            quadrant = 3
        else
            quadrant = 4
        end
        
        problem(
            question="The polar point \$(5, $(θ_val)°)\$ lies in which quadrant?",
            answer=quadrant,
            difficulty=(100, 300),
            solution=steps(
                "Given angle: \$θ = $(θ_val)°\$",
                "Quadrant I: 0° to 90°, Quadrant II: 90° to 180°, Quadrant III: 180° to 270°, Quadrant IV: 270° to 360°",
                sol("Answer", "Quadrant $(quadrant)")
            ),
            time=30
        )
        
    elseif problem_type == 3
        # Convert rectangular to polar (r value only, simple)
        x_val = nonzero(-8, 8)
        y_val = nonzero(-8, 8)
        
        r_val = round(sqrt(x_val^2 + y_val^2), digits=2)
        
        problem(
            question="Find the value of \$r\$ for the rectangular point \$($(x_val), $(y_val))\$ in polar coordinates. Round to 2 decimal places.",
            answer=r_val,
            difficulty=(300, 500),
            solution=steps(
                "Given rectangular coordinates: \$(x, y) = ($(x_val), $(y_val))\$",
                "Use formula: \$r = \\sqrt{x^2 + y^2}\$",
                sol("Answer", "r = $(r_val)")
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Simple angle identification
        θ_val = choice([0, 45, 90, 135, 180, 225, 270, 315])
        
        problem(
            question="What is the angle \$θ = $(θ_val)°\$ in radians? Express as a multiple of π (e.g., pi/4 or 3*pi/2).",
            answer="$(θ_val)*pi/180",
            difficulty=(200, 400),
            solution=steps(
                "Given angle: \$θ = $(θ_val)°\$",
                "Convert using: \$\\text{radians} = \\text{degrees} \\times \\frac{\\pi}{180}\$",
                sol("Answer", "$(θ_val)π/180 = $(θ_val÷gcd(θ_val,180))π/$(180÷gcd(θ_val,180))")
            ),
            time=45
        )
        
    elseif problem_type == 5
        # Given r and θ, find x coordinate only
        r_val = randint(2, 10)
        θ_val = choice([0, 60, 90, 120, 180, 240, 270, 300])
        θ_rad = θ_val * π / 180
        
        x_val = round(r_val * cos(θ_rad), digits=2)
        
        problem(
            question="For the polar point \$($(r_val), $(θ_val)°)\$, what is the x-coordinate? Round to 2 decimal places.",
            answer=x_val,
            difficulty=(200, 400),
            solution=steps(
                "Given: \$(r, θ) = ($(r_val), $(θ_val)°)\$",
                "Use formula: \$x = r\\cos(θ)\$",
                sol("Answer", "x = $(x_val)")
            ),
            time=45
        )
        
    elseif problem_type == 6
        # Given r and θ, find y coordinate only
        r_val = randint(2, 10)
        θ_val = choice([0, 30, 60, 90, 120, 150, 180, 210, 240, 270, 300, 330])
        θ_rad = θ_val * π / 180
        
        y_val = round(r_val * sin(θ_rad), digits=2)
        
        problem(
            question="For the polar point \$($(r_val), $(θ_val)°)\$, what is the y-coordinate? Round to 2 decimal places.",
            answer=y_val,
            difficulty=(200, 400),
            solution=steps(
                "Given: \$(r, θ) = ($(r_val), $(θ_val)°)\$",
                "Use formula: \$y = r\\sin(θ)\$",
                sol("Answer", "y = $(y_val)")
            ),
            time=45
        )
        
    elseif problem_type == 7
        # Distance from origin in polar
        r_val = randint(1, 15)
        θ_val = randint(0, 359)
        
        problem(
            question="What is the distance from the origin to the polar point \$($(r_val), $(θ_val)°)\$?",
            answer=r_val,
            difficulty=(100, 300),
            solution=steps(
                "Given polar coordinates: \$(r, θ) = ($(r_val), $(θ_val)°)\$",
                "In polar coordinates, \$r\$ represents the distance from the origin",
                sol("Answer", r_val)
            ),
            time=30
        )
        
    else
        # Recognize equivalent polar coordinates (angle)
        θ_val = randint(0, 180)
        equivalent_θ = θ_val + 360
        
        problem(
            question="The polar angle \$$(θ_val)°\$ is equivalent to which of these angles: $(θ_val + 180)°, $(equivalent_θ)°, $(θ_val - 90)°, or $(θ_val + 90)°?",
            answer=equivalent_θ,
            difficulty=(300, 500),
            solution=steps(
                "Given angle: \$$(θ_val)°\$",
                "Angles in polar coordinates repeat every 360°",
                sol("Answer", "$(equivalent_θ)° = $(θ_val)° + 360°")
            ),
            time=45
        )
    end
end