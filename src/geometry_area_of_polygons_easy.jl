# geometry - area_of_polygons (easy)
# Generated: 2026-03-08T20:07:35.494051

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/area_of_polygons")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Rectangle area - ELO 700-900
        width = randint(3, 15)
        height = randint(3, 15)
        area = width * height
        
        d = DiagramObj(grid=false, width=400, height=300)
        polygon!(d, [0, width, width, 0], [0, 0, height, height], fill="lightblue", stroke="black", stroke_width=2)
        segment_label!(d, 0, 0, width, 0, "$(width)", :below)
        segment_label!(d, width, 0, width, height, "$(height)", :right)
        right_angle!(d, width, 0, 10)
        
        problem(
            question="Find the area of the rectangle shown in the diagram.",
            answer=area,
            difficulty=(700, 900),
            solution=steps(
                "The area of a rectangle is length × width",
                sol("A = $(width) × $(height)"),
                sol("Area", area)
            ),
            time=60,
            image=render(d)
        )
        
    elseif problem_type == 2
        # Triangle area - ELO 800-1000
        base = randint(4, 20)
        height = randint(4, 18)
        area = (base * height) // 2
        
        d = DiagramObj(grid=false, width=400, height=300)
        polygon!(d, [0, base, base//2], [0, 0, height], fill="lightgreen", stroke="black", stroke_width=2)
        line!(d, base, 0, base, height, stroke="blue", stroke_width=1, stroke_dasharray="5,5")
        segment_label!(d, 0, 0, base, 0, "$(base)", :below)
        segment_label!(d, base, 0, base, height, "$(height)", :right)
        right_angle!(d, base, 0, 8)
        
        problem(
            question="Find the area of the triangle shown in the diagram.",
            answer=area,
            difficulty=(800, 1000),
            solution=steps(
                "The area of a triangle is \\frac{1}{2} × base × height",
                sol("A = \\frac{1}{2} × $(base) × $(height)"),
                sol("Area", area)
            ),
            time=75,
            image=render(d)
        )
        
    elseif problem_type == 3
        # Parallelogram area - ELO 900-1100
        base = randint(5, 18)
        height = randint(4, 14)
        slant = height + randint(2, 6)
        area = base * height
        
        d = DiagramObj(grid=false, width=400, height=300)
        offset = randint(2, 5)
        polygon!(d, [0, base, base+offset, offset], [0, 0, height, height], fill="lightyellow", stroke="black", stroke_width=2)
        line!(d, base, 0, base, height, stroke="blue", stroke_width=1, stroke_dasharray="5,5")
        segment_label!(d, 0, 0, base, 0, "$(base)", :below)
        segment_label!(d, base, 0, base, height, "$(height)", :right)
        right_angle!(d, base, 0, 8)
        
        problem(
            question="Find the area of the parallelogram shown in the diagram.",
            answer=area,
            difficulty=(900, 1100),
            solution=steps(
                "The area of a parallelogram is base × height",
                "Use the perpendicular height, not the slant side",
                sol("A = $(base) × $(height)"),
                sol("Area", area)
            ),
            time=90,
            image=render(d)
        )
        
    else
        # Trapezoid area - ELO 1000-1200
        base1 = randint(6, 16)
        base2 = randint(8, 20)
        if base1 > base2
            base1, base2 = base2, base1
        end
        height = randint(5, 12)
        area = ((base1 + base2) * height) // 2
        
        d = DiagramObj(grid=false, width=400, height=300)
        offset = (base2 - base1) // 2
        polygon!(d, [offset, offset+base1, base2, 0], [height, height, 0, 0], fill="lightcoral", stroke="black", stroke_width=2)
        line!(d, offset, height, offset, 0, stroke="blue", stroke_width=1, stroke_dasharray="5,5")
        segment_label!(d, 0, 0, base2, 0, "$(base2)", :below)
        segment_label!(d, offset, height, offset+base1, height, "$(base1)", :above)
        segment_label!(d, offset, 0, offset, height, "$(height)", :left)
        right_angle!(d, offset, 0, 8)
        
        problem(
            question="Find the area of the trapezoid shown in the diagram.",
            answer=area,
            difficulty=(1000, 1200),
            solution=steps(
                "The area of a trapezoid is \\frac{1}{2}(b_1 + b_2) × h",
                "The parallel sides are $(base1) and $(base2), height is $(height)",
                sol("A = \\frac{1}{2}($(base1) + $(base2)) × $(height)"),
                sol("A = \\frac{1}{2}($(base1 + base2)) × $(height)"),
                sol("Area", area)
            ),
            time=120,
            image=render(d)
        )
    end
end