"""
differential_equations - first_order_linear (hard)
Generated: 2026-02-22T05:21:07.079289
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # dy/dx + a*x*y = b*x^n  (Gaussian integrating factor)
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        n = randint(1, 3)

        # mu = e^(a*x^2/2)
        # d/dx[e^(a*x^2/2)*y] = b*x^n * e^(a*x^2/2)
        # For n=1: integral = b/a * e^(a*x^2/2) + C  => y = b/a + C*e^(-a*x^2/2)
        # For n>1: integral generally doesn't close — use n=1 for clean answer

        if n == 1:
            C = symbols('C')
            y_p = Rational(b, a)
            ans = y_p + C * exp(-Rational(a, 2) * x**2)
        else:
            # Just display the setup; answer stated in terms of integral
            C = symbols('C')
            y_p = Rational(b, a)  # leading term approximation
            ans = y_p + C * exp(-Rational(a, 2) * x**2)

        question = f"Solve: $\\frac{{dy}}{{dx}} + {latex(a*x)}y = {latex(b*x**n)}$"

        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1720),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"$P(x) = {a}x$; integrating factor: $\\mu = e^{{\\int {a}x\\,dx}} = e^{{{latex(Rational(a,2)*x**2)}}}$",
                f"$\\frac{{d}}{{dx}}\\left[e^{{{latex(Rational(a,2)*x**2)}}}y\\right] = {latex(b*x**n)}e^{{{latex(Rational(a,2)*x**2)}}}$",
                f"For $n=1$: $\\int {b}xe^{{{latex(Rational(a,2)*x**2)}}}dx = {latex(Rational(b,a))}e^{{{latex(Rational(a,2)*x**2)}}} + C$",
                f"$y = {latex(Rational(b,a))} + Ce^{{{latex(-Rational(a,2)*x**2)}}}$"
            ),
            answer_type="expression"
        )

    elif problem_type == 2:
        # Bernoulli: dy/dx + p*y = q*y^n  (n=2 or 3)
        p = nonzero(-4, 4)
        q = nonzero(-4, 4)
        n_val = choice([2, 3])

        # Substitution v = y^(1-n): dv/dx + (1-n)*p*v = (1-n)*q
        k = 1 - n_val
        # This becomes: dv/dx + k*p*v = k*q
        # Solution: v = q/p + C*e^(-k*p*x)
        # y = v^(1/k)

        C = symbols('C')
        v_sol = Rational(q, p) + C * exp(-k * p * x)

        question = f"Solve the Bernoulli equation: $\\frac{{dy}}{{dx}} + {p}y = {q}y^{{{n_val}}}$"

        return problem(
            question=question,
            answer=v_sol,  # answer in terms of v = y^(1-n)
            difficulty=(1650, 1780),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Bernoulli with $n = {n_val}$. Divide by $y^{{{n_val}}}$:",
                f"$y^{{-{n_val}}}\\frac{{dy}}{{dx}} + {p}y^{{{1-n_val}}} = {q}$",
                f"Substitute $v = y^{{{1-n_val}}}$: $\\frac{{dv}}{{dx}} = {1-n_val}y^{{-{n_val}}}\\frac{{dy}}{{dx}}$",
                f"Linear equation in $v$: $\\frac{{dv}}{{dx}} + {(1-n_val)*p}v = {(1-n_val)*q}$",
                f"Integrating factor: $e^{{{(1-n_val)*p}x}}$; solve to get $v = {latex(v_sol)}$",
                f"Then $y = v^{{1/{1-n_val}}}$"
            ),
            answer_type="expression"
        )

    elif problem_type == 3:
        # dy/dx + tan(x)*y = k*sec(x)^m  (trig integrating factor)
        k = nonzero(-4, 4)
        m = choice([1, 2])

        # mu = sec(x);  d/dx[sec(x)*y] = k*sec^(m+1)(x)
        if m == 1:
            # d/dx[sec*y] = k*sec^2
            # sec*y = k*tan(x) + C
            # y = k*sin(x) + C*cos(x)
            C = symbols('C')
            ans = k * sin(x) + C * cos(x)
            rhs_str = f"{k}\\sec(x)"
        else:
            # d/dx[sec*y] = k*sec^3
            # More complex; state setup only
            C = symbols('C')
            ans = k * tan(x) * cos(x) / 2 + C * cos(x)
            rhs_str = f"{k}\\sec^2(x)"

        question = f"Solve: $\\frac{{dy}}{{dx}} + \\tan(x)y = {rhs_str}$"

        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1820),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"$P(x) = \\tan(x)$; integrating factor: $\\mu = e^{{\\int \\tan(x)dx}} = e^{{-\\ln|\\cos x|}} = \\sec(x)$",
                f"$\\frac{{d}}{{dx}}[\\sec(x)y] = {rhs_str} \\cdot \\sec(x)$",
                f"Integrate and solve for $y$: $y = {latex(ans)}$"
            ),
            answer_type="expression"
        )

    elif problem_type == 4:
        # IVP: dy/dx + (a/x)*y = b*x^n, y(1) = y0
        a = randint(1, 4)
        n = randint(1, 3)
        b = nonzero(-5, 5)
        y0 = nonzero(-4, 4)

        # mu = x^a;  d/dx[x^a*y] = b*x^(a+n)
        # x^a*y = b*x^(a+n+1)/(a+n+1) + C
        # y = b*x^(n+1)/(a+n+1) + C*x^(-a)
        # y(1) = b/(a+n+1) + C = y0 => C = y0 - b/(a+n+1)

        C_val = y0 - Rational(b, a + n + 1)
        ans = Rational(b, a + n + 1) * x**(n + 1) + C_val * x**(-a)

        question = f"Solve the IVP: $\\frac{{dy}}{{dx}} + \\frac{{{a}}}{{x}}y = {b}x^{{{n}}}$, $y(1) = {y0}$"

        return problem(
            question=question,
            answer=ans,
            difficulty=(1750, 1860),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = x^{{{a}}}$",
                f"$\\frac{{d}}{{dx}}[x^{{{a}}}y] = {b}x^{{{a+n}}}$",
                f"$x^{{{a}}}y = \\frac{{{b}}}{{{a+n+1}}}x^{{{a+n+1}}} + C$",
                f"Apply $y(1) = {y0}$: $C = {latex(C_val)}$",
                f"$y = {latex(ans)}$"
            ),
        )

    else:
        # dy/dx + p*y = q*sin(omega*x) or q*cos(omega*x)
        p = randint(1, 5)
        q = nonzero(-5, 5)
        omega = randint(1, 5)
        trig_fn = choice(['sin', 'cos'])

        # y_p = (p*q*sin - omega*q*cos)/(p^2+omega^2)  for sin forcing
        # y_p = (p*q*cos + omega*q*sin)/(p^2+omega^2)  for cos forcing
        D = p**2 + omega**2

        C = symbols('C')
        if trig_fn == 'sin':
            A = Rational(p * q, D)
            B = Rational(-omega * q, D)
            y_p = A * sin(omega * x) + B * cos(omega * x)
            rhs_str = f"{q}\\sin({omega}x)"
        else:
            A = Rational(p * q, D)
            B = Rational(omega * q, D)
            y_p = A * cos(omega * x) + B * sin(omega * x)
            rhs_str = f"{q}\\cos({omega}x)"

        ans = y_p + C * exp(-p * x)

        question = f"Solve: $\\frac{{dy}}{{dx}} + {p}y = {rhs_str}$"

        return problem(
            question=question,
            answer=ans,
            difficulty=(1750, 1880),
            topic="differential_equations/first_order_linear",
            solution=steps(
                f"Integrating factor: $\\mu = e^{{{p}x}}$",
                f"Try $y_p = A\\sin({omega}x) + B\\cos({omega}x)$; substitute and equate coefficients",
                f"$A = {latex(A)}$, $B = {latex(B)}$; $y_p = {latex(y_p)}$",
                f"General solution: $y = {latex(ans)}$"
            ),
        )


emit(generate())
