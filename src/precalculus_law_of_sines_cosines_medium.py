"""
precalculus - law_of_sines_cosines (medium)
Generated: 2026-02-22T04:50:34.007863
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['sss_law_of_cosines', 'sas_law_of_cosines', 'asa_law_of_sines', 'aas_law_of_sines', 'ssa_law_of_sines'])
    
    if problem_type == 'sss_law_of_cosines':
        # Given three sides, find an angle using law of cosines
        side_a = randint(5, 12)
        side_b = randint(5, 12)
        side_c = randint(max(2, abs(side_a - side_b) + 1), side_a + side_b - 1)
        
        # Use law of cosines: c^2 = a^2 + b^2 - 2ab*cos(C)
        # cos(C) = (a^2 + b^2 - c^2) / (2ab)
        cos_C = (side_a**2 + side_b**2 - side_c**2) / (2 * side_a * side_b)
        angle_C_rad = acos(cos_C)
        angle_C_deg = float(angle_C_rad * 180 / pi)
        
        d = Diagram(width=300, height=250, padding=40)
        p1 = (0, 0)
        p2 = (side_c, 0)
        p3_x = side_b * cos(angle_C_rad)
        p3_y = side_b * sin(angle_C_rad)
        p3 = (float(p3_x), float(p3_y))
        
        d.polygon([p1, p2, p3], labels=['A', 'B', 'C'])
        d.segment_label(p1, p2, f'{side_c}')
        d.segment_label(p2, p3, f'{side_a}')
        d.segment_label(p3, p1, f'{side_b}')
        
        return problem(
            question=f"In triangle $ABC$, side $a = {side_a}$, side $b = {side_b}$, and side $c = {side_c}$. Find angle $C$ in degrees. Round to the nearest tenth.",
            answer=round(angle_C_deg, 1),
            difficulty=(1400, 1500),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Cosines: $c^2 = a^2 + b^2 - 2ab\\cos(C)$",
                f"Rearrange: $\\cos(C) = \\frac{{a^2 + b^2 - c^2}}{{2ab}}$",
                f"$\\cos(C) = \\frac{{{side_a}^2 + {side_b}^2 - {side_c}^2}}{{2({side_a})({side_b})}} = \\frac{{{side_a**2 + side_b**2 - side_c**2}}}{{{2*side_a*side_b}}}$",
                f"$C = \\cos^{{-1}}\\left({round(cos_C, 4)}\\right) \\approx {round(angle_C_deg, 1)}°$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    elif problem_type == 'sas_law_of_cosines':
        # Given two sides and included angle, find third side
        side_a = randint(6, 15)
        side_b = randint(6, 15)
        angle_C_deg = randint(30, 150)
        angle_C_rad = angle_C_deg * pi / 180
        
        # c^2 = a^2 + b^2 - 2ab*cos(C)
        c_squared = side_a**2 + side_b**2 - 2*side_a*side_b*cos(angle_C_rad)
        side_c = float(sqrt(c_squared))
        
        d = Diagram(width=300, height=250, padding=40)
        p1 = (0, 0)
        p2 = (side_a, 0)
        p3_x = side_b * cos(angle_C_rad)
        p3_y = side_b * sin(angle_C_rad)
        p3 = (float(p3_x), float(p3_y))
        
        d.polygon([p1, p2, p3], labels=['C', 'B', 'A'])
        d.segment_label(p1, p2, f'{side_a}')
        d.segment_label(p1, p3, f'{side_b}')
        d.angle_arc(p1, p2, p3, f'{angle_C_deg}°')
        
        return problem(
            question=f"In triangle $ABC$, side $a = {side_a}$, side $b = {side_b}$, and angle $C = {angle_C_deg}°$. Find side $c$. Round to the nearest tenth.",
            answer=round(side_c, 1),
            difficulty=(1300, 1400),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Cosines: $c^2 = a^2 + b^2 - 2ab\\cos(C)$",
                f"$c^2 = {side_a}^2 + {side_b}^2 - 2({side_a})({side_b})\\cos({angle_C_deg}°)$",
                f"$c^2 = {side_a**2} + {side_b**2} - {2*side_a*side_b}\\cos({angle_C_deg}°)$",
                f"$c = \\sqrt{{{round(float(c_squared), 2)}}} \\approx {round(side_c, 1)}$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    elif problem_type == 'asa_law_of_sines':
        # Given two angles and included side, find another side
        angle_A_deg = randint(35, 75)
        angle_B_deg = randint(35, 75)
        angle_C_deg = 180 - angle_A_deg - angle_B_deg
        
        side_c = randint(8, 20)
        
        # Law of sines: a/sin(A) = c/sin(C)
        # a = c * sin(A) / sin(C)
        angle_A_rad = angle_A_deg * pi / 180
        angle_C_rad = angle_C_deg * pi / 180
        side_a = float(side_c * sin(angle_A_rad) / sin(angle_C_rad))
        
        return problem(
            question=f"In triangle $ABC$, angle $A = {angle_A_deg}°$, angle $B = {angle_B_deg}°$, and side $c = {side_c}$. Find side $a$. Round to the nearest tenth.",
            answer=round(side_a, 1),
            difficulty=(1300, 1400),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"First find angle $C$: $C = 180° - {angle_A_deg}° - {angle_B_deg}° = {angle_C_deg}°$",
                f"Use the Law of Sines: $\\frac{{a}}{{\\sin(A)}} = \\frac{{c}}{{\\sin(C)}}$",
                f"$a = \\frac{{c \\cdot \\sin(A)}}{{\\sin(C)}} = \\frac{{{side_c} \\cdot \\sin({angle_A_deg}°)}}{{\\sin({angle_C_deg}°)}}$",
                f"$a \\approx {round(side_a, 1)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'aas_law_of_sines':
        # Given two angles and a non-included side, find another side
        angle_A_deg = randint(40, 80)
        angle_B_deg = randint(40, 80)
        angle_C_deg = 180 - angle_A_deg - angle_B_deg
        
        side_a = randint(10, 25)
        
        # Find side b using law of sines: a/sin(A) = b/sin(B)
        angle_A_rad = angle_A_deg * pi / 180
        angle_B_rad = angle_B_deg * pi / 180
        side_b = float(side_a * sin(angle_B_rad) / sin(angle_A_rad))
        
        return problem(
            question=f"In triangle $ABC$, angle $A = {angle_A_deg}°$, angle $B = {angle_B_deg}°$, and side $a = {side_a}$. Find side $b$. Round to the nearest tenth.",
            answer=round(side_b, 1),
            difficulty=(1400, 1500),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Sines: $\\frac{{a}}{{\\sin(A)}} = \\frac{{b}}{{\\sin(B)}}$",
                f"$b = \\frac{{a \\cdot \\sin(B)}}{{\\sin(A)}} = \\frac{{{side_a} \\cdot \\sin({angle_B_deg}°)}}{{\\sin({angle_A_deg}°)}}$",
                f"$b \\approx {round(side_b, 1)}$"
            ),
            calculator="scientific"
        )
    
    else:  # ssa_law_of_sines
        # Given two sides and non-included angle, find another angle
        side_a = randint(12, 20)
        angle_A_deg = randint(35, 60)
        side_b = randint(int(side_a * 0.6), int(side_a * 0.9))
        
        # Law of sines: a/sin(A) = b/sin(B)
        # sin(B) = b*sin(A)/a
        angle_A_rad = angle_A_deg * pi / 180
        sin_B = side_b * sin(angle_A_rad) / side_a
        
        if sin_B > 1:
            side_b = int(side_a * 0.7)
            sin_B = side_b * sin(angle_A_rad) / side_a
        
        angle_B_rad = asin(sin_B)
        angle_B_deg = float(angle_B_rad * 180 / pi)
        
        return problem(
            question=f"In triangle $ABC$, side $a = {side_a}$, side $b = {side_b}$, and angle $A = {angle_A_deg}°$. Find angle $B$ (the acute angle). Round to the nearest tenth.",
            answer=round(angle_B_deg, 1),
            difficulty=(1500, 1600),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the Law of Sines: $\\frac{{a}}{{\\sin(A)}} = \\frac{{b}}{{\\sin(B)}}$",
                f"$\\sin(B) = \\frac{{b \\cdot \\sin(A)}}{{a}} = \\frac{{{side_b} \\cdot \\sin({angle_A_deg}°)}}{{{side_a}}}$",
                f"$\\sin(B) \\approx {round(float(sin_B), 4)}$",
                f"$B = \\sin^{{-1}}({round(float(sin_B), 4)}) \\approx {round(angle_B_deg, 1)}°$"
            ),
            calculator="scientific"
        )

emit(generate())