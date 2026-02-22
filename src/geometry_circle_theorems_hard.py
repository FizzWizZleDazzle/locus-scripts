"""
geometry - circle_theorems (hard)
Generated: 2026-02-22T04:10:28.238215
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Inscribed angle theorem with algebra
        # Central angle is twice inscribed angle
        inscribed_coeff = randint(2, 5)
        inscribed_const = randint(10, 40)
        # Inscribed angle = inscribed_coeff * x + inscribed_const
        # Central angle = 2 * (inscribed_coeff * x + inscribed_const)
        # But central angle also given as another expression
        central_coeff = randint(3, 7)
        central_const = randint(20, 60)
        
        # Solve: 2(inscribed_coeff * x + inscribed_const) = central_coeff * x + central_const
        # 2*inscribed_coeff*x + 2*inscribed_const = central_coeff*x + central_const
        # x(2*inscribed_coeff - central_coeff) = central_const - 2*inscribed_const
        
        eq = Eq(2*(inscribed_coeff*x + inscribed_const), central_coeff*x + central_const)
        x_val = solve(eq, x)[0]
        
        # Make sure x is positive integer
        if not (isinstance(x_val, int) or x_val.is_Integer) or x_val <= 0:
            x_val = randint(5, 15)
            central_const = 2*inscribed_coeff*x_val + 2*inscribed_const - central_coeff*x_val
        
        inscribed_angle = inscribed_coeff * x_val + inscribed_const
        
        d = Diagram(width=320, height=320, padding=40)
        center = (0, 0)
        radius = 4
        
        # Draw circle
        d.circle(center, radius)
        d.point(0, 0, "O")
        
        # Points on circle for inscribed angle
        A = (radius * cos(130 * 3.14159/180), radius * sin(130 * 3.14159/180))
        B = (radius * cos(30 * 3.14159/180), radius * sin(30 * 3.14159/180))
        P = (radius * cos(100 * 3.14159/180), radius * sin(100 * 3.14159/180))
        
        d.point(A[0], A[1], "A")
        d.point(B[0], B[1], "B")
        d.point(P[0], P[1], "P")
        
        d.line(P, A)
        d.line(P, B)
        d.line(center, A)
        d.line(center, B)
        
        return problem(
            question=f"In circle O, inscribed angle ∠APB = {inscribed_coeff}x + {inscribed_const}° and central angle ∠AOB = {central_coeff}x + {central_const}°, where both angles subtend the same arc AB. Find the measure of the inscribed angle ∠APB in degrees.",
            answer=inscribed_angle,
            difficulty=(1600, 1750),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the Inscribed Angle Theorem, the central angle is twice the inscribed angle",
                f"$\\angle AOB = 2 \\cdot \\angle APB$",
                f"${central_coeff}x + {central_const} = 2({inscribed_coeff}x + {inscribed_const})$",
                f"${central_coeff}x + {central_const} = {2*inscribed_coeff}x + {2*inscribed_const}$",
                f"${central_const - 2*inscribed_const} = {2*inscribed_coeff - central_coeff}x$",
                f"$x = {x_val}$",
                f"$\\angle APB = {inscribed_coeff}({x_val}) + {inscribed_const} = {inscribed_angle}°$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Tangent-secant angle theorem
        # Angle formed = 1/2 * (difference of intercepted arcs)
        small_arc = randint(40, 80)
        large_arc = randint(120, 180)
        angle = (large_arc - small_arc) // 2
        
        # Give algebraic expressions
        coeff1 = randint(2, 4)
        const1 = randint(10, 30)
        # small_arc = coeff1*x + const1
        # large_arc = (some expression)
        # angle = given value
        
        # angle = (large_arc - small_arc)/2
        # 2*angle = large_arc - small_arc
        # large_arc = 2*angle + small_arc
        
        coeff2 = randint(3, 6)
        const2 = 2*angle + coeff1*5 + const1 - coeff2*5  # Make x=5 work nicely
        
        # Solve: (coeff2*x + const2) - (coeff1*x + const1) = 2*angle
        x_val = (2*angle - const2 + const1) // (coeff2 - coeff1)
        if x_val <= 0 or not isinstance(x_val, int):
            x_val = randint(5, 12)
            const2 = 2*angle + coeff1*x_val + const1 - coeff2*x_val
        
        ans = x_val
        
        return problem(
            question=f"A tangent and a secant are drawn to a circle from an external point P. The tangent touches the circle at T, and the secant intersects the circle at points A and B (with A closer to P). If arc TB = {coeff1}x + {const1}° and arc TA = {coeff2}x + {const2}°, and ∠TPA = {angle}°, find x.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the tangent-secant angle theorem: ∠TPA = \\frac{{1}}{{2}}(\\text{{arc TA}} - \\text{{arc TB}})",
                f"${angle} = \\frac{{1}}{{2}}\\left[({coeff2}x + {const2}) - ({coeff1}x + {const1})\\right]$",
                f"${2*angle} = {coeff2}x + {const2} - {coeff1}x - {const1}$",
                f"${2*angle} = {coeff2-coeff1}x + {const2-const1}$",
                f"${2*angle - (const2-const1)} = {coeff2-coeff1}x$",
                f"$x = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Power of a point (two secants from external point)
        # PA * PB = PC * PD
        a = randint(3, 8)
        b = randint(4, 9)
        c = randint(3, 7)
        
        # Let PA = x, AB = a, so PB = x + a
        # Let PC = c, CD = b, so PD = c + b
        # x(x+a) = c(c+b)
        # x^2 + ax - c^2 - bc = 0
        
        eq = x**2 + a*x - c**2 - b*c
        sols = solve(eq, x)
        x_val = [s for s in sols if s > 0][0]
        
        ans = x_val
        
        return problem(
            question=f"Two secants are drawn to a circle from external point P. The first secant intersects the circle at A and B, with PA = x and AB = {a}. The second secant intersects the circle at C and D, with PC = {c} and CD = {b}. Find x.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the Power of a Point theorem: $PA \\cdot PB = PC \\cdot PD$",
                f"Note that $PB = PA + AB = x + {a}$ and $PD = PC + CD = {c} + {b} = {c+b}$",
                f"$x(x + {a}) = {c} \\cdot {c+b}$",
                f"$x^2 + {a}x = {c*(c+b)}$",
                f"$x^2 + {a}x - {c*(c+b)} = 0$",
                f"Using the quadratic formula or factoring: $x = {ans}$"
            )
        )
    
    elif problem_type == 4:
        # Cyclic quadrilateral with opposite angles summing to 180
        coeff1 = randint(2, 5)
        const1 = randint(20, 50)
        coeff2 = randint(3, 6)
        
        # angle1 + angle2 = 180
        # coeff1*x + const1 + coeff2*x + const2 = 180
        # (coeff1 + coeff2)*x = 180 - const1 - const2
        
        x_val = randint(8, 20)
        const2 = 180 - const1 - (coeff1 + coeff2)*x_val
        
        if const2 < 10 or const2 > 100:
            const2 = randint(30, 60)
            x_val = (180 - const1 - const2) // (coeff1 + coeff2)
        
        ans = x_val
        
        return problem(
            question=f"Quadrilateral ABCD is inscribed in a circle. If ∠A = {coeff1}x + {const1}° and ∠C = {coeff2}x + {const2}°, find x.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/circle_theorems",
            solution=steps(
                f"In a cyclic quadrilateral, opposite angles are supplementary",
                f"$\\angle A + \\angle C = 180°$",
                f"$({coeff1}x + {const1}) + ({coeff2}x + {const2}) = 180$",
                f"${coeff1 + coeff2}x + {const1 + const2} = 180$",
                f"${coeff1 + coeff2}x = {180 - const1 - const2}$",
                f"$x = {ans}$"
            )
        )
    
    else:  # problem_type == 5
        # Chord-chord angle (angle formed by two chords = 1/2 sum of intercepted arcs)
        arc1_coeff = randint(2, 4)
        arc1_const = randint(30, 60)
        arc2_coeff = randint(3, 5)
        arc2_const = randint(40, 70)
        
        angle_val = randint(50, 80)
        
        # angle = (arc1 + arc2)/2
        # 2*angle = arc1 + arc2
        # 2*angle = (arc1_coeff*x + arc1_const) + (arc2_coeff*x + arc2_const)
        
        x_val = (2*angle_val - arc1_const - arc2_const) // (arc1_coeff + arc2_coeff)
        
        if x_val <= 0:
            x_val = randint(5, 12)
        
        ans = x_val
        
        return problem(
            question=f"Two chords AB and CD intersect inside a circle at point E. If arc AC = {arc1_coeff}x + {arc1_const}° and arc BD = {arc2_coeff}x + {arc2_const}°, and ∠AEC = {angle_val}°, find x.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="geometry/circle_theorems",
            solution=steps(
                f"When two chords intersect inside a circle, the angle formed equals half the sum of the intercepted arcs",
                f"$\\angle AEC = \\frac{{1}}{{2}}(\\text{{arc AC}} + \\text{{arc BD}})$",
                f"${angle_val} = \\frac{{1}}{{2}}\\left[({arc1_coeff}x + {arc1_const}) + ({arc2_coeff}x + {arc2_const})\\right]$",
                f"${2*angle_val} = {arc1_coeff + arc2_coeff}x + {arc1_const + arc2_const}$",
                f"${2*angle_val - (arc1_const + arc2_const)} = {arc1_coeff + arc2_coeff}x$",
                f"$x = {ans}$"
            )
        )

emit(generate())