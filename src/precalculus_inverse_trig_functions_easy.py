"""
precalculus - inverse_trig_functions (easy)
"""

from problem_utils import *

# Full tables of exact inverse-trig values
ARCSIN_TABLE = [
    (0, 0),
    (Rational(1, 2), pi/6),
    (sqrt(2)/2, pi/4),
    (sqrt(3)/2, pi/3),
    (1, pi/2),
    (-Rational(1, 2), -pi/6),
    (-sqrt(2)/2, -pi/4),
    (-sqrt(3)/2, -pi/3),
    (-1, -pi/2),
]

ARCCOS_TABLE = [
    (1, 0),
    (sqrt(3)/2, pi/6),
    (sqrt(2)/2, pi/4),
    (Rational(1, 2), pi/3),
    (0, pi/2),
    (-Rational(1, 2), 2*pi/3),
    (-sqrt(2)/2, 3*pi/4),
    (-sqrt(3)/2, 5*pi/6),
    (-1, pi),
]

ARCTAN_TABLE = [
    (0, 0),
    (1, pi/4),
    (sqrt(3), pi/3),
    (sqrt(3)/3, pi/6),
    (-1, -pi/4),
    (-sqrt(3), -pi/3),
    (-sqrt(3)/3, -pi/6),
    (2, atan(2)),
    (3, atan(3)),
    (-2, -atan(2)),
    (-3, -atan(3)),
]

# Values safe for sin(arcsin) / cos(arccos) composition problems
COMP_VALS = [Rational(1, 3), Rational(2, 5), Rational(3, 7), Rational(4, 9),
             Rational(1, 4), Rational(3, 5), Rational(5, 8), Rational(2, 7),
             -Rational(1, 3), -Rational(2, 5), -Rational(3, 7), -Rational(4, 9)]


def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Direct evaluation of arcsin / arccos / arctan at standard values
        func_choice = randint(1, 3)

        if func_choice == 1:
            val, ans = choice(ARCSIN_TABLE)
            return problem(
                question=f"Evaluate $\\arcsin\\!\\left({latex(val)}\\right)$",
                answer=ans,
                difficulty=(1000, 1200),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Find $\\theta \\in \\left[-\\tfrac{{\\pi}}{{2}}, \\tfrac{{\\pi}}{{2}}\\right]$ with $\\sin\\theta = {latex(val)}$",
                    f"$\\arcsin\\!\\left({latex(val)}\\right) = {latex(ans)}$"
                ),
            )
        elif func_choice == 2:
            val, ans = choice(ARCCOS_TABLE)
            return problem(
                question=f"Evaluate $\\arccos\\!\\left({latex(val)}\\right)$",
                answer=ans,
                difficulty=(1000, 1200),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Find $\\theta \\in [0, \\pi]$ with $\\cos\\theta = {latex(val)}$",
                    f"$\\arccos\\!\\left({latex(val)}\\right) = {latex(ans)}$"
                ),
            )
        else:
            val, ans = choice(ARCTAN_TABLE)
            return problem(
                question=f"Evaluate $\\arctan\\!\\left({latex(val)}\\right)$",
                answer=ans,
                difficulty=(1000, 1200),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"Find $\\theta \\in \\left(-\\tfrac{{\\pi}}{{2}}, \\tfrac{{\\pi}}{{2}}\\right)$ with $\\tan\\theta = {latex(val)}$",
                    f"$\\arctan\\!\\left({latex(val)}\\right) = {latex(ans)}$"
                ),
            )

    elif problem_type == 2:
        # Composition f(f^{-1}(val)) = val
        func_choice = randint(1, 3)
        val = choice(COMP_VALS)

        if func_choice == 1:
            return problem(
                question=f"Evaluate $\\sin\\!\\left(\\arcsin\\!\\left({latex(val)}\\right)\\right)$",
                answer=val,
                difficulty=(1100, 1250),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\sin$ and $\\arcsin$ are inverses, so $\\sin(\\arcsin(u)) = u$ for $u \\in [-1,1]$",
                    f"Answer: ${latex(val)}$"
                ),
            )
        elif func_choice == 2:
            val_pos = abs(val)
            return problem(
                question=f"Evaluate $\\cos\\!\\left(\\arccos\\!\\left({latex(val_pos)}\\right)\\right)$",
                answer=val_pos,
                difficulty=(1100, 1250),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\cos$ and $\\arccos$ are inverses, so $\\cos(\\arccos(u)) = u$ for $u \\in [-1,1]$",
                    f"Answer: ${latex(val_pos)}$"
                ),
            )
        else:
            return problem(
                question=f"Evaluate $\\tan\\!\\left(\\arctan\\!\\left({latex(val)}\\right)\\right)$",
                answer=val,
                difficulty=(1100, 1250),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "$\\tan$ and $\\arctan$ are inverses for all real $u$",
                    f"Answer: ${latex(val)}$"
                ),
            )

    elif problem_type == 3:
        # arcsin(sin(theta)) / arccos(cos(theta)) / arctan(tan(theta))
        # where theta is already in the principal range
        func_choice = randint(1, 3)

        if func_choice == 1:
            angles = [0, pi/6, pi/4, pi/3, pi/2, -pi/6, -pi/4, -pi/3, -pi/2]
            theta = choice(angles)
            return problem(
                question=f"Evaluate $\\arcsin\\!\\left(\\sin\\!\\left({latex(theta)}\\right)\\right)$",
                answer=theta,
                difficulty=(1200, 1300),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"${latex(theta)} \\in \\left[-\\tfrac{{\\pi}}{{2}}, \\tfrac{{\\pi}}{{2}}\\right]$, so it is in the range of $\\arcsin$",
                    f"$\\arcsin(\\sin({latex(theta)})) = {latex(theta)}$"
                ),
            )
        elif func_choice == 2:
            angles = [0, pi/6, pi/4, pi/3, pi/2, 2*pi/3, 3*pi/4, 5*pi/6, pi]
            theta = choice(angles)
            return problem(
                question=f"Evaluate $\\arccos\\!\\left(\\cos\\!\\left({latex(theta)}\\right)\\right)$",
                answer=theta,
                difficulty=(1200, 1300),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"${latex(theta)} \\in [0, \\pi]$, so it is in the range of $\\arccos$",
                    f"$\\arccos(\\cos({latex(theta)})) = {latex(theta)}$"
                ),
            )
        else:
            angles = [0, pi/6, pi/4, pi/3, -pi/6, -pi/4, -pi/3]
            theta = choice(angles)
            return problem(
                question=f"Evaluate $\\arctan\\!\\left(\\tan\\!\\left({latex(theta)}\\right)\\right)$",
                answer=theta,
                difficulty=(1200, 1300),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    f"${latex(theta)} \\in \\left(-\\tfrac{{\\pi}}{{2}}, \\tfrac{{\\pi}}{{2}}\\right)$, so it is in the range of $\\arctan$",
                    f"$\\arctan(\\tan({latex(theta)})) = {latex(theta)}$"
                ),
            )

    elif problem_type == 4:
        # Domain questions: is a value in the domain?
        func_choice = randint(1, 3)

        if func_choice == 1:
            # Outside domain: |val| > 1
            val = choice([Rational(3, 2), 2, Rational(5, 3), Rational(7, 4), -Rational(3, 2), -2])
            return problem(
                question=f"Is ${latex(val)}$ in the domain of $\\arcsin(x)$?",
                answer=False,
                difficulty=(1000, 1150),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "Domain of $\\arcsin$ is $[-1, 1]$",
                    f"$|{latex(val)}| > 1$, so ${latex(val)}$ is NOT in the domain"
                ),
                answer_type="boolean"
            )
        elif func_choice == 2:
            # Inside domain of arccos
            val = choice([Rational(1, 2), Rational(3, 4), Rational(4, 5), -Rational(1, 2),
                          Rational(1, 3), Rational(2, 3), -Rational(3, 4), 0, 1, -1])
            return problem(
                question=f"Is ${latex(val)}$ in the domain of $\\arccos(x)$?",
                answer=True,
                difficulty=(1000, 1150),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "Domain of $\\arccos$ is $[-1, 1]$",
                    f"${latex(val)} \\in [-1,1]$, so it IS in the domain"
                ),
                answer_type="boolean"
            )
        else:
            # arctan domain is all reals
            val = nonzero(-10, 10)
            return problem(
                question=f"Is ${val}$ in the domain of $\\arctan(x)$?",
                answer=True,
                difficulty=(1000, 1150),
                topic="precalculus/inverse_trig_functions",
                solution=steps(
                    "Domain of $\\arctan$ is all real numbers $(-\\infty, \\infty)$",
                    f"Therefore ${val}$ IS in the domain"
                ),
                answer_type="boolean"
            )

    else:
        # Identify range of arcsin / arccos / arctan
        func_choice = randint(1, 3)

        if func_choice == 1:
            ans = fmt_interval(-pi/2, pi/2, False, False)
            return problem(
                question="State the range of $y = \\arcsin(x)$.",
                answer=ans,
                difficulty=(1050, 1200),
                topic="precalculus/inverse_trig_functions",
                answer_type="interval",
                solution=steps(
                    "The range of $\\arcsin$ is $\\left[-\\dfrac{\\pi}{2}, \\dfrac{\\pi}{2}\\right]$"
                ),
            )
        elif func_choice == 2:
            ans = fmt_interval(0, pi, False, False)
            return problem(
                question="State the range of $y = \\arccos(x)$.",
                answer=ans,
                difficulty=(1050, 1200),
                topic="precalculus/inverse_trig_functions",
                answer_type="interval",
                solution=steps("The range of $\\arccos$ is $[0, \\pi]$"),
            )
        else:
            ans = fmt_interval(-pi/2, pi/2, True, True)
            return problem(
                question="State the range of $y = \\arctan(x)$.",
                answer=ans,
                difficulty=(1050, 1200),
                topic="precalculus/inverse_trig_functions",
                answer_type="interval",
                solution=steps(
                    "The range of $\\arctan$ is $\\left(-\\dfrac{\\pi}{2}, \\dfrac{\\pi}{2}\\right)$ (open interval)"
                ),
            )

emit(generate())
