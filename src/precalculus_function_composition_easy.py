"""
precalculus - function_composition (easy)
Generated: 2026-02-22T04:37:34.902777
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple composition with linear functions (1000-1100)
        # f(x) = ax + b, g(x) = cx + d, find f(g(x))
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-5, 5)
        d = nonzero(-8, 8)
        
        f_expr = a*x + b
        g_expr = c*x + d
        
        # Compute f(g(x))
        composition = f_expr.subs(x, g_expr)
        ans = expand(composition)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $f(g(x))$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/function_composition",
            solution=steps(
                f"To find $f(g(x))$, substitute $g(x)$ into $f(x)$",
                f"$f(g(x)) = f({latex(g_expr)})$",
                f"$= {latex(a)}({latex(g_expr)}) + {latex(b)}$",
                f"$= {latex(expand(a*g_expr))} + {latex(b)}$",
                f"$= {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Evaluate composition at a point (1000-1150)
        # f(x) = ax + b, g(x) = cx + d, find f(g(k)) for specific k
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        c = nonzero(-5, 5)
        d = nonzero(-8, 8)
        k_val = nonzero(-5, 5)
        
        f_expr = a*x + b
        g_expr = c*x + d
        
        # First compute g(k)
        g_at_k = g_expr.subs(x, k_val)
        # Then compute f(g(k))
        ans = f_expr.subs(x, g_at_k)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $f(g({k_val}))$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="precalculus/function_composition",
            solution=steps(
                f"First find $g({k_val})$:",
                f"$g({k_val}) = {latex(c)}({k_val}) + {latex(d)} = {latex(g_at_k)}$",
                f"Now find $f(g({k_val})) = f({latex(g_at_k)})$:",
                f"$f({latex(g_at_k)}) = {latex(a)}({latex(g_at_k)}) + {latex(b)}$",
                f"$= {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Simple composition with quadratic (1100-1250)
        # f(x) = x^2, g(x) = ax + b, find f(g(x))
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        
        f_expr = x**2
        g_expr = a*x + b
        
        # Compute f(g(x))
        composition = f_expr.subs(x, g_expr)
        ans = expand(composition)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $f(g(x))$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="precalculus/function_composition",
            solution=steps(
                f"To find $f(g(x))$, substitute $g(x)$ into $f(x)$",
                f"$f(g(x)) = f({latex(g_expr)})$",
                f"$= ({latex(g_expr)})^2$",
                f"$= {latex(ans)}$"
            ),
        )
    
    else:
        # Type 4: Reverse composition g(f(x)) with simple functions (1150-1300)
        # f(x) = ax + b, g(x) = x^2, find g(f(x))
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        
        f_expr = a*x + b
        g_expr = x**2
        
        # Compute g(f(x))
        composition = g_expr.subs(x, f_expr)
        ans = expand(composition)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $g(f(x))$.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="precalculus/function_composition",
            solution=steps(
                f"To find $g(f(x))$, substitute $f(x)$ into $g(x)$",
                f"$g(f(x)) = g({latex(f_expr)})$",
                f"$= ({latex(f_expr)})^2$",
                f"$= {latex(ans)}$"
            ),
        )

emit(generate())