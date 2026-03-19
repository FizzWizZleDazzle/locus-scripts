# geometry - pythagorean_theorem (easy)
# Generated: 2026-03-08T20:11:10.984024

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("geometry/pythagorean_theorem")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Find hypotenuse given two legs
        a = randint(3, 12)
        b = randint(3, 12)
        c = sqrt(a^2 + b^2)
        
        d = DiagramObj(400, 300)
        polygon!(d, [50, 250], [350, 250], [50, 250-b*15], fill="lightblue", stroke="black", stroke_width=2)
        right_angle!(d, [50, 250], [350, 250], [50, 250-b*15], size=15)
        segment_label!(d, [50, 250], [350, 250], "$a", position=:below)
        segment_label!(d, [50, 250], [50, 250-b*15], "$b", position=:left)
        segment_label!(d, [350, 250], [50, 250-b*15], "c", position=:right)
        
        if c == floor(c)
            ans = Int(c)
        else
            ans = c
        end
        
        problem(
            question="Find the length of the hypotenuse \\(c\\) of the right triangle shown.",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Use the Pythagorean theorem: \$c^2 = a^2 + b^2\$",
                sol("Substitute", "c^2 = $(a)^2 + $(b)^2 = $(a^2) + $(b^2) = $(a^2 + b^2)"),
                sol("Take square root", "c = \\sqrt{$(a^2 + b^2)} = $(ans)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Find a leg given hypotenuse and other leg
        b = randint(3, 10)
        c = randint(b+1, 15)
        a = sqrt(c^2 - b^2)
        
        d = DiagramObj(400, 300)
        polygon!(d, [50, 250], [350, 250], [50, 100], fill="lightcoral", stroke="black", stroke_width=2)
        right_angle!(d, [50, 250], [350, 250], [50, 100], size=15)
        segment_label!(d, [50, 250], [350, 250], "a", position=:below)
        segment_label!(d, [50, 250], [50, 100], "$b", position=:left)
        segment_label!(d, [350, 250], [50, 100], "$c", position=:right)
        
        if a == floor(a)
            ans = Int(a)
        else
            ans = a
        end
        
        problem(
            question="Find the length of side \\(a\\) of the right triangle shown.",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Use the Pythagorean theorem: \$a^2 + b^2 = c^2\$",
                sol("Substitute", "a^2 + $(b)^2 = $(c)^2"),
                sol("Solve", "a^2 = $(c^2) - $(b^2) = $(c^2 - b^2)"),
                sol("Take square root", "a = \\sqrt{$(c^2 - b^2)} = $(ans)")
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 3
        # Pythagorean triple recognition
        scale = randint(1, 4)
        base_triples = [[3, 4, 5], [5, 12, 13], [8, 15, 17], [7, 24, 25]]
        triple = choice(base_triples)
        a, b, c = triple[1] * scale, triple[2] * scale, triple[3] * scale
        
        d = DiagramObj(400, 300)
        polygon!(d, [50, 250], [300, 250], [50, 120], fill="lightgreen", stroke="black", stroke_width=2)
        right_angle!(d, [50, 250], [300, 250], [50, 120], size=15)
        segment_label!(d, [50, 250], [300, 250], "$a", position=:below)
        segment_label!(d, [50, 250], [50, 120], "$b", position=:left)
        segment_label!(d, [300, 250], [50, 120], "$c", position=:right)
        
        problem(
            question="Verify whether the triangle shown with sides \\(a = $a\\), \\(b = $b\\), and \\(c = $c\\) is a right triangle. Answer 'yes' or 'no'.",
            answer="yes",
            difficulty=(700, 900),
            solution=steps(
                "Check if \$a^2 + b^2 = c^2\$",
                sol("Calculate", "$(a)^2 + $(b)^2 = $(a^2) + $(b^2) = $(a^2 + b^2)"),
                sol("Compare", "$(c)^2 = $(c^2)"),
                "Since \$$(a^2 + b^2) = $(c^2)\$, the triangle is a right triangle."
            ),
            image=render(d),
            time=90
        )
        
    else
        # Word problem: ladder against wall
        ladder = randint(10, 25)
        base = randint(5, ladder - 3)
        height = sqrt(ladder^2 - base^2)
        
        d = DiagramObj(400, 350)
        line!(d, [50, 300], [350, 300], stroke="brown", stroke_width=4)
        line!(d, [80, 300], [80, 50], stroke="gray", stroke_width=4)
        line!(d, [80, 300-height*3], [80 + base*8, 300], stroke="red", stroke_width=3)
        right_angle!(d, [80, 300], [80 + base*8, 300], [80, 300-height*3], size=15)
        segment_label!(d, [80, 300], [80 + base*8, 300], "$base ft", position=:below)
        segment_label!(d, [80, 300-height*3], [80 + base*8, 300], "$ladder ft", position=:right)
        segment_label!(d, [80, 300], [80, 300-height*3], "h", position=:left)
        text!(d, 200, 30, "Wall", font_size=16)
        text!(d, 200, 330, "Ground", font_size=16)
        
        if height == floor(height)
            ans = Int(height)
        else
            ans = round(height, digits=2)
        end
        
        problem(
            question="A $ladder-foot ladder is leaning against a wall. The base of the ladder is $base feet from the wall. How high up the wall does the ladder reach? Round to the nearest hundredth if necessary.",
            answer=ans,
            difficulty=(900, 1200),
            solution=steps(
                "Use the Pythagorean theorem with ladder as hypotenuse: \$h^2 + $(base)^2 = $(ladder)^2\$",
                sol("Solve for h²", "h^2 = $(ladder)^2 - $(base)^2 = $(ladder^2) - $(base^2) = $(ladder^2 - base^2)"),
                sol("Take square root", "h = \\sqrt{$(ladder^2 - base^2)} \\approx $(ans) \\text{ feet}")
            ),
            image=render(d),
            time=150
        )
    end
end