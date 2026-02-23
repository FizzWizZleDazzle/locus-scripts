"""
calculus - chain_rule (hard)
Generated: 2026-02-22T05:04:19.211829
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # d/dx[outer(ax^n + bx + c)]  outer ∈ {sin, cos, exp, ln}
        inner_coeff = nonzero(-5, 5)
        b_coeff = randint(-6, 6)
        c_coeff = randint(-6, 6)
        inner_power = randint(2, 4)
        outer_func = choice([sin, cos, exp])
        outer_name = {sin: "sin", cos: "cos", exp: "exp"}[outer_func]

        inner = inner_coeff * x**inner_power + b_coeff * x + c_coeff
        expr = outer_func(inner)
        ans = diff(expr, x)

        deriv_outer = {
            sin: f"\\cos({latex(inner)})",
            cos: f"-\\sin({latex(inner)})",
            exp: f"e^{{{latex(inner)}}}"
        }[outer_func]
        deriv_inner = diff(inner, x)

        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/chain_rule",
            solution=steps(
                f"Let $u = {latex(inner)}$",
                f"Outer derivative: ${deriv_outer}$",
                f"Inner derivative: $u' = {latex(deriv_inner)}$",
                f"By chain rule: ${latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # d/dx[e^(ax² + bx + c)]  — varied quadratic exponents
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        c = randint(-5, 5)

        inner = a * x**2 + b * x + c
        expr = exp(inner)
        ans = diff(expr, x)
        deriv_inner = diff(inner, x)

        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/chain_rule",
            solution=steps(
                f"Let $u = {latex(inner)}$",
                f"$\\frac{{d}}{{dx}}[e^u] = e^u \\cdot u'$",
                f"$u' = {latex(deriv_inner)}$",
                f"Result: ${latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Nested chain rule: outer(middle(inner))  e.g. sin(cos(ax+b)) or exp(sin(cx))
        a = nonzero(-4, 4)
        b = randint(-5, 5)
        inner_func = choice([sin, cos])
        outer_func = choice([sin, cos, exp])

        inner_arg = a * x + b
        middle = inner_func(inner_arg)
        expr = outer_func(middle)
        ans = diff(expr, x)

        middle_name = "sin" if inner_func == sin else "cos"
        outer_name = {sin: "sin", cos: "cos", exp: "exp"}[outer_func]

        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1700, 1800),
            topic="calculus/chain_rule",
            solution=steps(
                f"Triple chain rule: outer={outer_name}, middle={middle_name}, inner={latex(inner_arg)}",
                f"Outer derivative of $\\{outer_name}(u)$: $\\frac{{d}}{{du}}$",
                f"Middle derivative of $\\{middle_name}({latex(inner_arg)})$: $\\pm {abs(a)}\\cdot$ trig",
                f"By chain rule: ${latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # Product rule + chain rule: poly * trig(poly)
        poly_coeff = nonzero(-4, 4)
        poly_power = randint(1, 3)
        poly_part = poly_coeff * x**poly_power

        inner_coeff = nonzero(-4, 4)
        inner_power = randint(2, 4)
        inner_const = randint(-5, 5)
        inner = inner_coeff * x**inner_power + inner_const
        chain_func = choice([sin, cos, exp])
        chain_part = chain_func(inner)

        expr = poly_part * chain_part
        ans = diff(expr, x)

        deriv_poly = diff(poly_part, x)
        deriv_chain = diff(chain_part, x)

        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1750, 1850),
            topic="calculus/chain_rule",
            solution=steps(
                f"Use product rule: $(uv)' = u'v + uv'$",
                f"$u = {latex(poly_part)}$, $v = {latex(chain_part)}$",
                f"$u' = {latex(deriv_poly)}$",
                f"$v' = {latex(deriv_chain)}$ (chain rule on $v$)",
                f"Result: ${latex(ans)}$"
            ),
        )

    else:
        # Quotient with chain rule: k / trig(ax+b)  = k*sec or k/cos etc.
        num_const = nonzero(-5, 5)
        a = nonzero(-4, 4)
        b = randint(-6, 6)
        denom_inner = a * x + b
        denom_func = choice([sin, cos, exp])
        denom = denom_func(denom_inner)

        expr = num_const / denom
        ans = simplify(diff(expr, x))
        deriv_denom = diff(denom, x)

        denom_name = {sin: "\\sin", cos: "\\cos", exp: "e^"}[denom_func]

        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/chain_rule",
            solution=steps(
                f"Quotient rule: $\\frac{{d}}{{dx}}\\left[\\frac{{u}}{{v}}\\right] = \\frac{{u'v - uv'}}{{v^2}}$",
                f"$u = {num_const}$ (constant), $v = {latex(denom)}$",
                f"$v' = {latex(deriv_denom)}$ (chain rule: inner $= {latex(denom_inner)}$)",
                f"$= \\frac{{0 \\cdot {latex(denom)} - {num_const} \\cdot ({latex(deriv_denom)})}}{{({latex(denom)})^2}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )

emit(generate())
