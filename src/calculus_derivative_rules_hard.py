"""
calculus - derivative_rules (hard)
Generated: 2026-02-22T05:03:10.032508
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Chain rule with trig and polynomial inside
        inner_coeff = nonzero(-4, 4)
        inner_const = nonzero(-5, 5)
        outer_func = choice([sin, cos])
        inner = inner_coeff * x + inner_const
        expr = outer_func(inner)**randint(2, 3)
        ans = diff(expr, x)
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Let $u = {latex(inner)}$, so $\\frac{{du}}{{dx}} = {latex(diff(inner, x))}$",
                f"Using chain rule: $\\frac{{d}}{{dx}}[{latex(expr)}] = {latex(diff(expr.func(x*0+1), x).subs(x, 1))} \\cdot \\frac{{du}}{{dx}}$ where we substitute $u = {latex(inner)}$",
                f"Result: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Product rule with three functions
        a1, a2, a3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        n1, n2 = randint(2, 4), randint(2, 4)
        f1 = a1 * x**n1
        f2 = exp(a2 * x)
        f3 = sin(a3 * x)
        expr = f1 * f2 * f3
        ans = simplify(diff(expr, x))
        
        return problem(
            question=f"\\text{{Differentiate }} {latex(expr)}",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Using product rule for three functions: $(uvw)' = u'vw + uv'w + uvw'$",
                f"Let $u = {latex(f1)}$, $v = {latex(f2)}$, $w = {latex(f3)}$",
                f"$u' = {latex(diff(f1, x))}$, $v' = {latex(diff(f2, x))}$, $w' = {latex(diff(f3, x))}$",
                f"Combining terms: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Quotient rule with chain rule
        num_coeff = nonzero(-4, 4)
        denom_base = nonzero(2, 5)
        power = randint(2, 3)
        numerator = num_coeff * x**power
        denominator = exp(denom_base * x)
        expr = numerator / denominator
        ans = simplify(diff(expr, x))
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Using quotient rule: $\\left(\\frac{{u}}{{v}}\\right)' = \\frac{{u'v - uv'}}{{v^2}}$",
                f"$u = {latex(numerator)}$, $u' = {latex(diff(numerator, x))}$",
                f"$v = {latex(denominator)}$, $v' = {latex(diff(denominator, x))}$",
                f"$\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right] = \\frac{{({latex(diff(numerator, x))})({latex(denominator)}) - ({latex(numerator)})({latex(diff(denominator, x))})}}{{({latex(denominator)})^2}}$",
                f"Simplifying: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Chain rule nested twice
        inner_coeff = nonzero(-3, 3)
        middle_func = choice([sin, cos, exp])
        outer_power = randint(2, 3)
        inner = inner_coeff * x
        middle = middle_func(inner)
        expr = middle**outer_power
        ans = simplify(diff(expr, x))
        
        return problem(
            question=f"\\text{{Compute }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Let $u = {latex(middle)}$ and $v = {latex(inner)}$",
                f"Then $\\frac{{du}}{{dv}} = {latex(diff(middle_func(x), x))}$ and $\\frac{{dv}}{{dx}} = {latex(inner_coeff)}$",
                f"By chain rule: $\\frac{{d}}{{dx}}[u^{{{outer_power}}}] = {outer_power}u^{{{outer_power-1}}} \\cdot \\frac{{du}}{{dx}}$",
                f"$\\frac{{du}}{{dx}} = \\frac{{du}}{{dv}} \\cdot \\frac{{dv}}{{dx}} = {latex(diff(middle_func(x), x))} \\cdot {latex(inner_coeff)}$ (at $v = {latex(inner)}$)",
                f"Final answer: ${latex(ans)}$"
            ),
        )
    
    else:
        # Product and quotient combined
        a, b, c = nonzero(-3, 3), nonzero(-3, 3), nonzero(2, 4)
        n = randint(2, 3)
        numerator = a * x**n * cos(b * x)
        denominator = c * x
        expr = numerator / denominator
        ans = simplify(diff(expr, x))
        
        return problem(
            question=f"\\text{{Differentiate }} {latex(expr)}",
            answer=ans,
            difficulty=(1700, 1900),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Rewrite as ${latex(simplify(numerator/c))} \\cdot x^{{-1}}$ or use quotient rule",
                f"Using product rule on numerator first: $({latex(a*x**n)})' \\cdot {latex(cos(b*x))} + {latex(a*x**n)} \\cdot ({latex(cos(b*x))})'$",
                f"Numerator derivative: ${latex(diff(numerator, x))}$",
                f"Applying quotient rule: $\\frac{{({latex(diff(numerator, x))})({latex(denominator)}) - ({latex(numerator)})({latex(diff(denominator, x))})}}{{({latex(denominator)})^2}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )

emit(generate())