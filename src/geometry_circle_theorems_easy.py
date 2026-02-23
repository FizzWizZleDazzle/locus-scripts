"""
geometry - circle_theorems (easy)
Generated: 2026-02-22T04:09:17.076830
"""

from problem_utils import *
from svg_utils import Diagram

# Wide pool of arc/angle measures in 10-degree increments
ARC_POOL = list(range(10, 181, 10))  # 10,20,...,170,180
CENTRAL_POOL = list(range(20, 341, 10))  # 20,...,340

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Central angle = arc measure
        angle = choice(ARC_POOL + list(range(190, 350, 10)))

        d = Diagram(width=280, height=280, padding=30)
        d.circle((0,0), 100)
        d.line((0,0),(100,0))
        angle_rad = angle * 3.14159 / 180
        end_x = 100 * cos(angle_rad)
        end_y = 100 * sin(angle_rad)
        d.line((0,0),(end_x,end_y))
        d.point(0,0,"O")
        d.point(100,0,"A")
        d.point(end_x,end_y,"B")
        d.angle_arc((0,0),(100,0),(end_x,end_y),f"{angle}°")

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
        # Inscribed angle = half central angle (or half arc)
        # Wide range: arcs from 20 to 340 in even increments
        arc = choice(list(range(20, 341, 20)))
        inscribed = arc // 2

        d = Diagram(width=280, height=280, padding=30)
        d.circle((0,0), 100)
        d.point(0,0,"O")
        d.point(100,0,"A")
        arc_rad = arc * 3.14159 / 180
        b_x = 100 * cos(arc_rad)
        b_y = 100 * sin(arc_rad)
        d.point(b_x,b_y,"B")
        c_x = 100 * cos((arc/2 + 90) * 3.14159 / 180)
        c_y = 100 * sin((arc/2 + 90) * 3.14159 / 180)
        d.point(c_x,c_y,"C")
        d.line((c_x,c_y),(100,0))
        d.line((c_x,c_y),(b_x,b_y))
        d.line((0,0),(100,0))
        d.line((0,0),(b_x,b_y))
        d.angle_arc((0,0),(100,0),(b_x,b_y),f"{arc}°")

        return problem(
            question=f"In a circle with center $O$, the central angle $\\angle AOB = {arc}°$. Point $C$ is on the major arc. What is the measure of the inscribed angle $\\angle ACB$ in degrees?",
            answer=inscribed,
            difficulty=(1100, 1200),
            topic="geometry/circle_theorems",
            solution=steps(
                f"An inscribed angle is half the central angle subtending the same arc.",
                f"$\\angle ACB = \\frac{{{arc}°}}{{2}} = {inscribed}°$"
            ),
            image=d.render()
        )

    elif problem_type == 3:
        # Diameter subtends right angle (always 90°) - vary point position
        point_angle = choice(list(range(10, 171, 10)))  # many positions

        d = Diagram(width=280, height=280, padding=30)
        d.circle((0,0),100)
        d.point(-100,0,"A")
        d.point(100,0,"B")
        d.line((-100,0),(100,0))
        angle_rad = point_angle * 3.14159 / 180
        c_x = 100 * cos(angle_rad)
        c_y = 100 * sin(angle_rad)
        d.point(c_x,c_y,"C")
        d.line((-100,0),(c_x,c_y))
        d.line((100,0),(c_x,c_y))
        d.right_angle((c_x,c_y),(-100,0),(100,0))

        return problem(
            question=f"In a circle, $AB$ is a diameter and point $C$ is on the circle (not at $A$ or $B$). What is the measure of $\\angle ACB$ in degrees?",
            answer=90,
            difficulty=(1150, 1250),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By Thales' theorem, any angle inscribed in a semicircle (subtended by a diameter) is a right angle.",
                f"$\\angle ACB = 90°$"
            ),
            image=d.render()
        )

    elif problem_type == 4:
        # Angles in same segment are equal
        arc_angle = choice(list(range(40, 181, 10)))
        inscribed = arc_angle // 2

        d = Diagram(width=280, height=280, padding=30)
        d.circle((0,0),100)
        d.point(100,0,"A")
        arc_rad = arc_angle * 3.14159 / 180
        b_x = 100 * cos(arc_rad)
        b_y = 100 * sin(arc_rad)
        d.point(b_x,b_y,"B")
        c_ang = arc_angle + randint(50, 100)
        c_x = 100 * cos(c_ang * 3.14159/180)
        c_y = 100 * sin(c_ang * 3.14159/180)
        d.point(c_x,c_y,"C")
        d_ang = c_ang + randint(30, 80)
        d_x = 100 * cos(d_ang * 3.14159/180)
        d_y = 100 * sin(d_ang * 3.14159/180)
        d.point(d_x,d_y,"D")
        d.line((c_x,c_y),(100,0))
        d.line((c_x,c_y),(b_x,b_y))
        d.line((d_x,d_y),(100,0))
        d.line((d_x,d_y),(b_x,b_y))

        return problem(
            question=f"In a circle, points $A$, $B$, $C$, $D$ lie on the circle. Inscribed angles $\\angle ACB$ and $\\angle ADB$ both subtend arc $AB$. If $\\angle ACB = {inscribed}°$, what is $\\angle ADB$?",
            answer=inscribed,
            difficulty=(1200, 1300),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Inscribed angles subtending the same arc are equal.",
                f"$\\angle ADB = \\angle ACB = {inscribed}°$"
            ),
            image=d.render()
        )

    else:
        # Find arc from inscribed angle
        inscribed = choice(list(range(10, 86, 5)))  # 10, 15, ..., 85
        arc_measure = inscribed * 2

        d = Diagram(width=280, height=280, padding=30)
        d.circle((0,0),100)
        d.point(100,0,"A")
        arc_rad = arc_measure * 3.14159/180
        b_x = 100 * cos(arc_rad)
        b_y = 100 * sin(arc_rad)
        d.point(b_x,b_y,"B")
        c_ang = arc_measure + 80
        c_x = 100 * cos(c_ang * 3.14159/180)
        c_y = 100 * sin(c_ang * 3.14159/180)
        d.point(c_x,c_y,"C")
        d.line((c_x,c_y),(100,0))
        d.line((c_x,c_y),(b_x,b_y))
        d.angle_arc((c_x,c_y),(100,0),(b_x,b_y),f"{inscribed}°")

        return problem(
            question=f"Point $C$ is on a circle. The inscribed angle $\\angle ACB = {inscribed}°$. What is the measure of arc $AB$ in degrees?",
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
