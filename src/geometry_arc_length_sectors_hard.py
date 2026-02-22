"""
geometry - arc_length_sectors (hard)
Generated: 2026-02-22T04:11:36.189916
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Arc length with angle conversions or complex calculations
        radius = randint(5, 20)
        # Use angles that require conversion or aren't simple
        angle_deg = choice([30, 45, 60, 72, 120, 135, 150, 225, 240, 270, 315])
        angle_rad = angle_deg * pi / 180
        arc_len = radius * angle_rad
        
        return problem(
            question=f"A circle has radius ${radius}$ units. Find the exact arc length subtended by a central angle of ${angle_deg}^\\circ$.",
            answer=arc_len,
            difficulty=(1600, 1700),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: $\\theta = {angle_deg}^\\circ \\cdot \\frac{{\\pi}}{{180^\\circ}} = {latex(angle_rad)}$",
                f"Arc length formula: $s = r\\theta$",
                f"$s = {radius} \\cdot {latex(angle_rad)} = {latex(arc_len)}$ units"
            ),
        )
    
    elif problem_type == 2:
        # Sector area with perimeter constraint
        radius = randint(6, 15)
        arc_multiplier = choice([Rational(1, 3), Rational(1, 4), Rational(2, 5), Rational(3, 8)])
        circumference = 2 * pi * radius
        arc_len = arc_multiplier * circumference
        theta = 2 * pi * arc_multiplier
        sector_area = Rational(1, 2) * radius**2 * theta
        
        return problem(
            question=f"A sector of a circle with radius ${radius}$ units has an arc length of ${latex(arc_len)}$ units. Find the exact area of the sector.",
            answer=sector_area,
            difficulty=(1650, 1750),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Find the central angle using $s = r\\theta$",
                f"$\\theta = \\frac{{s}}{{r}} = \\frac{{{latex(arc_len)}}}{{{radius}}} = {latex(theta)}$ radians",
                f"Sector area formula: $A = \\frac{{1}}{{2}}r^2\\theta$",
                f"$A = \\frac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(theta)} = {latex(sector_area)}$ square units"
            ),
        )
    
    elif problem_type == 3:
        # Find radius given arc length and angle
        theta_deg = choice([40, 50, 72, 80, 100, 144, 160])
        theta_rad = theta_deg * pi / 180
        radius = randint(8, 18)
        arc_len = radius * theta_rad
        
        return problem(
            question=f"An arc of length ${latex(arc_len)}$ units is subtended by a central angle of ${theta_deg}^\\circ$. Find the radius of the circle.",
            answer=radius,
            difficulty=(1600, 1700),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: $\\theta = {theta_deg}^\\circ \\cdot \\frac{{\\pi}}{{180^\\circ}} = {latex(theta_rad)}$",
                f"Arc length formula: $s = r\\theta$, so $r = \\frac{{s}}{{\\theta}}$",
                f"$r = \\frac{{{latex(arc_len)}}}{{{latex(theta_rad)}}} = {radius}$ units"
            ),
        )
    
    elif problem_type == 4:
        # Sector with given perimeter, find area
        radius = randint(8, 16)
        theta = choice([Rational(2, 3), Rational(3, 4), Rational(4, 5), Rational(5, 6)]) * pi
        arc_len = radius * theta
        perimeter = 2 * radius + arc_len
        sector_area = Rational(1, 2) * radius**2 * theta
        
        return problem(
            question=f"A sector has a perimeter of ${latex(perimeter)}$ units and a radius of ${radius}$ units. Find the exact area of the sector.",
            answer=sector_area,
            difficulty=(1700, 1800),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Perimeter of sector: $P = 2r + s$ where $s$ is arc length",
                f"${latex(perimeter)} = 2({radius}) + s$",
                f"$s = {latex(perimeter)} - {2*radius} = {latex(arc_len)}$ units",
                f"Find angle: $\\theta = \\frac{{s}}{{r}} = \\frac{{{latex(arc_len)}}}{{{radius}}} = {latex(theta)}$ radians",
                f"Sector area: $A = \\frac{{1}}{{2}}r^2\\theta = \\frac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(theta)} = {latex(sector_area)}$ square units"
            ),
        )
    
    else:
        # Two concentric circles, find area between arcs
        r1 = randint(5, 12)
        r2 = r1 + randint(4, 8)
        angle_deg = choice([60, 90, 120, 135, 150])
        theta = angle_deg * pi / 180
        
        # Area of annular sector
        area = Rational(1, 2) * (r2**2 - r1**2) * theta
        
        return problem(
            question=f"Two concentric circles have radii ${r1}$ units and ${r2}$ units. Find the exact area of the region bounded by the two circles and two radii forming a central angle of ${angle_deg}^\\circ$.",
            answer=area,
            difficulty=(1750, 1850),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: $\\theta = {angle_deg}^\\circ \\cdot \\frac{{\\pi}}{{180^\\circ}} = {latex(theta)}$",
                f"Area of larger sector: $A_1 = \\frac{{1}}{{2}} \\cdot {r2}^2 \\cdot {latex(theta)} = {latex(Rational(1,2) * r2**2 * theta)}$",
                f"Area of smaller sector: $A_2 = \\frac{{1}}{{2}} \\cdot {r1}^2 \\cdot {latex(theta)} = {latex(Rational(1,2) * r1**2 * theta)}$",
                f"Area between: $A_1 - A_2 = {latex(area)}$ square units"
            ),
        )

emit(generate())