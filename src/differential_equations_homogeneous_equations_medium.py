"""
differential_equations - homogeneous_equations (medium)
Generated: 2026-02-22T05:23:38.334903
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # dy/dx = (a1*x + a2*y) / x  — linear homogeneous
        a1 = nonzero(-5, 5)
        a2 = nonzero(-5, 5)

        # v = y/x  =>  v + x*dv/dx = a1 + a2*v
        # x*dv/dx = a1 + (a2-1)*v
        k = a2 - 1

        if a1 == 1:
            num_latex = f"x + {a2}y" if a2 != 1 else "x + y"
        elif a1 == -1:
            num_latex = f"-x + {a2}y" if a2 != 1 else "-x + y"
        else:
            num_latex = f"{a1}x + {a2}y" if a2 != 1 else f"{a1}x + y"

        question = f"Solve the homogeneous DE: $\\frac{{dy}}{{dx}} = \\frac{{{num_latex}}}{{x}}$"

        if k == 0:
            # x*dv/dx = a1  =>  v = a1*ln|x| + C  =>  y = a1*x*ln|x| + Cx
            ans_expr = f"y = {a1}x\\ln|x| + Cx" if a1 != 1 else "y = x\\ln|x| + Cx"
            sol_steps = steps(
                f"Let $v = y/x$: $v + x\\frac{{dv}}{{dx}} = {a1} + {a2}v = {a1} + v$",
                f"Simplify: $x\\frac{{dv}}{{dx}} = {a1}$",
                f"Separate: $dv = \\frac{{{a1}\\,dx}}{{x}}$",
                f"Integrate: $v = {a1}\\ln|x| + C$",
                f"Back-substitute: ${ans_expr}$"
            )
        else:
            # dv/(a1 + k*v) = dx/x
            # (1/k)*ln|a1 + k*v| = ln|x| + C
            ans_expr = f"{a1} + {k}(y/x) = Cx" if k != 1 else f"{a1} + y/x = Cx"
            sol_steps = steps(
                f"Let $v = y/x$: $x\\frac{{dv}}{{dx}} = {a1} + {k}v$",
                f"Separate: $\\frac{{dv}}{{{a1} + {k}v}} = \\frac{{dx}}{{x}}$",
                f"Integrate: $\\frac{{1}}{{{k}}}\\ln|{a1} + {k}v| = \\ln|x| + C_1$",
                f"$|{a1} + {k}v| = C|x|^{{{k}}}$",
                f"Back-substitute $v = y/x$: ${ans_expr}$"
            )

        return problem(
            question=question,
            answer=ans_expr,
            difficulty=(1300, 1470),
            topic="differential_equations/homogeneous_equations",
            solution=sol_steps,
            answer_type="expression"
        )

    elif problem_type == 2:
        # dy/dx = (y/x)^2 + a*(y/x)
        a = randint(1, 5)
        b = a - 1  # coefficient after substitution

        # v + x*dv/dx = v^2 + a*v
        # x*dv/dx = v^2 + (a-1)*v = v^2 + b*v

        if a == 1:
            main_eq = "\\left(\\frac{y}{x}\\right)^2 + \\frac{y}{x}"
        else:
            main_eq = f"\\left(\\frac{{y}}{{x}}\\right)^2 + {a}\\frac{{y}}{{x}}"

        question = f"Solve the homogeneous DE: $\\frac{{dy}}{{dx}} = {main_eq}$"

        if b == 0:
            ans_expr = "y = -\\frac{x}{\\ln|x| + C}"
        else:
            ans_expr = f"\\frac{{1}}{{v}} - \\frac{{1}}{{v + {b}}} = {b}\\ln|x| + C \\text{{ where }} v = y/x"

        sol_steps = steps(
            f"Let $v = y/x$: $v + x\\frac{{dv}}{{dx}} = v^2 + {a}v$",
            f"$x\\frac{{dv}}{{dx}} = v^2 + {b}v = v(v + {b})$",
            f"Partial fractions: $\\frac{{dv}}{{v(v + {b})}} = \\frac{{dx}}{{x}}$",
            f"Integrate and back-substitute $v = y/x$: ${ans_expr}$"
        )

        return problem(
            question=question,
            answer=ans_expr,
            difficulty=(1400, 1560),
            topic="differential_equations/homogeneous_equations",
            solution=sol_steps,
            answer_type="expression"
        )

    elif problem_type == 3:
        # (a*x^2 + b*y^2)dx + c_coef*xy*dy = 0
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c_coef = nonzero(-4, 4)

        # dy/dx = -(a*x^2 + b*y^2)/(c_coef*x*y)
        # v = y/x  =>  dy/dx = -(a + b*v^2)/(c_coef*v)
        # v + x*dv/dx = -(a + b*v^2)/(c_coef*v)
        # x*dv/dx = -(a + b*v^2)/(c_coef*v) - v = -(a + b*v^2 + c_coef*v^2)/(c_coef*v)

        if c_coef > 0:
            q_str = f"({a}x^2 + {b}y^2)dx + {c_coef}xy\\,dy = 0"
        else:
            q_str = f"({a}x^2 + {b}y^2)dx - {-c_coef}xy\\,dy = 0"

        ans_expr = f"{a}x^2 + {b + c_coef}y^2 = Cx^{{{2 + c_coef}}}" if (b + c_coef) != 0 else f"Implicit solution involves integration"

        sol_steps = steps(
            f"Rewrite: $\\frac{{dy}}{{dx}} = -\\frac{{{a}x^2 + {b}y^2}}{{{c_coef}xy}}$",
            f"This is homogeneous (degree 2). Let $v = y/x$",
            f"Substitute $y = vx$ and separate variables",
            f"After integration, back-substitute $v = y/x$"
        )

        return problem(
            question=f"Solve the homogeneous DE: ${q_str}$",
            answer=ans_expr,
            difficulty=(1350, 1520),
            topic="differential_equations/homogeneous_equations",
            solution=sol_steps,
            answer_type="expression"
        )

    else:
        # dy/dx = 1 ± y/x  — simplest log-type solutions
        sign = choice([1, -1])

        if sign == 1:
            # v + x*dv/dx = 1 + v  =>  x*dv/dx = 1  =>  v = ln|x| + C
            # y = vx = x*ln|x| + Cx
            ans_expr = "y = x\\ln|x| + Cx"
            eq_str = "1 + \\frac{y}{x}"
        else:
            # v + x*dv/dx = 1 - v  =>  x*dv/dx = 1 - 2v
            # dv/(1-2v) = dx/x  =>  -ln|1-2v|/2 = ln|x| + C
            # 1 - 2y/x = C/x^2
            ans_expr = "x^2 - 2xy = C"
            eq_str = "1 - \\frac{y}{x}"

        sol_steps = steps(
            f"Let $v = y/x$: $v + x\\frac{{dv}}{{dx}} = {eq_str}$",
            f"Simplify and separate variables",
            f"Integrate both sides",
            f"Back-substitute $v = y/x$: ${ans_expr}$"
        )

        return problem(
            question=f"Solve the homogeneous DE: $\\frac{{dy}}{{dx}} = {eq_str}$",
            answer=ans_expr,
            difficulty=(1300, 1430),
            topic="differential_equations/homogeneous_equations",
            solution=sol_steps,
            answer_type="expression"
        )


emit(generate())
