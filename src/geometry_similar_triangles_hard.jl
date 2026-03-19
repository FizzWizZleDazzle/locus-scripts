# geometry - similar_triangles (hard)
# Generated: 2026-03-08T20:05:05.977227

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("geometry/similar_triangles")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # AA similarity with angle chasing (1800-2000)
        angle1 = randint(35, 70)
        angle2 = randint(40, 75)
        angle3 = 180 - angle1 - angle2
        
        # Create second triangle with one shared angle and one constructible angle
        shared = angle1
        constructed_angle = randint(30, 80)
        third_angle = 180 - shared - constructed_angle
        
        d = DiagramObj(600, 400)
        
        # First triangle ABC
        polygon!(d, [(50, 300), (250, 300), (180, 100)], :none, "black", 2)
        point!(d, 50, 300, "A", :bottomleft)
        point!(d, 250, 300, "B", :bottomright)
        point!(d, 180, 100, "C", :top)
        text!(d, 70, 280, "$(angle1)°", 12)
        text!(d, 220, 280, "$(angle2)°", 12)
        text!(d, 180, 120, "$(angle3)°", 12)
        
        # Second triangle DEF
        polygon!(d, [(350, 300), (550, 300), (480, 150)], :none, "blue", 2)
        point!(d, 350, 300, "D", :bottomleft)
        point!(d, 550, 300, "E", :bottomright)
        point!(d, 480, 150, "F", :top)
        text!(d, 370, 280, "$(shared)°", 12)
        text!(d, 520, 280, "$(constructed_angle)°", 12)
        
        svg = render(d)
        
        problem(
            question="In triangle ABC, ∠A = $(angle1)°, ∠B = $(angle2)°, and ∠C = $(angle3)°. In triangle DEF, ∠D = $(shared)° and ∠E = $(constructed_angle)°. Are the triangles similar? If so, write the similarity statement.",
            answer="Yes, △ABC ~ △DFE",
            difficulty=(1800, 2000),
            answer_type="text",
            solution=steps(
                "Find ∠F in triangle DEF: ∠F = 180° - $(shared)° - $(constructed_angle)° = $(third_angle)°",
                "Compare angles: Triangle ABC has angles $(angle1)°, $(angle2)°, $(angle3)°",
                "Triangle DEF has angles $(shared)°, $(constructed_angle)°, $(third_angle)°",
                "Since ∠A = ∠D = $(angle1)° and ∠C = ∠F = $(angle3)°, by AA similarity, △ABC ~ △DFE"
            ),
            image=svg,
            time=180
        )
        
    elseif problem_type == 2
        # Side-splitter theorem application (1900-2100)
        # Triangle with parallel line creating similar triangles
        small_side = randint(4, 9)
        ratio_num = randint(2, 4)
        ratio_den = randint(5, 8)
        while ratio_den <= ratio_num
            ratio_den = randint(5, 8)
        end
        
        segment_length = small_side * ratio_num // ratio_den
        unknown_side = randint(6, 15)
        answer = unknown_side * ratio_num // ratio_den
        
        d = DiagramObj(500, 450)
        
        # Large triangle
        polygon!(d, [(50, 400), (450, 400), (250, 50)], :none, "black", 2)
        point!(d, 50, 400, "A", :bottomleft)
        point!(d, 450, 400, "B", :bottomright)
        point!(d, 250, 50, "C", :top)
        
        # Parallel line DE
        line!(d, 120, 260, 380, 260, "blue", 2)
        point!(d, 120, 260, "D", :left)
        point!(d, 380, 260, "E", :right)
        
        # Labels
        segment_label!(d, 50, 400, 120, 260, "$(small_side)", :left)
        segment_label!(d, 450, 400, 380, 260, "$(segment_length)", :right)
        segment_label!(d, 120, 260, 250, 50, "x", :left)
        segment_label!(d, 380, 260, 250, 50, "$(unknown_side)", :right)
        
        text!(d, 250, 270, "DE ∥ AB", 12)
        
        svg = render(d)
        
        problem(
            question="In triangle ABC, line segment DE is parallel to AB, with D on AC and E on BC. If AD = $(small_side), DB = $(segment_length), and EC = $(unknown_side), find DC (denoted as x in the diagram).",
            answer=answer,
            difficulty=(1900, 2100),
            solution=steps(
                "Since DE ∥ AB, by the side-splitter theorem, we have \\frac{AD}{DC} = \\frac{BE}{EC}",
                "Also, triangles CDE and CAB are similar, so \\frac{DC}{AC} = \\frac{EC}{BC}",
                "From the parallel lines, \\frac{AD}{DB} = \\frac{DC}{EC}, so \\frac{$(small_side)}{$(segment_length)} = \\frac{x}{$(unknown_side)}",
                sol("Solve for x", "x = $(unknown_side) \\cdot \\frac{$(small_side)}{$(segment_length)} = $(answer)")
            ),
            image=svg,
            time=240
        )
        
    elseif problem_type == 3
        # Nested similar triangles with ratio problem (2000-2300)
        small_base = randint(6, 12)
        large_base = small_base * randint(2, 4)
        small_height = randint(8, 15)
        ratio = small_base // large_base
        large_height = small_height // ratio
        
        area_small = (small_base * small_height) // 2
        area_large = (large_base * large_height) // 2
        area_trapezoid = area_large - area_small
        
        d = DiagramObj(500, 500)
        
        # Large triangle
        base_y = 420
        top_y = 80
        polygon!(d, [(100, base_y), (400, base_y), (250, top_y)], :none, "black", 2)
        point!(d, 100, base_y, "A", :bottomleft)
        point!(d, 400, base_y, "B", :bottomright)
        point!(d, 250, top_y, "C", :top)
        
        # Small triangle (similar, nested)
        small_y = base_y - Int(round((base_y - top_y) * float(ratio)))
        left_x = 100 + Int(round(150 * (1 - float(ratio))))
        right_x = 400 - Int(round(150 * (1 - float(ratio))))
        
        polygon!(d, [(left_x, small_y), (right_x, small_y), (250, top_y)], :lightblue, "blue", 2)
        point!(d, left_x, small_y, "D", :bottomleft)
        point!(d, right_x, small_y, "E", :bottomright)
        
        # Labels
        segment_label!(d, 100, base_y, 400, base_y, "$(large_base)", :bottom)
        segment_label!(d, left_x, small_y, right_x, small_y, "$(small_base)", :top)
        
        svg = render(d)
        
        problem(
            question="Triangle ABC has base AB = $(large_base) and is similar to triangle CDE with base DE = $(small_base), where D is on AC and E is on BC, and DE ∥ AB. If the height of triangle CDE is $(small_height), find the area of trapezoid ABDE.",
            answer=area_trapezoid,
            difficulty=(2000, 2300),
            solution=steps(
                "Since △CDE ~ △CAB, the ratio of similarity is k = \\frac{$(small_base)}{$(large_base)} = $(ratio)",
                "The height of △CAB is \\frac{$(small_height)}{$(ratio)} = $(large_height)",
                "Area of △CAB = \\frac{1}{2} \\cdot $(large_base) \\cdot $(large_height) = $(area_large)",
                "Area of △CDE = \\frac{1}{2} \\cdot $(small_base) \\cdot $(small_height) = $(area_small)",
                sol("Area of trapezoid ABDE", "$(area_large) - $(area_small) = $(area_trapezoid)")
            ),
            image=svg,
            time=300
        )
        
    else
        # Altitude to hypotenuse creates similar triangles (2100-2400)
        # In right triangle, altitude to hypotenuse creates 3 similar triangles
        short_seg = randint(4, 9)
        long_seg = randint(10, 20)
        altitude = Int(round(sqrt(float(short_seg * long_seg))))
        
        # Adjust to make it exact
        altitude_sq = short_seg * long_seg
        altitude = isqrt(altitude_sq)
        if altitude^2 != altitude_sq
            short_seg = randint(3, 6)
            long_seg = short_seg * randint(4, 9)
            altitude = Int(round(sqrt(float(short_seg * long_seg))))
        end
        
        d = DiagramObj(550, 400)
        
        # Right triangle ABC with right angle at C
        polygon!(d, [(50, 350), (500, 350), (50, 50)], :none, "black", 2)
        point!(d, 50, 350, "A", :bottomleft)
        point!(d, 500, 350, "B", :bottomright)
        point!(d, 50, 50, "C", :topleft)
        right_angle!(d, 50, 350, 50, 50, 500, 350, 15)
        
        # Altitude from C to AB
        altitude_x = 50 + short_seg * (450 // (short_seg + long_seg))
        line!(d, altitude_x, 350, 50, 50, "blue", 2)
        point!(d, altitude_x, 350, "D", :bottom)
        right_angle!(d, altitude_x, 350, 50, 50, 50, 350, 12)
        
        # Labels
        segment_label!(d, 50, 350, altitude_x, 350, "$(short_seg)", :bottom)
        segment_label!(d, altitude_x, 350, 500, 350, "$(long_seg)", :bottom)
        segment_label!(d, altitude_x, 350, 50, 50, "h", :right)
        
        svg = render(d)
        
        problem(
            question="In right triangle ABC with right angle at C, the altitude from C to hypotenuse AB meets AB at point D. If AD = $(short_seg) and DB = $(long_seg), find the length of altitude CD.",
            answer=altitude,
            difficulty=(2100, 2400),
            solution=steps(
                "When an altitude is drawn to the hypotenuse of a right triangle, it creates three similar triangles: △ABC ~ △ACD ~ △CBD",
                "From the similarity △ACD ~ △CBD, we have \\frac{CD}{AD} = \\frac{DB}{CD}",
                "This gives us CD^2 = AD \\cdot DB = $(short_seg) \\cdot $(long_seg) = $(short_seg * long_seg)",
                sol("CD", "\\sqrt{$(short_seg * long_seg)} = $(altitude)")
            ),
            image=svg,
            time=280
        )
    end
end