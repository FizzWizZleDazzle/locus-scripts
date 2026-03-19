# geometry - circle_theorems (hard)
# Generated: 2026-03-08T20:06:07.137133

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/circle_theorems")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Inscribed angle theorem with chord
        radius = randint(5, 12)
        arc_angle = choice([60, 80, 90, 100, 120, 140, 160])
        inscribed_angle = arc_angle // 2
        
        d = DiagramObj(width=400, height=400)
        circle!(d, 200, 200, 150, stroke="black", fill="none", stroke_width=2)
        
        # Central angle
        θ1 = deg2rad(90)
        θ2 = deg2rad(90 + arc_angle)
        x1, y1 = 200 + 150*cos(θ1), 200 - 150*sin(θ1)
        x2, y2 = 200 + 150*cos(θ2), 200 - 150*sin(θ2)
        
        # Point on circle (opposite side)
        θ3 = deg2rad(90 + arc_angle/2 + 180)
        x3, y3 = 200 + 150*cos(θ3), 200 - 150*sin(θ3)
        
        line!(d, x1, y1, x3, y3, stroke="blue", stroke_width=2)
        line!(d, x2, y2, x3, y3, stroke="blue", stroke_width=2)
        line!(d, x1, y1, 200, 200, stroke="gray", stroke_width=1.5, stroke_dasharray="5,5")
        line!(d, x2, y2, 200, 200, stroke="gray", stroke_width=1.5, stroke_dasharray="5,5")
        
        point!(d, 200, 200, label="O", size=4)
        point!(d, x1, y1, label="A", size=4)
        point!(d, x2, y2, label="B", size=4)
        point!(d, x3, y3, label="P", size=4)
        
        arc!(d, 200, 200, 30, 90, 90 + arc_angle, stroke="red", stroke_width=2)
        text!(d, 200 + 50*cos(deg2rad(90 + arc_angle/2)), 200 - 50*sin(deg2rad(90 + arc_angle/2)), "$(arc_angle)°", font_size=16)
        
        problem(
            question="Circle O has an arc AB with central angle $(arc_angle)°. Point P lies on the circle such that P and the center O are on opposite sides of chord AB. What is the measure of inscribed angle ∠APB?",
            answer=inscribed_angle,
            difficulty=(1800, 2000),
            solution=steps(
                "By the Inscribed Angle Theorem, an inscribed angle is half the central angle that subtends the same arc",
                sol("Central angle", "$(arc_angle)°"),
                sol("Inscribed angle ∠APB", "$(arc_angle)° ÷ 2 = $(inscribed_angle)°")
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 2
        # Tangent-chord angle
        chord_angle = choice([40, 50, 60, 70, 80])
        arc_angle = 2 * chord_angle
        
        d = DiagramObj(width=400, height=400)
        circle!(d, 200, 200, 130, stroke="black", fill="none", stroke_width=2)
        
        # Tangent point
        θ_tangent = deg2rad(45)
        xt, yt = 200 + 130*cos(θ_tangent), 200 - 130*sin(θ_tangent)
        
        # Chord endpoint
        θ_chord = deg2rad(45 + arc_angle)
        xc, yc = 200 + 130*cos(θ_chord), 200 - 130*sin(θ_chord)
        
        # Tangent line (perpendicular to radius)
        tang_dx = -sin(θ_tangent)
        tang_dy = -cos(θ_tangent)
        line!(d, xt - 80*tang_dx, yt + 80*tang_dy, xt + 80*tang_dx, yt - 80*tang_dy, stroke="green", stroke_width=2)
        
        # Chord
        line!(d, xt, yt, xc, yc, stroke="blue", stroke_width=2)
        
        point!(d, xt, yt, label="T", size=4)
        point!(d, xc, yc, label="C", size=4)
        point!(d, 200, 200, label="O", size=4)
        
        arc!(d, 200, 200, 40, 45, 45 + arc_angle, stroke="red", stroke_width=2)
        
        problem(
            question="A tangent to circle O touches the circle at point T. A chord TC is drawn from T to point C on the circle. The arc TC (not containing the tangent side) measures $(arc_angle)°. What is the measure of the angle between the tangent and chord TC?",
            answer=chord_angle,
            difficulty=(1900, 2100),
            solution=steps(
                "By the Tangent-Chord Angle Theorem, the angle between a tangent and a chord equals half the arc intercepted by the chord",
                sol("Arc TC", "$(arc_angle)°"),
                sol("Angle between tangent and chord", "$(arc_angle)° ÷ 2 = $(chord_angle)°")
            ),
            image=render(d),
            time=150
        )
        
    elseif problem_type == 3
        # Two chords intersecting inside circle
        arc1 = choice([70, 80, 90, 100])
        arc2 = choice([50, 60, 70, 80])
        angle_formed = (arc1 + arc2) // 2
        
        d = DiagramObj(width=400, height=400)
        circle!(d, 200, 200, 140, stroke="black", fill="none", stroke_width=2)
        
        # Intersection point inside
        ix, iy = 220, 200
        
        # Chord 1
        θ1a, θ1b = deg2rad(20), deg2rad(20 + arc1)
        x1a, y1a = 200 + 140*cos(θ1a), 200 - 140*sin(θ1a)
        x1b, y1b = 200 + 140*cos(θ1b), 200 - 140*sin(θ1b)
        
        # Chord 2
        θ2a, θ2b = deg2rad(200), deg2rad(200 + arc2)
        x2a, y2a = 200 + 140*cos(θ2a), 200 - 140*sin(θ2a)
        x2b, y2b = 200 + 140*cos(θ2b), 200 - 140*sin(θ2b)
        
        line!(d, x1a, y1a, x1b, y1b, stroke="blue", stroke_width=2)
        line!(d, x2a, y2a, x2b, y2b, stroke="purple", stroke_width=2)
        
        point!(d, x1a, y1a, label="A", size=4)
        point!(d, x1b, y1b, label="B", size=4)
        point!(d, x2a, y2a, label="C", size=4)
        point!(d, x2b, y2b, label="D", size=4)
        point!(d, ix, iy, label="P", size=4)
        
        arc!(d, 200, 200, 50, 20, 20 + arc1, stroke="red", stroke_width=2)
        text!(d, 200 + 70*cos(deg2rad(20 + arc1/2)), 200 - 70*sin(deg2rad(20 + arc1/2)), "$(arc1)°", font_size=14)
        
        arc!(d, 200, 200, 60, 200, 200 + arc2, stroke="red", stroke_width=2)
        text!(d, 200 + 80*cos(deg2rad(200 + arc2/2)), 200 - 80*sin(deg2rad(200 + arc2/2)), "$(arc2)°", font_size=14)
        
        problem(
            question="Two chords AB and CD intersect at point P inside circle O. Arc AB measures $(arc1)° and arc CD measures $(arc2)°. What is the measure of ∠APD formed at the intersection?",
            answer=angle_formed,
            difficulty=(2000, 2200),
            solution=steps(
                "When two chords intersect inside a circle, the measure of an inscribed angle equals half the sum of the intercepted arcs",
                sol("Arc AB", "$(arc1)°"),
                sol("Arc CD", "$(arc2)°"),
                sol("∠APD", "($(arc1)° + $(arc2)°) ÷ 2 = $(angle_formed)°")
            ),
            image=render(d),
            time=180
        )
        
    elseif problem_type == 4
        # Power of a point (two secants)
        PA = randint(4, 8)
        PB = randint(10, 16)
        PC = randint(5, 9)
        PD = (PA * PB) // PC
        
        d = DiagramObj(width=450, height=400)
        circle!(d, 250, 200, 110, stroke="black", fill="none", stroke_width=2)
        
        # External point
        px, py = 80, 200
        
        # Secant 1
        θ1 = deg2rad(30)
        θ2 = deg2rad(70)
        xa = 250 + 110*cos(θ1)
        ya = 200 - 110*sin(θ1)
        xb = 250 + 110*cos(θ2)
        yb = 200 - 110*sin(θ2)
        
        # Secant 2
        θ3 = deg2rad(140)
        θ4 = deg2rad(180)
        xc = 250 + 110*cos(θ3)
        yc = 200 - 110*sin(θ3)
        xd = 250 + 110*cos(θ4)
        yd = 200 - 110*sin(θ4)
        
        line!(d, px, py, xb, yb, stroke="blue", stroke_width=2)
        line!(d, px, py, xd, yd, stroke="purple", stroke_width=2)
        
        point!(d, px, py, label="P", size=4)
        point!(d, xa, ya, label="A", size=4)
        point!(d, xb, yb, label="B", size=4)
        point!(d, xc, yc, label="C", size=4)
        point!(d, xd, yd, label="D", size=4)
        point!(d, 250, 200, label="O", size=3)
        
        segment_label!(d, px, py, xa, ya, "$(PA)", offset=15)
        segment_label!(d, px, py, xb, yb, "$(PB)", offset=15)
        segment_label!(d, px, py, xc, yc, "$(PC)", offset=15)
        
        problem(
            question="From external point P, two secants are drawn to circle O. One secant intersects the circle at A and B with PA = $(PA) and PB = $(PB). The other secant intersects at C and D with PC = $(PC). Find PD.",
            answer=PD,
            difficulty=(2100, 2300),
            solution=steps(
                "By the Power of a Point Theorem, for two secants from an external point: PA · PB = PC · PD",
                sol("Given equation", "$(PA) × $(PB) = $(PC) × PD"),
                sol("$(PA * PB) = $(PC) × PD"),
                sol("PD", "$(PA * PB) ÷ $(PC) = $(PD)")
            ),
            image=render(d),
            time=200
        )
        
    else
        # Cyclic quadrilateral opposite angles
        angle_A = choice([75, 80, 85, 90, 95, 100, 105, 110])
        angle_C = 180 - angle_A
        
        d = DiagramObj(width=400, height=400)
        circle!(d, 200, 200, 130, stroke="black", fill="none", stroke_width=2)
        
        # Four points on circle forming quadrilateral
        θA, θB, θC, θD = deg2rad(40), deg2rad(110), deg2rad(220), deg2rad(320)
        xA, yA = 200 + 130*cos(θA), 200 - 130*sin(θA)
        xB, yB = 200 + 130*cos(θB), 200 - 130*sin(θB)
        xC, yC = 200 + 130*cos(θC), 200 - 130*sin(θC)
        xD, yD = 200 + 130*cos(θD), 200 - 130*sin(θD)
        
        polygon!(d, [xA, xB, xC, xD], [yA, yB, yC, yD], stroke="blue", fill="none", stroke_width=2)
        
        point!(d, xA, yA, label="A", size=4)
        point!(d, xB, yB, label="B", size=4)
        point!(d, xC, yC, label="C", size=4)
        point!(d, xD, yD, label="D", size=4)
        
        text!(d, xA - 30, yA, "$(angle_A)°", font_size=16)
        text!(d, xC + 20, yC, "?", font_size=16)
        
        problem(
            question="Quadrilateral ABCD is inscribed in a circle (cyclic quadrilateral). If ∠A = $(angle_A)°, what is the measure of ∠C?",
            answer=angle_C,
            difficulty=(1850, 2050),
            solution=steps(
                "In a cyclic quadrilateral, opposite angles are supplementary (sum to 180°)",
                sol("∠A + ∠C", "180°"),
                sol("$(angle_A)° + ∠C", "180°"),
                sol("∠C", "180° - $(angle_A)° = $(angle_C)°")
            ),
            image=render(d),
            time=140
        )
    end
end