"""
calculus - chain_rule (easy)
Generated: 2026-02-22T05:03:31.019825
"""

from problem_utils import *

def generate():
    # Easy chain rule: single composition, clean integer coefficients
    # Parameter ranges greatly expanded to produce 500+ distinct problems

    problem_type = randint(1, 6)

    if problem_type == 1:
        # d/dx[sin(ax+b)]  or  d/dx[cos(ax+b)]
        func_choice = choice(['sin', 'cos'])
        a = nonzero(-6, 6)
        b = randint(-8, 8)
        inner = a * x + b

        if func_choice == 'sin':
            expr = sin(inner)
            ans = a * cos(inner)
            outer_deriv_text = f"\\cos({latex(inner)})"
        else:
            expr = cos(inner)
            ans = -a * sin(inner)
            outer_deriv_text = f"-\\sin({latex(inner)})"

        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1000, 1200),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule: derivative of outer × derivative of inner",
                f"Inner: ${latex(inner)}$, derivative: ${a}$",
                f"Outer derivative: ${outer_deriv_text}$",
                f"Result: ${latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # d/dx[(ax+b)^n]  a in {±1..±5}, b in {-8..8}, n in {2..7}
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        n = randint(2, 7)

        expr = (a * x + b)**n
        ans = n * a * (a * x + b)**(n - 1)

        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to ${latex(expr)}$",
                f"Outer: $u^{{{n}}}$ → derivative ${n}u^{{{n-1}}}$",
                f"Inner: $u = {latex(a*x+b)}$ → derivative ${a}$",
                f"Result: ${n} \\cdot {latex(a*x+b)}^{{{n-1}}} \\cdot {a} = {latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # d/dx[e^(ax+b)]  a in {±1..±6}, b in {-6..6}
        a = nonzero(-6, 6)
        b = randint(-6, 6)
        inner = a * x + b

        expr = exp(inner)
        ans = a * exp(inner)

        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1050, 1200),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to $e^{{{latex(inner)}}}$",
                f"$\\frac{{d}}{{dx}}[e^u] = e^u \\cdot \\frac{{du}}{{dx}}$, $u = {latex(inner)}$",
                f"$\\frac{{du}}{{dx}} = {a}$",
                f"Result: ${latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # d/dx[tan(ax+b)]
        a = nonzero(-5, 5)
        b = randint(-6, 6)
        inner = a * x + b

        expr = tan(inner)
        ans = diff(expr, x)

        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to $\\tan({latex(inner)})$",
                f"$\\frac{{d}}{{dx}}[\\tan(u)] = \\sec^2(u) \\cdot \\frac{{du}}{{dx}}$",
                f"$u = {latex(inner)}$, $\\frac{{du}}{{dx}} = {a}$",
                f"Result: ${a} \\sec^2({latex(inner)})$"
            )
        )

    elif problem_type == 5:
        # d/dx[ln(ax + b)]  a, b chosen so argument positive
        a = randint(1, 6)
        b = randint(1, 8)
        inner = a * x + b

        expr = log(inner)
        ans = Rational(a, 1) / inner

        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[\\ln({latex(inner)})\\right]",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to $\\ln({latex(inner)})$",
                f"$\\frac{{d}}{{dx}}[\\ln(u)] = \\frac{{1}}{{u}} \\cdot \\frac{{du}}{{dx}}$",
                f"$u = {latex(inner)}$, $\\frac{{du}}{{dx}} = {a}$",
                f"Result: $\\frac{{{a}}}{{{latex(inner)}}}$"
            )
        )

    else:
        # d/dx[(x^n)^m]  = d/dx[x^(nm)]  — power in disguise
        n = randint(2, 4)
        m = randint(2, 3)

        expr = (x**n)**m
        simplified = x**(n * m)
        ans = n * m * x**(n * m - 1)

        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1000, 1150),
            topic="calculus/chain_rule",
            solution=steps(
                f"Simplify: ${latex(expr)} = x^{{{n*m}}}$",
                f"Apply power rule: ${n*m} x^{{{n*m - 1}}}$"
            )
        )

emit(generate())
