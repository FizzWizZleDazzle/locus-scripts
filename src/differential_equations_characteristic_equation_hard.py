"""
differential_equations - characteristic_equation (hard)
Generated: 2026-02-22T05:26:46.117468
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 5)

    if difficulty_choice == 1:
        # Third-order: one real root + pair of complex roots
        r1 = nonzero(-5, 5)
        alpha = randint(-4, 4)
        beta = randint(1, 6)

        # (r - r1)(r^2 - 2*alpha*r + alpha^2 + beta^2)
        a2 = -(r1 + 2 * alpha)
        a1 = r1 * 2 * alpha + alpha ** 2 + beta ** 2
        a0 = -r1 * (alpha ** 2 + beta ** 2)

        sign = lambda v: f"+ {v}" if v >= 0 else f"- {-v}"

        poly_latex = f"r^3 {sign(a2)}r^2 {sign(a1)}r {sign(a0)}"

        ans_parts = [f"r = {r1}", f"r = {alpha} + {beta}i", f"r = {alpha} - {beta}i"]
        ans_str = fmt_set(ans_parts)

        return problem(
            question=f"Find all roots of the characteristic equation ${poly_latex} = 0$",
            answer=ans_str,
            difficulty=(1600, 1700),
            topic="differential_equations/characteristic_equation",
            answer_type="set",
            solution=steps(
                f"Use the rational root theorem; test $r = {r1}$",
                f"${r1}^3 {sign(a2)}\\cdot{r1}^2 {sign(a1)}\\cdot{r1} {sign(a0)} = 0$ ✓",
                f"Factor out $(r - {r1})$: quotient is $r^2 - {2*alpha}r + {alpha**2 + beta**2}$",
                f"Quadratic formula gives $r = \\frac{{{2*alpha} \\pm \\sqrt{{{4*alpha**2} - {4*(alpha**2 + beta**2)}}}}}{{{2}}}$",
                f"$r = {alpha} \\pm {beta}i$",
                f"All roots: $r = {r1},\\; {alpha} + {beta}i,\\; {alpha} - {beta}i$"
            ),
        )

    elif difficulty_choice == 2:
        # Fourth-order: two distinct repeated roots (r-r1)^2(r-r2)^2
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        poly = expand((x - r1) ** 2 * (x - r2) ** 2)

        ans_parts = [f"r = {r1}", f"r = {r2}"]
        ans_str = fmt_set(ans_parts)

        return problem(
            question=f"Find all distinct roots of the characteristic equation ${latex(poly)} = 0$ (use $r$ instead of $x$)",
            answer=ans_str,
            difficulty=(1650, 1750),
            topic="differential_equations/characteristic_equation",
            answer_type="set",
            solution=steps(
                f"Recognise the polynomial as $(r - {r1})^2(r - {r2})^2$",
                f"$r = {r1}$ (multiplicity 2), $r = {r2}$ (multiplicity 2)",
                f"Distinct roots: $r = {r1},\\; {r2}$"
            ),
        )

    elif difficulty_choice == 3:
        # Reconstruct characteristic equation from general solution
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r2 == r1:
            r2 = nonzero(-5, 5)

        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        b_sign = f"{b_coeff:+d}"
        c_sign = f"{c_coeff:+d}"
        char_eq = f"r^2 {b_sign}r {c_sign} = 0"

        ans_str = fmt_set([f"r = {r1}", f"r = {r2}"])

        return problem(
            question=f"The general solution to a second-order linear homogeneous ODE is $y = c_1 e^{{{r1}t}} + c_2 e^{{{r2}t}}$. Find the roots of its characteristic equation.",
            answer=ans_str,
            difficulty=(1700, 1800),
            topic="differential_equations/characteristic_equation",
            answer_type="set",
            solution=steps(
                f"The exponential factors $e^{{{r1}t}}$ and $e^{{{r2}t}}$ reveal characteristic roots",
                f"$r_1 = {r1}$, $r_2 = {r2}$",
                f"Characteristic equation: $(r - {r1})(r - {r2}) = 0$, i.e. ${char_eq}$"
            ),
        )

    elif difficulty_choice == 4:
        # Find parameter k so characteristic equation has given roots
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r2 == r1:
            r2 = nonzero(-5, 5)

        product = r1 * r2
        ans_k = -(r1 + r2)
        prod_sign = f"{product:+d}" if product < 0 else str(product)

        return problem(
            question=f"For what value of $k$ does the characteristic equation $r^2 + kr + {prod_sign} = 0$ have roots $r = {r1}$ and $r = {r2}$?",
            answer=ans_k,
            difficulty=(1750, 1850),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"By Vieta's formulas: sum of roots $= {r1} + {r2} = -k$",
                f"Product of roots $= {r1} \\cdot {r2} = {product}$ ✓",
                f"Therefore $k = -({r1} + {r2}) = {ans_k}$"
            ),
        )

    else:
        # Fourth-order: (r - r1)^2 * (r^2 - 2*alpha*r + alpha^2 + beta^2)
        r1 = nonzero(-3, 3)
        alpha = randint(-3, 3)
        beta = randint(1, 5)

        quad_part = x ** 2 - 2 * alpha * x + alpha ** 2 + beta ** 2
        poly = expand((x - r1) ** 2 * quad_part)

        ans_parts = [f"r = {r1}", f"r = {alpha} + {beta}i", f"r = {alpha} - {beta}i"]
        ans_str = fmt_set(ans_parts)

        disc_inner = 4 * alpha ** 2 - 4 * (alpha ** 2 + beta ** 2)

        return problem(
            question=f"Find all distinct roots of the characteristic equation ${latex(poly)} = 0$ (use $r$ for the variable)",
            answer=ans_str,
            difficulty=(1800, 1950),
            topic="differential_equations/characteristic_equation",
            answer_type="set",
            calculator="scientific",
            solution=steps(
                f"Factor: $(r - {r1})^2 \\cdot ({latex(quad_part)})$",
                f"From $(r - {r1})^2 = 0$: $r = {r1}$ (multiplicity 2)",
                f"From ${latex(quad_part)} = 0$: $r = \\frac{{{2*alpha} \\pm \\sqrt{{{disc_inner}}}}}{2}$",
                f"$r = {alpha} \\pm {beta}i$",
                f"Distinct roots: $r = {r1},\\; {alpha} + {beta}i,\\; {alpha} - {beta}i$"
            ),
        )


emit(generate())
