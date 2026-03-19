# geometry - similar_triangles (very_easy)
# Generated: 2026-03-08T20:04:23.004294

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/similar_triangles")
    
    # Pick problem type randomly
    prob_type = choice(["identify_similar", "find_ratio", "find_missing_side", "basic_proportion"])
    
    if prob_type == "identify_similar"
        # ELO 200-400: Identify if triangles are similar by looking at angles
        angle1 = randint(30, 80)
        angle2 = randint(40, 90)
        angle3 = 180 - angle1 - angle2
        
        # Second triangle has same angles in different order
        use_same = choice([true, false])
        
        d = DiagramObj(600, 400)
        
        # First triangle
        polygon!(d, [(50, 300), (200, 300), (100, 150)], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, 60, 280, "A", fontsize=16)
        text!(d, 210, 280, "B", fontsize=16)
        text!(d, 100, 135, "C", fontsize=16)
        text!(d, 120, 240, "$(angle1)°", fontsize=14)
        text!(d, 160, 280, "$(angle2)°", fontsize=14)
        text!(d, 85, 180, "$(angle3)°", fontsize=14)
        
        # Second triangle
        if use_same
            polygon!(d, [(350, 300), (550, 300), (420, 120)], stroke="red", fill="lightcoral", opacity=0.3)
            text!(d, 360, 280, "D", fontsize=16)
            text!(d, 560, 280, "E", fontsize=16)
            text!(d, 420, 105, "F", fontsize=16)
            text!(d, 390, 220, "$(angle1)°", fontsize=14)
            text!(d, 500, 280, "$(angle2)°", fontsize=14)
            text!(d, 410, 160, "$(angle3)°", fontsize=14)
            ans = "yes"
        else
            new_angle1 = randint(35, 75)
            new_angle2 = randint(45, 95)
            while abs(new_angle1 - angle1) < 10 || abs(new_angle2 - angle2) < 10
                new_angle1 = randint(35, 75)
                new_angle2 = randint(45, 95)
            end
            new_angle3 = 180 - new_angle1 - new_angle2
            
            polygon!(d, [(350, 300), (550, 300), (420, 120)], stroke="red", fill="lightcoral", opacity=0.3)
            text!(d, 360, 280, "D", fontsize=16)
            text!(d, 560, 280, "E", fontsize=16)
            text!(d, 420, 105, "F", fontsize=16)
            text!(d, 390, 220, "$(new_angle1)°", fontsize=14)
            text!(d, 500, 280, "$(new_angle2)°", fontsize=14)
            text!(d, 410, 160, "$(new_angle3)°", fontsize=14)
            ans = "no"
        end
        
        problem(
            question="Are triangle ABC and triangle DEF similar? Answer yes or no.",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Triangle ABC has angles: $(angle1)°, $(angle2)°, $(angle3)°",
                use_same ? "Triangle DEF has angles: $(angle1)°, $(angle2)°, $(angle3)°" : "Triangle DEF has different angles",
                use_same ? "All corresponding angles are equal, so the triangles are similar" : "The angles are different, so the triangles are not similar",
                sol("Answer", ans)
            ),
            image=render(d),
            time=45
        )
        
    elseif prob_type == "find_ratio"
        # ELO 400-600: Find the scale factor between similar triangles
        base1 = randint(3, 8)
        scale = randint(2, 4)
        base2 = base1 * scale
        
        d = DiagramObj(600, 400)
        
        # First triangle (smaller)
        polygon!(d, [(50, 300), (50 + base1 * 30, 300), ((50 + base1 * 30 + 50) / 2, 300 - base1 * 25)], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, 50 + base1 * 15, 320, "$(base1)", fontsize=14, fill="blue")
        text!(d, 30, 280, "Triangle 1", fontsize=12)
        
        # Second triangle (larger)
        polygon!(d, [(300, 300), (300 + base2 * 30, 300), ((300 + base2 * 30 + 300) / 2, 300 - base2 * 25)], stroke="red", fill="lightcoral", opacity=0.3)
        text!(d, 300 + base2 * 15, 320, "$(base2)", fontsize=14, fill="red")
        text!(d, 280, 280, "Triangle 2", fontsize=12)
        
        text!(d, 300, 50, "The triangles are similar", fontsize=16)
        
        problem(
            question="The two triangles shown are similar. What is the scale factor from Triangle 1 to Triangle 2?",
            answer=scale,
            difficulty=(400, 600),
            solution=steps(
                "Triangle 1 has base = $(base1)",
                "Triangle 2 has base = $(base2)",
                "Scale factor = $(base2) ÷ $(base1) = $(scale)",
                sol("Answer", scale)
            ),
            image=render(d),
            time=60
        )
        
    elseif prob_type == "find_missing_side"
        # ELO 500-700: Find missing side in similar triangles
        side1 = randint(4, 10)
        side2 = randint(6, 14)
        scale = randint(2, 3)
        missing = side1 * scale
        known_big = side2 * scale
        
        d = DiagramObj(600, 400)
        
        # Small triangle
        polygon!(d, [(50, 300), (50 + 120, 300), (50 + 60, 200)], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, 100, 320, "$(side1)", fontsize=14, fill="blue")
        text!(d, 30, 250, "$(side2)", fontsize=14, fill="blue")
        text!(d, 120, 240, "?", fontsize=14, fill="red")
        
        # Large triangle
        polygon!(d, [(300, 300), (300 + 240, 300), (300 + 120, 100)], stroke="red", fill="lightcoral", opacity=0.3)
        text!(d, 410, 320, "x", fontsize=14, fill="red")
        text!(d, 270, 200, "$(known_big)", fontsize=14, fill="red")
        
        text!(d, 250, 50, "Similar triangles", fontsize=16)
        
        problem(
            question="The two triangles shown are similar. Find the value of x.",
            answer=missing,
            difficulty=(500, 700),
            solution=steps(
                "Set up proportion: $(side1)/x = $(side2)/$(known_big)",
                "Cross multiply: $(side2) · x = $(side1) · $(known_big)",
                "Solve: x = $(side1 * known_big) ÷ $(side2) = $(missing)",
                sol("Answer", missing)
            ),
            image=render(d),
            time=90
        )
        
    else  # basic_proportion
        # ELO 300-500: Simple proportion with similar triangles
        a = randint(3, 9)
        b = randint(4, 10)
        c = randint(2, 5)
        x = (b * c) // a
        
        d = DiagramObj(600, 350)
        
        # Draw two similar triangles side by side
        polygon!(d, [(50, 280), (180, 280), (115, 150)], stroke="blue", fill="lightblue", opacity=0.3)
        text!(d, 110, 300, "$(a)", fontsize=14)
        text!(d, 30, 220, "$(b)", fontsize=14)
        
        polygon!(d, [(320, 280), (450, 280), (385, 150)], stroke="red", fill="lightcoral", opacity=0.3)
        text!(d, 380, 300, "$(c)", fontsize=14)
        text!(d, 300, 220, "x", fontsize=14, fill="red")
        
        text!(d, 200, 50, "Similar triangles", fontsize=16)
        
        problem(
            question="These triangles are similar. Find x.",
            answer=x,
            difficulty=(300, 500),
            solution=steps(
                "Since triangles are similar, sides are proportional",
                "Set up proportion: $(a)/$(c) = $(b)/x",
                "Cross multiply and solve: x = ($(b) · $(c)) ÷ $(a) = $(x)",
                sol("Answer", x)
            ),
            image=render(d),
            time=75
        )
    end
end