"""
geometry - triangle_congruence (medium)
Generated: 2026-02-22T04:06:40.688032
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # SSS Congruence - given three sides, determine if triangles are congruent
        side1 = randint(3, 8)
        side2 = randint(4, 9)
        side3 = randint(5, 10)
        
        # Make sure triangle inequality holds
        while side1 + side2 <= side3 or side1 + side3 <= side2 or side2 + side3 <= side1:
            side3 = randint(5, 10)
        
        # Second triangle - sometimes congruent, sometimes not
        if randint(0, 1) == 0:
            # Make congruent
            sides2 = [side1, side2, side3]
            from random import shuffle
            shuffle(sides2)
            ans = True
        else:
            # Make not congruent by changing one side
            sides2 = [side1, side2, side3 + randint(1, 3)]
            ans = False
        
        d = Diagram(width=400, height=200, padding=20)
        
        # First triangle
        p1 = (0, 0)
        p2 = (side1 * 15, 0)
        p3 = (side1 * 7.5, side2 * 12)
        d.polygon([p1, p2, p3], labels=['A', 'B', 'C'])
        d.segment_label(p1, p2, str(side1))
        d.segment_label(p2, p3, str(side2))
        d.segment_label(p3, p1, str(side3))
        
        # Second triangle
        q1 = (side1 * 20, 0)
        q2 = (side1 * 20 + sides2[0] * 15, 0)
        q3 = (side1 * 20 + sides2[0] * 7.5, sides2[1] * 12)
        d.polygon([q1, q2, q3], labels=['D', 'E', 'F'])
        d.segment_label(q1, q2, str(sides2[0]))
        d.segment_label(q2, q3, str(sides2[1]))
        d.segment_label(q3, q1, str(sides2[2]))
        
        return problem(
            question=f"Are triangles ABC and DEF congruent? Triangle ABC has sides {side1}, {side2}, {side3}. Triangle DEF has sides {sides2[0]}, {sides2[1]}, {sides2[2]}.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="geometry/triangle_congruence",
            solution=steps(
                f"Check if all three sides match (SSS congruence)",
                f"Triangle ABC: sides {side1}, {side2}, {side3}",
                f"Triangle DEF: sides {sides2[0]}, {sides2[1]}, {sides2[2]}",
                f"{'All sides match, triangles are congruent by SSS' if ans else 'Sides do not all match, triangles are not congruent'}",
            ),
            image=d.render(),
        )
    
    elif problem_type == 2:
        # SAS Congruence - given two sides and included angle
        side_a = randint(4, 9)
        side_b = randint(5, 10)
        angle = choice([30, 45, 60, 90, 120])
        
        # Second triangle
        if randint(0, 1) == 0:
            # Congruent
            side_a2, side_b2, angle2 = side_a, side_b, angle
            ans = True
        else:
            # Not congruent - change the angle
            angle2 = angle + choice([-30, -15, 15, 30])
            if angle2 <= 0 or angle2 >= 180:
                angle2 = angle + 30
            side_a2, side_b2 = side_a, side_b
            ans = False
        
        return problem(
            question=f"Triangle ABC has AB = {side_a}, BC = {side_b}, and angle B = {angle}°. Triangle DEF has DE = {side_a2}, EF = {side_b2}, and angle E = {angle2}°. Are the triangles congruent by SAS?",
            answer=ans,
            difficulty=(1400, 1500),
            topic="geometry/triangle_congruence",
            solution=steps(
                f"For SAS congruence, two sides and the included angle must match",
                f"Triangle ABC: sides {side_a}, {side_b} with included angle {angle}°",
                f"Triangle DEF: sides {side_a2}, {side_b2} with included angle {angle2}°",
                f"{'Sides and included angle match, triangles are congruent by SAS' if ans else 'The included angles differ, triangles are not congruent'}",
            ),
        )
    
    elif problem_type == 3:
        # ASA Congruence - given two angles and included side
        angle1 = choice([30, 40, 50, 60])
        angle2 = choice([40, 50, 60, 70])
        while angle1 + angle2 >= 180:
            angle2 = choice([40, 50, 60, 70])
        
        side = randint(5, 12)
        
        # Second triangle
        if randint(0, 1) == 0:
            # Congruent
            angle1_2, angle2_2, side2 = angle1, angle2, side
            ans = True
        else:
            # Not congruent - change one angle
            angle1_2 = angle1 + choice([10, 15, 20])
            angle2_2, side2 = angle2, side
            ans = False
        
        return problem(
            question=f"Triangle ABC has angle A = {angle1}°, angle B = {angle2}°, and side AB = {side}. Triangle DEF has angle D = {angle1_2}°, angle E = {angle2_2}°, and side DE = {side2}. Are the triangles congruent by ASA?",
            answer=ans,
            difficulty=(1400, 1500),
            topic="geometry/triangle_congruence",
            solution=steps(
                f"For ASA congruence, two angles and the included side must match",
                f"Triangle ABC: angles {angle1}° and {angle2}° with included side {side}",
                f"Triangle DEF: angles {angle1_2}° and {angle2_2}° with included side {side2}",
                f"{'Angles and included side match, triangles are congruent by ASA' if ans else 'The angles do not match, triangles are not congruent'}",
            ),
        )
    
    else:
        # Identify congruence theorem from given information
        theorem_choice = randint(1, 3)
        
        if theorem_choice == 1:
            # SSS setup
            s1, s2, s3 = randint(4, 8), randint(5, 9), randint(6, 10)
            while s1 + s2 <= s3 or s1 + s3 <= s2 or s2 + s3 <= s1:
                s3 = randint(6, 10)
            
            return problem(
                question=f"Triangle ABC has sides AB = {s1}, BC = {s2}, AC = {s3}. Triangle DEF has sides DE = {s1}, EF = {s2}, DF = {s3}. Which congruence theorem proves these triangles are congruent?",
                answer="SSS",
                difficulty=(1300, 1400),
                topic="geometry/triangle_congruence",
                solution=steps(
                    f"We are given all three sides of both triangles",
                    f"AB = DE = {s1}, BC = EF = {s2}, AC = DF = {s3}",
                    f"All three pairs of corresponding sides are equal",
                    f"Therefore, the triangles are congruent by SSS (Side-Side-Side)",
                ),
            )
        
        elif theorem_choice == 2:
            # SAS setup
            s1, s2 = randint(5, 10), randint(6, 11)
            ang = choice([45, 60, 90])
            
            return problem(
                question=f"Triangle ABC has AB = {s1}, BC = {s2}, and angle B = {ang}°. Triangle DEF has DE = {s1}, EF = {s2}, and angle E = {ang}°. Which congruence theorem proves these triangles are congruent?",
                answer="SAS",
                difficulty=(1400, 1500),
                topic="geometry/triangle_congruence",
                solution=steps(
                    f"We are given two sides and the included angle of both triangles",
                    f"AB = DE = {s1}, BC = EF = {s2}, and angle B = angle E = {ang}°",
                    f"Two pairs of sides and the included angles are equal",
                    f"Therefore, the triangles are congruent by SAS (Side-Angle-Side)",
                ),
            )
        
        else:
            # ASA setup
            ang1, ang2 = choice([40, 50, 60]), choice([50, 60, 70])
            while ang1 + ang2 >= 180:
                ang2 = choice([50, 60, 70])
            side = randint(7, 12)
            
            return problem(
                question=f"Triangle ABC has angle A = {ang1}°, angle C = {ang2}°, and side AC = {side}. Triangle DEF has angle D = {ang1}°, angle F = {ang2}°, and side DF = {side}. Which congruence theorem proves these triangles are congruent?",
                answer="ASA",
                difficulty=(1400, 1500),
                topic="geometry/triangle_congruence",
                solution=steps(
                    f"We are given two angles and the included side of both triangles",
                    f"Angle A = angle D = {ang1}°, angle C = angle F = {ang2}°, and AC = DF = {side}",
                    f"Two pairs of angles and the included sides are equal",
                    f"Therefore, the triangles are congruent by ASA (Angle-Side-Angle)",
                ),
            )

emit(generate())