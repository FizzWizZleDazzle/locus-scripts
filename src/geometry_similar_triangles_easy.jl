# geometry - similar_triangles (easy)
# Generated: 2026-03-08T20:04:44.229755

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("geometry/similar_triangles")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Basic ratio problem with two similar triangles
        scale = rand(2:5)
        side1 = randint(3, 12)
        side2 = side1 * scale
        unknown_base = randint(4, 15)
        ans = unknown_base * scale
        
        d = DiagramObj(600, 400)
        
        # Small triangle
        polygon!(d, [(50, 300), (150, 300), (100, 200)], fill="lightblue", stroke="blue", stroke_width=2)
        text!(d, 100, 320, "$(side1)", font_size=14)
        text!(d, 25, 250, "$(unknown_base)", font_size=14)
        text!(d, 80, 180, "A", font_size=16)
        text!(d, 30, 310, "B", font_size=16)
        text!(d, 160, 310, "C", font_size=16)
        
        # Large triangle
        polygon!(d, [(300, 300), (300 + side2*10, 300), (300 + side1*10, 300 - unknown_base*10)], fill="lightgreen", stroke="green", stroke_width=2)
        text!(d, 300 + side1*5, 320, "$(side2)", font_size=14)
        text!(d, 270, 250, "x", font_size=16, fill="red")
        text!(d, 300 + side1*10 - 10, 300 - unknown_base*10 - 20, "D", font_size=16)
        text!(d, 280, 310, "E", font_size=16)
        text!(d, 300 + side2*10 + 10, 310, "F", font_size=16)
        
        problem(
            question="Triangle ABC is similar to triangle DEF. If BC = $(side1), EF = $(side2), and AB = $(unknown_base), find DE.",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Since triangles ABC and DEF are similar, corresponding sides are proportional",
                sol("\\frac{BC}{EF} = \\frac{AB}{DE}"),
                sol("\\frac{$(side1)}{$(side2)} = \\frac{$(unknown_base)}{x}"),
                "Cross multiply: $(side1)x = $(side2) \\cdot $(unknown_base) = $(side2 * unknown_base)",
                sol("x = ", ans)
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Shadow problem (classic similar triangles application)
        person_height = randint(150, 200)  # cm
        person_shadow = randint(80, 150)
        tree_shadow = randint(400, 800)
        ans = round(Int, (person_height * tree_shadow) // person_shadow)
        
        d = DiagramObj(700, 400)
        
        # Ground line
        line!(d, 50, 350, 650, 350, stroke="brown", stroke_width=3)
        
        # Person
        line!(d, 100, 350, 100, 350 - person_height/2, stroke="blue", stroke_width=4)
        circle!(d, 100, 350 - person_height/2 - 10, 8, fill="blue")
        
        # Person's shadow
        line!(d, 100, 350, 100 + person_shadow/2, 350, stroke="gray", stroke_width=2, stroke_dasharray="5,5")
        text!(d, 100 + person_shadow/4, 365, "$(person_shadow) cm", font_size=12)
        
        # Person height label
        text!(d, 75, 350 - person_height/4, "$(person_height) cm", font_size=12, fill="blue")
        
        # Tree
        line!(d, 400, 350, 400, 350 - 150, stroke="green", stroke_width=6)
        polygon!(d, [(380, 350 - 140), (420, 350 - 140), (400, 350 - 180)], fill="darkgreen")
        
        # Tree's shadow
        line!(d, 400, 350, 400 + tree_shadow/3, 350, stroke="gray", stroke_width=2, stroke_dasharray="5,5")
        text!(d, 400 + tree_shadow/6, 365, "$(tree_shadow) cm", font_size=12)
        
        # Tree height label
        text!(d, 415, 275, "h = ?", font_size=14, fill="red")
        
        # Sun rays
        line!(d, 100, 350 - person_height/2, 100 + person_shadow/2, 350, stroke="orange", stroke_width=1)
        line!(d, 400, 350 - 150, 400 + tree_shadow/3, 350, stroke="orange", stroke_width=1)
        
        problem(
            question="A person who is $(person_height) cm tall casts a shadow $(person_shadow) cm long. At the same time, a tree casts a shadow $(tree_shadow) cm long. How tall is the tree?",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "The sun creates similar triangles for the person and tree",
                sol("\\frac{\\text{person height}}{\\text{person shadow}} = \\frac{\\text{tree height}}{\\text{tree shadow}}"),
                sol("\\frac{$(person_height)}{$(person_shadow)} = \\frac{h}{$(tree_shadow)}"),
                "Cross multiply: $(person_shadow)h = $(person_height) \\cdot $(tree_shadow) = $(person_height * tree_shadow)",
                sol("h = ", ans, " \\text{ cm}")
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 3
        # Two triangles sharing a vertex with parallel sides
        small_side = randint(4, 10)
        large_side = randint(15, 25)
        small_height = randint(6, 12)
        ans = round(Int, (small_height * large_side) // small_side)
        
        d = DiagramObj(500, 500)
        
        # Large triangle
        polygon!(d, [(250, 400), (100, 100), (400, 100)], fill="none", stroke="blue", stroke_width=2)
        
        # Small triangle (similar, sharing top vertex)
        small_base_center = 250
        small_left = small_base_center - small_side * 10
        small_right = small_base_center + small_side * 10
        small_base_y = 400 - small_height * 10
        polygon!(d, [(small_base_center, 400), (small_left, small_base_y), (small_right, small_base_y)], fill="lightgreen", stroke="green", stroke_width=2)
        
        # Parallel marks
        tick_marks!(d, small_left, small_base_y, small_right, small_base_y, n=2)
        tick_marks!(d, 100, 100, 400, 100, n=2)
        
        # Labels
        text!(d, small_base_center - small_side * 5, small_base_y - 15, "$(small_side)", font_size=14)
        text!(d, 245, 100 - 15, "$(large_side)", font_size=14)
        text!(d, 260, 400 - small_height * 5, "$(small_height)", font_size=14)
        text!(d, 260, 250, "x", font_size=16, fill="red")
        
        problem(
            question="In the diagram, the two horizontal segments are parallel. If the smaller base is $(small_side) units, the larger base is $(large_side) units, and the height to the smaller base is $(small_height) units, find the total height x.",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                "Parallel lines create similar triangles",
                sol("\\frac{$(small_side)}{$(large_side)} = \\frac{$(small_height)}{x}"),
                "Cross multiply: $(small_side)x = $(large_side) \\cdot $(small_height) = $(large_side * small_height)",
                sol("x = ", ans)
            ),
            image=render(d),
            time=100
        )
        
    else
        # Finding missing side using similarity ratio
        side_a1 = randint(5, 12)
        side_b1 = randint(6, 14)
        ratio_num = randint(2, 4)
        ratio_den = randint(3, 6)
        while ratio_num >= ratio_den
            ratio_num = randint(2, 4)
            ratio_den = randint(3, 6)
        end
        
        side_a2 = round(Int, (side_a1 * ratio_den) // ratio_num)
        ans = round(Int, (side_b1 * ratio_den) // ratio_num)
        
        d = DiagramObj(600, 400)
        
        # First triangle
        polygon!(d, [(50, 300), (200, 300), (125, 150)], fill="lightblue", stroke="blue", stroke_width=2)
        text!(d, 125, 320, "$(side_a1)", font_size=14)
        text!(d, 30, 225, "$(side_b1)", font_size=14)
        text!(d, 110, 130, "P", font_size=16)
        text!(d, 30, 310, "Q", font_size=16)
        text!(d, 210, 310, "R", font_size=16)
        
        # Second triangle
        polygon!(d, [(300, 300), (520, 300), (410, 100)], fill="lightgreen", stroke="green", stroke_width=2)
        text!(d, 410, 320, "$(side_a2)", font_size=14)
        text!(d, 270, 200, "x", font_size=16, fill="red")
        text!(d, 395, 80, "S", font_size=16)
        text!(d, 280, 310, "T", font_size=16)
        text!(d, 530, 310, "U", font_size=16)
        
        problem(
            question="Triangle PQR is similar to triangle STU. If QR = $(side_a1), PQ = $(side_b1), and TU = $(side_a2), find ST.",
            answer=ans,
            difficulty=(700, 1000),
            solution=steps(
                "Since the triangles are similar, corresponding sides are proportional",
                sol("\\frac{QR}{TU} = \\frac{PQ}{ST}"),
                sol("\\frac{$(side_a1)}{$(side_a2)} = \\frac{$(side_b1)}{x}"),
                "Cross multiply: $(side_a1)x = $(side_a2) \\cdot $(side_b1) = $(side_a2 * side_b1)",
                sol("x = ", ans)
            ),
            image=render(d),
            time=90
        )
    end
end