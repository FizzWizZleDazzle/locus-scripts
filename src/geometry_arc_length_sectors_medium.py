"""
geometry - arc_length_sectors (medium)
Generated: 2026-02-22T04:11:12.522768
"""

from problem_utils import *
from svg_utils import Diagram

ANGLE_POOL_DEG = [30, 45, 60, 72, 90, 108, 120, 135, 150, 180, 216, 240, 270]
RADIUS_POOL = list(range(2, 18))

def generate():
    problem_type = choice(['arc_length', 'sector_area', 'combined', 'find_radius', 'find_angle_deg'])

    if problem_type == 'arc_length':
        radius = choice(RADIUS_POOL)
        angle_deg = choice(ANGLE_POOL_DEG)
        arc_length = simplify(Rational(angle_deg, 360) * 2 * pi * radius)

        d = Diagram(width=280, height=280, padding=40)
        d.circle((0,0), radius)
        end_x = radius * cos(angle_deg * pi / 180)
        end_y = radius * sin(angle_deg * pi / 180)
        d.line((0,0),(radius,0))
        d.line((0,0),(end_x, end_y))
        d.arc((0,0), radius*0.3, 0, angle_deg)
        d.text(radius*0.4, radius*0.15, f"{angle_deg}°")
        d.segment_label((0,0),(radius,0),str(radius))

        return problem(
            question=f"Find the arc length of a circle with radius ${radius}$ and central angle ${angle_deg}°$. Express your answer in terms of $\\pi$.",
            answer=arc_length,
            difficulty=(1300, 1450),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Arc length formula: $L = \\frac{{\\theta}}{{360°}} \\cdot 2\\pi r$",
                f"$L = \\frac{{{angle_deg}}}{{360}} \\cdot 2\\pi \\cdot {radius}$",
                f"$L = {latex(arc_length)}$"
            ),
            image=d.render()
        )

    elif problem_type == 'sector_area':
        radius = choice(RADIUS_POOL)
        angle_deg = choice(ANGLE_POOL_DEG)
        sector_area = simplify(Rational(angle_deg, 360) * pi * radius**2)

        d = Diagram(width=280, height=280, padding=40)
        d.circle((0,0), radius)
        end_x = radius * cos(angle_deg * pi / 180)
        end_y = radius * sin(angle_deg * pi / 180)
        d.line((0,0),(radius,0))
        d.line((0,0),(end_x, end_y))
        d.arc((0,0), radius, 0, angle_deg)
        d.segment_label((0,0),(radius*0.7, radius*0.4), str(radius))

        return problem(
            question=f"Find the area of a sector with radius ${radius}$ and central angle ${angle_deg}°$. Express your answer in terms of $\\pi$.",
            answer=sector_area,
            difficulty=(1300, 1450),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Sector area formula: $A = \\frac{{\\theta}}{{360°}} \\cdot \\pi r^2$",
                f"$A = \\frac{{{angle_deg}}}{{360}} \\cdot \\pi \\cdot {radius}^2$",
                f"$A = \\frac{{{angle_deg}}}{{360}} \\cdot {radius**2}\\pi$",
                f"$A = {latex(sector_area)}$"
            ),
            image=d.render()
        )

    elif problem_type == 'combined':
        # Given arc length, find sector area
        radius = choice(RADIUS_POOL)
        angle_deg = choice([45, 60, 72, 90, 108, 120, 135, 150, 180])
        arc_length = simplify(Rational(angle_deg, 360) * 2 * pi * radius)
        sector_area = simplify(Rational(angle_deg, 360) * pi * radius**2)

        return problem(
            question=f"A sector of radius ${radius}$ has arc length ${latex(arc_length)}$. Find the area of the sector. Express your answer in terms of $\\pi$.",
            answer=sector_area,
            difficulty=(1450, 1600),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Given $r = {radius}$ and $s = {latex(arc_length)}$",
                f"Find central angle: $\\theta = \\frac{{s}}{{r}} = \\frac{{{latex(arc_length)}}}{{{radius}}} = {latex(Rational(angle_deg,180)*pi)}$ rad",
                f"Convert to degrees: $\\theta = {angle_deg}°$",
                f"Sector area: $A = \\frac{{{angle_deg}}}{{360}} \\cdot \\pi \\cdot {radius}^2 = {latex(sector_area)}$"
            )
        )

    elif problem_type == 'find_radius':
        # Given arc length and angle, find radius
        angle_deg = choice(ANGLE_POOL_DEG)
        angle_rad = Rational(angle_deg, 180) * pi
        radius = choice([3, 4, 5, 6, 7, 8, 9, 10, 12, 14, 15])
        arc_length = simplify(radius * angle_rad)

        return problem(
            question=f"An arc subtends a central angle of ${angle_deg}°$ and has length ${latex(arc_length)}$. Find the radius of the circle.",
            answer=radius,
            difficulty=(1400, 1550),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: $\\theta = {angle_deg}° = {latex(angle_rad)}$ rad",
                f"Use $s = r\\theta$, so $r = \\frac{{s}}{{\\theta}}$",
                f"$r = \\frac{{{latex(arc_length)}}}{{{latex(angle_rad)}}} = {radius}$"
            ),
            calculator="scientific"
        )

    else:  # find_angle_deg
        # Given arc length and radius (integer answer in degrees)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180])
        radius = choice(RADIUS_POOL)
        arc_length = simplify(Rational(angle_deg, 360) * 2 * pi * radius)

        return problem(
            question=f"A circle of radius ${radius}$ has an arc of length ${latex(arc_length)}$. Find the central angle in degrees.",
            answer=angle_deg,
            difficulty=(1350, 1500),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use $s = \\frac{{\\theta}}{{360°}} \\cdot 2\\pi r$",
                f"${latex(arc_length)} = \\frac{{\\theta}}{{360}} \\cdot 2\\pi \\cdot {radius}$",
                f"$\\theta = \\frac{{{latex(arc_length)} \\cdot 360}}{{2\\pi \\cdot {radius}}} = {angle_deg}°$"
            ),
            calculator="scientific"
        )

emit(generate())
