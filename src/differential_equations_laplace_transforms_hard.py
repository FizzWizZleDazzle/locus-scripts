"""
differential_equations - laplace_transforms (hard)
Generated: 2026-02-22T05:31:47.642846
"""

from problem_utils import *
s = symbols('s')

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Inverse Laplace via partial fractions: (A*s + B)/((s-a)(s+b))
        a = randint(2, 6)
        b = randint(1, 5)
        A = nonzero(-4, 4)
        B = randint(1, 8)

        # (As + B) = C1*(s+b) + C2*(s-a)
        # At s=a: C1 = (A*a + B)/(a+b)
        # At s=-b: C2 = (-A*b + B)/(-(b+a)) = (A*b - B)/(b+a)
        C1 = Rational(A * a + B, a + b)
        C2 = Rational(A * (-b) + B, -(b + a))

        ans = C1 * exp(a * t) + C2 * exp(-b * t)
        B_str = f"+ {B}" if B >= 0 else str(B)
        numerator_latex = f"{A}s {B_str}"

        return problem(
            question=f"Find the inverse Laplace transform: $\\mathcal{{L}}^{{-1}}\\left[\\frac{{{numerator_latex}}}{{(s - {a})(s + {b})}}\\right]$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Partial fractions: $\\frac{{{numerator_latex}}}{{(s-{a})(s+{b})}} = \\frac{{C_1}}{{s-{a}}} + \\frac{{C_2}}{{s+{b}}}$",
                f"At $s = {a}$: $C_1 = \\frac{{{A * a + B}}}{{{a + b}}} = {latex(C1)}$",
                f"At $s = -{b}$: $C_2 = \\frac{{{A*(-b) + B}}}{{{-(b+a)}}} = {latex(C2)}$",
                f"$\\mathcal{{L}}^{{-1}}\\left[\\frac{{{latex(C1)}}}{{s-{a}}} + \\frac{{{latex(C2)}}}{{s+{b}}}\\right] = {latex(C1)}e^{{{a}t}} + {latex(C2)}e^{{-{b}t}}$"
            ),
        )

    elif problem_type == 2:
        # Frequency differentiation: L[t^n * sin(omega*t)] or L[t^n * cos(omega*t)]
        n_val = randint(1, 3)
        omega = randint(2, 7)
        trig_choice = choice(['sin', 'cos'])

        s_sym = symbols('s')
        if trig_choice == 'sin':
            F_s = omega / (s_sym**2 + omega**2)
        else:
            F_s = s_sym / (s_sym**2 + omega**2)

        # L[t^n f(t)] = (-1)^n * d^n F(s)/ds^n
        result = F_s
        for _ in range(n_val):
            result = -diff(result, s_sym)
        ans = simplify(result)

        trig_latex = f"\\sin({omega}t)" if trig_choice == 'sin' else f"\\cos({omega}t)"
        base_latex = f"\\frac{{{omega}}}{{s^2 + {omega**2}}}" if trig_choice == 'sin' else f"\\frac{{s}}{{s^2 + {omega**2}}}"

        return problem(
            question=f"Find the Laplace transform: $\\mathcal{{L}}[t^{{{n_val}}} {trig_latex}]$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Use frequency differentiation: $\\mathcal{{L}}[t^n f(t)] = (-1)^n \\frac{{d^n}}{{ds^n}}F(s)$",
                f"$\\mathcal{{L}}[{trig_latex}] = {base_latex}$",
                f"Differentiate {n_val} time(s) and multiply by $(-1)^{{{n_val}}}$",
                f"$\\mathcal{{L}}[t^{{{n_val}}} {trig_latex}] = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Convolution theorem: L^-1[1/((s-a)(s+b))]
        a = randint(2, 5)
        b = randint(2, 5)

        # (e^(at) * e^(-bt))(t) = integral from 0 to t of e^(a*tau)*e^(-b(t-tau)) d_tau
        # = (e^(at) - e^(-bt))/(a+b)
        ans = (exp(a * t) - exp(-b * t)) / (a + b)

        return problem(
            question=f"Use the convolution theorem to find: $\\mathcal{{L}}^{{-1}}\\left[\\frac{{1}}{{(s-{a})(s+{b})}}\\right]$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Write as product: $\\frac{{1}}{{s-{a}}} \\cdot \\frac{{1}}{{s+{b}}}$",
                f"By convolution: $f(t) = e^{{{a}t}}$, $g(t) = e^{{-{b}t}}$",
                f"$(f * g)(t) = \\int_0^t e^{{{a}\\tau}} e^{{-{b}(t-\\tau)}} d\\tau = e^{{-{b}t}} \\int_0^t e^{{({a}+{b})\\tau}} d\\tau$",
                f"$= e^{{-{b}t}} \\cdot \\frac{{e^{{({a}+{b})t}} - 1}}{{{a+b}}} = \\frac{{e^{{{a}t}} - e^{{-{b}t}}}}{{{a+b}}}$"
            ),
        )

    elif problem_type == 4:
        # Solve IVP with Laplace: y'' + p*y' + q*y = 0 with given IC, read off answer
        # Choose roots to give clean form
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)

        b_coef = -(r1 + r2)
        c_coef = r1 * r2
        y0 = nonzero(-3, 3)
        yp0 = nonzero(-3, 3)

        # Y(s)*(s^2 + b*s + c) = y0*s + (yp0 + b*y0)
        # Y(s) = (y0*s + yp0 + b_coef*y0) / ((s-r1)(s-r2))
        num_const = yp0 + b_coef * y0
        # Partial fractions: y0*s + num_const = A/(s-r1) + B/(s-r2)
        # A*(s-r2) + B*(s-r1) = y0*s + num_const
        # A = (y0*r1 + num_const)/(r1-r2)
        # B = (y0*r2 + num_const)/(r2-r1)
        if r1 != r2:
            A_val = Rational(y0 * r1 + num_const, r1 - r2)
            B_val = Rational(y0 * r2 + num_const, r2 - r1)
            ans = A_val * exp(r1 * t) + B_val * exp(r2 * t)
        else:
            ans = y0 * exp(r1 * t) + (yp0 - r1 * y0) * t * exp(r1 * t)

        b_sign = f"{b_coef:+d}"
        c_sign = f"{c_coef:+d}"

        return problem(
            question=f"Solve the IVP using Laplace transforms: $y'' {b_sign}y' {c_sign}y = 0$, $y(0) = {y0}$, $y'(0) = {yp0}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Take Laplace: $(s^2 Y - {y0}s - {yp0}) {b_sign}(sY - {y0}) {c_sign}Y = 0$",
                f"$(s^2 {b_sign}s {c_sign})Y = {y0}s + {yp0 + b_coef * y0}$",
                f"$Y(s) = \\frac{{{y0}s + {yp0 + b_coef * y0}}}{{(s - {r1})(s - {r2})}}$",
                f"Partial fractions and inverse Laplace: $y(t) = {latex(ans)}$"
            ),
        )

    else:
        # L^-1 of rational with repeated factor: k!/(s-a)^(k+1)  given as sum
        a = nonzero(-4, 4)
        n1 = randint(1, 3)
        n2 = randint(1, 3)
        A = nonzero(-3, 3)
        B = nonzero(-3, 3)

        fact1 = factorial(n1)
        fact2 = factorial(n2)
        F_s = A * fact1 / (s - a)**(n1 + 1) + B * fact2 / (s - a)**(n2 + 1)
        ans = (A * t**n1 + B * t**n2) * exp(a * t)

        return problem(
            question=f"Find the inverse Laplace transform of $F(s) = {latex(F_s)}$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="differential_equations/laplace_transforms",
            solution=steps(
                f"Apply inverse Laplace term by term",
                f"$\\mathcal{{L}}^{{-1}}\\left[\\frac{{{A * fact1}}}{{(s-{a})^{{{n1+1}}}}}\\right] = {A}t^{{{n1}}}e^{{{a}t}}$",
                f"$\\mathcal{{L}}^{{-1}}\\left[\\frac{{{B * fact2}}}{{(s-{a})^{{{n2+1}}}}}\\right] = {B}t^{{{n2}}}e^{{{a}t}}$",
                f"$f(t) = {latex(ans)}$"
            ),
        )


emit(generate())
