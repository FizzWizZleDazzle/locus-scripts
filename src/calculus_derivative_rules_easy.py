"""
calculus - derivative_rules (easy)
Generated: 2026-02-22T05:02:22.123027
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Power rule - monomial (1000-1100)
        n = randint(2, 6)
        coeff = nonzero(-5, 5)
        expr = coeff * x**n
        ans = diff(expr, x)
        return problem(
            question=f"Find the derivative: $\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Apply the power rule: $\\frac{{d}}{{dx}}[x^n] = nx^{{n-1}}$",
                f"$\\frac{{d}}{{dx}}[{latex(expr)}] = {coeff} \\cdot {n}x^{{{n-1}}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Power rule - simple polynomial (1100-1200)
        coeff1 = nonzero(-8, 8)
        exp1 = randint(2, 4)
        coeff2 = nonzero(-8, 8)
        expr = coeff1 * x**exp1 + coeff2 * x
        ans = diff(expr, x)
        return problem(
            question=f"Find the derivative: $\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Apply the power rule to each term:",
                f"$\\frac{{d}}{{dx}}[{latex(coeff1 * x**exp1)}] = {latex(diff(coeff1 * x**exp1, x))}$",
                f"$\\frac{{d}}{{dx}}[{latex(coeff2 * x)}] = {coeff2}$",
                f"Combined: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Three-term polynomial (1200-1300)
        coeff1 = nonzero(-6, 6)
        exp1 = randint(2, 3)
        coeff2 = nonzero(-6, 6)
        coeff3 = nonzero(-10, 10)
        expr = coeff1 * x**exp1 + coeff2 * x + coeff3
        ans = diff(expr, x)
        return problem(
            question=f"Find the derivative: $\\frac{{d}}{{dx}}\\left[{latex(expr)}\\right]$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Apply the power rule to each term:",
                f"$\\frac{{d}}{{dx}}[{latex(coeff1 * x**exp1)}] = {latex(diff(coeff1 * x**exp1, x))}$",
                f"$\\frac{{d}}{{dx}}[{latex(coeff2 * x)}] = {coeff2}$",
                f"$\\frac{{d}}{{dx}}[{coeff3}] = 0$ (constant rule)",
                f"Answer: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Constant multiple rule (1000-1100)
        k = nonzero(-7, 7)
        n = randint(2, 5)
        expr = k * x**n
        ans = diff(expr, x)
        return problem(
            question=f"Differentiate: $f(x) = {latex(expr)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Use the constant multiple rule: $\\frac{{d}}{{dx}}[kf(x)] = k\\frac{{d}}{{dx}}[f(x)]$",
                f"$f'(x) = {k} \\cdot {n}x^{{{n-1}}} = {latex(ans)}$"
            )
        )
    
    else:
        # Simple sum rule (1100-1200)
        coeff1 = nonzero(-5, 5)
        exp1 = randint(3, 5)
        coeff2 = nonzero(-5, 5)
        exp2 = randint(1, 2)
        expr = coeff1 * x**exp1 + coeff2 * x**exp2
        ans = diff(expr, x)
        return problem(
            question=f"Find $f'(x)$ if $f(x) = {latex(expr)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/derivative_rules",
            solution=steps(
                f"Use the sum rule: differentiate each term separately",
                f"$\\frac{{d}}{{dx}}[{latex(coeff1 * x**exp1)}] = {latex(diff(coeff1 * x**exp1, x))}$",
                f"$\\frac{{d}}{{dx}}[{latex(coeff2 * x**exp2)}] = {latex(diff(coeff2 * x**exp2, x))}$",
                f"Therefore: $f'(x) = {latex(ans)}$"
            )
        )

emit(generate())