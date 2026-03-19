# geometry - triangle_congruence (easy)
# Generated: 2026-03-08T20:03:39.507782

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_congruence")
    
    # Generate random triangle dimensions
    side1 = randint(3, 12)
    side2 = randint(3, 12)
    side3 = randint(3, 12)
    
    # Ensure valid triangle inequality
    while !(side1 + side2 > side3 && side1 + side3 > side2 && side2 + side3 > side1)
        side1 = randint(3, 12)
        side2 = randint(3, 12)
        side3 = randint(3, 12)
    end
    
    # Choose random angles for first triangle
    angle1 = randint(35, 75)
    angle2 = randint(40, 80)
    angle3 = 180 - angle1 - angle2
    
    # Decide problem type
    problem_type = choice(["SSS", "SAS", "ASA", "AAS"])
    
    if problem_type == "SSS"
        # Side-Side-Side congruence
        d = DiagramObj(width=500, height=300)
        
        # First triangle (ABC)
        ax, ay = 50, 200
        bx, by = ax + side1 * 20, ay
        cx, cy = ax + side2 * 20 * cos(angle1 * π / 180), ay - side2 * 20 * sin(angle1 * π / 180)
        
        polygon!(d, [ax, bx, cx], [ay, by, cy], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, "A", ax - 15, ay + 15)
        text!(d, "B", bx + 10, by + 15)
        text!(d, "C", cx, cy - 15)
        
        segment_label!(d, (ax + bx) / 2, (ay + by) / 2 + 20, "$(side1)")
        segment_label!(d, (ax + cx) / 2 - 20, (ay + cy) / 2, "$(side2)")
        segment_label!(d, (bx + cx) / 2 + 15, (by + cy) / 2, "$(side3)")
        
        # Second triangle (DEF)
        dx, dy = 280, 200
        ex, ey = dx + side1 * 20, dy
        fx, fy = dx + side2 * 20 * cos(angle1 * π / 180), dy - side2 * 20 * sin(angle1 * π / 180)
        
        polygon!(d, [dx, ex, fx], [dy, ey, fy], stroke="red", fill="lightcoral", opacity=0.3)
        text!(d, "D", dx - 15, dy + 15)
        text!(d, "E", ex + 10, ey + 15)
        text!(d, "F", fx, fy - 15)
        
        segment_label!(d, (dx + ex) / 2, (dy + ey) / 2 + 20, "$(side1)")
        segment_label!(d, (dx + fx) / 2 - 20, (dy + fy) / 2, "$(side2)")
        segment_label!(d, (ex + fx) / 2 + 15, (ey + fy) / 2, "$(side3)")
        
        question_text = "Triangle ABC has sides AB = $(side1), AC = $(side2), and BC = $(side3). Triangle DEF has sides DE = $(side1), DF = $(side2), and EF = $(side3). Are the triangles congruent? If yes, which congruence criterion applies?"
        answer_text = "SSS"
        solution_text = steps(
            "Given: AB = DE = $(side1), AC = DF = $(side2), BC = EF = $(side3)",
            "All three corresponding sides are equal",
            "By Side-Side-Side (SSS) congruence criterion, △ABC ≅ △DEF",
            sol("Answer", "SSS")
        )
        difficulty_val = (700, 900)
        
    elseif problem_type == "SAS"
        # Side-Angle-Side congruence
        d = DiagramObj(width=500, height=300)
        
        included_angle = randint(40, 80)
        
        # First triangle (ABC)
        ax, ay = 50, 200
        bx, by = ax + side1 * 20, ay
        cx, cy = ax + side2 * 20 * cos(included_angle * π / 180), ay - side2 * 20 * sin(included_angle * π / 180)
        
        polygon!(d, [ax, bx, cx], [ay, by, cy], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, "A", ax - 15, ay + 15)
        text!(d, "B", bx + 10, by + 15)
        text!(d, "C", cx, cy - 15)
        
        segment_label!(d, (ax + bx) / 2, (ay + by) / 2 + 20, "$(side1)")
        segment_label!(d, (ax + cx) / 2 - 20, (ay + cy) / 2, "$(side2)")
        angle_arc!(d, ax, ay, 25, 0, included_angle, "$(included_angle)°")
        
        # Second triangle (DEF)
        dx, dy = 280, 200
        ex, ey = dx + side1 * 20, dy
        fx, fy = dx + side2 * 20 * cos(included_angle * π / 180), dy - side2 * 20 * sin(included_angle * π / 180)
        
        polygon!(d, [dx, ex, fx], [dy, ey, fy], stroke="red", fill="lightcoral", opacity=0.3)
        text!(d, "D", dx - 15, dy + 15)
        text!(d, "E", ex + 10, ey + 15)
        text!(d, "F", fx, fy - 15)
        
        segment_label!(d, (dx + ex) / 2, (dy + ey) / 2 + 20, "$(side1)")
        segment_label!(d, (dx + fx) / 2 - 20, (dy + fy) / 2, "$(side2)")
        angle_arc!(d, dx, dy, 25, 0, included_angle, "$(included_angle)°")
        
        question_text = "Triangle ABC has AB = $(side1), AC = $(side2), and ∠A = $(included_angle)°. Triangle DEF has DE = $(side1), DF = $(side2), and ∠D = $(included_angle)°. Which congruence criterion proves these triangles are congruent?"
        answer_text = "SAS"
        solution_text = steps(
            "Given: AB = DE = $(side1), AC = DF = $(side2), ∠A = ∠D = $(included_angle)°",
            "Two sides and the included angle are equal",
            "By Side-Angle-Side (SAS) congruence criterion, △ABC ≅ △DEF",
            sol("Answer", "SAS")
        )
        difficulty_val = (800, 1000)
        
    elseif problem_type == "ASA"
        # Angle-Side-Angle congruence
        d = DiagramObj(width=500, height=300)
        
        angle_a = randint(40, 70)
        angle_b = randint(45, 75)
        side_between = randint(4, 10)
        
        # First triangle (ABC)
        ax, ay = 50, 200
        bx, by = ax + side_between * 20, ay
        cx, cy = ax + 80 * cos(angle_a * π / 180), ay - 80 * sin(angle_a * π / 180)
        
        polygon!(d, [ax, bx, cx], [ay, by, cy], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, "A", ax - 15, ay + 15)
        text!(d, "B", bx + 10, by + 15)
        text!(d, "C", cx, cy - 15)
        
        segment_label!(d, (ax + bx) / 2, (ay + by) / 2 + 20, "$(side_between)")
        angle_arc!(d, ax, ay, 25, 0, angle_a, "$(angle_a)°")
        angle_arc!(d, bx, by, 25, 180 - angle_b, 180, "$(angle_b)°")
        
        # Second triangle (DEF)
        dx, dy = 280, 200
        ex, ey = dx + side_between * 20, dy
        fx, fy = dx + 80 * cos(angle_a * π / 180), dy - 80 * sin(angle_a * π / 180)
        
        polygon!(d, [dx, ex, fx], [dy, ey, fy], stroke="red", fill="lightcoral", opacity=0.3)
        text!(d, "D", dx - 15, dy + 15)
        text!(d, "E", ex + 10, ey + 15)
        text!(d, "F", fx, fy - 15)
        
        segment_label!(d, (dx + ex) / 2, (dy + ey) / 2 + 20, "$(side_between)")
        angle_arc!(d, dx, dy, 25, 0, angle_a, "$(angle_a)°")
        angle_arc!(d, ex, ey, 25, 180 - angle_b, 180, "$(angle_b)°")
        
        question_text = "Triangle ABC has ∠A = $(angle_a)°, AB = $(side_between), and ∠B = $(angle_b)°. Triangle DEF has ∠D = $(angle_a)°, DE = $(side_between), and ∠E = $(angle_b)°. Which congruence criterion applies?"
        answer_text = "ASA"
        solution_text = steps(
            "Given: ∠A = ∠D = $(angle_a)°, AB = DE = $(side_between), ∠B = ∠E = $(angle_b)°",
            "Two angles and the included side are equal",
            "By Angle-Side-Angle (ASA) congruence criterion, △ABC ≅ △DEF",
            sol("Answer", "ASA")
        )
        difficulty_val = (850, 1050)
        
    else  # AAS
        # Angle-Angle-Side congruence
        d = DiagramObj(width=500, height=300)
        
        angle_a = randint(45, 75)
        angle_b = randint(40, 70)
        side_non_included = randint(5, 11)
        
        # First triangle (ABC)
        ax, ay = 50, 200
        bx, by = ax + side_non_included * 20, ay
        cx, cy = ax + 90 * cos(angle_a * π / 180), ay - 90 * sin(angle_a * π / 180)
        
        polygon!(d, [ax, bx, cx], [ay, by, cy], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, "A", ax - 15, ay + 15)
        text!(d, "B", bx + 10, by + 15)
        text!(d, "C", cx, cy - 15)
        
        segment_label!(d, (bx + cx) / 2 + 15, (by + cy) / 2, "$(side_non_included)")
        angle_arc!(d, ax, ay, 25, 0, angle_a, "$(angle_a)°")
        angle_arc!(d, bx, by, 25, 180 - angle_b, 180, "$(angle_b)°")
        
        # Second triangle (DEF)
        dx, dy = 280, 200
        ex, ey = dx + side_non_included * 20, dy
        fx, fy = dx + 90 * cos(angle_a * π / 180), dy - 90 * sin(angle_a * π / 180)
        
        polygon!(d, [dx, ex, fx], [dy, ey, fy], stroke="red", fill="lightcoral", opacity=0.3)
        text!(d, "D", dx - 15, dy + 15)
        text!(d, "E", ex + 10, ey + 15)
        text!(d, "F", fx, fy - 15)
        
        segment_label!(d, (ex + fx) / 2 + 15, (ey + fy) / 2, "$(side_non_included)")
        angle_arc!(d, dx, dy, 25, 0, angle_a, "$(angle_a)°")
        angle_arc!(d, ex, ey, 25, 180 - angle_b, 180, "$(angle_b)°")
        
        question_text = "Triangle ABC has ∠A = $(angle_a)°, ∠B = $(angle_b)°, and BC = $(side_non_included). Triangle DEF has ∠D = $(angle_a)°, ∠E = $(angle_b)°, and EF = $(side_non_included). Which congruence criterion proves congruence?"
        answer_text = "AAS"
        solution_text = steps(
            "Given: ∠A = ∠D = $(angle_a)°, ∠B = ∠E = $(angle_b)°, BC = EF = $(side_non_included)",
            "Two angles and a non-included side are equal",
            "By Angle-Angle-Side (AAS) congruence criterion, △ABC ≅ △DEF",
            sol("Answer", "AAS")
        )
        difficulty_val = (900, 1150)
    end
    
    problem(
        question=question_text,
        answer=answer_text,
        difficulty=difficulty_val,
        solution=solution_text,
        image=render(d),
        time=90,
        answer_type="text"
    )
end