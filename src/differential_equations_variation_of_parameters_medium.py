"""
differential_equations - variation_of_parameters (medium)
Generated: 2026-02-22T05:29:15.106930
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 4)

    if difficulty_choice == 1:
        # Distinct real roots + polynomial forcing
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        y1 = exp(r1 * x)
        y2 = exp(r2 * x)

        poly_coeff = nonzero(-5, 5)
        power = randint(0, 2)
        g = poly_coeff * x**power

        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))
        u1_prime = simplify(-y2 * g / W)
        u2_prime = simplify(y1 * g / W)
        u1 = integrate(u1_prime, x)
        u2 = integrate(u2_prime, x)
        y_p = simplify(u1 * y1 + u2 * y2)

        b_sign = f"{-(r1 + r2):+d}"
        c_sign = f"{r1 * r2:+d}"

        question = (f"Use variation of parameters to find a particular solution for "
                    f"$y'' {b_sign}y' {c_sign}y = {latex(g)}$. "
                    f"The complementary solution is $y_c = c_1 e^{{{r1}x}} + c_2 e^{{{r2}x}}$.")

        solution = steps(
            f"$y_1 = {latex(y1)}$, $y_2 = {latex(y2)}$",
            f"Wronskian: $W = {latex(W)}$",
            f"$u_1' = -\\frac{{y_2 g}}{{W}} = {latex(u1_prime)}$, $u_2' = \\frac{{y_1 g}}{{W}} = {latex(u2_prime)}$",
            f"Integrate: $u_1 = {latex(u1)}$, $u_2 = {latex(u2)}$",
            f"$y_p = u_1 y_1 + u_2 y_2 = {latex(y_p)}$"
        )

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1300, 1430),
            topic="differential_equations/variation_of_parameters",
            solution=solution,
            calculator="scientific"
        )

    elif difficulty_choice == 2:
        # Complex roots + exponential forcing
        alpha = randint(-3, 3)
        beta = randint(1, 5)

        y1 = exp(alpha * x) * cos(beta * x)
        y2 = exp(alpha * x) * sin(beta * x)

        exp_coeff = nonzero(-4, 4)
        exp_power = nonzero(-3, 3)
        while exp_power == alpha:
            exp_power = nonzero(-3, 3)
        g = exp_coeff * exp(exp_power * x)

        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))
        u1_prime = simplify(-y2 * g / W)
        u2_prime = simplify(y1 * g / W)
        u1 = integrate(u1_prime, x)
        u2 = integrate(u2_prime, x)
        y_p = simplify(u1 * y1 + u2 * y2)

        b_val = -2 * alpha
        c_val = alpha**2 + beta**2
        b_sign = f"{b_val:+d}"
        c_sign = f"{c_val:+d}"

        question = (f"Use variation of parameters to find a particular solution for "
                    f"$y'' {b_sign}y' {c_sign}y = {latex(g)}$. "
                    f"The complementary solution is $y_c = e^{{{alpha}x}}(c_1\\cos({beta}x) + c_2\\sin({beta}x))$.")

        solution = steps(
            f"$y_1 = {latex(y1)}$, $y_2 = {latex(y2)}$",
            f"Wronskian: $W = {latex(W)}$",
            f"$u_1' = {latex(u1_prime)}$, $u_2' = {latex(u2_prime)}$",
            f"Integrate: $u_1 = {latex(u1)}$, $u_2 = {latex(u2)}$",
            f"$y_p = {latex(y_p)}$"
        )

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1430, 1540),
            topic="differential_equations/variation_of_parameters",
            solution=solution,
            calculator="scientific"
        )

    elif difficulty_choice == 3:
        # Pure real roots + trig forcing
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        y1 = exp(r1 * x)
        y2 = exp(r2 * x)

        omega = randint(1, 6)
        trig_fn = choice(['sin', 'cos'])
        g = sin(omega * x) if trig_fn == 'sin' else cos(omega * x)

        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))
        u1_prime = simplify(-y2 * g / W)
        u2_prime = simplify(y1 * g / W)
        u1 = integrate(u1_prime, x)
        u2 = integrate(u2_prime, x)
        y_p = simplify(u1 * y1 + u2 * y2)

        b_sign = f"{-(r1 + r2):+d}"
        c_sign = f"{r1 * r2:+d}"
        trig_latex = f"\\sin({omega}x)" if trig_fn == 'sin' else f"\\cos({omega}x)"

        question = (f"Use variation of parameters to find a particular solution for "
                    f"$y'' {b_sign}y' {c_sign}y = {trig_latex}$. "
                    f"The complementary solution is $y_c = c_1 e^{{{r1}x}} + c_2 e^{{{r2}x}}$.")

        solution = steps(
            f"$y_1 = {latex(y1)}$, $y_2 = {latex(y2)}$, $W = {latex(W)}$",
            f"$u_1' = {latex(u1_prime)}$, $u_2' = {latex(u2_prime)}$",
            f"$u_1 = {latex(u1)}$, $u_2 = {latex(u2)}$",
            f"$y_p = {latex(y_p)}$"
        )

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1480, 1580),
            topic="differential_equations/variation_of_parameters",
            solution=solution,
            calculator="scientific"
        )

    else:
        # Pure imaginary roots (omega) + sec forcing
        omega = randint(1, 4)

        y1 = cos(omega * x)
        y2 = sin(omega * x)

        g = sec(omega * x)

        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))

        # u1 = integral(-sin(omega*x)*sec(omega*x)/omega) = -ln|sec(omega*x)|/omega^2 (via tan integral)
        # u2 = integral(cos(omega*x)*sec(omega*x)/omega) = x/omega
        u1 = log(cos(omega * x)) / omega**2
        u2 = x / omega

        y_p = simplify(u1 * y1 + u2 * y2)

        question = (f"Use variation of parameters to find a particular solution for "
                    f"$y'' + {omega**2}y = \\sec({omega}x)$. "
                    f"The complementary solution is $y_c = c_1\\cos({omega}x) + c_2\\sin({omega}x)$.")

        solution = steps(
            f"$y_1 = \\cos({omega}x)$, $y_2 = \\sin({omega}x)$, $W = {omega}$",
            f"$u_1' = -\\frac{{\\sin({omega}x)\\sec({omega}x)}}{{{omega}}} = -\\frac{{\\tan({omega}x)}}{{{omega}}}$",
            f"$u_2' = \\frac{{\\cos({omega}x)\\sec({omega}x)}}{{{omega}}} = \\frac{{1}}{{{omega}}}$",
            f"Integrate: $u_1 = \\frac{{\\ln|\\cos({omega}x)|}}{{{omega**2}}}$, $u_2 = \\frac{{x}}{{{omega}}}$",
            f"$y_p = {latex(y_p)}$"
        )

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1540, 1600),
            topic="differential_equations/variation_of_parameters",
            solution=solution,
            calculator="scientific"
        )


emit(generate())
