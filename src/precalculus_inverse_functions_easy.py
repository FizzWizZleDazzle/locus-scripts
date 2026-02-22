"""
precalculus - inverse_functions (easy)
Generated: 2026-02-22T04:38:54.504876
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Find inverse of simple linear function f(x) = ax + b
        a_val = nonzero(-5, 5)
        b_val = randint(-8, 8)
        
        f_expr = a_val * x + b_val
        
        # Solve y = ax + b for x
        # y - b = ax
        # x = (y - b)/a
        inverse_expr = (x - b_val) / a_val
        
        return problem(
            question=f"Find the inverse function $f^{{-1}}(x)$ if $f(x) = {latex(f_expr)}$",
            answer=inverse_expr,
            difficulty=(1000, 1150),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"Let $y = {latex(f_expr)}$",
                f"Solve for $x$: $y - {b_val} = {a_val}x$",
                f"$x = \\frac{{y - {b_val}}}{{{a_val}}}$",
                f"Replace $y$ with $x$: $f^{{-1}}(x) = {latex(inverse_expr)}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Verify if two simple functions are inverses
        a_val = nonzero(-4, 4)
        b_val = randint(-6, 6)
        
        f_expr = a_val * x + b_val
        
        # Create correct or incorrect inverse
        is_correct = choice([True, False])
        
        if is_correct:
            g_expr = (x - b_val) / a_val
        else:
            # Make a common mistake
            mistake = choice(['sign', 'wrong_denominator'])
            if mistake == 'sign':
                g_expr = (x + b_val) / a_val
            else:
                wrong_a = nonzero(-4, 4)
                while wrong_a == a_val:
                    wrong_a = nonzero(-4, 4)
                g_expr = (x - b_val) / wrong_a
        
        composed = simplify(f_expr.subs(x, g_expr))
        
        return problem(
            question=f"Are $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$ inverse functions? (Answer True or False)",
            answer=is_correct,
            difficulty=(1100, 1250),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"Check if $f(g(x)) = x$",
                f"$f(g(x)) = {latex(f_expr.subs(x, g_expr))}$",
                f"Simplify: ${latex(composed)}$",
                f"Since $f(g(x)) {'=' if is_correct else '\\neq'} x$, the answer is {is_correct}"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Evaluate f^(-1)(k) given a simple function
        a_val = nonzero(-5, 5)
        b_val = randint(-8, 8)
        
        f_expr = a_val * x + b_val
        
        # Pick a value that gives a nice answer
        x_val = randint(-5, 5)
        k_val = a_val * x_val + b_val
        
        return problem(
            question=f"If $f(x) = {latex(f_expr)}$, find $f^{{-1}}({k_val})$",
            answer=x_val,
            difficulty=(1050, 1200),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"To find $f^{{-1}}({k_val})$, solve $f(x) = {k_val}$",
                f"${latex(f_expr)} = {k_val}$",
                f"${a_val}x = {k_val - b_val}$",
                f"$x = {x_val}$",
                f"Therefore, $f^{{-1}}({k_val}) = {x_val}$"
            )
        )
    
    else:
        # Type 4: Find inverse of f(x) = a/x (simple reciprocal)
        a_val = nonzero(-6, 6)
        
        f_expr = a_val / x
        
        # The inverse of a/x is a/x (self-inverse)
        inverse_expr = a_val / x
        
        return problem(
            question=f"Find the inverse function $f^{{-1}}(x)$ if $f(x) = {latex(f_expr)}$",
            answer=inverse_expr,
            difficulty=(1150, 1300),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"Let $y = {latex(f_expr)}$",
                f"Solve for $x$: $xy = {a_val}$",
                f"$x = \\frac{{{a_val}}}{{y}}$",
                f"Replace $y$ with $x$: $f^{{-1}}(x) = {latex(inverse_expr)}$",
                f"Note: This function is its own inverse"
            )
        )

emit(generate())