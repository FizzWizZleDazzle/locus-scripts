# geometry - area_of_polygons (very_easy)
# Generated: 2026-03-08T20:07:20.082051

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/area_of_polygons")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Rectangle area (ELO 100-300)
        width = randint(3, 12)
        height = randint(3, 12)
        area = width * height
        
        d = DiagramObj(width=400, height=300)
        polygon!(d, [(50, 50), (50+width*25, 50), (50+width*25, 50+height*25), (50, 50+height*25)], 
                fill="lightblue", stroke="black", stroke_width=2)
        text!(d, 50 + width*12.5, 35, "$(width)", font_size=16)
        text!(d, 30, 50 + height*12.5, "$(height)", font_size=16)
        
        problem(
            question="Find the area of the rectangle shown.",
            answer=area,
            difficulty=(150, 300),
            solution=steps(
                "Use the formula: Area = length × width",
                sol("Calculation", "$(width) × $(height)"),
                sol("Area", "$(area) square units")
            ),
            image=render(d),
            time=45
        )
        
    elseif problem_type == 2
        # Triangle area (ELO 300-500)
        base = randint(4, 15)
        height = randint(4, 15)
        area = (base * height) // 2
        
        d = DiagramObj(width=400, height=300)
        polygon!(d, [(50, 220), (50 + base*20, 220), (50 + base*10, 220 - height*12)], 
                fill="lightgreen", stroke="black", stroke_width=2)
        line!(d, 50 + base*10, 220, 50 + base*10, 220 - height*12, stroke="red", stroke_width=1, dash="5,5")
        text!(d, 50 + base*10, 235, "$(base)", font_size=16)
        text!(d, 50 + base*10 + 20, 220 - height*6, "$(height)", font_size=16)
        
        problem(
            question="Find the area of the triangle shown. The base is $(base) and the height is $(height).",
            answer=area,
            difficulty=(350, 500),
            solution=steps(
                "Use the formula: Area = ½ × base × height",
                sol("Calculation", "\\frac{1}{2} × $(base) × $(height)"),
                sol("Area", "$(area) square units")
            ),
            image=render(d),
            time=60
        )
        
    elseif problem_type == 3
        # Square area (ELO 100-250)
        side = randint(4, 14)
        area = side * side
        
        d = DiagramObj(width=400, height=400)
        polygon!(d, [(50, 50), (50+side*20, 50), (50+side*20, 50+side*20), (50, 50+side*20)], 
                fill="lightyellow", stroke="black", stroke_width=2)
        text!(d, 50 + side*10, 35, "$(side)", font_size=16)
        
        problem(
            question="Find the area of the square with side length $(side).",
            answer=area,
            difficulty=(100, 250),
            solution=steps(
                "Use the formula: Area = side × side",
                sol("Calculation", "$(side) × $(side)"),
                sol("Area", "$(area) square units")
            ),
            image=render(d),
            time=40
        )
        
    else
        # Parallelogram area (ELO 400-650)
        base = randint(5, 16)
        height = randint(4, 12)
        area = base * height
        
        d = DiagramObj(width=450, height=300)
        offset = 40
        polygon!(d, [(50, 220), (50 + base*18, 220), (50 + base*18 + offset, 220 - height*14), (50 + offset, 220 - height*14)], 
                fill="lightcoral", stroke="black", stroke_width=2)
        line!(d, 50 + offset, 220, 50 + offset, 220 - height*14, stroke="red", stroke_width=1, dash="5,5")
        text!(d, 50 + base*9, 235, "$(base)", font_size=16)
        text!(d, 35 + offset, 220 - height*7, "$(height)", font_size=16)
        
        problem(
            question="Find the area of the parallelogram shown. The base is $(base) and the height is $(height).",
            answer=area,
            difficulty=(450, 650),
            solution=steps(
                "Use the formula: Area = base × height",
                "Note: The height is perpendicular to the base",
                sol("Calculation", "$(base) × $(height)"),
                sol("Area", "$(area) square units")
            ),
            image=render(d),
            time=75
        )
    end
end