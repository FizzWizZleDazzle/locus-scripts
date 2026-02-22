"""
geometry - triangle_congruence (easy)
Generated: 2026-02-22T04:06:09.743831
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # SSS congruence - identify if two triangles are congruent given all three sides
        # ELO 1000-1100: Direct identification with matching sides
        side1 = randint(3, 8)
        side2 = randint(3, 8)
        side3 = randint(3, 8)
        
        # Create two triangles with same sides (possibly reordered)
        triangle1_sides = [side1, side2, side3]
        triangle2_sides = triangle1_sides.copy()
        from random import shuffle
        shuffle(triangle2_sides)
        
        question = (f"Triangle ABC has sides of length {triangle1_sides[0]}, {triangle1_sides[1]}, and {triangle1_sides[2]}. "
                   f"Triangle DEF has sides of length {triangle2_sides[0]}, {triangle2_sides[1]}, and {triangle2_sides[2]}. "
                   f"Are the triangles congruent by SSS (Side-Side-Side)?")
        
        ans = True
        
        solution = steps(
            f"Triangle ABC has sides: {triangle1_sides[0]}, {triangle1_sides[1]}, {triangle1_sides[2]}",
            f"Triangle DEF has sides: {triangle2_sides[0]}, {triangle2_sides[1]}, {triangle2_sides[2]}",
            "All three pairs of corresponding sides are equal",
            "By SSS congruence, the triangles are congruent"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="geometry/triangle_congruence",
            solution=solution
        )
    
    elif problem_type == 2:
        # SAS congruence - two sides and included angle
        # ELO 1100-1200: Direct identification with two sides and included angle
        side1 = randint(4, 9)
        side2 = randint(4, 9)
        angle = choice([30, 45, 60, 90])
        
        question = (f"Triangle ABC has AB = {side1}, BC = {side2}, and angle B = {angle}°. "
                   f"Triangle XYZ has XY = {side1}, YZ = {side2}, and angle Y = {angle}°. "
                   f"Are these triangles congruent by SAS (Side-Angle-Side)?")
        
        ans = True
        
        solution = steps(
            f"Triangle ABC: AB = {side1}, angle B = {angle}°, BC = {side2}",
            f"Triangle XYZ: XY = {side1}, angle Y = {angle}°, YZ = {side2}",
            "Two sides and the included angle are equal in both triangles",
            "By SAS congruence, the triangles are congruent"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="geometry/triangle_congruence",
            solution=solution
        )
    
    elif problem_type == 3:
        # ASA congruence - two angles and included side
        # ELO 1200-1250: Identify congruence with two angles and included side
        angle1 = choice([30, 40, 45, 50, 60])
        angle2 = choice([40, 50, 60, 70])
        side = randint(5, 10)
        
        question = (f"Triangle PQR has angle P = {angle1}°, PQ = {side}, and angle Q = {angle2}°. "
                   f"Triangle LMN has angle L = {angle1}°, LM = {side}, and angle M = {angle2}°. "
                   f"Are these triangles congruent by ASA (Angle-Side-Angle)?")
        
        ans = True
        
        solution = steps(
            f"Triangle PQR: angle P = {angle1}°, PQ = {side}, angle Q = {angle2}°",
            f"Triangle LMN: angle L = {angle1}°, LM = {side}, angle M = {angle2}°",
            "Two angles and the included side are equal in both triangles",
            "By ASA congruence, the triangles are congruent"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1250),
            topic="geometry/triangle_congruence",
            solution=solution
        )
    
    else:
        # Not congruent - slightly different measurements
        # ELO 1250-1300: Identify when triangles are NOT congruent
        side1 = randint(5, 8)
        side2 = randint(5, 8)
        side3 = randint(5, 8)
        
        # Make one side different
        side3_different = side3 + randint(1, 2)
        
        question = (f"Triangle ABC has sides of length {side1}, {side2}, and {side3}. "
                   f"Triangle DEF has sides of length {side1}, {side2}, and {side3_different}. "
                   f"Are the triangles congruent?")
        
        ans = False
        
        solution = steps(
            f"Triangle ABC has sides: {side1}, {side2}, {side3}",
            f"Triangle DEF has sides: {side1}, {side2}, {side3_different}",
            f"The third sides are different: {side3} ≠ {side3_different}",
            "The triangles are NOT congruent"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1250, 1300),
            topic="geometry/triangle_congruence",
            solution=solution
        )

emit(generate())