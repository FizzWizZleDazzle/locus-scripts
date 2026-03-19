# geometry - arc_length_sectors (very_easy)
# Generated: 2026-03-08T20:06:29.376615

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/arc_length_sectors")
    
    prob_type = choice(["arc_length", "sector_area", "central_angle", "radius_from_arc"])
    
    if prob_type == "arc_length"
        # Simple arc length calculation: s = rθ (θ in radians)
        r = randint(3, 12)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180])
        angle_rad = angle_deg * π / 180
        arc_length = r * angle_rad
        
        d = DiagramObj(width=200, height=200)
        circle!(d, 100, 100, 60)
        arc!(d, 100, 100, 60, 0, angle_deg; stroke="red", stroke_width=3)
        line!(d, 100, 100, 100 + 60, 100; stroke="blue")
        line!(d, 100, 100, 100 + 60*cos(angle_rad), 100 - 60*sin(angle_rad); stroke="blue")
        point!(d, 100, 100; label="", color="black")
        text!(d, 100, 130, "r = $r")
        text!(d, 120, 85, "$(angle_deg)°")
        
        problem(
            question="Find the arc length of a circle with radius $r when the central angle is $(angle_deg)°. Leave your answer in terms of π.",
            answer=arc_length,
            difficulty=(200, 500),
            solution=steps(
                "Convert angle to radians: \$\\theta = $(angle_deg)° \\cdot \\frac{\\pi}{180°} = $(tex(angle_rad))\$",
                "Use arc length formula: \$s = r\\theta\$",
                sol("Arc length", arc_length)
            ),
            image=render(d),
            time=90
        )
        
    elseif prob_type == "sector_area"
        # Sector area: A = (1/2)r²θ
        r = randint(4, 10)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150])
        angle_rad = angle_deg * π / 180
        sector_area = (1//2) * r^2 * angle_rad
        
        d = DiagramObj(width=200, height=200)
        circle!(d, 100, 100, 50)
        # Draw sector filled
        polygon!(d, [
            [100, 100],
            [100 + 50, 100],
            [100 + 50*cos(angle_rad*0.2), 100 - 50*sin(angle_rad*0.2)],
            [100 + 50*cos(angle_rad*0.4), 100 - 50*sin(angle_rad*0.4)],
            [100 + 50*cos(angle_rad*0.6), 100 - 50*sin(angle_rad*0.6)],
            [100 + 50*cos(angle_rad*0.8), 100 - 50*sin(angle_rad*0.8)],
            [100 + 50*cos(angle_rad), 100 - 50*sin(angle_rad)]
        ], fill="lightblue", opacity=0.5)
        line!(d, 100, 100, 100 + 50, 100; stroke="blue", stroke_width=2)
        line!(d, 100, 100, 100 + 50*cos(angle_rad), 100 - 50*sin(angle_rad); stroke="blue", stroke_width=2)
        text!(d, 100, 125, "r = $r")
        text!(d, 115, 85, "$(angle_deg)°")
        
        problem(
            question="Find the area of a sector with radius $r and central angle $(angle_deg)°. Leave your answer in terms of π.",
            answer=sector_area,
            difficulty=(300, 600),
            solution=steps(
                "Convert angle to radians: \$\\theta = $(angle_deg)° \\cdot \\frac{\\pi}{180°} = $(tex(angle_rad))\$",
                "Use sector area formula: \$A = \\frac{1}{2}r^2\\theta\$",
                sol("Sector area", sector_area)
            ),
            image=render(d),
            time=90
        )
        
    elseif prob_type == "central_angle"
        # Given arc length and radius, find angle
        r = randint(5, 15)
        angle_deg = choice([30, 45, 60, 90, 120])
        angle_rad = angle_deg * π / 180
        arc_length = r * angle_rad
        
        d = DiagramObj(width=200, height=200)
        circle!(d, 100, 100, 55)
        arc!(d, 100, 100, 55, 0, angle_deg; stroke="red", stroke_width=3)
        line!(d, 100, 100, 100 + 55, 100; stroke="blue")
        line!(d, 100, 100, 100 + 55*cos(angle_rad), 100 - 55*sin(angle_rad); stroke="blue")
        text!(d, 100, 130, "r = $r")
        text!(d, 130, 60, "s = $(tex(arc_length))")
        
        problem(
            question="An arc has length \$$(tex(arc_length))\$ on a circle with radius $r. Find the central angle in degrees.",
            answer=angle_deg,
            difficulty=(400, 700),
            solution=steps(
                "Use arc length formula: \$s = r\\theta\$",
                "Solve for θ in radians: \$\\theta = \\frac{s}{r} = \\frac{$(tex(arc_length))}{$r} = $(tex(angle_rad))\$",
                "Convert to degrees: \$$(tex(angle_rad)) \\cdot \\frac{180°}{\\pi} = $(angle_deg)°\$",
                sol("Central angle", angle_deg)
            ),
            image=render(d),
            time=120
        )
        
    else  # radius_from_arc
        # Given arc length and angle, find radius
        angle_deg = choice([30, 45, 60, 90, 120, 180])
        angle_rad = angle_deg * π / 180
        r = randint(4, 12)
        arc_length = r * angle_rad
        
        d = DiagramObj(width=200, height=200)
        circle!(d, 100, 100, 50)
        arc!(d, 100, 100, 50, 0, angle_deg; stroke="red", stroke_width=3)
        line!(d, 100, 100, 100 + 50, 100; stroke="blue")
        line!(d, 100, 100, 100 + 50*cos(angle_rad), 100 - 50*sin(angle_rad); stroke="blue")
        text!(d, 115, 85, "$(angle_deg)°")
        text!(d, 130, 65, "s = $(tex(arc_length))")
        
        problem(
            question="An arc with central angle $(angle_deg)° has length \$$(tex(arc_length))\$. Find the radius of the circle.",
            answer=r,
            difficulty=(500, 700),
            solution=steps(
                "Convert angle to radians: \$\\theta = $(angle_deg)° \\cdot \\frac{\\pi}{180°} = $(tex(angle_rad))\$",
                "Use arc length formula: \$s = r\\theta\$",
                "Solve for r: \$r = \\frac{s}{\\theta} = \\frac{$(tex(arc_length))}{$(tex(angle_rad))} = $r\$",
                sol("Radius", r)
            ),
            image=render(d),
            time=120
        )
    end
end