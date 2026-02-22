"""
geometry - arc_length_sectors (medium)
Generated: 2026-02-22T04:11:12.522768
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['arc_length', 'sector_area', 'combined'])
    
    if problem_type == 'arc_length':
        # Arc length problems
        radius = randint(3, 15)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 240, 270])
        
        # Calculate arc length: L = (θ/360) * 2πr
        arc_length = Rational(angle_deg, 360) * 2 * pi * radius
        arc_length_simplified = simplify(arc_length)
        
        # Create diagram
        d = Diagram(width=280, height=280, padding=40)
        center = (0, 0)
        d.circle(center, radius)
        
        # Draw radii
        start_point = (radius, 0)
        end_x = radius * cos(angle_deg * pi / 180)
        end_y = radius * sin(angle_deg * pi / 180)
        end_point = (end_x, end_y)
        
        d.line(center, start_point)
        d.line(center, end_point)
        d.arc(center, radius * 0.3, 0, angle_deg)
        d.text(radius * 0.4, radius * 0.15, f"{angle_deg}°")
        d.segment_label(center, start_point, str(radius))
        
        return problem(
            question=f"Find the arc length of a circle with radius ${radius}$ and central angle ${angle_deg}°$. Express your answer in terms of $\\pi$.",
            answer=arc_length_simplified,
            difficulty=(1300, 1450),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use the arc length formula: $L = \\frac{{\\theta}}{{360°}} \\cdot 2\\pi r$",
                f"Substitute $r = {radius}$ and $\\theta = {angle_deg}°$",
                f"$L = \\frac{{{angle_deg}}}{{360}} \\cdot 2\\pi \\cdot {radius}$",
                f"$L = {latex(arc_length_simplified)}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'sector_area':
        # Sector area problems
        radius = randint(4, 12)
        angle_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 240, 270])
        
        # Calculate sector area: A = (θ/360) * πr²
        sector_area = Rational(angle_deg, 360) * pi * radius**2
        sector_area_simplified = simplify(sector_area)
        
        # Create diagram
        d = Diagram(width=280, height=280, padding=40)
        center = (0, 0)
        d.circle(center, radius)
        
        # Draw sector
        start_point = (radius, 0)
        end_x = radius * cos(angle_deg * pi / 180)
        end_y = radius * sin(angle_deg * pi / 180)
        end_point = (end_x, end_y)
        
        d.line(center, start_point)
        d.line(center, end_point)
        d.arc(center, radius, 0, angle_deg)
        d.angle_arc(center, start_point, end_point, f"{angle_deg}°")
        d.segment_label(center, (radius * 0.7, radius * 0.4), str(radius))
        
        return problem(
            question=f"Find the area of a sector with radius ${radius}$ and central angle ${angle_deg}°$. Express your answer in terms of $\\pi$.",
            answer=sector_area_simplified,
            difficulty=(1300, 1450),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Use the sector area formula: $A = \\frac{{\\theta}}{{360°}} \\cdot \\pi r^2$",
                f"Substitute $r = {radius}$ and $\\theta = {angle_deg}°$",
                f"$A = \\frac{{{angle_deg}}}{{360}} \\cdot \\pi \\cdot {radius}^2$",
                f"$A = \\frac{{{angle_deg}}}{{360}} \\cdot \\pi \\cdot {radius**2}$",
                f"$A = {latex(sector_area_simplified)}$"
            ),
            image=d.render()
        )
    
    else:
        # Combined problem: given arc length, find sector area or vice versa
        radius = randint(5, 12)
        angle_deg = choice([60, 90, 120, 135, 150, 180])
        
        # Calculate arc length
        arc_length = Rational(angle_deg, 360) * 2 * pi * radius
        arc_length_simplified = simplify(arc_length)
        
        # Calculate sector area
        sector_area = Rational(angle_deg, 360) * pi * radius**2
        sector_area_simplified = simplify(sector_area)
        
        # Create diagram
        d = Diagram(width=280, height=280, padding=40)
        center = (0, 0)
        d.circle(center, radius)
        
        start_point = (radius, 0)
        end_x = radius * cos(angle_deg * pi / 180)
        end_y = radius * sin(angle_deg * pi / 180)
        end_point = (end_x, end_y)
        
        d.line(center, start_point)
        d.line(center, end_point)
        d.arc(center, radius, 0, angle_deg)
        d.segment_label(center, start_point, str(radius))
        
        return problem(
            question=f"A sector has radius ${radius}$ and arc length ${latex(arc_length_simplified)}$. Find the area of the sector. Express your answer in terms of $\\pi$.",
            answer=sector_area_simplified,
            difficulty=(1450, 1600),
            topic="geometry/arc_length_sectors",
            solution=steps(
                f"Given: $r = {radius}$ and arc length $L = {latex(arc_length_simplified)}$",
                f"Use $L = \\frac{{\\theta}}{{360°}} \\cdot 2\\pi r$ to find $\\theta$",
                f"${latex(arc_length_simplified)} = \\frac{{\\theta}}{{360°}} \\cdot 2\\pi \\cdot {radius}$",
                f"Solving: $\\theta = {angle_deg}°$",
                f"Now use $A = \\frac{{\\theta}}{{360°}} \\cdot \\pi r^2$",
                f"$A = \\frac{{{angle_deg}}}{{360}} \\cdot \\pi \\cdot {radius}^2$",
                f"$A = {latex(sector_area_simplified)}$"
            ),
            image=d.render()
        )

emit(generate())