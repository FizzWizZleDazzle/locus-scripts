# geometry - perimeter (easy)
# Generated: 2026-03-08T20:08:22.955165

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/perimeter")
    
    shape_type = choice(["rectangle", "triangle", "composite"])
    
    if shape_type == "rectangle"
        width = randint(3, 15)
        length = randint(width + 2, 25)
        perimeter = 2 * (width + length)
        
        d = DiagramObj(300, 200)
        polygon!(d, [20, 20, 20 + length * 8, 20 + length * 8, 20], 
                    [20, 20 + width * 8, 20 + width * 8, 20, 20], 
                    fill="lightblue", stroke="black", stroke_width=2)
        segment_label!(d, 20 + length * 4, 15, "$length")
        segment_label!(d, 15, 20 + width * 4, "$width")
        
        problem(
            question="Find the perimeter of the rectangle shown in the diagram.",
            answer=perimeter,
            difficulty=(700, 900),
            solution=steps(
                "Given: width = $width, length = $length",
                sol("Perimeter formula", "P = 2(w + l)"),
                sol("Substitute", "P = 2($width + $length) = 2($(width + length))"),
                sol("Answer", perimeter)
            ),
            image=render(d),
            time=60
        )
        
    elseif shape_type == "triangle"
        side1 = randint(5, 18)
        side2 = randint(5, 18)
        side3 = randint(max(abs(side1 - side2) + 1, 5), min(side1 + side2 - 1, 20))
        perimeter = side1 + side2 + side3
        
        d = DiagramObj(300, 250)
        x1, y1 = 30, 200
        x2, y2 = 250, 200
        x3, y3 = 120, 50
        polygon!(d, [x1, x2, x3, x1], [y1, y2, y3, y1], 
                fill="lightgreen", stroke="black", stroke_width=2)
        segment_label!(d, (x1 + x2) / 2, y1 + 15, "$side1")
        segment_label!(d, (x2 + x3) / 2 + 10, (y2 + y3) / 2, "$side2")
        segment_label!(d, (x1 + x3) / 2 - 15, (y1 + y3) / 2, "$side3")
        
        problem(
            question="Find the perimeter of the triangle shown in the diagram.",
            answer=perimeter,
            difficulty=(700, 850),
            solution=steps(
                "Given: sides are $side1, $side2, and $side3",
                sol("Perimeter formula", "P = a + b + c"),
                sol("Substitute", "P = $side1 + $side2 + $side3"),
                sol("Answer", perimeter)
            ),
            image=render(d),
            time=45
        )
        
    else  # composite
        rect_width = randint(4, 12)
        rect_height = randint(6, 14)
        cut_width = randint(2, rect_width - 1)
        cut_height = randint(2, rect_height - 1)
        
        perimeter = 2 * rect_width + 2 * rect_height + 2 * cut_width + 2 * cut_height
        
        d = DiagramObj(320, 280)
        scale = 12
        x_base = 30
        y_base = 30
        
        outer_pts_x = [x_base, x_base + rect_width * scale, x_base + rect_width * scale, 
                       x_base + cut_width * scale, x_base + cut_width * scale, x_base, x_base]
        outer_pts_y = [y_base, y_base, y_base + cut_height * scale, y_base + cut_height * scale,
                       y_base + rect_height * scale, y_base + rect_height * scale, y_base]
        
        polygon!(d, outer_pts_x, outer_pts_y, fill="lightyellow", stroke="black", stroke_width=2)
        
        segment_label!(d, x_base + rect_width * scale / 2, y_base - 10, "$rect_width")
        segment_label!(d, x_base - 15, y_base + rect_height * scale / 2, "$rect_height")
        segment_label!(d, x_base + cut_width * scale / 2, y_base + cut_height * scale + 10, "$cut_width")
        segment_label!(d, x_base + cut_width * scale + 15, y_base + (cut_height + rect_height) * scale / 2, "$cut_height")
        
        problem(
            question="Find the perimeter of the L-shaped figure shown in the diagram. The outer dimensions are $rect_width by $rect_height, with a rectangular piece of size $cut_width by $cut_height removed from the upper-right corner.",
            answer=perimeter,
            difficulty=(900, 1200),
            solution=steps(
                "The perimeter includes all outer edges",
                "Count edges: bottom = $rect_width, right side parts = $cut_height + $(rect_height - cut_height), top parts = $(rect_width - cut_width) + $cut_width, inner edges = $cut_height + $cut_width, left = $rect_height",
                sol("Sum all edges", "$rect_width + $rect_height + $(rect_width - cut_width) + $cut_height + $cut_width + $(rect_height - cut_height)"),
                sol("Simplify", "2($rect_width) + 2($rect_height) + 2($cut_width) + 2($cut_height) = $perimeter"),
                sol("Answer", perimeter)
            ),
            image=render(d),
            time=120
        )
    end
end