"""
geometry - area_of_polygons (easy)
Generated: 2026-02-22T04:11:52.050832
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Rectangle area - simplest (1000-1100)
        length = randint(3, 12)
        width = randint(3, 10)
        ans = length * width
        
        d = Diagram(width=300, height=200, padding=40)
        points = [(0, 0), (length, 0), (length, width), (0, width)]
        d.polygon(points, labels=['', '', '', ''])
        d.segment_label((0, 0), (length, 0), f"{length}")
        d.segment_label((length, 0), (length, width), f"{width}")
        
        return problem(
            question=f"Find the area of a rectangle with length ${length}$ units and width ${width}$ units.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of rectangle = length × width",
                f"Area = ${length} \\times {width} = {ans}$ square units"
            ),
            image=d.render(),
            calculator="none"
        )
    
    elif problem_type == 2:
        # Square area (1000-1100)
        side = randint(4, 15)
        ans = side * side
        
        d = Diagram(width=250, height=250, padding=40)
        points = [(0, 0), (side, 0), (side, side), (0, side)]
        d.polygon(points, labels=['', '', '', ''])
        d.segment_label((0, 0), (side, 0), f"{side}")
        d.segment_label((side, 0), (side, side), f"{side}")
        
        return problem(
            question=f"Find the area of a square with side length ${side}$ units.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of square = side²",
                f"Area = ${side}^2 = {ans}$ square units"
            ),
            image=d.render(),
            calculator="none"
        )
    
    elif problem_type == 3:
        # Triangle area with base and height given (1100-1250)
        base = randint(4, 16)
        height = randint(3, 12)
        ans = Rational(base * height, 2)
        
        d = Diagram(width=300, height=220, padding=40)
        points = [(0, 0), (base, 0), (base/2, height)]
        d.polygon(points, labels=['', '', ''])
        d.segment_label((0, 0), (base, 0), f"{base}")
        d.line((base/2, 0), (base/2, height), dashed=True)
        d.segment_label((base/2, 0), (base/2, height), f"{height}")
        d.right_angle((base/2, 0), (base, 0), (base/2, height))
        
        return problem(
            question=f"Find the area of a triangle with base ${base}$ units and height ${height}$ units.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of triangle = $\\frac{{1}}{{2}} \\times$ base $\\times$ height",
                f"Area = $\\frac{{1}}{{2}} \\times {base} \\times {height} = {latex(ans)}$ square units"
            ),
            image=d.render(),
            calculator="none"
        )
    
    else:
        # Parallelogram area (1200-1300)
        base = randint(5, 14)
        height = randint(4, 10)
        slant = height + randint(2, 5)
        ans = base * height
        
        d = Diagram(width=320, height=200, padding=40)
        offset = 2
        points = [(0, 0), (base, 0), (base + offset, height), (offset, height)]
        d.polygon(points, labels=['', '', '', ''])
        d.segment_label((0, 0), (base, 0), f"{base}")
        d.line((offset, 0), (offset, height), dashed=True)
        d.segment_label((offset, 0), (offset, height), f"{height}")
        d.right_angle((offset, 0), (base, 0), (offset, height))
        
        return problem(
            question=f"Find the area of a parallelogram with base ${base}$ units and height ${height}$ units.",
            answer=ans,
            difficulty=(1200, 1300),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Area of parallelogram = base × height",
                f"Area = ${base} \\times {height} = {ans}$ square units"
            ),
            image=d.render(),
            calculator="none"
        )

emit(generate())