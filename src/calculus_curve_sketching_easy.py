"""
calculus - curve_sketching (easy)
Generated: 2026-02-22T05:07:26.311361
"""

from problem_utils import *

def generate():
    problem_type = choice(['increasing_decreasing', 'concavity', 'critical_points', 'inflection_points'])
    
    if problem_type == 'increasing_decreasing':
        # Simple polynomial, ask where increasing/decreasing
        # ELO 1000-1300: just find derivative sign at a specific point
        a = nonzero(-3, 3)
        b = nonzero(-5, 5)
        
        # Function: ax^2 + bx
        func = a*x**2 + b*x
        deriv = diff(func, x)
        
        # Pick a test point
        test_x = nonzero(-4, 4)
        deriv_value = deriv.subs(x, test_x)
        
        if deriv_value > 0:
            ans = "increasing"
        else:
            ans = "decreasing"
        
        return problem(
            question=f"Is $f(x) = {latex(func)}$ increasing or decreasing at $x = {test_x}$?",
            answer=ans,
            difficulty=(1000, 1200),
            topic="calculus/curve_sketching",
            answer_type="string",
            solution=steps(
                f"Find the derivative: $f'(x) = {latex(deriv)}$",
                f"Evaluate at $x = {test_x}$: $f'({test_x}) = {latex(deriv_value)}$",
                f"Since $f'({test_x}) {'>' if deriv_value > 0 else '<'} 0$, the function is {ans}"
            ),
        )
    
    elif problem_type == 'concavity':
        # Simple polynomial, ask about concavity at a point
        # ELO 1100-1300: find second derivative sign at a point
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-5, 5)
        
        # Function: ax^3 + bx^2 + cx
        func = a*x**3 + b*x**2 + c*x
        first_deriv = diff(func, x)
        second_deriv = diff(first_deriv, x)
        
        # Pick a test point
        test_x = nonzero(-3, 3)
        second_deriv_value = second_deriv.subs(x, test_x)
        
        if second_deriv_value > 0:
            ans = "concave up"
        else:
            ans = "concave down"
        
        return problem(
            question=f"Is $f(x) = {latex(func)}$ concave up or concave down at $x = {test_x}$?",
            answer=ans,
            difficulty=(1100, 1300),
            topic="calculus/curve_sketching",
            answer_type="string",
            solution=steps(
                f"Find the first derivative: $f'(x) = {latex(first_deriv)}$",
                f"Find the second derivative: $f''(x) = {latex(second_deriv)}$",
                f"Evaluate at $x = {test_x}$: $f''({test_x}) = {latex(second_deriv_value)}$",
                f"Since $f''({test_x}) {'>' if second_deriv_value > 0 else '<'} 0$, the function is {ans}"
            ),
        )
    
    elif problem_type == 'critical_points':
        # Find a critical point of a simple quadratic
        # ELO 1100-1300: solve f'(x) = 0 for simple case
        a = nonzero(-3, 3)
        
        # Choose critical point first (reverse engineer)
        crit_pt = nonzero(-5, 5)
        
        # Build function: a(x - crit_pt)^2 expanded
        func = a*(x - crit_pt)**2
        func_expanded = expand(func)
        deriv = diff(func_expanded, x)
        
        return problem(
            question=f"Find the critical point of $f(x) = {latex(func_expanded)}$",
            answer=crit_pt,
            difficulty=(1100, 1300),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find the derivative: $f'(x) = {latex(deriv)}$",
                f"Set $f'(x) = 0$: ${latex(deriv)} = 0$",
                f"Solve for $x$: $x = {crit_pt}$"
            ),
        )
    
    else:  # inflection_points
        # Find inflection point of a simple cubic
        # ELO 1200-1300: solve f''(x) = 0 for simple case
        a = nonzero(-2, 2)
        
        # Choose inflection point first
        infl_pt = nonzero(-4, 4)
        
        # Build function: a(x - infl_pt)^3 expanded
        func = a*(x - infl_pt)**3
        func_expanded = expand(func)
        first_deriv = diff(func_expanded, x)
        second_deriv = diff(first_deriv, x)
        
        return problem(
            question=f"Find the inflection point of $f(x) = {latex(func_expanded)}$",
            answer=infl_pt,
            difficulty=(1200, 1300),
            topic="calculus/curve_sketching",
            solution=steps(
                f"Find the first derivative: $f'(x) = {latex(first_deriv)}$",
                f"Find the second derivative: $f''(x) = {latex(second_deriv)}$",
                f"Set $f''(x) = 0$: ${latex(second_deriv)} = 0$",
                f"Solve for $x$: $x = {infl_pt}$"
            ),
        )

emit(generate())