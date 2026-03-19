# geometry - perimeter (medium)
# Generated: 2026-03-08T20:08:44.328989

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/perimeter")
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Rectangle with algebraic expression for dimensions
        width = randint(3, 12)
        coeff = randint(2, 8)
        const_term = randint(-5, 10)
        
        # Length in terms of width
        length = coeff * width + const_term
        
        perimeter = 2 * (width + length)
        
        d = DiagramObj(600, 400)
        polygon!(d, [50, 50, 50+400, 50+400], [50, 50+250, 50+250, 50], fill="lightblue", stroke="black", stroke_width=2)
        segment_label!(d, 50+200, 30, "$(coeff)w + $(const_term)", fontsize=20)
        segment_label!(d, 30, 50+125, "w = $(width)", fontsize=20)
        
        problem(
            question="A rectangle has width \\(w = $(width)\\) and length \\($(coeff)w + $(const_term)\\). Find the perimeter of the rectangle.",
            answer=perimeter,
            difficulty=(1200, 1400),
            solution=steps(
                "Substitute \\(w = $(width)\\) into the length expression",
                sol("Length", length),
                "Use perimeter formula \\(P = 2(\\text{length} + \\text{width})\\)",
                sol("P", "2($(length) + $(width)) = 2($(length + width)) = $(perimeter)")
            ),
            image=render(d),
            time=90
        )
        
    elseif prob_type == 2
        # Composite figure: rectangle with semicircle
        width = randint(6, 16)
        height = randint(8, 20)
        
        # Perimeter = 3 sides of rectangle + semicircle arc
        rect_sides = 2 * height + width
        semicircle_arc = Rational(width) * π / 1
        perimeter_exact = rect_sides + semicircle_arc
        
        d = DiagramObj(600, 500)
        # Rectangle
        polygon!(d, [100, 100, 100+300, 100+300], [150, 150+250, 150+250, 150], fill="lightblue", stroke="black", stroke_width=2)
        # Semicircle on top
        arc!(d, 100+150, 150, 150, 0, 180, stroke="black", stroke_width=2, fill="lightgreen")
        
        segment_label!(d, 100+150, 420, "$(width)", fontsize=18)
        segment_label!(d, 70, 150+125, "$(height)", fontsize=18)
        text!(d, 250, 80, "semicircle", fontsize=16)
        
        problem(
            question="A figure consists of a rectangle with width $(width) and height $(height), with a semicircle attached to the top side (diameter = width). Find the exact perimeter of this composite figure.",
            answer="$(rect_sides) + $(width)π/2",
            difficulty=(1400, 1600),
            solution=steps(
                "Perimeter includes: left side + bottom + right side + semicircular arc",
                sol("Three rectangle sides", "$(height) + $(width) + $(height) = $(rect_sides)"),
                sol("Semicircle arc", "\\frac{1}{2} \\cdot \\pi d = \\frac{1}{2} \\cdot \\pi \\cdot $(width) = \\frac{$(width)\\pi}{2}"),
                sol("Total perimeter", "$(rect_sides) + \\frac{$(width)\\pi}{2}")
            ),
            image=render(d),
            time=150
        )
        
    elseif prob_type == 3
        # Isosceles triangle with perimeter equation
        leg = randint(5, 15)
        base_coeff = randint(2, 4)
        total_perimeter = randint(40, 80)
        
        # 2*leg + base = perimeter, where base = base_coeff * x
        # Solve for x: 2*leg + base_coeff*x = total_perimeter
        x_val = (total_perimeter - 2*leg) // base_coeff
        base = base_coeff * x_val
        
        d = DiagramObj(600, 500)
        polygon!(d, [300, 100, 500], [100, 400, 400], fill="lightyellow", stroke="black", stroke_width=2)
        segment_label!(d, 180, 250, "$(leg)", fontsize=18)
        segment_label!(d, 420, 250, "$(leg)", fontsize=18)
        segment_label!(d, 300, 430, "$(base_coeff)x", fontsize=18)
        
        problem(
            question="An isosceles triangle has two equal sides of length $(leg) each, and a base of length \\($(base_coeff)x\\). If the perimeter of the triangle is $(total_perimeter), find the value of \\(x\\).",
            answer=x_val,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Perimeter equation", "2($(leg)) + $(base_coeff)x = $(total_perimeter)"),
                "Simplify left side",
                sol("", "$(2*leg) + $(base_coeff)x = $(total_perimeter)"),
                "Solve for \\(x\\)",
                sol("x", x_val)
            ),
            image=render(d),
            time=120
        )
        
    else
        # Regular polygon perimeter problem
        n_sides = choice([5, 6, 8])
        side_expr_coeff = randint(2, 6)
        side_expr_const = randint(-8, 8)
        var_value = randint(4, 12)
        
        side_length = side_expr_coeff * var_value + side_expr_const
        perimeter = n_sides * side_length
        
        polygon_name = n_sides == 5 ? "pentagon" : (n_sides == 6 ? "hexagon" : "octagon")
        
        d = DiagramObj(600, 600)
        
        # Draw regular polygon
        center_x, center_y = 300, 300
        radius = 200
        points_x = []
        points_y = []
        for i in 0:(n_sides-1)
            angle = 2π * i / n_sides - π/2
            push!(points_x, center_x + radius * cos(angle))
            push!(points_y, center_y + radius * sin(angle))
        end
        polygon!(d, points_x, points_y, fill="lightcoral", stroke="black", stroke_width=2)
        
        # Label one side
        mid_x = (points_x[1] + points_x[2]) / 2
        mid_y = (points_y[1] + points_y[2]) / 2
        text!(d, mid_x, mid_y - 20, "$(side_expr_coeff)s + $(side_expr_const)", fontsize=18)
        
        problem(
            question="A regular $(polygon_name) has side length \\($(side_expr_coeff)s + $(side_expr_const)\\). If \\(s = $(var_value)\\), find the perimeter of the $(polygon_name).",
            answer=perimeter,
            difficulty=(1250, 1450),
            solution=steps(
                "Substitute \\(s = $(var_value)\\) into the side length expression",
                sol("Side length", "$(side_expr_coeff)($(var_value)) + $(side_expr_const) = $(side_length)"),
                "A regular $(polygon_name) has $(n_sides) equal sides",
                sol("Perimeter", "$(n_sides) \\times $(side_length) = $(perimeter)")
            ),
            image=render(d),
            time=100
        )
    end
end