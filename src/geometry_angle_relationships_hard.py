"""
geometry - angle_relationships (hard)
Generated: 2026-02-22T04:04:16.715129
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Multiple angle relationships in a complex figure
        # Two parallel lines cut by two transversals forming multiple angles
        angle1 = randint(40, 80)
        angle2 = randint(30, 70)
        
        # Create angles based on relationships
        # If we have parallel lines and transversals, we can use corresponding, alternate interior, etc.
        target_angle = 180 - angle1 - angle2
        
        d = Diagram(width=400, height=300, padding=40)
        
        # Draw two parallel lines
        d.line((0, 3), (10, 3))
        d.line((0, 0), (10, 0))
        
        # Draw two transversals
        d.line((2, -0.5), (5, 4))
        d.line((6, -0.5), (8, 4))
        
        # Mark angles
        d.angle_arc((3, 3), (2, 2.5), (10, 3), label=f"{angle1}°")
        d.angle_arc((7, 3), (6, 2.5), (10, 3), label=f"{angle2}°")
        d.text(4.5, 0, "x")
        
        question = f"Two parallel lines are cut by two transversals. If two angles on the top line measure ${angle1}°$ and ${angle2}°$ as shown, and these angles are on the same side of their respective transversals, find the angle $x$ formed at the intersection of the two transversals on the bottom parallel line, where $x$ is the angle corresponding to the angle formed by the two given angles."
        
        return problem(
            question=question,
            answer=target_angle,
            difficulty=(1600, 1700),
            topic="geometry/angle_relationships",
            solution=steps(
                "Since the lines are parallel, corresponding angles are equal.",
                f"The angle at the intersection on the top line between the transversals is $180° - {angle1}° - {angle2}° = {target_angle}°$",
                f"By the corresponding angles theorem, $x = {target_angle}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # System of angle equations with vertical, supplementary, and complementary angles
        coeff1 = randint(2, 4)
        coeff2 = randint(2, 4)
        const = randint(10, 30)
        
        # Two angles are supplementary: coeff1*x + const + coeff2*x = 180
        # Solve for x
        x_val = (180 - const) / (coeff1 + coeff2)
        answer = coeff1 * x_val + const
        
        question = f"Two angles are supplementary. The first angle measures $({coeff1}x + {const})°$ and the second angle measures ${coeff2}x°$. Additionally, a third angle is vertically opposite to the first angle. Find the measure of the first angle in degrees."
        
        return problem(
            question=question,
            answer=int(answer) if answer == int(answer) else answer,
            difficulty=(1650, 1750),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Since the angles are supplementary: $({coeff1}x + {const}) + {coeff2}x = 180$",
                f"${coeff1 + coeff2}x + {const} = 180$",
                f"${coeff1 + coeff2}x = {180 - const}$",
                f"$x = {x_val}$",
                f"First angle = ${coeff1}({x_val}) + {const} = {answer}°$"
            )
        )
    
    elif problem_type == 3:
        # Angles in a polygon with exterior angle theorem
        n_sides = randint(5, 7)
        
        # Create interior angles where one is unknown
        # Sum of interior angles = (n-2)*180
        total = (n_sides - 2) * 180
        
        # Create n-1 angles
        known_angles = []
        for i in range(n_sides - 1):
            known_angles.append(randint(100, 140))
        
        answer = total - sum(known_angles)
        
        angle_str = " + ".join([f"{a}°" for a in known_angles])
        
        question = f"A {n_sides}-sided polygon has interior angles measuring {angle_str}, and one unknown angle $x$. Find the measure of angle $x$ in degrees."
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1600, 1700),
            topic="geometry/angle_relationships",
            solution=steps(
                f"The sum of interior angles in a {n_sides}-sided polygon is $(n-2) \\times 180° = ({n_sides}-2) \\times 180° = {total}°$",
                f"Sum of known angles: ${' + '.join([str(a) for a in known_angles])} = {sum(known_angles)}°$",
                f"$x = {total}° - {sum(known_angles)}° = {answer}°$"
            )
        )
    
    elif problem_type == 4:
        # Complex transversal problem with algebraic expressions
        mult1 = randint(3, 5)
        mult2 = randint(2, 4)
        const1 = randint(5, 20)
        const2 = randint(5, 20)
        
        # Alternate interior angles are equal
        # mult1*x + const1 = mult2*x + const2
        x_val = (const2 - const1) / (mult1 - mult2) if mult1 != mult2 else 20
        
        if mult1 == mult2:
            mult1 += 1
            x_val = (const2 - const1) / (mult1 - mult2)
        
        angle1_val = mult1 * x_val + const1
        
        # Find a co-interior angle (supplementary)
        answer = 180 - angle1_val
        
        question = f"Two parallel lines are cut by a transversal. One alternate interior angle measures $({mult1}x + {const1})°$ and the other measures $({mult2}x + {const2})°$. Find the measure of an angle that is supplementary to the first alternate interior angle."
        
        return problem(
            question=question,
            answer=int(answer) if answer == int(answer) else answer,
            difficulty=(1700, 1800),
            topic="geometry/angle_relationships",
            solution=steps(
                f"Alternate interior angles are equal: ${mult1}x + {const1} = {mult2}x + {const2}$",
                f"${mult1 - mult2}x = {const2 - const1}$",
                f"$x = {x_val}$",
                f"First angle = ${mult1}({x_val}) + {const1} = {angle1_val}°$",
                f"Supplementary angle = $180° - {angle1_val}° = {answer}°$"
            )
        )
    
    else:  # problem_type == 5
        # Angles formed by intersecting chords/secants with arc measures
        arc1 = randint(40, 80)
        arc2 = randint(60, 100)
        arc3 = randint(30, 70)
        
        # Angle formed by two chords = (arc1 + arc2) / 2
        # Related angle uses arc3
        answer = (arc1 + arc3) / 2
        
        question = f"Two chords intersect inside a circle. The chords intercept arcs of ${arc1}°$ and ${arc2}°$ on opposite sides of one intersection point. A second angle at the intersection is formed by arcs measuring ${arc1}°$ and ${arc3}°$. Find the measure of this second angle in degrees."
        
        return problem(
            question=question,
            answer=int(answer) if answer == int(answer) else answer,
            difficulty=(1750, 1850),
            topic="geometry/angle_relationships",
            solution=steps(
                "The angle formed by two chords intersecting inside a circle equals half the sum of the intercepted arcs.",
                f"Second angle = $\\frac{{{arc1}° + {arc3}°}}{{2}}$",
                f"Second angle = $\\frac{{{arc1 + arc3}°}}{{2}} = {answer}°$"
            )
        )

emit(generate())