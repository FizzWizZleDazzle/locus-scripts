# geometry - perimeter (very_easy)
# Generated: 2026-03-08T20:08:14.038209

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/perimeter")
    
    shape_type = choice([:rectangle, :triangle, :square])
    
    if shape_type == :rectangle
        width = randint(3, 15)
        height = randint(3, 15)
        while height == width
            height = randint(3, 15)
        end
        
        d = DiagramObj(width=400, height=300)
        scale = 20
        x_start = 50
        y_start = 50
        
        polygon!(d, [
            (x_start, y_start),
            (x_start + width * scale, y_start),
            (x_start + width * scale, y_start + height * scale),
            (x_start, y_start + height * scale)
        ], fill="lightblue", stroke="black", stroke_width=2)
        
        text!(d, x_start + width * scale / 2, y_start - 15, "$(width)", font_size=16)
        text!(d, x_start + width * scale + 20, y_start + height * scale / 2, "$(height)", font_size=16)
        
        perimeter = 2 * (width + height)
        
        problem(
            question="Find the perimeter of the rectangle shown in the diagram.",
            answer=perimeter,
            difficulty=(200, 400),
            solution=steps(
                "The perimeter of a rectangle is P = 2(width + height)",
                sol("Substitute values", "P = 2($(width) + $(height))"),
                sol("Answer", perimeter)
            ),
            image=render(d),
            time=45
        )
        
    elseif shape_type == :triangle
        side1 = randint(4, 12)
        side2 = randint(4, 12)
        side3 = randint(4, 12)
        
        while side1 + side2 <= side3 || side1 + side3 <= side2 || side2 + side3 <= side1
            side1 = randint(4, 12)
            side2 = randint(4, 12)
            side3 = randint(4, 12)
        end
        
        d = DiagramObj(width=400, height=300)
        
        x1, y1 = 50, 250
        x2, y2 = 350, 250
        x3, y3 = 150, 80
        
        polygon!(d, [(x1, y1), (x2, y2), (x3, y3)], fill="lightgreen", stroke="black", stroke_width=2)
        
        text!(d, (x1 + x2) / 2, y1 + 20, "$(side1)", font_size=16)
        text!(d, (x2 + x3) / 2 + 20, (y2 + y3) / 2, "$(side2)", font_size=16)
        text!(d, (x1 + x3) / 2 - 20, (y1 + y3) / 2, "$(side3)", font_size=16)
        
        perimeter = side1 + side2 + side3
        
        problem(
            question="Find the perimeter of the triangle shown in the diagram.",
            answer=perimeter,
            difficulty=(150, 350),
            solution=steps(
                "The perimeter of a triangle is the sum of all three sides",
                sol("Add the sides", "P = $(side1) + $(side2) + $(side3)"),
                sol("Answer", perimeter)
            ),
            image=render(d),
            time=40
        )
        
    else  # square
        side = randint(5, 18)
        
        d = DiagramObj(width=400, height=400)
        scale = 15
        x_start = 80
        y_start = 80
        
        polygon!(d, [
            (x_start, y_start),
            (x_start + side * scale, y_start),
            (x_start + side * scale, y_start + side * scale),
            (x_start, y_start + side * scale)
        ], fill="lightyellow", stroke="black", stroke_width=2)
        
        text!(d, x_start + side * scale / 2, y_start - 15, "$(side)", font_size=16)
        
        perimeter = 4 * side
        
        problem(
            question="Find the perimeter of the square shown in the diagram.",
            answer=perimeter,
            difficulty=(100, 300),
            solution=steps(
                "The perimeter of a square is P = 4 × side",
                sol("Substitute the side length", "P = 4 × $(side)"),
                sol("Answer", perimeter)
            ),
            image=render(d),
            time=35
        )
    end
end