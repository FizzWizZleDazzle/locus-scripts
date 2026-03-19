# geometry - triangle_properties (very_easy)
# Generated: 2026-03-08T20:02:22.778178

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_properties")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # ELO 150-300: Identify triangle type from diagram
        sides = sort([randint(3, 8), randint(3, 8), randint(3, 8)])
        if sides[1] == sides[2] == sides[3]
            tri_type = "equilateral"
        elseif sides[1] == sides[2] || sides[2] == sides[3]
            tri_type = "isosceles"
        else
            tri_type = "scalene"
        end
        
        d = DiagramObj(width=300, height=250)
        if tri_type == "equilateral"
            polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightblue", stroke="black", stroke_width=2)
            segment_label!(d, (50, 200), (250, 200), "$(sides[1])", :below)
            segment_label!(d, (250, 200), (150, 50), "$(sides[1])", :right)
            segment_label!(d, (150, 50), (50, 200), "$(sides[1])", :left)
        elseif tri_type == "isosceles"
            polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightblue", stroke="black", stroke_width=2)
            segment_label!(d, (50, 200), (250, 200), "$(sides[2])", :below)
            segment_label!(d, (250, 200), (150, 50), "$(sides[1])", :right)
            segment_label!(d, (150, 50), (50, 200), "$(sides[1])", :left)
        else
            polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightblue", stroke="black", stroke_width=2)
            segment_label!(d, (50, 200), (250, 200), "$(sides[0])", :below)
            segment_label!(d, (250, 200), (150, 50), "$(sides[2])", :right)
            segment_label!(d, (150, 50), (50, 200), "$(sides[1])", :left)
        end
        
        problem(
            question="What type of triangle is shown in the diagram based on its side lengths?",
            answer=tri_type,
            difficulty=(150, 300),
            solution=steps(
                "Examine the side lengths of the triangle",
                "Compare the three sides: $(sides[1]), $(sides[2]), $(sides[3])",
                "This is a $(tri_type) triangle"
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == 2
        # ELO 200-400: Find missing angle in triangle
        angle1 = randint(30, 80)
        angle2 = randint(30, 80)
        angle3 = 180 - angle1 - angle2
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightblue", stroke="black", stroke_width=2)
        angle_arc!(d, (50, 200), (250, 200), (150, 50), radius=25, label="$(angle1)°")
        angle_arc!(d, (250, 200), (150, 50), (50, 200), radius=25, label="$(angle2)°")
        angle_arc!(d, (150, 50), (50, 200), (250, 200), radius=25, label="?")
        
        problem(
            question="Find the measure of the missing angle in the triangle.",
            answer=angle3,
            difficulty=(200, 400),
            solution=steps(
                "The sum of angles in a triangle equals 180°",
                "Missing angle = 180° - $(angle1)° - $(angle2)°",
                sol("Answer", "$(angle3)°")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == 3
        # ELO 300-500: Identify right triangle and find missing side
        a = randint(3, 12)
        b = randint(3, 12)
        c = round(Int, sqrt(a^2 + b^2))
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (250, 200), (50, 50)], fill="lightgreen", stroke="black", stroke_width=2)
        right_angle!(d, (50, 200), (50, 50), (250, 200), size=15)
        segment_label!(d, (50, 200), (250, 200), "$(b)", :below)
        segment_label!(d, (50, 50), (50, 200), "$(a)", :left)
        segment_label!(d, (250, 200), (50, 50), "?", :right)
        
        problem(
            question="This is a right triangle. If the two legs have lengths $(a) and $(b), what is the length of the hypotenuse? (Round to the nearest integer)",
            answer=c,
            difficulty=(300, 500),
            solution=steps(
                "Use the Pythagorean theorem: a² + b² = c²",
                "$(a)² + $(b)² = $(a^2) + $(b^2) = $(a^2 + b^2)",
                sol("Hypotenuse", "√$(a^2 + b^2) ≈ $(c)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 4
        # ELO 400-600: Find perimeter of triangle
        side1 = randint(5, 15)
        side2 = randint(5, 15)
        side3 = randint(5, 15)
        perimeter = side1 + side2 + side3
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightyellow", stroke="black", stroke_width=2)
        segment_label!(d, (50, 200), (250, 200), "$(side1)", :below)
        segment_label!(d, (250, 200), (150, 50), "$(side2)", :right)
        segment_label!(d, (150, 50), (50, 200), "$(side3)", :left)
        
        problem(
            question="Find the perimeter of the triangle shown in the diagram.",
            answer=perimeter,
            difficulty=(400, 600),
            solution=steps(
                "The perimeter is the sum of all three sides",
                "P = $(side1) + $(side2) + $(side3)",
                sol("Perimeter", "$(perimeter)")
            ),
            image=render(d),
            time=60
        )
        
    else
        # ELO 500-700: Isosceles triangle - find unknown side given perimeter
        equal_side = randint(8, 18)
        base = randint(6, 20)
        perimeter = 2 * equal_side + base
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (250, 200), (150, 50)], fill="lightcoral", stroke="black", stroke_width=2)
        segment_label!(d, (50, 200), (250, 200), "$(base)", :below)
        segment_label!(d, (250, 200), (150, 50), "x", :right)
        segment_label!(d, (150, 50), (50, 200), "x", :left)
        tick_marks!(d, (250, 200), (150, 50), 1)
        tick_marks!(d, (150, 50), (50, 200), 1)
        text!(d, 150, 230, "Perimeter = $(perimeter)", font_size=14)
        
        problem(
            question="This isosceles triangle has a perimeter of $(perimeter). The base has length $(base). Find the length of each equal side (x).",
            answer=equal_side,
            difficulty=(500, 700),
            solution=steps(
                "In an isosceles triangle, two sides are equal",
                "Perimeter = base + 2x, so $(perimeter) = $(base) + 2x",
                "2x = $(perimeter - base), so x = $(equal_side)"
            ),
            image=render(d),
            time=90
        )
    end
end