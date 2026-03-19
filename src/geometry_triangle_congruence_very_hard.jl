# geometry - triangle_congruence (very_hard)
# Generated: 2026-03-08T20:04:14.344589

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_congruence")
    
    # Generate a competition/olympiad level triangle congruence problem (2500-3500 ELO)
    # We'll create a diagram with two triangles and prove congruence through auxiliary constructions
    
    problem_type = rand(1:3)
    
    if problem_type == 1
        # Problem: Two triangles sharing a common side with angle-side constraints
        # Advanced problem requiring multiple congruence steps
        
        # Choose random dimensions
        base_length = randint(6, 12)
        height1 = randint(4, 8)
        height2 = randint(4, 8)
        angle_measure = randint(35, 70)
        
        d = DiagramObj(width=500, height=400)
        
        # Draw two triangles ABC and DBC sharing side BC
        # A is above BC, D is below BC
        point!(d, 100, 300, "B")
        point!(d, 400, 300, "C")
        point!(d, 250, 150, "A")
        point!(d, 250, 380, "D")
        
        # Triangle ABC
        line!(d, 100, 300, 400, 300)  # BC
        line!(d, 100, 300, 250, 150)  # AB
        line!(d, 250, 150, 400, 300)  # AC
        
        # Triangle DBC
        line!(d, 100, 300, 250, 380)  # DB
        line!(d, 250, 380, 400, 300)  # DC
        
        # Mark equal segments
        tick_marks!(d, 100, 300, 250, 150, 1)  # AB
        tick_marks!(d, 100, 300, 250, 380, 1)  # DB
        tick_marks!(d, 250, 150, 400, 300, 2)  # AC
        tick_marks!(d, 250, 380, 400, 300, 2)  # DC
        
        # Mark angles
        angle_arc!(d, 250, 150, 100, 300, 400, 300, 30)
        angle_arc!(d, 250, 380, 100, 300, 400, 300, 30)
        
        question_text = "In the diagram, triangles ABC and DBC share side BC. It is given that AB = DB, AC = DC, and M is the midpoint of BC. Prove that triangles ABC and DBC are congruent, and determine the measure of ∠AMC if ∠ABC = $(angle_measure)°."
        
        answer_val = 90
        
        solution_text = steps(
            "Given: AB = DB, AC = DC, and BC is a common side",
            "Since AB = DB and AC = DC, point B and C are equidistant from both A and D",
            "This means A and D lie on the perpendicular bisector of BC",
            "Therefore, AM ⊥ BC where M is the midpoint of BC",
            sol("∠AMC", "90°"),
            "By SSS congruence (AB = DB, AC = DC, BC = BC), △ABC ≅ △DBC"
        )
        
        difficulty_rating = (2600, 3200)
        time_limit = 240
        
    elseif problem_type == 2
        # Problem: Prove congruence using angle bisector theorem
        
        side_a = randint(8, 15)
        side_b = randint(8, 15)
        ratio_num = randint(2, 5)
        ratio_den = randint(2, 5)
        
        d = DiagramObj(width=500, height=400)
        
        # Triangle ABC with angle bisector AD
        point!(d, 100, 300, "A")
        point!(d, 450, 300, "B")
        point!(d, 350, 100, "C")
        point!(d, 400, 250, "D")
        
        # Draw triangle
        line!(d, 100, 300, 450, 300)  # AB
        line!(d, 450, 300, 350, 100)  # BC
        line!(d, 350, 100, 100, 300)  # CA
        
        # Draw angle bisector
        line!(d, 100, 300, 400, 250, style="dashed")  # AD
        
        # Mark the angle bisector
        angle_arc!(d, 100, 300, 350, 100, 400, 250, 25)
        angle_arc!(d, 100, 300, 400, 250, 450, 300, 25)
        
        # Labels
        text!(d, 275, 310, "c", fontsize=14)
        text!(d, 430, 200, "a", fontsize=14)
        text!(d, 220, 190, "b", fontsize=14)
        
        question_text = "In triangle ABC, AD bisects ∠BAC, with D on BC. Given AB = c, AC = b, BD = $(ratio_num)x, and DC = $(ratio_den)x. If triangles ABD and CAD have equal areas, prove that the triangle is isosceles and find the relationship between b and c."
        
        answer_val = "b = c"
        
        solution_text = steps(
            "By the Angle Bisector Theorem: BD/DC = AB/AC = c/b",
            sol("Given ratio", "$(ratio_num)x / $(ratio_den)x = c/b"),
            "This simplifies to $(ratio_num)/$(ratio_den) = c/b",
            "If triangles ABD and CAD have equal areas with same height from A:",
            "Then BD = DC (equal bases), so $(ratio_num)x = $(ratio_den)x",
            "This is only possible if the premise requires c = b",
            sol("Conclusion", "The triangle is isosceles with b = c"),
            "Therefore AB = AC and triangle ABC is isosceles"
        )
        
        difficulty_rating = (2700, 3300)
        time_limit = 300
        
    else
        # Problem: Complex configuration with multiple triangles
        
        angle1 = randint(40, 60)
        angle2 = randint(40, 60)
        
        d = DiagramObj(width=500, height=450)
        
        # Complex configuration: quadrilateral ABCD with diagonals
        point!(d, 150, 350, "A")
        point!(d, 450, 350, "B")
        point!(d, 400, 100, "C")
        point!(d, 200, 100, "D")
        point!(d, 300, 225, "E")
        
        # Draw quadrilateral
        line!(d, 150, 350, 450, 350)  # AB
        line!(d, 450, 350, 400, 100)  # BC
        line!(d, 400, 100, 200, 100)  # CD
        line!(d, 200, 100, 150, 350)  # DA
        
        # Draw diagonals
        line!(d, 150, 350, 400, 100, style="dashed")  # AC
        line!(d, 450, 350, 200, 100, style="dashed")  # BD
        
        # Mark equal angles
        angle_arc!(d, 150, 350, 450, 350, 300, 225, 25)
        angle_arc!(d, 400, 100, 200, 100, 300, 225, 25)
        
        tick_marks!(d, 150, 350, 300, 225, 1)  # AE
        tick_marks!(d, 300, 225, 400, 100, 1)  # EC
        
        question_text = "In quadrilateral ABCD, diagonals AC and BD intersect at E. It is given that AE = EC, ∠DAE = ∠BCE, and ∠AED = ∠CEB (vertical angles). Prove that △ADE ≅ △CBE and find ∠AEB if ∠DAE = $(angle1)° and ∠ADE = $(angle2)°."
        
        angle_aeb = 180 - angle1 - angle2
        answer_val = angle_aeb
        
        solution_text = steps(
            "Given: AE = EC, ∠DAE = ∠BCE, ∠AED = ∠CEB",
            "∠AED and ∠CEB are vertical angles, so ∠AED = ∠CEB",
            "By AAS congruence: ∠DAE = ∠BCE, ∠AED = ∠CEB, and AE = EC",
            sol("Therefore", "△ADE ≅ △CBE"),
            "In △ADE: ∠AEB is supplementary to ∠AED",
            "∠AED = 180° - ∠DAE - ∠ADE = 180° - $(angle1)° - $(angle2)°",
            sol("∠AEB", "$(angle_aeb)°"),
            "This confirms the congruence and completes the proof"
        )
        
        difficulty_rating = (2800, 3400)
        time_limit = 270
    end
    
    problem(
        question=question_text,
        answer=answer_val,
        difficulty=difficulty_rating,
        solution=solution_text,
        image=render(d),
        time=time_limit,
        calculator="none"
    )
end