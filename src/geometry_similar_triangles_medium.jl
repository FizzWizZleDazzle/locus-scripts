# geometry - similar_triangles (medium)
# Generated: 2026-03-08T20:04:50.743904

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("geometry/similar_triangles")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Basic similar triangles with side ratios (1200-1400)
        k = choice([2, 3, 4, 5])  # scale factor
        a = randint(3, 12)
        b = randint(3, 12)
        c = randint(3, 12)
        
        known_side = a
        corresponding_side = k * a
        unknown = k * b
        
        d = DiagramObj(600, 400)
        
        # First triangle (smaller)
        polygon!(d, [(50, 300), (200, 300), (200, 150)], :none, :black, 2)
        text!(d, 125, 320, "$(a)", 14)
        text!(d, 220, 225, "$(b)", 14)
        text!(d, 115, 215, "$(c)", 14)
        text!(d, 125, 130, "△ABC", 16)
        
        # Second triangle (larger)
        polygon!(d, [(300, 300), (550, 300), (550, 50)], :none, :blue, 2)
        text!(d, 425, 320, "$(corresponding_side)", 14)
        text!(d, 570, 175, "?", 14)
        text!(d, 415, 150, "$(k*c)", 14)
        text!(d, 425, 30, "△DEF", 16)
        
        text!(d, 300, 50, "△ABC ~ △DEF", 18)
        
        problem(
            question="Triangles ABC and DEF are similar. In △ABC, side AB = $(a) and BC = $(b). In △DEF, the side corresponding to AB is $(corresponding_side). Find the length of the side in △DEF that corresponds to BC.",
            answer=unknown,
            difficulty=(1200, 1400),
            solution=steps(
                "Given: △ABC ~ △DEF",
                sol("Scale factor", corresponding_side // known_side),
                "The ratio of corresponding sides is $(k):1",
                sol("Unknown side", "$(b) \\times $(k) = $(unknown)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Similar triangles with algebra (1300-1500)
        k = choice([2, 3, 4])
        base_val = randint(4, 10)
        
        side1 = base_val
        side2 = k * base_val
        side3 = randint(5, 15)
        unknown_expr = k * side3
        
        d = DiagramObj(600, 400)
        
        # First triangle
        polygon!(d, [(50, 300), (200, 300), (150, 150)], :none, :black, 2)
        text!(d, 125, 320, "$(side1)", 14)
        text!(d, 100, 215, "$(side3)", 14)
        text!(d, 175, 215, "x", 14)
        
        # Second triangle
        polygon!(d, [(300, 300), (550, 300), (450, 50)], :none, :blue, 2)
        text!(d, 425, 320, "$(side2)", 14)
        text!(d, 355, 165, "y", 14)
        text!(d, 500, 165, "z", 14)
        
        text!(d, 300, 30, "The triangles are similar", 16)
        
        problem(
            question="Two similar triangles have corresponding sides in the ratio $(side1):$(side2). If one side of the smaller triangle is $(side3), what is the length of the corresponding side in the larger triangle?",
            answer=unknown_expr,
            difficulty=(1300, 1500),
            solution=steps(
                "Set up ratio of corresponding sides",
                sol("\\frac{\\text{small}}{\\text{large}}", "\\frac{$(side1)}{$(side2)} = \\frac{$(side3)}{x}"),
                "Cross multiply: $(side1)x = $(side2) \\cdot $(side3)",
                sol("x", "\\frac{$(side2 * side3)}{$(side1)} = $(unknown_expr)")
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 3
        # Triangles within triangles (parallel lines) (1400-1600)
        small_base = randint(4, 8)
        large_base = randint(12, 20)
        height_small = randint(3, 7)
        
        ratio = large_base // small_base
        height_large = height_small * ratio
        
        d = DiagramObj(600, 500)
        
        # Large triangle
        polygon!(d, [(100, 400), (500, 400), (300, 100)], :none, :black, 2)
        
        # Parallel line creating small triangle
        small_width = 200
        y_parallel = 250
        left_x = 200
        right_x = 400
        
        line!(d, left_x, y_parallel, right_x, y_parallel, :blue, 2)
        line!(d, 100, 400, left_x, y_parallel, :black, 2)
        line!(d, 500, 400, right_x, y_parallel, :black, 2)
        
        # Labels
        text!(d, 300, 420, "$(large_base)", 14)
        text!(d, 300, 240, "$(small_base)", 14)
        text!(d, 80, 325, "$(height_large)", 14)
        text!(d, 180, 325, "?", 14)
        
        text!(d, 300, 80, "DE ∥ BC", 16)
        
        problem(
            question="In triangle ABC, line segment DE is parallel to BC. If BC = $(large_base), DE = $(small_base), and the distance from A to DE is $(height_small), find the total distance from A to BC.",
            answer=height_large,
            difficulty=(1400, 1600),
            solution=steps(
                "Since DE ∥ BC, triangles ADE and ABC are similar",
                sol("\\frac{DE}{BC}", "\\frac{$(small_base)}{$(large_base)} = \\frac{1}{$(ratio)}"),
                "The ratio of heights equals the ratio of corresponding sides",
                sol("\\text{Total height}", "$(height_small) \\times $(ratio) = $(height_large)")
            ),
            image=render(d),
            time=150
        )
        
    else
        # Shadow problem or real-world application (1500-1800)
        person_height = choice([150, 160, 170, 180])  # cm
        person_shadow = randint(80, 150)
        tree_shadow = randint(400, 800)
        
        tree_height = (person_height * tree_shadow) // person_shadow
        
        d = DiagramObj(700, 400)
        
        # Sun rays
        line!(d, 50, 50, 650, 350, :orange, 2, :dashed)
        
        # Person (small triangle)
        line!(d, 150, 350, 150, 350 - 60, :black, 3)
        line!(d, 150, 350, 150 + 40, 350, :gray, 2)
        polygon!(d, [(150, 350), (150 + 40, 350), (150, 350 - 60)], :none, :black, 1, :dashed)
        text!(d, 130, 320, "$(person_height) cm", 12)
        text!(d, 170, 365, "$(person_shadow) cm", 12)
        
        # Tree (large triangle)
        line!(d, 450, 350, 450, 350 - 180, :brown, 5)
        line!(d, 450, 350, 450 + 120, 350, :gray, 2)
        polygon!(d, [(450, 350), (450 + 120, 350), (450, 350 - 180)], :none, :black, 1, :dashed)
        text!(d, 480, 365, "$(tree_shadow) cm", 12)
        text!(d, 420, 260, "?", 14)
        
        text!(d, 300, 30, "Similar triangles (same sun angle)", 16)
        
        problem(
            question="A person who is $(person_height) cm tall casts a shadow that is $(person_shadow) cm long. At the same time, a tree casts a shadow that is $(tree_shadow) cm long. How tall is the tree?",
            answer=tree_height,
            difficulty=(1500, 1800),
            solution=steps(
                "Set up proportion using similar triangles",
                sol("\\frac{\\text{person height}}{\\text{person shadow}}", "\\frac{$(person_height)}{$(person_shadow)} = \\frac{h}{$(tree_shadow)}"),
                "Cross multiply and solve",
                sol("h", "\\frac{$(person_height) \\times $(tree_shadow)}{$(person_shadow)} = $(tree_height) \\text{ cm}")
            ),
            image=render(d),
            time=180
        )
    end
end