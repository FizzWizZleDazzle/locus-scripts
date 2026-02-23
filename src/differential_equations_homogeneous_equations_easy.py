"""
differential_equations - homogeneous_equations (easy)
Generated: 2026-02-22T05:23:01.669773
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # dy/dx = (a*x^p) / (b*y^q)  — separable, written as fraction
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        p = choice([1, 2, 3])
        q = choice([1, 2])

        question = f"Solve the differential equation: $\\frac{{dy}}{{dx}} = \\frac{{{latex(a * x**p)}}}{{{latex(b * y**q)}}}$"

        # b*y^q dy = a*x^p dx
        left_power = q + 1
        right_power = p + 1
        left_side = Rational(b, left_power) * y**left_power
        right_side = Rational(a, right_power) * x**right_power

        ans = Eq(left_side, right_side + c)

        solution_steps = steps(
            f"Separate variables: ${b}y^{{{q}}}\\,dy = {a}x^{{{p}}}\\,dx$",
            f"Integrate: $\\int {b}y^{{{q}}}\\,dy = \\int {a}x^{{{p}}}\\,dx$",
            f"${latex(left_side)} = {latex(right_side)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )

    elif problem_type == 2:
        # dy/dx = (a*y) / (b*x)  — homogeneous, v = y/x substitution
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)

        # v = y/x, y = v*x, dy/dx = v + x*dv/dx
        # v + x*dv/dx = a*v/b
        # x*dv/dx = (a/b - 1)*v = (a - b)/b * v
        # dv/v = (a-b)/b * dx/x
        # ln|v| = (a-b)/b * ln|x| + C
        # v = C * x^((a-b)/b)
        # y = v*x = C * x^(a/b)

        ratio = Rational(a, b)
        question = f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = \\frac{{{a}y}}{{{b}x}}$"

        if ratio == 1:
            ans = Eq(y, c * x)
            ans_latex = "y = Cx"
        else:
            ans = Eq(y, c * x**ratio)
            ans_latex = f"y = Cx^{{{latex(ratio)}}}"

        solution_steps = steps(
            f"This is homogeneous. Let $v = y/x$, so $y = vx$ and $\\frac{{dy}}{{dx}} = v + x\\frac{{dv}}{{dx}}$",
            f"Substitute: $v + x\\frac{{dv}}{{dx}} = \\frac{{{a}v}}{{{b}}}$",
            f"Simplify: $x\\frac{{dv}}{{dx}} = \\left(\\frac{{{a}}}{{{b}}} - 1\\right)v = \\frac{{{a - b}}}{{{b}}}v$",
            f"Separate: $\\frac{{dv}}{{v}} = \\frac{{{a - b}}}{{{b}}} \\cdot \\frac{{dx}}{{x}}$",
            f"Integrate: $\\ln|v| = \\frac{{{a - b}}}{{{b}}}\\ln|x| + C_1$",
            f"Back-substitute $v = y/x$: ${ans_latex}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )

    elif problem_type == 3:
        # dy/dx = k*y  — simplest separable (basis for homogeneous context)
        k_val = nonzero(-5, 5)

        if k_val == 1:
            eq_latex = "\\frac{dy}{dx} = y"
        elif k_val == -1:
            eq_latex = "\\frac{dy}{dx} = -y"
        elif k_val > 0:
            eq_latex = f"\\frac{{dy}}{{dx}} = {k_val}y"
        else:
            eq_latex = f"\\frac{{dy}}{{dx}} = {k_val}y"

        ans = Eq(y, c * exp(k_val * x))

        solution_steps = steps(
            f"Separate variables: $\\frac{{dy}}{{y}} = {k_val}\\,dx$",
            f"Integrate: $\\ln|y| = {latex(k_val * x)} + C_1$",
            f"Exponentiate: $y = Ce^{{{latex(k_val * x)}}}$"
        )

        return problem(
            question=f"Solve the differential equation: ${eq_latex}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )

    else:
        # dy/dx = (a*x + b*y) / (c_coef*x)  — homogeneous via v = y/x
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c_coef = nonzero(-3, 3)

        # dy/dx = a/c_coef + (b/c_coef)*v, where v = y/x
        # v + x*dv/dx = a/c_coef + (b/c_coef)*v
        # x*dv/dx = a/c_coef + (b/c_coef - 1)*v
        # When b = c_coef: x*dv/dx = a/c_coef  =>  v = (a/c_coef)*ln|x| + C
        # y = vx = (a/c_coef)*x*ln|x| + Cx

        ratio_b = Rational(b, c_coef)
        ratio_a = Rational(a, c_coef)

        question = f"Solve the homogeneous differential equation: $\\frac{{dy}}{{dx}} = \\frac{{{a}x + {b}y}}{{{c_coef}x}}$"

        if b == c_coef:
            ans = Eq(y, ratio_a * x * log(Abs(x)) + c * x)
            ans_latex = f"y = {latex(ratio_a)}x\\ln|x| + Cx"
        else:
            k = ratio_b - 1
            # dv/(ratio_a + k*v) = dx/x
            # (1/k)*ln|ratio_a + k*v| = ln|x| + C
            ans_latex = f"{latex(ratio_a)} + {latex(k)}\\frac{{y}}{{x}} = Cx"
            ans = ans_latex

        solution_steps = steps(
            f"Rewrite as $\\frac{{dy}}{{dx}} = \\frac{{{a}}}{{{c_coef}}} + \\frac{{{b}}}{{{c_coef}}} \\cdot \\frac{{y}}{{x}}$",
            f"Let $v = y/x$: $v + x\\frac{{dv}}{{dx}} = {latex(ratio_a)} + {latex(ratio_b)}v$",
            f"$x\\frac{{dv}}{{dx}} = {latex(ratio_a)} + {latex(ratio_b - 1)}v$",
            f"Separate variables and integrate",
            f"Back-substitute $v = y/x$: ${ans_latex}$"
        )

        return problem(
            question=question,
            answer=ans if b == c_coef else Eq(y, x * log(Abs(x)) * ratio_a + c * x),
            difficulty=(1200, 1300),
            topic="differential_equations/homogeneous_equations",
            solution=solution_steps,
            grading_mode="equivalent"
        )


emit(generate())
