"""
precalculus - law_of_sines_cosines (hard)
Generated: 2026-02-22T04:51:09.857760
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Ambiguous case (SSA) with two solutions
        side_a = randint(8, 15)
        angle_A = randint(25, 40)
        side_b = randint(side_a + 2, side_a + 8)
        
        # Calculate angle B using law of sines (will have two solutions)
        sin_B = side_b * sin(angle_A * pi / 180) / side_a
        angle_B1 = float(asin(sin_B) * 180 / pi)
        angle_B2 = 180 - angle_B1
        
        # Check both are valid
        angle_C1 = 180 - angle_A - angle_B1
        angle_C2 = 180 - angle_A - angle_B2
        
        if angle_C1 > 0 and angle_C2 > 0:
            # Find side c for both triangles
            side_c1 = side_a * sin(angle_C1 * pi / 180) / sin(angle_A * pi / 180)
            side_c2 = side_a * sin(angle_C2 * pi / 180) / sin(angle_A * pi / 180)
            
            area1 = 0.5 * side_a * side_b * sin(angle_C1 * pi / 180)
            area2 = 0.5 * side_a * side_b * sin(angle_C2 * pi / 180)
            
            total_area = float(area1 + area2)
            ans = round(total_area, 2)
            
            d = Diagram(width=350, height=200, padding=30)
            p1 = (0, 0)
            p2 = (side_a, 0)
            angle_rad = angle_A * pi / 180
            p3_1 = (side_b * cos(angle_rad), side_b * sin(angle_rad))
            
            d.polygon([p1, p2, p3_1], labels=['B', 'C', 'A'])
            d.segment_label(p1, p2, f'{side_a}')
            d.segment_label(p1, p3_1, f'{side_b}')
            d.angle_arc(p1, p2, p3_1, f'{angle_A}°')
            
            return problem(
                question=f"In triangle $ABC$, $a = {side_a}$, $b = {side_b}$, and $\\angle A = {angle_A}°$. This is an ambiguous case (SSA) that yields two possible triangles. Find the sum of the areas of both possible triangles.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/law_of_sines_cosines",
                solution=steps(
                    f"Use Law of Sines: $\\frac{{\\sin B}}{{b}} = \\frac{{\\sin A}}{{a}}$",
                    f"$\\sin B = \\frac{{{side_b} \\cdot \\sin({angle_A}°)}}{{{side_a}}} \\approx {float(sin_B):.4f}$",
                    f"Two solutions: $B_1 \\approx {angle_B1:.2f}°$ and $B_2 \\approx {angle_B2:.2f}°$",
                    f"Triangle 1: $C_1 = {angle_C1:.2f}°$, $c_1 \\approx {float(side_c1):.2f}$",
                    f"Area$_1 = \\frac{{1}}{{2}} \\cdot {side_a} \\cdot {side_b} \\cdot \\sin({angle_C1:.2f}°) \\approx {float(area1):.2f}$",
                    f"Triangle 2: $C_2 = {angle_C2:.2f}°$, $c_2 \\approx {float(side_c2):.2f}$",
                    f"Area$_2 = \\frac{{1}}{{2}} \\cdot {side_a} \\cdot {side_b} \\cdot \\sin({angle_C2:.2f}°) \\approx {float(area2):.2f}$",
                    f"Total area = ${float(area1):.2f} + {float(area2):.2f} = {ans}$"
                ),
                calculator="scientific",
                image=d.render()
            )
    
    if problem_type == 2:
        # Law of cosines application with area calculation
        side_a = randint(10, 20)
        side_b = randint(10, 20)
        angle_C = randint(50, 130)
        
        # Calculate side c using law of cosines
        side_c_sq = side_a**2 + side_b**2 - 2*side_a*side_b*cos(angle_C * pi / 180)
        side_c = sqrt(side_c_sq)
        
        # Calculate area using formula
        area = 0.5 * side_a * side_b * sin(angle_C * pi / 180)
        ans = round(float(area), 2)
        
        d = Diagram(width=300, height=250, padding=30)
        p1 = (0, 0)
        p2 = (side_b, 0)
        angle_rad = angle_C * pi / 180
        p3 = (side_a * cos(angle_rad), side_a * sin(angle_rad))
        
        d.polygon([p1, p2, p3], labels=['C', 'A', 'B'])
        d.segment_label(p1, p3, f'{side_a}')
        d.segment_label(p1, p2, f'{side_b}')
        d.angle_arc(p1, p2, p3, f'{angle_C}°')
        
        return problem(
            question=f"In triangle $ABC$, $a = {side_a}$, $b = {side_b}$, and $\\angle C = {angle_C}°$. Find the area of the triangle.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"Use the area formula: $\\text{{Area}} = \\frac{{1}}{{2}}ab\\sin C$",
                f"$\\text{{Area}} = \\frac{{1}}{{2}} \\cdot {side_a} \\cdot {side_b} \\cdot \\sin({angle_C}°)$",
                f"$\\text{{Area}} \\approx {ans}$"
            ),
            calculator="scientific",
            image=d.render()
        )
    
    if problem_type == 3:
        # Challenging problem: find angle using law of cosines after using law of sines
        side_a = randint(12, 18)
        angle_A = randint(45, 75)
        angle_B = randint(40, 90 - angle_A)
        angle_C = 180 - angle_A - angle_B
        
        # Calculate side b using law of sines
        side_b = side_a * sin(angle_B * pi / 180) / sin(angle_A * pi / 180)
        
        # Calculate side c using law of sines
        side_c = side_a * sin(angle_C * pi / 180) / sin(angle_A * pi / 180)
        
        # Now find largest angle (opposite to largest side)
        sides = [(side_a, angle_A, 'A'), (float(side_b), angle_B, 'B'), (float(side_c), angle_C, 'C')]
        sides.sort(reverse=True)
        largest_angle = sides[0][1]
        
        ans = round(float(largest_angle), 1)
        
        return problem(
            question=f"In triangle $ABC$, $a = {side_a}$, $\\angle A = {angle_A}°$, and $\\angle B = {angle_B}°$. Find the measure of the largest angle in the triangle.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="precalculus/law_of_sines_cosines",
            solution=steps(
                f"First find $\\angle C = 180° - {angle_A}° - {angle_B}° = {angle_C}°$",
                f"Use Law of Sines to find $b$: $\\frac{{b}}{{\\sin B}} = \\frac{{a}}{{\\sin A}}$",
                f"$b = \\frac{{{side_a} \\cdot \\sin({angle_B}°)}}{{\\sin({angle_A}°)}} \\approx {float(side_b):.2f}$",
                f"Similarly, $c = \\frac{{{side_a} \\cdot \\sin({angle_C}°)}}{{\\sin({angle_A}°)}} \\approx {float(side_c):.2f}$",
                f"The largest angle is opposite the largest side",
                f"Comparing sides: $a = {side_a}$, $b \\approx {float(side_b):.2f}$, $c \\approx {float(side_c):.2f}$",
                f"The largest angle is ${ans}°$"
            ),
            calculator="scientific"
        )
    
    # problem_type == 4
    # Use both laws: law of cosines to find a side, then law of sines to find an angle
    side_a = randint(15, 25)
    side_b = randint(12, 22)
    angle_C = randint(65, 115)
    
    # Find side c using law of cosines
    side_c_sq = side_a**2 + side_b**2 - 2*side_a*side_b*cos(angle_C * pi / 180)
    side_c = sqrt(side_c_sq)
    
    # Find angle A using law of sines
    sin_A = side_a * sin(angle_C * pi / 180) / side_c
    angle_A = asin(sin_A) * 180 / pi
    
    ans = round(float(angle_A), 1)
    
    return problem(
        question=f"In triangle $ABC$, $a = {side_a}$, $b = {side_b}$, and $\\angle C = {angle_C}°$. Find the measure of $\\angle A$.",
        answer=ans,
        difficulty=(1700, 1850),
        topic="precalculus/law_of_sines_cosines",
        solution=steps(
            f"First use Law of Cosines to find side $c$:",
            f"$c^2 = a^2 + b^2 - 2ab\\cos C$",
            f"$c^2 = {side_a}^2 + {side_b}^2 - 2({side_a})({side_b})\\cos({angle_C}°)$",
            f"$c \\approx {float(side_c):.2f}$",
            f"Now use Law of Sines: $\\frac{{\\sin A}}{{a}} = \\frac{{\\sin C}}{{c}}$",
            f"$\\sin A = \\frac{{{side_a} \\cdot \\sin({angle_C}°)}}{{{float(side_c):.2f}}}$",
            f"$\\angle A \\approx {ans}°$"
        ),
        calculator="scientific"
    )

emit(generate())