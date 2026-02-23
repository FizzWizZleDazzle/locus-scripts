"""
calculus - u_substitution (easy)
Generated: 2026-02-22T05:12:24.203042
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # ∫ (ax + b)^n dx   a in {±1..±5}, b in {-8..8}, n in {2..6}
        a_val = nonzero(-5, 5)
        b_val = randint(-8, 8)
        n_val = randint(2, 6)

        u_expr = a_val * x + b_val
        integrand = u_expr**n_val
        ans = (u_expr**(n_val + 1)) / (a_val * (n_val + 1))

        question = f"\\int {latex(integrand)} \\, dx"

        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = {a_val} \\, dx$, so $dx = \\frac{{1}}{{{a_val}}} \\, du$",
            f"The integral becomes $\\frac{{1}}{{{a_val}}} \\int u^{{{n_val}}} \\, du$",
            f"$= \\frac{{1}}{{{a_val}}} \\cdot \\frac{{u^{{{n_val+1}}}}}{{{n_val+1}}} + C$",
            f"$= {latex(ans)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1150),
            topic="calculus/u_substitution",
            solution=sol
        )

    elif problem_type == 2:
        # ∫ x^m * (a*x^(m+1) + c)^n dx   — u = inner poly
        # Keep m=1 for easy level, n in {2..5}, a in {1..4}, c in {-6..6}
        a_val = randint(1, 5)
        c_val = randint(-6, 6)
        n_val = randint(2, 5)

        u_expr = a_val * x**2 + c_val
        integrand = x * (u_expr)**n_val
        # u = a*x² + c, du = 2a*x dx  →  x dx = du/(2a)
        ans = (u_expr**(n_val + 1)) / (2 * a_val * (n_val + 1))

        question = f"\\int {latex(integrand)} \\, dx"

        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = {2*a_val}x \\, dx$, so $x \\, dx = \\frac{{1}}{{{2*a_val}}} \\, du$",
            f"The integral becomes $\\frac{{1}}{{{2*a_val}}} \\int u^{{{n_val}}} \\, du$",
            f"$= \\frac{{u^{{{n_val+1}}}}}{{{2*a_val*(n_val+1)}}} + C$",
            f"$= {latex(ans)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/u_substitution",
            solution=sol
        )

    elif problem_type == 3:
        # ∫ sin(ax + b) dx  or  ∫ cos(ax + b) dx
        a_val = nonzero(-5, 5)
        b_val = randint(-6, 6)
        trig_choice = choice(['sin', 'cos'])
        u_expr = a_val * x + b_val

        if trig_choice == 'sin':
            integrand = sin(u_expr)
            ans = -cos(u_expr) / a_val
            antideriv_u = "-\\cos(u)"
        else:
            integrand = cos(u_expr)
            ans = sin(u_expr) / a_val
            antideriv_u = "\\sin(u)"

        question = f"\\int {latex(integrand)} \\, dx"

        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = {a_val} \\, dx$, so $dx = \\frac{{1}}{{{a_val}}} \\, du$",
            f"The integral becomes $\\frac{{1}}{{{a_val}}} \\int {trig_choice}(u) \\, du = \\frac{{1}}{{{a_val}}} \\cdot {antideriv_u} + C$",
            f"$= {latex(ans)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1200),
            topic="calculus/u_substitution",
            solution=sol
        )

    elif problem_type == 4:
        # ∫ e^(ax + b) dx   a in {±1..±5}, b in {-5..5}
        a_val = nonzero(-5, 5)
        b_val = randint(-5, 5)

        u_expr = a_val * x + b_val
        integrand = exp(u_expr)
        ans = exp(u_expr) / a_val

        question = f"\\int {latex(integrand)} \\, dx"

        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = {a_val} \\, dx$, so $dx = \\frac{{1}}{{{a_val}}} \\, du$",
            f"$\\frac{{1}}{{{a_val}}} \\int e^u \\, du = \\frac{{1}}{{{a_val}}} e^u + C$",
            f"$= {latex(ans)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1050, 1250),
            topic="calculus/u_substitution",
            solution=sol
        )

    else:
        # ∫ x^2 * (a*x^3 + b)^n dx   n in {2..5}, a in {1..4}, b in {-5..5}
        a_val = randint(1, 5)
        b_val = randint(-5, 5)
        n_val = randint(2, 5)

        u_expr = a_val * x**3 + b_val
        integrand = x**2 * u_expr**n_val
        # u = a*x³ + b, du = 3a*x² dx  →  x² dx = du/(3a)
        ans = (u_expr**(n_val + 1)) / (3 * a_val * (n_val + 1))

        question = f"\\int {latex(integrand)} \\, dx"

        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = {3*a_val}x^2 \\, dx$, so $x^2 \\, dx = \\frac{{1}}{{{3*a_val}}} \\, du$",
            f"$\\frac{{1}}{{{3*a_val}}} \\int u^{{{n_val}}} \\, du = \\frac{{u^{{{n_val+1}}}}}{{{3*a_val*(n_val+1)}}} + C$",
            f"$= {latex(ans)} + C$"
        )

        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/u_substitution",
            solution=sol
        )

emit(generate())
