"""
geometry - perimeter (medium)
Generated: 2026-02-22T04:13:40.406856
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Rectangle perimeter with numeric values (1200-1400)
        length = randint(5, 20)
        width = randint(3, 15)
        if width >= length:
            length, width = width + randint(1, 5), width
        
        perimeter = 2 * (length + width)
        
        d = Diagram(width=300, height=200, padding=40)
        d.polygon([(0, 0), (length, 0), (length, width), (0, width)], 
                  labels=['', '', '', ''])
        d.segment_label((0, 0), (length, 0), f"{length}")
        d.segment_label((length, 0), (length, width), f"{width}")
        
        return problem(
            question=f"Find the perimeter of a rectangle with length ${length}$ and width ${width}$.",
            answer=perimeter,
            difficulty=(1200, 1400),
            topic="geometry/perimeter",
            solution=steps(
                f"Perimeter of rectangle = $2(\\text{{length}} + \\text{{width}})$",
                f"$P = 2({length} + {width})$",
                f"$P = 2({length + width})$",
                f"$P = {perimeter}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Regular polygon perimeter (1300-1500)
        sides = choice([5, 6, 8])
        side_length = randint(4, 12)
        perimeter = sides * side_length
        
        polygon_names = {5: "pentagon", 6: "hexagon", 8: "octagon"}
        
        return problem(
            question=f"A regular {polygon_names[sides]} has side length ${side_length}$. Find its perimeter.",
            answer=perimeter,
            difficulty=(1300, 1500),
            topic="geometry/perimeter",
            solution=steps(
                f"A regular {polygon_names[sides]} has ${sides}$ equal sides",
                f"Perimeter = ${sides} \\times {side_length}$",
                f"$P = {perimeter}$"
            )
        )
    
    elif problem_type == 3:
        # Find missing side given perimeter (1400-1600)
        perimeter = randint(30, 60)
        known_sides = randint(2, 3)
        
        if known_sides == 2:
            # Triangle with two known sides
            side1 = randint(8, 15)
            side2 = randint(8, 15)
            side3 = perimeter - side1 - side2
            
            # Ensure valid triangle
            if side3 <= 0 or side3 >= side1 + side2 or side1 >= side2 + side3 or side2 >= side1 + side3:
                # Recalculate to ensure valid triangle
                side1 = randint(10, 14)
                side2 = randint(10, 14)
                perimeter = randint(side1 + side2 + 2, side1 + side2 + 15)
                side3 = perimeter - side1 - side2
            
            return problem(
                question=f"A triangle has perimeter ${perimeter}$. Two of its sides have lengths ${side1}$ and ${side2}$. Find the length of the third side.",
                answer=side3,
                difficulty=(1400, 1600),
                topic="geometry/perimeter",
                solution=steps(
                    f"Perimeter = sum of all three sides",
                    f"${perimeter} = {side1} + {side2} + x$",
                    f"${perimeter} = {side1 + side2} + x$",
                    f"$x = {perimeter} - {side1 + side2}$",
                    f"$x = {side3}$"
                )
            )
        else:
            # Rectangle - find width given length and perimeter
            length = randint(10, 18)
            width = (perimeter - 2*length) // 2
            
            # Ensure valid rectangle
            if width <= 0 or width >= length:
                perimeter = 2*length + 2*randint(3, length-2)
                width = (perimeter - 2*length) // 2
            
            return problem(
                question=f"A rectangle has perimeter ${perimeter}$ and length ${length}$. Find its width.",
                answer=width,
                difficulty=(1400, 1600),
                topic="geometry/perimeter",
                solution=steps(
                    f"Perimeter of rectangle = $2(\\text{{length}} + \\text{{width}})$",
                    f"${perimeter} = 2({length} + w)$",
                    f"${perimeter // 2} = {length} + w$",
                    f"$w = {perimeter // 2} - {length}$",
                    f"$w = {width}$"
                )
            )
    
    else:
        # Composite figure perimeter (1400-1600)
        base = randint(10, 16)
        height = randint(6, 12)
        side = randint(5, 10)
        
        # L-shaped figure
        perimeter = 2*base + 2*height + 2*side
        
        d = Diagram(width=300, height=250, padding=40)
        points = [
            (0, 0),
            (base, 0),
            (base, side),
            (side, side),
            (side, height),
            (0, height)
        ]
        d.polygon(points, labels=['', '', '', '', '', ''])
        d.segment_label((0, 0), (base, 0), f"{base}")
        d.segment_label((side, side), (side, height), f"{height - side}")
        d.segment_label((base, 0), (base, side), f"{side}")
        
        return problem(
            question=f"Find the perimeter of the L-shaped figure shown, where the base is ${base}$, the total height on the left is ${height}$, and the step height is ${side}$.",
            answer=perimeter,
            difficulty=(1400, 1600),
            topic="geometry/perimeter",
            solution=steps(
                f"Add all outer edge lengths",
                f"Bottom: ${base}$, Right vertical: ${side}$, Top right horizontal: ${base - side}$",
                f"Top vertical: ${height - side}$, Top left horizontal: ${side}$, Left vertical: ${height}$",
                f"$P = {base} + {side} + {base - side} + {height - side} + {side} + {height}$",
                f"$P = {perimeter}$"
            ),
            image=d.render()
        )

emit(generate())