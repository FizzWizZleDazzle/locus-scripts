"""
differential_equations - separable_equations (medium)
Generated: 2026-02-22T05:18:59.460572
"""

from problem_utils import *

def generate():
    prob_type = randint(1, 5)

    if prob_type == 1:
        # dy/dx = (a*x^n) / (b*y^m)  — polynomial separation
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        n = randint(1, 4)
        m = randint(1, 3)

        lhs_power = m + 1
        rhs_integral = integrate(a * x**n, x)   # a*x^(n+1)/(n+1)

        question_text = f"\\frac{{dy}}{{dx}} = \\frac{{{latex(a * x**n)}}}{{{latex(b * y**m)}}}"

        # b*y^m dy = a*x^n dx
        # b*y^(m+1)/(m+1) = a*x^(n+1)/(n+1) + C
        left_expr = Rational(b, lhs_power) * y**lhs_power
        ans = Eq(left_expr, rhs_integral + c)

        solution_steps = [
            f"Separate variables: ${b}y^{{{m}}}\\,dy = {a}x^{{{n}}}\\,dx$",
            f"Integrate both sides: $\\int {b}y^{{{m}}}\\,dy = \\int {a}x^{{{n}}}\\,dx$",
            f"${latex(left_expr)} = {latex(rhs_integral)} + C$"
        ]

        difficulty = (1300, 1420)

    elif prob_type == 2:
        # dy/dx = k*x/y  (hyperbola family)
        k = nonzero(-6, 6)

        question_text = f"\\frac{{dy}}{{dx}} = \\frac{{{latex(k * x)}}}{{y}}"

        # y dy = k*x dx  =>  y^2/2 = k*x^2/2 + C  =>  y^2 = k*x^2 + C
        ans = Eq(y**2, k * x**2 + c)

        solution_steps = [
            f"Separate variables: $y\\,dy = {k}x\\,dx$",
            f"Integrate both sides: $\\frac{{y^2}}{{2}} = {latex(Rational(k,2)*x**2)} + C_1$",
            f"Multiply by 2: $y^2 = {k}x^2 + C$"
        ]

        difficulty = (1350, 1480)

    elif prob_type == 3:
        # dy/dx = k*e^(a*x)*y  (exponential coefficient)
        k = nonzero(-4, 4)
        a = nonzero(-4, 4)

        question_text = f"\\frac{{dy}}{{dx}} = {latex(k * exp(a * x) * y)}"

        # dy/y = k*e^(a*x) dx  =>  ln|y| = k/a * e^(a*x) + C
        integral_rhs = integrate(k * exp(a * x), x)
        ans = Eq(log(y), integral_rhs + c)

        solution_steps = [
            f"Separate variables: $\\frac{{dy}}{{y}} = {latex(k * exp(a * x))}\\,dx$",
            f"Integrate: $\\ln|y| = \\int {latex(k * exp(a * x))}\\,dx = {latex(integral_rhs)} + C$"
        ]

        difficulty = (1420, 1530)

    elif prob_type == 4:
        # dy/dx = sin(a*x) * b*y  or  cos(a*x) * b*y
        a = randint(1, 6)
        b = nonzero(-5, 5)
        trig_fn = choice(['sin', 'cos'])

        if trig_fn == 'sin':
            rhs_trig = sin(a * x)
            trig_latex = f"\\sin({a}x)"
            integral_rhs = -cos(a * x) / a
            integral_latex = f"-\\frac{{\\cos({a}x)}}{{{a}}}"
        else:
            rhs_trig = cos(a * x)
            trig_latex = f"\\cos({a}x)"
            integral_rhs = sin(a * x) / a
            integral_latex = f"\\frac{{\\sin({a}x)}}{{{a}}}"

        question_text = f"\\frac{{dy}}{{dx}} = {b}{trig_latex} \\cdot y"

        ans = Eq(log(y), b * integral_rhs + c)

        solution_steps = [
            f"Separate variables: $\\frac{{dy}}{{y}} = {b}{trig_latex}\\,dx$",
            f"Integrate: $\\ln|y| = {b} \\cdot {integral_latex} + C = {latex(b * integral_rhs)} + C$"
        ]

        difficulty = (1480, 1580)

    else:
        # dy/dx = a*e^x / (b*y^2)  — exponential/polynomial mix
        a = nonzero(-5, 5)
        b = nonzero(-4, 4)

        question_text = f"\\frac{{dy}}{{dx}} = \\frac{{{latex(a * exp(x))}}}{{{latex(b * y**2)}}}"

        # b*y^2 dy = a*e^x dx  =>  b*y^3/3 = a*e^x + C
        ans = Eq(Rational(b, 3) * y**3, a * exp(x) + c)

        solution_steps = [
            f"Separate variables: ${b}y^2\\,dy = {a}e^x\\,dx$",
            f"Integrate: $\\frac{{{b}y^3}}{{3}} = {a}e^x + C$"
        ]

        difficulty = (1520, 1600)

    return problem(
        question=f"Solve the differential equation: ${question_text}$",
        answer=ans,
        difficulty=difficulty,
        topic="differential_equations/separable_equations",
        solution=steps(*solution_steps),
        answer_type="equation",
        grading_mode="equivalent"
    )


emit(generate())
