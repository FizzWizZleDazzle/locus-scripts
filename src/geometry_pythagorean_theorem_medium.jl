# geometry - pythagorean_theorem (medium)
# Generated: 2026-03-08T20:11:46.979961

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/pythagorean_theorem")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Find hypotenuse given two legs
        a = randint(3, 15)
        b = randint(3, 15)
        c = sqrt(a^2 + b^2)
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (250, 200), (250, 200 - b * 10)], :none, "black", 2)
        right_angle!(d, (250, 200), (250, 200 - b * 10), (50, 200), 15)
        segment_label!(d, (50, 200), (250, 200), "$a", :below)
        segment_label!(d, (250, 200), (250, 200 - b * 10), "$b", :right)
        segment_label!(d, (50, 200), (250, 200 - b * 10), "c", :above_left)
        
        if c == floor(c)
            ans = Int(c)
            problem(
                question="Find the length of the hypotenuse c in the right triangle shown.",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "Apply the Pythagorean theorem: \$c^2 = a^2 + b^2\$",
                    sol("c^2 = $(a)^2 + $(b)^2 = $(a^2) + $(b^2) = $(a^2 + b^2)"),
                    sol("c = \\sqrt{$(a^2 + b^2)} = $ans")
                ),
                image=render(d),
                time=90
            )
        else
            ans_simplified = sqrt(a^2 + b^2)
            problem(
                question="Find the exact length of the hypotenuse c in the right triangle shown. Simplify your answer.",
                answer=ans_simplified,
                difficulty=(1300, 1500),
                solution=steps(
                    "Apply the Pythagorean theorem: \$c^2 = a^2 + b^2\$",
                    sol("c^2 = $(a)^2 + $(b)^2 = $(a^2) + $(b^2) = $(a^2 + b^2)"),
                    sol("c = \\sqrt{$(a^2 + b^2)}")
                ),
                image=render(d),
                time=90
            )
        end
        
    elseif problem_type == 2
        # Find leg given hypotenuse and other leg
        a = randint(3, 12)
        c = randint(a + 2, 20)
        b_squared = c^2 - a^2
        b = sqrt(b_squared)
        
        d = DiagramObj(width=300, height=250)
        leg_height = min(150, b * 8)
        polygon!(d, [(50, 200), (250, 200), (250, 200 - leg_height)], :none, "black", 2)
        right_angle!(d, (250, 200), (250, 200 - leg_height), (50, 200), 15)
        segment_label!(d, (50, 200), (250, 200), "$a", :below)
        segment_label!(d, (250, 200), (250, 200 - leg_height), "b", :right)
        segment_label!(d, (50, 200), (250, 200 - leg_height), "$c", :above_left)
        
        if b == floor(b)
            ans = Int(b)
            problem(
                question="Find the length of side b in the right triangle shown.",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "Apply the Pythagorean theorem: \$a^2 + b^2 = c^2\$",
                    sol("$(a)^2 + b^2 = $(c)^2"),
                    sol("$(a^2) + b^2 = $(c^2)"),
                    sol("b^2 = $(c^2) - $(a^2) = $b_squared"),
                    sol("b = $ans")
                ),
                image=render(d),
                time=90
            )
        else
            ans_simplified = sqrt(b_squared)
            problem(
                question="Find the exact length of side b in the right triangle shown. Simplify your answer.",
                answer=ans_simplified,
                difficulty=(1300, 1500),
                solution=steps(
                    "Apply the Pythagorean theorem: \$a^2 + b^2 = c^2\$",
                    sol("$(a)^2 + b^2 = $(c)^2"),
                    sol("b^2 = $(c^2) - $(a^2) = $b_squared"),
                    sol("b = \\sqrt{$b_squared}")
                ),
                image=render(d),
                time=90
            )
        end
        
    elseif problem_type == 3
        # Pythagorean triple with scaling
        scale = randint(2, 5)
        base_triple = choice([(3, 4, 5), (5, 12, 13), (8, 15, 17), (7, 24, 25)])
        a = scale * base_triple[1]
        b = scale * base_triple[2]
        c = scale * base_triple[3]
        
        d = DiagramObj(width=320, height=260)
        polygon!(d, [(50, 220), (270, 220), (270, 80)], :none, "black", 2)
        right_angle!(d, (270, 220), (270, 80), (50, 220), 15)
        segment_label!(d, (50, 220), (270, 220), "$a", :below)
        segment_label!(d, (270, 220), (270, 80), "$b", :right)
        segment_label!(d, (50, 220), (270, 80), "x", :above_left)
        
        problem(
            question="Find the value of x in the right triangle shown.",
            answer=c,
            difficulty=(1200, 1400),
            solution=steps(
                "Apply the Pythagorean theorem: \$x^2 = $(a)^2 + $(b)^2\$",
                sol("x^2 = $(a^2) + $(b^2) = $(a^2 + b^2)"),
                sol("x = \\sqrt{$(a^2 + b^2)} = $c")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 4
        # Distance between two points (coordinate geometry)
        x1 = randint(-8, 8)
        y1 = randint(-8, 8)
        x2 = randint(-8, 8)
        y2 = randint(-8, 8)
        while x1 == x2 && y1 == y2
            x2 = randint(-8, 8)
            y2 = randint(-8, 8)
        end
        
        dist_squared = (x2 - x1)^2 + (y2 - y1)^2
        dist = sqrt(dist_squared)
        
        d = DiagramObj(width=350, height=350)
        
        scale = 18
        ox, oy = 175, 175
        
        # Grid lines
        for i in -9:9
            line!(d, (ox + i*scale, 50), (ox + i*scale, 300), "lightgray", 0.5)
            line!(d, (50, oy - i*scale), (300, oy - i*scale), "lightgray", 0.5)
        end
        
        # Axes
        arrow!(d, (50, oy), (310, oy), "black", 1.5)
        arrow!(d, (ox, 300), (ox, 40), "black", 1.5)
        
        # Points
        point!(d, (ox + x1*scale, oy - y1*scale), "A($(x1),$(y1))", :above, "blue")
        point!(d, (ox + x2*scale, oy - y2*scale), "B($(x2),$(y2))", :above, "blue")
        
        # Line segment
        line!(d, (ox + x1*scale, oy - y1*scale), (ox + x2*scale, oy - y2*scale), "blue", 2)
        
        if dist == floor(dist)
            ans = Int(dist)
            problem(
                question="Find the distance between points A($(x1), $(y1)) and B($(x2), $(y2)).",
                answer=ans,
                difficulty=(1300, 1500),
                solution=steps(
                    "Use the distance formula: \$d = \\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2}\$",
                    sol("d = \\sqrt{($(x2)-$(x1))^2 + ($(y2)-$(y1))^2}"),
                    sol("d = \\sqrt{$(x2-x1)^2 + $(y2-y1)^2} = \\sqrt{$((x2-x1)^2) + $((y2-y1)^2)} = \\sqrt{$dist_squared}"),
                    sol("d = $ans")
                ),
                image=render(d),
                calculator="scientific",
                time=120
            )
        else
            ans = sqrt(dist_squared)
            problem(
                question="Find the exact distance between points A($(x1), $(y1)) and B($(x2), $(y2)). Simplify your answer.",
                answer=ans,
                difficulty=(1400, 1600),
                solution=steps(
                    "Use the distance formula: \$d = \\sqrt{(x_2-x_1)^2 + (y_2-y_1)^2}\$",
                    sol("d = \\sqrt{($(x2)-$(x1))^2 + ($(y2)-$(y1))^2}"),
                    sol("d = \\sqrt{$(x2-x1)^2 + $(y2-y1)^2} = \\sqrt{$((x2-x1)^2) + $((y2-y1)^2)}"),
                    sol("d = \\sqrt{$dist_squared}")
                ),
                image=render(d),
                time=120
            )
        end
        
    else
        # Word problem: ladder against wall
        ladder = randint(15, 30)
        base = randint(5, ladder - 5)
        height_squared = ladder^2 - base^2
        height = sqrt(height_squared)
        
        d = DiagramObj(width=300, height=300)
        
        # Ground
        line!(d, (30, 250), (280, 250), "brown", 3)
        
        # Wall
        line!(d, (80, 250), (80, 50), "gray", 3)
        
        # Ladder
        line!(d, (80, 250 - min(180, height * 6)), (80 + base * 6, 250), "orange", 4)
        
        # Right angle marker
        right_angle!(d, (80, 250), (80, 250 - min(180, height * 6)), (80 + base * 6, 250), 15)
        
        # Labels
        segment_label!(d, (80, 250), (80 + base * 6, 250), "$(base) ft", :below)
        segment_label!(d, (80, 250), (80, 250 - min(180, height * 6)), "h", :left)
        segment_label!(d, (80, 250 - min(180, height * 6)), (80 + base * 6, 250), "$(ladder) ft", :above_right)
        
        if height == floor(height)
            ans = Int(height)
            problem(
                question="A $(ladder)-foot ladder is leaning against a wall. The base of the ladder is $(base) feet from the wall. How high up the wall does the ladder reach?",
                answer=ans,
                difficulty=(1400, 1600),
                solution=steps(
                    "This forms a right triangle with hypotenuse $(ladder) ft and base $(base) ft",
                    "Apply the Pythagorean theorem: \$h^2 + $(base)^2 = $(ladder)^2\$",
                    sol("h^2 + $(base^2) = $(ladder^2)"),
                    sol("h^2 = $(ladder^2) - $(base^2) = $height_squared"),
                    sol("h = $ans \\text{ feet}")
                ),
                image=render(d),
                time=150
            )
        else
            ans = sqrt(height_squared)
            problem(
                question="A $(ladder)-foot ladder is leaning against a wall. The base of the ladder is $(base) feet from the wall. How high up the wall does the ladder reach? Give your answer in simplified radical form.",
                answer=ans,
                difficulty=(1500, 1700),
                solution=steps(
                    "This forms a right triangle with hypotenuse $(ladder) ft and base $(base) ft",
                    "Apply the Pythagorean theorem: \$h^2 + $(base)^2 = $(ladder)^2\$",
                    sol("h^2 = $(ladder^2) - $(base^2) = $height_squared"),
                    sol("h = \\sqrt{$height_squared} \\text{ feet}")
                ),
                image=render(d),
                time=150
            )
        end
    end
end