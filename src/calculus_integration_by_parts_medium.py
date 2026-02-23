"""
calculus - integration_by_parts (medium)
Generated: 2026-02-22T05:13:46.565867
"""

from problem_utils import *

def generate():
    problem_type = choice(['polynomial_exp', 'polynomial_trig', 'ln_polynomial', 'exp_trig'])

    if problem_type == 'polynomial_exp':
        # ∫ x^n * e^(ax) dx  n in {1,2,3}, a in {±1..±4}
        n = randint(1, 3)
        a = nonzero(-4, 4)

        if n == 1:
            integrand = x * exp(a * x)
            ans = (x / a - Rational(1, a**2)) * exp(a * x)

            sol = steps(
                f"Let $u = x$ and $dv = e^{{{a}x}} dx$",
                f"Then $du = dx$ and $v = \\frac{{1}}{{{a}}}e^{{{a}x}}$",
                f"Using $\\int u\\,dv = uv - \\int v\\,du$:",
                f"$= \\frac{{x}}{{{a}}}e^{{{a}x}} - \\int \\frac{{1}}{{{a}}}e^{{{a}x}} dx$",
                f"$= \\frac{{x}}{{{a}}}e^{{{a}x}} - \\frac{{1}}{{{a**2}}}e^{{{a}x}} + C$",
                f"$= {latex(ans)} + C$"
            )
            diff_range = (1300, 1450)

        elif n == 2:
            integrand = x**2 * exp(a * x)
            ans = (x**2 / a - Rational(2, a**2) * x + Rational(2, a**3)) * exp(a * x)

            sol = steps(
                f"Let $u = x^2$ and $dv = e^{{{a}x}} dx$",
                f"Then $du = 2x\\,dx$ and $v = \\frac{{1}}{{{a}}}e^{{{a}x}}$",
                f"$= \\frac{{x^2}}{{{a}}}e^{{{a}x}} - \\frac{{2}}{{{a}}}\\int x e^{{{a}x}} dx$",
                f"Apply integration by parts again to $\\int x e^{{{a}x}} dx$",
                f"$= \\frac{{x^2}}{{{a}}}e^{{{a}x}} - \\frac{{2}}{{{a}}}\\left(\\frac{{x}}{{{a}}}e^{{{a}x}} - \\frac{{1}}{{{a**2}}}e^{{{a}x}}\\right) + C$",
                f"$= {latex(simplify(ans))} + C$"
            )
            diff_range = (1450, 1600)

        else:  # n == 3
            integrand = x**3 * exp(a * x)
            ans = simplify(integrate(integrand, x))

            sol = steps(
                f"Let $u = x^3$ and $dv = e^{{{a}x}} dx$",
                f"Then $du = 3x^2\\,dx$ and $v = \\frac{{1}}{{{a}}}e^{{{a}x}}$",
                f"$= \\frac{{x^3}}{{{a}}}e^{{{a}x}} - \\frac{{3}}{{{a}}}\\int x^2 e^{{{a}x}} dx$",
                f"Apply integration by parts twice more to $\\int x^2 e^{{{a}x}} dx$",
                f"$= {latex(ans)} + C$"
            )
            diff_range = (1500, 1600)

    elif problem_type == 'polynomial_trig':
        # ∫ x^n * sin(ax) or cos(ax)  n in {1,2}, a in {±1..±4}
        n = randint(1, 2)
        a = nonzero(-4, 4)
        trig_choice = choice(['sin', 'cos'])

        if n == 1:
            if trig_choice == 'sin':
                integrand = x * sin(a * x)
                ans = -x * cos(a * x) / a + sin(a * x) / a**2

                sol = steps(
                    f"Let $u = x$ and $dv = \\sin({a}x) dx$",
                    f"Then $du = dx$ and $v = -\\frac{{1}}{{{a}}}\\cos({a}x)$",
                    f"$= -\\frac{{x}}{{{a}}}\\cos({a}x) + \\frac{{1}}{{{a}}}\\int \\cos({a}x) dx$",
                    f"$= -\\frac{{x}}{{{a}}}\\cos({a}x) + \\frac{{1}}{{{a**2}}}\\sin({a}x) + C$"
                )
            else:
                integrand = x * cos(a * x)
                ans = x * sin(a * x) / a + cos(a * x) / a**2

                sol = steps(
                    f"Let $u = x$ and $dv = \\cos({a}x) dx$",
                    f"Then $du = dx$ and $v = \\frac{{1}}{{{a}}}\\sin({a}x)$",
                    f"$= \\frac{{x}}{{{a}}}\\sin({a}x) - \\frac{{1}}{{{a}}}\\int \\sin({a}x) dx$",
                    f"$= \\frac{{x}}{{{a}}}\\sin({a}x) + \\frac{{1}}{{{a**2}}}\\cos({a}x) + C$"
                )
            diff_range = (1300, 1450)
        else:  # n == 2
            if trig_choice == 'sin':
                integrand = x**2 * sin(a * x)
            else:
                integrand = x**2 * cos(a * x)
            ans = simplify(integrate(integrand, x))

            sol = steps(
                f"Let $u = x^2$ and $dv = \\{trig_choice}({a}x) dx$ — requires two applications of parts",
                f"First application: $u = x^2$, reduce to $\\int x \\cdot$ trig",
                f"Second application: $u = x$, reduce to $\\int$ trig",
                f"$= {latex(ans)} + C$"
            )
            diff_range = (1450, 1600)

    elif problem_type == 'ln_polynomial':
        # ∫ x^n * ln(ax) dx  n in {0,1,2,3}, a in {1..5}
        n = randint(0, 3)
        a = randint(1, 5)

        if n == 0:
            integrand = log(a * x)
            ans = x * log(a * x) - x

            sol = steps(
                f"Let $u = \\ln({a}x)$ and $dv = dx$",
                f"Then $du = \\frac{{1}}{{x}} dx$ and $v = x$",
                f"$= x\\ln({a}x) - \\int 1\\,dx$",
                f"$= x\\ln({a}x) - x + C$"
            )
            diff_range = (1300, 1450)
        else:
            integrand = x**n * log(a * x)
            v_expr = x**(n + 1) / (n + 1)
            ans = v_expr * log(a * x) - integrate(v_expr / x, x)
            ans = simplify(ans)

            sol = steps(
                f"Let $u = \\ln({a}x)$ and $dv = x^{{{n}}}\\,dx$",
                f"Then $du = \\frac{{1}}{{x}} dx$ and $v = \\frac{{x^{{{n+1}}}}}{{{n+1}}}$",
                f"$= \\frac{{x^{{{n+1}}}}}{{{n+1}}}\\ln({a}x) - \\int \\frac{{x^{{{n+1}}}}}{{{n+1}}} \\cdot \\frac{{1}}{{x}} dx$",
                f"$= \\frac{{x^{{{n+1}}}}}{{{n+1}}}\\ln({a}x) - \\frac{{1}}{{{n+1}}}\\int x^{{{n}}} dx$",
                f"$= {latex(ans)} + C$"
            )
            diff_range = (1400, 1550)

    else:  # exp_trig — ∫ e^(ax) * sin(bx) or cos(bx)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        trig_choice = choice(['sin', 'cos'])

        if trig_choice == 'sin':
            integrand = exp(a * x) * sin(b * x)
            # Answer: e^(ax)(a sin(bx) - b cos(bx)) / (a^2 + b^2)
            ans = exp(a * x) * (a * sin(b * x) - b * cos(b * x)) / (a**2 + b**2)

            sol = steps(
                f"Let $I = \\int e^{{{a}x}}\\sin({b}x) dx$",
                f"Let $u = \\sin({b}x)$, $dv = e^{{{a}x}} dx$ → $v = \\frac{{1}}{{{a}}}e^{{{a}x}}$",
                f"$I = \\frac{{1}}{{{a}}}e^{{{a}x}}\\sin({b}x) - \\frac{{{b}}}{{{a}}}\\int e^{{{a}x}}\\cos({b}x) dx$",
                f"Apply parts again to $\\int e^{{{a}x}}\\cos({b}x) dx$",
                f"Solve algebraically: $I(1 + \\frac{{{b**2}}}{{{a**2}}}) = \\ldots$",
                f"$I = {latex(ans)} + C$"
            )
        else:
            integrand = exp(a * x) * cos(b * x)
            ans = exp(a * x) * (a * cos(b * x) + b * sin(b * x)) / (a**2 + b**2)

            sol = steps(
                f"Let $I = \\int e^{{{a}x}}\\cos({b}x) dx$",
                f"Let $u = \\cos({b}x)$, $dv = e^{{{a}x}} dx$ → $v = \\frac{{1}}{{{a}}}e^{{{a}x}}$",
                f"$I = \\frac{{1}}{{{a}}}e^{{{a}x}}\\cos({b}x) + \\frac{{{b}}}{{{a}}}\\int e^{{{a}x}}\\sin({b}x) dx$",
                f"Apply parts again to $\\int e^{{{a}x}}\\sin({b}x) dx$",
                f"Solve algebraically for $I$",
                f"$I = {latex(ans)} + C$"
            )
        diff_range = (1500, 1600)

    return problem(
        question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
        answer=ans,
        difficulty=diff_range,
        topic="calculus/integration_by_parts",
        solution=sol,
        grading_mode="equivalent"
    )

emit(generate())
