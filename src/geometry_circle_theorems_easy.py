"""
geometry - circle_theorems (easy)
Generated: 2026-02-22T04:09:17.076830
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Central angle equals arc (1000-1100)
        angle = choice([30, 45, 60, 90, 120, 135, 150])
        
        d = Diagram(width=280, height=280, padding=30)
        d.circle((0, 0), 100)
        d.line((0, 0), (100, 0))
        angle_rad = angle * 3.14159 / 180
        end_x = 100 * cos(angle_rad)
        end_y = 100 * sin(angle_rad)
        d.line((0, 0), (end_x, end_y))
        d.point(0, 0, "O")
        d.point(100, 0, "A")
        d.point(end_x, end_y, "B")
        d.angle_arc((0, 0), (100, 0), (end_x, end_y), f"{angle}°")
        
        return problem(
            question=f"A circle has center $O$ with points $A$ and $B$ on the circle. The central angle $\\angle AOB = {angle}°$. What is the measure of arc $AB$ in degrees?",
            answer=angle,
            difficulty=(1000, 1100),
            topic="geometry/circle_theorems",
            solution=steps(
                f"The measure of an arc equals the measure of its central angle.",
                f"Arc $AB = {angle}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Inscribed angle theorem - basic (1100-1200)
        central_angle = choice([60, 80, 100, 120, 140, 160])
        inscribed_angle = central_angle // 2
        
        d = Diagram(width=280, height=280, padding=30)
        d.circle((0, 0), 100)
        d.point(0, 0, "O")
        d.point(100, 0, "A")
        angle_rad = central_angle * 3.14159 / 180
        end_x = 100 * cos(angle_rad)
        end_y = 100 * sin(angle_rad)
        d.point(end_x, end_y, "B")
        inscribed_x = 100 * cos((central_angle/2 + 90) * 3.14159 / 180)
        inscribed_y = 100 * sin((central_angle/2 + 90) * 3.14159 / 180)
        d.point(inscribed_x, inscribed_y, "C")
        d.line((inscribed_x, inscribed_y), (100, 0))
        d.line((inscribed_x, inscribed_y), (end_x, end_y))
        
        return problem(
            question=f"In a circle, the central angle $\\angle AOB = {central_angle}°$. Point $C$ is on the circle. What is the measure of the inscribed angle $\\angle ACB$ in degrees?",
            answer=inscribed_angle,
            difficulty=(1100, 1200),
            topic="geometry/circle_theorems",
            solution=steps(
                f"An inscribed angle is half the central angle that subtends the same arc.",
                f"$\\angle ACB = \\frac{{{central_angle}°}}{{2}} = {inscribed_angle}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 3:
        # Diameter subtends right angle (1150-1250)
        
        d = Diagram(width=280, height=280, padding=30)
        d.circle((0, 0), 100)
        d.point(-100, 0, "A")
        d.point(100, 0, "B")
        d.line((-100, 0), (100, 0))
        point_angle = choice([30, 45, 60, 120, 135, 150])
        angle_rad = point_angle * 3.14159 / 180
        c_x = 100 * cos(angle_rad)
        c_y = 100 * sin(angle_rad)
        d.point(c_x, c_y, "C")
        d.line((-100, 0), (c_x, c_y))
        d.line((100, 0), (c_x, c_y))
        d.right_angle((c_x, c_y), (-100, 0), (100, 0))
        
        return problem(
            question=f"In a circle, $AB$ is a diameter and point $C$ is on the circle. What is the measure of $\\angle ACB$ in degrees?",
            answer=90,
            difficulty=(1150, 1250),
            topic="geometry/circle_theorems",
            solution=steps(
                f"An angle inscribed in a semicircle (subtended by a diameter) is always a right angle.",
                f"$\\angle ACB = 90°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 4:
        # Angles in same segment equal (1200-1300)
        arc_angle = choice([80, 100, 120, 140])
        inscribed = arc_angle // 2
        
        d = Diagram(width=280, height=280, padding=30)
        d.circle((0, 0), 100)
        d.point(100, 0, "A")
        angle_rad = arc_angle * 3.14159 / 180
        b_x = 100 * cos(angle_rad)
        b_y = 100 * sin(angle_rad)
        d.point(b_x, b_y, "B")
        
        c_angle = arc_angle + 70
        c_rad = c_angle * 3.14159 / 180
        c_x = 100 * cos(c_rad)
        c_y = 100 * sin(c_rad)
        d.point(c_x, c_y, "C")
        
        d_angle = arc_angle + 110
        d_rad = d_angle * 3.14159 / 180
        d_x = 100 * cos(d_rad)
        d_y = 100 * sin(d_rad)
        d.point(d_x, d_y, "D")
        
        d.line((c_x, c_y), (100, 0))
        d.line((c_x, c_y), (b_x, b_y))
        d.line((d_x, d_y), (100, 0))
        d.line((d_x, d_y), (b_x, b_y))
        
        return problem(
            question=f"In a circle, points $A$, $B$, $C$, and $D$ lie on the circle. Both $\\angle ACB$ and $\\angle ADB$ are inscribed angles subtending the same arc $AB$. If $\\angle ACB = {inscribed}°$, what is $\\angle ADB$ in degrees?",
            answer=inscribed,
            difficulty=(1200, 1300),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Inscribed angles that subtend the same arc are equal.",
                f"$\\angle ADB = \\angle ACB = {inscribed}°$"
            ),
            image=d.render()
        )
    
    else:
        # Find arc from inscribed angle (1100-1200)
        inscribed = choice([25, 30, 35, 40, 45, 50])
        arc_measure = inscribed * 2
        
        d = Diagram(width=280, height=280, padding=30)
        d.circle((0, 0), 100)
        d.point(100, 0, "A")
        arc_rad = arc_measure * 3.14159 / 180
        b_x = 100 * cos(arc_rad)
        b_y = 100 * sin(arc_rad)
        d.point(b_x, b_y, "B")
        
        c_angle = arc_measure + 90
        c_rad = c_angle * 3.14159 / 180
        c_x = 100 * cos(c_rad)
        c_y = 100 * sin(c_rad)
        d.point(c_x, c_y, "C")
        
        d.line((c_x, c_y), (100, 0))
        d.line((c_x, c_y), (b_x, b_y))
        d.angle_arc((c_x, c_y), (100, 0), (b_x, b_y), f"{inscribed}°")
        
        return problem(
            question=f"Point $C$ is on a circle, with $\\angle ACB = {inscribed}°$ as an inscribed angle. What is the measure of arc $AB$ in degrees?",
            answer=arc_measure,
            difficulty=(1100, 1200),
            topic="geometry/circle_theorems",
            solution=steps(
                f"The arc measure is twice the inscribed angle.",
                f"Arc $AB = 2 \\times {inscribed}° = {arc_measure}°$"
            ),
            image=d.render()
        )

emit(generate())