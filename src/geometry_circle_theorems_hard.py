"""
geometry - circle_theorems (hard)
Generated: 2026-02-22T04:10:28.238215
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Inscribed angle theorem with algebra: 2*(inscribed) = central
        inscribed_coeff = randint(2, 6)
        inscribed_const = randint(5, 40)
        central_coeff = randint(2, 8)
        # Choose x_val first, then derive central_const
        x_val = randint(3, 15)
        inscribed_angle = inscribed_coeff * x_val + inscribed_const
        central_angle = 2 * inscribed_angle
        central_const = central_angle - central_coeff * x_val

        if central_const <= 0 or central_angle <= 0 or central_angle > 360:
            x_val = 5
            inscribed_angle = inscribed_coeff * x_val + inscribed_const
            central_angle = 2 * inscribed_angle
            central_const = central_angle - central_coeff * x_val

        return problem(
            question=f"In circle $O$, inscribed angle $\\angle APB = {inscribed_coeff}x + {inscribed_const}°$ and central angle $\\angle AOB = {central_coeff}x + {central_const}°$, both subtending the same arc $AB$. Find the measure of inscribed angle $\\angle APB$ in degrees.",
            answer=inscribed_angle,
            difficulty=(1600, 1750),
            topic="geometry/circle_theorems",
            solution=steps(
                f"By the Inscribed Angle Theorem: $\\angle AOB = 2 \\cdot \\angle APB$",
                f"${central_coeff}x + {central_const} = 2({inscribed_coeff}x + {inscribed_const})$",
                f"${central_coeff}x + {central_const} = {2*inscribed_coeff}x + {2*inscribed_const}$",
                f"${central_const - 2*inscribed_const} = {2*inscribed_coeff - central_coeff}x$",
                f"$x = {x_val}$",
                f"$\\angle APB = {inscribed_coeff}({x_val}) + {inscribed_const} = {inscribed_angle}°$"
            )
        )

    elif problem_type == 2:
        # Tangent-secant angle: angle = (large_arc - small_arc)/2
        # Wide range of arcs
        small_arc = choice(list(range(10, 101, 10)))
        large_arc = choice(list(range(small_arc + 40, 320, 10)))
        # Ensure small + large < 360 reasonably
        if small_arc + large_arc > 340:
            large_arc = 340 - small_arc
        angle = (large_arc - small_arc) // 2

        # Express arcs algebraically
        coeff1 = randint(1, 3)
        const1 = randint(5, 20)
        coeff2 = randint(2, 5)
        x_val = randint(4, 12)
        # small_arc = coeff1*x + const1 → small_arc - const1 = coeff1*x
        # Adjust const to match
        actual_const1 = small_arc - coeff1 * x_val
        if actual_const1 <= 0:
            actual_const1 = small_arc - coeff1 * 2
            x_val = 2
        actual_const2 = large_arc - coeff2 * x_val
        if actual_const2 <= 0:
            x_val = randint(2, 6)
            actual_const1 = small_arc - coeff1 * x_val
            actual_const2 = large_arc - coeff2 * x_val
            if actual_const1 <= 0 or actual_const2 <= 0:
                x_val = 1
                actual_const1 = small_arc - coeff1
                actual_const2 = large_arc - coeff2

        return problem(
            question=f"A tangent and secant from external point $P$ intercept arcs of measure $({coeff1}x + {actual_const1})°$ (near arc) and $({coeff2}x + {actual_const2})°$ (far arc). If $\\angle P = {angle}°$, find $x$.",
            answer=x_val,
            difficulty=(1650, 1800),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Tangent-secant angle $= \\frac{{1}}{{2}}(\\text{{far arc}} - \\text{{near arc}})$",
                f"${angle} = \\frac{{1}}{{2}}\\left[({coeff2}x + {actual_const2}) - ({coeff1}x + {actual_const1})\\right]$",
                f"${2*angle} = {coeff2 - coeff1}x + {actual_const2 - actual_const1}$",
                f"${2*angle - (actual_const2 - actual_const1)} = {coeff2 - coeff1}x$",
                f"$x = {x_val}$"
            )
        )

    elif problem_type == 3:
        # Power of a point - two secants from external point: PA*PB = PC*PD
        # a, b are chords (chord lengths), PA = x (near), PC = c (near)
        a = randint(2, 9)  # chord AB length
        c = randint(2, 8)  # near distance PC
        d_chord = randint(2, 9)  # chord CD length
        # x(x+a) = c(c+d): solve for x
        eq = x**2 + a*x - c**2 - d_chord*c
        sols = solve(eq, x)
        pos_sols = [s for s in sols if s > 0]
        if not pos_sols:
            # Adjust parameters
            c = 3
            d_chord = 4
            a = 5
            eq = x**2 + a*x - c**2 - d_chord*c
            sols = solve(eq, x)
            pos_sols = [s for s in sols if s > 0]
        ans = pos_sols[0]

        return problem(
            question=f"Two secants are drawn from external point $P$. The first secant intersects the circle at $A$ and $B$ with $PA = x$ and $AB = {a}$. The second intersects at $C$ and $D$ with $PC = {c}$ and $CD = {d_chord}$. Find $x$.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Power of a Point: $PA \\cdot PB = PC \\cdot PD$",
                f"$PB = x + {a}$, $PD = {c} + {d_chord} = {c + d_chord}$",
                f"$x(x + {a}) = {c} \\cdot {c + d_chord} = {c*(c+d_chord)}$",
                f"$x^2 + {a}x - {c*(c+d_chord)} = 0$",
                f"Solving: $x = {latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # Cyclic quadrilateral with algebraic angles
        coeff1 = randint(2, 5)
        const1 = randint(15, 50)
        coeff2 = randint(2, 5)
        x_val = randint(5, 18)
        # angle_A + angle_C = 180
        angle_A = coeff1 * x_val + const1
        angle_C = 180 - angle_A
        const2 = angle_C - coeff2 * x_val

        if const2 <= 0 or angle_A <= 0 or angle_C <= 0:
            x_val = 8
            angle_A = coeff1 * x_val + const1
            angle_C = 180 - angle_A
            const2 = angle_C - coeff2 * x_val
            if const2 <= 0:
                const1 = 20
                angle_A = coeff1 * x_val + const1
                angle_C = 180 - angle_A
                const2 = angle_C - coeff2 * x_val

        return problem(
            question=f"Quadrilateral $ABCD$ is inscribed in a circle. If $\\angle A = {coeff1}x + {const1}°$ and $\\angle C = {coeff2}x + {const2}°$, find $x$.",
            answer=x_val,
            difficulty=(1600, 1700),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Opposite angles of a cyclic quadrilateral are supplementary: $\\angle A + \\angle C = 180°$",
                f"$({coeff1}x + {const1}) + ({coeff2}x + {const2}) = 180$",
                f"${coeff1 + coeff2}x + {const1 + const2} = 180$",
                f"${coeff1 + coeff2}x = {180 - const1 - const2}$",
                f"$x = {x_val}$"
            )
        )

    elif problem_type == 5:
        # Chord-chord angle with algebra: angle = (arc1 + arc2)/2
        arc1_coeff = randint(2, 5)
        arc1_const = randint(10, 40)
        arc2_coeff = randint(2, 5)
        arc2_const = randint(10, 40)
        angle_val = choice(list(range(40, 91, 5)))
        x_val = randint(4, 14)

        arc1_at_x = arc1_coeff * x_val + arc1_const
        arc2_at_x = arc2_coeff * x_val + arc2_const
        # Adjust to make angle_val consistent
        actual_const2 = 2 * angle_val - arc2_coeff * x_val - arc1_coeff * x_val - arc1_const
        if actual_const2 <= 0:
            x_val = 3
            actual_const2 = 2 * angle_val - arc2_coeff * x_val - arc1_coeff * x_val - arc1_const
            if actual_const2 <= 0:
                actual_const2 = 15
                x_val = (2 * angle_val - arc1_const - actual_const2) // (arc1_coeff + arc2_coeff)

        return problem(
            question=f"Two chords intersect inside a circle at point $E$. Arc $AC = {arc1_coeff}x + {arc1_const}°$ and arc $BD = {arc2_coeff}x + {actual_const2}°$, and $\\angle AEC = {angle_val}°$. Find $x$.",
            answer=x_val,
            difficulty=(1650, 1800),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Chord-chord angle $= \\frac{{1}}{{2}}$(sum of intercepted arcs)",
                f"${angle_val} = \\frac{{1}}{{2}}\\left[({arc1_coeff}x + {arc1_const}) + ({arc2_coeff}x + {actual_const2})\\right]$",
                f"${2*angle_val} = {arc1_coeff + arc2_coeff}x + {arc1_const + actual_const2}$",
                f"${2*angle_val - arc1_const - actual_const2} = {arc1_coeff + arc2_coeff}x$",
                f"$x = {x_val}$"
            )
        )

    else:
        # Power of a point - tangent-secant: PA^2 = PB * PC
        # PA = tangent length, PB = near distance, PC = near + chord
        pa = randint(4, 12)
        pb = randint(2, pa - 1)
        # pa^2 = pb * pc  →  pc = pa^2 / pb (must be integer)
        pa_options = [v for v in range(4, 16) for pb_try in range(2, v) if (v**2) % pb_try == 0]
        pa = choice([4, 6, 8, 9, 10, 12])
        # Find pb that divides pa^2
        divisors = [d for d in range(2, pa) if (pa**2) % d == 0]
        if not divisors:
            pa, pb, pc = 6, 4, 9
        else:
            pb = choice(divisors)
            pc = pa**2 // pb
        chord_len = pc - pb

        return problem(
            question=f"From external point $P$, a tangent $PA$ and a secant $PBC$ are drawn to a circle. If $PA = {pa}$ and $PB = {pb}$, find $PC$.",
            answer=pc,
            difficulty=(1700, 1850),
            topic="geometry/circle_theorems",
            solution=steps(
                f"Power of a Point (tangent-secant): $PA^2 = PB \\cdot PC$",
                f"${pa}^2 = {pb} \\cdot PC$",
                f"${pa**2} = {pb} \\cdot PC$",
                f"$PC = \\frac{{{pa**2}}}{{{pb}}} = {pc}$"
            )
        )

emit(generate())
