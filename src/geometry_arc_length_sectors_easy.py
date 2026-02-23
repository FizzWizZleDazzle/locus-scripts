"""
geometry - arc_length_sectors (easy)
Generated: 2026-02-22T04:10:46.045590
"""

from problem_utils import *

ANGLE_POOL_DEG = [30, 45, 60, 72, 90, 120, 135, 150, 180, 270]
RADIUS_POOL = list(range(2, 16))

def generate():
    problem_type = choice(['arc_length_deg', 'sector_area_deg', 'arc_from_rad', 'angle_from_arc'])

    if problem_type == 'arc_length_deg':
        # Given radius and angle in degrees, find arc length
        radius = choice(RADIUS_POOL)
        angle_deg = choice(ANGLE_POOL_DEG)
        angle_rad = angle_deg * pi / 180
        arc_length = simplify(radius * angle_rad)

        return problem(
            question=f"Find the arc length of a circle with radius ${radius}$ and central angle ${angle_deg}°$. Leave your answer in terms of $\\pi$.",
            answer=arc_length,
            difficulty=(1000, 1200),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: ${angle_deg}° = {latex(angle_rad)}$ rad",
                f"Use arc length formula: $s = r\\theta$",
                f"$s = {radius} \\cdot {latex(angle_rad)} = {latex(arc_length)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'sector_area_deg':
        # Given radius and angle in degrees, find sector area
        radius = choice(RADIUS_POOL)
        angle_deg = choice(ANGLE_POOL_DEG)
        angle_rad = angle_deg * pi / 180
        sector_area = simplify(Rational(1,2) * radius**2 * angle_rad)

        return problem(
            question=f"Find the area of a sector with radius ${radius}$ and central angle ${angle_deg}°$. Leave your answer in terms of $\\pi$.",
            answer=sector_area,
            difficulty=(1100, 1300),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: ${angle_deg}° = {latex(angle_rad)}$ rad",
                f"Use sector area formula: $A = \\frac{{1}}{{2}}r^2\\theta$",
                f"$A = \\frac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(angle_rad)} = {latex(sector_area)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'arc_from_rad':
        # Arc length given angle in radians (simple fractions of pi)
        radius = choice([3, 4, 5, 6, 8, 9, 10, 12])
        num = choice([1, 2, 3, 4, 5])
        den = choice([2, 3, 4, 6])
        angle_rad = Rational(num, den) * pi
        arc_length = simplify(radius * angle_rad)

        return problem(
            question=f"A circle has radius ${radius}$. Find the arc length subtended by a central angle of $\\frac{{{num}\\pi}}{{{den}}}$ radians.",
            answer=arc_length,
            difficulty=(1000, 1200),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use arc length formula: $s = r\\theta$",
                f"$s = {radius} \\cdot \\frac{{{num}\\pi}}{{{den}}} = {latex(arc_length)}$"
            ),
            calculator="scientific"
        )

    else:  # angle_from_arc
        # Given arc length and radius, find angle
        radius = choice(RADIUS_POOL)
        num = choice([1, 2, 3])
        den = choice([2, 3, 4, 6])
        angle_rad = Rational(num, den) * pi
        arc_length = simplify(radius * angle_rad)

        return problem(
            question=f"A circle has radius ${radius}$ and an arc of length ${latex(arc_length)}$. Find the central angle in radians.",
            answer=angle_rad,
            difficulty=(1100, 1300),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use $s = r\\theta$, so $\\theta = \\frac{{s}}{{r}}$",
                f"$\\theta = \\frac{{{latex(arc_length)}}}{{{radius}}} = {latex(angle_rad)}$ radians"
            ),
            calculator="scientific"
        )

emit(generate())
