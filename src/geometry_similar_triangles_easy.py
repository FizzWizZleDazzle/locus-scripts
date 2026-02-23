"""
geometry - similar_triangles (easy)
Generated: 2026-02-22T04:07:47.191584
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # Find missing side given scale factor (integer 2-8)
        scale = randint(2, 8)
        small_side = randint(2, 10)
        large_side = small_side * scale

        d = Diagram(width=400, height=200, padding=30)
        tri1 = [(0,0),(small_side,0),(small_side,small_side)]
        d.polygon(tri1, labels=['A','B','C'])
        d.segment_label((0,0),(small_side,0),f'{small_side}')
        d.tick_marks((0,0),(small_side,0),count=1)

        offset = small_side + 4
        tri2 = [(offset,0),(offset+large_side,0),(offset+large_side,large_side)]
        d.polygon(tri2, labels=['D','E','F'])
        d.segment_label((offset,0),(offset+large_side,0),'?')
        d.tick_marks((offset,0),(offset+large_side,0),count=1)

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
        # Find missing side using proportion (integer scale factor 2-7)
        scale = randint(2, 7)
        side1_small = randint(3, 10)
        side2_small = randint(3, 10)
        side1_large = side1_small * scale
        side2_large = side2_small * scale

        d = Diagram(width=400, height=200, padding=30)
        tri1 = [(0,0),(side1_small,0),(side1_small*0.7,side2_small)]
        d.polygon(tri1, labels=['P','Q','R'])
        d.segment_label((0,0),(side1_small,0),f'{side1_small}')
        d.segment_label((side1_small,0),(side1_small*0.7,side2_small),f'{side2_small}')

        offset = side1_small + 4
        tri2 = [(offset,0),(offset+side1_large,0),(offset+side1_large*0.7,side2_large)]
        d.polygon(tri2, labels=['X','Y','Z'])
        d.segment_label((offset,0),(offset+side1_large,0),f'{side1_large}')
        d.segment_label((offset+side1_large,0),(offset+side1_large*0.7,side2_large),'?')

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
        # Find scale factor given two corresponding sides (scale can be fraction 1/2–1/5 or integer 2-8)
        use_fraction = randint(0, 1)
        if use_fraction:
            denom = randint(2, 5)
            side_large = randint(denom, denom * 6) * denom  # ensure divisible
            side_small = side_large // denom
            scale_ans = Rational(side_small, side_large)
            scale_str = f"$\\frac{{1}}{{{denom}}}$"
            q = f"Two similar triangles have corresponding sides of length ${side_large}$ and ${side_small}$. What is the scale factor from the larger triangle to the smaller triangle?"
        else:
            scale_num = randint(2, 8)
            side_small = randint(2, 8)
            side_large = side_small * scale_num
            scale_ans = scale_num
            scale_str = f"${scale_num}$"
            q = f"Two similar triangles have corresponding sides of length ${side_small}$ and ${side_large}$. What is the scale factor from the smaller triangle to the larger triangle?"

        return problem(
            question=q,
            answer=scale_ans,
            difficulty=(1150, 1300),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Scale factor = $\\frac{{\\text{{corresponding side in second triangle}}}}{{\\text{{corresponding side in first triangle}}}}$",
                f"Scale factor = {scale_str}"
            )
        )

    else:
        # Proportion with non-unit scale: a/b = c/x, find x
        # Use integer scale to guarantee integer answer
        a = randint(2, 8)
        scale = randint(2, 6)
        b = a * scale
        c = randint(2, 9)
        d_ans = c * scale

        return problem(
            question=f"In two similar triangles, the ratio of two corresponding sides is ${a}:{b}$. If a side in the smaller triangle measures ${c}$, what is the length of the corresponding side in the larger triangle?",
            answer=d_ans,
            difficulty=(1200, 1300),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Set up proportion: $\\frac{{{a}}}{{{b}}} = \\frac{{{c}}}{{x}}$",
                f"Cross multiply: ${a} \\cdot x = {b} \\cdot {c} = {b*c}$",
                f"$x = \\frac{{{b*c}}}{{{a}}} = {d_ans}$"
            )
        )

emit(generate())
