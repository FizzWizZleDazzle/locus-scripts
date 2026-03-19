# geometry - triangle_congruence (hard)
# Generated: 2026-03-08T20:04:03.529425

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("geometry/triangle_congruence")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # SSS congruence with side lengths involving algebraic expressions
        # Difficulty: 1800-2000
        a_base = randint(8, 15)
        b_base = randint(8, 15)
        c_base = randint(8, 15)
        
        # Make sure triangle inequality holds
        while a_base + b_base <= c_base || a_base + c_base <= b_base || b_base + c_base <= a_base
            a_base = randint(8, 15)
            b_base = randint(8, 15)
            c_base = randint(8, 15)
        end
        
        k = nonzero(2, 5)
        m = randint(3, 8)
        
        # Triangle 1 has sides: a_base, b_base, c_base
        # Triangle 2 has sides: k*x - m, b_base, c_base
        # Find x such that k*x - m = a_base
        ans = (a_base + m) // k
        
        d = DiagramObj(400, 300)
        # Triangle 1
        polygon!(d, [(50, 250), (150, 80), (220, 250)], :none, :black, 2)
        text!(d, 40, 270, "A", 14)
        text!(d, 150, 60, "B", 14)
        text!(d, 230, 270, "C", 14)
        segment_label!(d, 100, 165, "$(a_base)", 12)
        segment_label!(d, 185, 165, "$(b_base)", 12)
        segment_label!(d, 135, 265, "$(c_base)", 12)
        
        # Triangle 2
        polygon!(d, [(280, 250), (380, 80), (350, 250)], :none, :blue, 2)
        text!(d, 270, 270, "D", 14)
        text!(d, 390, 60, "E", 14)
        text!(d, 360, 270, "F", 14)
        segment_label!(d, 330, 165, "$(k)x - $(m)", 12, :blue)
        segment_label!(d, 365, 165, "$(b_base)", 12, :blue)
        segment_label!(d, 315, 265, "$(c_base)", 12, :blue)
        
        problem(
            question="Triangles ABC and DEF are congruent by SSS. If AB = $(a_base), BC = $(c_base), AC = $(b_base), and DE = $(k)x - $(m), EF = $(c_base), DF = $(b_base), find the value of x.",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Since triangles are congruent by SSS, all corresponding sides are equal",
                "Matching sides: AB corresponds to DE, so $(a_base) = $(k)x - $(m)",
                sol("Solve", a_base ~ k*x - m),
                "Add $(m) to both sides: $(k)x = $(a_base + m)",
                sol("Answer", ans)
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 2
        # ASA congruence with angles
        # Difficulty: 1900-2100
        angle1 = randint(35, 65)
        angle2 = randint(40, 70)
        angle3 = 180 - angle1 - angle2
        
        # Second triangle has algebraic angle
        k = nonzero(2, 4)
        m = randint(5, 20)
        # k*x + m = angle1
        ans = (angle1 - m) // k
        
        side_between = randint(10, 18)
        
        d = DiagramObj(450, 300)
        # Triangle 1
        polygon!(d, [(50, 250), (150, 100), (200, 250)], :none, :black, 2)
        text!(d, 40, 270, "A", 14)
        text!(d, 150, 80, "B", 14)
        text!(d, 210, 270, "C", 14)
        angle_arc!(d, 50, 250, 20, 0, angle1, :black)
        text!(d, 75, 240, "$(angle1)°", 11)
        angle_arc!(d, 200, 250, 20, 180-angle2, 180, :black)
        text!(d, 170, 240, "$(angle2)°", 11)
        segment_label!(d, 125, 265, "$(side_between)", 12)
        
        # Triangle 2
        polygon!(d, [(280, 250), (380, 100), (430, 250)], :none, :blue, 2)
        text!(d, 270, 270, "D", 14)
        text!(d, 380, 80, "E", 14)
        text!(d, 440, 270, "F", 14)
        angle_arc!(d, 280, 250, 20, 0, angle1, :blue)
        text!(d, 305, 240, "$(k)x + $(m)°", 11, :blue)
        angle_arc!(d, 430, 250, 20, 180-angle2, 180, :blue)
        text!(d, 395, 240, "$(angle2)°", 11, :blue)
        segment_label!(d, 355, 265, "$(side_between)", 12, :blue)
        
        problem(
            question="Triangles ABC and DEF are congruent by ASA. Given ∠A = $(angle1)°, ∠C = $(angle2)°, AC = $(side_between), and ∠D = $(k)x + $(m)°, ∠F = $(angle2)°, DF = $(side_between), find x.",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "By ASA congruence, corresponding angles are equal",
                "∠A corresponds to ∠D (both adjacent to the equal side)",
                sol("Equation", angle1 ~ k*x + m),
                "Subtract $(m) from both sides: $(k)x = $(angle1 - m)",
                sol("Answer", ans)
            ),
            image=render(d),
            time=150
        )
        
    elseif problem_type == 3
        # SAS congruence problem
        # Difficulty: 2000-2200
        side1 = randint(12, 20)
        side2 = randint(10, 18)
        included_angle = randint(45, 90)
        
        # Second triangle has expression for one side
        a = nonzero(2, 5)
        b = randint(8, 20)
        # a*x - b = side1
        ans = (side1 + b) // a
        
        d = DiagramObj(450, 320)
        # Triangle 1
        polygon!(d, [(50, 280), (50, 150), (180, 280)], :none, :black, 2)
        text!(d, 35, 295, "P", 14)
        text!(d, 35, 135, "Q", 14)
        text!(d, 195, 295, "R", 14)
        segment_label!(d, 25, 215, "$(side1)", 12)
        segment_label!(d, 115, 295, "$(side2)", 12)
        angle_arc!(d, 50, 280, 25, 0, 90, :black)
        text!(d, 80, 265, "$(included_angle)°", 11)
        
        # Triangle 2
        polygon!(d, [(280, 280), (280, 150), (410, 280)], :none, :blue, 2)
        text!(d, 265, 295, "S", 14)
        text!(d, 265, 135, "T", 14)
        text!(d, 425, 295, "U", 14)
        segment_label!(d, 250, 215, "$(a)x - $(b)", 12, :blue)
        segment_label!(d, 345, 295, "$(side2)", 12, :blue)
        angle_arc!(d, 280, 280, 25, 0, 90, :blue)
        text!(d, 310, 265, "$(included_angle)°", 11, :blue)
        
        problem(
            question="Triangles PQR and STU are congruent by SAS. Given PQ = $(side1), PR = $(side2), ∠P = $(included_angle)°, and ST = $(a)x - $(b), SU = $(side2), ∠S = $(included_angle)°, find x.",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "By SAS congruence, the two sides forming the equal angle must be equal",
                "PQ corresponds to ST (both adjacent to the equal angle and opposite sides match)",
                sol("Set equal", side1 ~ a*x - b),
                "Add $(b): $(a)x = $(side1 + b)",
                sol("Answer", ans)
            ),
            image=render(d),
            time=180
        )
        
    else
        # AAS congruence with two angles and non-included side
        # Difficulty: 2100-2400
        angle_A = randint(40, 70)
        angle_B = randint(35, 65)
        angle_C = 180 - angle_A - angle_B
        
        non_included_side = randint(15, 25)
        
        # Second triangle angle expression
        p = nonzero(3, 6)
        q = randint(10, 30)
        # p*x - q = angle_B
        ans = (angle_B + q) // p
        
        d = DiagramObj(500, 300)
        # Triangle 1
        polygon!(d, [(40, 250), (140, 80), (220, 250)], :none, :black, 2)
        text!(d, 30, 270, "A", 14)
        text!(d, 140, 60, "B", 14)
        text!(d, 230, 270, "C", 14)
        angle_arc!(d, 40, 250, 20, 0, 50, :black)
        text!(d, 65, 240, "$(angle_A)°", 11)
        angle_arc!(d, 140, 80, 20, 240, 300, :black)
        text!(d, 125, 100, "$(angle_B)°", 11)
        segment_label!(d, 130, 265, "$(non_included_side)", 12)
        
        # Triangle 2
        polygon!(d, [(280, 250), (380, 80), (460, 250)], :none, :blue, 2)
        text!(d, 270, 270, "D", 14)
        text!(d, 380, 60, "E", 14)
        text!(d, 470, 270, "F", 14)
        angle_arc!(d, 280, 250, 20, 0, 50, :blue)
        text!(d, 305, 240, "$(angle_A)°", 11, :blue)
        angle_arc!(d, 380, 80, 20, 240, 300, :blue)
        text!(d, 360, 100, "$(p)x - $(q)°", 11, :blue)
        segment_label!(d, 370, 265, "$(non_included_side)", 12, :blue)
        
        problem(
            question="Triangles ABC and DEF are congruent by AAS. Given ∠A = $(angle_A)°, ∠B = $(angle_B)°, AC = $(non_included_side), and ∠D = $(angle_A)°, ∠E = $(p)x - $(q)°, DF = $(non_included_side), find x.",
            answer=ans,
            difficulty=(2100, 2400),
            solution=steps(
                "By AAS congruence, two angles and the non-included side are equal",
                "∠B corresponds to ∠E",
                sol("Set equal", angle_B ~ p*x - q),
                "Add $(q): $(p)x = $(angle_B + q)",
                "Divide by $(p)",
                sol("Answer", ans)
            ),
            image=render(d),
            time=180
        )
    end
end