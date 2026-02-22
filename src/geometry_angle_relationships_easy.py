"""
geometry - angle_relationships (easy)
Generated: 2026-02-22T04:03:08.106419
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Complementary angles: two angles that sum to 90 degrees
        angle1 = randint(20, 70)
        angle2 = 90 - angle1
        
        d = Diagram(width=300, height=200, padding=30)
        # Draw a right angle with two parts
        origin = (0, 0)
        p1 = (3, 0)
        p2 = (3 * cos(angle1 * 3.14159 / 180), 3 * sin(angle1 * 3.14159 / 180))
        p3 = (0, 3)
        
        d.line(origin, p1)
        d.line(origin, p2)
        d.line(origin, p3)
        d.right_angle(origin, p1, p3)
        d.angle_arc(origin, p1, p2, label=f"{angle1}°")
        d.angle_arc(origin, p2, p3, label="?")
        
        return problem(
            question=f"Two angles are complementary. If one angle measures ${angle1}°$, what is the measure of the other angle?",
            answer=angle2,
            difficulty=(1000, 1100),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Complementary angles sum to $90°$",
                f"$90° - {angle1}° = {angle2}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Supplementary angles: two angles that sum to 180 degrees
        angle1 = randint(60, 140)
        angle2 = 180 - angle1
        
        d = Diagram(width=350, height=150, padding=30)
        origin = (0, 0)
        p1 = (-3, 0)
        p2 = (3 * cos(angle1 * 3.14159 / 180), 3 * sin(angle1 * 3.14159 / 180))
        p3 = (3, 0)
        
        d.line(p1, p3)
        d.line(origin, p2)
        d.angle_arc(origin, p3, p2, label=f"{angle1}°")
        d.angle_arc(origin, p2, p1, label="?")
        
        return problem(
            question=f"Two angles are supplementary. If one angle measures ${angle1}°$, what is the measure of the other angle?",
            answer=angle2,
            difficulty=(1000, 1100),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Supplementary angles sum to $180°$",
                f"$180° - {angle1}° = {angle2}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 3:
        # Vertical angles are equal
        angle = randint(30, 150)
        
        d = Diagram(width=300, height=300, padding=30)
        d.line((-3, -2), (3, 2))
        d.line((-2, 3), (2, -3))
        origin = (0, 0)
        
        # Mark one pair of vertical angles
        p1 = (3, 2)
        p2 = (2, -3)
        p3 = (-3, -2)
        p4 = (-2, 3)
        
        d.text(1.5, 1.2, f"{angle}°")
        d.text(-1.5, -1.2, "?")
        
        return problem(
            question=f"Two lines intersect forming vertical angles. If one angle measures ${angle}°$, what is the measure of the angle vertical to it?",
            answer=angle,
            difficulty=(1000, 1100),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Vertical angles are congruent (equal)",
                f"The vertical angle also measures ${angle}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 4:
        # Linear pair: adjacent angles on a straight line sum to 180
        angle1 = randint(50, 130)
        angle2 = 180 - angle1
        
        d = Diagram(width=350, height=150, padding=30)
        origin = (0, 0)
        p1 = (-3, 0)
        p2 = (3 * cos(angle1 * 3.14159 / 180), 3 * sin(angle1 * 3.14159 / 180))
        p3 = (3, 0)
        
        d.line(p1, p3)
        d.line(origin, p2)
        d.angle_arc(origin, p3, p2, label=f"{angle1}°")
        d.angle_arc(origin, p2, p1, label="x")
        
        return problem(
            question=f"Two angles form a linear pair. If one angle measures ${angle1}°$, find $x$, the measure of the other angle.",
            answer=angle2,
            difficulty=(1100, 1200),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Angles in a linear pair are supplementary",
                f"$x + {angle1}° = 180°$",
                f"$x = 180° - {angle1}° = {angle2}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 5:
        # Finding missing angle in complementary angles using algebra
        coeff = randint(2, 4)
        const = randint(5, 20)
        # x + (coeff*x + const) = 90
        # (coeff+1)*x + const = 90
        x_val = (90 - const) // (coeff + 1)
        if x_val <= 0 or x_val >= 80:
            x_val = 20
            const = 90 - (coeff + 1) * x_val
        
        angle1_expr = f"{coeff}x + {const}" if const > 0 else f"{coeff}x - {-const}"
        
        return problem(
            question=f"Two angles are complementary. One angle measures $x°$ and the other measures $({angle1_expr})°$. Find $x$.",
            answer=x_val,
            difficulty=(1200, 1300),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Complementary angles sum to $90°$",
                f"$x + ({angle1_expr}) = 90$",
                f"${coeff + 1}x + {const} = 90$",
                f"${coeff + 1}x = {90 - const}$",
                f"$x = {x_val}°$"
            )
        )
    
    else:
        # Finding missing angle in supplementary angles using algebra
        coeff = randint(2, 3)
        const = randint(10, 40)
        # x + (coeff*x + const) = 180
        x_val = (180 - const) // (coeff + 1)
        if x_val <= 0 or x_val >= 160:
            x_val = 40
            const = 180 - (coeff + 1) * x_val
        
        angle1_expr = f"{coeff}x + {const}" if const > 0 else f"{coeff}x - {-const}"
        
        return problem(
            question=f"Two angles are supplementary. One angle measures $x°$ and the other measures $({angle1_expr})°$. Find $x$.",
            answer=x_val,
            difficulty=(1200, 1300),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Supplementary angles sum to $180°$",
                f"$x + ({angle1_expr}) = 180$",
                f"${coeff + 1}x + {const} = 180$",
                f"${coeff + 1}x = {180 - const}$",
                f"$x = {x_val}°$"
            )
        )

emit(generate())