# geometry - triangle_congruence (very_easy)
# Generated: 2026-03-08T20:03:37.127150

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_congruence")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Foundational: Identify corresponding parts of congruent triangles
        # ELO: 200-400
        side1 = randint(3, 12)
        side2 = randint(3, 12)
        side3 = randint(3, 12)
        
        vertices1 = ["A", "B", "C"]
        vertices2 = ["D", "E", "F"]
        
        d = DiagramObj(width=500, height=300)
        
        # First triangle
        polygon!(d, [50, 150], [150, 150], [100, 50], fill="lightblue", stroke="black", stroke_width=2)
        text!(d, 50, 165, "A", font_size=16)
        text!(d, 150, 165, "B", font_size=16)
        text!(d, 100, 35, "C", font_size=16)
        segment_label!(d, [50, 150], [150, 150], "$(side1)", :below)
        segment_label!(d, [150, 150], [100, 50], "$(side2)", :right)
        segment_label!(d, [100, 50], [50, 150], "$(side3)", :left)
        
        # Second triangle (congruent)
        polygon!(d, [300, 150], [400, 150], [350, 50], fill="lightgreen", stroke="black", stroke_width=2)
        text!(d, 300, 165, "D", font_size=16)
        text!(d, 400, 165, "E", font_size=16)
        text!(d, 350, 35, "F", font_size=16)
        segment_label!(d, [300, 150], [400, 150], "$(side1)", :below)
        segment_label!(d, [400, 150], [350, 50], "$(side2)", :right)
        segment_label!(d, [350, 50], [300, 150], "$(side3)", :left)
        
        corresponding_side = choice(["AB", "BC", "CA"])
        if corresponding_side == "AB"
            answer = "DE"
        elseif corresponding_side == "BC"
            answer = "EF"
        else
            answer = "FD"
        end
        
        problem(
            question="Triangle ABC is congruent to triangle DEF (ABC ≅ DEF). What side in triangle DEF corresponds to side $(corresponding_side) in triangle ABC?",
            answer=answer,
            difficulty=(200, 400),
            solution=steps(
                "Given: Triangle ABC ≅ Triangle DEF",
                "Corresponding vertices are in order: A↔D, B↔E, C↔F",
                sol("Answer", answer)
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == 2
        # Elementary: Determine if triangles are congruent by SSS
        # ELO: 400-600
        side_a = randint(4, 10)
        side_b = randint(4, 10)
        side_c = randint(4, 10)
        
        match = rand([true, false])
        
        if match
            side_d = side_a
            side_e = side_b
            side_f = side_c
            answer = "Yes"
        else
            side_d = side_a
            side_e = side_b
            side_f = side_c + randint(1, 3)
            answer = "No"
        end
        
        d = DiagramObj(width=500, height=300)
        
        # First triangle
        polygon!(d, [50, 200], [150, 200], [100, 100], fill="lightblue", stroke="black", stroke_width=2)
        text!(d, 50, 220, "P", font_size=16)
        text!(d, 150, 220, "Q", font_size=16)
        text!(d, 100, 80, "R", font_size=16)
        segment_label!(d, [50, 200], [150, 200], "$(side_a)", :below)
        segment_label!(d, [150, 200], [100, 100], "$(side_b)", :right)
        segment_label!(d, [100, 100], [50, 200], "$(side_c)", :left)
        
        # Second triangle
        polygon!(d, [300, 200], [400, 200], [350, 100], fill="lightgreen", stroke="black", stroke_width=2)
        text!(d, 300, 220, "X", font_size=16)
        text!(d, 400, 220, "Y", font_size=16)
        text!(d, 350, 80, "Z", font_size=16)
        segment_label!(d, [300, 200], [400, 200], "$(side_d)", :below)
        segment_label!(d, [400, 200], [350, 100], "$(side_e)", :right)
        segment_label!(d, [350, 100], [300, 200], "$(side_f)", :left)
        
        problem(
            question="Are triangles PQR and XYZ congruent by SSS (Side-Side-Side)? Answer Yes or No.",
            answer=answer,
            difficulty=(400, 600),
            solution=steps(
                "Triangle PQR has sides: $(side_a), $(side_b), $(side_c)",
                "Triangle XYZ has sides: $(side_d), $(side_e), $(side_f)",
                match ? "All three pairs of corresponding sides are equal" : "Not all corresponding sides are equal",
                sol("Answer", answer)
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == 3
        # Elementary: Find missing side using congruence
        # ELO: 500-700
        side1 = randint(5, 15)
        side2 = randint(5, 15)
        side3 = randint(5, 15)
        
        d = DiagramObj(width=500, height=300)
        
        # First triangle with all sides labeled
        polygon!(d, [50, 200], [150, 200], [100, 100], fill="lightblue", stroke="black", stroke_width=2)
        text!(d, 50, 220, "A", font_size=16)
        text!(d, 150, 220, "B", font_size=16)
        text!(d, 100, 80, "C", font_size=16)
        segment_label!(d, [50, 200], [150, 200], "$(side1)", :below)
        segment_label!(d, [150, 200], [100, 100], "$(side2)", :right)
        segment_label!(d, [100, 100], [50, 200], "$(side3)", :left)
        
        # Second triangle with one side missing (marked x)
        polygon!(d, [300, 200], [400, 200], [350, 100], fill="lightgreen", stroke="black", stroke_width=2)
        text!(d, 300, 220, "D", font_size=16)
        text!(d, 400, 220, "E", font_size=16)
        text!(d, 350, 80, "F", font_size=16)
        segment_label!(d, [300, 200], [400, 200], "$(side1)", :below)
        segment_label!(d, [400, 200], [350, 100], "x", :right)
        segment_label!(d, [350, 100], [300, 200], "$(side3)", :left)
        
        answer = side2
        
        problem(
            question="Triangle ABC is congruent to triangle DEF. If AB = $(side1), BC = $(side2), CA = $(side3), DE = $(side1), and FD = $(side3), find the length of side EF (marked as x).",
            answer=answer,
            difficulty=(500, 700),
            solution=steps(
                "Given: Triangle ABC ≅ Triangle DEF",
                "Corresponding sides are equal: AB = DE, BC = EF, CA = FD",
                "Since BC = $(side2) and BC = EF",
                sol("Answer: x =", answer)
            ),
            image=render(d),
            time=75
        )
        
    else
        # Elementary: Identify congruence postulate (SSS, SAS, ASA)
        # ELO: 600-700
        postulate_type = choice(["SSS", "SAS", "ASA"])
        
        d = DiagramObj(width=500, height=300)
        
        if postulate_type == "SSS"
            s1 = randint(5, 12)
            s2 = randint(5, 12)
            s3 = randint(5, 12)
            
            # Triangle 1
            polygon!(d, [50, 200], [150, 200], [100, 100], fill="lightblue", stroke="black", stroke_width=2)
            text!(d, 50, 220, "A", font_size=16)
            text!(d, 150, 220, "B", font_size=16)
            text!(d, 100, 80, "C", font_size=16)
            segment_label!(d, [50, 200], [150, 200], "$(s1)", :below)
            segment_label!(d, [150, 200], [100, 100], "$(s2)", :right)
            segment_label!(d, [100, 100], [50, 200], "$(s3)", :left)
            
            # Triangle 2
            polygon!(d, [300, 200], [400, 200], [350, 100], fill="lightgreen", stroke="black", stroke_width=2)
            text!(d, 300, 220, "D", font_size=16)
            text!(d, 400, 220, "E", font_size=16)
            text!(d, 350, 80, "F", font_size=16)
            segment_label!(d, [300, 200], [400, 200], "$(s1)", :below)
            segment_label!(d, [400, 200], [350, 100], "$(s2)", :right)
            segment_label!(d, [350, 100], [300, 200], "$(s3)", :left)
            
            answer = "SSS"
            
        elseif postulate_type == "SAS"
            s1 = randint(5, 12)
            s2 = randint(5, 12)
            angle = randint(30, 120)
            
            # Triangle 1
            polygon!(d, [50, 200], [150, 200], [100, 100], fill="lightblue", stroke="black", stroke_width=2)
            text!(d, 50, 220, "A", font_size=16)
            text!(d, 150, 220, "B", font_size=16)
            text!(d, 100, 80, "C", font_size=16)
            segment_label!(d, [50, 200], [150, 200], "$(s1)", :below)
            segment_label!(d, [100, 100], [50, 200], "$(s2)", :left)
            angle_arc!(d, [50, 200], [150, 200], [100, 100], label="$(angle)°", radius=25)
            
            # Triangle 2
            polygon!(d, [300, 200], [400, 200], [350, 100], fill="lightgreen", stroke="black", stroke_width=2)
            text!(d, 300, 220, "D", font_size=16)
            text!(d, 400, 220, "E", font_size=16)
            text!(d, 350, 80, "F", font_size=16)
            segment_label!(d, [300, 200], [400, 200], "$(s1)", :below)
            segment_label!(d, [350, 100], [300, 200], "$(s2)", :left)
            angle_arc!(d, [300, 200], [400, 200], [350, 100], label="$(angle)°", radius=25)
            
            answer = "SAS"
            
        else  # ASA
            s1 = randint(5, 12)
            angle1 = randint(30, 70)
            angle2 = randint(30, 70)
            
            # Triangle 1
            polygon!(d, [50, 200], [150, 200], [100, 100], fill="lightblue", stroke="black", stroke_width=2)
            text!(d, 50, 220, "A", font_size=16)
            text!(d, 150, 220, "B", font_size=16)
            text!(d, 100, 80, "C", font_size=16)
            segment_label!(d, [50, 200], [150, 200], "$(s1)", :below)
            angle_arc!(d, [50, 200], [150, 200], [100, 100], label="$(angle1)°", radius=25)
            angle_arc!(d, [150, 200], [100, 100], [50, 200], label="$(angle2)°", radius=25)
            
            # Triangle 2
            polygon!(d, [300, 200], [400, 200], [350, 100], fill="lightgreen", stroke="black", stroke_width=2)
            text!(d, 300, 220, "D", font_size=16)
            text!(d, 400, 220, "E", font_size=16)
            text!(d, 350, 80, "F", font_size=16)
            segment_label!(d, [300, 200], [400, 200], "$(s1)", :below)
            angle_arc!(d, [300, 200], [400, 200], [350, 100], label="$(angle1)°", radius=25)
            angle_arc!(d, [400, 200], [350, 100], [300, 200], label="$(angle2)°", radius=25)
            
            answer = "ASA"
        end
        
        problem(
            question="Which congruence postulate (SSS, SAS, or ASA) proves that these two triangles are congruent?",
            answer=answer,
            difficulty=(600, 700),
            solution=steps(
                "Examine the marked corresponding parts in both triangles",
                postulate_type == "SSS" ? "All three sides are marked as equal" : 
                postulate_type == "SAS" ? "Two sides and the included angle are marked as equal" :
                "Two angles and the included side are marked as equal",
                sol("Congruence postulate", answer)
            ),
            image=render(d),
            time=60
        )
    end
end