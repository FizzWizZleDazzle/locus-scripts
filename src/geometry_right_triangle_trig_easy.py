"""
geometry - right_triangle_trig (easy)
Generated: 2026-02-22T04:18:52.199856
"""

from problem_utils import *
from svg_utils import Diagram

# Special angles with exact trig values
SPECIAL_ANGLES = {
    30: {'sin': Rational(1,2), 'cos': sqrt(3)/2, 'tan': 1/sqrt(3)},
    45: {'sin': sqrt(2)/2, 'cos': sqrt(2)/2, 'tan': Integer(1)},
    60: {'sin': sqrt(3)/2, 'cos': Rational(1,2), 'tan': sqrt(3)},
}

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # Find a side using sin/cos/tan with a special angle
        angle = choice([30, 45, 60])
        trig_name = choice(['sin', 'cos', 'tan'])
        scale = choice([2, 3, 4, 5, 6, 8, 10, 12, 15, 20])
        ratios = SPECIAL_ANGLES[angle]
        ratio_val = ratios[trig_name]

        if trig_name == 'sin':
            hyp = scale
            opp = simplify(ratio_val * hyp)
            question_text = f"In a right triangle, if the hypotenuse is ${hyp}$ and one angle is ${angle}°$, find the side opposite to the ${angle}°$ angle."
            ans = opp
            sol = steps(
                f"Use $\\sin({angle}°) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\sin({angle}°) = {latex(ratio_val)}$",
                f"$\\text{{opposite}} = {hyp} \\cdot {latex(ratio_val)} = {latex(ans)}$"
            )
        elif trig_name == 'cos':
            hyp = scale
            adj = simplify(ratio_val * hyp)
            question_text = f"In a right triangle, if the hypotenuse is ${hyp}$ and one angle is ${angle}°$, find the side adjacent to the ${angle}°$ angle."
            ans = adj
            sol = steps(
                f"Use $\\cos({angle}°) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}}$",
                f"$\\cos({angle}°) = {latex(ratio_val)}$",
                f"$\\text{{adjacent}} = {hyp} \\cdot {latex(ratio_val)} = {latex(ans)}$"
            )
        else:  # tan
            adj = scale
            opp = simplify(ratio_val * adj)
            question_text = f"In a right triangle, if the side adjacent to a ${angle}°$ angle is ${adj}$, find the side opposite to the ${angle}°$ angle."
            ans = opp
            sol = steps(
                f"Use $\\tan({angle}°) = \\frac{{\\text{{opposite}}}}{{\\text{{adjacent}}}}$",
                f"$\\tan({angle}°) = {latex(ratio_val)}$",
                f"$\\text{{opposite}} = {adj} \\cdot {latex(ratio_val)} = {latex(ans)}$"
            )

        return problem(
            question=question_text,
            answer=simplify(ans),
            difficulty=(1000, 1200),
            topic="geometry/right_triangle_trig",
            solution=sol
        )

    elif problem_type == 2:
        # Find an angle given a ratio that matches a special angle
        angle = choice([30, 45, 60])
        trig_name = choice(['sin', 'cos', 'tan'])
        ratio_val = SPECIAL_ANGLES[angle][trig_name]
        scale = randint(1, 6)

        if trig_name == 'sin':
            opp = simplify(ratio_val * scale * 2) if angle in [30,60] else simplify(ratio_val * scale)
            hyp = simplify(scale * 2) if angle in [30,60] else simplify(sqrt(2) * scale)
            question_text = f"In a right triangle, the side opposite an angle is ${latex(simplify(ratio_val * scale * 2 if angle in [30,60] else ratio_val*scale))}$ and the hypotenuse is ${latex(simplify(2*scale if angle in [30,60] else sqrt(2)*scale))}$. Find the angle in degrees."
            sol = steps(
                f"$\\sin(\\theta) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}} = {latex(ratio_val)}$",
                f"$\\theta = \\sin^{{-1}}({latex(ratio_val)}) = {angle}°$"
            )
        elif trig_name == 'cos':
            adj = simplify(ratio_val * scale * 2) if angle in [30,60] else simplify(ratio_val * scale)
            hyp = simplify(scale * 2) if angle in [30,60] else simplify(sqrt(2) * scale)
            question_text = f"In a right triangle, the side adjacent to an angle is ${latex(simplify(ratio_val * scale * 2 if angle in [30,60] else ratio_val*scale))}$ and the hypotenuse is ${latex(simplify(2*scale if angle in [30,60] else sqrt(2)*scale))}$. Find the angle in degrees."
            sol = steps(
                f"$\\cos(\\theta) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}} = {latex(ratio_val)}$",
                f"$\\theta = \\cos^{{-1}}({latex(ratio_val)}) = {angle}°$"
            )
        else:
            opp_scale = scale
            adj_scale = simplify(opp_scale / ratio_val)
            question_text = f"In a right triangle, the side opposite an angle is ${opp_scale}$ and the side adjacent is ${latex(simplify(adj_scale))}$. Find the angle in degrees."
            sol = steps(
                f"$\\tan(\\theta) = \\frac{{\\text{{opposite}}}}{{\\text{{adjacent}}}} = \\frac{{{opp_scale}}}{{{latex(simplify(adj_scale))}}} = {latex(ratio_val)}$",
                f"$\\theta = \\tan^{{-1}}({latex(ratio_val)}) = {angle}°$"
            )

        return problem(
            question=question_text,
            answer=angle,
            difficulty=(1100, 1250),
            topic="geometry/right_triangle_trig",
            solution=sol
        )

    elif problem_type == 3:
        # SOH-CAH-TOA identification: write trig ratio as fraction
        angle_label = choice(['A', 'B', 'C', 'D', 'E'])
        # Pick non-equal coprime sides
        side1 = randint(2, 15)
        side2 = randint(2, 15)
        while side1 == side2:
            side2 = randint(2, 15)
        ratio_type = choice(['sin', 'cos', 'tan'])
        ans = Rational(side1, side2)

        if ratio_type == 'sin':
            q = f"In a right triangle, the side opposite angle ${angle_label}$ is ${side1}$ and the hypotenuse is ${side2}$. Write $\\sin({angle_label})$ as a fraction."
            sol = steps(
                f"$\\sin({angle_label}) = \\frac{{\\text{{opposite}}}}{{\\text{{hypotenuse}}}} = \\frac{{{side1}}}{{{side2}}}$"
            )
        elif ratio_type == 'cos':
            q = f"In a right triangle, the side adjacent to angle ${angle_label}$ is ${side1}$ and the hypotenuse is ${side2}$. Write $\\cos({angle_label})$ as a fraction."
            sol = steps(
                f"$\\cos({angle_label}) = \\frac{{\\text{{adjacent}}}}{{\\text{{hypotenuse}}}} = \\frac{{{side1}}}{{{side2}}}$"
            )
        else:
            q = f"In a right triangle, the side opposite angle ${angle_label}$ is ${side1}$ and the side adjacent is ${side2}$. Write $\\tan({angle_label})$ as a fraction."
            sol = steps(
                f"$\\tan({angle_label}) = \\frac{{\\text{{opposite}}}}{{\\text{{adjacent}}}} = \\frac{{{side1}}}{{{side2}}}$"
            )

        return problem(
            question=q,
            answer=ans,
            difficulty=(1000, 1150),
            topic="geometry/right_triangle_trig",
            solution=sol
        )

    else:
        # 30-60-90 and 45-45-90 triangles, given hypotenuse find legs
        triangle_type = choice(['30-60-90', '45-45-90'])
        hypotenuse = choice([2, 4, 6, 8, 10, 12, 14, 16, 20])

        if triangle_type == '30-60-90':
            short_leg = simplify(hypotenuse * Rational(1,2))
            long_leg = simplify(hypotenuse * sqrt(3) / 2)
            which = choice(['short', 'long'])
            if which == 'short':
                ans = short_leg
                q = f"In a $30°$-$60°$-$90°$ triangle, the hypotenuse is ${hypotenuse}$. Find the length of the shorter leg (opposite $30°$)."
                sol = steps(
                    f"In a $30°$-$60°$-$90°$ triangle, the sides are in ratio $1:\\sqrt{{3}}:2$",
                    f"Shorter leg $= \\frac{{\\text{{hypotenuse}}}}{{2}} = \\frac{{{hypotenuse}}}{{2}} = {latex(short_leg)}$"
                )
            else:
                ans = long_leg
                q = f"In a $30°$-$60°$-$90°$ triangle, the hypotenuse is ${hypotenuse}$. Find the length of the longer leg (opposite $60°$)."
                sol = steps(
                    f"In a $30°$-$60°$-$90°$ triangle, sides are in ratio $1:\\sqrt{{3}}:2$",
                    f"Longer leg $= \\frac{{\\sqrt{{3}}}}{{2}} \\cdot {hypotenuse} = {latex(long_leg)}$"
                )
        else:
            leg = simplify(hypotenuse * sqrt(2) / 2)
            ans = leg
            q = f"In a $45°$-$45°$-$90°$ triangle, the hypotenuse is ${hypotenuse}$. Find the length of one leg."
            sol = steps(
                f"In a $45°$-$45°$-$90°$ triangle, the sides are in ratio $1:1:\\sqrt{{2}}$",
                f"Leg $= \\frac{{\\text{{hypotenuse}}}}{{\\sqrt{{2}}}} = \\frac{{{hypotenuse}}}{{\\sqrt{{2}}}} = {latex(leg)}$"
            )

        return problem(
            question=q,
            answer=ans,
            difficulty=(1200, 1300),
            topic="geometry/right_triangle_trig",
            solution=sol
        )

emit(generate())
