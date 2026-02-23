"""
differential_equations - exact_equations (hard)
Generated: 2026-02-22T05:22:36.394900
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # F = a*x^n*y + b*x*y^m + sin/cos term
        a_coef = nonzero(-4, 4)
        b_coef = nonzero(-4, 4)
        n = randint(2, 4)
        m = randint(2, 4)
        trig_choice = choice(['sin_y', 'cos_y', 'none'])

        if trig_choice == 'sin_y':
            F = a_coef * x**n * y + b_coef * x * y**m + sin(y)
        elif trig_choice == 'cos_y':
            F = a_coef * x**n * y + b_coef * x * y**m + cos(y)
        else:
            F = a_coef * x**n * y + b_coef * x * y**m + x**2

        M = diff(F, x)
        N = diff(F, y)

        ans = simplify(F)
        integral_M = integrate(M, x)
        g_prime = simplify(N - diff(integral_M, y))

        return problem(
            question=f"Solve the exact DE: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$",
            answer=fmt_equation(ans, "C"),
            difficulty=(1600, 1720),
            topic="differential_equations/exact_equations",
            answer_type="equation",
            solution=steps(
                f"$M_y = {latex(diff(M, y))}$, $N_x = {latex(diff(N, x))}$ — equal, exact",
                f"$\\int M\\,dx = {latex(integral_M)} + g(y)$",
                f"$g'(y) = {latex(g_prime)}$, $g(y) = {latex(integrate(g_prime, y))}$",
                f"Solution: ${latex(ans)} = C$"
            )
        )

    elif problem_type == 2:
        # Non-exact -> integrating factor mu(x) = e^(int R dx), R = (M_y - N_x)/N
        for _ in range(30):
            a_coef = nonzero(-3, 3)
            b_coef = nonzero(-3, 3)
            c_coef = nonzero(-3, 3)

            M = a_coef * y + b_coef * x
            N = c_coef * x

            M_y = diff(M, y)
            N_x = diff(N, x)

            if simplify(M_y - N_x) == 0:
                continue

            ratio = simplify((M_y - N_x) / N)
            if y in ratio.free_symbols:
                continue

            mu = exp(integrate(ratio, x))
            M_new = simplify(mu * M)
            N_new = simplify(mu * N)

            dM_new_dy = diff(M_new, y)
            dN_new_dx = diff(N_new, x)
            if simplify(dM_new_dy - dN_new_dx) != 0:
                continue

            F = simplify(integrate(M_new, x) + integrate(N_new - diff(integrate(M_new, x), y), y))

            return problem(
                question=f"Solve: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$ (find an integrating factor if needed)",
                answer=fmt_equation(F, "C"),
                difficulty=(1700, 1820),
                topic="differential_equations/exact_equations",
                answer_type="equation",
                solution=steps(
                    f"$M_y = {latex(M_y)}$, $N_x = {latex(N_x)}$ — not equal",
                    f"$R = (M_y - N_x)/N = {latex(ratio)}$ (function of $x$ only)",
                    f"$\\mu(x) = e^{{\\int {latex(ratio)}dx}} = {latex(mu)}$",
                    f"Multiply through by $\\mu$; new equation is exact",
                    f"Solution: ${latex(F)} = C$"
                )
            )

    if problem_type == 3:
        # F = a*e^x*y + b*x^n*y^m
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        n = randint(2, 4)
        m = randint(2, 4)

        F = a * exp(x) * y + b * x**n * y**m
        M = diff(F, x)
        N = diff(F, y)

        ans = simplify(F)
        integral_M = integrate(M, x)
        g_prime = simplify(N - diff(integral_M, y))

        return problem(
            question=f"Solve the exact DE: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$",
            answer=fmt_equation(ans, "C"),
            difficulty=(1680, 1800),
            topic="differential_equations/exact_equations",
            answer_type="equation",
            solution=steps(
                f"$M_y = {latex(diff(M,y))}$, $N_x = {latex(diff(N,x))}$ — exact",
                f"$\\int M\\,dx = {latex(integral_M)} + g(y)$",
                f"$g'(y) = {latex(g_prime)}$, $g(y) = {latex(integrate(g_prime, y))}$",
                f"${latex(ans)} = C$"
            )
        )

    else:
        # F = a*x^p*y^q + b*ln(x)*y + c*x/y
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        p = choice([2, 3])
        q = choice([2, 3])

        F = a * x**p * y**q + b * log(x) * y + c * x / y
        M = diff(F, x)
        N = diff(F, y)

        ans = simplify(F)
        integral_M = integrate(M, x)
        g_prime = simplify(N - diff(integral_M, y))

        return problem(
            question=f"Solve the exact DE: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$",
            answer=fmt_equation(ans, "C"),
            difficulty=(1780, 1950),
            topic="differential_equations/exact_equations",
            answer_type="equation",
            solution=steps(
                f"$M = {latex(M)}$, $N = {latex(N)}$",
                f"$M_y = {latex(diff(M,y))}$, $N_x = {latex(diff(N,x))}$ — exact",
                f"$\\int M\\,dx = {latex(integral_M)} + g(y)$",
                f"$g'(y) = {latex(g_prime)}$, $g(y) = {latex(integrate(g_prime, y))}$",
                f"${latex(ans)} = C$"
            )
        )


emit(generate())
