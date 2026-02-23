"""
differential_equations - variation_of_parameters (easy)
Generated: 2026-02-22T05:28:46.441851
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # y' + a*y = const  =>  y_p = const/a
        a_coeff = choice([1, 2, 3, 4, 5])
        const = nonzero(-8, 8)

        particular = Rational(const, a_coeff)

        return problem(
            question=f"Find the particular solution to $y' + {a_coeff}y = {const}$ using variation of parameters.",
            answer=particular,
            difficulty=(1000, 1150),
            topic="differential_equations/variation_of_parameters",
            solution=steps(
                f"Homogeneous solution: $y_h = Ce^{{-{a_coeff}x}}$",
                f"Let $y_p = u(x)e^{{-{a_coeff}x}}$; substitute into ODE",
                f"$u'e^{{-{a_coeff}x}} = {const}$, so $u' = {const}e^{{{a_coeff}x}}$",
                f"Integrate: $u = \\frac{{{const}}}{{{a_coeff}}}e^{{{a_coeff}x}}$",
                f"$y_p = \\frac{{{const}}}{{{a_coeff}}}e^{{{a_coeff}x}} \\cdot e^{{-{a_coeff}x}} = {latex(particular)}$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 2:
        # y' - a*y = b*e^(a*x)  =>  y_p = b*x*e^(a*x)
        a_coeff = choice([1, 2, 3, 4])
        b_coeff = nonzero(-6, 6)

        particular = b_coeff * x * exp(a_coeff * x)

        return problem(
            question=f"Find the particular solution to $y' - {a_coeff}y = {b_coeff}e^{{{a_coeff}x}}$ using variation of parameters.",
            answer=particular,
            difficulty=(1100, 1250),
            topic="differential_equations/variation_of_parameters",
            solution=steps(
                f"Homogeneous solution: $y_h = Ce^{{{a_coeff}x}}$",
                f"Let $y_p = u(x)e^{{{a_coeff}x}}$; then $u'e^{{{a_coeff}x}} = {b_coeff}e^{{{a_coeff}x}}$",
                f"$u' = {b_coeff}$, so $u = {b_coeff}x$",
                f"$y_p = {b_coeff}x \\cdot e^{{{a_coeff}x}} = {latex(particular)}$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 3:
        # y' + a*y = b*x  =>  y_p = b*x/a - b/a^2
        a_coeff = choice([1, 2, 3, 4])
        b_coeff = nonzero(-5, 5)

        # IF: e^(a*x); d/dx[y*e^(a*x)] = b*x*e^(a*x)
        # y*e^(a*x) = b * integral(x*e^(a*x)) = b*(x/a - 1/a^2)*e^(a*x) + C
        # y_p = b*(x/a - 1/a^2)
        particular = b_coeff * (x / a_coeff - Rational(1, a_coeff**2))
        particular = simplify(particular)

        return problem(
            question=f"Find the particular solution to $y' + {a_coeff}y = {b_coeff}x$ using variation of parameters.",
            answer=particular,
            difficulty=(1150, 1300),
            topic="differential_equations/variation_of_parameters",
            solution=steps(
                f"Homogeneous solution: $y_h = Ce^{{-{a_coeff}x}}$",
                f"Let $y_p = u(x)e^{{-{a_coeff}x}}$; $u' = {b_coeff}x \\cdot e^{{{a_coeff}x}}$",
                f"Integrate by parts: $u = {b_coeff}\\left(\\frac{{x}}{{{a_coeff}}} - \\frac{{1}}{{{a_coeff**2}}}\\right)e^{{{a_coeff}x}}$",
                f"$y_p = {latex(particular)}$"
            ),
            grading_mode="equivalent"
        )

    else:
        # y' + a*y = b*e^(c*x) with c != -a  =>  y_p = b/(a+c) * e^(c*x)
        a_coeff = choice([1, 2, 3])
        c_val = nonzero(-4, 4)
        while c_val == -a_coeff:
            c_val = nonzero(-4, 4)
        b_coeff = nonzero(-5, 5)

        particular = Rational(b_coeff, a_coeff + c_val) * exp(c_val * x)

        return problem(
            question=f"Find the particular solution to $y' + {a_coeff}y = {b_coeff}e^{{{c_val}x}}$ using variation of parameters.",
            answer=particular,
            difficulty=(1100, 1250),
            topic="differential_equations/variation_of_parameters",
            solution=steps(
                f"Homogeneous solution: $y_h = Ce^{{-{a_coeff}x}}$",
                f"Let $y_p = u(x)e^{{-{a_coeff}x}}$; $u' = {b_coeff}e^{{{c_val}x}} \\cdot e^{{{a_coeff}x}} = {b_coeff}e^{{{a_coeff + c_val}x}}$",
                f"Integrate: $u = \\frac{{{b_coeff}}}{{{a_coeff + c_val}}}e^{{{a_coeff + c_val}x}}$",
                f"$y_p = \\frac{{{b_coeff}}}{{{a_coeff + c_val}}}e^{{{c_val}x}} = {latex(particular)}$"
            ),
            grading_mode="equivalent"
        )


emit(generate())
