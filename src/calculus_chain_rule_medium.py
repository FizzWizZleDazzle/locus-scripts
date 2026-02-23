"""
calculus - chain_rule (medium)
Generated: 2026-02-22T05:03:49.235572
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # d/dx[(ax² + bx + c)^n]
        outer_power = randint(2, 5)
        a_c = nonzero(-5, 5)
        b_c = randint(-8, 8)
        c_c = randint(-8, 8)

        inner = a_c * x**2 + b_c * x + c_c
        expr = inner**outer_power
        ans = diff(expr, x)

        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1300, 1450),
            topic="calculus/chain_rule",
            solution=steps(
                f"Let $u = {latex(inner)}$",
                f"$\\frac{{d}}{{dx}}[u^{{{outer_power}}}] = {outer_power}u^{{{outer_power-1}}} \\cdot u'$",
                f"$u' = {latex(diff(inner, x))}$",
                f"Result: ${latex(ans)}$"
            )
        )

    elif problem_type == 2:
        # d/dx[sin(ax² + bx + c)]  or cos variant
        trig_func = choice([sin, cos])
        a_c = nonzero(-4, 4)
        b_c = randint(-6, 6)
        c_c = randint(-6, 6)

        inner = a_c * x**2 + b_c * x + c_c
        expr = trig_func(inner)
        ans = diff(expr, x)

        trig_name = "\\sin" if trig_func == sin else "\\cos"
        deriv_name = "\\cos" if trig_func == sin else "-\\sin"

        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to ${trig_name}({latex(inner)})$",
                f"$= {deriv_name}({latex(inner)}) \\cdot \\frac{{d}}{{dx}}[{latex(inner)}]$",
                f"$\\frac{{d}}{{dx}}[{latex(inner)}] = {latex(diff(inner, x))}$",
                f"Result: ${latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # d/dx[e^(polynomial)]  — inner is ax² + bx or ax³ + c
        inner_type = choice(['quadratic', 'cubic_c'])
        a_c = nonzero(-4, 4)
        b_c = nonzero(-5, 5)
        c_c = randint(-5, 5)

        if inner_type == 'quadratic':
            inner = a_c * x**2 + b_c * x + c_c
        else:
            inner = a_c * x**3 + c_c

        expr = exp(inner)
        ans = diff(expr, x)

        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1450, 1550),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to $e^{{{latex(inner)}}}$",
                f"$\\frac{{d}}{{dx}}[e^u] = e^u \\cdot u'$ where $u = {latex(inner)}$",
                f"$u' = {latex(diff(inner, x))}$",
                f"Result: ${latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # d/dx[ln(polynomial)]  — ln(ax^n + b)
        n_pow = randint(2, 4)
        a_c = randint(1, 5)
        b_c = randint(1, 8)   # keep argument positive

        inner = a_c * x**n_pow + b_c
        expr = log(inner)
        ans = diff(expr, x)

        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[\\ln({latex(inner)})\\right]",
            answer=ans,
            difficulty=(1400, 1500),
            topic="calculus/chain_rule",
            solution=steps(
                f"$\\frac{{d}}{{dx}}[\\ln(u)] = \\frac{{1}}{{u}} \\cdot u'$ where $u = {latex(inner)}$",
                f"$u' = {latex(diff(inner, x))}$",
                f"Result: $\\frac{{{latex(diff(inner,x))}}}{{({latex(inner)})}} = {latex(ans)}$"
            )
        )

    else:
        # d/dx[outer(inner)] where outer ∈ {sin, cos, exp} and inner = ax^n  n in {2,3}
        outer_type = choice(['sin', 'cos', 'exp'])
        inner_power = randint(2, 3)
        inner_coef = nonzero(-4, 4)
        const = randint(-5, 5)

        inner = inner_coef * x**inner_power + const

        if outer_type == 'sin':
            expr = sin(inner)
            outer_deriv = f"\\cos({latex(inner)})"
        elif outer_type == 'cos':
            expr = cos(inner)
            outer_deriv = f"-\\sin({latex(inner)})"
        else:
            expr = exp(inner)
            outer_deriv = f"e^{{{latex(inner)}}}"

        ans = diff(expr, x)

        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/chain_rule",
            solution=steps(
                f"Inner function: $u = {latex(inner)}$, $u' = {latex(diff(inner, x))}$",
                f"Outer derivative: ${outer_deriv}$",
                f"Result: ${latex(ans)}$"
            )
        )

emit(generate())
