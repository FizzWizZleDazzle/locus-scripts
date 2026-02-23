"""
differential_equations - separable_equations (easy)
Generated: 2026-02-22T05:18:37.350626
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # dy/dx = k*y  (exponential growth/decay)
        k_val = nonzero(-6, 6)

        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(k_val)}y$"

        C = symbols('C')
        ans = Eq(y, C * exp(k_val * x))

        solution = steps(
            f"Separate variables: $\\frac{{dy}}{{y}} = {k_val}\\,dx$",
            f"Integrate both sides: $\\ln|y| = {latex(k_val * x)} + C_1$",
            f"Exponentiate: $y = Ce^{{{latex(k_val * x)}}}$",
            f"General solution: ${latex(ans)}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )

    elif problem_type == 2:
        # dy/dx = a * x^n  (direct integration)
        a = nonzero(-6, 6)
        n = randint(1, 4)

        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(a * x**n)}$"

        C = symbols('C')
        integrated = integrate(a * x**n, x)
        ans = Eq(y, integrated + C)

        solution = steps(
            f"Separate: $dy = {latex(a * x**n)}\\,dx$",
            f"Integrate both sides: $y = \\int {latex(a * x**n)}\\,dx$",
            f"$y = {latex(integrated)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )

    elif problem_type == 3:
        # dy/dx = a*y^2  (separable with y^2)
        a = nonzero(-5, 5)

        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(a * y**2)}$"

        C = symbols('C')
        ans = Eq(y, -1 / (a * x + C))

        solution = steps(
            f"Separate variables: $\\frac{{dy}}{{y^2}} = {a}\\,dx$",
            f"Integrate: $\\int y^{{-2}}\\,dy = \\int {a}\\,dx$",
            f"$-\\frac{{1}}{{y}} = {latex(a * x)} + C_1$",
            f"Solve for $y$: $y = -\\frac{{1}}{{{latex(a * x)} + C}}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1250),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )

    elif problem_type == 4:
        # dy/dx = a*x*y  (Gaussian-type)
        a = nonzero(-5, 5)

        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(a * x * y)}$"

        C = symbols('C')
        exponent = Rational(a, 2) * x**2
        ans = Eq(y, C * exp(exponent))

        solution = steps(
            f"Separate variables: $\\frac{{dy}}{{y}} = {a}x\\,dx$",
            f"Integrate: $\\ln|y| = {latex(exponent)} + C_1$",
            f"Exponentiate: $y = Ce^{{{latex(exponent)}}}$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1250, 1300),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )

    else:
        # dy/dx = a*e^(b*x)  (exponential right-hand side)
        a = nonzero(-5, 5)
        b = nonzero(-4, 4)

        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(a * exp(b * x))}$"

        C = symbols('C')
        integrated = integrate(a * exp(b * x), x)
        ans = Eq(y, integrated + C)

        solution = steps(
            f"Integrate directly: $y = \\int {latex(a * exp(b * x))}\\,dx$",
            f"$y = {latex(integrated)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )


emit(generate())
