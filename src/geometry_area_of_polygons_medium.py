"""
geometry - area_of_polygons (medium)
Generated: 2026-02-22T04:12:17.262019
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['rectangle', 'triangle', 'parallelogram', 'trapezoid', 'composite'])
    
    if problem_type == 'rectangle':
        length = randint(5, 20)
        width = randint(3, 15)
        area = length * width
        
        d = Diagram(width=300, height=200, padding=40)
        points = [(0, 0), (length, 0), (length, width), (0, width)]
        d.polygon(points)
        d.segment_label((0, 0), (length, 0), f"{length}")
        d.segment_label((length, 0), (length, width), f"{width}")
        d.right_angle((0, 0), (length, 0), (0, width))
        d.right_angle((length, 0), (length, width), (0, 0))
        
        return problem(
            question=f"Find the area of a rectangle with length ${length}$ units and width ${width}$ units.",
            answer=area,
            difficulty=(1200, 1300),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of rectangle = length × width",
                f"$A = {length} \\times {width}$",
                f"$A = {area}$ square units"
            ),
            image=d.render()
        )
    
    elif problem_type == 'triangle':
        base = randint(6, 24)
        height = randint(4, 20)
        area = Rational(base * height, 2)
        
        d = Diagram(width=300, height=220, padding=40)
        points = [(0, 0), (base, 0), (base/2, height)]
        d.polygon(points)
        d.segment_label((0, 0), (base, 0), f"{base}")
        d.line((base/2, 0), (base/2, height), dashed=True)
        d.segment_label((base/2, 0), (base/2, height), f"{height}")
        d.right_angle((base/2, 0), (base, 0), (base/2, height))
        
        return problem(
            question=f"Find the area of a triangle with base ${base}$ units and height ${height}$ units.",
            answer=area,
            difficulty=(1300, 1400),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of triangle = $\\frac{{1}}{{2}} \\times$ base $\\times$ height",
                f"$A = \\frac{{1}}{{2}} \\times {base} \\times {height}$",
                f"$A = \\frac{{{base * height}}}{{2}}$",
                f"$A = {latex(area)}$ square units"
            ),
            image=d.render()
        )
    
    elif problem_type == 'parallelogram':
        base = randint(8, 20)
        height = randint(5, 15)
        slant = randint(2, 6)
        area = base * height
        
        d = Diagram(width=320, height=200, padding=40)
        points = [(slant, 0), (base + slant, 0), (base, height), (0, height)]
        d.polygon(points)
        d.segment_label((slant, 0), (base + slant, 0), f"{base}")
        d.line((slant, 0), (slant, height), dashed=True)
        d.segment_label((slant, 0), (slant, height), f"{height}")
        d.right_angle((slant, 0), (base + slant, 0), (slant, height))
        
        return problem(
            question=f"Find the area of a parallelogram with base ${base}$ units and height ${height}$ units.",
            answer=area,
            difficulty=(1300, 1400),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of parallelogram = base × height",
                f"$A = {base} \\times {height}$",
                f"$A = {area}$ square units"
            ),
            image=d.render()
        )
    
    elif problem_type == 'trapezoid':
        base1 = randint(8, 18)
        base2 = randint(4, base1 - 2)
        height = randint(5, 12)
        area = Rational((base1 + base2) * height, 2)
        
        offset = (base1 - base2) / 2
        d = Diagram(width=300, height=220, padding=40)
        points = [(0, 0), (base1, 0), (base1 - offset, height), (offset, height)]
        d.polygon(points)
        d.segment_label((0, 0), (base1, 0), f"{base1}")
        d.segment_label((offset, height), (base1 - offset, height), f"{base2}")
        d.line((offset, 0), (offset, height), dashed=True)
        d.segment_label((offset, 0), (offset, height), f"{height}")
        d.right_angle((offset, 0), (base1, 0), (offset, height))
        
        return problem(
            question=f"Find the area of a trapezoid with bases ${base1}$ units and ${base2}$ units, and height ${height}$ units.",
            answer=area,
            difficulty=(1400, 1500),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of trapezoid = $\\frac{{1}}{{2}} \\times$ (base₁ + base₂) $\\times$ height",
                f"$A = \\frac{{1}}{{2}} \\times ({base1} + {base2}) \\times {height}$",
                f"$A = \\frac{{1}}{{2}} \\times {base1 + base2} \\times {height}$",
                f"$A = \\frac{{{(base1 + base2) * height}}}{{2}}$",
                f"$A = {latex(area)}$ square units"
            ),
            image=d.render()
        )
    
    else:  # composite shape
        rect_length = randint(8, 16)
        rect_width = randint(6, 12)
        tri_base = rect_length
        tri_height = randint(4, 10)
        
        rect_area = rect_length * rect_width
        tri_area = Rational(tri_base * tri_height, 2)
        total_area = rect_area + tri_area
        
        d = Diagram(width=300, height=250, padding=40)
        rect_points = [(0, 0), (rect_length, 0), (rect_length, rect_width), (0, rect_width)]
        d.polygon(rect_points)
        tri_points = [(0, rect_width), (rect_length, rect_width), (rect_length/2, rect_width + tri_height)]
        d.polygon(tri_points)
        d.segment_label((0, 0), (rect_length, 0), f"{rect_length}")
        d.segment_label((rect_length, 0), (rect_length, rect_width), f"{rect_width}")
        d.line((rect_length/2, rect_width), (rect_length/2, rect_width + tri_height), dashed=True)
        d.segment_label((rect_length/2, rect_width), (rect_length/2, rect_width + tri_height), f"{tri_height}")
        
        return problem(
            question=f"Find the total area of the composite shape: a rectangle with dimensions ${rect_length}$ by ${rect_width}$ units, topped with a triangle of base ${tri_base}$ units and height ${tri_height}$ units.",
            answer=total_area,
            difficulty=(1500, 1600),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Find the area of the rectangle: $A_{{rect}} = {rect_length} \\times {rect_width} = {rect_area}$ square units",
                f"Find the area of the triangle: $A_{{tri}} = \\frac{{1}}{{2}} \\times {tri_base} \\times {tri_height} = {latex(tri_area)}$ square units",
                f"Total area = $A_{{rect}} + A_{{tri}}$",
                f"$A = {rect_area} + {latex(tri_area)} = {latex(total_area)}$ square units"
            ),
            image=d.render()
        )

emit(generate())