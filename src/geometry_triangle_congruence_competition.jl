# geometry - triangle_congruence (competition)
# Generated: 2026-03-08T20:04:26.427845

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_congruence")
    
    # Generate a challenging olympiad-level triangle congruence problem
    # We'll create a configuration with multiple triangles and ask for a proof
    
    problem_type = rand(1:3)
    
    if problem_type == 1
        # Complex configuration: Two triangles sharing a common side with perpendicular bisectors
        # This requires understanding of congruence, perpendicular bisectors, and isosceles triangles
        
        AB = randint(6, 12)
        angle_BAC = randint(40, 70)
        angle_ABC = randint(40, 70)
        
        d = DiagramObj(width=500, height=400)
        
        # Triangle ABC
        Ax, Ay = 50, 300
        Bx, By = Ax + AB * 30, Ay
        
        # Calculate C position using angles
        angle_rad = deg2rad(angle_BAC)
        Cx = Ax + 200 * cos(angle_rad)
        Cy = Ay - 200 * sin(angle_rad)
        
        # Point D on AB such that CD is perpendicular to AB
        Dx = (Ax + Bx) / 2
        Dy = Ay
        
        # Point E on AC extended
        Ex = Ax + 350 * cos(angle_rad)
        Ey = Ay - 350 * sin(angle_rad)
        
        # Point F such that triangle DEF is congruent to something interesting
        Fx = Dx + (Cx - Dx)
        Fy = Dy - abs(Cy - Dy)
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], fill="none", stroke="blue", stroke_width=2)
        line!(d, Cx, Cy, Dx, Dy, stroke="green", stroke_width=2)
        line!(d, Dx, Dy, Fx, Fy, stroke="red", stroke_width=2)
        line!(d, Fx, Fy, Cx, Cy, stroke="red", stroke_width=2)
        
        point!(d, Ax, Ay, label="A", label_pos="bottom")
        point!(d, Bx, By, label="B", label_pos="bottom")
        point!(d, Cx, Cy, label="C", label_pos="top")
        point!(d, Dx, Dy, label="D", label_pos="bottom")
        point!(d, Fx, Fy, label="F", label_pos="top")
        
        right_angle!(d, Dx, Dy, Cx, Cy, Ax, Ay, size=15)
        
        segment_label!(d, Ax, Ay, Dx, Dy, "$(div(AB,2))", offset=15)
        segment_label!(d, Dx, Dy, Bx, By, "$(div(AB,2))", offset=15)
        
        question_text = "In the diagram, triangle \\(ABC\\) has \\(AB = $(AB)\\), and \\(D\\) is the midpoint of \\(AB\\). " *
                       "\\(CD \\perp AB\\). Point \\(F\\) is constructed such that \\(DF \\perp AB\\), \\(DF = CD\\), " *
                       "and \\(F\\) is on the opposite side of \\(AB\\) from \\(C\\). " *
                       "Prove that \\(\\triangle ACD \\cong \\triangle BFD\\) and determine the congruence criterion used."
        
        answer_text = "SAS"
        
        solution_text = steps(
            "Given: \\(D\\) is the midpoint of \\(AB\\), so \\(AD = BD = $(div(AB,2))\\)",
            "Given: \\(CD \\perp AB\\) and \\(DF \\perp AB\\), and \\(DF = CD\\) by construction",
            "Both \\(\\angle ADC\\) and \\(\\angle BDF\\) are right angles (both 90°)",
            "By SAS (Side-Angle-Side): \\(AD = BD\\), \\(\\angle ADC = \\angle BDF = 90°\\), and \\(CD = DF\\)",
            sol("Therefore", "\\(\\triangle ACD \\cong \\triangle BFD\\) by SAS"),
            "The congruence criterion is SAS"
        )
        
        difficulty_level = (3500, 4200)
        time_limit = 480
        
    elseif problem_type == 2
        # Advanced problem: Circle with inscribed triangles and tangent properties
        
        radius = randint(5, 10)
        
        d = DiagramObj(width=500, height=500)
        
        cx, cy = 250, 250
        circle!(d, cx, cy, radius * 25, fill="none", stroke="blue", stroke_width=2)
        
        # Three points on circle
        angle1 = randint(10, 80)
        angle2 = angle1 + randint(90, 140)
        angle3 = angle2 + randint(90, 140)
        
        Ax = cx + radius * 25 * cos(deg2rad(angle1))
        Ay = cy + radius * 25 * sin(deg2rad(angle1))
        
        Bx = cx + radius * 25 * cos(deg2rad(angle2))
        By = cy + radius * 25 * sin(deg2rad(angle2))
        
        Cx = cx + radius * 25 * cos(deg2rad(angle3))
        Cy = cy + radius * 25 * sin(deg2rad(angle3))
        
        # Tangent points
        Tx = cx + radius * 25 * cos(deg2rad((angle1 + angle2)/2))
        Ty = cy + radius * 25 * sin(deg2rad((angle1 + angle2)/2))
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], fill="none", stroke="green", stroke_width=2)
        line!(d, cx, cy, Ax, Ay, stroke="gray", stroke_width=1, stroke_dasharray="5,5")
        line!(d, cx, cy, Bx, By, stroke="gray", stroke_width=1, stroke_dasharray="5,5")
        line!(d, cx, cy, Cx, Cy, stroke="gray", stroke_width=1, stroke_dasharray="5,5")
        
        point!(d, cx, cy, label="O", label_pos="center")
        point!(d, Ax, Ay, label="A", label_pos="bottom")
        point!(d, Bx, By, label="B", label_pos="left")
        point!(d, Cx, Cy, label="C", label_pos="right")
        
        question_text = "Let \\(O\\) be the center of a circle with radius \\($(radius)\\). " *
                       "Points \\(A\\), \\(B\\), and \\(C\\) lie on the circle such that \\(OA = OB = OC = $(radius)\\). " *
                       "If \\(\\triangle OAB\\) and \\(\\triangle OBC\\) share the common side \\(OB\\), " *
                       "and it is given that \\(AB = BC\\), prove that \\(\\triangle OAB \\cong \\triangle OCB\\) " *
                       "and identify all congruence criteria that apply."
        
        answer_text = "SSS"
        
        solution_text = steps(
            "Given: \\(OA = OB = OC = $(radius)\\) (all radii of the circle)",
            "Given: \\(AB = BC\\) (provided condition)",
            "Note that \\(OB\\) is a common side to both triangles",
            "In \\(\\triangle OAB\\): sides are \\(OA = $(radius)\\), \\(OB = $(radius)\\), \\(AB\\)",
            "In \\(\\triangle OCB\\): sides are \\(OC = $(radius)\\), \\(OB = $(radius)\\), \\(BC = AB\\)",
            "By SSS (Side-Side-Side): \\(OA = OC\\), \\(AB = BC\\), and \\(OB = OB\\)",
            sol("Therefore", "\\(\\triangle OAB \\cong \\triangle OCB\\) by SSS"),
            "Additionally, SAS also applies: \\(OA = OC\\), \\(\\angle AOB = \\angle COB\\) (by congruent triangles), \\(OB = OB\\)"
        )
        
        difficulty_level = (3800, 4500)
        time_limit = 540
        
    else
        # Ultra-hard: Prove congruence in a complex hexagon configuration
        
        side = randint(4, 8)
        
        d = DiagramObj(width=600, height=500)
        
        # Regular hexagon ABCDEF with special construction
        cx, cy = 300, 250
        hex_radius = 120
        
        points_x = []
        points_y = []
        labels = ["A", "B", "C", "D", "E", "F"]
        
        for i in 0:5
            angle = deg2rad(60 * i)
            px = cx + hex_radius * cos(angle)
            py = cy + hex_radius * sin(angle)
            push!(points_x, px)
            push!(points_y, py)
            point!(d, px, py, label=labels[i+1], label_pos=(i % 2 == 0 ? "right" : "left"))
        end
        
        # Draw hexagon
        for i in 1:6
            next_i = (i % 6) + 1
            line!(d, points_x[i], points_y[i], points_x[next_i], points_y[next_i], 
                  stroke="blue", stroke_width=2)
        end
        
        # Draw diagonals AD, BE, CF
        line!(d, points_x[1], points_y[1], points_x[4], points_y[4], stroke="red", stroke_width=1.5)
        line!(d, points_x[2], points_y[2], points_x[5], points_y[5], stroke="red", stroke_width=1.5)
        line!(d, points_x[3], points_y[3], points_x[6], points_y[6], stroke="red", stroke_width=1.5)
        
        # Center point
        point!(d, cx, cy, label="O", label_pos="center")
        
        question_text = "In regular hexagon \\(ABCDEF\\) with side length \\($(side)\\), " *
                       "the three main diagonals \\(AD\\), \\(BE\\), and \\(CF\\) intersect at point \\(O\\). " *
                       "Prove that \\(\\triangle AOB \\cong \\triangle COD \\cong \\triangle EOF\\). " *
                       "Furthermore, prove that all six triangles formed by consecutive vertices and the center " *
                       "are congruent. State the congruence criterion and explain why rotational symmetry " *
                       "guarantees this result."
        
        answer_text = "SAS"
        
        solution_text = steps(
            "In a regular hexagon, all sides are equal: \\(AB = BC = CD = DE = EF = FA = $(side)\\)",
            "The center \\(O\\) is equidistant from all vertices, so \\(OA = OB = OC = OD = OE = OF\\)",
            "Each central angle is \\(360° / 6 = 60°\\), so \\(\\angle AOB = \\angle BOC = \\angle COD = \\angle DOE = \\angle EOF = \\angle FOA = 60°\\)",
            "For \\(\\triangle AOB\\) and \\(\\triangle COD\\): \\(OA = OC\\) (radii), \\(\\angle AOB = \\angle COD = 60°\\), \\(OB = OD\\) (radii)",
            "By SAS: \\(\\triangle AOB \\cong \\triangle COD\\)",
            "Similarly, \\(\\triangle EOF \\cong \\triangle AOB\\) by the same reasoning (rotational symmetry of 120°)",
            sol("All six triangles are congruent by SAS", ""),
            "Rotational symmetry of order 6 guarantees that rotating by 60° maps each triangle onto the next",
            "This is a fundamental property of regular polygons: the center creates congruent isosceles triangles"
        )
        
        difficulty_level = (4200, 4800)
        time_limit = 600
    end
    
    problem(
        question=question_text,
        answer=answer_text,
        difficulty=difficulty_level,
        solution=solution_text,
        image=render(d),
        time=time_limit,
        calculator="none"
    )
end