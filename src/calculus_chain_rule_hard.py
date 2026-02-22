"""
calculus - chain_rule (hard)
Generated: 2026-02-22T05:04:19.211829
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Nested trig functions with polynomial inside
        inner_coeff = nonzero(-4, 4)
        inner_power = randint(2, 3)
        inner_const = nonzero(-5, 5)
        outer_func = choice([sin, cos])
        outer_name = "sin" if outer_func == sin else "cos"
        
        inner = inner_coeff * x**inner_power + inner_const
        expr = outer_func(inner)
        ans = diff(expr, x)
        
        deriv_outer = cos(inner) if outer_func == sin else -sin(inner)
        deriv_inner = diff(inner, x)
        
        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1600, 1700),
            topic="calculus/chain_rule",
            solution=steps(
                f"Let $u = {latex(inner)}$, so we have ${outer_name}(u)$",
                f"By the chain rule: $\\frac{{d}}{{dx}}[{outer_name}(u)] = {outer_name}'(u) \\cdot u'$",
                f"$u' = \\frac{{d}}{{dx}}[{latex(inner)}] = {latex(deriv_inner)}$",
                f"${outer_name}'(u) = {latex(deriv_outer)}$",
                f"Therefore: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Composition of exponential and polynomial
        inner_a = nonzero(-3, 3)
        inner_b = nonzero(-4, 4)
        inner = inner_a * x**2 + inner_b * x
        expr = exp(inner)
        ans = diff(expr, x)
        
        deriv_inner = diff(inner, x)
        
        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1650, 1750),
            topic="calculus/chain_rule",
            solution=steps(
                f"Let $u = {latex(inner)}$, so we have $e^u$",
                f"By the chain rule: $\\frac{{d}}{{dx}}[e^u] = e^u \\cdot u'$",
                f"$u' = \\frac{{d}}{{dx}}[{latex(inner)}] = {latex(deriv_inner)}$",
                f"Therefore: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Multiple chain rule applications: sin(cos(x))
        middle_coeff = nonzero(-3, 3)
        inner_func = middle_coeff * x
        middle = cos(inner_func)
        expr = sin(middle)
        ans = diff(expr, x)
        
        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1700, 1800),
            topic="calculus/chain_rule",
            solution=steps(
                f"This requires the chain rule twice",
                f"Outer function: $\\sin(u)$ where $u = {latex(middle)}$",
                f"$\\frac{{d}}{{du}}[\\sin(u)] = \\cos(u) = {latex(cos(middle))}$",
                f"Now find $\\frac{{du}}{{dx}}$ where $u = \\cos({latex(inner_func)})$",
                f"$\\frac{{du}}{{dx}} = -\\sin({latex(inner_func)}) \\cdot {middle_coeff} = {latex(diff(middle, x))}$",
                f"By the chain rule: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Product rule combined with chain rule
        poly_coeff = nonzero(-3, 3)
        poly_power = randint(1, 3)
        poly_part = poly_coeff * x**poly_power
        
        inner_coeff = nonzero(-3, 3)
        inner_power = randint(2, 3)
        inner = inner_coeff * x**inner_power
        chain_part = sin(inner)
        
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
                f"Use the product rule: $(uv)' = u'v + uv'$",
                f"Let $u = {latex(poly_part)}$ and $v = {latex(chain_part)}$",
                f"$u' = {latex(deriv_poly)}$",
                f"For $v'$, use the chain rule on ${latex(chain_part)}$:",
                f"$v' = \\cos({latex(inner)}) \\cdot {latex(diff(inner, x))} = {latex(deriv_chain)}$",
                f"Therefore: ${latex(ans)}$"
            ),
        )
    
    else:
        # Quotient with chain rule in numerator or denominator
        num_const = nonzero(-4, 4)
        denom_inner_coeff = nonzero(-3, 3)
        denom_inner = denom_inner_coeff * x
        denom = cos(denom_inner)
        expr = num_const / denom
        ans = simplify(diff(expr, x))
        
        deriv_denom = diff(denom, x)
        
        return problem(
            question=f"Find \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/chain_rule",
            solution=steps(
                f"Rewrite as ${num_const} \\cdot \\sec({latex(denom_inner)})$ or use the quotient rule",
                f"Using quotient rule: $\\frac{{d}}{{dx}}\\left[\\frac{{u}}{{v}}\\right] = \\frac{{u'v - uv'}}{{v^2}}$",
                f"$u = {num_const}$, so $u' = 0$",
                f"$v = {latex(denom)}$, use chain rule: $v' = {latex(deriv_denom)}$",
                f"$\\frac{{0 \\cdot v - {num_const} \\cdot ({latex(deriv_denom)})}}{{({latex(denom)})^2}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )

emit(generate())