# geometry - circle_theorems (medium)
# Generated: 2026-03-08T20:06:04.682464

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/circle_theorems")
    
    problem_type = choice([
        :inscribed_angle,
        :central_angle,
        :tangent_chord,
        :cyclic_quadrilateral,
        :chord_distance,
        :intersecting_chords
    ])
    
    if problem_type == :inscribed_angle
        # Inscribed angle is half the central angle
        central = 2 * randint(20, 80)
        inscribed = central ÷ 2
        arc_label = choice(["AB", "CD", "EF", "PQ"])
        
        d = DiagramObj(width=300, height=300)
        circle!(d, 150, 150, 100)
        
        # Draw central angle
        angle1 = randint(10, 80)
        angle2 = angle1 + central
        x1 = 150 + 100 * cosd(angle1)
        y1 = 150 - 100 * sind(angle1)
        x2 = 150 + 100 * cosd(angle2)
        y2 = 150 - 100 * sind(angle2)
        
        line!(d, 150, 150, x1, y1)
        line!(d, 150, 150, x2, y2)
        arc!(d, 150, 150, 100, angle1, angle2)
        
        # Draw inscribed angle
        inscribed_base_angle = angle1 + central/2 + randint(120, 150)
        x3 = 150 + 100 * cosd(inscribed_base_angle)
        y3 = 150 - 100 * sind(inscribed_base_angle)
        line!(d, x3, y3, x1, y1, stroke="blue")
        line!(d, x3, y3, x2, y2, stroke="blue")
        
        point!(d, 150, 150, label="O")
        point!(d, x1, y1, label="A")
        point!(d, x2, y2, label="B")
        point!(d, x3, y3, label="P")
        text!(d, 150, 130, "$(central)°", font_size=14)
        text!(d, x3-10, y3+20, "?", font_size=16, fill="blue")
        
        problem(
            question="In the diagram, O is the center of the circle. The central angle ∠AOB = $(central)°. Point P lies on the circle. Find the measure of the inscribed angle ∠APB.",
            answer=inscribed,
            difficulty=(1200, 1400),
            solution=steps(
                "The inscribed angle theorem states that an inscribed angle is half the measure of the central angle that subtends the same arc.",
                sol("Central angle ∠AOB", central),
                sol("Inscribed angle ∠APB = $(central)° ÷ 2", inscribed)
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == :central_angle
        # Given inscribed angle, find arc or central angle
        inscribed = randint(25, 70)
        arc_measure = 2 * inscribed
        
        d = DiagramObj(width=300, height=300)
        circle!(d, 150, 150, 100)
        
        angle1 = randint(10, 80)
        angle2 = angle1 + arc_measure
        x1 = 150 + 100 * cosd(angle1)
        y1 = 150 - 100 * sind(angle1)
        x2 = 150 + 100 * cosd(angle2)
        y2 = 150 - 100 * sind(angle2)
        
        inscribed_vertex_angle = angle1 + arc_measure/2 + randint(130, 160)
        x3 = 150 + 100 * cosd(inscribed_vertex_angle)
        y3 = 150 - 100 * sind(inscribed_vertex_angle)
        
        line!(d, x3, y3, x1, y1, stroke="blue")
        line!(d, x3, y3, x2, y2, stroke="blue")
        
        point!(d, x1, y1, label="A")
        point!(d, x2, y2, label="B")
        point!(d, x3, y3, label="C")
        point!(d, 150, 150, label="O")
        
        text!(d, x3-10, y3+20, "$(inscribed)°", font_size=14, fill="blue")
        
        problem(
            question="In the circle with center O, the inscribed angle ∠ACB = $(inscribed)°. Find the measure of arc AB (minor arc).",
            answer=arc_measure,
            difficulty=(1200, 1400),
            solution=steps(
                "The measure of an arc is equal to the measure of its central angle.",
                "By the inscribed angle theorem, the central angle is twice the inscribed angle.",
                sol("Arc AB = 2 × $(inscribed)°", arc_measure)
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == :tangent_chord
        # Angle between tangent and chord
        arc = randint(80, 160)
        angle = arc ÷ 2
        
        d = DiagramObj(width=320, height=300)
        circle!(d, 150, 150, 90)
        
        # Point of tangency at right
        x_tangent = 240
        y_tangent = 150
        
        # Tangent line (vertical)
        line!(d, x_tangent, 50, x_tangent, 250, stroke="green", stroke_width=2)
        
        # Chord from tangent point
        chord_angle = 180 - arc
        x_chord = 150 + 90 * cosd(chord_angle)
        y_chord = 150 - 90 * sind(chord_angle)
        line!(d, x_tangent, y_tangent, x_chord, y_chord, stroke="blue", stroke_width=2)
        
        point!(d, x_tangent, y_tangent, label="T")
        point!(d, x_chord, y_chord, label="A")
        point!(d, 150, 150, label="O")
        
        text!(d, x_tangent + 15, y_tangent - 30, "?", font_size=16, fill="blue")
        text!(d, 180, 120, "$(arc)°", font_size=12)
        
        problem(
            question="In the diagram, line l is tangent to the circle at point T. The arc TA (going counterclockwise from T to A) measures $(arc)°. Find the measure of the angle between the tangent and chord TA.",
            answer=angle,
            difficulty=(1300, 1500),
            solution=steps(
                "The angle formed by a tangent and a chord is equal to half the measure of the intercepted arc.",
                sol("Arc TA", arc),
                sol("Angle = $(arc)° ÷ 2", angle)
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == :cyclic_quadrilateral
        # Opposite angles in cyclic quadrilateral sum to 180
        angle_A = randint(70, 120)
        angle_C = 180 - angle_A
        
        d = DiagramObj(width=300, height=300)
        circle!(d, 150, 150, 90)
        
        # Four points on circle
        a1 = 30
        a2 = 100
        a3 = 200
        a4 = 280
        
        x1 = 150 + 90 * cosd(a1)
        y1 = 150 - 90 * sind(a1)
        x2 = 150 + 90 * cosd(a2)
        y2 = 150 - 90 * sind(a2)
        x3 = 150 + 90 * cosd(a3)
        y3 = 150 - 90 * sind(a3)
        x4 = 150 + 90 * cosd(a4)
        y4 = 150 - 90 * sind(a4)
        
        polygon!(d, [x1, x2, x3, x4], [y1, y2, y3, y4], fill="none", stroke="blue", stroke_width=2)
        
        point!(d, x1, y1, label="A")
        point!(d, x2, y2, label="B")
        point!(d, x3, y3, label="C")
        point!(d, x4, y4, label="D")
        
        text!(d, x1+15, y1-10, "$(angle_A)°", font_size=14)
        text!(d, x3-25, y3+15, "?", font_size=16, fill="red")
        
        problem(
            question="Quadrilateral ABCD is inscribed in a circle (cyclic quadrilateral). If ∠A = $(angle_A)°, find the measure of ∠C.",
            answer=angle_C,
            difficulty=(1300, 1500),
            solution=steps(
                "In a cyclic quadrilateral, opposite angles are supplementary (sum to 180°).",
                sol("∠A + ∠C = 180°"),
                sol("∠C = 180° - $(angle_A)°", angle_C)
            ),
            image=render(d),
            time=100
        )
        
    elseif problem_type == :chord_distance
        # Relationship between chord length and distance from center
        radius = randint(8, 15)
        dist = randint(3, radius - 2)
        chord_half = isqrt(radius^2 - dist^2)
        chord_length = 2 * chord_half
        
        d = DiagramObj(width=300, height=300)
        circle!(d, 150, 150, 60)
        
        # Horizontal chord
        chord_y = 150 - dist * 60 ÷ radius
        x_left = 150 - chord_half * 60 ÷ radius
        x_right = 150 + chord_half * 60 ÷ radius
        
        line!(d, x_left, chord_y, x_right, chord_y, stroke="blue", stroke_width=2)
        line!(d, 150, 150, 150, chord_y, stroke="red", stroke_width=1, stroke_dasharray="3,3")
        
        point!(d, 150, 150, label="O")
        point!(d, x_left, chord_y, label="A")
        point!(d, x_right, chord_y, label="B")
        point!(d, 150, chord_y, label="M")
        
        text!(d, 155, (150 + chord_y)/2, "$(dist)", font_size=12)
        text!(d, 150, 135, "r=$(radius)", font_size=12)
        
        problem(
            question="In a circle with radius $(radius) units, a chord is at a distance of $(dist) units from the center. Find the length of the chord.",
            answer=chord_length,
            difficulty=(1400, 1600),
            solution=steps(
                "The perpendicular from the center to a chord bisects the chord.",
                "Using the Pythagorean theorem: (chord/2)² + d² = r²",
                sol("(chord/2)² = $(radius)² - $(dist)² = $(radius^2 - dist^2)"),
                sol("chord/2 = $(chord_half)"),
                sol("Chord length", chord_length)
            ),
            image=render(d),
            time=150
        )
        
    else  # :intersecting_chords
        # Power of a point (intersecting chords)
        a = randint(3, 8)
        b = randint(4, 10)
        c = randint(3, 8)
        d = (a * b) ÷ c
        if d < 1 || a * b != c * d
            d = randint(4, 10)
        end
        
        d_obj = DiagramObj(width=300, height=300)
        circle!(d_obj, 150, 150, 90)
        
        # Two chords intersecting
        angle1 = 30
        angle2 = 150
        angle3 = 200
        angle4 = 330
        
        x1 = 150 + 90 * cosd(angle1)
        y1 = 150 - 90 * sind(angle1)
        x2 = 150 + 90 * cosd(angle2)
        y2 = 150 - 90 * sind(angle2)
        x3 = 150 + 90 * cosd(angle3)
        y3 = 150 - 90 * sind(angle3)
        x4 = 150 + 90 * cosd(angle4)
        y4 = 150 - 90 * sind(angle4)
        
        line!(d_obj, x1, y1, x2, y2, stroke="blue", stroke_width=2)
        line!(d_obj, x3, y3, x4, y4, stroke="green", stroke_width=2)
        
        # Intersection point
        x_int = 170
        y_int = 140
        
        point!(d_obj, x1, y1, label="A")
        point!(d_obj, x2, y2, label="B")
        point!(d_obj, x3, y3, label="C")
        point!(d_obj, x4, y4, label="D")
        point!(d_obj, x_int, y_int, label="P")
        
        text!(d_obj, x_int-20, y_int-15, "$(a)", font_size=11)
        text!(d_obj, x_int+10, y_int-15, "$(b)", font_size=11)
        text!(d_obj, x_int-20, y_int+10, "$(c)", font_size=11)
        text!(d_obj, x_int+10, y_int+10, "?", font_size=12, fill="red")
        
        problem(
            question="Two chords AB and CD intersect at point P inside a circle. If AP = $(a), PB = $(b), and CP = $(c), find PD.",
            answer=d,
            difficulty=(1500, 1700),
            solution=steps(
                "When two chords intersect inside a circle, the products of their segments are equal.",
                sol("AP × PB = CP × PD"),
                sol("$(a) × $(b) = $(c) × PD"),
                sol("PD = $(a * b) ÷ $(c)", d)
            ),
            image=render(d_obj),
            time=140
        )
    end
end