"""
calculus - chain_rule (easy)
Generated: 2026-02-22T05:03:31.019825
"""

from problem_utils import *

def generate():
    # For EASIER chain rule problems (1000-1300), we focus on:
    # - Simple compositions like sin(ax), cos(bx), (cx+d)^n
    # - Direct application of chain rule
    # - Clean integer coefficients
    
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type: d/dx[sin(ax)] or d/dx[cos(ax)]
        func_choice = choice(['sin', 'cos'])
        a = nonzero(-5, 5)
        
        if func_choice == 'sin':
            expr = sin(a*x)
            ans = a * cos(a*x)
            inner = a*x
            inner_deriv = a
            outer_name = "sine"
            outer_deriv_text = f"\\cos({latex(inner)})"
        else:
            expr = cos(a*x)
            ans = -a * sin(a*x)
            inner = a*x
            inner_deriv = a
            outer_name = "cosine"
            outer_deriv_text = f"-\\sin({latex(inner)})"
        
        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1000, 1200),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule: derivative of outer function times derivative of inner function",
                f"Inner function: ${latex(inner)}$, derivative: ${latex(inner_deriv)}$",
                f"Outer derivative: ${outer_deriv_text}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Type: d/dx[(ax + b)^n] for small n
        a = nonzero(-4, 4)
        b = randint(-6, 6)
        n = randint(2, 4)
        
        expr = (a*x + b)**n
        ans = n * a * (a*x + b)**(n-1)
        
        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to ${latex(expr)}$",
                f"Outer function: $u^{n}$, derivative: ${n}u^{{{n-1}}}$",
                f"Inner function: $u = {latex(a*x + b)}$, derivative: ${latex(a)}$",
                f"Chain rule: ${n} \\cdot {latex(a*x + b)}^{{{n-1}}} \\cdot {latex(a)}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Type: d/dx[e^(ax)]
        a = nonzero(-4, 4)
        
        expr = exp(a*x)
        ans = a * exp(a*x)
        
        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1050, 1200),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to ${latex(expr)}$",
                f"Derivative of $e^u$ is $e^u \\cdot \\frac{{du}}{{dx}}$",
                f"Here $u = {latex(a*x)}$, so $\\frac{{du}}{{dx}} = {latex(a)}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Type: d/dx[(x^2)^n] = d/dx[x^(2n)] - simple power in disguise
        n = randint(2, 3)
        
        expr = (x**2)**n
        simplified = x**(2*n)
        ans = 2*n*x**(2*n-1)
        
        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1000, 1150),
            topic="calculus/chain_rule",
            solution=steps(
                f"Simplify: ${latex(expr)} = {latex(simplified)}$",
                f"Apply power rule: ${latex(ans)}$"
            )
        )
    
    else:
        # Type: d/dx[tan(ax)] for variety
        a = nonzero(-3, 3)
        
        expr = tan(a*x)
        ans = a * (1/cos(a*x))**2
        ans_alt = a * (tan(a*x)**2 + 1)  # sec^2 form
        
        return problem(
            question=f"\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/chain_rule",
            solution=steps(
                f"Apply chain rule to ${latex(expr)}$",
                f"Derivative of $\\tan(u)$ is $\\sec^2(u) \\cdot \\frac{{du}}{{dx}}$",
                f"Here $u = {latex(a*x)}$, so $\\frac{{du}}{{dx}} = {latex(a)}$",
                f"Result: ${latex(a)} \\sec^2({latex(a*x)})$"
            )
        )

emit(generate())