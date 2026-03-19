# geometry - similar_triangles (very_hard)
# Generated: 2026-03-08T20:05:22.128130

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("geometry/similar_triangles")
    
    # Competition/Olympiad level similar triangles problem (2500-3500 ELO)
    # Create a complex configuration with multiple similar triangles
    
    problem_type = choice(1:3)
    
    if problem_type == 1
        # Type 1: Nested similar triangles with ratio chain
        # Triangle ABC with point D on AB, E on AC such that DE || BC
        # Point F on DE, G on AC such that FG || BC
        
        AB = randint(20, 40)
        ratio1 = randint(2, 5) // randint(6, 9)  # AD/AB
        ratio2 = randint(3, 7) // randint(8, 12)  # DF/DE (relative to smaller triangle)
        
        AD = AB * ratio1
        DB = AB - AD
        
        # Since DE || BC, triangle ADE ~ triangle ABC
        DE_over_BC = ratio1
        AE_over_AC = ratio1
        
        # We need to find a specific length
        # Let's say BC = some value, find a compound ratio
        BC = randint(25, 50)
        DE = BC * DE_over_BC
        AC = randint(30, 60)
        AE = AC * AE_over_AC
        EC = AC - AE
        
        # Now FG || BC where F is on DE
        # AF/AD determines the similarity ratio for triangle AFG ~ triangle ADC
        AF_over_AD = ratio2
        FG_over_DE = AF_over_AD
        FG = DE * FG_over_DE
        
        answer = rationalize(FG, tol=1e-10)
        
        d = DiagramObj(600, 500)
        
        # Draw main triangle ABC
        Ax, Ay = 50, 400
        Bx, By = 500, 400
        Cx, Cy = 200, 50
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], :none, "black", 2)
        
        # Point D on AB
        t1 = Float64(ratio1)
        Dx = Ax + t1 * (Bx - Ax)
        Dy = Ay + t1 * (By - Ay)
        
        # Point E on AC
        Ex = Ax + t1 * (Cx - Ax)
        Ey = Ay + t1 * (Cy - Ay)
        
        # Draw DE
        line!(d, Dx, Dy, Ex, Ey, "blue", 2)
        
        # Point F on DE (using ratio2 from D)
        t2 = Float64(ratio2)
        Fx = Dx + t2 * (Ex - Dx)
        Fy = Dy + t2 * (Ey - Dy)
        
        # Point G on AC such that FG || BC
        # We need AG/AC = AF/AB (by similar triangles)
        # AF/AB = (AD + DF)/AB = (AD + ratio2*DE)/AB
        combined_ratio = Float64(ratio1 + ratio2 * (1 - ratio1))
        Gx = Ax + combined_ratio * (Cx - Ax)
        Gy = Ay + combined_ratio * (Cy - Ay)
        
        line!(d, Fx, Fy, Gx, Gy, "red", 2)
        
        # Label points
        point!(d, Ax, Ay, "A", :below)
        point!(d, Bx, By, "B", :below)
        point!(d, Cx, Cy, "C", :above)
        point!(d, Dx, Dy, "D", :below)
        point!(d, Ex, Ey, "E", :left)
        point!(d, Fx, Fy, "F", :below)
        point!(d, Gx, Gy, "G", :right)
        
        # Add some lengths
        segment_label!(d, Ax, Ay, Dx, Dy, "$(Int(numerator(AD)))", :above)
        segment_label!(d, Dx, Dy, Bx, By, "$(Int(numerator(DB)))", :above)
        segment_label!(d, Bx, By, Cx, Cy, "$(Int(BC))", :right)
        
        question = "In triangle ABC, point D lies on AB with AD = $(Int(numerator(AD))) and DB = $(Int(numerator(DB))). Point E lies on AC such that DE ∥ BC. Point F lies on segment DE such that DF:FE = $(Int(numerator(ratio2))):$(Int(denominator(ratio2) - numerator(ratio2))). Point G lies on AC such that FG ∥ BC. If BC = $(Int(BC)), find the length FG."
        
        solution = steps(
            "Since DE ∥ BC, triangles ADE and ABC are similar with ratio AD:AB = $(tex(ratio1))",
            sol("Therefore", "DE/BC = $(tex(ratio1)), so DE = $(tex(DE))"),
            "Point F divides DE such that DF/DE = $(tex(ratio2))",
            "Since FG ∥ BC and F is on DE, by similar triangles AFG ~ ADE",
            sol("The ratio is", "FG/DE = AF/AD"),
            "We have AF/AD = (AD + DF)/AD = 1 + (DF/AD) = 1 + (DF/DE)·(DE/AD) = 1 + $(tex(ratio2))·$(tex(1/ratio1))",
            "Wait, we use DF:FE = $(Int(numerator(ratio2))):$(Int(denominator(ratio2) - numerator(ratio2))), so DF/DE = $(tex(ratio2))",
            sol("Thus", "FG = DE · $(tex(ratio2)) = $(tex(DE)) · $(tex(ratio2)) = $(tex(answer))"),
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2600, 3200),
            solution=solution,
            image=render(d),
            time=420
        )
        
    elseif problem_type == 2
        # Type 2: Cevian configuration with similar triangles
        # Triangle with cevians creating multiple similar triangles
        
        # Setup: Triangle ABC with cevian AD to BC
        # Point E on AB, F on AC such that EF || BC
        # Find ratio involving similar triangles
        
        a = randint(15, 30)  # BC
        b = randint(18, 35)  # AC
        c = randint(20, 38)  # AB
        
        # Point D divides BC in ratio m:n
        m = randint(2, 7)
        n = randint(3, 8)
        BD = a * m // (m + n)
        DC = a * n // (m + n)
        
        # E on AB such that AE/AB = k
        k = randint(3, 7) // randint(8, 15)
        AE = c * k
        EB = c - AE
        
        # Since we want a specific answer, let's find where EF intersects AD
        # EF || BC means triangle AEF ~ triangle ABC
        EF_over_BC = k
        AF_over_AC = k
        
        EF = a * k
        AF = b * k
        
        answer = rationalize(EF, tol=1e-10)
        
        d = DiagramObj(600, 500)
        
        # Draw triangle ABC
        Ax, Ay = 100, 50
        Bx, By = 50, 400
        Cx, Cy = 500, 400
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], :none, "black", 2)
        
        # Point D on BC
        t_d = Float64(m / (m + n))
        Dx = Bx + t_d * (Cx - Bx)
        Dy = By + t_d * (Cy - By)
        
        # Cevian AD
        line!(d, Ax, Ay, Dx, Dy, "purple", 2)
        
        # Point E on AB
        t_e = Float64(k)
        Ex = Ax + t_e * (Bx - Ax)
        Ey = Ay + t_e * (By - Ay)
        
        # Point F on AC
        Fx = Ax + t_e * (Cx - Ax)
        Fy = Ay + t_e * (Cy - Ay)
        
        # Line EF
        line!(d, Ex, Ey, Fx, Fy, "blue", 2)
        
        # Label points
        point!(d, Ax, Ay, "A", :above)
        point!(d, Bx, By, "B", :below)
        point!(d, Cx, Cy, "C", :below)
        point!(d, Dx, Dy, "D", :below)
        point!(d, Ex, Ey, "E", :left)
        point!(d, Fx, Fy, "F", :right)
        
        # Labels
        segment_label!(d, Bx, By, Dx, Dy, "$(Int(numerator(BD)))", :below)
        segment_label!(d, Dx, Dy, Cx, Cy, "$(Int(numerator(DC)))", :below)
        segment_label!(d, Ax, Ay, Ex, Ey, "$(Int(numerator(AE)))", :left)
        segment_label!(d, Cx, Cy, Ax, Ay, "$(Int(b))", :right)
        
        question = "In triangle ABC, cevian AD is drawn to side BC with BD = $(Int(numerator(BD))) and DC = $(Int(numerator(DC))). Point E lies on AB with AE = $(Int(numerator(AE))), and point F lies on AC such that EF ∥ BC. If AC = $(Int(b)), find the length of EF."
        
        solution = steps(
            "Since EF ∥ BC, triangles AEF and ABC are similar",
            sol("The ratio of similarity is", "AE/AB"),
            "We need to find AB. We're given AE = $(Int(numerator(AE)))",
            "From the parallel condition, AE/AB = AF/AC = EF/BC",
            "We have BC = BD + DC = $(Int(numerator(BD))) + $(Int(numerator(DC))) = $(Int(a))",
            "The ratio AE/AB = $(tex(k))",
            sol("Therefore", "EF/BC = $(tex(k))"),
            sol("EF", "= $(Int(a)) · $(tex(k)) = $(tex(answer))"),
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2400, 3000),
            solution=solution,
            image=render(d),
            time=360
        )
        
    else
        # Type 3: Spiral similarity with three triangles
        # Advanced configuration: P inside triangle ABC
        # Lines through P create similar triangles
        
        # Let's use a specific configuration
        AB = randint(24, 48)
        AC = randint(20, 45)
        BC = randint(18, 42)
        
        # Point P divides various segments
        # Line through P parallel to BC intersects AB at D, AC at E
        ratio_P = randint(2, 5) // randint(7, 11)
        
        AD = AB * ratio_P
        AE = AC * ratio_P
        DE = BC * ratio_P
        
        # Now create another parallel line through a different point
        # Point Q on AD such that AQ/AD = another ratio
        ratio_Q = randint(3, 6) // randint(8, 13)
        AQ = AD * ratio_Q
        
        # Line through Q parallel to DE (hence also to BC)
        # Combined ratio: AQ/AB = ratio_P * ratio_Q
        combined = ratio_P * ratio_Q
        
        QR = BC * combined  # where R is on AC
        
        answer = rationalize(QR, tol=1e-10)
        
        d = DiagramObj(600, 500)
        
        # Draw main triangle
        Ax, Ay = 100, 50
        Bx, By = 50, 450
        Cx, Cy = 550, 450
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], :none, "black", 2)
        
        # Points D and E for first parallel
        t1 = Float64(ratio_P)
        Dx = Ax + t1 * (Bx - Ax)
        Dy = Ay + t1 * (By - Ay)
        Ex = Ax + t1 * (Cx - Ax)
        Ey = Ay + t1 * (Cy - Ay)
        
        line!(d, Dx, Dy, Ex, Ey, "blue", 2)
        
        # Point Q on AD
        t2 = Float64(ratio_Q)
        Qx = Ax + t2 * (Dx - Ax)
        Qy = Ay + t2 * (Dy - Ay)
        
        # Point R on AE (since QR || DE || BC)
        Rx = Ax + t2 * (Ex - Ax)
        Ry = Ay + t2 * (Ey - Ay)
        
        line!(d, Qx, Qy, Rx, Ry, "red", 2)
        
        # Labels
        point!(d, Ax, Ay, "A", :above)
        point!(d, Bx, By, "B", :below)
        point!(d, Cx, Cy, "C", :below)
        point!(d, Dx, Dy, "D", :left)
        point!(d, Ex, Ey, "E", :right)
        point!(d, Qx, Qy, "Q", :left)
        point!(d, Rx, Ry, "R", :right)
        
        segment_label!(d, Bx, By, Cx, Cy, "$(Int(BC))", :below)
        
        question = "In triangle ABC with BC = $(Int(BC)), points D and E lie on AB and AC respectively such that DE ∥ BC and AD:AB = $(Int(numerator(ratio_P))):$(Int(denominator(ratio_P))). Point Q lies on segment AD such that AQ:AD = $(Int(numerator(ratio_Q))):$(Int(denominator(ratio_Q))). A line through Q parallel to BC intersects AC at R. Find the length QR."
        
        solution = steps(
            "Since DE ∥ BC, triangles ADE and ABC are similar",
            sol("With ratio", "AD/AB = $(tex(ratio_P))"),
            sol("Therefore", "DE/BC = $(tex(ratio_P)), so DE = $(tex(DE))"),
            "Point Q on AD satisfies AQ/AD = $(tex(ratio_Q))",
            "Since QR ∥ DE ∥ BC, triangles AQR and ADE are similar",
            sol("With ratio", "AQ/AD = $(tex(ratio_Q))"),
            sol("Therefore", "QR/DE = $(tex(ratio_Q))"),
            sol("QR", "= $(tex(DE)) · $(tex(ratio_Q)) = $(tex(answer))"),
            "The answer follows from the ratio of similar triangles",
            sol("Answer", Float64(answer))
        )

        problem(
            question=question,
            answer=Float64(answer),
            difficulty=(3200, 3600),
            solution=solution,
            image=render(d),
            time=300
        )
    end
end
