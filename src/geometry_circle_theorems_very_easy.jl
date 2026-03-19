# geometry - circle_theorems (very_easy)
# Generated: 2026-03-08T20:05:16.392779

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/circle_theorems")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Identify parts of a circle (ELO 100-300)
        d = DiagramObj(300, 300)
        center_x, center_y = 150, 150
        radius = 80
        
        circle!(d, center_x, center_y, radius)
        point!(d, center_x, center_y, "O")
        
        angle = rand(20:340)
        px = center_x + radius * cosd(angle)
        py = center_y + radius * sind(angle)
        point!(d, px, py, "A")
        line!(d, center_x, center_y, px, py)
        
        parts = ["radius", "center", "circumference", "diameter"]
        correct = "radius"
        
        problem(
            question="What is the line segment OA called in this circle?",
            answer=correct,
            difficulty=(150, 300),
            solution=steps(
                "The center of the circle is O",
                "Point A is on the circle",
                "A line segment from the center to a point on the circle is called a radius"
            ),
            image=render(d),
            time=30
        )
        
    elseif problem_type == 2
        # Central angle identification (ELO 200-400)
        d = DiagramObj(300, 300)
        center_x, center_y = 150, 150
        radius = 70
        
        circle!(d, center_x, center_y, radius)
        point!(d, center_x, center_y, "O")
        
        angle1 = rand(10:80)
        angle2 = angle1 + rand(60:120)
        
        px1 = center_x + radius * cosd(angle1)
        py1 = center_y + radius * sind(angle1)
        px2 = center_x + radius * cosd(angle2)
        py2 = center_y + radius * sind(angle2)
        
        point!(d, px1, py1, "A")
        point!(d, px2, py2, "B")
        line!(d, center_x, center_y, px1, py1)
        line!(d, center_x, center_y, px2, py2)
        
        central_angle = angle2 - angle1
        angle_arc!(d, center_x, center_y, 25, angle1, angle2)
        
        problem(
            question="The central angle ∠AOB measures $(central_angle)°. What is the measure of arc AB?",
            answer=central_angle,
            difficulty=(300, 500),
            solution=steps(
                "A central angle has its vertex at the center of the circle",
                "The measure of an arc equals the measure of its central angle",
                sol("Answer", central_angle)
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == 3
        # Diameter and radius relationship (ELO 200-400)
        d = DiagramObj(300, 300)
        center_x, center_y = 150, 150
        radius = choice([5, 6, 7, 8, 9, 10, 12, 15])
        
        circle!(d, center_x, center_y, radius * 6)
        point!(d, center_x, center_y, "O")
        
        px1 = center_x - radius * 6
        px2 = center_x + radius * 6
        point!(d, px1, center_y, "A")
        point!(d, px2, center_y, "B")
        line!(d, px1, center_y, px2, center_y)
        
        diameter = 2 * radius
        
        problem(
            question="The radius of this circle is $(radius) units. What is the diameter AB?",
            answer=diameter,
            difficulty=(200, 400),
            solution=steps(
                sol("Given radius", radius),
                "The diameter is twice the radius",
                sol("Diameter = 2 × $(radius)", diameter)
            ),
            image=render(d),
            time=30
        )
        
    elseif problem_type == 4
        # Inscribed angle theorem (ELO 400-700)
        d = DiagramObj(320, 320)
        center_x, center_y = 160, 160
        radius = 75
        
        circle!(d, center_x, center_y, radius)
        point!(d, center_x, center_y, "O")
        
        angle_start = rand(10:50)
        central_angle = rand(80:140)
        angle_end = angle_start + central_angle
        
        inscribed_angle = central_angle ÷ 2
        
        px1 = center_x + radius * cosd(angle_start)
        py1 = center_y + radius * sind(angle_start)
        px2 = center_x + radius * cosd(angle_end)
        py2 = center_y + radius * sind(angle_end)
        
        angle_p = angle_start + central_angle ÷ 2 + 90
        px_p = center_x + radius * cosd(angle_p)
        py_p = center_y + radius * sind(angle_p)
        
        point!(d, px1, py1, "A")
        point!(d, px2, py2, "B")
        point!(d, px_p, py_p, "P")
        
        line!(d, px_p, py_p, px1, py1)
        line!(d, px_p, py_p, px2, py2)
        line!(d, center_x, center_y, px1, py1)
        line!(d, center_x, center_y, px2, py2)
        
        problem(
            question="The central angle ∠AOB measures $(central_angle)°. What is the measure of the inscribed angle ∠APB?",
            answer=inscribed_angle,
            difficulty=(500, 700),
            solution=steps(
                sol("Central angle ∠AOB", central_angle),
                "The inscribed angle theorem states that an inscribed angle is half the central angle subtending the same arc",
                sol("∠APB = $(central_angle)° ÷ 2", inscribed_angle)
            ),
            image=render(d),
            time=60
        )
        
    else
        # Chord and diameter (ELO 300-500)
        d = DiagramObj(300, 300)
        center_x, center_y = 150, 150
        radius = 70
        
        circle!(d, center_x, center_y, radius)
        point!(d, center_x, center_y, "O")
        
        angle1 = rand(30:60)
        angle2 = angle1 + rand(100:140)
        
        px1 = center_x + radius * cosd(angle1)
        py1 = center_y + radius * sind(angle1)
        px2 = center_x + radius * cosd(angle2)
        py2 = center_y + radius * sind(angle2)
        
        point!(d, px1, py1, "A")
        point!(d, px2, py2, "B")
        line!(d, px1, py1, px2, py2)
        
        problem(
            question="Is the line segment AB a diameter of the circle?",
            answer="no",
            difficulty=(250, 450),
            solution=steps(
                "A diameter must pass through the center O of the circle",
                "The chord AB connects two points on the circle but does not pass through O",
                "Therefore, AB is not a diameter"
            ),
            image=render(d),
            time=45
        )
    end
end