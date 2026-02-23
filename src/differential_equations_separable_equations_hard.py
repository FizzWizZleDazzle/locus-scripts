"""
differential_equations - separable_equations (hard)
Generated: 2026-02-22T05:19:41.525814
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # IVP: y^2 dy = k*x^(m-1) dx
        k = nonzero(-5, 5)
        m = choice([2, 3, 4, 5])
        x0 = choice([0, 1, 2])
        y0 = nonzero(1, 5)

        C_val = Rational(y0**3, 3) - k * Rational(x0**m, m)

        question = f"Solve the IVP: $\\frac{{dy}}{{dx}} = \\frac{{{latex(k * x**(m-1))}}}{{y^2}}$, $y({x0}) = {y0}$"

        ans = cbrt(3 * k * x**m / m + 3 * C_val)

        sol_steps = steps(
            f"Separate variables: $y^2\\,dy = {latex(k * x**(m-1))}\\,dx$",
            f"Integrate: $\\frac{{y^3}}{{3}} = {latex(k * x**m / m)} + C$",
            f"Apply $y({x0}) = {y0}$: $C = {latex(C_val)}$",
            f"$y^3 = {latex(3 * k * x**m / m + 3 * C_val)}$",
            f"$y = {latex(ans)}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1750),
            topic="differential_equations/separable_equations",
            solution=sol_steps
        )

    elif problem_type == 2:
        # Logistic equation: dy/dx = y(a - b*y)
        a = randint(1, 5)
        b = randint(1, 4)

        question = f"Solve: $\\frac{{dy}}{{dx}} = y({a} - {b}y)$"

        C1 = symbols('C_1')
        ans = a * C1 * exp(a * x) / (1 + b * C1 * exp(a * x))

        sol_steps = steps(
            f"Separate: $\\frac{{dy}}{{y({a} - {b}y)}} = dx$",
            f"Partial fractions: $\\frac{{1}}{{y({a} - {b}y)}} = \\frac{{1}}{{{a}y}} + \\frac{{{b}}}{{{a}({a} - {b}y)}}$",
            f"Integrate: $\\frac{{1}}{{{a}}}\\ln|y| - \\frac{{1}}{{{a}}}\\ln|{a} - {b}y| = x + C$",
            f"Simplify: $\\ln\\left|\\frac{{y}}{{{a} - {b}y}}\\right| = {a}x + {a}C$",
            f"Exponentiate: $\\frac{{y}}{{{a} - {b}y}} = C_1 e^{{{a}x}}$",
            f"Solve for $y$: $y = \\frac{{{a}C_1 e^{{{a}x}}}}{{1 + {b}C_1 e^{{{a}x}}}}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1800),
            topic="differential_equations/separable_equations",
            solution=sol_steps
        )

    elif problem_type == 3:
        # dy/dx = f(x) * sec^2(y)  =>  cos^2(y) dy = f(x) dx  =>  tan(y) = F(x) + C
        a = nonzero(-5, 5)
        m = choice([1, 2, 3])
        f_x = a * x**m
        F_x = integrate(f_x, x)

        question = f"Solve: $\\frac{{dy}}{{dx}} = {latex(f_x)} \\sec^2(y)$"

        C1 = symbols('C_1')
        ans_implicit = Eq(tan(y), F_x + C1)

        sol_steps = steps(
            f"Separate: $\\frac{{dy}}{{\\sec^2(y)}} = {latex(f_x)}\\,dx$, i.e. $\\cos^2(y)\\,dy = {latex(f_x)}\\,dx$",
            f"Since $\\frac{{d}}{{dy}}[\\tan y] = \\sec^2 y$, divide both sides of original by $\\sec^2 y$:",
            f"$\\int dy/\\sec^2 y$ leads to $\\tan(y) = \\int {latex(f_x)}\\,dx$",
            f"$\\tan(y) = {latex(F_x)} + C_1$"
        )

        return problem(
            question=question,
            answer=ans_implicit,
            difficulty=(1600, 1700),
            topic="differential_equations/separable_equations",
            solution=sol_steps,
            answer_type="equation"
        )

    elif problem_type == 4:
        # Limited-growth IVP: dy/dt = k*y*(M - y)
        k_choices = [Rational(1, 10), Rational(1, 5), Rational(1, 4), Rational(1, 8), Rational(3, 20)]
        k = choice(k_choices)
        M = choice([50, 100, 200, 150])
        y0 = choice([5, 10, 20, 25])
        t0 = 0

        K_val = Rational(y0, M - y0)

        ans = M * K_val * exp(M * k * t) / (1 + K_val * exp(M * k * t))

        question = f"Solve the IVP: $\\frac{{dy}}{{dt}} = {latex(k)}y({M} - y)$, $y({t0}) = {y0}$"

        sol_steps = steps(
            f"Separate: $\\frac{{dy}}{{y({M} - y)}} = {latex(k)}\\,dt$",
            f"Partial fractions: $\\frac{{1}}{{y({M} - y)}} = \\frac{{1}}{{{M}y}} + \\frac{{1}}{{{M}({M} - y)}}$",
            f"Integrate and exponentiate: $\\frac{{y}}{{{M} - y}} = Ke^{{{latex(M * k)}t}}$",
            f"Apply $y({t0}) = {y0}$: $K = \\frac{{{y0}}}{{{M - y0}}} = {latex(K_val)}$",
            f"$y = {latex(ans)}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1750, 1850),
            topic="differential_equations/separable_equations",
            solution=sol_steps
        )

    else:
        # dy/dx = e^(a*x + b*y)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)

        question = f"Solve: $\\frac{{dy}}{{dx}} = e^{{{latex(a * x + b * y)}}}$"

        C1 = symbols('C_1')
        # e^(-b*y) dy = e^(a*x) dx
        # -1/b * e^(-b*y) = 1/a * e^(a*x) + C
        ans_implicit = Eq(-exp(-b * y) / b, exp(a * x) / a + C1)

        sol_steps = steps(
            f"Factor: $\\frac{{dy}}{{dx}} = e^{{{a}x}} \\cdot e^{{{b}y}}$",
            f"Separate: $e^{{-{b}y}}\\,dy = e^{{{a}x}}\\,dx$",
            f"Integrate: $-\\frac{{e^{{-{b}y}}}}{{{b}}} = \\frac{{e^{{{a}x}}}}{{{a}}} + C_1$"
        )

        return problem(
            question=question,
            answer=ans_implicit,
            difficulty=(1650, 1760),
            topic="differential_equations/separable_equations",
            solution=sol_steps,
            answer_type="equation"
        )


emit(generate())
