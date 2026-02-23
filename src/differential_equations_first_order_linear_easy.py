"""
differential_equations - first_order_linear (easy)
Generated: 2026-02-22T05:20:01.222580
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # dy/dx + a*y = 0  (homogeneous)
        a = nonzero(-6, 6)

        C = symbols('C')
        ans = C * exp(-a * x)

        return problem(
            question=f"Solve the differential equation: $\\frac{{dy}}{{dx}} + {a}y = 0$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Separate: $\\frac{{dy}}{{y}} = -{a}\\,dx$",
                f"Integrate: $\\ln|y| = {-a}x + C_1$",
                f"$y = Ce^{{{-a}x}}$"
            ),
        )

    elif problem_type == 2:
        # dy/dx + a*y = b  (constant forcing)
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)

        C = symbols('C')
        ans = Rational(b, a) + C * exp(-a * x)

        return problem(
            question=f"Solve the differential equation: $\\frac{{dy}}{{dx}} + {a}y = {b}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = e^{{{a}x}}$",
                f"Multiply: $\\frac{{d}}{{dx}}[e^{{{a}x}}y] = {b}e^{{{a}x}}$",
                f"Integrate: $e^{{{a}x}}y = \\frac{{{b}}}{{{a}}}e^{{{a}x}} + C$",
                f"$y = {latex(Rational(b,a))} + Ce^{{{-a}x}}$"
            ),
        )

    elif problem_type == 3:
        # dy/dx = k*y  (growth/decay, wider range)
        k = nonzero(-6, 6)

        C = symbols('C')
        ans = C * exp(k * x)

        return problem(
            question=f"Solve the differential equation: $\\frac{{dy}}{{dx}} = {k}y$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Separate: $\\frac{{dy}}{{y}} = {k}\\,dx$",
                f"Integrate: $\\ln|y| = {k}x + C_1$",
                f"$y = Ce^{{{k}x}}$"
            ),
        )

    elif problem_type == 4:
        # dy/dx + y = a*x + b  (linear forcing)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)

        # IF: e^x; d/dx[e^x*y] = (a*x+b)*e^x
        # Integrate by parts: e^x*(a*x+b) int = (a*x + b - a)*e^x + C  (for a*x)
        # y_p = a*x + b - a = a*(x-1) + b
        C = symbols('C')
        y_p = a * x + b - a
        ans = y_p + C * exp(-x)

        return problem(
            question=f"Solve the differential equation: $\\frac{{dy}}{{dx}} + y = {latex(a*x+b)}$",
            answer=ans,
            difficulty=(1200, 1280),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = e^x$",
                f"$\\frac{{d}}{{dx}}[e^x y] = ({latex(a*x+b)})e^x$",
                f"Integrate by parts: $e^x y = ({latex(y_p)})e^x + C$",
                f"$y = {latex(y_p)} + Ce^{{-x}}$"
            ),
        )

    else:
        # dy/dx + a*y = b*e^(c*x) with c != -a
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        c = nonzero(-4, 4)
        while c == -a:
            c = nonzero(-4, 4)

        # y_p = b/(a+c) * e^(c*x)
        C = symbols('C')
        y_p = Rational(b, a + c) * exp(c * x)
        ans = y_p + C * exp(-a * x)

        return problem(
            question=f"Solve the differential equation: $\\frac{{dy}}{{dx}} + {a}y = {b}e^{{{c}x}}$",
            answer=ans,
            difficulty=(1150, 1270),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = e^{{{a}x}}$",
                f"$\\frac{{d}}{{dx}}[e^{{{a}x}}y] = {b}e^{{{a+c}x}}$",
                f"Integrate: $e^{{{a}x}}y = \\frac{{{b}}}{{{a+c}}}e^{{{a+c}x}} + C$",
                f"$y = {latex(y_p)} + Ce^{{{-a}x}}$"
            ),
        )


emit(generate())
