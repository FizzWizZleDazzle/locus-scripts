"""
geometry - perimeter (hard)
Generated: 2026-02-22T04:14:16.361318
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Composite shape with algebraic expressions
        # Rectangle with semicircle removed
        length = randint(8, 15)
        width = randint(5, 10)
        radius = width // 2
        
        rect_perim = 2 * length + 2 * width
        semicircle_perim = pi * radius
        removed_diameter = 2 * radius
        total = rect_perim - removed_diameter + semicircle_perim
        
        d = Diagram(width=350, height=250)
        d.polygon([(0, 0), (length, 0), (length, width), (0, width)], 
                  labels=['A', 'B', 'C', 'D'])
        mid_point = length / 2
        d.arc((mid_point, width), radius, 0, 180)
        d.segment_label((0, 0), (length, 0), f"{length}")
        d.segment_label((0, 0), (0, width), f"{width}")
        
        return problem(
            question=f"A rectangular piece has dimensions {length} cm by {width} cm. A semicircular notch with diameter {2*radius} cm is cut from the top edge (centered). Find the perimeter of the resulting shape. Express your answer in terms of $\\pi$.",
            answer=simplify(total),
            difficulty=(1600, 1700),
            topic="geometry/perimeter",
            solution=steps(
                f"The original rectangle has perimeter $2({length}) + 2({width}) = {rect_perim}$ cm",
                f"The semicircular notch removes a diameter of {2*radius} cm from the top edge",
                f"But adds a semicircular arc of length $\\frac{{1}}{{2}} \\cdot 2\\pi r = \\pi({radius}) = {radius}\\pi$ cm",
                f"Net perimeter = ${rect_perim} - {2*radius} + {radius}\\pi = {simplify(total)}$ cm"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Perimeter with constraint optimization
        side1 = randint(10, 20)
        side2 = randint(8, 15)
        hyp = sqrt(side1**2 + side2**2)
        
        # Triangle with two sides given, find third for specific perimeter
        target_perimeter = side1 + side2 + randint(5, 12)
        third_side = target_perimeter - side1 - side2
        
        d = Diagram(width=300, height=250)
        d.polygon([(0, 0), (side1, 0), (side1, side2)], labels=['A', 'B', 'C'])
        d.right_angle((side1, 0), (0, 0), (side1, side2))
        d.segment_label((0, 0), (side1, 0), f"{side1}")
        d.segment_label((side1, 0), (side1, side2), f"{side2}")
        d.segment_label((0, 0), (side1, side2), "x")
        
        return problem(
            question=f"A right triangle has legs of length {side1} and {side2}. If the perimeter of the triangle is {target_perimeter}, find the length of the hypotenuse. Round to two decimal places if necessary.",
            answer=round(float(third_side), 2),
            difficulty=(1650, 1750),
            topic="geometry/perimeter",
            solution=steps(
                f"Let $x$ be the length of the hypotenuse",
                f"Perimeter = {side1} + {side2} + x = {target_perimeter}",
                f"Solving: $x = {target_perimeter} - {side1} - {side2} = {third_side}$",
                f"Verify with Pythagorean theorem: ${side1}^2 + {side2}^2 = {side1**2 + side2**2}$ and $x^2 = {float(third_side)**2:.2f}$",
                f"The hypotenuse is ${float(third_side):.2f}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 3:
        # Regular polygon inscribed in circle
        n_sides = choice([5, 6, 8, 10])
        radius = randint(6, 12)
        
        # Side length of regular polygon inscribed in circle
        side_length = 2 * radius * sin(pi / n_sides)
        perimeter = n_sides * side_length
        
        return problem(
            question=f"A regular {n_sides}-sided polygon is inscribed in a circle of radius {radius} cm. Find the perimeter of the polygon. Express your answer in terms of $\\sin$ if necessary, or as a decimal rounded to two places.",
            answer=round(float(perimeter), 2),
            difficulty=(1700, 1800),
            topic="geometry/perimeter",
            solution=steps(
                f"For a regular {n_sides}-gon inscribed in a circle of radius $r = {radius}$",
                f"Each side subtends a central angle of $\\frac{{2\\pi}}{{{n_sides}}} = \\frac{{360^\\circ}}{{{n_sides}}} = {360//n_sides}^\\circ$",
                f"Using the formula: side length $= 2r\\sin\\left(\\frac{{\\pi}}{{{n_sides}}}\\right) = 2({radius})\\sin\\left(\\frac{{\\pi}}{{{n_sides}}}\\right)$",
                f"Side length $\\approx {float(side_length):.4f}$ cm",
                f"Perimeter $= {n_sides} \\times {float(side_length):.4f} \\approx {float(perimeter):.2f}$ cm"
            )
        )
    
    elif problem_type == 4:
        # Track with straight sections and semicircular ends
        straight_length = randint(80, 120)
        track_width = randint(30, 50)
        inner_radius = track_width / 2
        outer_radius = track_width / 2
        
        # Inner perimeter
        inner_perim = 2 * straight_length + 2 * pi * inner_radius
        
        # Outer perimeter  
        lane_width = randint(3, 8)
        outer_rad = inner_radius + lane_width
        outer_perim = 2 * straight_length + 2 * pi * outer_rad
        
        difference = outer_perim - inner_perim
        
        return problem(
            question=f"A running track consists of two straight sections each {straight_length} m long, connected by semicircular ends. The inner radius of the semicircles is {int(inner_radius)} m. An outer lane has radius {int(outer_rad)} m for its semicircular ends. How much longer is one lap around the outer lane compared to the inner lane? Express your answer in terms of $\\pi$.",
            answer=simplify(difference),
            difficulty=(1650, 1750),
            topic="geometry/perimeter",
            solution=steps(
                f"Inner lane perimeter: $2({straight_length}) + 2\\pi({int(inner_radius)}) = {2*straight_length} + {2*int(inner_radius)}\\pi$ m",
                f"Outer lane perimeter: $2({straight_length}) + 2\\pi({int(outer_rad)}) = {2*straight_length} + {2*int(outer_rad)}\\pi$ m",
                f"Difference: $({2*straight_length} + {2*int(outer_rad)}\\pi) - ({2*straight_length} + {2*int(inner_radius)}\\pi)$",
                f"Simplifying: ${2*int(outer_rad)}\\pi - {2*int(inner_radius)}\\pi = {simplify(difference)}$ m"
            )
        )
    
    else:
        # Perimeter with algebraic relationship
        # Isosceles triangle where perimeter involves quadratic
        base = 2 * x
        leg_expr = x + randint(3, 8)
        k = randint(3, 8)
        
        perim_expr = base + 2 * leg_expr
        perim_value = randint(35, 55)
        
        # Solve for x
        equation = Eq(perim_expr, perim_value)
        x_val = solve(equation, x)[0]
        
        # Calculate actual side lengths
        base_val = 2 * x_val
        leg_val = x_val + k
        
        return problem(
            question=f"An isosceles triangle has a base of length $2x$ and two equal sides each of length $(x + {k})$. If the perimeter is {perim_value}, find the value of $x$.",
            answer=x_val,
            difficulty=(1600, 1700),
            topic="geometry/perimeter",
            solution=steps(
                f"Perimeter = base + 2(leg) = $2x + 2(x + {k}) = {perim_value}$",
                f"Simplifying: $2x + 2x + {2*k} = {perim_value}$",
                f"$4x + {2*k} = {perim_value}$",
                f"$4x = {perim_value - 2*k}$",
                f"$x = {x_val}$"
            )
        )

emit(generate())