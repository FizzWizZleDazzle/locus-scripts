"""
precalculus - inverse_trig_functions (medium)
"""

from problem_utils import *

ARCSIN_TABLE = [
    (-1, -pi/2), (-sqrt(3)/2, -pi/3), (-sqrt(2)/2, -pi/4),
    (-Rational(1,2), -pi/6), (0, 0), (Rational(1,2), pi/6),
    (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/3), (1, pi/2),
]
ARCCOS_TABLE = [
    (-1, pi), (-sqrt(3)/2, 5*pi/6), (-sqrt(2)/2, 3*pi/4),
    (-Rational(1,2), 2*pi/3), (0, pi/2), (Rational(1,2), pi/3),
    (sqrt(2)/2, pi/4), (sqrt(3)/2, pi/6), (1, 0),
]
ARCTAN_TABLE = [
    (-sqrt(3), -pi/3), (-1, -pi/4), (-sqrt(3)/3, -pi/6),
    (0, 0), (sqrt(3)/3, pi/6), (1, pi/4), (sqrt(3), pi/3),
]


def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Evaluate at standard values — large pool
        func = choice(['arcsin', 'arccos', 'arctan'])
        table = {'arcsin': ARCSIN_TABLE, 'arccos': ARCCOS_TABLE, 'arctan': ARCTAN_TABLE}[func]
        val, ans = choice(table)
        func_latex = {'arcsin': '\\arcsin', 'arccos': '\\arccos', 'arctan': '\\arctan'}[func]
        return problem(
            question=f"Evaluate ${func_latex}\\!\\left({latex(val)}\\right)$",
            answer=ans,
            difficulty=(1200, 1350),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"Recall: ${func_latex}$ returns the angle in its principal range whose {func[3:]} is the input",
                f"${func_latex}\\!\\left({latex(val)}\\right) = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # Solve sin/cos/tan(x) = value in principal range
        trig_func = choice(['sin', 'cos', 'tan'])
        if trig_func == 'sin':
            table = ARCSIN_TABLE
            range_text = r"-\frac{\pi}{2} \leq x \leq \frac{\pi}{2}"
        elif trig_func == 'cos':
            table = ARCCOS_TABLE
            range_text = r"0 \leq x \leq \pi"
        else:
            table = ARCTAN_TABLE
            range_text = r"-\frac{\pi}{2} < x < \frac{\pi}{2}"

        val, ans = choice(table)
        func_latex = {'sin': '\\sin', 'cos': '\\cos', 'tan': '\\tan'}[trig_func]
        inv_latex = {'sin': '\\arcsin', 'cos': '\\arccos', 'tan': '\\arctan'}[trig_func]

        return problem(
            question=f"Solve ${func_latex}(x) = {latex(val)}$ where ${range_text}$",
            answer=ans,
            difficulty=(1300, 1450),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"Apply ${inv_latex}$ to both sides",
                f"$x = {inv_latex}\\!\\left({latex(val)}\\right) = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # arcsin(sin(theta)) where theta may be outside [-pi/2, pi/2]
        # Varied pool of angles in all quadrants
        outside_angles = [
            2*pi/3, 3*pi/4, 5*pi/6, pi,
            7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2,
            5*pi/3, 7*pi/4, 11*pi/6, 2*pi,
        ]
        theta = choice(outside_angles)
        sin_val = sin(theta)
        # Find the equivalent angle in [-pi/2, pi/2]
        ans = asin(sin_val)
        ans = simplify(ans)

        return problem(
            question=f"Simplify $\\arcsin\\!\\left(\\sin\\!\\left({latex(theta)}\\right)\\right)$",
            answer=ans,
            difficulty=(1400, 1550),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"First evaluate $\\sin\\!\\left({latex(theta)}\\right) = {latex(simplify(sin_val))}$",
                f"Find the angle in $\\left[-\\dfrac{{\\pi}}{{2}}, \\dfrac{{\\pi}}{{2}}\\right]$ with that sine value",
                f"Answer: ${latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # Domain of arcsin(linear expression): find x such that -1 <= ax+b <= 1
        # Vary a and b widely
        a_vals = [2, 3, 4, 5, Rational(1,2), Rational(1,3)]
        b_vals = [-3, -2, -1, 0, 1, 2, 3]
        a = choice(a_vals)
        b = choice(b_vals)
        # domain: (-1-b)/a <= x <= (1-b)/a   (a > 0)
        lo = simplify((-1 - b) / a)
        hi = simplify((1 - b) / a)
        if lo > hi:
            lo, hi = hi, lo
        ans = fmt_interval(lo, hi, False, False)

        inner_str = f"{latex(a)}x" + (f" + {b}" if b > 0 else (f" - {abs(b)}" if b < 0 else ""))

        return problem(
            question=f"Find the domain of $f(x) = \\arcsin\\!\\left({inner_str}\\right)$",
            answer=ans,
            difficulty=(1350, 1500),
            topic="precalculus/inverse_trig_functions",
            answer_type="interval",
            solution=steps(
                f"Domain of $\\arcsin$ requires $-1 \\leq {inner_str} \\leq 1$",
                f"Solve: ${latex(lo)} \\leq x \\leq {latex(hi)}$"
            ),
        )

    elif problem_type == 5:
        # arccos(cos(theta)) with theta outside [0, pi]
        outside_angles = [
            -pi/6, -pi/4, -pi/3, -pi/2,
            -2*pi/3, -3*pi/4, -5*pi/6,
            7*pi/6, 5*pi/4, 4*pi/3, 3*pi/2,
            5*pi/3, 7*pi/4, 11*pi/6,
        ]
        theta = choice(outside_angles)
        cos_val = cos(theta)
        ans = simplify(acos(cos_val))

        return problem(
            question=f"Simplify $\\arccos\\!\\left(\\cos\\!\\left({latex(theta)}\\right)\\right)$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"Evaluate $\\cos\\!\\left({latex(theta)}\\right) = {latex(simplify(cos_val))}$",
                f"Find the angle in $[0, \\pi]$ with that cosine value",
                f"Answer: ${latex(ans)}$"
            ),
        )

    else:
        # arctan(tan(theta)) with theta outside (-pi/2, pi/2)
        outside_angles = [
            3*pi/4, 5*pi/6, 2*pi/3,
            -3*pi/4, -5*pi/6, -2*pi/3,
            pi + pi/6, pi + pi/4, pi + pi/3,
        ]
        theta = choice(outside_angles)
        tan_val = tan(theta)
        ans = simplify(atan(tan_val))

        return problem(
            question=f"Simplify $\\arctan\\!\\left(\\tan\\!\\left({latex(theta)}\\right)\\right)$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="precalculus/inverse_trig_functions",
            solution=steps(
                f"Evaluate $\\tan\\!\\left({latex(theta)}\\right) = {latex(simplify(tan_val))}$",
                f"Find the angle in $\\left(-\\dfrac{{\\pi}}{{2}}, \\dfrac{{\\pi}}{{2}}\\right)$ with that tangent value",
                f"Answer: ${latex(ans)}$"
            ),
        )

emit(generate())
