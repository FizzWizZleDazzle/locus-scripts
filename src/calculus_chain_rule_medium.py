"""
calculus - chain_rule (medium)
Generated: 2026-02-22T05:03:49.235572
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple chain rule: polynomial composition
        # Difficulty: 1300-1400
        outer_power = randint(2, 4)
        inner_coef = nonzero(-5, 5)
        inner_const = nonzero(-8, 8)
        
        inner = inner_coef * x + inner_const
        expr = inner ** outer_power
        ans = diff(expr, x)
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1300, 1400),
            topic="calculus/chain_rule",
            solution=steps(
                f"Let $u = {latex(inner)}$, so we have $u^{{{outer_power}}}$",
                f"Using the chain rule: $\\frac{{d}}{{dx}}[u^{{{outer_power}}}] = {outer_power}u^{{{outer_power-1}}} \\cdot \\frac{{du}}{{dx}}$",
                f"$\\frac{{du}}{{dx}} = {latex(diff(inner, x))}$",
                f"Therefore: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Trig function with linear argument
        # Difficulty: 1400-1500
        trig_func = choice([sin, cos])
        inner_coef = nonzero(-6, 6)
        inner_const = nonzero(-5, 5)
        
        inner = inner_coef * x + inner_const
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
                f"Apply the chain rule to ${trig_name}({latex(inner)})$",
                f"$\\frac{{d}}{{dx}}[{trig_name}(u)] = {deriv_name}(u) \\cdot \\frac{{du}}{{dx}}$ where $u = {latex(inner)}$",
                f"$\\frac{{du}}{{dx}} = {latex(diff(inner, x))}$",
                f"Therefore: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Exponential with polynomial argument
        # Difficulty: 1450-1550
        inner_coef = nonzero(-4, 4)
        inner_power = choice([1, 2])
        
        if inner_power == 1:
            inner = inner_coef * x
        else:
            inner = inner_coef * x**2
            
        expr = exp(inner)
        ans = diff(expr, x)
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1450, 1550),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply the chain rule to $e^{{{latex(inner)}}}$",
                f"$\\frac{{d}}{{dx}}[e^u] = e^u \\cdot \\frac{{du}}{{dx}}$ where $u = {latex(inner)}$",
                f"$\\frac{{du}}{{dx}} = {latex(diff(inner, x))}$",
                f"Therefore: ${latex(ans)}$"
            )
        )
    
    else:
        # Composition of two functions (more complex)
        # Difficulty: 1500-1600
        outer_type = choice(['sin', 'cos', 'exp'])
        inner_power = randint(2, 3)
        inner_coef = nonzero(-3, 3)
        
        inner = inner_coef * x**inner_power
        
        if outer_type == 'sin':
            expr = sin(inner)
        elif outer_type == 'cos':
            expr = cos(inner)
        else:
            expr = exp(inner)
        
        ans = diff(expr, x)
        
        if outer_type == 'sin':
            outer_deriv = f"\\cos({latex(inner)})"
        elif outer_type == 'cos':
            outer_deriv = f"-\\sin({latex(inner)})"
        else:
            outer_deriv = f"e^{{{latex(inner)}}}"
        
        return problem(
            question=f"\\text{{Find }} \\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1500, 1600),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply the chain rule with outer function and inner function $u = {latex(inner)}$",
                f"Derivative of outer function: ${outer_deriv}$",
                f"Derivative of inner function: $\\frac{{du}}{{dx}} = {latex(diff(inner, x))}$",
                f"Multiply: ${latex(ans)}$"
            )
        )

emit(generate())