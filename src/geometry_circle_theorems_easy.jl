# geometry - circle_theorems (easy)
# Generated: 2026-03-08T20:05:36.656150

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/circle_theorems")
    
    problem_type = choice(["inscribed_angle", "central_angle", "chord_theorem", "tangent_chord"])
    
    if problem_type == "inscribed_angle"
        # Inscribed angle theorem: inscribed angle is half the central angle
        arc_measure = randint(40, 160)
        inscribed_angle = arc_measure // 2
        
        d = DiagramObj(300, 300)
        circle!(d, 150, 150, 80)
        
        # Draw inscribed angle
        angle_start = randint(20, 80)
        arc_end = angle_start + arc_measure
        
        # Points on circle for inscribed angle
        x1 = 150 + 80 * cosd(angle_start)
        y1 = 150 - 80 * sind(angle_start)
        x2 = 150 + 80 * cosd(arc_end)
        y2 = 150 - 80 * sind(arc_end)
        
        # Vertex on circle (opposite side)
        vertex_angle = angle_start + arc_measure/2 + 180
        xv = 150 + 80 * cosd(vertex_angle)
        yv = 150 - 80 * sind(vertex_angle)
        
        point!(d, x1, y1, "A")
        point!(d, x2, y2, "B")
        point!(d, xv, yv, "C")
        point!(d, 150, 150, "O")
        
        line!(d, xv, yv, x1, y1)
        line!(d, xv, yv, x2, y2)
        line!(d, 150, 150, x1, y1, :dashed)
        line!(d, 150, 150, x2, y2, :dashed)
        
        arc!(d, 150, 150, 60, angle_start, arc_end)
        text!(d, 150 + 50*cosd(angle_start + arc_measure/2), 
              150 - 50*sind(angle_start + arc_measure/2), "$(arc_measure)°", 12)
        
        problem(
            question="In the circle with center O, arc AB measures $(arc_measure)°. What is the measure of inscribed angle ∠ACB?",
            answer=inscribed_angle,
            difficulty=(700, 900),
            solution=steps(
                "The inscribed angle theorem states that an inscribed angle is half the measure of its intercepted arc",
                sol("Arc AB", arc_measure),
                sol("∠ACB = \\frac{1}{2} \\times $(arc_measure)°", inscribed_angle)
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == "central_angle"
        # Central angle equals arc measure
        central_angle = randint(50, 150)
        
        d = DiagramObj(300, 300)
        circle!(d, 150, 150, 80)
        
        angle_start = randint(20, 80)
        arc_end = angle_start + central_angle
        
        x1 = 150 + 80 * cosd(angle_start)
        y1 = 150 - 80 * sind(angle_start)
        x2 = 150 + 80 * cosd(arc_end)
        y2 = 150 - 80 * sind(arc_end)
        
        point!(d, 150, 150, "O")
        point!(d, x1, y1, "A")
        point!(d, x2, y2, "B")
        
        line!(d, 150, 150, x1, y1)
        line!(d, 150, 150, x2, y2)
        
        angle_arc!(d, 150, 150, 30, angle_start, arc_end)
        text!(d, 150 + 20*cosd(angle_start + central_angle/2), 
              150 - 20*sind(angle_start + central_angle/2), "$(central_angle)°", 12)
        
        problem(
            question="In the circle with center O, the central angle ∠AOB measures $(central_angle)°. What is the measure of arc AB?",
            answer=central_angle,
            difficulty=(700, 800),
            solution=steps(
                "A central angle has the same measure as its intercepted arc",
                sol("∠AOB", central_angle),
                sol("Arc AB", central_angle)
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == "chord_theorem"
        # Two chords intersect: products of segments are equal
        a = randint(3, 12)
        b = randint(3, 12)
        c = randint(3, 12)
        d_val = (a * b) // c
        
        while denominator(d_val) != 1
            a = randint(3, 12)
            b = randint(3, 12)
            c = randint(3, 12)
            d_val = (a * b) // c
        end
        
        d_int = Int(d_val)
        
        d = DiagramObj(300, 300)
        circle!(d, 150, 150, 80)
        
        # Intersection point inside circle
        ix = 150 + randint(-30, 30)
        iy = 150 + randint(-30, 30)
        
        # Two chords through intersection
        x1 = 150 + 80 * cosd(30)
        y1 = 150 - 80 * sind(30)
        x2 = 150 + 80 * cosd(210)
        y2 = 150 - 80 * sind(210)
        
        x3 = 150 + 80 * cosd(120)
        y3 = 150 - 80 * sind(120)
        x4 = 150 + 80 * cosd(300)
        y4 = 150 - 80 * sind(300)
        
        point!(d, x1, y1, "A")
        point!(d, x2, y2, "B")
        point!(d, x3, y3, "C")
        point!(d, x4, y4, "D")
        point!(d, ix, iy, "E")
        
        line!(d, x1, y1, x2, y2)
        line!(d, x3, y3, x4, y4)
        
        segment_label!(d, (x1+ix)/2, (y1+iy)/2, "$(a)")
        segment_label!(d, (x2+ix)/2, (y2+iy)/2, "$(b)")
        segment_label!(d, (x3+ix)/2, (y3+iy)/2, "$(c)")
        segment_label!(d, (x4+ix)/2, (y4+iy)/2, "x")
        
        problem(
            question="Two chords AB and CD intersect at point E inside a circle. If AE = $(a), EB = $(b), and CE = $(c), find the length of ED.",
            answer=d_int,
            difficulty=(900, 1100),
            solution=steps(
                "When two chords intersect inside a circle, the products of their segments are equal: AE × EB = CE × ED",
                sol("Equation", "$(a) \\times $(b) = $(c) \\times x"),
                sol("$(a * b) = $(c)x"),
                sol("x", d_int)
            ),
            image=render(d),
            time=90
        )
        
    else  # tangent_chord
        # Tangent-chord angle equals half the intercepted arc
        arc_measure = randint(60, 160)
        tangent_angle = arc_measure // 2
        
        d = DiagramObj(300, 300)
        circle!(d, 150, 150, 80)
        
        # Point of tangency at bottom
        px = 150
        py = 230
        
        # Tangent line (horizontal)
        line!(d, 50, py, 250, py)
        
        # Chord from tangent point
        chord_angle = randint(30, 70)
        x2 = 150 + 80 * cosd(chord_angle)
        y2 = 150 - 80 * sind(chord_angle)
        
        point!(d, px, py, "A")
        point!(d, x2, y2, "B")
        point!(d, 150, 150, "O")
        
        line!(d, px, py, x2, y2)
        
        arc!(d, 150, 150, 60, chord_angle, 270)
        
        problem(
            question="A tangent line touches a circle at point A, and chord AB is drawn. If arc AB measures $(arc_measure)°, what is the measure of the angle between the tangent and the chord?",
            answer=tangent_angle,
            difficulty=(900, 1100),
            solution=steps(
                "The angle between a tangent and a chord equals half the measure of the intercepted arc",
                sol("Arc AB", arc_measure),
                sol("Tangent-chord angle = \\frac{1}{2} \\times $(arc_measure)°", tangent_angle)
            ),
            image=render(d),
            time=75
        )
    end
end