"""
differential_equations - characteristic_equation (medium)
Generated: 2026-02-22T05:26:15.688608
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 3)

    if problem_type == 1:
        # Distinct real roots with wider range
        r1 = nonzero(-6, 6)
        r2 = nonzero(-6, 6)
        while r2 == r1:
            r2 = nonzero(-6, 6)

        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        b_sign = f"{b_coeff:+d}"
        c_sign = f"{c_coeff:+d}"

        ode_latex = f"y'' {b_sign}y' {c_sign}y = 0"
        char_eq = r**2 + b_coeff * r + c_coeff

        ans = FiniteSet(r1, r2)

        return problem(
            question=f"Find the characteristic equation and its roots for the differential equation ${ode_latex}$",
            answer=ans,
            difficulty=(1300, 1430),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"Substitute $y = e^{{rt}}$ into the ODE",
                f"Characteristic equation: ${latex(char_eq)} = 0$",
                f"Factor: $(r - {r1})(r - {r2}) = 0$",
                f"Roots: $r_1 = {r1}$, $r_2 = {r2}$"
            ),
            answer_type="set"
        )

    elif problem_type == 2:
        # Repeated real root
        r1 = nonzero(-5, 5)

        b_coeff = -2 * r1
        c_coeff = r1 ** 2

        b_sign = f"{b_coeff:+d}"
        c_sign = f"{c_coeff:+d}"

        ode_latex = f"y'' {b_sign}y' {c_sign}y = 0"
        char_eq = r**2 + b_coeff * r + c_coeff

        ans = FiniteSet(r1)

        return problem(
            question=f"Find the characteristic equation and its roots for the differential equation ${ode_latex}$",
            answer=ans,
            difficulty=(1430, 1530),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"The characteristic equation is: ${latex(char_eq)} = 0$",
                f"Discriminant: $\\Delta = ({b_coeff})^2 - 4({c_coeff}) = {b_coeff**2 - 4*c_coeff}$",
                f"Factor: $(r - {r1})^2 = 0$",
                f"Repeated root: $r = {r1}$ (multiplicity 2)"
            ),
            answer_type="set"
        )

    else:
        # Complex roots r = alpha ± beta*i
        alpha = randint(-4, 4)
        beta = randint(1, 6)

        b_coeff = -2 * alpha
        c_coeff = alpha ** 2 + beta ** 2

        b_sign = f"{b_coeff:+d}"
        c_sign = f"{c_coeff:+d}"

        ode_latex = f"y'' {b_sign}y' {c_sign}y = 0"
        char_eq = r**2 + b_coeff * r + c_coeff
        disc = b_coeff**2 - 4 * c_coeff

        root1 = alpha + beta * I
        root2 = alpha - beta * I
        ans = FiniteSet(root1, root2)

        return problem(
            question=f"Find the characteristic equation and its roots for the differential equation ${ode_latex}$",
            answer=ans,
            difficulty=(1530, 1600),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"The characteristic equation is: ${latex(char_eq)} = 0$",
                f"Quadratic formula: $r = \\frac{{-({b_coeff}) \\pm \\sqrt{{({b_coeff})^2 - 4({c_coeff})}}}}{{2}}$",
                f"Discriminant: $\\Delta = {b_coeff**2} - {4*c_coeff} = {disc}$",
                f"Since $\\Delta < 0$: $r = {alpha} \\pm {beta}i$"
            ),
            answer_type="set"
        )


emit(generate())
