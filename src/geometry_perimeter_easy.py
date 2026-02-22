"""
geometry - perimeter (easy)
Generated: 2026-02-22T04:13:14.985871
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple rectangle perimeter
        length = randint(3, 12)
        width = randint(2, 10)
        if width == length:
            width = width + randint(1, 3)
        
        perimeter = 2 * (length + width)
        
        d = Diagram(width=300, height=200, padding=40)
        rect_points = [(0, 0), (length, 0), (length, width), (0, width)]
        d.polygon(rect_points, labels=['', '', '', ''])
        d.segment_label((0, 0), (length, 0), f"{length}")
        d.segment_label((length, 0), (length, width), f"{width}")
        
        return problem(
            question=f"Find the perimeter of a rectangle with length ${length}$ and width ${width}$.",
            answer=perimeter,
            difficulty=(1000, 1100),
            topic="geometry/perimeter",
            solution=steps(
                f"Perimeter of rectangle = $2 \\times (\\text{{length}} + \\text{{width}})$",
                f"$P = 2 \\times ({length} + {width})$",
                f"$P = 2 \\times {length + width}$",
                f"$P = {perimeter}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Simple square perimeter
        side = randint(4, 15)
        perimeter = 4 * side
        
        d = Diagram(width=250, height=250, padding=40)
        square_points = [(0, 0), (side, 0), (side, side), (0, side)]
        d.polygon(square_points, labels=['', '', '', ''])
        d.segment_label((0, 0), (side, 0), f"{side}")
        d.tick_marks((0, 0), (side, 0), count=1)
        d.tick_marks((side, 0), (side, side), count=1)
        d.tick_marks((side, side), (0, side), count=1)
        d.tick_marks((0, side), (0, 0), count=1)
        
        return problem(
            question=f"Find the perimeter of a square with side length ${side}$.",
            answer=perimeter,
            difficulty=(1000, 1100),
            topic="geometry/perimeter",
            solution=steps(
                f"Perimeter of square = $4 \\times \\text{{side}}$",
                f"$P = 4 \\times {side}$",
                f"$P = {perimeter}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 3:
        # Triangle perimeter with three given sides
        side1 = randint(4, 10)
        side2 = randint(5, 11)
        side3 = randint(6, 12)
        
        # Ensure triangle inequality
        if side1 + side2 <= side3:
            side3 = side1 + side2 - 1
        if side1 + side3 <= side2:
            side2 = side1 + side3 - 1
        if side2 + side3 <= side1:
            side1 = side2 + side3 - 1
            
        perimeter = side1 + side2 + side3
        
        d = Diagram(width=300, height=220, padding=40)
        tri_points = [(0, 0), (side1 * 10, 0), (side1 * 5, side2 * 8)]
        d.polygon(tri_points, labels=['', '', ''])
        d.segment_label(tri_points[0], tri_points[1], f"{side1}")
        d.segment_label(tri_points[1], tri_points[2], f"{side3}")
        d.segment_label(tri_points[2], tri_points[0], f"{side2}")
        
        return problem(
            question=f"Find the perimeter of a triangle with sides ${side1}$, ${side2}$, and ${side3}$.",
            answer=perimeter,
            difficulty=(1100, 1200),
            topic="geometry/perimeter",
            solution=steps(
                f"Perimeter of triangle = sum of all sides",
                f"$P = {side1} + {side2} + {side3}$",
                f"$P = {perimeter}$"
            ),
            image=d.render()
        )
    
    else:
        # Find missing side given perimeter of rectangle
        perimeter = randint(20, 50)
        if perimeter % 2 == 1:
            perimeter += 1
        
        length = randint(5, perimeter // 4)
        width = perimeter // 2 - length
        
        d = Diagram(width=300, height=200, padding=40)
        rect_points = [(0, 0), (length, 0), (length, width), (0, width)]
        d.polygon(rect_points, labels=['', '', '', ''])
        d.segment_label((0, 0), (length, 0), f"{length}")
        d.segment_label((length, 0), (length, width), "?")
        
        return problem(
            question=f"A rectangle has perimeter ${perimeter}$ and one side has length ${length}$. Find the length of the adjacent side.",
            answer=width,
            difficulty=(1200, 1300),
            topic="geometry/perimeter",
            solution=steps(
                f"Perimeter of rectangle = $2 \\times (\\text{{length}} + \\text{{width}})$",
                f"${perimeter} = 2 \\times ({length} + w)$",
                f"${perimeter // 2} = {length} + w$",
                f"$w = {perimeter // 2} - {length}$",
                f"$w = {width}$"
            ),
            image=d.render()
        )

emit(generate())