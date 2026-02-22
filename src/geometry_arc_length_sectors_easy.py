"""
geometry - arc_length_sectors (easy)
Generated: 2026-02-22T04:10:46.045590
"""

from problem_utils import *

def generate():
    # For arc length and sectors at 1000-1300 ELO, we want straightforward problems
    # with nice numbers (multiples of 30, 45, 60, 90 degrees or simple radian measures)
    
    problem_type = choice(['arc_length', 'sector_area', 'arc_from_angle', 'angle_from_arc'])
    
    if problem_type == 'arc_length':
        # Given radius and angle, find arc length
        # Use simple angles and radii
        radius = choice([3, 4, 5, 6, 8, 10, 12])
        
        # Use simple angles in degrees that convert nicely
        angle_deg = choice([30, 45, 60, 90, 120, 180, 270])
        angle_rad = angle_deg * pi / 180
        
        # Arc length = r * theta (theta in radians)
        arc_length = radius * angle_rad
        arc_length_simplified = simplify(arc_length)
        
        return problem(
            question=f"Find the arc length of a circle with radius ${radius}$ and central angle ${angle_deg}°$. Leave your answer in terms of $\\pi$.",
            answer=arc_length_simplified,
            difficulty=(1000, 1200),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: ${angle_deg}° = {latex(angle_rad)}$ radians",
                f"Use arc length formula: $s = r\\theta$",
                f"$s = {radius} \\cdot {latex(angle_rad)} = {latex(arc_length_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'sector_area':
        # Given radius and angle, find sector area
        radius = choice([4, 6, 8, 10, 12])
        angle_deg = choice([30, 45, 60, 90, 120, 180])
        angle_rad = angle_deg * pi / 180
        
        # Sector area = (1/2) * r^2 * theta
        sector_area = Rational(1, 2) * radius**2 * angle_rad
        sector_area_simplified = simplify(sector_area)
        
        return problem(
            question=f"Find the area of a sector with radius ${radius}$ and central angle ${angle_deg}°$. Leave your answer in terms of $\\pi$.",
            answer=sector_area_simplified,
            difficulty=(1100, 1300),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Convert angle to radians: ${angle_deg}° = {latex(angle_rad)}$ radians",
                f"Use sector area formula: $A = \\frac{{1}}{{2}}r^2\\theta$",
                f"$A = \\frac{{1}}{{2}} \\cdot {radius}^2 \\cdot {latex(angle_rad)} = {latex(sector_area_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'arc_from_angle':
        # Simple arc length with angle given in radians
        radius = choice([5, 6, 8, 10])
        
        # Use simple fractions of pi
        angle_numerator = choice([1, 2, 3, 4])
        angle_denominator = choice([2, 3, 4, 6])
        angle_rad = angle_numerator * pi / angle_denominator
        
        arc_length = radius * angle_rad
        arc_length_simplified = simplify(arc_length)
        
        return problem(
            question=f"A circle has radius ${radius}$. Find the length of an arc with central angle ${latex(angle_rad)}$ radians.",
            answer=arc_length_simplified,
            difficulty=(1000, 1200),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use arc length formula: $s = r\\theta$",
                f"$s = {radius} \\cdot {latex(angle_rad)} = {latex(arc_length_simplified)}$"
            ),
            calculator="scientific"
        )
    
    else:  # angle_from_arc
        # Given arc length and radius, find angle (simpler reverse problem)
        radius = choice([4, 5, 6, 8, 10])
        
        # Pick a nice angle that gives clean arc length
        angle_numerator = choice([1, 2, 3])
        angle_denominator = choice([2, 3, 4])
        angle_rad = angle_numerator * pi / angle_denominator
        
        arc_length = radius * angle_rad
        arc_length_simplified = simplify(arc_length)
        
        return problem(
            question=f"A circle has radius ${radius}$ and an arc of length ${latex(arc_length_simplified)}$. Find the central angle in radians.",
            answer=angle_rad,
            difficulty=(1100, 1300),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use arc length formula: $s = r\\theta$",
                f"Solve for $\\theta$: $\\theta = \\frac{{s}}{{r}}$",
                f"$\\theta = \\frac{{{latex(arc_length_simplified)}}}{{{radius}}} = {latex(angle_rad)}$"
            ),
            calculator="scientific"
        )

emit(generate())