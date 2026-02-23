"""
calculus - u_substitution (hard)
Generated: 2026-02-22T05:13:01.416242
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # ∫ trig^n(ax+b) * trig'(ax+b) dx  with power n in {2..4}
        a = nonzero(-4, 4)
        b = randint(-5, 5)
        n = randint(2, 4)
        trig_choice = choice(['sin', 'cos'])
        inner = a * x + b

        if trig_choice == 'sin':
            integrand = sin(inner)**n * cos(inner) * a
            ans = sin(inner)**(n + 1) / (n + 1)
            u_str = f"\\sin({latex(inner)})"
        else:
            integrand = cos(inner)**n * sin(inner) * (-a)
            ans = cos(inner)**(n + 1) / (n + 1)
            u_str = f"\\cos({latex(inner)})"

        integrand = expand(integrand)
        ans_check = simplify(integrate(integrand, x))

        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans_check,
            difficulty=(1600, 1750),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {u_str}$, then $du = \\pm {abs(a)} \\cdot \\text{{trig}}({latex(inner)}) dx$",
                f"The integral becomes $\\int u^{{{n}}} \\, du$",
                f"$= \\frac{{u^{{{n+1}}}}}{{{n+1}}} + C$",
                f"Substitute back: ${latex(ans_check)} + C$"
            ),
            calculator="none"
        )

    elif problem_type == 2:
        # ∫ k * exp(ax² + bx) * (2ax + b) dx  — u = ax²+bx
        a = nonzero(-3, 3)
        b = randint(-5, 5)
        k = nonzero(-3, 3)
        inner = a * x**2 + b * x

        integrand = k * exp(inner) * diff(inner, x)
        ans = k * exp(inner)

        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(inner)}$, then $du = {latex(diff(inner, x))} dx$",
                f"The integral becomes $\\int {k} e^u \\, du = {k} e^u + C$",
                f"Substitute back: ${latex(ans)} + C$"
            ),
            calculator="none"
        )

    elif problem_type == 3:
        # ∫ k / (ax² + b) dx  using the arctan form: (k/a) * arctan(x/√(b/a))
        # For simplicity use b=a so √(b/a)=1: ∫ k/(a(x²+1)) = (k/a)*arctan(x) + C
        # More general: let b divisible nicely
        a = randint(1, 5)
        k = nonzero(-4, 4)

        # ∫ k / (a + x²) dx  = (k/√a) arctan(x/√a) when a is perfect square
        a_sq = choice([1, 4, 9, 16])

        integrand = k / (a_sq + x**2)
        ans = k * atan(x / sqrt(a_sq)) / sqrt(a_sq)

        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/u_substitution",
            solution=steps(
                f"Recall $\\int \\frac{{1}}{{a^2 + x^2}} dx = \\frac{{1}}{{a}} \\arctan\\left(\\frac{{x}}{{a}}\\right) + C$",
                f"Here $a^2 = {a_sq}$, so $a = {int(a_sq**0.5)}$",
                f"$= \\frac{{{k}}}{{{int(a_sq**0.5)}}} \\arctan\\left(\\frac{{x}}{{{int(a_sq**0.5)}}}\\right) + C$",
                f"$= {latex(ans)} + C$"
            ),
            calculator="none"
        )

    elif problem_type == 4:
        # ∫ x^(m-1) * f(ax^m + b)  →  u = ax^m + b
        m = randint(2, 4)
        a = randint(1, 5)
        b = randint(-5, 5)
        inner = a * x**m + b

        func_type = choice(['sin', 'cos', 'exp'])

        if func_type == 'sin':
            integrand = x**(m - 1) * sin(inner)
            # du = m*a*x^(m-1) dx  →  integral = -cos(u)/(m*a)
            ans = -cos(inner) / (m * a)
        elif func_type == 'cos':
            integrand = x**(m - 1) * cos(inner)
            ans = sin(inner) / (m * a)
        else:
            integrand = x**(m - 1) * exp(inner)
            ans = exp(inner) / (m * a)

        ans_check = simplify(integrate(integrand, x))

        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans_check,
            difficulty=(1750, 1900),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(inner)}$, then $du = {latex(diff(inner, x))} dx$",
                f"Notice $x^{{{m-1}}} dx = \\frac{{1}}{{{m*a}}} du$",
                f"The integral becomes $\\frac{{1}}{{{m*a}}} \\int {func_type}(u) \\, du$",
                f"$= {latex(ans)} + C$"
            ),
            calculator="none"
        )

    else:
        # ∫ (ax+b)^n dx with large n in {5..9}  — power rule after substitution
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        n = randint(5, 9)

        inner = a * x + b
        integrand = inner**n * a
        ans = inner**(n + 1) / (n + 1)

        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(inner)}$, then $du = {a} dx$",
                f"The integral becomes $\\int u^{{{n}}} \\, du$",
                f"$= \\frac{{u^{{{n+1}}}}}{{{n+1}}} + C$",
                f"Substitute back: ${latex(ans)} + C$"
            ),
            calculator="none"
        )

emit(generate())
