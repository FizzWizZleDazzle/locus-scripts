"""
precalculus - law_of_sines_cosines (easy)
Generated: 2026-02-22T04:50:00.373870
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['law_of_sines_angle', 'law_of_sines_side', 'law_of_cosines_side', 'law_of_cosines_angle'])
    
    if problem_type == 'law_of_sines_angle':
        # Given two angles and one side, find another side (ASA or AAS)
        # Keep it simple with nice angles
        angle_A = choice([30, 45, 60])
        angle_B = choice([30, 45, 60, 75, 90])
        
        # Make sure angles sum to less than 180
        if angle_A + angle_B >= 180:
            angle_B = choice([30, 45, 60])
        
        angle_C = 180 - angle_A - angle_B
        
        # Give one side length
        side_a = randint(5, 15)
        
        # Find side b using law of sines: a/sin(A) = b/sin(B)
        side_b_calc = side_a * sin(angle_B * pi / 180) / sin(angle_A * pi / 180)
        side_b = float(side_b_calc.evalf())
        
        d = Diagram(width=300, height=250)
        # Create triangle with labeled vertices
        A = (0, 0)
        B = (4, 0)
        C = (1.5, 2.5)
        d.polygon([A, B, C], labels=['A', 'B', 'C'])
        d.segment_label(B, C, f'a = {side_a}')
        d.segment_label(A, C, 'b = ?')
        d.text(0.3, 0.15, f'{angle_A}°')
        d.text(3.5, 0.15, f'{angle_B}°')
        
        return problem(
            question=f"In triangle $ABC$, $\\angle A = {angle_A}°$, $\\angle B = {angle_B}°$, and side $a = {side_a}$. Find the length of side $b$ (opposite to angle $B$). Round to two decimal places.",
            answer=round(side_b, 2),
            difficulty=(1100, 1300),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Sines: $\\frac{{a}}{{\\sin A}} = \\frac{{b}}{{\\sin B}}$",
                f"$\\frac{{{side_a}}}{{\\sin {angle_A}°}} = \\frac{{b}}{{\\sin {angle_B}°}}$",
                f"$b = {side_a} \\cdot \\frac{{\\sin {angle_B}°}}{{\\sin {angle_A}°}}$",
                f"$b = {side_a} \\cdot \\frac{{{latex(sin(angle_B * pi / 180))}}}{{{latex(sin(angle_A * pi / 180))}}}$",
                f"$b \\approx {round(side_b, 2)}$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    elif problem_type == 'law_of_sines_side':
        # Given two sides and an angle opposite one of them (SSA), find the other angle
        angle_A = choice([30, 45, 60])
        side_a = randint(5, 10)
        side_b = randint(5, 10)
        
        # Make sure we have a valid triangle (avoid ambiguous case)
        # If side_a > side_b, we're safe
        if side_a <= side_b:
            side_a = side_b + randint(2, 5)
        
        # Find angle B using law of sines
        sin_B = side_b * sin(angle_A * pi / 180) / side_a
        angle_B_rad = asin(sin_B)
        angle_B = float((angle_B_rad * 180 / pi).evalf())
        
        d = Diagram(width=300, height=250)
        A = (0, 0)
        B = (4, 0)
        C = (1.5, 2.5)
        d.polygon([A, B, C], labels=['A', 'B', 'C'])
        d.segment_label(B, C, f'a = {side_a}')
        d.segment_label(A, C, f'b = {side_b}')
        d.text(0.3, 0.15, f'{angle_A}°')
        
        return problem(
            question=f"In triangle $ABC$, side $a = {side_a}$, side $b = {side_b}$, and $\\angle A = {angle_A}°$. Find $\\angle B$ (the angle opposite side $b$). Round to two decimal places.",
            answer=round(angle_B, 2),
            difficulty=(1100, 1300),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Sines: $\\frac{{a}}{{\\sin A}} = \\frac{{b}}{{\\sin B}}$",
                f"$\\frac{{{side_a}}}{{\\sin {angle_A}°}} = \\frac{{{side_b}}}{{\\sin B}}$",
                f"$\\sin B = {side_b} \\cdot \\frac{{\\sin {angle_A}°}}{{{side_a}}}$",
                f"$\\sin B = \\frac{{{side_b} \\cdot {latex(sin(angle_A * pi / 180))}}}{{{side_a}}}$",
                f"$B = \\arcsin\\left({latex(sin_B)}\\right)$",
                f"$B \\approx {round(angle_B, 2)}°$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    elif problem_type == 'law_of_cosines_side':
        # Given two sides and included angle (SAS), find the third side
        side_a = randint(5, 12)
        side_b = randint(5, 12)
        angle_C = choice([30, 45, 60, 90, 120])
        
        # Find side c using law of cosines: c² = a² + b² - 2ab cos(C)
        c_squared = side_a**2 + side_b**2 - 2*side_a*side_b*cos(angle_C * pi / 180)
        side_c = float(sqrt(c_squared).evalf())
        
        d = Diagram(width=300, height=250)
        A = (0, 0)
        B = (4, 0)
        C = (1.5, 2.5)
        d.polygon([A, B, C], labels=['A', 'B', 'C'])
        d.segment_label(B, C, f'a = {side_a}')
        d.segment_label(A, C, f'b = {side_b}')
        d.segment_label(A, B, 'c = ?')
        d.text(1.3, 2.2, f'{angle_C}°')
        
        return problem(
            question=f"In triangle $ABC$, side $a = {side_a}$, side $b = {side_b}$, and $\\angle C = {angle_C}°$ (the angle between sides $a$ and $b$). Find the length of side $c$ (opposite to angle $C$). Round to two decimal places.",
            answer=round(side_c, 2),
            difficulty=(1100, 1300),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Cosines: $c^2 = a^2 + b^2 - 2ab\\cos C$",
                f"$c^2 = {side_a}^2 + {side_b}^2 - 2({side_a})({side_b})\\cos {angle_C}°$",
                f"$c^2 = {side_a**2} + {side_b**2} - {2*side_a*side_b}\\cos {angle_C}°$",
                f"$c^2 = {side_a**2 + side_b**2} - {2*side_a*side_b} \\cdot {latex(cos(angle_C * pi / 180))}$",
                f"$c^2 \\approx {latex(c_squared)}$",
                f"$c \\approx {round(side_c, 2)}$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    else:  # law_of_cosines_angle
        # Given three sides (SSS), find one angle
        # Use simple Pythagorean triple or near-Pythagorean for easier calculation
        side_a = randint(5, 10)
        side_b = randint(5, 10)
        side_c = randint(5, 10)
        
        # Make sure triangle inequality holds
        sides_sorted = sorted([side_a, side_b, side_c])
        if sides_sorted[0] + sides_sorted[1] <= sides_sorted[2]:
            side_c = sides_sorted[0] + sides_sorted[1] - 1
        
        # Find angle C using law of cosines: cos(C) = (a² + b² - c²) / (2ab)
        cos_C = (side_a**2 + side_b**2 - side_c**2) / (2 * side_a * side_b)
        angle_C_rad = acos(cos_C)
        angle_C = float((angle_C_rad * 180 / pi).evalf())
        
        d = Diagram(width=300, height=250)
        A = (0, 0)
        B = (4, 0)
        C = (1.5, 2.5)
        d.polygon([A, B, C], labels=['A', 'B', 'C'])
        d.segment_label(B, C, f'a = {side_a}')
        d.segment_label(A, C, f'b = {side_b}')
        d.segment_label(A, B, f'c = {side_c}')
        
        return problem(
            question=f"In triangle $ABC$, side $a = {side_a}$, side $b = {side_b}$, and side $c = {side_c}$. Find $\\angle C$ (the angle opposite side $c$). Round to two decimal places.",
            answer=round(angle_C, 2),
            difficulty=(1200, 1300),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Cosines: $\\cos C = \\frac{{a^2 + b^2 - c^2}}{{2ab}}$",
                f"$\\cos C = \\frac{{{side_a}^2 + {side_b}^2 - {side_c}^2}}{{2({side_a})({side_b})}}$",
                f"$\\cos C = \\frac{{{side_a**2} + {side_b**2} - {side_c**2}}}{{{2*side_a*side_b}}}$",
                f"$\\cos C = \\frac{{{side_a**2 + side_b**2 - side_c**2}}}{{{2*side_a*side_b}}}$",
                f"$C = \\arccos\\left({latex(cos_C)}\\right)$",
                f"$C \\approx {round(angle_C, 2)}°$"
            ),
            calculator="scientific",
            image=d.render()
        )

emit(generate())