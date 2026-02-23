"""
differential_equations - variation_of_parameters (hard)
Generated: 2026-02-22T05:29:53.828633
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # y'' + omega^2*y = sec(omega*x) or tan(omega*x)
        omega = randint(1, 5)
        rhs_type = choice(['sec', 'tan'])

        y1 = cos(omega * x)
        y2 = sin(omega * x)
        # W = omega

        if rhs_type == 'sec':
            g_str = f"\\sec({omega}x)"
            # u1 = integral(-sin(omega*x)*sec(omega*x)/omega) = ln|cos(omega*x)|/omega^2
            # u2 = integral(cos(omega*x)*sec(omega*x)/omega) = x/omega
            y_p = cos(omega * x) * log(cos(omega * x)) / omega**2 + x * sin(omega * x) / omega
        else:
            g_str = f"\\tan({omega}x)"
            # u1 = -integral(sin^2(omega*x)/(omega*cos(omega*x))) — leads to ln|cos|/omega^2
            # u2 = integral(cos(omega*x)*tan(omega*x)/omega) = -cos(omega*x)/omega^2
            y_p = -cos(omega * x) * log(cos(omega * x)) / omega**2

        question = f"Use variation of parameters to find a particular solution to $y'' + {omega**2}y = {g_str}$"

        solution_steps = [
            f"Homogeneous solutions: $y_1 = \\cos({omega}x)$, $y_2 = \\sin({omega}x)$",
            f"Wronskian: $W = {omega}$",
            f"$u_1 = -\\int \\frac{{y_2 \\cdot {g_str}}}{{W}} dx$, $u_2 = \\int \\frac{{y_1 \\cdot {g_str}}}{{W}} dx$",
            f"After integration: $y_p = {latex(y_p)}$"
        ]

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1650, 1800),
            topic="differential_equations/variation_of_parameters",
            solution=steps(*solution_steps),
            calculator="cas"
        )

    elif problem_type == 2:
        # y'' - (r1+r2)*y' + r1*r2*y = k*e^(a*x) with a != r1, r2
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        k = nonzero(-4, 4)
        a_val = nonzero(-4, 4)
        while a_val == r1 or a_val == r2:
            a_val = nonzero(-4, 4)

        y1 = exp(r1 * x)
        y2 = exp(r2 * x)
        g = k * exp(a_val * x)

        W = simplify(y1 * diff(y2, x) - y2 * diff(y1, x))
        u1_prime = simplify(-y2 * g / W)
        u2_prime = simplify(y1 * g / W)
        u1 = integrate(u1_prime, x)
        u2 = integrate(u2_prime, x)
        y_p = simplify(u1 * y1 + u2 * y2)

        b_val = -(r1 + r2)
        c_val = r1 * r2
        b_sign = f"{b_val:+d}"
        c_sign = f"{c_val:+d}"

        question = (f"Use variation of parameters to find a particular solution for "
                    f"$y'' {b_sign}y' {c_sign}y = {latex(g)}$")

        solution_steps = [
            f"$y_1 = e^{{{r1}x}}$, $y_2 = e^{{{r2}x}}$, $W = {latex(W)}$",
            f"$u_1' = {latex(u1_prime)}$, integrate to get $u_1 = {latex(u1)}$",
            f"$u_2' = {latex(u2_prime)}$, integrate to get $u_2 = {latex(u2)}$",
            f"$y_p = {latex(y_p)}$"
        ]

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1700, 1820),
            topic="differential_equations/variation_of_parameters",
            solution=steps(*solution_steps),
            calculator="cas"
        )

    elif problem_type == 3:
        # y'' + omega^2*y = csc(omega*x)
        omega = randint(1, 4)

        y1 = cos(omega * x)
        y2 = sin(omega * x)
        # W = omega
        # u1' = -sin(omega*x)*csc(omega*x)/omega = -1/omega
        # u2' = cos(omega*x)*csc(omega*x)/omega = cot(omega*x)/omega
        # u1 = -x/omega
        # u2 = ln|sin(omega*x)|/omega^2
        y_p = -x * cos(omega * x) / omega + sin(omega * x) * log(Abs(sin(omega * x))) / omega**2

        question = f"Use variation of parameters to find a particular solution to $y'' + {omega**2}y = \\csc({omega}x)$"

        solution_steps = [
            f"$y_1 = \\cos({omega}x)$, $y_2 = \\sin({omega}x)$, $W = {omega}$",
            f"$u_1' = -\\frac{{1}}{{{omega}}}$, so $u_1 = -\\frac{{x}}{{{omega}}}$",
            f"$u_2' = \\frac{{\\cot({omega}x)}}{{{omega}}}$, so $u_2 = \\frac{{\\ln|\\sin({omega}x)|}}{{{omega**2}}}$",
            f"$y_p = u_1 y_1 + u_2 y_2 = {latex(y_p)}$"
        ]

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1700, 1850),
            topic="differential_equations/variation_of_parameters",
            solution=steps(*solution_steps),
            calculator="cas"
        )

    else:
        # y'' - 2*r*y' + r^2*y = f(x)/x  (repeated root r)
        r_val = nonzero(-3, 3)
        k = nonzero(-4, 4)

        # y1 = e^(r*x), y2 = x*e^(r*x), W = e^(2*r*x)
        # g = k*e^(r*x)/x
        # u1' = -x*e^(r*x)*k*e^(r*x)/x / e^(2*r*x) = -k
        # u2' = e^(r*x)*k*e^(r*x)/x / e^(2*r*x) = k/x
        # u1 = -k*x
        # u2 = k*ln|x|
        y_p = simplify(-k * x * exp(r_val * x) + k * x * exp(r_val * x) * log(Abs(x)))

        g_str = f"\\frac{{{k}e^{{{r_val}x}}}}{{x}}"

        b_val = -2 * r_val
        c_val = r_val**2
        b_sign = f"{b_val:+d}"
        c_sign = f"{c_val:+d}"

        question = (f"Use variation of parameters to find a particular solution to "
                    f"$y'' {b_sign}y' {c_sign}y = {g_str}$")

        solution_steps = [
            f"Characteristic equation: $(r - {r_val})^2 = 0$, repeated root",
            f"$y_1 = e^{{{r_val}x}}$, $y_2 = xe^{{{r_val}x}}$, $W = e^{{{2 * r_val}x}}$",
            f"$u_1' = -\\frac{{xe^{{{r_val}x}} \\cdot {k}e^{{{r_val}x}}/x}}{{e^{{{2 * r_val}x}}}} = -{k}$",
            f"$u_2' = \\frac{{e^{{{r_val}x}} \\cdot {k}e^{{{r_val}x}}/x}}{{e^{{{2 * r_val}x}}}} = \\frac{{{k}}}{{x}}$",
            f"$u_1 = -{k}x$, $u_2 = {k}\\ln|x|$",
            f"$y_p = {latex(y_p)}$"
        ]

        return problem(
            question=question,
            answer=y_p,
            difficulty=(1750, 1920),
            topic="differential_equations/variation_of_parameters",
            solution=steps(*solution_steps),
            calculator="cas"
        )


emit(generate())
