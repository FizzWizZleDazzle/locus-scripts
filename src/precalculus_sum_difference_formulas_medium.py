"""
precalculus - sum_difference_formulas (medium)
"""

from problem_utils import *

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
    (240, 180, 60, '+'),
    (255, 210, 45, '+'),
    (285, 270, 15, '+'),
    (300, 270, 30, '+'),
    (315, 270, 45, '+'),
    (330, 300, 30, '+'),
]


def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Evaluate sin/cos/tan of sum/difference of standard angles
        a1 = choice([30, 45, 60, 90, 120, 135, 150])
        a2 = choice([30, 45, 60])
        is_sum = choice([True, False])
        func = choice(['sin', 'cos', 'tan'])

        result_deg = (a1 + a2) if is_sum else (a1 - a2)
        result_rad = result_deg * pi / 180
        op = '+' if is_sum else '-'

        if func == 'sin':
            ans = simplify(sin(result_rad))
            formula = r"\sin(A\pm B)=\sin A\cos B\pm\cos A\sin B"
        elif func == 'cos':
            ans = simplify(cos(result_rad))
            formula = r"\cos(A\pm B)=\cos A\cos B\mp\sin A\sin B"
        else:
            # Avoid undefined tan
            if result_deg % 180 == 90:
                func = 'sin'
                ans = simplify(sin(result_rad))
                formula = r"\sin(A\pm B)=\sin A\cos B\pm\cos A\sin B"
            else:
                try:
                    ans = simplify(tan(result_rad))
                    formula = r"\tan(A\pm B)=\frac{\tan A\pm\tan B}{1\mp\tan A\tan B}"
                except Exception:
                    func = 'cos'
                    ans = simplify(cos(result_rad))
                    formula = r"\cos(A\pm B)=\cos A\cos B\mp\sin A\sin B"

        return problem(
            question=f"Evaluate $\\{func}({a1}^\\circ {op} {a2}^\\circ)$ exactly.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Use: ${formula}$",
                f"Substitute $A = {a1}^\\circ$, $B = {a2}^\\circ$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # Simplify with variables: sin(ax)/cos(bx) combo → single function
        a = choice([2, 3, 4, 5, 6])
        b = choice([1, 2, 3, 4])
        while a == b:
            b = choice([1, 2, 3, 4])

        variant = choice(['expand_sin', 'expand_cos', 'collapse_sin', 'collapse_cos'])

        if variant == 'expand_sin':
            angle_add = choice([pi/6, pi/4, pi/3, pi/2])
            lhs = sin(x + angle_add)
            ans = expand_trig(lhs)
            return problem(
                question=f"Expand $\\sin\\!\\left(x + {latex(angle_add)}\\right)$ using the sum formula.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    "$\\sin(A+B) = \\sin A\\cos B + \\cos A\\sin B$",
                    f"$= \\sin x\\cos{latex(angle_add)} + \\cos x\\sin{latex(angle_add)}$",
                    f"$= {latex(ans)}$"
                )
            )

        elif variant == 'expand_cos':
            angle_add = choice([pi/6, pi/4, pi/3, pi/2])
            is_sum_v = choice([True, False])
            if is_sum_v:
                lhs = cos(x + angle_add)
            else:
                lhs = cos(x - angle_add)
            ans = expand_trig(lhs)
            pm = '+' if is_sum_v else '-'
            return problem(
                question=f"Expand $\\cos\\!\\left(x {pm} {latex(angle_add)}\\right)$ using the {'sum' if is_sum_v else 'difference'} formula.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    f"$\\cos(A{pm}B) = \\cos A\\cos B {'\\mp' if is_sum_v else '\\pm'}\\sin A\\sin B$",
                    f"$= {latex(ans)}$"
                )
            )

        elif variant == 'collapse_sin':
            # sin(ax)cos(bx) - cos(ax)sin(bx) = sin((a-b)x)
            ans = sin((a - b) * x)
            return problem(
                question=f"Simplify $\\sin({a}x)\\cos({b}x) - \\cos({a}x)\\sin({b}x)$.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    "$\\sin(A-B)=\\sin A\\cos B - \\cos A\\sin B$",
                    f"$= \\sin({a}x - {b}x) = \\sin({a-b}x)$"
                )
            )

        else:
            # cos(ax)cos(bx) + sin(ax)sin(bx) = cos((a-b)x)
            ans = cos((a - b) * x)
            return problem(
                question=f"Simplify $\\cos({a}x)\\cos({b}x) + \\sin({a}x)\\sin({b}x)$.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/sum_difference_formulas",
                solution=steps(
                    "$\\cos(A-B)=\\cos A\\cos B + \\sin A\\sin B$",
                    f"$= \\cos({a}x - {b}x) = \\cos({a-b}x)$"
                )
            )

    elif problem_type == 3:
        # tan addition / subtraction formula
        a1 = choice([15, 30, 45, 60, 75, 120, 135, 150])
        a2 = choice([30, 45, 60])
        is_sum = choice([True, False])
        result_deg = (a1 + a2) if is_sum else (a1 - a2)

        if result_deg % 180 == 90:
            # undefined — skip to safe values
            a1, a2, is_sum = 15, 45, False  # 15-45 = -30 — tan(-30) well defined
            result_deg = -30

        result_rad = result_deg * pi / 180
        ans = simplify(tan(result_rad))
        op = '+' if is_sum else '-'
        formula = r"\tan(A\pm B) = \frac{\tan A \pm \tan B}{1 \mp \tan A\tan B}"

        return problem(
            question=f"Evaluate $\\tan({a1}^\\circ {op} {a2}^\\circ)$ using the {'sum' if is_sum else 'difference'} formula.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Formula: ${formula}$",
                f"$\\tan({a1}^\\circ) = {latex(simplify(tan(a1*pi/180)))}$, "
                f"$\\tan({a2}^\\circ) = {latex(simplify(tan(a2*pi/180)))}$",
                f"$= {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Exact value of non-standard angle — wider target pool
        target, a1, a2, op = choice(SPECIAL)
        func = choice(['sin', 'cos', 'tan'])

        angle_rad = target * pi / 180
        if func == 'tan' and target % 180 == 90:
            func = 'cos'

        if func == 'sin':
            ans = simplify(sin(angle_rad))
        elif func == 'cos':
            ans = simplify(cos(angle_rad))
        else:
            try:
                ans = simplify(tan(angle_rad))
                if not ans.is_finite:
                    func = 'sin'
                    ans = simplify(sin(angle_rad))
            except Exception:
                func = 'cos'
                ans = simplify(cos(angle_rad))

        return problem(
            question=f"Find the exact value of $\\{func}({target}^\\circ)$ using a sum or difference formula.",
            answer=ans,
            difficulty=(1500, 1600),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"${target}^\\circ = {a1}^\\circ {op} {a2}^\\circ$",
                f"Apply the $\\{func}$ {'sum' if op == '+' else 'difference'} formula",
                f"$= {latex(ans)}$"
            )
        )

    else:
        # Solve sin(x + c) = val or cos(x - c) = val on [0, 2pi)
        angle_const = choice([pi/6, pi/4, pi/3, pi/2, 2*pi/3])
        target_val = choice([Rational(1, 2), sqrt(2)/2, sqrt(3)/2, 0, -Rational(1,2)])
        is_sin = choice([True, False])
        pm = choice(['+', '-'])

        if is_sin:
            if pm == '+':
                equation = Eq(sin(x + angle_const), target_val)
                question = f"Solve for $x \\in [0, 2\\pi)$: $\\sin\\!\\left(x + {latex(angle_const)}\\right) = {latex(target_val)}$"
            else:
                equation = Eq(sin(x - angle_const), target_val)
                question = f"Solve for $x \\in [0, 2\\pi)$: $\\sin\\!\\left(x - {latex(angle_const)}\\right) = {latex(target_val)}$"
        else:
            if pm == '+':
                equation = Eq(cos(x + angle_const), target_val)
                question = f"Solve for $x \\in [0, 2\\pi)$: $\\cos\\!\\left(x + {latex(angle_const)}\\right) = {latex(target_val)}$"
            else:
                equation = Eq(cos(x - angle_const), target_val)
                question = f"Solve for $x \\in [0, 2\\pi)$: $\\cos\\!\\left(x - {latex(angle_const)}\\right) = {latex(target_val)}$"

        sols_full = solve(equation, x)
        sols = [s for s in sols_full if s.is_real and 0 <= s < 2*pi]
        # also check by substituting 2pi-shifted values
        extended = []
        for s in sols:
            for k in range(-1, 3):
                cand = s + 2*pi*k
                if 0 <= cand < 2*pi:
                    extended.append(cand)
        if extended:
            ans = FiniteSet(*[simplify(v) for v in set(extended)])
        else:
            ans = FiniteSet()

        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="precalculus/sum_difference_formulas",
            solution=steps(
                f"Let $u = x {pm} {latex(angle_const)}$, solve $\\{'sin' if is_sin else 'cos'}(u) = {latex(target_val)}$",
                f"Find solutions for $u$, then subtract the constant to get $x$",
                f"Solutions in $[0, 2\\pi)$: ${latex(ans)}$"
            )
        )

emit(generate())
