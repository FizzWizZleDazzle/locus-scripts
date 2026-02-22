"""
precalculus - function_composition (medium)
Generated: 2026-02-22T04:37:57.986831
"""

from problem_utils import *

def generate():
    # Choose problem type randomly
    problem_type = choice(['evaluate', 'find_expression', 'decompose'])
    
    if problem_type == 'evaluate':
        # Type 1: Evaluate (f ∘ g)(a) for specific value
        # Difficulty: 1300-1400
        
        # Create simple functions
        coeff_f = nonzero(-5, 5)
        const_f = randint(-8, 8)
        
        func_g_type = choice(['linear', 'quadratic'])
        if func_g_type == 'linear':
            coeff_g = nonzero(-4, 4)
            const_g = randint(-6, 6)
            g_expr = coeff_g * x + const_g
        else:
            g_expr = x**2 + randint(-5, 5)
        
        f_expr = coeff_f * x + const_f
        
        # Choose evaluation point
        a_val = randint(-3, 3)
        
        # Calculate answer
        g_at_a = g_expr.subs(x, a_val)
        ans = f_expr.subs(x, g_at_a)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $(f \\circ g)({a_val})$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/function_composition",
            solution=steps(
                f"First find $g({a_val}) = {latex(g_expr.subs(x, a_val))} = {latex(g_at_a)}$",
                f"Then find $f(g({a_val})) = f({latex(g_at_a)})$",
                f"$f({latex(g_at_a)}) = {latex(f_expr.subs(x, g_at_a))} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 'find_expression':
        # Type 2: Find the composition (f ∘ g)(x)
        # Difficulty: 1400-1500
        
        func_type = choice(['linear_linear', 'quadratic_linear', 'linear_quadratic'])
        
        if func_type == 'linear_linear':
            # f(x) = ax + b, g(x) = cx + d
            a_val = nonzero(-4, 4)
            b_val = randint(-6, 6)
            c_val = nonzero(-4, 4)
            d_val = randint(-6, 6)
            
            f_expr = a_val * x + b_val
            g_expr = c_val * x + d_val
            
            composition = f_expr.subs(x, g_expr)
            ans = expand(composition)
            
        elif func_type == 'quadratic_linear':
            # f(x) = x^2 + bx + c, g(x) = ax + d
            b_val = randint(-4, 4)
            c_val = randint(-6, 6)
            a_val = nonzero(-3, 3)
            d_val = randint(-5, 5)
            
            f_expr = x**2 + b_val*x + c_val
            g_expr = a_val * x + d_val
            
            composition = f_expr.subs(x, g_expr)
            ans = expand(composition)
            
        else:  # linear_quadratic
            # f(x) = ax + b, g(x) = x^2 + c
            a_val = nonzero(-4, 4)
            b_val = randint(-6, 6)
            c_val = randint(-5, 5)
            
            f_expr = a_val * x + b_val
            g_expr = x**2 + c_val
            
            composition = f_expr.subs(x, g_expr)
            ans = expand(composition)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $(f \\circ g)(x)$.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="precalculus/function_composition",
            grading_mode="expand",
            solution=steps(
                f"$(f \\circ g)(x) = f(g(x))$",
                f"Substitute $g(x) = {latex(g_expr)}$ into $f(x)$:",
                f"$f({latex(g_expr)}) = {latex(composition)}$",
                f"Simplify: ${latex(ans)}$"
            ),
        )
    
    else:  # decompose
        # Type 3: Decompose h(x) = f(g(x)), find f or g
        # Difficulty: 1500-1600
        
        # Build from inside out
        inner_type = choice(['linear', 'simple_quad'])
        
        if inner_type == 'linear':
            a_val = nonzero(-3, 3)
            b_val = randint(-5, 5)
            g_expr = a_val * x + b_val
        else:
            g_expr = x**2 + randint(-4, 4)
        
        # Outer function
        outer_type = choice(['square', 'linear'])
        if outer_type == 'square':
            f_expr = x**2
            h_expr = expand(g_expr**2)
        else:
            m_val = nonzero(-4, 4)
            n_val = randint(-6, 6)
            f_expr = m_val * x + n_val
            h_expr = expand(f_expr.subs(x, g_expr))
        
        # Ask for the inner function
        return problem(
            question=f"Given $h(x) = {latex(h_expr)} = (f \\circ g)(x)$ where $f(x) = {latex(f_expr)}$, find $g(x)$.",
            answer=g_expr,
            difficulty=(1500, 1600),
            topic="precalculus/function_composition",
            solution=steps(
                f"We have $h(x) = f(g(x)) = {latex(h_expr)}$",
                f"Since $f(x) = {latex(f_expr)}$, we need $f(g(x)) = {latex(f_expr.subs(x, 'g(x)'))}$",
                f"Setting this equal to $h(x)$: ${latex(f_expr.subs(x, 'g(x)'))} = {latex(h_expr)}$",
                f"Solving for $g(x)$: $g(x) = {latex(g_expr)}$"
            ),
        )

emit(generate())