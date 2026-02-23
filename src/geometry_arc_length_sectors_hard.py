"""
geometry - arc_length_sectors (hard)
Generated: 2026-02-22T04:11:36.189916
"""

from problem_utils import *

ANGLE_POOL = [20, 30, 36, 40, 45, 50, 60, 72, 80, 90, 100, 108, 120, 135, 150, 160, 200, 225, 240, 270, 300, 315]
RADIUS_POOL = list(range(4, 22))

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Arc length with wide variety of angles and radii
        radius = choice(RADIUS_POOL)
        angle_deg = choice(ANGLE_POOL)
        angle_rad = angle_deg * pi / 180
        arc_len = simplify(radius * angle_rad)

        return problem(
            question=f"A circle has radius ${radius}$ units. Find the exact arc length subtended by a central angle of ${angle_deg}°$.",
            answer=arc_len,
            difficulty=(1600, 1700),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert: $\\theta = {angle_deg}° \\cdot \\frac{{\\pi}}{{180°}} = {latex(angle_rad)}$ rad",
                f"$s = r\\theta = {radius} \\cdot {latex(angle_rad)} = {latex(arc_len)}$ units"
            )
        )

    elif problem_type == 2:
        # Find sector area from arc length (fractional arc of circumference)
        radius = choice(RADIUS_POOL)
        frac = choice([Rational(1,3), Rational(1,4), Rational(2,5), Rational(3,8), Rational(1,6), Rational(2,7), Rational(3,10)])
        arc_len = simplify(frac * 2 * pi * radius)
        theta = simplify(2 * pi * frac)
        sector_area = simplify(Rational(1,2) * radius**2 * theta)

        return problem(
            question=f"A sector of a circle with radius ${radius}$ units has arc length ${latex(arc_len)}$ units. Find the exact area of the sector.",
            answer=sector_area,
            difficulty=(1650, 1750),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Find central angle: $\\theta = \\frac{{s}}{{r}} = \\frac{{{latex(arc_len)}}}{{{radius}}} = {latex(theta)}$ rad",
                f"Sector area: $A = \\frac{{1}}{{2}}r^2\\theta = \\frac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(theta)} = {latex(sector_area)}$ sq units"
            )
        )

    elif problem_type == 3:
        # Find radius given arc length and angle (non-trivial angle)
        angle_deg = choice([20, 36, 40, 50, 72, 80, 100, 144, 160, 200])
        radius = choice(RADIUS_POOL)
        angle_rad = angle_deg * pi / 180
        arc_len = simplify(radius * angle_rad)

        return problem(
            question=f"An arc of length ${latex(arc_len)}$ is subtended by a central angle of ${angle_deg}°$. Find the radius of the circle.",
            answer=radius,
            difficulty=(1600, 1700),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert: $\\theta = {angle_deg}° = {latex(angle_rad)}$ rad",
                f"$s = r\\theta \\Rightarrow r = \\frac{{s}}{{\\theta}} = \\frac{{{latex(arc_len)}}}{{{latex(angle_rad)}}} = {radius}$ units"
            )
        )

    elif problem_type == 4:
        # Given perimeter of sector, find area
        radius = choice(RADIUS_POOL)
        theta_frac = choice([Rational(2,3), Rational(3,4), Rational(4,5), Rational(5,6), Rational(1,2), Rational(3,5)])
        theta = theta_frac * pi
        arc_len = simplify(radius * theta)
        perimeter = simplify(2 * radius + arc_len)
        sector_area = simplify(Rational(1,2) * radius**2 * theta)

        return problem(
            question=f"A sector has radius ${radius}$ units and perimeter ${latex(perimeter)}$ units. Find the exact area of the sector.",
            answer=sector_area,
            difficulty=(1700, 1800),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Perimeter = $2r + s$: ${latex(perimeter)} = 2({radius}) + s$",
                f"Arc length: $s = {latex(perimeter)} - {2*radius} = {latex(arc_len)}$",
                f"Central angle: $\\theta = \\frac{{s}}{{r}} = \\frac{{{latex(arc_len)}}}{{{radius}}} = {latex(theta)}$ rad",
                f"Area: $A = \\frac{{1}}{{2}}r^2\\theta = \\frac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(theta)} = {latex(sector_area)}$ sq units"
            )
        )

    elif problem_type == 5:
        # Annular sector (ring between two circles)
        r1 = choice(range(3, 12))
        gap = randint(3, 8)
        r2 = r1 + gap
        angle_deg = choice([30, 45, 60, 72, 90, 120, 135, 150])
        theta = angle_deg * pi / 180

        area = simplify(Rational(1,2) * (r2**2 - r1**2) * theta)

        return problem(
            question=f"Two concentric circles have radii ${r1}$ and ${r2}$ units. Find the exact area of the region bounded by the two circles and two radii forming a central angle of ${angle_deg}°$.",
            answer=area,
            difficulty=(1750, 1850),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert: $\\theta = {angle_deg}° = {latex(theta)}$ rad",
                f"Outer sector area: $A_{{out}} = \\frac{{1}}{{2}} \\cdot {r2}^2 \\cdot {latex(theta)} = {latex(simplify(Rational(1,2)*r2**2*theta))}$",
                f"Inner sector area: $A_{{in}} = \\frac{{1}}{{2}} \\cdot {r1}^2 \\cdot {latex(theta)} = {latex(simplify(Rational(1,2)*r1**2*theta))}$",
                f"Annular sector area: $A = A_{{out}} - A_{{in}} = \\frac{{1}}{{2}}({r2}^2 - {r1}^2)\\theta = {latex(area)}$ sq units"
            )
        )

    else:
        # Find sector area given arc length and radius (using A = rs/2)
        radius = choice(RADIUS_POOL)
        angle_deg = choice(ANGLE_POOL)
        angle_rad = Rational(angle_deg, 180) * pi
        arc_len = simplify(radius * angle_rad)
        sector_area = simplify(Rational(1,2) * radius * arc_len)

        return problem(
            question=f"A sector has radius ${radius}$ and arc length ${latex(arc_len)}$. Using the formula $A = \\frac{{1}}{{2}}rs$, find the exact area of the sector.",
            answer=sector_area,
            difficulty=(1650, 1750),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use $A = \\frac{{1}}{{2}}rs$",
                f"$A = \\frac{{1}}{{2}} \\cdot {radius} \\cdot {latex(arc_len)}$",
                f"$A = {latex(sector_area)}$ square units"
            )
        )

emit(generate())
