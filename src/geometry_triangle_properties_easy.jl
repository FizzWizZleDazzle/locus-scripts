# geometry - triangle_properties (easy)
# Generated: 2026-03-08T20:02:34.030674

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_properties")
    
    problem_type = choice([:angle_sum, :isosceles, :exterior_angle, :triangle_inequality])
    
    if problem_type == :angle_sum
        angle1 = randint(20, 70)
        angle2 = randint(20, 80)
        angle3 = 180 - angle1 - angle2
        
        d = DiagramObj(600, 400)
        polygon!(d, [(100, 300), (500, 300), (250, 100)], fill="lightblue", stroke="black", stroke_width=2)
        point!(d, 100, 300, "A", :left)
        point!(d, 500, 300, "B", :right)
        point!(d, 250, 100, "C", :above)
        text!(d, 180, 280, "$(angle1)°", font_size=16)
        text!(d, 420, 280, "$(angle2)°", font_size=16)
        text!(d, 250, 140, "?", font_size=18, color="red")
        
        problem(
            question="In triangle ABC, angle A = $(angle1)° and angle B = $(angle2)°. Find the measure of angle C.",
            answer=angle3,
            difficulty=(700, 900),
            solution=steps(
                "Use the triangle angle sum property: A + B + C = 180°",
                sol("Substitute known values", "$(angle1)° + $(angle2)° + C = 180°"),
                sol("Solve for C", "C = 180° - $(angle1)° - $(angle2)° = $(angle3)°")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == :isosceles
        base_angle = randint(35, 70)
        apex_angle = 180 - 2*base_angle
        
        d = DiagramObj(600, 400)
        polygon!(d, [(150, 300), (450, 300), (300, 100)], fill="lightgreen", stroke="black", stroke_width=2)
        point!(d, 150, 300, "A", :left)
        point!(d, 450, 300, "B", :right)
        point!(d, 300, 100, "C", :above)
        
        tick_marks!(d, 150, 300, 300, 100, 1)
        tick_marks!(d, 450, 300, 300, 100, 1)
        
        text!(d, 210, 280, "$(base_angle)°", font_size=16)
        text!(d, 300, 140, "?", font_size=18, color="red")
        
        problem(
            question="In isosceles triangle ABC with AC = BC, angle A = $(base_angle)°. Find the measure of angle C (the apex angle).",
            answer=apex_angle,
            difficulty=(800, 1000),
            solution=steps(
                "In an isosceles triangle, base angles are equal",
                sol("So angle B", "= $(base_angle)°"),
                sol("Using angle sum", "C = 180° - $(base_angle)° - $(base_angle)° = $(apex_angle)°")
            ),
            image=render(d),
            time=75
        )
        
    elseif problem_type == :exterior_angle
        angle1 = randint(30, 60)
        angle2 = randint(35, 70)
        exterior = angle1 + angle2
        
        d = DiagramObj(700, 400)
        polygon!(d, [(100, 300), (400, 300), (250, 100)], fill="lightyellow", stroke="black", stroke_width=2)
        line!(d, 400, 300, 600, 300, stroke="black", stroke_width=2, dash="5,5")
        
        point!(d, 100, 300, "A", :left)
        point!(d, 400, 300, "B", :below)
        point!(d, 250, 100, "C", :above)
        
        text!(d, 170, 280, "$(angle1)°", font_size=16)
        text!(d, 250, 140, "$(angle2)°", font_size=16)
        text!(d, 480, 320, "x", font_size=18, color="red")
        arc!(d, 400, 300, 50, 0, 30, stroke="red", stroke_width=2)
        
        problem(
            question="In the diagram, an exterior angle is formed at vertex B. If angle A = $(angle1)° and angle C = $(angle2)°, find the measure of the exterior angle x.",
            answer=exterior,
            difficulty=(900, 1100),
            solution=steps(
                "The exterior angle of a triangle equals the sum of the two non-adjacent interior angles",
                sol("Therefore", "x = A + C"),
                sol("Answer", "x = $(angle1)° + $(angle2)° = $(exterior)°")
            ),
            image=render(d),
            time=90
        )
        
    else  # triangle_inequality
        a = randint(5, 12)
        b = randint(8, 15)
        min_c = abs(a - b) + 1
        max_c = a + b - 1
        valid_c = randint(min_c, max_c)
        
        d = DiagramObj(600, 400)
        polygon!(d, [(100, 300), (500, 300), (280, 120)], fill="lightcoral", stroke="black", stroke_width=2)
        point!(d, 100, 300, "A", :left)
        point!(d, 500, 300, "B", :right)
        point!(d, 280, 120, "C", :above)
        
        segment_label!(d, 100, 300, 500, 300, "$(a)", :below)
        segment_label!(d, 100, 300, 280, 120, "$(b)", :left)
        segment_label!(d, 500, 300, 280, 120, "?", :right)
        
        problem(
            question="A triangle has two sides of lengths $(a) and $(b). The third side has integer length. What is the maximum possible length of the third side?",
            answer=max_c,
            difficulty=(1000, 1200),
            solution=steps(
                "By the triangle inequality, the sum of any two sides must be greater than the third side",
                sol("So the third side c must satisfy", "$(abs(a-b)) < c < $(a+b)"),
                sol("Maximum integer value", "c = $(max_c)")
            ),
            image=render(d),
            time=120
        )
    end
end