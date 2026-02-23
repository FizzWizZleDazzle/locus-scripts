"""
differential_equations - second_order_constant (medium)
Generated: 2026-02-22T05:24:57.613871
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # Homogeneous — distinct real roots (wider range)
        r1 = nonzero(-6, 6)
        r2 = nonzero(-6, 6)
        while r2 == r1:
            r2 = nonzero(-6, 6)

        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        C1, C2 = symbols('C_1 C_2')
        ans = C1 * exp(r1 * t) + C2 * exp(r2 * t)

        diff_eq = f"y''{b_coeff:+d}y'{c_coeff:+d}y = 0"

        return problem(
            question=f"Find the general solution to the differential equation: ${diff_eq}$",
            answer=ans,
            difficulty=(1300, 1430),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coeff:+d}r{c_coeff:+d}=0$",
                f"Factor: $(r-{r1})(r-{r2})=0$",
                f"Roots: $r_1={r1}$, $r_2={r2}$",
                f"General solution: $y = C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}}$"
            ),
            answer_type="expression"
        )

    elif problem_type == 2:
        # Homogeneous — repeated root
        r = nonzero(-5, 5)

        b_coeff = -2 * r
        c_coeff = r ** 2

        C1, C2 = symbols('C_1 C_2')
        ans = (C1 + C2 * t) * exp(r * t)

        diff_eq = f"y''{b_coeff:+d}y'{c_coeff:+d}y = 0"

        return problem(
            question=f"Find the general solution to the differential equation: ${diff_eq}$",
            answer=ans,
            difficulty=(1400, 1530),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coeff:+d}r{c_coeff:+d}=0$",
                f"Factor: $(r-{r})^2=0$; repeated root $r={r}$",
                f"General solution: $y = (C_1 + C_2 t)e^{{{r}t}}$"
            ),
            answer_type="expression"
        )

    elif problem_type == 3:
        # Homogeneous — complex roots
        alpha = randint(-4, 4)
        beta = randint(1, 6)

        b_coeff = -2 * alpha
        c_coeff = alpha ** 2 + beta ** 2

        C1, C2 = symbols('C_1 C_2')
        ans = exp(alpha * t) * (C1 * cos(beta * t) + C2 * sin(beta * t))

        diff_eq = f"y''{b_coeff:+d}y'{c_coeff:+d}y = 0"

        return problem(
            question=f"Find the general solution to the differential equation: ${diff_eq}$",
            answer=ans,
            difficulty=(1450, 1580),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coeff:+d}r{c_coeff:+d}=0$",
                f"Using quadratic formula: $r = {alpha} \\pm {beta}i$",
                f"General solution: $y = e^{{{alpha}t}}(C_1\\cos({beta}t) + C_2\\sin({beta}t))$"
            ),
            answer_type="expression"
        )

    else:
        # Non-homogeneous: y'' + b*y' + c*y = rhs (constant)
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2

        rhs = nonzero(-10, 10)
        y_p = Rational(rhs, c_coeff)

        C1, C2 = symbols('C_1 C_2')
        yh = C1 * exp(r1 * t) + C2 * exp(r2 * t)
        ans = yh + y_p

        diff_eq = f"y''{b_coeff:+d}y'{c_coeff:+d}y = {rhs}"

        return problem(
            question=f"Find the general solution to the differential equation: ${diff_eq}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Homogeneous: $y_h = C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}}$",
                f"Particular (try $y_p = A$): ${c_coeff}A = {rhs}$, so $A = {latex(y_p)}$",
                f"General solution: $y = C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}} + {latex(y_p)}$"
            ),
            answer_type="expression"
        )


emit(generate())
