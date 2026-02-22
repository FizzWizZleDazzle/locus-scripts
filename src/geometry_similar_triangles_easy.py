"""
geometry - similar_triangles (easy)
Generated: 2026-02-22T04:07:47.191584
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Find missing side given similar triangles with scale factor (1000-1150)
        scale = randint(2, 4)
        small_side = randint(3, 8)
        large_side = small_side * scale
        
        # Ask for the corresponding side in the larger triangle
        d = Diagram(width=400, height=200, padding=30)
        
        # Small triangle
        tri1 = [(0, 0), (small_side, 0), (small_side, small_side)]
        d.polygon(tri1, labels=['A', 'B', 'C'])
        d.segment_label((0, 0), (small_side, 0), f'{small_side}')
        
        # Large triangle (shifted right)
        offset = small_side + 4
        tri2 = [(offset, 0), (offset + large_side, 0), (offset + large_side, large_side)]
        d.polygon(tri2, labels=['D', 'E', 'F'])
        d.segment_label((offset, 0), (offset + large_side, 0), '?')
        
        # Tick marks to show similarity
        d.tick_marks((0, 0), (small_side, 0), count=1)
        d.tick_marks((offset, 0), (offset + large_side, 0), count=1)
        
        return problem(
            question=f"Triangle $ABC$ is similar to triangle $DEF$. If $AB = {small_side}$ and the scale factor from $ABC$ to $DEF$ is ${scale}$, find $DE$.",
            answer=large_side,
            difficulty=(1000, 1150),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Scale factor from $ABC$ to $DEF$ is ${scale}$",
                f"$DE = AB \\times {scale} = {small_side} \\times {scale} = {large_side}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Type 2: Simple ratio problem with two corresponding sides given (1100-1250)
        side1_small = randint(4, 9)
        side2_small = randint(3, 8)
        scale = randint(2, 3)
        side1_large = side1_small * scale
        side2_large = side2_small * scale
        
        d = Diagram(width=400, height=200, padding=30)
        
        # Small triangle
        tri1 = [(0, 0), (side1_small, 0), (side1_small * 0.7, side2_small)]
        d.polygon(tri1, labels=['P', 'Q', 'R'])
        d.segment_label((0, 0), (side1_small, 0), f'{side1_small}')
        d.segment_label((side1_small, 0), (side1_small * 0.7, side2_small), f'{side2_small}')
        
        # Large triangle
        offset = side1_small + 4
        tri2 = [(offset, 0), (offset + side1_large, 0), (offset + side1_large * 0.7, side2_large)]
        d.polygon(tri2, labels=['X', 'Y', 'Z'])
        d.segment_label((offset, 0), (offset + side1_large, 0), f'{side1_large}')
        d.segment_label((offset + side1_large, 0), (offset + side1_large * 0.7, side2_large), '?')
        
        return problem(
            question=f"Triangles $PQR$ and $XYZ$ are similar. If $PQ = {side1_small}$, $QR = {side2_small}$, and $XY = {side1_large}$, find $YZ$.",
            answer=side2_large,
            difficulty=(1100, 1250),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Since triangles are similar, corresponding sides are proportional",
                f"$\\frac{{XY}}{{PQ}} = \\frac{{YZ}}{{QR}}$",
                f"$\\frac{{{side1_large}}}{{{side1_small}}} = \\frac{{YZ}}{{{side2_small}}}$",
                f"$YZ = {side2_small} \\times \\frac{{{side1_large}}}{{{side1_small}}} = {side2_small} \\times {scale} = {side2_large}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 3:
        # Type 3: Find scale factor given two corresponding sides (1150-1300)
        side_small = randint(3, 6)
        scale_num = randint(2, 4)
        side_large = side_small * scale_num
        
        return problem(
            question=f"Two similar triangles have corresponding sides of length ${side_small}$ and ${side_large}$. What is the scale factor from the smaller triangle to the larger triangle?",
            answer=scale_num,
            difficulty=(1150, 1300),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Scale factor = $\\frac{{\\text{{larger side}}}}{{\\text{{smaller side}}}}$",
                f"Scale factor = $\\frac{{{side_large}}}{{{side_small}}} = {scale_num}$"
            )
        )
    
    else:
        # Type 4: Simple proportion setup (1200-1300)
        a = randint(2, 5)
        b = randint(3, 7)
        c = randint(2, 4)
        d = b * c // a
        
        # Ensure d is an integer
        while (b * c) % a != 0:
            a = randint(2, 5)
            b = randint(3, 7)
            c = randint(2, 4)
            d = (b * c) // a
            if (b * c) % a == 0:
                break
        
        d = (b * c) // a
        
        return problem(
            question=f"In two similar triangles, the ratio of two corresponding sides is ${a}:{b}$. If a side in the smaller triangle measures ${c}$, what is the length of the corresponding side in the larger triangle?",
            answer=d,
            difficulty=(1200, 1300),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Set up proportion: $\\frac{{{a}}}{{{b}}} = \\frac{{{c}}}{{x}}$",
                f"Cross multiply: ${a} \\cdot x = {b} \\cdot {c}$",
                f"${a}x = {b * c}$",
                f"$x = \\frac{{{b * c}}}{{{a}}} = {d}$"
            )
        )

emit(generate())