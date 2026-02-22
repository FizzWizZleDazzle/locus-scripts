"""
precalculus - function_composition (hard)
Generated: 2026-02-22T04:38:27.619215
"""

from problem_utils import *

def generate():
    problem_type = choice(['nested_evaluate', 'nested_solve', 'decompose', 'inverse_composition', 'multi_composition'])
    
    if problem_type == 'nested_evaluate':
        # Given f(x) and g(x), find f(g(a)) for specific value a
        # ELO: 1600-1700
        a_coeff = nonzero(-3, 3)
        b_const = nonzero(-5, 5)
        c_coeff = nonzero(-4, 4)
        d_const = nonzero(-6, 6)
        
        # f(x) = a*x + b, g(x) = c*x^2 + d
        f_expr = a_coeff * x + b_const
        g_expr = c_coeff * x**2 + d_const
        
        eval_point = nonzero(-3, 3)
        
        # Calculate g(eval_point)
        g_val = g_expr.subs(x, eval_point)
        # Calculate f(g(eval_point))
        ans = f_expr.subs(x, g_val)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $f(g({eval_point}))$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/function_composition",
            solution=steps(
                f"First evaluate $g({eval_point})$:",
                f"$g({eval_point}) = {latex(c_coeff)}({eval_point})^2 + {latex(d_const)} = {latex(g_val)}$",
                f"Now evaluate $f({latex(g_val)})$:",
                f"$f({latex(g_val)}) = {latex(a_coeff)}({latex(g_val)}) + {latex(b_const)} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 'nested_solve':
        # Given f(x) and g(x), solve f(g(x)) = k for x
        # ELO: 1700-1800
        a_coeff = nonzero(-2, 2)
        b_const = nonzero(-4, 4)
        c_coeff = choice([1, 2])
        d_const = nonzero(-3, 3)
        
        # f(x) = a*x + b, g(x) = c*x + d
        f_expr = a_coeff * x + b_const
        g_expr = c_coeff * x + d_const
        
        # Compose f(g(x))
        fg_expr = f_expr.subs(x, g_expr)
        fg_simplified = simplify(fg_expr)
        
        # Pick a target value k
        target_k = nonzero(-10, 10)
        
        # Solve f(g(x)) = k
        solutions = solve(Eq(fg_simplified, target_k), x)
        ans = solutions[0]
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Solve $f(g(x)) = {target_k}$ for $x$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="precalculus/function_composition",
            solution=steps(
                f"First find $f(g(x))$:",
                f"$f(g(x)) = f({latex(g_expr)}) = {latex(a_coeff)}({latex(g_expr)}) + {latex(b_const)}$",
                f"$f(g(x)) = {latex(fg_simplified)}$",
                f"Now solve ${latex(fg_simplified)} = {target_k}$:",
                f"$x = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 'decompose':
        # Given h(x), find f and g such that h(x) = f(g(x))
        # ELO: 1750-1850
        inner_coeff = nonzero(-3, 3)
        inner_const = nonzero(-4, 4)
        outer_power = choice([2, 3])
        
        # h(x) = (inner_coeff*x + inner_const)^outer_power
        inner_expr = inner_coeff * x + inner_const
        h_expr = inner_expr**outer_power
        
        g_ans = inner_expr
        f_ans = x**outer_power
        
        return problem(
            question=f"Find functions $f(x)$ and $g(x)$ such that $f(g(x)) = {latex(expand(h_expr))}$ where $g(x)$ is linear. Express $g(x)$ in simplest form.",
            answer=g_ans,
            difficulty=(1750, 1850),
            topic="precalculus/function_composition",
            solution=steps(
                f"We need to decompose ${latex(expand(h_expr))}$ as a composition.",
                f"Notice that ${latex(expand(h_expr))} = ({latex(inner_expr)})^{outer_power}$",
                f"Let $g(x) = {latex(inner_expr)}$ and $f(x) = x^{outer_power}$",
                f"Then $f(g(x)) = ({latex(inner_expr)})^{outer_power} = {latex(expand(h_expr))}$",
                f"Therefore, $g(x) = {latex(g_ans)}$"
            ),
        )
    
    elif problem_type == 'inverse_composition':
        # Given f(x) and g(x), find f^(-1)(g(a))
        # ELO: 1800-1900
        a_coeff = nonzero(-3, 3)
        b_const = nonzero(-5, 5)
        c_coeff = choice([1, 2, 3])
        d_const = nonzero(-4, 4)
        
        # f(x) = a*x + b (invertible), g(x) = c*x + d
        f_expr = a_coeff * x + b_const
        g_expr = c_coeff * x + d_const
        
        # Find f^(-1)(x): solve y = a*x + b for x
        f_inv = solve(Eq(y, f_expr), x)[0]
        f_inv_expr = f_inv.subs(y, x)
        
        eval_point = nonzero(-2, 2)
        g_val = g_expr.subs(x, eval_point)
        ans = f_inv_expr.subs(x, g_val)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$. Find $f^{{-1}}(g({eval_point}))$.",
            answer=ans,
            difficulty=(1800, 1900),
            topic="precalculus/function_composition",
            solution=steps(
                f"First find $f^{{-1}}(x)$ by solving $y = {latex(f_expr)}$ for $x$:",
                f"$x = {latex(f_inv_expr)}$, so $f^{{-1}}(x) = {latex(f_inv_expr)}$",
                f"Next evaluate $g({eval_point})$:",
                f"$g({eval_point}) = {latex(g_val)}$",
                f"Finally, evaluate $f^{{-1}}({latex(g_val)})$:",
                f"$f^{{-1}}({latex(g_val)}) = {latex(ans)}$"
            ),
        )
    
    else:  # multi_composition
        # Given f(x), g(x), h(x), find f(g(h(a)))
        # ELO: 1650-1750
        a_coeff = nonzero(-2, 2)
        b_const = nonzero(-3, 3)
        c_const = nonzero(-4, 4)
        d_coeff = choice([1, 2])
        
        # f(x) = a*x + b, g(x) = x^2 + c, h(x) = d*x
        f_expr = a_coeff * x + b_const
        g_expr = x**2 + c_const
        h_expr = d_coeff * x
        
        eval_point = nonzero(-3, 3)
        
        h_val = h_expr.subs(x, eval_point)
        g_val = g_expr.subs(x, h_val)
        ans = f_expr.subs(x, g_val)
        
        return problem(
            question=f"Let $f(x) = {latex(f_expr)}$, $g(x) = {latex(g_expr)}$, and $h(x) = {latex(h_expr)}$. Find $f(g(h({eval_point})))$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="precalculus/function_composition",
            solution=steps(
                f"Evaluate from the inside out. First find $h({eval_point})$:",
                f"$h({eval_point}) = {latex(h_val)}$",
                f"Next find $g({latex(h_val)})$:",
                f"$g({latex(h_val)}) = ({latex(h_val)})^2 + {latex(c_const)} = {latex(g_val)}$",
                f"Finally find $f({latex(g_val)})$:",
                f"$f({latex(g_val)}) = {latex(a_coeff)}({latex(g_val)}) + {latex(b_const)} = {latex(ans)}$"
            ),
        )

emit(generate())