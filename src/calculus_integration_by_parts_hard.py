"""
calculus - integration_by_parts (hard)
Generated: 2026-02-22T05:14:12.753863
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # x^n * trig(ax)  n in {2,3}, a in {1..4}, coeff in {±1..±4}
        power = randint(2, 3)
        a = randint(1, 4)
        coeff = nonzero(-4, 4)
        trig_choice = choice(['sin', 'cos'])

        u = x**power
        du = power * x**(power - 1)

        if trig_choice == 'sin':
            expr = coeff * x**power * sin(a * x)
            dv_str = f"\\sin({a}x)"
            v_str = f"-\\frac{{1}}{{{a}}}\\cos({a}x)"
        else:
            expr = coeff * x**power * cos(a * x)
            dv_str = f"\\cos({a}x)"
            v_str = f"\\frac{{1}}{{{a}}}\\sin({a}x)"

        ans = simplify(integrate(expr, x))

        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts with $u = {latex(u)}$ and $dv = {coeff}{dv_str} dx$",
                f"Then $du = {latex(du)} dx$ and $v = {coeff}{v_str}$",
                f"$\\int u \\, dv = uv - \\int v \\, du$ — the remaining integral needs parts again",
                f"Apply again with inner polynomial of degree {power - 1}",
                f"${latex(ans)} + C$"
            ),
        )

    elif problem_type == 2:
        # x^n * ln(ax)  n in {2..5}, a in {1..5}, coeff in {±1,±2,±3}
        power = randint(2, 5)
        a = randint(1, 5)
        coeff = nonzero(-3, 3)

        expr = coeff * x**power * log(a * x)
        v_expr = coeff * x**(power + 1) / (power + 1)
        ans = simplify(integrate(expr, x))

        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts with $u = \\ln({a}x)$ and $dv = {latex(coeff * x**power)} dx$",
                f"Then $du = \\frac{{1}}{{x}} dx$ and $v = {latex(v_expr)}$",
                f"$\\int u \\, dv = uv - \\int v \\, du$",
                f"$= {latex(v_expr * log(a * x))} - \\int {latex(v_expr)} \\cdot \\frac{{1}}{{x}} dx$",
                f"${latex(ans)} + C$"
            ),
        )

    elif problem_type == 3:
        # e^(ax) * sin(bx) or cos(bx) — cyclic, solve algebraically
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        trig_choice = choice(['sin', 'cos'])

        if trig_choice == 'sin':
            expr = exp(a * x) * sin(b * x)
            ans = exp(a * x) * (a * sin(b * x) - b * cos(b * x)) / (a**2 + b**2)
        else:
            expr = exp(a * x) * cos(b * x)
            ans = exp(a * x) * (a * cos(b * x) + b * sin(b * x)) / (a**2 + b**2)

        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1750, 1850),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Call the integral $I = \\int {latex(expr)} dx$",
                f"Let $u = {trig_choice}({b}x)$, $dv = e^{{{a}x}} dx$",
                f"First application gives a new integral of the same family",
                f"Second application produces $-I$ (or $+I$), so collect terms",
                f"$(1 + \\frac{{{b**2}}}{{{a**2}}}) I = \\ldots$ → $I = {latex(ans)} + C$"
            ),
        )

    elif problem_type == 4:
        # x^n * arcsin(x) or arctan(x)  n in {1,2}, coeff in {±1..±3}
        power = randint(1, 2)
        coeff = nonzero(-3, 3)
        inv_trig = choice(['asin', 'atan'])

        if inv_trig == 'asin':
            expr = coeff * x**power * asin(x)
        else:
            expr = coeff * x**power * atan(x)

        ans = simplify(integrate(expr, x))

        inv_name = "\\arcsin" if inv_trig == 'asin' else "\\arctan"
        du_inv = "\\frac{1}{\\sqrt{1-x^2}}" if inv_trig == 'asin' else "\\frac{1}{1+x^2}"

        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1700, 1800),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts with $u = {inv_name}(x)$ and $dv = {latex(coeff * x**power)} dx$",
                f"$du = {du_inv} dx$ and $v = {latex(coeff * x**(power+1) / (power+1))}$",
                f"$\\int u \\, dv = uv - \\int v \\, du$ — remaining integral is algebraic",
                f"${latex(ans)} + C$"
            ),
        )

    else:
        # Definite integral  ∫₀¹ x^n * e^(ax) dx  n in {1,2}, a in {1..4}, coeff in {±1,±2}
        coeff = nonzero(-2, 2)
        power = randint(1, 2)
        a = randint(1, 4)

        expr = coeff * x**power * exp(a * x)
        lower, upper = 0, 1

        ans = simplify(integrate(expr, (x, lower, upper)))

        return problem(
            question=f"\\int_{{{lower}}}^{{{upper}}} {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/integration_by_parts",
            solution=steps(
                f"Use integration by parts: $u = {latex(x**power)}$, $dv = {latex(coeff * exp(a*x))} dx$",
                f"Then $du = {latex(diff(x**power, x))} dx$ and $v = \\frac{{{coeff}}}{{{a}}}e^{{{a}x}}$",
                f"Find the antiderivative $F(x)$ first, then evaluate $F({upper}) - F({lower})$",
                f"$= {latex(ans)}$"
            ),
        )

emit(generate())
