# geometry - arc_length_sectors (very_hard)
# Generated: 2026-03-08T20:07:19.976056

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/arc_length_sectors")
    
    # Choose problem type
    problem_type = choice([:arc_with_chord, :inscribed_sectors, :nested_circles])
    
    if problem_type == :arc_with_chord
        # Competition-level: Find arc length given chord and radius with constraints
        R = randint(8, 20)
        # Chord length as a specific fraction of diameter for clean angles
        chord_ratio = choice([1//2, sqrt(2)/2, sqrt(3)/2])
        chord = rationalize(2 * R * chord_ratio, tol=0.01)
        
        # Calculate central angle from chord
        # chord = 2R sin(θ/2), so sin(θ/2) = chord/(2R)
        sin_half = float(chord) / (2 * R)
        half_angle = asin(sin_half)
        theta_rad = 2 * half_angle
        theta_deg = theta_rad * 180 / π
        
        # Arc length
        arc_len = R * theta_rad
        
        # Create diagram
        d = DiagramObj(600, 500)
        center_x, center_y = 300, 250
        
        # Draw circle
        circle!(d, center_x, center_y, R * 15, stroke="black", fill="none", stroke_width=2)
        
        # Draw radius and chord
        angle1 = 90 + theta_deg/2
        angle2 = 90 - theta_deg/2
        x1 = center_x + R * 15 * cosd(angle1)
        y1 = center_y - R * 15 * sind(angle1)
        x2 = center_x + R * 15 * cosd(angle2)
        y2 = center_y - R * 15 * sind(angle2)
        
        # Radii
        line!(d, center_x, center_y, x1, y1, stroke="blue", stroke_width=2)
        line!(d, center_x, center_y, x2, y2, stroke="blue", stroke_width=2)
        
        # Chord
        line!(d, x1, y1, x2, y2, stroke="red", stroke_width=2.5)
        
        # Arc
        arc!(d, center_x, center_y, R * 15, angle2, angle1, stroke="green", stroke_width=3, fill="none")
        
        # Points
        point!(d, center_x, center_y, label="O", label_pos="bottom")
        point!(d, x1, y1, label="A", label_pos="left")
        point!(d, x2, y2, label="B", label_pos="right")
        
        # Labels
        text!(d, (center_x + x1)/2 - 20, (center_y + y1)/2, "R = $R", font_size=14, fill="blue")
        text!(d, (x1 + x2)/2, (y1 + y2)/2 + 25, "chord = $chord", font_size=14, fill="red")
        
        ans = round(arc_len, digits=3)
        
        problem(
            question="A circle has radius R = $R. A chord of length $chord is drawn. Find the length of the minor arc subtended by this chord. Express your answer as a decimal rounded to 3 decimal places.",
            answer=ans,
            difficulty=(2600, 2900),
            solution=steps(
                "Let the chord AB have length $chord and the radius R = $R",
                sol("Using the relation", "\\text{chord} = 2R\\sin(\\theta/2)"),
                "We get \\sin(\\theta/2) = $(round(sin_half, digits=4))",
                "Therefore \\theta/2 = $(round(half_angle, digits=4)) radians",
                "Central angle \\theta = $(round(theta_rad, digits=4)) radians",
                sol("Arc length", "s = R\\theta = $R \\times $(round(theta_rad, digits=4)) = $(round(ans, digits=3))")
            ),
            image=render(d),
            time=240,
            calculator="scientific"
        )
        
    elseif problem_type == :inscribed_sectors
        # Olympiad-level: Two circles, find ratio of sectors with angle constraint
        r1 = randint(5, 12)
        r2 = randint(13, 25)
        
        # Create special angle relationship
        theta1_deg = choice([60, 72, 90, 120])
        theta1 = theta1_deg * π / 180
        
        # The constraint: arc lengths are equal
        # r1 * theta1 = r2 * theta2
        theta2 = r1 * theta1 / r2
        theta2_deg = theta2 * 180 / π
        
        # Sector areas
        area1 = (1//2) * r1^2 * theta1
        area2 = (1//2) * r2^2 * theta2
        
        ratio = simplify(area1 / area2)
        
        # Create diagram
        d = DiagramObj(700, 400)
        
        # First circle and sector
        cx1, cy1 = 180, 200
        circle!(d, cx1, cy1, r1 * 10, stroke="black", fill="none", stroke_width=2)
        
        angle_start1 = 0
        angle_end1 = theta1_deg
        x1a = cx1 + r1 * 10 * cosd(angle_start1)
        y1a = cy1 - r1 * 10 * sind(angle_start1)
        x1b = cx1 + r1 * 10 * cosd(angle_end1)
        y1b = cy1 - r1 * 10 * sind(angle_end1)
        
        line!(d, cx1, cy1, x1a, y1a, stroke="blue", stroke_width=2)
        line!(d, cx1, cy1, x1b, y1b, stroke="blue", stroke_width=2)
        arc!(d, cx1, cy1, r1 * 10, angle_start1, angle_end1, stroke="blue", stroke_width=2.5, fill="none")
        
        # Second circle and sector
        cx2, cy2 = 520, 200
        circle!(d, cx2, cy2, r2 * 8, stroke="black", fill="none", stroke_width=2)
        
        angle_start2 = 0
        angle_end2 = theta2_deg
        x2a = cx2 + r2 * 8 * cosd(angle_start2)
        y2a = cy2 - r2 * 8 * sind(angle_start2)
        x2b = cx2 + r2 * 8 * cosd(angle_end2)
        y2b = cy2 - r2 * 8 * sind(angle_end2)
        
        line!(d, cx2, cy2, x2a, y2a, stroke="red", stroke_width=2)
        line!(d, cx2, cy2, x2b, y2b, stroke="red", stroke_width=2)
        arc!(d, cx2, cy2, r2 * 8, angle_start2, angle_end2, stroke="red", stroke_width=2.5, fill="none")
        
        # Labels
        text!(d, cx1, cy1 - r1 * 10 - 20, "r = $r1", font_size=14)
        text!(d, cx1 + 30, cy1 - 30, "$(theta1_deg)°", font_size=13)
        text!(d, cx2, cy2 - r2 * 8 - 20, "r = $r2", font_size=14)
        text!(d, cx2 + 30, cy2 - 30, "θ", font_size=13)
        
        ans_num = float(numerator(ratio))
        ans_den = float(denominator(ratio))
        
        problem(
            question="Two circular sectors are shown. The first sector has radius $r1 and central angle $(theta1_deg)°. The second sector has radius $r2 and central angle θ. If the two sectors have equal arc lengths, find the ratio of the area of the first sector to the area of the second sector. Express your answer as a simplified fraction a/b, then enter the value a/b as a decimal rounded to 4 decimal places.",
            answer=round(ans_num/ans_den, digits=4),
            difficulty=(2700, 3200),
            solution=steps(
                "Arc length of first sector: \\(s_1 = r_1\\theta_1 = $r1 \\cdot $(round(theta1, digits=4)) = $(round(r1*theta1, digits=3))\\)",
                "Arc length of second sector: \\(s_2 = r_2\\theta_2 = $r2 \\cdot \\theta_2\\)",
                "Setting equal: \\($r2 \\theta_2 = $(round(r1*theta1, digits=3))\\), so \\(\\theta_2 = $(round(theta2, digits=4))\\)",
                "Area of first sector: \\(A_1 = \\frac{1}{2}r_1^2\\theta_1 = \\frac{1}{2} \\cdot $r1^2 \\cdot $(round(theta1, digits=4))\\)",
                "Area of second sector: \\(A_2 = \\frac{1}{2}r_2^2\\theta_2 = \\frac{1}{2} \\cdot $r2^2 \\cdot $(round(theta2, digits=4))\\)",
                sol("Ratio", "\\frac{A_1}{A_2} = \\frac{r_1^2\\theta_1}{r_2^2\\theta_2} = \\frac{$r1^2}{$r2^2} = $(round(ans_num/ans_den, digits=4))")
            ),
            image=render(d),
            time=300,
            calculator="scientific"
        )
        
    else  # nested_circles
        # Olympiad: Three concentric circles, find area between specific arcs
        r1 = randint(6, 10)
        r2 = r1 + randint(4, 8)
        r3 = r2 + randint(4, 8)
        
        # Create angle where arc on outer circle equals chord on middle circle
        theta_deg = choice([45, 60, 90, 120])
        theta = theta_deg * π / 180
        
        # Calculate areas
        sector_outer = (1//2) * r3^2 * theta
        sector_middle = (1//2) * r2^2 * theta
        sector_inner = (1//2) * r1^2 * theta
        
        # Area of annular sector between r2 and r3
        area_between = sector_outer - sector_middle
        
        # Create diagram
        d = DiagramObj(600, 600)
        cx, cy = 300, 300
        
        # Three concentric circles
        circle!(d, cx, cy, r3 * 12, stroke="black", fill="none", stroke_width=2)
        circle!(d, cx, cy, r2 * 12, stroke="black", fill="none", stroke_width=2)
        circle!(d, cx, cy, r1 * 12, stroke="black", fill="none", stroke_width=2)
        
        # Radii for the sector
        angle_start = 20
        angle_end = angle_start + theta_deg
        
        x1 = cx + r3 * 12 * cosd(angle_start)
        y1 = cy - r3 * 12 * sind(angle_start)
        x2 = cx + r3 * 12 * cosd(angle_end)
        y2 = cy - r3 * 12 * sind(angle_end)
        
        line!(d, cx, cy, x1, y1, stroke="blue", stroke_width=2)
        line!(d, cx, cy, x2, y2, stroke="blue", stroke_width=2)
        
        # Arcs for all three circles in the sector
        arc!(d, cx, cy, r3 * 12, angle_start, angle_end, stroke="green", stroke_width=3, fill="none")
        arc!(d, cx, cy, r2 * 12, angle_start, angle_end, stroke="orange", stroke_width=2.5, fill="none")
        arc!(d, cx, cy, r1 * 12, angle_start, angle_end, stroke="purple", stroke_width=2, fill="none")
        
        # Labels
        text!(d, cx + r1 * 6, cy + 15, "$r1", font_size=13)
        text!(d, cx + r2 * 6, cy + 15, "$r2", font_size=13)
        text!(d, cx + r3 * 6, cy + 15, "$r3", font_size=13)
        text!(d, cx + 50, cy - 50, "$(theta_deg)°", font_size=14, fill="blue")
        
        ans = float(area_between)
        
        problem(
            question="Three concentric circles have radii $r1, $r2, and $r3. A sector with central angle $(theta_deg)° is drawn from the center, intersecting all three circles. Find the area of the region between the middle circle (radius $r2) and the outer circle (radius $r3) within this sector. Round your answer to 2 decimal places.",
            answer=round(ans, digits=2),
            difficulty=(2500, 2800),
            solution=steps(
                "Convert angle to radians: \\(\\theta = $(theta_deg)° = $(round(theta, digits=4))\\) radians",
                "Area of sector in outer circle: \\(A_3 = \\frac{1}{2}r_3^2\\theta = \\frac{1}{2} \\cdot $r3^2 \\cdot $(round(theta, digits=4)) = $(round(sector_outer, digits=3))\\)",
                "Area of sector in middle circle: \\(A_2 = \\frac{1}{2}r_2^2\\theta = \\frac{1}{2} \\cdot $r2^2 \\cdot $(round(theta, digits=4)) = $(round(sector_middle, digits=3))\\)",
                sol("Area between circles", "A_3 - A_2 = $(round(sector_outer, digits=3)) - $(round(sector_middle, digits=3)) = $(round(ans, digits=2))")
            ),
            image=render(d),
            time=270,
            calculator="scientific"
        )
    end
end