"""
differential_equations - first_order_linear (medium)
Generated: 2026-02-22T05:20:21.432875
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # dy/dx + p*y = q with p,q constants (wider ranges)
        p = nonzero(-6, 6)
        q = nonzero(-10, 10)

        C = symbols('C')
        ans = Rational(q, p) + C * exp(-p * x)

        return problem(
            question=f"Solve: $\\frac{{dy}}{{dx}} + {p}y = {q}$",
            answer=ans,
            difficulty=(1300, 1420),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = e^{{{p}x}}$",
                f"$\\frac{{d}}{{dx}}[e^{{{p}x}}y] = {q}e^{{{p}x}}$",
                f"Integrate: $e^{{{p}x}}y = {latex(Rational(q,p))}e^{{{p}x}} + C$",
                f"$y = {latex(Rational(q,p))} + Ce^{{{-p}x}}$"
            ),
        )

    elif problem_type == 2:
        # IVP: dy/dx + p*y = q, y(0) = y0
        p = choice([1, 2, 3, 4, 5])
        q = nonzero(-8, 8)
        y0 = nonzero(-6, 6)

        C_val = y0 - Rational(q, p)
        ans = Rational(q, p) + C_val * exp(-p * x)

        return problem(
            question=f"Solve the IVP: $\\frac{{dy}}{{dx}} + {p}y = {q}$, $y(0) = {y0}$",
            answer=ans,
            difficulty=(1400, 1520),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"General solution: $y = {latex(Rational(q,p))} + Ce^{{{-p}x}}$",
                f"Apply $y(0) = {y0}$: ${y0} = {latex(Rational(q,p))} + C$",
                f"$C = {latex(C_val)}$",
                f"$y = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # dy/dx + (a/x)*y = Q(x)  (Cauchy-Euler type)
        a = nonzero(-4, 4)
        n = randint(1, 4)  # Q(x) = x^n

        # mu = x^a (when a>0) or x^a (when a<0)
        # d/dx[x^a * y] = x^(a+n)
        # x^a * y = x^(a+n+1)/(a+n+1) + C
        # y = x^(n+1)/(a+n+1) + C*x^(-a)

        if a + n + 1 != 0:
            C = symbols('C')
            ans = x**(n + 1) / (a + n + 1) + C * x**(-a)

            return problem(
                question=f"Solve: $\\frac{{dy}}{{dx}} + \\frac{{{a}}}{{x}}y = x^{{{n}}}$ for $x > 0$",
                answer=ans,
                difficulty=(1430, 1550),
                topic="differential_equations/first_order_linear",
                solution=steps(
                    f"$P(x) = {a}/x$, integrating factor: $\\mu = e^{{\\int ({a}/x)dx}} = x^{{{a}}}$",
                    f"$\\frac{{d}}{{dx}}[x^{{{a}}}y] = x^{{{a+n}}}$",
                    f"Integrate: $x^{{{a}}}y = \\frac{{x^{{{a+n+1}}}}}{{{a+n+1}}} + C$",
                    f"$y = \\frac{{x^{{{n+1}}}}}{{{a+n+1}}} + Cx^{{{-a}}}$"
                ),
            )

    if problem_type == 4:
        # dy/dx + p*y = q + r*x  (linear + constant forcing)
        p = nonzero(-5, 5)
        q = nonzero(-6, 6)
        r = nonzero(-5, 5)

        # y_p = (r*x + (q*p - r))/p^2
        # Verify: y_p' + p*y_p = r*x + q
        y_p = Rational(r, p) * x + Rational(q * p - r, p**2)

        C = symbols('C')
        ans = y_p + C * exp(-p * x)

        return problem(
            question=f"Solve: $\\frac{{dy}}{{dx}} + {p}y = {latex(q + r*x)}$",
            answer=ans,
            difficulty=(1470, 1580),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = e^{{{p}x}}$",
                f"$\\frac{{d}}{{dx}}[e^{{{p}x}}y] = ({latex(q + r*x)})e^{{{p}x}}$",
                f"Integrate by parts; particular solution: $y_p = {latex(y_p)}$",
                f"General solution: $y = {latex(ans)}$"
            ),
        )

    else:
        # dy/dx + p*y = q*e^(a*x)  (exponential forcing, a != -p)
        p = nonzero(-5, 5)
        q = nonzero(-6, 6)
        a = nonzero(-4, 4)
        while a == -p:
            a = nonzero(-4, 4)

        C = symbols('C')
        y_p = Rational(q, p + a) * exp(a * x)
        ans = y_p + C * exp(-p * x)

        return problem(
            question=f"Solve: $\\frac{{dy}}{{dx}} + {p}y = {q}e^{{{a}x}}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = e^{{{p}x}}$",
                f"$\\frac{{d}}{{dx}}[e^{{{p}x}}y] = {q}e^{{{p+a}x}}$",
                f"Integrate: $e^{{{p}x}}y = \\frac{{{q}}}{{{p+a}}}e^{{{p+a}x}} + C$",
                f"$y = {latex(y_p)} + Ce^{{{-p}x}}$"
            ),
        )


emit(generate())
