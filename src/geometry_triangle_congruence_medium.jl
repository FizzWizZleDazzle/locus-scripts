# geometry - triangle_congruence (medium)
# Generated: 2026-03-08T20:03:51.235668

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_congruence")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # SSS congruence with diagram
        side1 = randint(5, 12)
        side2 = randint(5, 12)
        side3 = randint(5, 12)
        
        # Ensure triangle inequality
        while side1 + side2 <= side3 || side1 + side3 <= side2 || side2 + side3 <= side1
            side1 = randint(5, 12)
            side2 = randint(5, 12)
            side3 = randint(5, 12)
        end
        
        d = DiagramObj(300, 250)
        
        # Triangle ABC
        ax, ay = 30, 200
        bx, by = 130, 200
        cx, cy = 80, 120
        polygon!(d, [ax, bx, cx], [ay, by, cy], :none, "black", 2)
        point!(d, ax, ay, "A", :below_left)
        point!(d, bx, by, "B", :below_right)
        point!(d, cx, cy, "C", :above)
        segment_label!(d, ax, ay, bx, by, "$(side1)", :below)
        segment_label!(d, bx, by, cx, cy, "$(side2)", :right)
        segment_label!(d, cx, cy, ax, ay, "$(side3)", :left)
        
        # Triangle DEF
        dx, dy = 170, 200
        ex, ey = 270, 200
        fx, fy = 220, 120
        polygon!(d, [dx, ex, fx], [dy, ey, fy], :none, "black", 2)
        point!(d, dx, dy, "D", :below_left)
        point!(d, ex, ey, "E", :below_right)
        point!(d, fx, fy, "F", :above)
        segment_label!(d, dx, dy, ex, ey, "$(side1)", :below)
        segment_label!(d, ex, ey, fx, fy, "$(side2)", :right)
        segment_label!(d, fx, fy, dx, dy, "$(side3)", :left)
        
        image = render(d)
        
        problem(
            question="The diagram shows two triangles. Triangle ABC has sides AB = $(side1), BC = $(side2), and CA = $(side3). Triangle DEF has sides DE = $(side1), EF = $(side2), and FD = $(side3). Which congruence theorem proves that △ABC ≅ △DEF?",
            answer="SSS",
            difficulty=(1200, 1400),
            answer_type="text",
            solution=steps(
                "Given: AB = DE = $(side1), BC = EF = $(side2), CA = FD = $(side3)",
                "All three corresponding sides are congruent",
                sol("Congruence Theorem", "SSS (Side-Side-Side)")
            ),
            image=image,
            time=90
        )
        
    elseif problem_type == 2
        # SAS congruence with diagram
        side1 = randint(6, 14)
        angle = randint(40, 100)
        side2 = randint(6, 14)
        
        d = DiagramObj(300, 250)
        
        # Triangle ABC
        ax, ay = 30, 200
        bx, by = 30 + side1 * 8, 200
        angle_rad = angle * π / 180
        cx = ax + side2 * 8 * cos(angle_rad)
        cy = ay - side2 * 8 * sin(angle_rad)
        polygon!(d, [ax, bx, cx], [ay, by, cy], :none, "black", 2)
        point!(d, ax, ay, "A", :below_left)
        point!(d, bx, by, "B", :below_right)
        point!(d, cx, cy, "C", :above)
        segment_label!(d, ax, ay, bx, by, "$(side1)", :below)
        segment_label!(d, ax, ay, cx, cy, "$(side2)", :left)
        angle_arc!(d, ax, ay, bx, by, cx, cy, "$(angle)°")
        
        # Triangle DEF
        dx, dy = 170, 200
        ex, ey = 170 + side1 * 8, 200
        fx = dx + side2 * 8 * cos(angle_rad)
        fy = dy - side2 * 8 * sin(angle_rad)
        polygon!(d, [dx, ex, fx], [dy, ey, fy], :none, "black", 2)
        point!(d, dx, dy, "D", :below_left)
        point!(d, ex, ey, "E", :below_right)
        point!(d, fx, fy, "F", :above)
        segment_label!(d, dx, dy, ex, ey, "$(side1)", :below)
        segment_label!(d, dx, dy, fx, fy, "$(side2)", :left)
        angle_arc!(d, dx, dy, ex, ey, fx, fy, "$(angle)°")
        
        image = render(d)
        
        problem(
            question="The diagram shows two triangles. In △ABC, AB = $(side1), ∠A = $(angle)°, and AC = $(side2). In △DEF, DE = $(side1), ∠D = $(angle)°, and DF = $(side2). Which congruence theorem proves △ABC ≅ △DEF?",
            answer="SAS",
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                "Given: AB = DE = $(side1), ∠A = ∠D = $(angle)°, AC = DF = $(side2)",
                "Two sides and the included angle are congruent",
                sol("Congruence Theorem", "SAS (Side-Angle-Side)")
            ),
            image=image,
            time=90
        )
        
    elseif problem_type == 3
        # ASA congruence with diagram
        angle1 = randint(35, 70)
        side = randint(7, 15)
        angle2 = randint(35, 70)
        
        # Ensure valid triangle
        while angle1 + angle2 >= 180
            angle1 = randint(35, 70)
            angle2 = randint(35, 70)
        end
        
        d = DiagramObj(320, 250)
        
        # Triangle ABC
        ax, ay = 30, 200
        bx, by = 30 + side * 8, 200
        angle1_rad = angle1 * π / 180
        angle2_rad = π - angle1_rad - angle2 * π / 180
        cx = bx - 60 * cos(angle2_rad)
        cy = by - 60 * sin(angle2_rad)
        polygon!(d, [ax, bx, cx], [ay, by, cy], :none, "black", 2)
        point!(d, ax, ay, "A", :below_left)
        point!(d, bx, by, "B", :below_right)
        point!(d, cx, cy, "C", :above)
        segment_label!(d, ax, ay, bx, by, "$(side)", :below)
        angle_arc!(d, ax, ay, bx, by, cx, cy, "$(angle1)°")
        angle_arc!(d, bx, by, ax, ay, cx, cy, "$(angle2)°")
        
        # Triangle DEF
        dx, dy = 180, 200
        ex, ey = 180 + side * 8, 200
        fx = ex - 60 * cos(angle2_rad)
        fy = ey - 60 * sin(angle2_rad)
        polygon!(d, [dx, ex, fx], [dy, ey, fy], :none, "black", 2)
        point!(d, dx, dy, "D", :below_left)
        point!(d, ex, ey, "E", :below_right)
        point!(d, fx, fy, "F", :above)
        segment_label!(d, dx, dy, ex, ey, "$(side)", :below)
        angle_arc!(d, dx, dy, ex, ey, fx, fy, "$(angle1)°")
        angle_arc!(d, ex, ey, dx, dy, fx, fy, "$(angle2)°")
        
        image = render(d)
        
        problem(
            question="The diagram shows two triangles. In △ABC, ∠A = $(angle1)°, AB = $(side), and ∠B = $(angle2)°. In △DEF, ∠D = $(angle1)°, DE = $(side), and ∠E = $(angle2)°. Which congruence theorem proves △ABC ≅ △DEF?",
            answer="ASA",
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                "Given: ∠A = ∠D = $(angle1)°, AB = DE = $(side), ∠B = ∠E = $(angle2)°",
                "Two angles and the included side are congruent",
                sol("Congruence Theorem", "ASA (Angle-Side-Angle)")
            ),
            image=image,
            time=90
        )
        
    else
        # Find missing side/angle using congruence
        side_ab = randint(8, 16)
        side_bc = randint(8, 16)
        side_ca = randint(8, 16)
        
        # Ensure triangle inequality
        while side_ab + side_bc <= side_ca || side_ab + side_ca <= side_bc || side_bc + side_ca <= side_ab
            side_ab = randint(8, 16)
            side_bc = randint(8, 16)
            side_ca = randint(8, 16)
        end
        
        unknown_var = choice(["x", "y"])
        
        d = DiagramObj(300, 250)
        
        # Triangle ABC
        ax, ay = 30, 200
        bx, by = 130, 200
        cx, cy = 80, 120
        polygon!(d, [ax, bx, cx], [ay, by, cy], :none, "black", 2)
        point!(d, ax, ay, "A", :below_left)
        point!(d, bx, by, "B", :below_right)
        point!(d, cx, cy, "C", :above)
        segment_label!(d, ax, ay, bx, by, "$(side_ab)", :below)
        segment_label!(d, bx, by, cx, cy, "$(side_bc)", :right)
        segment_label!(d, cx, cy, ax, ay, "$(side_ca)", :left)
        
        # Triangle DEF with unknown
        dx, dy = 170, 200
        ex, ey = 270, 200
        fx, fy = 220, 120
        polygon!(d, [dx, ex, fx], [dy, ey, fy], :none, "black", 2)
        point!(d, dx, dy, "D", :below_left)
        point!(d, ex, ey, "E", :below_right)
        point!(d, fx, fy, "F", :above)
        segment_label!(d, dx, dy, ex, ey, "$(side_ab)", :below)
        segment_label!(d, ex, ey, fx, fy, "$(unknown_var)", :right)
        segment_label!(d, fx, fy, dx, dy, "$(side_ca)", :left)
        
        image = render(d)
        
        problem(
            question="Given that △ABC ≅ △DEF with AB = $(side_ab), BC = $(side_bc), CA = $(side_ca), DE = $(side_ab), and FD = $(side_ca). The diagram shows both triangles. Find the value of $(unknown_var) where EF = $(unknown_var).",
            answer=side_bc,
            difficulty=(1400, 1600),
            solution=steps(
                "Given: △ABC ≅ △DEF",
                "Corresponding sides of congruent triangles are equal",
                "BC corresponds to EF",
                sol("Therefore, $(unknown_var)", side_bc)
            ),
            image=image,
            time=120
        )
    end
end