# geometry - arc_length_sectors (medium)
# Generated: 2026-03-08T20:07:02.317587

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("geometry/arc_length_sectors")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Arc length given radius and central angle
        radius = randint(5, 25)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 210, 240, 270, 300, 330])
        angle_rad = angle_deg * π / 180
        arc_length = radius * angle_rad
        
        d = DiagramObj(width=300, height=300)
        center_x, center_y = 150, 150
        circle!(d, center_x, center_y, radius * 2.5)
        point!(d, center_x, center_y, label="O", label_offset=(-15, -15))
        
        start_angle = 0
        end_angle = angle_deg
        line!(d, center_x, center_y, center_x + radius * 2.5, center_y, stroke="blue", stroke_width=2)
        end_x = center_x + radius * 2.5 * cosd(angle_deg)
        end_y = center_y - radius * 2.5 * sind(angle_deg)
        line!(d, center_x, center_y, end_x, end_y, stroke="blue", stroke_width=2)
        
        arc!(d, center_x, center_y, radius * 2.5, start_angle, end_angle, stroke="red", stroke_width=3)
        angle_arc!(d, center_x, center_y, 30, start_angle, end_angle, label="$(angle_deg)°")
        
        mid_angle = angle_deg / 2
        label_x = center_x + radius * 1.3 * cosd(mid_angle)
        label_y = center_y - radius * 1.3 * sind(mid_angle)
        text!(d, label_x, label_y, "r = $(radius)", font_size=14)
        
        problem(
            question="Find the arc length of a sector with radius $(radius) and central angle $(angle_deg)°. Express your answer in terms of π.",
            answer=arc_length,
            difficulty=(1200, 1400),
            solution=steps(
                "Convert angle to radians: \$\\theta = $(angle_deg)° \\cdot \\frac{\\pi}{180°} = $(tex(angle_rad))\$",
                sol("Arc length formula", "s = r\\theta"),
                sol("Substitute", "s = $(radius) \\cdot $(tex(angle_rad)) = $(tex(arc_length))")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Sector area given radius and central angle
        radius = randint(6, 20)
        angle_deg = choice([36, 45, 60, 72, 90, 120, 144, 150, 180])
        angle_rad = angle_deg * π / 180
        sector_area = radius^2 * angle_rad / 2
        
        d = DiagramObj(width=300, height=300)
        center_x, center_y = 150, 150
        circle!(d, center_x, center_y, radius * 2.8, stroke_dasharray="5,5")
        point!(d, center_x, center_y, label="O", label_offset=(-15, -15))
        
        start_angle = 0
        end_angle = angle_deg
        line!(d, center_x, center_y, center_x + radius * 2.8, center_y, stroke="blue", stroke_width=2)
        end_x = center_x + radius * 2.8 * cosd(angle_deg)
        end_y = center_y - radius * 2.8 * sind(angle_deg)
        line!(d, center_x, center_y, end_x, end_y, stroke="blue", stroke_width=2)
        
        arc!(d, center_x, center_y, radius * 2.8, start_angle, end_angle, stroke="blue", stroke_width=2)
        
        n_fill = 8
        for i in 0:(n_fill-1)
            fill_angle = start_angle + (end_angle - start_angle) * i / n_fill
            fill_x = center_x + radius * 1.4 * cosd(fill_angle)
            fill_y = center_y - radius * 1.4 * sind(fill_angle)
            point!(d, fill_x, fill_y, radius=2, color="lightblue")
        end
        
        angle_arc!(d, center_x, center_y, 35, start_angle, end_angle, label="$(angle_deg)°")
        text!(d, center_x + radius * 1.5, center_y + 30, "r = $(radius)", font_size=14)
        
        problem(
            question="Find the area of a sector with radius $(radius) and central angle $(angle_deg)°. Express your answer in terms of π.",
            answer=sector_area,
            difficulty=(1300, 1500),
            solution=steps(
                "Convert angle to radians: \$\\theta = $(angle_deg)° \\cdot \\frac{\\pi}{180°} = $(tex(angle_rad))\$",
                sol("Sector area formula", "A = \\frac{1}{2}r^2\\theta"),
                sol("Substitute", "A = \\frac{1}{2}($(radius))^2 \\cdot $(tex(angle_rad)) = $(tex(sector_area))")
            ),
            image=render(d),
            time=100
        )
        
    elseif problem_type == 3
        # Find central angle given arc length and radius
        radius = randint(8, 18)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150])
        angle_rad = angle_deg * π / 180
        arc_length = radius * angle_rad
        
        d = DiagramObj(width=300, height=300)
        center_x, center_y = 150, 150
        circle!(d, center_x, center_y, radius * 2.6, stroke_dasharray="5,5")
        point!(d, center_x, center_y, label="O", label_offset=(-15, -15))
        
        start_angle = 0
        end_angle = angle_deg
        line!(d, center_x, center_y, center_x + radius * 2.6, center_y, stroke="blue", stroke_width=2)
        end_x = center_x + radius * 2.6 * cosd(angle_deg)
        end_y = center_y - radius * 2.6 * sind(angle_deg)
        line!(d, center_x, center_y, end_x, end_y, stroke="blue", stroke_width=2)
        
        arc!(d, center_x, center_y, radius * 2.6, start_angle, end_angle, stroke="red", stroke_width=3)
        
        mid_angle = angle_deg / 2
        label_x = center_x + radius * 1.5 * cosd(mid_angle)
        label_y = center_y - radius * 1.5 * sind(mid_angle)
        text!(d, label_x, label_y, "s = $(tex(arc_length))", font_size=13)
        text!(d, center_x + radius * 1.3, center_y + 35, "r = $(radius)", font_size=14)
        
        problem(
            question="An arc has length \$$(tex(arc_length))\$ and the radius is $(radius). Find the central angle in degrees.",
            answer=angle_deg,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Arc length formula", "s = r\\theta"),
                sol("Solve for θ (in radians)", "\\theta = \\frac{s}{r} = \\frac{$(tex(arc_length))}{$(radius)} = $(tex(angle_rad))"),
                "Convert to degrees: \$\\theta = $(tex(angle_rad)) \\cdot \\frac{180°}{\\pi} = $(angle_deg)°\$"
            ),
            image=render(d),
            time=120
        )
        
    else
        # Find radius given sector area and central angle
        angle_deg = choice([40, 45, 60, 72, 90, 120, 135, 144])
        angle_rad = angle_deg * π / 180
        radius = randint(8, 16)
        sector_area = radius^2 * angle_rad / 2
        
        d = DiagramObj(width=300, height=300)
        center_x, center_y = 150, 150
        circle!(d, center_x, center_y, radius * 2.5, stroke_dasharray="5,5")
        point!(d, center_x, center_y, label="O", label_offset=(-15, -15))
        
        start_angle = 0
        end_angle = angle_deg
        line!(d, center_x, center_y, center_x + radius * 2.5, center_y, stroke="blue", stroke_width=2)
        end_x = center_x + radius * 2.5 * cosd(angle_deg)
        end_y = center_y - radius * 2.5 * sind(angle_deg)
        line!(d, center_x, center_y, end_x, end_y, stroke="blue", stroke_width=2)
        
        arc!(d, center_x, center_y, radius * 2.5, start_angle, end_angle, stroke="blue", stroke_width=2)
        
        angle_arc!(d, center_x, center_y, 35, start_angle, end_angle, label="$(angle_deg)°")
        text!(d, center_x - 20, center_y - 40, "A = $(tex(sector_area))", font_size=13)
        
        problem(
            question="A sector has area \$$(tex(sector_area))\$ and central angle $(angle_deg)°. Find the radius.",
            answer=radius,
            difficulty=(1500, 1700),
            solution=steps(
                "Convert angle to radians: \$\\theta = $(angle_deg)° \\cdot \\frac{\\pi}{180°} = $(tex(angle_rad))\$",
                sol("Sector area formula", "A = \\frac{1}{2}r^2\\theta"),
                sol("Solve for r", "r^2 = \\frac{2A}{\\theta} = \\frac{2 \\cdot $(tex(sector_area))}{$(tex(angle_rad))} = $(radius^2)"),
                sol("Answer", "r = $(radius)")
            ),
            image=render(d),
            time=130
        )
    end
end