# geometry - area_of_polygons (hard)
# Generated: 2026-03-08T20:08:01.090652

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/area_of_polygons")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Triangle with altitude - find area given constraints
        base = randint(8, 20)
        height = randint(6, 18)
        side1 = randint(height + 2, height + 10)
        side2 = randint(height + 2, height + 10)
        
        d = DiagramObj(width=400, height=300)
        polygon!(d, [(50, 250), (50 + base * 15, 250), (50 + base * 7, 250 - height * 12)], fill="lightblue", stroke="black", stroke_width=2)
        line!(d, 50 + base * 7, 250 - height * 12, 50 + base * 7, 250, stroke="red", stroke_width=1.5, dash="4,2")
        point!(d, 50 + base * 7, 250, color="red", radius=4)
        segment_label!(d, 50, 250, 50 + base * 15, 250, "$(base)", offset=-15)
        segment_label!(d, 50 + base * 7, 250 - height * 12, 50 + base * 7, 250, "$(height)", offset=15)
        text!(d, 50, 250 - height * 12, "A", offset_x=-15, offset_y=-10)
        text!(d, 50 + base * 15, 250, "B", offset_x=10, offset_y=5)
        text!(d, 50, 250, "C", offset_x=-15, offset_y=5)
        
        area = (base * height) // 2
        
        problem(
            question="A triangle has a base of $(base) units and an altitude (height) of $(height) units drawn to that base. Find the area of the triangle.",
            answer=area,
            difficulty=(1800, 2000),
            solution=steps(
                "Given: base = $(base), height = $(height)",
                sol("Area formula", "A = \\frac{1}{2} \\times \\text{base} \\times \\text{height}"),
                sol("Calculation", "A = \\frac{1}{2} \\times $(base) \\times $(height) = $(area)"),
                sol("Answer", area)
            ),
            image=render(d),
            time=90
        )
        
    elseif problem_type == 2
        # Trapezoid area problem
        base1 = randint(10, 25)
        base2 = randint(base1 + 4, base1 + 15)
        height = randint(8, 18)
        
        d = DiagramObj(width=450, height=300)
        offset = (base2 - base1) * 5
        polygon!(d, [(50 + offset, 250 - height * 10), (50 + offset + base1 * 12, 250 - height * 10), 
                     (50 + base2 * 12, 250), (50, 250)], fill="lightgreen", stroke="black", stroke_width=2)
        line!(d, 50 + offset, 250 - height * 10, 50 + offset, 250, stroke="red", stroke_width=1.5, dash="4,2")
        segment_label!(d, 50 + offset, 250 - height * 10, 50 + offset + base1 * 12, 250 - height * 10, "$(base1)", offset=-15)
        segment_label!(d, 50, 250, 50 + base2 * 12, 250, "$(base2)", offset=15)
        segment_label!(d, 50 + offset, 250 - height * 10, 50 + offset, 250, "$(height)", offset=15)
        
        area = ((base1 + base2) * height) // 2
        
        problem(
            question="A trapezoid has parallel bases of lengths $(base1) and $(base2) units, and a height of $(height) units. Find the area of the trapezoid.",
            answer=area,
            difficulty=(1850, 2050),
            solution=steps(
                "Given: base₁ = $(base1), base₂ = $(base2), height = $(height)",
                sol("Trapezoid area formula", "A = \\frac{1}{2}(b_1 + b_2) \\times h"),
                sol("Substitution", "A = \\frac{1}{2}($(base1) + $(base2)) \\times $(height)"),
                sol("Calculation", "A = \\frac{1}{2} \\times $(base1 + base2) \\times $(height) = $(area)"),
                sol("Answer", area)
            ),
            image=render(d),
            time=120
        )
        
    elseif problem_type == 3
        # Complex polygon decomposition
        rect_width = randint(12, 24)
        rect_height = randint(10, 20)
        tri_base = randint(6, rect_width - 2)
        tri_height = randint(6, 14)
        
        d = DiagramObj(width=500, height=350)
        polygon!(d, [(50, 250), (50 + rect_width * 12, 250), (50 + rect_width * 12, 250 - rect_height * 10),
                     (50, 250 - rect_height * 10)], fill="lightcoral", stroke="black", stroke_width=2)
        tri_x = 50 + (rect_width - tri_base) * 6
        polygon!(d, [(tri_x, 250 - rect_height * 10), (tri_x + tri_base * 12, 250 - rect_height * 10),
                     (tri_x + tri_base * 6, 250 - rect_height * 10 - tri_height * 10)], 
                    fill="lightyellow", stroke="black", stroke_width=2)
        
        segment_label!(d, 50, 250, 50 + rect_width * 12, 250, "$(rect_width)", offset=15)
        segment_label!(d, 50, 250, 50, 250 - rect_height * 10, "$(rect_height)", offset=-15)
        segment_label!(d, tri_x, 250 - rect_height * 10, tri_x + tri_base * 12, 250 - rect_height * 10, "$(tri_base)", offset=15)
        segment_label!(d, tri_x + tri_base * 6, 250 - rect_height * 10 - tri_height * 10, tri_x + tri_base * 6, 250 - rect_height * 10, "$(tri_height)", offset=10)
        
        rect_area = rect_width * rect_height
        tri_area = (tri_base * tri_height) // 2
        total_area = rect_area + tri_area
        
        problem(
            question="A composite figure consists of a rectangle with width $(rect_width) and height $(rect_height), with an isosceles triangle of base $(tri_base) and height $(tri_height) attached to the top. Find the total area of the composite figure.",
            answer=total_area,
            difficulty=(1950, 2150),
            solution=steps(
                "Decompose into rectangle and triangle",
                sol("Rectangle area", "A_r = $(rect_width) \\times $(rect_height) = $(rect_area)"),
                sol("Triangle area", "A_t = \\frac{1}{2} \\times $(tri_base) \\times $(tri_height) = $(tri_area)"),
                sol("Total area", "A = $(rect_area) + $(tri_area) = $(total_area)"),
                sol("Answer", total_area)
            ),
            image=render(d),
            time=150
        )
        
    elseif problem_type == 4
        # Regular polygon area using apothem
        n = choice([5, 6, 8])
        side = randint(8, 16)
        apothem_dict = Dict(5 => side / (2 * tan(π/5)), 6 => side * sqrt(3) / 2, 8 => side * (1 + sqrt(2)) / 2)
        apothem = round(apothem_dict[n], digits=2)
        
        d = DiagramObj(width=400, height=400)
        center_x, center_y = 200, 200
        radius = side / (2 * sin(π/n))
        angles = [2π * i / n - π/2 for i in 0:n-1]
        points = [(center_x + radius * cos(θ), center_y + radius * sin(θ)) for θ in angles]
        polygon!(d, points, fill="lavender", stroke="black", stroke_width=2)
        line!(d, center_x, center_y, (points[1][1] + points[2][1])/2, (points[1][2] + points[2][2])/2, 
              stroke="red", stroke_width=1.5, dash="4,2")
        point!(d, center_x, center_y, color="red", radius=4)
        text!(d, center_x, center_y - 40, "apothem = $(apothem)", font_size=14)
        text!(d, points[1][1] - 20, points[1][2] + 30, "side = $(side)", font_size=14)
        
        perimeter = n * side
        area = (perimeter * apothem) / 2
        area_rounded = round(area, digits=2)
        
        problem(
            question="A regular $(n)-gon has a side length of $(side) units and an apothem (distance from center to midpoint of a side) of $(apothem) units. Find the area of the polygon.",
            answer=area_rounded,
            difficulty=(2100, 2300),
            solution=steps(
                "Given: n = $(n) sides, side length = $(side), apothem = $(apothem)",
                sol("Perimeter", "P = $(n) \\times $(side) = $(perimeter)"),
                sol("Regular polygon area formula", "A = \\frac{1}{2} \\times P \\times a"),
                sol("Calculation", "A = \\frac{1}{2} \\times $(perimeter) \\times $(apothem) = $(area_rounded)"),
                sol("Answer", area_rounded)
            ),
            image=render(d),
            time=180
        )
        
    else
        # Rhombus area using diagonals
        d1 = randint(12, 28)
        d2 = randint(10, 26)
        
        diag = DiagramObj(width=450, height=400)
        center_x, center_y = 225, 200
        polygon!(diag, [(center_x, center_y - d1 * 6), (center_x + d2 * 6, center_y), 
                       (center_x, center_y + d1 * 6), (center_x - d2 * 6, center_y)], 
                fill="lightpink", stroke="black", stroke_width=2)
        line!(diag, center_x, center_y - d1 * 6, center_x, center_y + d1 * 6, stroke="blue", stroke_width=2)
        line!(diag, center_x - d2 * 6, center_y, center_x + d2 * 6, center_y, stroke="blue", stroke_width=2)
        segment_label!(diag, center_x, center_y - d1 * 6, center_x, center_y + d1 * 6, "$(d1)", offset=-20)
        segment_label!(diag, center_x - d2 * 6, center_y, center_x + d2 * 6, center_y, "$(d2)", offset=-15)
        
        area = (d1 * d2) // 2
        
        problem(
            question="A rhombus has diagonals of lengths $(d1) and $(d2) units. Find the area of the rhombus.",
            answer=area,
            difficulty=(1900, 2100),
            solution=steps(
                "Given: diagonal₁ = $(d1), diagonal₂ = $(d2)",
                sol("Rhombus area formula", "A = \\frac{1}{2} \\times d_1 \\times d_2"),
                sol("Substitution", "A = \\frac{1}{2} \\times $(d1) \\times $(d2)"),
                sol("Calculation", "A = $(area)"),
                sol("Answer", area)
            ),
            image=render(diag),
            time=120
        )
    end
end