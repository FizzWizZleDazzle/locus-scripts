# geometry - triangle_properties (very_hard)
# Generated: 2026-03-08T20:03:15.871167

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_properties")
    
    problem_type = choice([:angle_chase, :cevian_length, :triangle_inequality_hard, :incircle_excircle])
    
    if problem_type == :angle_chase
        # Complex angle chasing in triangle with cevians
        angle_A = randint(40, 70)
        angle_B = randint(50, 80)
        angle_C = 180 - angle_A - angle_B
        
        # Construct a cevian from A to BC creating angles
        angle_BAD = randint(15, angle_A - 10)
        angle_CAD = angle_A - angle_BAD
        
        # Point D on BC, now find angle ADB
        angle_ADB = 180 - angle_B - angle_BAD
        angle_ADC = 180 - angle_C - angle_CAD
        
        # Add point E on AB such that DE is parallel to AC
        # Then angle BED = angle_C (corresponding angles)
        angle_BED = angle_C
        angle_BDE = 180 - angle_B - angle_BED
        
        # Find angle ADE
        answer = angle_ADB - angle_BDE
        
        d = DiagramObj(400, 350)
        
        # Draw triangle ABC
        Ax, Ay = 200, 50
        Bx, By = 80, 280
        Cx, Cy = 320, 280
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], fill="none", stroke="black", stroke_width=2)
        
        # Point D on BC
        t_D = 0.4
        Dx = Bx + t_D * (Cx - Bx)
        Dy = By + t_D * (Cy - By)
        
        # Point E on AB
        t_E = 0.35
        Ex = Ax + t_E * (Bx - Ax)
        Ey = Ay + t_E * (By - Ay)
        
        # Draw cevians
        line!(d, Ax, Ay, Dx, Dy, stroke="blue", stroke_width=1.5)
        line!(d, Ex, Ey, Dx, Dy, stroke="green", stroke_width=1.5)
        
        # Mark points
        point!(d, Ax, Ay, label="A", label_pos="above")
        point!(d, Bx, By, label="B", label_pos="below left")
        point!(d, Cx, Cy, label="C", label_pos="below right")
        point!(d, Dx, Dy, label="D", label_pos="below")
        point!(d, Ex, Ey, label="E", label_pos="left")
        
        # Mark some angles
        text!(d, Ax + 15, Ay + 25, "$(angle_A)°", font_size=11)
        text!(d, Bx + 20, By - 15, "$(angle_B)°", font_size=11)
        text!(d, Cx - 20, Cy - 15, "$(angle_C)°", font_size=11)
        text!(d, Ax - 5, Ay + 55, "$(angle_BAD)°", font_size=10, fill="blue")
        
        problem(
            question="In triangle ABC, ∠A = $(angle_A)°, ∠B = $(angle_B)°, and ∠C = $(angle_C)°. Point D lies on BC such that ∠BAD = $(angle_BAD)°. Point E lies on AB such that DE ∥ AC. Find ∠ADE in degrees.",
            answer=answer,
            difficulty=(2600, 3000),
            solution=steps(
                "Given: ∠A = $(angle_A)°, ∠B = $(angle_B)°, ∠C = $(angle_C)°, ∠BAD = $(angle_BAD)°",
                "Since ∠BAD = $(angle_BAD)°, we have ∠CAD = $(angle_A) - $(angle_BAD) = $(angle_CAD)°",
                "In triangle ABD: ∠ADB = 180° - ∠B - ∠BAD = 180° - $(angle_B)° - $(angle_BAD)° = $(angle_ADB)°",
                "Since DE ∥ AC, by corresponding angles: ∠BED = ∠C = $(angle_C)°",
                "In triangle BDE: ∠BDE = 180° - ∠B - ∠BED = 180° - $(angle_B)° - $(angle_C)° = $(angle_BDE)°",
                "Since points A, D are positioned such that ∠ADB is split by DE:",
                sol("∠ADE", "$(angle_ADB)° - $(angle_BDE)° = $(answer)°")
            ),
            image=render(d),
            time=300
        )
        
    elseif problem_type == :cevian_length
        # Stewart's theorem or angle bisector theorem problem
        a = randint(10, 20)  # BC
        b = randint(12, 22)  # AC
        c = randint(14, 24)  # AB
        
        # Check triangle inequality
        if !(a + b > c && b + c > a && c + a > b)
            a, b, c = 13, 14, 15
        end
        
        # Point D on BC such that BD/DC = m/n
        m = randint(2, 5)
        n = randint(2, 5)
        
        BD = (m * a) // (m + n)
        DC = (n * a) // (m + n)
        
        # Stewart's theorem: b²·m + c²·n - AD²·(m+n) = a·m·n
        # AD² = (b²·m + c²·n - a·m·n)/(m+n)
        
        numerator = b^2 * m + c^2 * n - a * m * n
        denominator = m + n
        
        AD_squared = numerator // denominator
        
        d = DiagramObj(400, 300)
        
        Bx, By = 50, 250
        Cx, Cy = 350, 250
        
        # Calculate A using triangle proportions
        Ax = 180
        Ay = 80
        
        Dx = Bx + (m / (m + n)) * (Cx - Bx)
        Dy = By
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], fill="none", stroke="black", stroke_width=2)
        line!(d, Ax, Ay, Dx, Dy, stroke="red", stroke_width=1.5, stroke_dasharray="5,3")
        
        point!(d, Ax, Ay, label="A", label_pos="above")
        point!(d, Bx, By, label="B", label_pos="below left")
        point!(d, Cx, Cy, label="C", label_pos="below right")
        point!(d, Dx, Dy, label="D", label_pos="below")
        
        segment_label!(d, Bx, By, Cx, Cy, "$(a)", offset=-15)
        segment_label!(d, Ax, Ay, Cx, Cy, "$(b)", offset=10)
        segment_label!(d, Ax, Ay, Bx, By, "$(c)", offset=-10)
        
        text!(d, Dx - 10, Dy + 30, "BD:DC = $(m):$(n)", font_size=11, fill="blue")
        
        problem(
            question="In triangle ABC, AB = $(c), AC = $(b), and BC = $(a). Point D lies on BC such that BD:DC = $(m):$(n). Find AD².",
            answer=AD_squared,
            difficulty=(2700, 3200),
            solution=steps(
                "Given: AB = $(c), AC = $(b), BC = $(a), and BD:DC = $(m):$(n)",
                "By the ratio, BD = \\frac{$(m) \\cdot $(a)}{$(m) + $(n)} = $(tex(BD)) and DC = \\frac{$(n) \\cdot $(a)}{$(m) + $(n)} = $(tex(DC))",
                "Apply Stewart's Theorem: AC² · BD + AB² · DC = BC(AD² + BD · DC)",
                "$(b)² · $(tex(BD)) + $(c)² · $(tex(DC)) = $(a)(AD² + $(tex(BD)) · $(tex(DC)))",
                "$(b^2 * m) + $(c^2 * n) = $(a * (m + n)) · AD² + $(a * m * n)",
                "$(numerator) = $(denominator) · AD²",
                sol("AD²", tex(AD_squared))
            ),
            image=render(d),
            time=360
        )
        
    elseif problem_type == :triangle_inequality_hard
        # Advanced triangle inequality with medians and altitudes
        a = randint(15, 25)
        b = randint(18, 28)
        c = randint(20, 30)
        
        if !(a + b > c && b + c > a && c + a > b)
            a, b, c = 15, 20, 24
        end
        
        # Median to side a: m_a = (1/2)√(2b² + 2c² - a²)
        median_a_sq = (2*b^2 + 2*c^2 - a^2) // 4
        
        d = DiagramObj(400, 300)
        
        Bx, By = 50, 240
        Cx, Cy = 350, 240
        Ax = 150
        Ay = 70
        
        Mx = (Bx + Cx) / 2
        My = (By + Cy) / 2
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], fill="none", stroke="black", stroke_width=2)
        line!(d, Ax, Ay, Mx, My, stroke="purple", stroke_width=1.5)
        
        point!(d, Ax, Ay, label="A", label_pos="above")
        point!(d, Bx, By, label="B", label_pos="below left")
        point!(d, Cx, Cy, label="C", label_pos="below right")
        point!(d, Mx, My, label="M", label_pos="below")
        
        segment_label!(d, Bx, By, Cx, Cy, "a = $(a)", offset=-15)
        segment_label!(d, Ax, Ay, Cx, Cy, "b = $(b)", offset=10)
        segment_label!(d, Ax, Ay, Bx, By, "c = $(c)", offset=-10)
        segment_label!(d, Ax, Ay, Mx, My, "m_a", offset=-10, color="purple")
        
        problem(
            question="In triangle ABC with sides a = $(a), b = $(b), and c = $(c), let M be the midpoint of BC. Find the square of the length of median AM (i.e., find m_a²).",
            answer=median_a_sq,
            difficulty=(2500, 2900),
            solution=steps(
                "Given: Triangle ABC with a = BC = $(a), b = AC = $(b), c = AB = $(c)",
                "M is the midpoint of BC, so BM = MC = \\frac{a}{2}",
                "Apply the median length formula: \\(m_a^2 = \\frac{2b^2 + 2c^2 - a^2}{4}\\)",
                "\\(m_a^2 = \\frac{2($(b))^2 + 2($(c))^2 - ($(a))^2}{4}\\)",
                "\\(m_a^2 = \\frac{2 \\cdot $(b^2) + 2 \\cdot $(c^2) - $(a^2)}{4}\\)",
                "\\(m_a^2 = \\frac{$(2*b^2) + $(2*c^2) - $(a^2)}{4}\\)",
                sol("m_a²", tex(median_a_sq))
            ),
            image=render(d),
            time=240
        )
        
    else  # incircle_excircle
        # Problem involving incircle and excircle radii
        a = randint(13, 21)
        b = randint(15, 23)
        c = randint(14, 22)
        
        if !(a + b > c && b + c > a && c + a > b)
            a, b, c = 13, 14, 15
        end
        
        s = (a + b + c) // 2  # semiperimeter
        
        # Area by Heron's formula: A² = s(s-a)(s-b)(s-c)
        area_sq = s * (s - a) * (s - b) * (s - c)
        
        # Inradius: r = A/s, so r² = A²/s²
        inradius_sq = area_sq // (s^2)
        
        # Exradius opposite to side a: r_a = A/(s-a), so r_a² = A²/(s-a)²
        exradius_sq = area_sq // ((s - a)^2)
        
        # Find r² + r_a²
        answer = inradius_sq + exradius_sq
        
        d = DiagramObj(400, 320)
        
        Bx, By = 60, 260
        Cx, Cy = 340, 260
        Ax = 180
        Ay = 80
        
        # Incircle center (approximate)
        Ix = (a*Ax + b*Bx + c*Cx) / (a + b + c)
        Iy = (a*Ay + b*By + c*Cy) / (a + b + c)
        
        polygon!(d, [Ax, Bx, Cx], [Ay, By, Cy], fill="none", stroke="black", stroke_width=2)
        circle!(d, Ix, Iy, 30, fill="lightblue", fill_opacity=0.3, stroke="blue", stroke_width=1.5)
        point!(d, Ix, Iy, color="blue", radius=2)
        
        point!(d, Ax, Ay, label="A", label_pos="above")
        point!(d, Bx, By, label="B", label_pos="below left")
        point!(d, Cx, Cy, label="C", label_pos="below right")
        
        segment_label!(d, Bx, By, Cx, Cy, "a = $(a)", offset=-15)
        segment_label!(d, Ax, Ay, Cx, Cy, "b = $(b)", offset=10)
        segment_label!(d, Ax, Ay, Bx, By, "c = $(c)", offset=-10)
        
        text!(d, Ix + 5, Iy - 5, "I", font_size=12, fill="blue")
        text!(d, 200, 30, "Incircle", font_size=11, fill="blue")
        
        problem(
            question="Triangle ABC has sides a = $(a), b = $(b), and c = $(c). Find the sum of the squares of the inradius and the exradius opposite side a.",
            answer=answer,
            difficulty=(2800, 3200),
            solution=steps(
                "Semi-perimeter s = $(s)",
                "By Heron's formula, compute Area squared",
                "r^2 = Area^2/s^2, r_a^2 = Area^2/(s-a)^2",
                sol("Answer", answer)
            ),
            image=render(d),
            time=300
        )
    end
end
