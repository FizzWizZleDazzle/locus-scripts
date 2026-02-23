"""
geometry - circle_theorems (medium)
Generated: 2026-02-22T04:09:45.790014
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['inscribed_angle', 'central_angle', 'tangent_chord',
                           'chord_properties', 'cyclic_quadrilateral', 'chord_chord_angle'])

    if problem_type == 'inscribed_angle':
        # Inscribed angle is half the central angle - wide range
        central = choice(list(range(20, 341, 10)))  # 20 to 340 in steps of 10
        inscribed = central // 2

        d = Diagram(width=300, height=300, padding=40)
        d.circle((0,0), 100)
        d.point(0,0,"O")
        angle_A = 180
        angle_B = (180 + central) % 360
        angle_C = (angle_A + central // 2 + 30) % 360
        import math
        A = (100*math.cos(math.radians(angle_A)), 100*math.sin(math.radians(angle_A)))
        B = (100*math.cos(math.radians(angle_B)), 100*math.sin(math.radians(angle_B)))
        C = (100*math.cos(math.radians(angle_C)), 100*math.sin(math.radians(angle_C)))
        d.point(A[0],A[1],"A")
        d.point(B[0],B[1],"B")
        d.point(C[0],C[1],"C")
        d.line((0,0),A)
        d.line((0,0),B)
        d.line(C,A)
        d.line(C,B)
        d.angle_arc((0,0),A,B,f"{central}°")
        d.angle_arc(C,A,B,"?")

        return problem(
            question=f"In a circle with center $O$, the central angle $\\angle AOB = {central}°$. Point $C$ is on the circle. Find the inscribed angle $\\angle ACB$ subtending the same arc $AB$.",
            answer=inscribed,
            difficulty=(1300, 1400),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the inscribed angle theorem, an inscribed angle is half the central angle subtending the same arc.",
                f"$\\angle ACB = \\frac{{{central}°}}{{2}} = {inscribed}°$"
            ),
            image=d.render()
        )

    elif problem_type == 'central_angle':
        # Given inscribed angle, find central angle - wide range
        inscribed = choice(list(range(10, 171, 5)))  # 10 to 170 in steps of 5
        central = inscribed * 2

        return problem(
            question=f"In a circle with center $O$, the inscribed angle $\\angle ACB = {inscribed}°$. Find the central angle $\\angle AOB$ subtending the same arc $AB$.",
            answer=central,
            difficulty=(1300, 1400),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the inscribed angle theorem, the central angle is twice the inscribed angle.",
                f"$\\angle AOB = 2 \\times {inscribed}° = {central}°$"
            )
        )

    elif problem_type == 'tangent_chord':
        # Tangent-chord angle = inscribed angle in alternate segment
        angle = choice(list(range(15, 76, 5)))  # 15 to 75

        d = Diagram(width=300, height=300, padding=40)
        d.circle((0,0), 100)
        T = (100, 0)
        d.line((100,-70),(100,70))  # tangent line
        angle_P = 180 - 2*angle
        import math
        P = (100*math.cos(math.radians(angle_P)), 100*math.sin(math.radians(angle_P)))
        d.point(T[0],T[1],"T")
        d.point(P[0],P[1],"P")
        d.line(T,P)
        angle_Q = angle_P + 80
        Q = (100*math.cos(math.radians(angle_Q)), 100*math.sin(math.radians(angle_Q)))
        d.point(Q[0],Q[1],"Q")
        d.line(Q,T)
        d.line(Q,P)
        d.text(115, 25, f"{angle}°")

        return problem(
            question=f"A line is tangent to a circle at point $T$. A chord $TP$ is drawn from the tangency point. The angle between the tangent and chord $TP$ is ${angle}°$. Find the inscribed angle $\\angle TQP$ in the alternate segment.",
            answer=angle,
            difficulty=(1400, 1500),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the Tangent-Chord (Alternate Segment) Theorem, the angle between a tangent and a chord equals the inscribed angle in the alternate segment.",
                f"$\\angle TQP = {angle}°$"
            ),
            image=d.render()
        )

    elif problem_type == 'chord_properties':
        # Perpendicular from center bisects chord - varied radii and chords
        half_chord = randint(2, 12)
        chord_length = 2 * half_chord
        distance = randint(2, 10)  # perpendicular distance
        radius = simplify(sqrt(half_chord**2 + distance**2))
        # Ensure radius is reasonable
        if not radius.is_Integer:
            # Just present with sqrt answer
            pass

        return problem(
            question=f"A chord of length ${chord_length}$ is drawn in a circle of radius ${latex(radius)}$. Find the perpendicular distance from the center to the chord.",
            answer=distance,
            difficulty=(1400, 1600),
            topic="geometry/circle_theorems",
            solution=steps(
                f"The perpendicular from center $O$ bisects the chord, giving half-length ${half_chord}$",
                f"In the right triangle: $d^2 + {half_chord}^2 = {latex(radius)}^2$",
                f"$d^2 = {latex(radius**2)} - {half_chord**2} = {latex(radius**2) - half_chord**2}$",
                f"$d = {distance}$"
            )
        )

    elif problem_type == 'cyclic_quadrilateral':
        # Opposite angles in cyclic quadrilateral sum to 180°
        angle1 = choice(list(range(50, 131, 5)))  # 50 to 130 in steps of 5
        angle2 = 180 - angle1

        return problem(
            question=f"Quadrilateral $ABCD$ is inscribed in a circle. If $\\angle A = {angle1}°$, find $\\angle C$.",
            answer=angle2,
            difficulty=(1300, 1400),
            topic="geometry/circle_theorems",
            solution=steps(
                f"In a cyclic quadrilateral, opposite angles are supplementary (sum to $180°$).",
                f"$\\angle A + \\angle C = 180°$",
                f"$\\angle C = 180° - {angle1}° = {angle2}°$"
            )
        )

    else:  # chord_chord_angle
        # Two chords intersect inside circle: angle = (arc1 + arc2)/2
        arc1 = choice(list(range(20, 151, 10)))
        arc2 = choice(list(range(20, 151, 10)))
        angle = (arc1 + arc2) // 2

        return problem(
            question=f"Two chords intersect inside a circle. The two intercepted arcs measure ${arc1}°$ and ${arc2}°$. Find the measure of the angle formed at the intersection.",
            answer=angle,
            difficulty=(1450, 1600),
            topic="geometry/circle_theorems",
            solution=steps(
                f"When two chords intersect inside a circle, the angle equals half the sum of the intercepted arcs.",
                f"$\\angle = \\frac{{{arc1}° + {arc2}°}}{{2}} = \\frac{{{arc1 + arc2}°}}{{2}} = {angle}°$"
            )
        )

emit(generate())
