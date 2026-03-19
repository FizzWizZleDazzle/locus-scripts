# geometry - right_triangle_trig (very_hard)
# Generated: 2026-03-08T20:13:26.431493

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/right_triangle_trig")
    
    # Competition to Olympiad level: 2500-3500 ELO
    # Create a challenging right triangle problem with multiple insights required
    
    # Choose problem type
    prob_type = choice(1:3)
    
    if prob_type == 1
        # Advanced angle chasing with nested right triangles
        # Pick clean angles that lead to exact values
        angle_A = choice([15, 18, 22, 30, 36, 45])
        
        # Create a diagram with point D on hypotenuse creating two right triangles
        a = randint(8, 20)
        
        d = DiagramObj(width=400, height=350)
        
        # Main right triangle ABC with right angle at C
        A = (50, 280)
        C = (320, 280)
        B = (320, 80)
        
        # Point D on AB
        t = rand() * 0.4 + 0.3  # Between 0.3 and 0.7
        D = (A[1] + t * (B[1] - A[1]), A[2] + t * (B[2] - A[2]))
        
        # Draw triangles
        polygon!(d, [A, C, B], stroke="black", fill="none", width=2)
        line!(d, D, C, stroke="blue", width=2, dash="4,4")
        
        # Mark right angles
        right_angle!(d, A, C, B, size=15)
        right_angle!(d, D, C, A, size=12)
        
        # Label points
        text!(d, A[1]-15, A[2]+15, "A", fontsize=16)
        text!(d, C[1]+15, C[2]+15, "C", fontsize=16)
        text!(d, B[1]+15, B[2]-10, "B", fontsize=16)
        text!(d, D[1]-15, D[2]-15, "D", fontsize=16)
        
        # Label angle and side
        text!(d, A[1]+25, A[2]-20, "$(angle_A)°", fontsize=14)
        segment_label!(d, A, C, "$(a)", position=:below, offset=10)
        
        # Calculate answer using trig
        # In triangle ABC: BC/AC = tan(angle_A), so BC = a*tan(angle_A)
        # In triangle ACD: CD/AC = sin(angle_A), so CD = a*sin(angle_A)
        # In triangle BCD: angle BCD = 90°, we need angle BDC
        
        # Using exact values for competition math
        if angle_A == 30
            tan_val = 1//3 * sqrt(3)
            sin_val = 1//2
            answer_angle = 60
        elseif angle_A == 45
            tan_val = 1
            sin_val = sqrt(2)//2
            answer_angle = 45
        else
            # For other angles, use approximation
            tan_val = tan(deg2rad(angle_A))
            sin_val = sin(deg2rad(angle_A))
            answer_angle = round(Int, 90 - angle_A)
        end
        
        question_text = "In the diagram, triangle \\(ABC\\) is a right triangle with \\(\\angle ACB = 90°\\), \\(\\angle CAB = $(angle_A)°\\), and \\(AC = $(a)\\). Point \\(D\\) lies on \\(AB\\) such that \\(CD \\perp AC\\). Find \\(\\angle BDC\\) in degrees."
        
        problem(
            question=question_text,
            answer=answer_angle,
            difficulty=(2500, 2900),
            solution=steps(
                "Since \\(\\angle ACB = 90°\\) and \\(\\angle CAB = $(angle_A)°\\), we have \\(\\angle ABC = $(90 - angle_A)°\\)",
                "In triangle \\(ACD\\), \\(\\angle DCA = 90°\\) (given \\(CD \\perp AC\\))",
                "Therefore \\(\\angle ADC = 90° - $(angle_A)° = $(90 - angle_A)°\\)",
                "Since \\(D\\) lies on \\(AB\\), angles \\(\\angle ADB\\) and \\(\\angle BDC\\) are supplementary to \\(\\angle ADC\\) around line \\(AB\\)",
                "In triangle \\(BCD\\), \\(\\angle BCD = 90° - 90° = 0°\\) or by angle sum: \\(\\angle BDC = 180° - 90° - $(90-angle_A)° = $(answer_angle)°\\)",
                sol("Answer", answer_angle)
            ),
            time=240,
            image=render(d)
        )
        
    elseif prob_type == 2
        # Challenging problem involving altitude and angle bisector
        # Right triangle with altitude from right angle to hypotenuse
        
        # Choose dimensions for exact ratios
        base_leg = randint(12, 24)
        height_leg = randint(9, 18)
        
        d = DiagramObj(width=400, height=380)
        
        # Right triangle with right angle at C
        A = (50, 300)
        B = (350, 300)
        C = (50 + base_leg * 8, 100)
        
        # Altitude from C to AB meets at H
        H = (C[1], A[2])
        
        # Draw triangle and altitude
        polygon!(d, [A, B, C], stroke="black", fill="none", width=2)
        line!(d, C, H, stroke="red", width=2, dash="3,3")
        
        # Mark right angles
        right_angle!(d, A, C, B, size=15)
        right_angle!(d, C, H, A, size=12)
        
        # Label points
        text!(d, A[1]-15, A[2]+15, "A", fontsize=16)
        text!(d, B[1]+15, B[2]+15, "B", fontsize=16)
        text!(d, C[1]-15, C[2]-15, "C", fontsize=16)
        text!(d, H[1], H[2]+20, "H", fontsize=16)
        
        # Label sides
        segment_label!(d, A, C, "$(base_leg)", position=:left, offset=10)
        segment_label!(d, C, B, "$(height_leg)", position=:right, offset=10)
        
        # Calculate CH (altitude to hypotenuse)
        hyp_sq = base_leg^2 + height_leg^2
        hyp = sqrt(hyp_sq)
        altitude = (base_leg * height_leg) / hyp
        
        # Round to reasonable precision
        answer = round(altitude, digits=2)
        
        question_text = "In right triangle \\(ABC\\) with \\(\\angle ACB = 90°\\), \\(AC = $(base_leg)\\) and \\(BC = $(height_leg)\\). The altitude from \\(C\\) to hypotenuse \\(AB\\) meets \\(AB\\) at \\(H\\). Find the length of \\(CH\\). Round to two decimal places."
        
        problem(
            question=question_text,
            answer=answer,
            difficulty=(2600, 3000),
            solution=steps(
                sol("Given", "AC = $(base_leg), BC = $(height_leg)"),
                "Find hypotenuse: \\(AB = \\sqrt{$(base_leg)^2 + $(height_leg)^2} = \\sqrt{$(hyp_sq)}\\)",
                "Area of triangle \\(ABC\\): \\(\\frac{1}{2} \\cdot $(base_leg) \\cdot $(height_leg) = $(base_leg * height_leg / 2)\\)",
                "Using \\(\\text{Area} = \\frac{1}{2} \\cdot AB \\cdot CH\\): \\(CH = \\frac{2 \\cdot $(base_leg * height_leg / 2)}{\\sqrt{$(hyp_sq)}} = \\frac{$(base_leg * height_leg)}{\\sqrt{$(hyp_sq)}}\\)",
                sol("Answer", answer)
            ),
            time=180,
            calculator="scientific",
            image=render(d)
        )
        
    else
        # Olympiad-level: Circle inscribed in right triangle
        a = randint(15, 30)
        b = randint(20, 36)
        
        d = DiagramObj(width=420, height=400)
        
        # Right triangle with right angle at C
        A = (60, 320)
        C = (60, 100)
        B = (340, 320)
        
        # Draw triangle
        polygon!(d, [A, C, B], stroke="black", fill="none", width=2.5)
        
        # Mark right angle
        right_angle!(d, A, C, B, size=18)
        
        # Incircle radius formula: r = (a + b - c) / 2
        c_sq = a^2 + b^2
        c = sqrt(c_sq)
        r = (a + b - c) / 2
        
        # Calculate incircle center (at distance r from each side)
        I = (C[1] + r * 3, C[2] + r * 3)
        
        # Draw incircle
        circle!(d, I[1], I[2], r * 3, stroke="blue", fill="lightblue", opacity=0.2, width=2)
        
        # Mark center
        point!(d, I[1], I[2], radius=3, fill="blue")
        
        # Label points
        text!(d, A[1]-20, A[2]+10, "A", fontsize=18)
        text!(d, C[1]-20, C[2], "C", fontsize=18)
        text!(d, B[1]+15, B[2]+10, "B", fontsize=18)
        text!(d, I[1]+10, I[2]-10, "I", fontsize=16)
        
        # Label legs
        segment_label!(d, C, A, "$(a)", position=:left, offset=12)
        segment_label!(d, C, B, "$(b)", position=:below, offset=12)
        
        answer = round(r, digits=3)
        
        question_text = "A circle is inscribed in right triangle \\(ABC\\) with \\(\\angle ACB = 90°\\), \\(AC = $(a)\\), and \\(BC = $(b)\\). Find the radius of the inscribed circle. Round to three decimal places."
        
        problem(
            question=question_text,
            answer=answer,
            difficulty=(2700, 3200),
            solution=steps(
                sol("Given", "Legs a = $(a), b = $(b)"),
                "Calculate hypotenuse: \\(c = \\sqrt{$(a)^2 + $(b)^2} = \\sqrt{$(c_sq)}\\)",
                "For a right triangle, the inradius formula is: \\(r = \\frac{a + b - c}{2}\\)",
                "Substitute: \\(r = \\frac{$(a) + $(b) - \\sqrt{$(c_sq)}}{2}\\)",
                sol("Answer", answer)
            ),
            time=200,
            calculator="scientific",
            image=render(d)
        )
    end
end