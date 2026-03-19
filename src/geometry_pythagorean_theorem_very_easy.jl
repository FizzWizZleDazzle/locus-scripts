# geometry - pythagorean_theorem (very_easy)
# Generated: 2026-03-08T20:11:05.754952

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/pythagorean_theorem")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Find hypotenuse (100-300 ELO)
        a = randint(3, 12)
        b = randint(3, 12)
        c = sqrt(a^2 + b^2)
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (50, 200-b*15), (50+a*15, 200)], fill="lightblue", stroke="black", stroke_width=2)
        right_angle!(d, (50, 200), (50, 200-b*15), (50+a*15, 200), size=15)
        segment_label!(d, (50, 200), (50, 200-b*15), "$b", :left)
        segment_label!(d, (50, 200), (50+a*15, 200), "$a", :below)
        segment_label!(d, (50, 200-b*15), (50+a*15, 200), "c", :above_right)
        
        problem(
            question="Find the length of the hypotenuse c in the right triangle.",
            answer=c,
            difficulty=(100, 300),
            solution=steps(
                "Use the Pythagorean theorem: \$c^2 = a^2 + b^2\$",
                sol("Substitute", "c^2 = $(a)^2 + $(b)^2 = $(a^2) + $(b^2) = $(a^2 + b^2)"),
                sol("Answer", "c = \\sqrt{$(a^2 + b^2)} = $(c)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Find a leg (200-400 ELO)
        a = randint(5, 15)
        c = randint(a+1, 20)
        b = sqrt(c^2 - a^2)
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (50, 200-b*8), (50+a*8, 200)], fill="lightgreen", stroke="black", stroke_width=2)
        right_angle!(d, (50, 200), (50, 200-b*8), (50+a*8, 200), size=15)
        segment_label!(d, (50, 200), (50, 200-b*8), "b", :left)
        segment_label!(d, (50, 200), (50+a*8, 200), "$a", :below)
        segment_label!(d, (50, 200-b*8), (50+a*8, 200), "$c", :above_right)
        
        problem(
            question="Find the length of the leg b in the right triangle.",
            answer=b,
            difficulty=(200, 400),
            solution=steps(
                "Use the Pythagorean theorem: \$a^2 + b^2 = c^2\$",
                sol("Rearrange", "b^2 = c^2 - a^2 = $(c)^2 - $(a)^2 = $(c^2) - $(a^2) = $(c^2 - a^2)"),
                sol("Answer", "b = \\sqrt{$(c^2 - a^2)} = $(b)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 3
        # Pythagorean triple recognition (300-500 ELO)
        triples = [(3,4,5), (5,12,13), (8,15,17), (7,24,25)]
        scale = randint(1, 3)
        base_triple = choice(triples)
        a, b, c = scale .* base_triple
        
        d = DiagramObj(width=350, height=280)
        polygon!(d, [(50, 220), (50, 220-b*7), (50+a*7, 220)], fill="lightyellow", stroke="black", stroke_width=2)
        right_angle!(d, (50, 220), (50, 220-b*7), (50+a*7, 220), size=15)
        segment_label!(d, (50, 220), (50, 220-b*7), "$b", :left)
        segment_label!(d, (50, 220), (50+a*7, 220), "$a", :below)
        segment_label!(d, (50, 220-b*7), (50+a*7, 220), "$c", :above_right)
        
        problem(
            question="Verify whether this is a right triangle by checking if the Pythagorean theorem holds. What is \$a^2 + b^2\$?",
            answer=a^2 + b^2,
            difficulty=(300, 500),
            solution=steps(
                sol("Calculate \$a^2\$", "$(a)^2 = $(a^2)"),
                sol("Calculate \$b^2\$", "$(b)^2 = $(b^2)"),
                sol("Sum", "a^2 + b^2 = $(a^2) + $(b^2) = $(a^2 + b^2)"),
                "This equals \$c^2 = $(c)^2 = $(c^2)\$, confirming it is a right triangle."
            ),
            image=render(d),
            time=120
        )
        
    else
        # Simple identification (100-200 ELO)
        a = randint(6, 15)
        b = randint(6, 15)
        
        d = DiagramObj(width=300, height=250)
        polygon!(d, [(50, 200), (50, 200-b*10), (50+a*10, 200)], fill="lightcoral", stroke="black", stroke_width=2)
        right_angle!(d, (50, 200), (50, 200-b*10), (50+a*10, 200), size=15)
        segment_label!(d, (50, 200), (50, 200-b*10), "$b", :left)
        segment_label!(d, (50, 200), (50+a*10, 200), "$a", :below)
        
        problem(
            question="In this right triangle, what is \$a^2 + b^2\$?",
            answer=a^2 + b^2,
            difficulty=(100, 200),
            solution=steps(
                sol("Calculate \$a^2\$", "$(a)^2 = $(a^2)"),
                sol("Calculate \$b^2\$", "$(b)^2 = $(b^2)"),
                sol("Answer", "a^2 + b^2 = $(a^2) + $(b^2) = $(a^2 + b^2)")
            ),
            image=render(d),
            time=60
        )
    end
end