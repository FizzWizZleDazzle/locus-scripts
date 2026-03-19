# geometry - circle_theorems (very_hard)
# Generated: 2026-03-08T20:06:28.602002

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/circle_theorems")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Power of a Point with secants (Competition level 2500-2800)
        R = randint(8, 15)
        angle = randint(25, 65)
        
        # Place circle at origin
        d = DiagramObj(600, 600)
        circle!(d, 300, 300, 200, stroke="black", stroke_width=2, fill="none")
        
        # External point P
        P_dist = R + randint(5, 10)
        Px = 300 + P_dist * 18
        Py = 300
        
        # First secant through two points on circle
        θ1 = deg2rad(angle)
        θ2 = deg2rad(angle + randint(40, 80))
        
        A_x = 300 + 200 * cos(θ1)
        A_y = 300 - 200 * sin(θ1)
        B_x = 300 + 200 * cos(θ2)
        B_y = 300 - 200 * sin(θ2)
        
        # Second secant
        θ3 = deg2rad(-angle)
        θ4 = deg2rad(-angle - randint(40, 80))
        
        C_x = 300 + 200 * cos(θ3)
        C_y = 300 - 200 * sin(θ3)
        D_x = 300 + 200 * cos(θ4)
        D_y = 300 - 200 * sin(θ4)
        
        line!(d, Px, Py, A_x, A_y, stroke="blue", stroke_width=2)
        line!(d, Px, Py, B_x, B_y, stroke="blue", stroke_width=2)
        line!(d, Px, Py, C_x, C_y, stroke="red", stroke_width=2)
        line!(d, Px, Py, D_x, D_y, stroke="red", stroke_width=2)
        
        point!(d, Px, Py, label="P", label_pos="right")
        point!(d, A_x, A_y, label="A", label_pos="left")
        point!(d, B_x, B_y, label="B", label_pos="left")
        point!(d, C_x, C_y, label="C", label_pos="right")
        point!(d, D_x, D_y, label="D", label_pos="right")
        point!(d, 300, 300, radius=2)
        
        PA = randint(6, 12)
        AB = randint(8, 16)
        PC = randint(7, 11)
        
        # Power of point: PA * PB = PC * PD
        PB = PA + AB
        PD = (PA * PB) // PC
        CD = PD - PC
        
        text!(d, 350, 550, "PA = $(PA), AB = $(AB), PC = $(PC)", font_size=18)
        
        problem(
            question="Point P lies outside a circle. Two secants from P intersect the circle at points A, B and C, D respectively (with A and C closer to P). If PA = $(PA), AB = $(AB), and PC = $(PC), find CD.",
            answer=CD,
            difficulty=(2500, 2800),
            solution=steps(
                "By the Power of a Point theorem, for two secants from external point P:",
                sol("PA \\cdot PB = PC \\cdot PD"),
                sol("PB", PA + AB),
                sol("Substituting", PA * PB ~ PC * PD),
                sol("$(PA) \\cdot $(PB) = $(PC) \\cdot PD"),
                sol("PD", PD),
                sol("CD = PD - PC", CD)
            ),
            image=render(d),
            time=240
        )
        
    elseif problem_type == 2
        # Inscribed angle and arc relationship (Competition 2600-3000)
        d = DiagramObj(600, 600)
        circle!(d, 300, 300, 200, stroke="black", stroke_width=2, fill="none")
        
        # Four points on circle forming a cyclic quadrilateral
        θ_A = deg2rad(randint(10, 40))
        θ_B = deg2rad(randint(80, 110))
        θ_C = deg2rad(randint(170, 200))
        θ_D = deg2rad(randint(260, 300))
        
        A_x = 300 + 200 * cos(θ_A)
        A_y = 300 - 200 * sin(θ_A)
        B_x = 300 + 200 * cos(θ_B)
        B_y = 300 - 200 * sin(θ_B)
        C_x = 300 + 200 * cos(θ_C)
        C_y = 300 - 200 * sin(θ_C)
        D_x = 300 + 200 * cos(θ_D)
        D_y = 300 - 200 * sin(θ_D)
        
        line!(d, A_x, A_y, B_x, B_y, stroke="blue", stroke_width=2)
        line!(d, B_x, B_y, C_x, C_y, stroke="blue", stroke_width=2)
        line!(d, C_x, C_y, D_x, D_y, stroke="blue", stroke_width=2)
        line!(d, D_x, D_y, A_x, A_y, stroke="blue", stroke_width=2)
        line!(d, A_x, A_y, C_x, C_y, stroke="red", stroke_width=1.5)
        
        point!(d, A_x, A_y, label="A", label_pos="right")
        point!(d, B_x, B_y, label="B", label_pos="left")
        point!(d, C_x, C_y, label="C", label_pos="left")
        point!(d, D_x, D_y, label="D", label_pos="right")
        
        angle_BAC = randint(35, 55)
        angle_ACD = randint(40, 60)
        
        # In cyclic quadrilateral, opposite angles sum to 180
        # Also inscribed angles subtend arcs
        angle_BDC = angle_BAC  # Same arc BC
        angle_CAD = angle_ACD  # Wait, need to use proper theorem
        
        # Use: angle subtended by arc at center is twice angle at circumference
        # For cyclic quad: ∠ABC + ∠ADC = 180°
        angle_ADC = randint(70, 100)
        angle_ABC = 180 - angle_ADC
        
        text!(d, 250, 550, "∠BAC = $(angle_BAC)°, ∠ADC = $(angle_ADC)°", font_size=18)
        
        # ∠BDC inscribes same arc as ∠BAC
        angle_BDC = angle_BAC
        
        problem(
            question="Cyclic quadrilateral ABCD is inscribed in a circle. If ∠BAC = $(angle_BAC)° and ∠ADC = $(angle_ADC)°, find ∠BDC.",
            answer=angle_BDC,
            difficulty=(2600, 3000),
            solution=steps(
                "In a cyclic quadrilateral, opposite angles are supplementary:",
                sol("∠ABC + ∠ADC = 180°"),
                sol("∠ABC", 180 - angle_ADC),
                "Angles ∠BAC and ∠BDC both subtend arc BC:",
                "By the inscribed angle theorem, angles subtending the same arc are equal:",
                sol("∠BDC = ∠BAC", angle_BDC)
            ),
            image=render(d),
            time=300
        )
        
    elseif problem_type == 3
        # Tangent-chord angle (Olympiad 3000-3400)
        d = DiagramObj(600, 600)
        R = 200
        circle!(d, 300, 300, R, stroke="black", stroke_width=2, fill="none")
        
        # Point A on circle for tangent
        θ_A = deg2rad(randint(20, 50))
        A_x = 300 + R * cos(θ_A)
        A_y = 300 - R * sin(θ_A)
        
        # Tangent at A (perpendicular to radius)
        tangent_angle = θ_A + π/2
        T_len = 250
        T1_x = A_x - T_len * cos(tangent_angle)
        T1_y = A_y + T_len * sin(tangent_angle)
        T2_x = A_x + T_len * cos(tangent_angle)
        T2_y = A_y - T_len * sin(tangent_angle)
        
        line!(d, T1_x, T1_y, T2_x, T2_y, stroke="green", stroke_width=2)
        
        # Chord from A
        θ_B = deg2rad(randint(140, 200))
        B_x = 300 + R * cos(θ_B)
        B_y = 300 - R * sin(θ_B)
        
        line!(d, A_x, A_y, B_x, B_y, stroke="blue", stroke_width=2)
        
        # Another point C
        θ_C = deg2rad(randint(220, 300))
        C_x = 300 + R * cos(θ_C)
        C_y = 300 - R * sin(θ_C)
        
        line!(d, B_x, B_y, C_x, C_y, stroke="blue", stroke_width=2)
        line!(d, C_x, C_y, A_x, A_y, stroke="blue", stroke_width=2)
        
        point!(d, A_x, A_y, label="A", label_pos="right")
        point!(d, B_x, B_y, label="B", label_pos="left")
        point!(d, C_x, C_y, label="C", label_pos="bottom")
        point!(d, 300, 300, label="O", label_pos="top", radius=2)
        
        arc_AB_deg = randint(80, 140)
        
        # Tangent-chord angle equals half the arc it intercepts
        angle_tangent_chord = arc_AB_deg // 2
        
        text!(d, 250, 550, "Arc AB = $(arc_AB_deg)°", font_size=18)
        
        problem(
            question="A tangent to a circle at point A forms an angle with chord AB. If the arc AB (not containing any other marked point) measures $(arc_AB_deg)°, find the measure of the angle between the tangent and chord AB.",
            answer=angle_tangent_chord,
            difficulty=(3000, 3400),
            solution=steps(
                "By the Tangent-Chord Angle Theorem:",
                "The angle between a tangent and a chord equals half the arc intercepted by the chord",
                sol("\\text{Angle}", "\\frac{1}{2} \\cdot \\text{arc } AB"),
                sol("\\text{Angle}", "\\frac{$(arc_AB_deg)°}{2}"),
                sol("\\text{Answer}", angle_tangent_chord)
            ),
            image=render(d),
            time=270
        )
        
    else
        # Ptolemy's Theorem for cyclic quadrilateral (Olympiad 3200-3500)
        d = DiagramObj(600, 600)
        circle!(d, 300, 300, 200, stroke="black", stroke_width=2, fill="none")
        
        θ_A = deg2rad(20)
        θ_B = deg2rad(100)
        θ_C = deg2rad(190)
        θ_D = deg2rad(290)
        
        A_x = 300 + 200 * cos(θ_A)
        A_y = 300 - 200 * sin(θ_A)
        B_x = 300 + 200 * cos(θ_B)
        B_y = 300 - 200 * sin(θ_B)
        C_x = 300 + 200 * cos(θ_C)
        C_y = 300 - 200 * sin(θ_C)
        D_x = 300 + 200 * cos(θ_D)
        D_y = 300 - 200 * sin(θ_D)
        
        line!(d, A_x, A_y, B_x, B_y, stroke="blue", stroke_width=2)
        line!(d, B_x, B_y, C_x, C_y, stroke="blue", stroke_width=2)
        line!(d, C_x, C_y, D_x, D_y, stroke="blue", stroke_width=2)
        line!(d, D_x, D_y, A_x, A_y, stroke="blue", stroke_width=2)
        line!(d, A_x, A_y, C_x, C_y, stroke="red", stroke_width=1.5, stroke_dasharray="5,5")
        line!(d, B_x, B_y, D_x, D_y, stroke="red", stroke_width=1.5, stroke_dasharray="5,5")
        
        point!(d, A_x, A_y, label="A", label_pos="right")
        point!(d, B_x, B_y, label="B", label_pos="left")
        point!(d, C_x, C_y, label="C", label_pos="left")
        point!(d, D_x, D_y, label="D", label_pos="right")
        
        # Choose nice integer values satisfying Ptolemy
        # AC·BD = AB·CD + BC·AD
        AB = randint(7, 13)
        BC = randint(6, 11)
        CD = randint(8, 14)
        AD = randint(7, 12)
        
        # Need to find BD such that Ptolemy holds with integer AC
        # Try: AC·BD = AB·CD + BC·AD
        # Pick AC, solve for BD
        AC = randint(10, 18)
        product = AB * CD + BC * AD
        
        # Make BD divide evenly
        if product % AC == 0
            BD = product // AC
        else
            # Adjust AC to make it work
            AC = randint(10, 18)
            while product % AC != 0
                AC += 1
                if AC > 25
                    AC = product // randint(2, 4)
                    break
                end
            end
            BD = product // AC
        end
        
        text!(d, 150, 560, "AB=$(AB), BC=$(BC), CD=$(CD), AD=$(AD), AC=$(AC)", font_size=16)
        
        problem(
            question="Cyclic quadrilateral ABCD has side lengths AB = $(AB), BC = $(BC), CD = $(CD), and AD = $(AD). Diagonal AC = $(AC). Find the length of diagonal BD.",
            answer=BD,
            difficulty=(3200, 3500),
            solution=steps(
                "Apply Ptolemy's Theorem: AC * BD = AB * CD + BC * AD",
                "Substitute known values and solve for the unknown",
                sol("Answer", BD)
            ),
            time=300
        )
    end
end
