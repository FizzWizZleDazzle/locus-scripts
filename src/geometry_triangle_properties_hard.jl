# geometry - triangle_properties (hard)
# Generated: 2026-03-08T20:03:02.080979

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/triangle_properties")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Triangle with angle bisector theorem (ELO 1800-2000)
        AB = randint(8, 20)
        AC = randint(8, 20)
        BD = randint(3, 10)
        DC = (AC * BD) // AB
        BC = BD + DC
        
        d = DiagramObj(600, 400)
        point!(d, 100, 300, "A")
        point!(d, 500, 300, "B")
        point!(d, 300, 50, "C")
        point!(d, 300 + (200 * BD) / BC - 200, 300, "D")
        
        line!(d, 100, 300, 500, 300)
        line!(d, 100, 300, 300, 50)
        line!(d, 500, 300, 300, 50)
        line!(d, 300, 50, 300 + (200 * BD) / BC - 200, 300, color="blue", stroke_width=2)
        
        segment_label!(d, 100, 300, 500, 300, "$(BC)", :below)
        segment_label!(d, 100, 300, 300, 50, "$(AB)", :left)
        segment_label!(d, 500, 300, 300, 50, "$(AC)", :right)
        text!(d, 300 + (200 * BD) / BC - 200, 320, "D", font_size=16)
        segment_label!(d, 100, 300, 300 + (200 * BD) / BC - 200, 300, "$(BD)", :below)
        
        problem(
            question="In triangle ABC, AD is the angle bisector of ∠BAC. If AB = $(AB), AC = $(AC), and BD = $(BD), find DC.",
            answer=DC,
            difficulty=(1800, 2000),
            solution=steps(
                "By the Angle Bisector Theorem, \\frac{BD}{DC} = \\frac{AB}{AC}",
                sol("Substituting", "\\frac{$(BD)}{DC} = \\frac{$(AB)}{$(AC)}"),
                sol("Cross multiply", "$(AB) \\cdot DC = $(AC) \\cdot $(BD) = $(AC * BD)"),
                sol("DC", DC)
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 2
        # Stewart's Theorem application (ELO 2000-2200)
        a = randint(10, 18)
        b = randint(10, 18)
        m = randint(4, 9)
        n = randint(4, 9)
        c = m + n
        
        d_squared = (b^2 * m + a^2 * n - m * n * c) // c
        d_val = sqrt(Float64(d_squared))
        
        d = DiagramObj(600, 400)
        point!(d, 100, 300, "B")
        point!(d, 500, 300, "C")
        point!(d, 300, 50, "A")
        point!(d, 100 + 400 * m / c, 300, "D")
        
        line!(d, 100, 300, 500, 300)
        line!(d, 100, 300, 300, 50)
        line!(d, 500, 300, 300, 50)
        line!(d, 300, 50, 100 + 400 * m / c, 300, color="blue", stroke_width=2)
        
        segment_label!(d, 100, 300, 300, 50, "$(a)", :left)
        segment_label!(d, 500, 300, 300, 50, "$(b)", :right)
        segment_label!(d, 100, 300, 100 + 400 * m / c, 300, "$(m)", :below)
        segment_label!(d, 100 + 400 * m / c, 300, 500, 300, "$(n)", :below)
        text!(d, 100 + 400 * m / c, 320, "D", font_size=16)
        
        problem(
            question="In triangle ABC, point D lies on BC such that BD = $(m) and DC = $(n). If AB = $(a) and AC = $(b), find AD² using Stewart's Theorem.",
            answer=d_squared,
            difficulty=(2000, 2200),
            solution=steps(
                "Stewart's Theorem states: b²m + a²n = c(d² + mn)",
                "Where BC = c = $(m) + $(n) = $(c) and AD = d",
                sol("Substitute", "$(b)^2 \\cdot $(m) + $(a)^2 \\cdot $(n) = $(c)(d^2 + $(m) \\cdot $(n))"),
                sol("Simplify", "$(b^2 * m) + $(a^2 * n) = $(c)d^2 + $(c * m * n)"),
                sol("Solve for d²", "d^2 = \\frac{$(b^2 * m + a^2 * n) - $(c * m * n)}{$(c)} = $(d_squared)")
            ),
            image=render(d),
            time=180
        )
        
    elseif problem_type == 3
        # Median length formula (ELO 1900-2100)
        a = randint(8, 16)
        b = randint(8, 16)
        c = randint(8, 16)
        
        m_a_squared = (2*b^2 + 2*c^2 - a^2) // 4
        
        d = DiagramObj(600, 400)
        point!(d, 100, 300, "B")
        point!(d, 500, 300, "C")
        point!(d, 300, 50, "A")
        point!(d, 300, 300, "M")
        
        line!(d, 100, 300, 500, 300)
        line!(d, 100, 300, 300, 50)
        line!(d, 500, 300, 300, 50)
        line!(d, 300, 50, 300, 300, color="red", stroke_width=2)
        
        segment_label!(d, 100, 300, 500, 300, "a = $(a)", :below)
        segment_label!(d, 100, 300, 300, 50, "c = $(c)", :left)
        segment_label!(d, 500, 300, 300, 50, "b = $(b)", :right)
        text!(d, 300, 320, "M", font_size=16)
        
        problem(
            question="In triangle ABC, M is the midpoint of BC. If BC = $(a), AC = $(b), and AB = $(c), find the square of the length of median AM using the formula m_a² = (2b² + 2c² - a²)/4.",
            answer=m_a_squared,
            difficulty=(1900, 2100),
            solution=steps(
                "The median length formula is m_a^2 = \\frac{2b^2 + 2c^2 - a^2}{4}",
                sol("Substitute", "m_a^2 = \\frac{2($(b))^2 + 2($(c))^2 - ($(a))^2}{4}"),
                sol("Calculate", "m_a^2 = \\frac{$(2*b^2) + $(2*c^2) - $(a^2)}{4}"),
                sol("Answer", "m_a^2 = \\frac{$(2*b^2 + 2*c^2 - a^2)}{4} = $(m_a_squared)")
            ),
            image=render(d),
            time=150
        )
        
    elseif problem_type == 4
        # Triangle with altitude and area relationship (ELO 1850-2050)
        base = randint(12, 24)
        height = randint(8, 18)
        area = (base * height) // 2
        
        side_a = randint(10, 20)
        altitude_to_a = (2 * area) // side_a
        
        d = DiagramObj(600, 400)
        point!(d, 100, 300, "B")
        point!(d, 500, 300, "C")
        point!(d, 300, 50, "A")
        point!(d, 300, 300, "H")
        
        line!(d, 100, 300, 500, 300)
        line!(d, 100, 300, 300, 50)
        line!(d, 500, 300, 300, 50)
        line!(d, 300, 50, 300, 300, color="green", stroke_width=2, stroke_dasharray="5,5")
        right_angle!(d, 300, 300, 300, 50, 350, 300, size=15)
        
        segment_label!(d, 100, 300, 500, 300, "$(base)", :below)
        segment_label!(d, 300, 50, 300, 300, "$(height)", :right)
        text!(d, 300, 320, "H", font_size=16)
        
        problem(
            question="Triangle ABC has base BC = $(base) and altitude AH = $(height) from A to BC. If another side of the triangle has length $(side_a), what is the length of the altitude to that side?",
            answer=altitude_to_a,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Area of triangle", "A = \\frac{1}{2} \\cdot $(base) \\cdot $(height) = $(area)"),
                "Using the same area with the other side as base:",
                sol("Formula", "$(area) = \\frac{1}{2} \\cdot $(side_a) \\cdot h"),
                sol("Solve", "h = \\frac{2 \\cdot $(area)}{$(side_a)} = \\frac{$(2*area)}{$(side_a)} = $(altitude_to_a)")
            ),
            image=render(d),
            time=120
        )
        
    else
        # Angle bisector with perpendiculars (ELO 2100-2300)
        angle_deg = choice([30, 40, 50, 60])
        half_angle = angle_deg / 2
        dist = randint(8, 16)
        
        perpendicular_dist = dist * sin(deg2rad(half_angle))
        rounded_ans = round(perpendicular_dist, digits=2)
        
        d = DiagramObj(600, 500)
        point!(d, 100, 400, "A")
        point!(d, 500, 400, "B")
        point!(d, 100, 100, "C")
        point!(d, 300, 250, "P")
        
        line!(d, 100, 400, 500, 400)
        line!(d, 100, 400, 100, 100)
        line!(d, 100, 400, 300, 250, color="blue", stroke_width=2)
        line!(d, 300, 250, 300, 400, color="red", stroke_width=1.5, stroke_dasharray="5,5")
        line!(d, 300, 250, 100, 250, color="red", stroke_width=1.5, stroke_dasharray="5,5")
        right_angle!(d, 300, 400, 300, 250, 350, 400, size=12)
        right_angle!(d, 100, 250, 300, 250, 100, 300, size=12)
        
        angle_arc!(d, 100, 400, 500, 400, 100, 100, radius=50)
        text!(d, 170, 380, "$(angle_deg)°", font_size=14)
        segment_label!(d, 100, 400, 300, 250, "$(dist)", :above)
        text!(d, 300, 420, "Q", font_size=16)
        text!(d, 80, 250, "R", font_size=16)
        
        problem(
            question="Point P lies on the angle bisector of ∠BAC where ∠BAC = $(angle_deg)°. If AP = $(dist), find the perpendicular distance from P to side AB. Round to 2 decimal places.",
            answer=rounded_ans,
            difficulty=(2100, 2300),
            solution=steps(
                "Since AP is on the angle bisector, the angle from AB to AP is $(half_angle)°",
                "The perpendicular distance d from P to AB satisfies \\sin($(half_angle)°) = \\frac{d}{$(dist)}",
                sol("Calculate", "d = $(dist) \\cdot \\sin($(half_angle)°)"),
                sol("Answer", "d \\approx $(rounded_ans)")
            ),
            image=render(d),
            calculator="scientific",
            time=180
        )
    end
end