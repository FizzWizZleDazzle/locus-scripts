"""
calculus - u_substitution (medium)
Generated: 2026-02-22T05:12:41.869760
"""

from problem_utils import *

def generate():
    problem_type = choice(['polynomial_composed', 'trig_linear', 'exponential', 'rational_power', 'trig_power'])

    if problem_type == 'polynomial_composed':
        # ∫ a*(ax+b)^n dx  — u = ax+b, du = a dx, so integral = (ax+b)^(n+1)/(n+1)
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        n = randint(2, 6)

        integrand = a * (a * x + b)**n
        ans = (a * x + b)**(n + 1) / (n + 1)

        diff_rating = (1300, 1450) if n <= 3 else (1400, 1550)

        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=diff_rating,
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {a} \\, dx$",
                f"The integral becomes: $\\int u^{{{n}}} \\, du = \\frac{{u^{{{n+1}}}}}{{{n+1}}} + C$",
                f"Substituting back: ${latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 'trig_linear':
        # ∫ k * sin(ax+b) dx  or  ∫ k * cos(ax+b) dx
        a = nonzero(-5, 5)
        b = randint(-6, 6)
        k = nonzero(-4, 4)
        trig_func = choice([sin, cos])

        integrand = k * trig_func(a * x + b)

        if trig_func == sin:
            ans = -k * cos(a * x + b) / a
            integral_result = f"-\\frac{{{k}}}{{{a}}}\\cos({latex(a*x+b)})"
        else:
            ans = k * sin(a * x + b) / a
            integral_result = f"\\frac{{{k}}}{{{a}}}\\sin({latex(a*x+b)})"

        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=(1350, 1500),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {a} \\, dx$, so $dx = \\frac{{1}}{{{a}}} du$",
                f"$= \\frac{{{k}}}{{{a}}} \\int {trig_func.__name__}(u) \\, du$",
                f"$= {integral_result} + C$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 'exponential':
        # ∫ k * e^(ax+b) dx
        a = nonzero(-4, 4)
        b = randint(-6, 6)
        k = nonzero(-5, 5)

        integrand = k * exp(a * x + b)
        ans = k * exp(a * x + b) / a

        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {a} \\, dx$",
                f"$= \\frac{{{k}}}{{{a}}} \\int e^u \\, du = \\frac{{{k}}}{{{a}}} e^u + C$",
                f"Substituting back: ${latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )

    elif problem_type == 'rational_power':
        # ∫ k / (ax + b) dx  →  (k/a) * ln|ax+b|
        a = nonzero(-5, 5)
        b = randint(-6, 6)
        k = nonzero(-5, 5)

        integrand = k / (a * x + b)
        ans = log(Abs(a * x + b)) * Rational(k, a)

        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=(1450, 1600),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {a} \\, dx$",
                f"$= \\frac{{{k}}}{{{a}}} \\int \\frac{{1}}{{u}} \\, du = \\frac{{{k}}}{{{a}}} \\ln|u| + C$",
                f"$= {latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )

    else:  # trig_power
        # ∫ sin^n(ax)*cos(ax) dx  or  ∫ cos^n(ax)*sin(ax) dx
        # u = sin(ax) or cos(ax)
        a = nonzero(-4, 4)
        n = randint(2, 5)
        choice_trig = choice(['sin_power', 'cos_power'])

        if choice_trig == 'sin_power':
            integrand = sin(a * x)**n * cos(a * x)
            ans = sin(a * x)**(n + 1) / (a * (n + 1))
            u_str = f"\\sin({a}x)"
        else:
            integrand = cos(a * x)**n * sin(a * x)
            ans = -cos(a * x)**(n + 1) / (a * (n + 1))
            u_str = f"\\cos({a}x)"

        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=(1400, 1550),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {u_str}$",
                f"Then $du = \\pm {abs(a)} \\cos({a}x)\\,dx$ (or $\\sin$ term)",
                f"The integral becomes $\\pm \\frac{{1}}{{{a}}} \\int u^{{{n}}} \\, du$",
                f"$= \\frac{{u^{{{n+1}}}}}{{{a}({n+1})}} + C$",
                f"$= {latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )

emit(generate())
