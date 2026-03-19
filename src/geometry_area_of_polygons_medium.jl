# geometry - area_of_polygons (medium)
# Generated: 2026-03-08T20:07:58.285949

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/area_of_polygons")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Rectangle with diagonal - find area
        width = randint(5, 15)
        height = randint(5, 15)
        area = width * height
        diagonal = sqrt(width^2 + height^2)
        
        d = DiagramObj(600, 400)
        polygon!(d, [(50, 50), (50 + 30*width, 50), (50 + 30*width, 50 + 30*height), (50, 50 + 30*height)], 
                 fill="lightblue", stroke="black", stroke_width=2)
        line!(d, 50, 50, 50 + 30*width, 50 + 30*height, stroke="red", stroke_width=2, dash="5,5")
        segment_label!(d, 50, 50 - 20, 50 + 30*width, 50 - 20, "$(width)", position=:above)
        segment_label!(d, 50 + 30*width + 20, 50, 50 + 30*width + 20, 50 + 30*height, "$(height)", position=:right)
        text!(d, (50 + 30*width)/2, (50 + 30*height)/2 + 20, "d = $(round(diagonal, digits=2))", font_size=14)
        
        problem(
            question="A rectangle has a diagonal of length \$$(round(diagonal, digits=2))\$ units. If the width is \$$(width)\$ units and the height is \$$(height)\$ units, find the area of the rectangle.",
            answer=area,
            difficulty=(1200, 1400),
            solution=steps(
                "Given: width = $(width), height = $(height)",
                sol("Area formula", "A = width × height"),
                sol("Calculate", "A = $(width) × $(height) = $(area)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Trapezoid area
        base1 = randint(8, 18)
        base2 = randint(5, base1 - 2)
        height = randint(6, 14)
        area = (base1 + base2) * height // 2
        
        d = DiagramObj(600, 400)
        offset = 30
        polygon!(d, [(50, 50 + 20*height), (50 + 20*base1, 50 + 20*height), 
                     (50 + 20*base1 - offset, 50), (50 + offset, 50)],
                 fill="lightgreen", stroke="black", stroke_width=2)
        segment_label!(d, 50, 50 + 20*height + 15, 50 + 20*base1, 50 + 20*height + 15, "$(base1)", position=:below)
        segment_label!(d, 50 + offset, 50 - 15, 50 + 20*base1 - offset, 50 - 15, "$(base2)", position=:above)
        line!(d, 50 + 20*base1 + 30, 50, 50 + 20*base1 + 30, 50 + 20*height, stroke="red", stroke_width=1, dash="3,3")
        segment_label!(d, 50 + 20*base1 + 35, 50, 50 + 20*base1 + 35, 50 + 20*height, "h = $(height)", position=:right)
        
        problem(
            question="Find the area of a trapezoid with parallel sides of length \$$(base1)\$ units and \$$(base2)\$ units, and a height of \$$(height)\$ units.",
            answer=area,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Trapezoid area formula", "A = \\frac{1}{2}(b_1 + b_2)h"),
                sol("Substitute values", "A = \\frac{1}{2}($(base1) + $(base2))($(height))"),
                sol("Calculate", "A = \\frac{1}{2}($(base1 + base2))($(height)) = $(area)")
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 3
        # Parallelogram with side and height
        base = randint(10, 20)
        side = randint(8, 15)
        height = randint(6, min(side - 1, 12))
        area = base * height
        
        d = DiagramObj(600, 400)
        offset = 40
        polygon!(d, [(50, 50 + 20*height), (50 + 20*base, 50 + 20*height), 
                     (50 + 20*base + offset, 50), (50 + offset, 50)],
                 fill="lightyellow", stroke="black", stroke_width=2)
        line!(d, 50 + offset, 50, 50 + offset, 50 + 20*height, stroke="red", stroke_width=2, dash="4,4")
        segment_label!(d, 50, 50 + 20*height + 15, 50 + 20*base, 50 + 20*height + 15, "$(base)", position=:below)
        segment_label!(d, 50 + offset + 5, 50, 50 + offset + 5, 50 + 20*height, "h = $(height)", position=:right)
        segment_label!(d, 50 + offset - 15, 50 - 10, 50 - 15, 50 + 20*height - 10, "$(side)", position=:left)
        
        problem(
            question="A parallelogram has a base of \$$(base)\$ units, a side length of \$$(side)\$ units, and a perpendicular height of \$$(height)\$ units. Find the area of the parallelogram.",
            answer=area,
            difficulty=(1200, 1400),
            solution=steps(
                "The area of a parallelogram is base × height",
                sol("Formula", "A = b \\times h"),
                sol("Substitute", "A = $(base) \\times $(height) = $(area)")
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 4
        # Composite figure: rectangle with triangle on top
        rect_width = randint(10, 18)
        rect_height = randint(8, 14)
        tri_height = randint(5, 10)
        
        rect_area = rect_width * rect_height
        tri_area = rect_width * tri_height // 2
        total_area = rect_area + tri_area
        
        d = DiagramObj(600, 450)
        polygon!(d, [(50, 50 + 20*rect_height), (50 + 20*rect_width, 50 + 20*rect_height), 
                     (50 + 20*rect_width, 50), (50, 50)],
                 fill="lightblue", stroke="black", stroke_width=2)
        polygon!(d, [(50, 50), (50 + 20*rect_width, 50), (50 + 10*rect_width, 50 - 20*tri_height)],
                 fill="lightcoral", stroke="black", stroke_width=2)
        segment_label!(d, 50, 50 + 20*rect_height + 15, 50 + 20*rect_width, 50 + 20*rect_height + 15, "$(rect_width)", position=:below)
        segment_label!(d, 50 - 20, 50, 50 - 20, 50 + 20*rect_height, "$(rect_height)", position=:left)
        segment_label!(d, 50 + 20*rect_width + 20, 50 - 20*tri_height, 50 + 20*rect_width + 20, 50, "$(tri_height)", position=:right)
        
        problem(
            question="A figure consists of a rectangle with width \$$(rect_width)\$ units and height \$$(rect_height)\$ units, topped by a triangle with the same base and height \$$(tri_height)\$ units. Find the total area of the figure.",
            answer=total_area,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Rectangle area", "A_1 = $(rect_width) \\times $(rect_height) = $(rect_area)"),
                sol("Triangle area", "A_2 = \\frac{1}{2} \\times $(rect_width) \\times $(tri_height) = $(tri_area)"),
                sol("Total area", "A = $(rect_area) + $(tri_area) = $(total_area)")
            ),
            image=render(d),
            time=150
        )
        
    else
        # Regular hexagon broken into triangles
        side = randint(6, 12)
        apothem_ratio = sqrt(3) / 2
        apothem = round(side * apothem_ratio, digits=2)
        perimeter = 6 * side
        area = round((perimeter * side * apothem_ratio) / 2, digits=2)
        
        d = DiagramObj(600, 600)
        cx, cy = 300, 300
        radius = 100
        angles = [60*i for i in 0:5]
        pts = [(cx + radius*cosd(a), cy + radius*sind(a)) for a in angles]
        polygon!(d, pts, fill="lavender", stroke="black", stroke_width=2)
        
        for i in 1:6
            line!(d, cx, cy, pts[i][1], pts[i][2], stroke="gray", stroke_width=1, dash="3,3")
        end
        
        point!(d, cx, cy, color="red", radius=4)
        segment_label!(d, cx, cy + 10, pts[1][1], pts[1][2] + 10, "$(side)", position=:above)
        text!(d, cx - 40, cy, "a = $(apothem)", font_size=12)
        
        problem(
            question="A regular hexagon has side length \$$(side)\$ units. The apothem (perpendicular distance from center to a side) is \$$(apothem)\$ units. Find the area of the hexagon.",
            answer=area,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Perimeter", "P = 6 \\times $(side) = $(perimeter)"),
                sol("Area formula", "A = \\frac{1}{2} \\times P \\times a"),
                sol("Calculate", "A = \\frac{1}{2} \\times $(perimeter) \\times $(apothem) = $(area)")
            ),
            image=render(d),
            time=180
        )
    end
end