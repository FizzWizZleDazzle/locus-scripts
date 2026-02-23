"""
differential_equations - second_order_constant (easy)
Generated: 2026-02-22T05:24:31.296042
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # General solution with distinct real roots (wider range)
        r1 = randint(-5, 5)
        r2 = randint(-5, 5)
        while r2 == r1 or r1 == 0 or r2 == 0:
            r1 = randint(-5, 5)
            r2 = randint(-5, 5)

        b_coef = -(r1 + r2)
        c_coef = r1 * r2

        C1, C2 = symbols('C_1 C_2')
        ans = C1 * exp(r1 * t) + C2 * exp(r2 * t)

        return problem(
            question=f"Find the general solution to $y''{b_coef:+d}y'{c_coef:+d}y=0$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coef:+d}r{c_coef:+d}=0$",
                f"Factor: $(r-{r1})(r-{r2})=0$",
                f"Roots: $r_1={r1}$, $r_2={r2}$",
                f"General solution: $y=C_1e^{{{r1}t}}+C_2e^{{{r2}t}}$"
            ),
        )

    elif problem_type == 2:
        # IVP with distinct real roots
        r1 = randint(-4, 4)
        r2 = randint(-4, 4)
        while r2 == r1 or r1 == 0 or r2 == 0:
            r1 = randint(-4, 4)
            r2 = randint(-4, 4)

        y0 = randint(-5, 5)
        yp0 = randint(-8, 8)

        # y(0)=C1+C2=y0, y'(0)=r1*C1+r2*C2=yp0
        if r1 != r2:
            C1_val = Rational(yp0 - r2 * y0, r1 - r2)
            C2_val = y0 - C1_val
        else:
            C1_val = y0
            C2_val = yp0 - r1 * y0

        ans = C1_val * exp(r1 * t) + C2_val * exp(r2 * t)

        b_coef = -(r1 + r2)
        c_coef = r1 * r2

        return problem(
            question=f"Solve the IVP: $y''{b_coef:+d}y'{c_coef:+d}y=0$, $y(0)={y0}$, $y'(0)={yp0}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation roots: $r={r1},{r2}$",
                f"General solution: $y=C_1e^{{{r1}t}}+C_2e^{{{r2}t}}$",
                f"$y(0)={y0}$: $C_1+C_2={y0}$",
                f"$y'(0)={yp0}$: ${r1}C_1+{r2}C_2={yp0}$",
                f"$C_1={latex(C1_val)}$, $C_2={latex(C2_val)}$",
                f"Solution: $y={latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Repeated real root general solution
        r1 = nonzero(-5, 5)

        b_coef = -2 * r1
        c_coef = r1 ** 2

        C1, C2 = symbols('C_1 C_2')
        ans = (C1 + C2 * t) * exp(r1 * t)

        return problem(
            question=f"Find the general solution to $y''{b_coef:+d}y'{c_coef:+d}y=0$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coef:+d}r{c_coef:+d}=0$",
                f"Factor: $(r-{r1})^2=0$",
                f"Repeated root $r={r1}$: $y=(C_1+C_2 t)e^{{{r1}t}}$"
            ),
        )

    else:
        # Complex roots: r = alpha ± beta*i
        alpha = randint(-4, 4)
        beta = randint(1, 6)

        b_coef = -2 * alpha
        c_coef = alpha ** 2 + beta ** 2

        C1, C2 = symbols('C_1 C_2')
        ans = exp(alpha * t) * (C1 * cos(beta * t) + C2 * sin(beta * t))

        return problem(
            question=f"Find the general solution to $y''{b_coef:+d}y'{c_coef:+d}y=0$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/second_order_constant",
            solution=steps(
                f"Characteristic equation: $r^2{b_coef:+d}r{c_coef:+d}=0$",
                f"Discriminant: $\\Delta = {b_coef**2 - 4*c_coef}$ (negative)",
                f"Complex roots: $r = {alpha} \\pm {beta}i$",
                f"$y = e^{{{alpha}t}}(C_1\\cos({beta}t) + C_2\\sin({beta}t))$"
            ),
        )


emit(generate())
