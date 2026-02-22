"""
geometry - triangle_properties (medium)
Generated: 2026-02-22T04:05:06.279038
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Pythagorean theorem - find missing side (1300-1400)
        leg1 = randint(3, 12)
        leg2 = randint(3, 12)
        hypotenuse = sqrt(leg1**2 + leg2**2)
        
        # Make sure it's either a Pythagorean triple or a simple radical
        if hypotenuse == int(hypotenuse):
            hypotenuse = int(hypotenuse)
            
        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0, 0), (leg1, 0), (leg1, leg2)], labels=['A', 'B', 'C'])
        d.right_angle((leg1, 0), (0, 0), (leg1, leg2))
        d.segment_label((0, 0), (leg1, 0), f'{leg1}')
        d.segment_label((leg1, 0), (leg1, leg2), f'{leg2}')
        d.segment_label((0, 0), (leg1, leg2), 'c')
        
        return problem(
            question=f"In right triangle ABC, the legs have lengths {leg1} and {leg2}. Find the length of the hypotenuse $c$.",
            answer=hypotenuse,
            difficulty=(1300, 1400),
            topic="geometry/triangle_properties",
            solution=steps(
                f"Use the Pythagorean theorem: $c^2 = a^2 + b^2$",
                f"$c^2 = {leg1}^2 + {leg2}^2 = {leg1**2} + {leg2**2} = {leg1**2 + leg2**2}$",
                f"$c = \\sqrt{{{leg1**2 + leg2**2}}} = {latex(hypotenuse)}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Triangle angle sum - find missing angle (1200-1300)
        angle1 = randint(30, 80)
        angle2 = randint(30, 90)
        while angle1 + angle2 >= 180:
            angle2 = randint(30, 90)
        angle3 = 180 - angle1 - angle2
        
        return problem(
            question=f"In triangle ABC, angle A measures ${angle1}°$ and angle B measures ${angle2}°$. Find the measure of angle C in degrees.",
            answer=angle3,
            difficulty=(1200, 1300),
            topic="geometry/triangle_properties",
            solution=steps(
                f"The sum of angles in a triangle is $180°$",
                f"$\\angle C = 180° - \\angle A - \\angle B$",
                f"$\\angle C = 180° - {angle1}° - {angle2}° = {angle3}°$"
            )
        )
    
    elif problem_type == 3:
        # Isosceles triangle - find angles (1300-1400)
        vertex_angle = randint(20, 80) * 2  # Make it even for clean division
        base_angle = (180 - vertex_angle) // 2
        
        d = Diagram(width=300, height=250, padding=40)
        height = 8
        base = 6
        d.polygon([(0, 0), (base, 0), (base/2, height)], labels=['B', 'C', 'A'])
        d.tick_marks((0, 0), (base/2, height), count=1)
        d.tick_marks((base, 0), (base/2, height), count=1)
        d.segment_label((0, 0), (base/2, height), '')
        d.segment_label((base, 0), (base/2, height), '')
        
        return problem(
            question=f"In isosceles triangle ABC with $AB = AC$, the vertex angle at A measures ${vertex_angle}°$. Find the measure of angle B in degrees.",
            answer=base_angle,
            difficulty=(1300, 1400),
            topic="geometry/triangle_properties",
            solution=steps(
                f"In an isosceles triangle, the base angles are equal",
                f"Let $\\angle B = \\angle C = x$",
                f"$\\angle A + \\angle B + \\angle C = 180°$",
                f"${vertex_angle}° + x + x = 180°$",
                f"$2x = {180 - vertex_angle}°$",
                f"$x = {base_angle}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 4:
        # Triangle perimeter given sides (1200-1300)
        side1 = randint(4, 12)
        side2 = randint(4, 12)
        side3 = randint(max(abs(side1 - side2) + 1, 4), side1 + side2 - 1)
        perimeter = side1 + side2 + side3
        
        return problem(
            question=f"A triangle has sides of length ${side1}$, ${side2}$, and ${side3}$. Find the perimeter of the triangle.",
            answer=perimeter,
            difficulty=(1200, 1300),
            topic="geometry/triangle_properties",
            solution=steps(
                f"The perimeter is the sum of all three sides",
                f"$P = {side1} + {side2} + {side3} = {perimeter}$"
            )
        )
    
    else:  # problem_type == 5
        # Exterior angle theorem (1400-1500)
        remote1 = randint(40, 70)
        remote2 = randint(40, 70)
        exterior = remote1 + remote2
        
        d = Diagram(width=350, height=250, padding=40)
        d.polygon([(0, 0), (8, 0), (3, 6)], labels=['A', 'B', 'C'])
        d.line((8, 0), (11, 0))
        d.text(0.5, 1, f'{remote1}°')
        d.text(2, 5, f'{remote2}°')
        d.text(9.5, 0.5, 'x')
        
        return problem(
            question=f"In triangle ABC, an exterior angle at vertex B is marked as $x$. The remote interior angles measure ${remote1}°$ and ${remote2}°$. Find the value of $x$ in degrees.",
            answer=exterior,
            difficulty=(1400, 1500),
            topic="geometry/triangle_properties",
            solution=steps(
                f"By the exterior angle theorem, an exterior angle equals the sum of the two remote interior angles",
                f"$x = {remote1}° + {remote2}°$",
                f"$x = {exterior}°$"
            ),
            image=d.render()
        )

emit(generate())