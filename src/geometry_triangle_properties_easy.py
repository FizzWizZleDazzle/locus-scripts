"""
geometry - triangle_properties (easy)
Generated: 2026-02-22T04:04:41.772819
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Find the third angle in a triangle given two angles
        angle1 = randint(30, 80)
        angle2 = randint(30, 80)
        # Ensure the sum is less than 180
        if angle1 + angle2 >= 150:
            angle2 = randint(20, 50)
        angle3 = 180 - angle1 - angle2
        
        d = Diagram(width=300, height=200, padding=40)
        # Draw a triangle
        p1 = (0, 0)
        p2 = (4, 0)
        p3 = (1.5, 2.5)
        d.polygon([p1, p2, p3], labels=['A', 'B', 'C'])
        d.text(0.3, 0.3, f"{angle1}°")
        d.text(3.5, 0.3, f"{angle2}°")
        d.text(1.5, 2.0, "?")
        
        return problem(
            question=f"Find the measure of the missing angle in the triangle. Two angles measure ${angle1}°$ and ${angle2}°$.",
            answer=angle3,
            difficulty=(1000, 1100),
            topic="geometry/triangle_properties",
            solution=steps(
                f"The sum of angles in a triangle is $180°$",
                f"Missing angle $= 180° - {angle1}° - {angle2}°$",
                f"Missing angle $= {angle3}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Classify triangle by angles (right, acute, or obtuse)
        triangle_type = choice(['right', 'acute', 'obtuse'])
        
        if triangle_type == 'right':
            angle1 = 90
            angle2 = randint(20, 70)
            angle3 = 90 - angle2
            ans = "right"
        elif triangle_type == 'acute':
            angle1 = randint(40, 70)
            angle2 = randint(40, 70)
            angle3 = 180 - angle1 - angle2
            if angle3 >= 90:
                angle2 = randint(30, 50)
                angle3 = 180 - angle1 - angle2
            ans = "acute"
        else:  # obtuse
            angle1 = randint(100, 140)
            angle2 = randint(20, 40)
            angle3 = 180 - angle1 - angle2
            ans = "obtuse"
        
        return problem(
            question=f"Classify the triangle with angles ${angle1}°$, ${angle2}°$, and ${angle3}°$ as acute, right, or obtuse.",
            answer=ans,
            difficulty=(1100, 1200),
            topic="geometry/triangle_properties",
            solution=steps(
                f"The angles are ${angle1}°$, ${angle2}°$, and ${angle3}°$",
                f"One angle is {angle1}°" if triangle_type == 'right' and angle1 == 90 else
                f"One angle ({angle1}°) is greater than $90°$" if triangle_type == 'obtuse' else
                f"All angles are less than $90°$",
                f"The triangle is {ans}"
            ),
            answer_type="text"
        )
    
    elif problem_type == 3:
        # Find perimeter of a triangle given three sides
        side1 = randint(3, 12)
        side2 = randint(3, 12)
        side3 = randint(3, 12)
        # Ensure triangle inequality
        if side1 + side2 <= side3:
            side3 = side1 + side2 - 1
        perimeter = side1 + side2 + side3
        
        d = Diagram(width=300, height=200, padding=40)
        p1 = (0, 0)
        p2 = (5, 0)
        p3 = (2, 3)
        d.polygon([p1, p2, p3], labels=['A', 'B', 'C'])
        d.segment_label(p1, p2, f"{side1}")
        d.segment_label(p2, p3, f"{side2}")
        d.segment_label(p3, p1, f"{side3}")
        
        return problem(
            question=f"Find the perimeter of a triangle with sides of length ${side1}$, ${side2}$, and ${side3}$.",
            answer=perimeter,
            difficulty=(1000, 1100),
            topic="geometry/triangle_properties",
            solution=steps(
                f"Perimeter $= {side1} + {side2} + {side3}$",
                f"Perimeter $= {perimeter}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 4:
        # Isosceles triangle - find the third angle given two equal angles
        equal_angle = randint(40, 70)
        third_angle = 180 - 2 * equal_angle
        
        d = Diagram(width=300, height=250, padding=40)
        p1 = (0, 0)
        p2 = (4, 0)
        p3 = (2, 3.5)
        d.polygon([p1, p2, p3], labels=['A', 'B', 'C'])
        d.tick_marks(p1, p3, 1)
        d.tick_marks(p2, p3, 1)
        d.text(0.3, 0.3, f"{equal_angle}°")
        d.text(3.5, 0.3, f"{equal_angle}°")
        d.text(2, 3.0, "?")
        
        return problem(
            question=f"In an isosceles triangle, two angles each measure ${equal_angle}°$. Find the measure of the third angle.",
            answer=third_angle,
            difficulty=(1100, 1200),
            topic="geometry/triangle_properties",
            solution=steps(
                f"The sum of angles in a triangle is $180°$",
                f"Two angles are equal: ${equal_angle}°$ each",
                f"Third angle $= 180° - {equal_angle}° - {equal_angle}°$",
                f"Third angle $= {third_angle}°$"
            ),
            image=d.render()
        )
    
    else:  # problem_type == 5
        # Equilateral triangle - all angles are equal
        angle = 60
        
        d = Diagram(width=300, height=250, padding=40)
        p1 = (0, 0)
        p2 = (4, 0)
        p3 = (2, 3.464)
        d.polygon([p1, p2, p3], labels=['A', 'B', 'C'])
        d.tick_marks(p1, p2, 1)
        d.tick_marks(p2, p3, 1)
        d.tick_marks(p3, p1, 1)
        d.text(2, 1.7, "?")
        
        return problem(
            question=f"Find the measure of each angle in an equilateral triangle.",
            answer=angle,
            difficulty=(1000, 1100),
            topic="geometry/triangle_properties",
            solution=steps(
                f"In an equilateral triangle, all angles are equal",
                f"Let each angle be $x$",
                f"$x + x + x = 180°$",
                f"$3x = 180°$",
                f"$x = 60°$"
            ),
            image=d.render()
        )

emit(generate())