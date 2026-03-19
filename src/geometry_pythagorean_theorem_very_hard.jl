# geometry - pythagorean_theorem (very_hard)
# Generated: 2026-03-08T20:11:59.731382

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/pythagorean_theorem")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # COMPETITION: Pythagorean theorem with altitude to hypotenuse
        a = randint(8, 20)
        b = randint(8, 20)
        c_sq = a^2 + b^2
        c = sqrt(c_sq)
        
        # Altitude h from right angle to hypotenuse
        h = (a * b) / c
        
        # Segments on hypotenuse
        p = a^2 / c
        q = b^2 / c
        
        d = DiagramObj(600, 400)
        polygon!(d, [100, 300], [500, 300], [500, 100], fill="lightblue", stroke="black", stroke_width=2)
        line!(d, [500, 300], [500 - h * (b/c), 300 - h * (a/c)], stroke="red", stroke_width=2)
        point!(d, [100, 300], label="A", label_offset=(-15, 10))
        point!(d, [500, 300], label="B", label_offset=(10, 10))
        point!(d, [500, 100], label="C", label_offset=(10, -15))
        point!(d, [500 - h * (b/c), 300 - h * (a/c)], label="D", label_offset=(0, -15))
        right_angle!(d, [500, 300], [500, 100], [100, 300])
        segment_label!(d, [100, 300], [500, 100], text=string(round(Int, a)))
        segment_label!(d, [500, 100], [500, 300], text=string(round(Int, b)))
        text!(d, 300, 50, "h = ?", font_size=16)
        
        ans = round(h, digits=2)
        
        problem(
            question="In right triangle ABC with right angle at B, the legs are AB = $(a) and BC = $(b). An altitude is drawn from B to the hypotenuse AC, meeting it at D. Find the length of this altitude BD (denoted h in the diagram). Round to 2 decimal places.",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                "Given: Right triangle with legs a=$(a) and b=$(b)",
                sol("Hypotenuse", "c = \\sqrt{$(a)^2 + $(b)^2} = \\sqrt{$(c_sq)} = $(round(c, digits=2))"),
                "Altitude to hypotenuse formula: \\(h = \\frac{ab}{c}\\)",
                sol("h", "\\frac{$(a) \\cdot $(b)}{$(round(c, digits=2))} = $(ans)")
            ),
            time=180,
            image=render(d)
        )
        
    elseif problem_type == 2
        # COMPETITION: Pythagorean triple with median
        # Use a Pythagorean triple scaled
        scale = randint(3, 8)
        base_triples = [[3, 4, 5], [5, 12, 13], [8, 15, 17], [7, 24, 25]]
        triple = choice(base_triples)
        a = triple[1] * scale
        b = triple[2] * scale
        c = triple[3] * scale
        
        # Median to hypotenuse is half the hypotenuse
        median = c / 2
        
        d = DiagramObj(600, 400)
        polygon!(d, [100, 350], [500, 350], [300, 100], fill="lightgreen", stroke="black", stroke_width=2)
        line!(d, [300, 100], [300, 350], stroke="blue", stroke_width=2, stroke_dasharray="5,5")
        point!(d, [100, 350], label="A", label_offset=(-15, 10))
        point!(d, [500, 350], label="B", label_offset=(10, 10))
        point!(d, [300, 100], label="C", label_offset=(0, -15))
        point!(d, [300, 350], label="M", label_offset=(0, 15))
        right_angle!(d, [300, 100], [100, 350], [300, 350])
        segment_label!(d, [100, 350], [300, 100], text=string(a))
        segment_label!(d, [300, 100], [500, 350], text=string(b))
        text!(d, 300, 50, "Find CM", font_size=16)
        
        ans = round(Int, median)
        
        problem(
            question="In right triangle ABC with right angle at A, AC = $(a) and AB = $(b). Point M is the midpoint of the hypotenuse BC. Find the length CM.",
            answer=ans,
            difficulty=(2600, 2900),
            solution=steps(
                "Given: Right triangle with legs $(a) and $(b)",
                sol("Hypotenuse BC", "\\sqrt{$(a)^2 + $(b)^2} = \\sqrt{$(a^2 + b^2)} = $(c)"),
                "Key theorem: The median from the right angle to the hypotenuse equals half the hypotenuse",
                sol("CM", "\\frac{$(c)}{2} = $(ans)")
            ),
            time=200,
            image=render(d)
        )
        
    elseif problem_type == 3
        # OLYMPIAD: Stewart's theorem application with Pythagorean
        a = randint(12, 25)
        b = randint(12, 25)
        c_sq = a^2 + b^2
        c = sqrt(c_sq)
        
        # Point on hypotenuse dividing it in ratio m:n
        m = randint(2, 5)
        n = randint(2, 5)
        ratio = m / (m + n)
        
        # Distance from vertex to dividing point
        d_from_right = sqrt(a^2 * (1 - ratio)^2 + b^2 * ratio^2)
        
        d = DiagramObj(600, 400)
        polygon!(d, [100, 350], [500, 350], [500, 100], fill="lightyellow", stroke="black", stroke_width=2)
        x_p = 500 - ratio * 400
        y_p = 350 - ratio * 250
        line!(d, [500, 350], [x_p, y_p], stroke="purple", stroke_width=2)
        point!(d, [100, 350], label="A", label_offset=(-15, 10))
        point!(d, [500, 350], label="B", label_offset=(10, 10))
        point!(d, [500, 100], label="C", label_offset=(10, -15))
        point!(d, [x_p, y_p], label="P", label_offset=(-15, -15))
        right_angle!(d, [500, 350], [500, 100], [100, 350])
        segment_label!(d, [100, 350], [500, 100], text=string(a))
        segment_label!(d, [500, 100], [500, 350], text=string(b))
        text!(d, 300, 50, "AP:PC = $(m):$(n), Find BP", font_size=16)
        
        ans = round(d_from_right, digits=2)
        
        problem(
            question="In right triangle ABC with right angle at B, AB = $(a) and BC = $(b). Point P lies on AC such that AP:PC = $(m):$(n). Find the length BP. Round to 2 decimal places.",
            answer=ans,
            difficulty=(3000, 3400),
            solution=steps(
                "Given: Right triangle with legs $(a), $(b); P divides AC in ratio $(m):$(n)",
                sol("Hypotenuse", "AC = \\sqrt{$(a)^2 + $(b)^2} = $(round(c, digits=2))"),
                "Using Stewart's Theorem or coordinate geometry with B at origin",
                sol("Coordinates", "A=($(a),0), C=(0,$(b)), P divides AC"),
                "P coordinates: \\(P = \\left($(a) \\cdot \\frac{$(n)}{$(m+n)}, $(b) \\cdot \\frac{$(m)}{$(m+n)}\\right)\\)",
                sol("BP", "\\sqrt{($(a) \\cdot \\frac{$(n)}{$(m+n)})^2 + ($(b) \\cdot \\frac{$(m)}{$(m+n)})^2} = $(ans)")
            ),
            time=300,
            image=render(d)
        )
        
    elseif problem_type == 4
        # COMPETITION-OLYMPIAD: Pythagorean with angle bisector
        a = randint(15, 30)
        b = randint(15, 30)
        c_sq = a^2 + b^2
        c = sqrt(c_sq)
        
        # Angle bisector from right angle to hypotenuse
        # Length formula: t = (ab√2)/(a+b)
        t = (a * b * sqrt(2)) / (a + b)
        
        d = DiagramObj(600, 400)
        polygon!(d, [100, 350], [500, 350], [500, 100], fill="lightcoral", stroke="black", stroke_width=2)
        # Angle bisector divides opposite side in ratio of adjacent sides
        ratio = a / (a + b)
        x_d = 100 + ratio * 400
        y_d = 350 - ratio * 250
        line!(d, [500, 350], [x_d, y_d], stroke="green", stroke_width=2)
        point!(d, [100, 350], label="A", label_offset=(-15, 10))
        point!(d, [500, 350], label="B", label_offset=(10, 10))
        point!(d, [500, 100], label="C", label_offset=(10, -15))
        point!(d, [x_d, y_d], label="D", label_offset=(0, -15))
        right_angle!(d, [500, 350], [500, 100], [100, 350])
        segment_label!(d, [100, 350], [500, 100], text=string(a))
        segment_label!(d, [500, 100], [500, 350], text=string(b))
        text!(d, 300, 50, "BD bisects ∠ABC, Find BD", font_size=16)
        
        ans = round(t, digits=2)
        
        problem(
            question="In right triangle ABC with right angle at B, AB = $(a) and BC = $(b). The angle bisector from B meets AC at D. Find the length BD. Round to 2 decimal places.",
            answer=ans,
            difficulty=(3100, 3500),
            solution=steps(
                "Given: Right triangle with legs $(a), $(b); BD bisects the right angle",
                "The angle bisector from the right angle to hypotenuse has formula:",
                sol("Formula", "BD = \\frac{ab\\sqrt{2}}{a+b}"),
                sol("Substitute", "BD = \\frac{$(a) \\cdot $(b) \\cdot \\sqrt{2}}{$(a) + $(b)} = \\frac{$(a*b)\\sqrt{2}}{$(a+b)}"),
                sol("Answer", "BD = $(ans)")
            ),
            time=280,
            image=render(d)
        )
        
    else
        # OLYMPIAD: Multiple Pythagorean applications with squares on sides
        leg = randint(10, 20)
        
        # Square on leg has diagonal
        diagonal = leg * sqrt(2)
        
        d = DiagramObj(600, 500)
        # Right triangle
        polygon!(d, [200, 400], [500, 400], [500, 200], fill="lightblue", stroke="black", stroke_width=2)
        # Square on vertical leg
        polygon!(d, [500, 200], [500, 400], [500 + leg * 1.5, 400], [500 + leg * 1.5, 200], fill="lightyellow", stroke="black", stroke_width=2)
        # Diagonal of square
        line!(d, [500, 200], [500 + leg * 1.5, 400], stroke="red", stroke_width=2, stroke_dasharray="5,5")
        
        point!(d, [200, 400], label="A", label_offset=(-15, 10))
        point!(d, [500, 400], label="B", label_offset=(-10, 10))
        point!(d, [500, 200], label="C", label_offset=(-10, -15))
        right_angle!(d, [500, 400], [500, 200], [200, 400])
        segment_label!(d, [500, 200], [500, 400], text=string(leg))
        text!(d, 300, 50, "Square BCDE on BC, Find diagonal BD", font_size=16)
        
        ans = round(diagonal, digits=2)
        
        problem(
            question="In right triangle ABC with right angle at B, BC = $(leg). A square BCDE is constructed externally on side BC. Find the length of diagonal BD of the square. Round to 2 decimal places.",
            answer=ans,
            difficulty=(2800, 3200),
            solution=steps(
                "Given: Square BCDE with side length $(leg)",
                "The diagonal of a square with side s is \\(s\\sqrt{2}\\)",
                sol("Formula", "BD = $(leg) \\cdot \\sqrt{2}"),
                sol("Calculate", "BD = $(leg)\\sqrt{2} \\approx $(ans)")
            ),
            time=240,
            image=render(d)
        )
    end
end