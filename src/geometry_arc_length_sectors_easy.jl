# geometry - arc_length_sectors (easy)
# Generated: 2026-03-08T20:06:38.882121

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/arc_length_sectors")
    
    problem_type = choice([:arc_length, :sector_area, :central_angle_from_arc, :radius_from_sector])
    
    if problem_type == :arc_length
        radius = randint(3, 15)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 210, 240, 270, 300])
        angle_rad = angle_deg * π / 180
        arc_len = radius * angle_rad
        
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, radius * 8, fill="none", stroke="black", stroke_width=2)
        line!(d, 200, 200, 200 + radius * 8 * cos(0), 200 + radius * 8 * sin(0), stroke="blue", stroke_width=2)
        line!(d, 200, 200, 200 + radius * 8 * cos(angle_rad), 200 - radius * 8 * sin(angle_rad), stroke="blue", stroke_width=2)
        arc!(d, 200, 200, radius * 8, 0, angle_deg, stroke="red", stroke_width=3, fill="none")
        angle_arc!(d, 200, 200, 30, 0, angle_deg, stroke="green", stroke_width=1)
        text!(d, 200 + 50, 200 - 10, "$(angle_deg)°", font_size=16)
        text!(d, 200 + radius * 4 * cos(angle_rad/2), 200 - radius * 4 * sin(angle_rad/2), "s=?", font_size=16, fill="red")
        text!(d, 200, 390, "r = $radius", font_size=16)
        
        problem(
            question="A circle has radius $radius. Find the arc length subtended by a central angle of $(angle_deg)°. Express your answer in terms of π.",
            answer=arc_len,
            difficulty=(700, 900),
            solution=steps(
                "Given: radius r = $radius, central angle θ = $(angle_deg)°",
                "Convert angle to radians: θ = $(angle_deg)° × \\frac{π}{180°} = $(tex(angle_rad))",
                sol("Arc length formula", "s = rθ"),
                "Substitute: s = $radius × $(tex(angle_rad)) = $(tex(arc_len))",
                sol("Answer", arc_len)
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == :sector_area
        radius = randint(4, 12)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 240, 270])
        angle_rad = angle_deg * π / 180
        sector_area = (1//2) * radius^2 * angle_rad
        
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, radius * 10, fill="none", stroke="black", stroke_width=2)
        polygon!(d, [200, 200 + radius * 10 * cos(0), 200 + radius * 10 * cos(angle_rad), 200],
                    [200, 200 + radius * 10 * sin(0), 200 - radius * 10 * sin(angle_rad), 200],
                    fill="lightblue", stroke="blue", stroke_width=2, opacity=0.5)
        line!(d, 200, 200, 200 + radius * 10 * cos(0), 200 + radius * 10 * sin(0), stroke="blue", stroke_width=2)
        line!(d, 200, 200, 200 + radius * 10 * cos(angle_rad), 200 - radius * 10 * sin(angle_rad), stroke="blue", stroke_width=2)
        arc!(d, 200, 200, radius * 10, 0, angle_deg, stroke="blue", stroke_width=2, fill="none")
        angle_arc!(d, 200, 200, 35, 0, angle_deg, stroke="green", stroke_width=1)
        text!(d, 200 + 50, 200 - 10, "$(angle_deg)°", font_size=16)
        text!(d, 200, 390, "r = $radius", font_size=16)
        
        problem(
            question="Find the area of a sector with radius $radius and central angle $(angle_deg)°. Express your answer in terms of π.",
            answer=sector_area,
            difficulty=(750, 950),
            solution=steps(
                "Given: radius r = $radius, central angle θ = $(angle_deg)°",
                "Convert angle to radians: θ = $(angle_deg)° × \\frac{π}{180°} = $(tex(angle_rad))",
                sol("Sector area formula", "A = \\frac{1}{2}r^2θ"),
                "Substitute: A = \\frac{1}{2} × $(radius)^2 × $(tex(angle_rad))",
                "A = \\frac{1}{2} × $(radius^2) × $(tex(angle_rad)) = $(tex(sector_area))",
                sol("Answer", sector_area)
            ),
            image=render(d),
            time=100
        )
        
    elseif problem_type == :central_angle_from_arc
        radius = randint(5, 12)
        angle_deg = choice([45, 60, 90, 120, 135, 150])
        angle_rad = angle_deg * π / 180
        arc_len = radius * angle_rad
        
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, radius * 9, fill="none", stroke="black", stroke_width=2)
        line!(d, 200, 200, 200 + radius * 9 * cos(0), 200 + radius * 9 * sin(0), stroke="blue", stroke_width=2)
        line!(d, 200, 200, 200 + radius * 9 * cos(angle_rad), 200 - radius * 9 * sin(angle_rad), stroke="blue", stroke_width=2)
        arc!(d, 200, 200, radius * 9, 0, angle_deg, stroke="red", stroke_width=3, fill="none")
        angle_arc!(d, 200, 200, 30, 0, angle_deg, stroke="green", stroke_width=1)
        text!(d, 200 + 50, 200 - 10, "θ=?", font_size=16)
        text!(d, 200 + radius * 5 * cos(angle_rad/2), 200 - radius * 5 * sin(angle_rad/2), "s=$(tex(arc_len))", font_size=14, fill="red")
        text!(d, 200, 390, "r = $radius", font_size=16)
        
        problem(
            question="An arc has length $(tex(arc_len)) on a circle of radius $radius. Find the measure of the central angle in degrees.",
            answer=angle_deg,
            difficulty=(800, 1000),
            solution=steps(
                "Given: arc length s = $(tex(arc_len)), radius r = $radius",
                sol("Arc length formula", "s = rθ (θ in radians)"),
                "Solve for θ: θ = \\frac{s}{r} = \\frac{$(tex(arc_len))}{$radius} = $(tex(angle_rad)) radians",
                "Convert to degrees: θ = $(tex(angle_rad)) × \\frac{180°}{π} = $(angle_deg)°",
                sol("Answer", "$(angle_deg)°")
            ),
            image=render(d),
            time=110
        )
        
    else  # radius_from_sector
        radius = randint(6, 14)
        angle_deg = choice([60, 90, 120, 180])
        angle_rad = angle_deg * π / 180
        sector_area = (1//2) * radius^2 * angle_rad
        
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, radius * 8, fill="none", stroke="black", stroke_width=2)
        polygon!(d, [200, 200 + radius * 8 * cos(0), 200 + radius * 8 * cos(angle_rad), 200],
                    [200, 200 + radius * 8 * sin(0), 200 - radius * 8 * sin(angle_rad), 200],
                    fill="lightblue", stroke="blue", stroke_width=2, opacity=0.5)
        line!(d, 200, 200, 200 + radius * 8 * cos(0), 200 + radius * 8 * sin(0), stroke="blue", stroke_width=2)
        line!(d, 200, 200, 200 + radius * 8 * cos(angle_rad), 200 - radius * 8 * sin(angle_rad), stroke="blue", stroke_width=2)
        arc!(d, 200, 200, radius * 8, 0, angle_deg, stroke="blue", stroke_width=2, fill="none")
        angle_arc!(d, 200, 200, 35, 0, angle_deg, stroke="green", stroke_width=1)
        text!(d, 200 + 50, 200 - 10, "$(angle_deg)°", font_size=16)
        text!(d, 200 + radius * 3 * cos(angle_rad/2), 200 - radius * 3 * sin(angle_rad/2), "A=$(tex(sector_area))", font_size=14)
        text!(d, 200, 390, "r = ?", font_size=16)
        
        problem(
            question="A sector has area $(tex(sector_area)) and central angle $(angle_deg)°. Find the radius of the circle.",
            answer=radius,
            difficulty=(900, 1200),
            solution=steps(
                "Given: sector area A = $(tex(sector_area)), central angle θ = $(angle_deg)°",
                "Convert angle to radians: θ = $(angle_deg)° × \\frac{π}{180°} = $(tex(angle_rad))",
                sol("Sector area formula", "A = \\frac{1}{2}r^2θ"),
                "Substitute: $(tex(sector_area)) = \\frac{1}{2}r^2 × $(tex(angle_rad))",
                "Solve for r²: r^2 = \\frac{2 × $(tex(sector_area))}{$(tex(angle_rad))} = $(radius^2)",
                "Take square root: r = $radius",
                sol("Answer", radius)
            ),
            image=render(d),
            time=120
        )
    end
end