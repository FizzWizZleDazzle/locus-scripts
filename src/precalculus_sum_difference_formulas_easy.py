"""
precalculus - sum_difference_formulas (easy)
"""

from problem_utils import *

# Wide pool: angles expressible as sums/differences of 30/45/60
SPECIAL = [
    (15,  45, 30, '-'),
    (75,  45, 30, '+'),
    (105, 60, 45, '+'),
    (120, 90, 30, '+'),
    (135, 90, 45, '+'),
    (150, 90, 60, '+'),
    (165, 120, 45, '+'),
    (195, 150, 45, '+'),
    (210, 180, 30, '+'),
    (225, 180, 45, '+'),
    (255, 210, 45, '+'),
    (285, 240, 45, '+'),
    (300, 270, 30, '+'),
    (315, 270, 45, '+'),
    (330, 300, 30, '+'),
    (345, 315, 30, '+'),
]

BASE_ANGLES = [0, 30, 45, 60, 90, 120, 135, 150, 180]


def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Direct sum/difference evaluation
        target, a1, a2, op = choice(SPECIAL)
        func = choice(['sin', 'cos'])
        func_name = func

        angle_rad = target * pi / 180
        if func == 'sin':
            ans = simplify(sin(angle_rad))
            if op == '+':
                formula = r"\sin(A+B)=\sin A\cos B+\cos A\sin B"
            else:
                formula = r"\sin(A-B)=\sin A\cos B-\cos A\sin B"
        else:
            ans = simplify(cos(angle_rad))
            if op == '+':
                formula = r"\cos(A+B)=\cos A\cos B-\sin A\sin B"
            else:
                formula = r"\cos(A-B)=\cos A\cos B+\sin A\sin B"

        return problem(
            question=f"Use a sum/difference formula to find the exact value of $\\{func_name}({target}^\\circ)$.",
            answer=ans,
            difficulty=(1000, 1200),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Write ${target}^\\circ = {a1}^\\circ {op} {a2}^\\circ$",
                f"Formula: ${formula}$",
                f"Substitute and evaluate: ${latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # Pattern recognition: sin(A)cos(B) ± cos(A)sin(B) = sin(A±B)
        a1 = choice([15, 30, 45, 60, 75, 90, 120, 135])
        a2 = choice([15, 30, 45, 60])
        is_sum = choice([True, False])
        is_sin = choice([True, False])

        if is_sin:
            result_angle = (a1 + a2) if is_sum else (a1 - a2)
            ans = simplify(sin(result_angle * pi / 180))
            if is_sum:
                expr_str = f"\\sin({a1}^\\circ)\\cos({a2}^\\circ) + \\cos({a1}^\\circ)\\sin({a2}^\\circ)"
                formula_str = "\\sin(A+B) = \\sin A\\cos B + \\cos A\\sin B"
            else:
                expr_str = f"\\sin({a1}^\\circ)\\cos({a2}^\\circ) - \\cos({a1}^\\circ)\\sin({a2}^\\circ)"
                formula_str = "\\sin(A-B) = \\sin A\\cos B - \\cos A\\sin B"
        else:
            result_angle = (a1 + a2) if is_sum else (a1 - a2)
            ans = simplify(cos(result_angle * pi / 180))
            if is_sum:
                expr_str = f"\\cos({a1}^\\circ)\\cos({a2}^\\circ) - \\sin({a1}^\\circ)\\sin({a2}^\\circ)"
                formula_str = "\\cos(A+B) = \\cos A\\cos B - \\sin A\\sin B"
            else:
                expr_str = f"\\cos({a1}^\\circ)\\cos({a2}^\\circ) + \\sin({a1}^\\circ)\\sin({a2}^\\circ)"
                formula_str = "\\cos(A-B) = \\cos A\\cos B + \\sin A\\sin B"

        return problem(
            question=f"Simplify ${expr_str}$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Recognize: ${formula_str}$",
                f"$= \\{'sin' if is_sin else 'cos'}({result_angle}^\\circ) = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Express as single trig function, variable form
        a = choice([1, 2, 3, 4, 5])
        b = choice([1, 2, 3, 4])
        while a == b:
            b = choice([1, 2, 3, 4])
        variant = choice(['sin_sum', 'sin_diff', 'cos_sum', 'cos_diff'])

        if variant == 'sin_sum':
            ans = sin((a + b) * x)
            expr_str = f"\\sin({a}x)\\cos({b}x) + \\cos({a}x)\\sin({b}x)"
            return problem(
                question=f"Express ${expr_str}$ as a single trig function.",
                answer=ans,
                difficulty=(1150, 1300),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    "$\\sin(A+B) = \\sin A\\cos B + \\cos A\\sin B$",
                    f"$= \\sin({a}x + {b}x) = \\sin({a+b}x)$"
                ),
            )
        elif variant == 'sin_diff':
            ans = sin((a - b) * x)
            expr_str = f"\\sin({a}x)\\cos({b}x) - \\cos({a}x)\\sin({b}x)"
            return problem(
                question=f"Express ${expr_str}$ as a single trig function.",
                answer=ans,
                difficulty=(1150, 1300),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    "$\\sin(A-B) = \\sin A\\cos B - \\cos A\\sin B$",
                    f"$= \\sin({a}x - {b}x) = \\sin({a-b}x)$"
                ),
            )
        elif variant == 'cos_sum':
            ans = cos((a + b) * x)
            expr_str = f"\\cos({a}x)\\cos({b}x) - \\sin({a}x)\\sin({b}x)"
            return problem(
                question=f"Express ${expr_str}$ as a single trig function.",
                answer=ans,
                difficulty=(1150, 1300),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    "$\\cos(A+B) = \\cos A\\cos B - \\sin A\\sin B$",
                    f"$= \\cos({a+b}x)$"
                ),
            )
        else:
            ans = cos((a - b) * x)
            expr_str = f"\\cos({a}x)\\cos({b}x) + \\sin({a}x)\\sin({b}x)"
            return problem(
                question=f"Express ${expr_str}$ as a single trig function.",
                answer=ans,
                difficulty=(1150, 1300),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    "$\\cos(A-B) = \\cos A\\cos B + \\sin A\\sin B$",
                    f"$= \\cos({a-b}x)$"
                ),
            )

    elif problem_type == 4:
        # Verify identity at specific angle pair
        angle_pairs = [(30,60),(45,45),(30,30),(60,60),(45,30),(60,30),(45,60),(15,45),(30,45)]
        a1, a2 = choice(angle_pairs)
        is_sin = choice([True, False])
        is_sum = choice([True, False])

        if is_sin:
            lhs = sin(a1*pi/180)*cos(a2*pi/180) + (1 if is_sum else -1)*cos(a1*pi/180)*sin(a2*pi/180)
            rhs = sin((a1 + (a2 if is_sum else -a2)) * pi / 180)
            op_str = '+' if is_sum else '-'
            func = 'sin'
        else:
            lhs = cos(a1*pi/180)*cos(a2*pi/180) + (-1 if is_sum else 1)*sin(a1*pi/180)*sin(a2*pi/180)
            rhs = cos((a1 + (a2 if is_sum else -a2)) * pi / 180)
            op_str = '+' if is_sum else '-'
            func = 'cos'

        ans = simplify(lhs).equals(simplify(rhs))

        question = (f"Does $\\{func}({a1}^\\circ)\\cos({a2}^\\circ) {op_str} \\cos({a1}^\\circ)\\sin({a2}^\\circ) = \\{func}({a1+(a2 if is_sum else -a2)}^\\circ)$?"
                    if is_sin else
                    f"Does $\\{func}({a1}^\\circ)\\cos({a2}^\\circ) {op_str} \\sin({a1}^\\circ)\\sin({a2}^\\circ) = \\{func}({a1+(a2 if is_sum else -a2)}^\\circ)$?")

        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1150),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"The left side matches the {'sum' if is_sum else 'difference'} formula for $\\{func}$",
                f"The statement is {'True' if ans else 'False'}"
            ),
            answer_type="boolean"
        )

    else:
        # tan addition/subtraction at special angles
        angles_pool = [0, 30, 45, 60]
        a1 = choice(angles_pool)
        a2 = choice(angles_pool)
        is_sum = choice([True, False])

        result_deg = (a1 + a2) if is_sum else (a1 - a2)
        result_rad = result_deg * pi / 180
        ans = simplify(tan(result_rad)) if result_deg % 90 != 0 else simplify(sin(result_rad)/cos(result_rad)) if cos(result_rad) != 0 else None

        if ans is None or not ans.is_finite:
            a1, a2, is_sum = 30, 45, True
            result_deg = 75
            ans = simplify(tan(result_deg * pi / 180))

        formula = r"\tan(A+B) = \frac{\tan A+\tan B}{1-\tan A\tan B}" if is_sum else r"\tan(A-B) = \frac{\tan A-\tan B}{1+\tan A\tan B}"
        op_str = '+' if is_sum else '-'

        return problem(
            question=f"Evaluate $\\tan({a1}^\\circ {op_str} {a2}^\\circ)$ exactly using the {'sum' if is_sum else 'difference'} formula.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Formula: ${formula}$",
                f"$\\tan({a1}^\\circ) = {latex(simplify(tan(a1*pi/180)))}$, $\\tan({a2}^\\circ) = {latex(simplify(tan(a2*pi/180)))}$",
                f"$= {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
