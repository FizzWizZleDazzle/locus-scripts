"""
geometry - circle_theorems (medium)
Generated: 2026-02-22T04:09:45.790014
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['inscribed_angle', 'central_angle', 'tangent_chord', 'chord_properties', 'cyclic_quadrilateral'])
    
    if problem_type == 'inscribed_angle':
        # Inscribed angle is half the central angle subtending the same arc
        central = randint(4, 16) * 10  # 40 to 160 degrees, multiples of 10
        inscribed = central // 2
        
        d = Diagram(width=300, height=300, padding=40)
        center = (0, 0)
        radius = 100
        
        # Draw circle
        d.circle(center, radius)
        
        # Points on circle
        angle_A = 180
        angle_B = 180 + central
        angle_C = 180 + central // 2 + 30
        
        A = (radius * cos(radians(angle_A)), radius * sin(radians(angle_A)))
        B = (radius * cos(radians(angle_B)), radius * sin(radians(angle_B)))
        C = (radius * cos(radians(angle_C)), radius * sin(radians(angle_C)))
        
        # Draw center and central angle
        d.point(center[0], center[1], "O")
        d.line(center, A)
        d.line(center, B)
        
        # Draw inscribed angle
        d.point(A[0], A[1], "A")
        d.point(B[0], B[1], "B")
        d.point(C[0], C[1], "C")
        d.line(C, A)
        d.line(C, B)
        
        # Mark angles
        d.angle_arc(center, A, B, f"{central}°")
        d.angle_arc(C, A, B, "?")
        
        return problem(
            question=f"In the circle with center O, the central angle \\angle AOB = {central}°. Point C is on the circle. Find the inscribed angle \\angle ACB that subtends the same arc AB.",
            answer=inscribed,
            difficulty=(1300, 1400),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the inscribed angle theorem, an inscribed angle is half the central angle subtending the same arc.",
                f"Central angle = ${central}°$",
                f"Inscribed angle = $\\frac{{{central}°}}{{2}} = {inscribed}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'central_angle':
        # Given inscribed angle, find central angle
        inscribed = randint(3, 8) * 10  # 30 to 80 degrees
        central = inscribed * 2
        
        d = Diagram(width=300, height=300, padding=40)
        center = (0, 0)
        radius = 100
        
        d.circle(center, radius)
        
        angle_A = 180
        angle_B = 180 + central
        angle_C = 180 + central // 2 + 30
        
        A = (radius * cos(radians(angle_A)), radius * sin(radians(angle_A)))
        B = (radius * cos(radians(angle_B)), radius * sin(radians(angle_B)))
        C = (radius * cos(radians(angle_C)), radius * sin(radians(angle_C)))
        
        d.point(center[0], center[1], "O")
        d.line(center, A)
        d.line(center, B)
        
        d.point(A[0], A[1], "A")
        d.point(B[0], B[1], "B")
        d.point(C[0], C[1], "C")
        d.line(C, A)
        d.line(C, B)
        
        d.angle_arc(center, A, B, "?")
        d.angle_arc(C, A, B, f"{inscribed}°")
        
        return problem(
            question=f"In the circle with center O, the inscribed angle \\angle ACB = {inscribed}°. Find the central angle \\angle AOB that subtends the same arc AB.",
            answer=central,
            difficulty=(1300, 1400),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the inscribed angle theorem, the central angle is twice the inscribed angle subtending the same arc.",
                f"Inscribed angle = ${inscribed}°$",
                f"Central angle = $2 \\times {inscribed}° = {central}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'tangent_chord':
        # Angle between tangent and chord equals inscribed angle in alternate segment
        angle = randint(3, 8) * 10
        
        d = Diagram(width=300, height=300, padding=40)
        center = (0, 0)
        radius = 100
        
        d.circle(center, radius)
        
        # Tangent point
        T = (radius, 0)
        # Tangent line
        d.line((radius, -60), (radius, 60))
        
        # Chord from tangent point
        angle_P = 180 - 2 * angle
        P = (radius * cos(radians(angle_P)), radius * sin(radians(angle_P)))
        
        d.point(T[0], T[1], "T")
        d.point(P[0], P[1], "P")
        d.line(T, P)
        
        # Inscribed angle in alternate segment
        angle_Q = angle_P + 80
        Q = (radius * cos(radians(angle_Q)), radius * sin(radians(angle_Q)))
        d.point(Q[0], Q[1], "Q")
        d.line(Q, T)
        d.line(Q, P)
        
        d.text(radius + 20, 30, f"{angle}°")
        d.angle_arc(Q, T, P, "?")
        
        return problem(
            question=f"A line is tangent to a circle at point T. A chord TP is drawn from the point of tangency. The angle between the tangent and the chord is {angle}°. Find the inscribed angle \\angle TQP in the alternate segment.",
            answer=angle,
            difficulty=(1400, 1500),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the alternate segment theorem, the angle between a tangent and a chord equals the inscribed angle in the alternate segment.",
                f"Angle between tangent and chord = ${angle}°$",
                f"Inscribed angle in alternate segment = ${angle}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'chord_properties':
        # Perpendicular from center bisects chord
        half_chord = randint(3, 8)
        chord_length = 2 * half_chord
        radius = randint(half_chord + 1, half_chord + 5)
        distance = sqrt(radius**2 - half_chord**2)
        
        return problem(
            question=f"A chord of length {chord_length} is drawn in a circle of radius {radius}. Find the perpendicular distance from the center of the circle to the chord.",
            answer=distance,
            difficulty=(1400, 1600),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Let the perpendicular from center O to chord AB meet at M.",
                f"By the perpendicular from center theorem, M bisects AB.",
                f"So $AM = \\frac{{{chord_length}}}{{2}} = {half_chord}$",
                f"In right triangle OMA: $OM^2 + AM^2 = OA^2$",
                f"$OM^2 + {half_chord}^2 = {radius}^2$",
                f"$OM^2 = {radius**2} - {half_chord**2} = {radius**2 - half_chord**2}$",
                f"$OM = {latex(distance)}$"
            )
        )
    
    else:  # cyclic_quadrilateral
        # Opposite angles in cyclic quadrilateral sum to 180
        angle1 = randint(70, 130)
        angle2 = 180 - angle1
        
        return problem(
            question=f"A quadrilateral ABCD is inscribed in a circle. If \\angle A = {angle1}°, find \\angle C.",
            answer=angle2,
            difficulty=(1300, 1400),
            topic="geometry/circle_theorems",
            solution=steps(
                f"In a cyclic quadrilateral, opposite angles are supplementary (sum to 180°).",
                f"$\\angle A + \\angle C = 180°$",
                f"${angle1}° + \\angle C = 180°$",
                f"$\\angle C = 180° - {angle1}° = {angle2}°$"
            )
        )

emit(generate())