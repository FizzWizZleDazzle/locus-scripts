# geometry - pythagorean_theorem (hard)
# Generated: 2026-03-08T20:11:45.913780

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("geometry/pythagorean_theorem")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Right triangle with integer sides - find hypotenuse
        # Pythagorean triple or near-triple
        triples = [(3,4,5), (5,12,13), (8,15,17), (7,24,25), (20,21,29), (9,40,41), (12,35,37), (11,60,61)]
        scale = rand(1:4)
        base_triple = choice(triples)
        a = base_triple[1] * scale
        b = base_triple[2] * scale
        c = base_triple[3] * scale
        
        d = DiagramObj(300, 300)
        polygon!(d, [(50, 250), (250, 250), (250, 50)], fill="lightblue", stroke="black", stroke_width=2)
        right_angle!(d, (250, 250), (250, 50), (50, 250), size=15)
        segment_label!(d, (50, 250), (250, 250), "$(a)", position=:below)
        segment_label!(d, (250, 250), (250, 50), "$(b)", position=:right)
        segment_label!(d, (50, 250), (250, 50), "c", position=:left, offset=10)
        point!(d, 50, 250, color="black", radius=3)
        point!(d, 250, 250, color="black", radius=3)
        point!(d, 250, 50, color="black", radius=3)
        
        problem(
            question="In the right triangle shown, find the length of the hypotenuse \\(c\\).",
            answer=c,
            difficulty=(1800, 2000),
            solution=steps(
                "Apply the Pythagorean theorem: \\(a^2 + b^2 = c^2\\)",
                sol("Substitute", "$(a)^2 + $(b)^2 = c^2"),
                sol("Calculate", "$(a^2) + $(b^2) = $(a^2 + b^2) = c^2"),
                sol("Answer", "c = $(c)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Right triangle - find one leg given hypotenuse and other leg
        triples = [(3,4,5), (5,12,13), (8,15,17), (7,24,25), (20,21,29), (9,40,41), (12,35,37)]
        scale = rand(1:3)
        base_triple = choice(triples)
        a = base_triple[1] * scale
        b = base_triple[2] * scale
        c = base_triple[3] * scale
        
        d = DiagramObj(300, 300)
        polygon!(d, [(50, 250), (250, 250), (250, 50)], fill="lightyellow", stroke="black", stroke_width=2)
        right_angle!(d, (250, 250), (250, 50), (50, 250), size=15)
        segment_label!(d, (50, 250), (250, 250), "$(a)", position=:below)
        segment_label!(d, (250, 250), (250, 50), "b", position=:right)
        segment_label!(d, (50, 250), (250, 50), "$(c)", position=:left, offset=10)
        point!(d, 50, 250, color="black", radius=3)
        point!(d, 250, 250, color="black", radius=3)
        point!(d, 250, 50, color="black", radius=3)
        
        problem(
            question="In the right triangle shown, the hypotenuse has length $(c) and one leg has length $(a). Find the length of the other leg \\(b\\).",
            answer=b,
            difficulty=(1850, 2050),
            solution=steps(
                "Apply the Pythagorean theorem: \\(a^2 + b^2 = c^2\\)",
                sol("Substitute", "$(a)^2 + b^2 = $(c)^2"),
                sol("Solve for b", "b^2 = $(c^2) - $(a^2) = $(c^2 - a^2)"),
                sol("Answer", "b = $(b)")
            ),
            image=render(d),
            time=100
        )
        
    elseif problem_type == 3
        # Rectangle diagonal problem
        w = randint(12, 30)
        h = randint(15, 40)
        d_val = sqrt(w^2 + h^2)
        
        diag = DiagramObj(350, 300)
        polygon!(diag, [(50, 250), (300, 250), (300, 100), (50, 100)], fill="lightgreen", stroke="black", stroke_width=2)
        line!(diag, (50, 250), (300, 100), stroke="red", stroke_width=2, dash="5,5")
        segment_label!(diag, (50, 250), (300, 250), "$(w)", position=:below)
        segment_label!(diag, (300, 250), (300, 100), "$(h)", position=:right)
        segment_label!(diag, (50, 250), (300, 100), "d", position=:center, offset=-15)
        point!(diag, 50, 250, color="black", radius=3)
        point!(diag, 300, 250, color="black", radius=3)
        point!(diag, 300, 100, color="black", radius=3)
        point!(diag, 50, 100, color="black", radius=3)
        
        problem(
            question="A rectangle has width $(w) and height $(h). Find the length of the diagonal \\(d\\). Round your answer to two decimal places if necessary.",
            answer=round(d_val, digits=2),
            difficulty=(1900, 2100),
            solution=steps(
                "The diagonal forms the hypotenuse of a right triangle",
                sol("Apply Pythagorean theorem", "d^2 = $(w)^2 + $(h)^2"),
                sol("Calculate", "d^2 = $(w^2) + $(h^2) = $(w^2 + h^2)"),
                sol("Answer", "d = $(round(d_val, digits=2))")
            ),
            image=render(diag),
            calculator="scientific",
            time=110
        )
        
    elseif problem_type == 4
        # Distance from point to point using Pythagorean theorem
        x1 = randint(-15, 15)
        y1 = randint(-15, 15)
        x2 = randint(-15, 15)
        y2 = randint(-15, 15)
        while abs(x2 - x1) < 5 || abs(y2 - y1) < 5
            x2 = randint(-15, 15)
            y2 = randint(-15, 15)
        end
        
        dist = sqrt((x2 - x1)^2 + (y2 - y1)^2)
        
        d = DiagramObj(300, 300)
        line!(d, (50, 250), (250, 250), stroke="gray", stroke_width=1)
        line!(d, (150, 50), (150, 250), stroke="gray", stroke_width=1)
        arrow!(d, (40, 250), (260, 250), stroke="black", stroke_width=1)
        arrow!(d, (150, 260), (150, 40), stroke="black", stroke_width=1)
        
        scale_x = 200 / max(abs(x1), abs(x2), 10)
        scale_y = 200 / max(abs(y1), abs(y2), 10)
        px1 = 150 + x1 * scale_x / 2
        py1 = 250 - y1 * scale_y / 2
        px2 = 150 + x2 * scale_x / 2
        py2 = 250 - y2 * scale_y / 2
        
        point!(d, px1, py1, color="red", radius=4)
        point!(d, px2, py2, color="blue", radius=4)
        line!(d, (px1, py1), (px2, py2), stroke="purple", stroke_width=2)
        text!(d, px1 - 20, py1 + 15, "A($(x1),$(y1))", font_size=12)
        text!(d, px2 + 10, py2 - 10, "B($(x2),$(y2))", font_size=12)
        
        problem(
            question="Find the distance between points \\(A($(x1), $(y1))\\) and \\(B($(x2), $(y2))\\). Round to two decimal places if necessary.",
            answer=round(dist, digits=2),
            difficulty=(2000, 2200),
            solution=steps(
                sol("Distance formula", "d = \\sqrt{(x_2 - x_1)^2 + (y_2 - y_1)^2}"),
                sol("Substitute", "d = \\sqrt{($(x2) - $(x1))^2 + ($(y2) - $(y1))^2}"),
                sol("Simplify", "d = \\sqrt{$(((x2-x1)^2)) + $(((y2-y1)^2))} = \\sqrt{$((x2-x1)^2 + (y2-y1)^2)}"),
                sol("Answer", "d = $(round(dist, digits=2))")
            ),
            image=render(d),
            calculator="scientific",
            time=130
        )
        
    else
        # Ladder problem - classic application
        ladder_length = randint(15, 30)
        base_dist = randint(6, ladder_length - 5)
        height = sqrt(ladder_length^2 - base_dist^2)
        
        d = DiagramObj(350, 350)
        line!(d, (50, 300), (300, 300), stroke="brown", stroke_width=4)
        line!(d, (50, 300), (50, 50), stroke="brown", stroke_width=4)
        line!(d, (50, 300), (50 + base_dist * 8, 300 - height * 8), stroke="orange", stroke_width=3)
        right_angle!(d, (50, 300), (50, 290), (60, 300), size=12)
        segment_label!(d, (50, 300), (50 + base_dist * 8, 300), "$(base_dist) ft", position=:below)
        segment_label!(d, (50, 300), (50, 300 - height * 8), "h", position=:left)
        segment_label!(d, (50, 300), (50 + base_dist * 8, 300 - height * 8), "$(ladder_length) ft", position=:center, offset=-10)
        point!(d, 50, 300, color="black", radius=3)
        point!(d, 50 + base_dist * 8, 300, color="black", radius=3)
        point!(d, 50, 300 - height * 8, color="black", radius=3)
        text!(d, 100, 320, "Ground", font_size=12)
        text!(d, 20, 150, "Wall", font_size=12)
        
        problem(
            question="A $(ladder_length)-foot ladder is leaning against a wall. The base of the ladder is $(base_dist) feet from the wall. How high up the wall does the ladder reach? Round to two decimal places if necessary.",
            answer=round(height, digits=2),
            difficulty=(2100, 2300),
            solution=steps(
                "The ladder forms the hypotenuse of a right triangle",
                sol("Pythagorean theorem", "$(base_dist)^2 + h^2 = $(ladder_length)^2"),
                sol("Solve for h", "h^2 = $(ladder_length^2) - $(base_dist^2) = $(ladder_length^2 - base_dist^2)"),
                sol("Answer", "h = $(round(height, digits=2)) \\text{ feet}")
            ),
            image=render(d),
            calculator="scientific",
            time=140
        )
    end
end