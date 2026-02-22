"""
precalculus - inverse_functions (medium)
Generated: 2026-02-22T04:39:25.391172
"""

from problem_utils import *

def generate():
    problem_type = choice(['verify_inverse', 'find_inverse', 'composition_check', 'evaluate_inverse'])
    
    if problem_type == 'verify_inverse':
        # Given two functions, verify they are inverses by checking f(g(x)) = x
        func_type = choice(['linear', 'rational', 'radical'])
        
        if func_type == 'linear':
            # f(x) = ax + b, g(x) = (x - b)/a
            a_val = nonzero(-5, 5)
            b_val = nonzero(-8, 8)
            f_expr = a_val * x + b_val
            g_expr = (x - b_val) / a_val
            
            composition = simplify(f_expr.subs(x, g_expr))
            ans = Eq(composition, x)
            
            return problem(
                question=f"Verify that $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$ are inverse functions by showing $f(g(x)) = x$.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/inverse_functions",
                solution=steps(
                    f"Compute $f(g(x))$ by substituting $g(x)$ into $f(x)$",
                    f"$f(g(x)) = {latex(a_val)}\\left({latex(g_expr)}\\right) + {latex(b_val)}$",
                    f"$= {latex(a_val)} \\cdot \\frac{{x - {b_val}}}{{{a_val}}} + {b_val}$",
                    f"$= x - {b_val} + {b_val}$",
                    f"$= x$",
                    "Therefore, $f$ and $g$ are inverse functions."
                ),
            )
        
        elif func_type == 'rational':
            # f(x) = (x + a)/(x + b), find its inverse
            a_val = nonzero(-6, 6)
            b_val = nonzero(-6, 6)
            while abs(a_val - b_val) < 2:
                b_val = nonzero(-6, 6)
            
            f_expr = (x + a_val) / (x + b_val)
            # Inverse: g(x) = (bx - a)/(1 - x)
            g_expr = (b_val * x - a_val) / (1 - x)
            
            composition = simplify(f_expr.subs(x, g_expr))
            ans = Eq(composition, x)
            
            return problem(
                question=f"Verify that $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$ are inverse functions by showing $f(g(x)) = x$.",
                answer=ans,
                difficulty=(1500, 1600),
                topic="precalculus/inverse_functions",
                solution=steps(
                    f"Compute $f(g(x))$ by substituting $g(x)$ into $f(x)$",
                    f"$f(g(x)) = \\frac{{{latex(g_expr)} + {a_val}}}{{{latex(g_expr)} + {b_val}}}$",
                    f"$= \\frac{{\\frac{{{b_val}x - {a_val}}}{{1 - x}} + {a_val}}}{{\\frac{{{b_val}x - {a_val}}}{{1 - x}} + {b_val}}}$",
                    f"Multiply numerator and denominator by $(1 - x)$",
                    f"$= \\frac{{{b_val}x - {a_val} + {a_val}(1 - x)}}{{{b_val}x - {a_val} + {b_val}(1 - x)}}$",
                    f"$= \\frac{{{b_val}x - {a_val} + {a_val} - {a_val}x}}{{{b_val}x - {a_val} + {b_val} - {b_val}x}}$",
                    f"$= \\frac{{x({b_val} - {a_val})}}{{{b_val - a_val}}} = x$",
                    "Therefore, $f$ and $g$ are inverse functions."
                ),
            )
    
    elif problem_type == 'find_inverse':
        # Find the inverse of a given function
        func_type = choice(['linear', 'cube_root', 'rational_simple'])
        
        if func_type == 'linear':
            a_val = nonzero(-5, 5)
            b_val = nonzero(-8, 8)
            f_expr = a_val * x + b_val
            ans = (x - b_val) / a_val
            
            return problem(
                question=f"Find the inverse function $f^{{-1}}(x)$ if $f(x) = {latex(f_expr)}$.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="precalculus/inverse_functions",
                solution=steps(
                    f"Let $y = {latex(f_expr)}$",
                    f"Solve for $x$: $y - {b_val} = {a_val}x$",
                    f"$x = \\frac{{y - {b_val}}}{{{a_val}}}$",
                    f"Replace $y$ with $x$ to get $f^{{-1}}(x) = {latex(ans)}$"
                ),
            )
        
        elif func_type == 'cube_root':
            a_val = nonzero(-4, 4)
            b_val = nonzero(-6, 6)
            f_expr = a_val * x**3 + b_val
            ans = ((x - b_val) / a_val)**Rational(1, 3)
            
            return problem(
                question=f"Find the inverse function $f^{{-1}}(x)$ if $f(x) = {latex(f_expr)}$.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/inverse_functions",
                solution=steps(
                    f"Let $y = {latex(f_expr)}$",
                    f"Solve for $x$: $y - {b_val} = {a_val}x^3$",
                    f"$x^3 = \\frac{{y - {b_val}}}{{{a_val}}}$",
                    f"$x = \\sqrt[3]{{\\frac{{y - {b_val}}}{{{a_val}}}}}$",
                    f"Replace $y$ with $x$ to get $f^{{-1}}(x) = {latex(ans)}$"
                ),
            )
        
        elif func_type == 'rational_simple':
            a_val = nonzero(-5, 5)
            b_val = nonzero(-8, 8)
            c_val = nonzero(-5, 5)
            while c_val == a_val:
                c_val = nonzero(-5, 5)
            
            f_expr = (a_val * x + b_val) / c_val
            ans = (c_val * x - b_val) / a_val
            
            return problem(
                question=f"Find the inverse function $f^{{-1}}(x)$ if $f(x) = {latex(f_expr)}$.",
                answer=ans,
                difficulty=(1400, 1500),
                topic="precalculus/inverse_functions",
                solution=steps(
                    f"Let $y = {latex(f_expr)}$",
                    f"Solve for $x$: ${c_val}y = {a_val}x + {b_val}$",
                    f"${a_val}x = {c_val}y - {b_val}$",
                    f"$x = \\frac{{{c_val}y - {b_val}}}{{{a_val}}}$",
                    f"Replace $y$ with $x$ to get $f^{{-1}}(x) = {latex(ans)}$"
                ),
            )
    
    elif problem_type == 'composition_check':
        # Given f and f^(-1), compute f^(-1)(f(a)) for some value
        a_val = nonzero(-4, 4)
        b_val = nonzero(-6, 6)
        test_val = nonzero(-5, 5)
        
        f_expr = a_val * x + b_val
        ans = test_val
        
        return problem(
            question=f"If $f(x) = {latex(f_expr)}$, find $f^{{-1}}(f({test_val}))$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"By the definition of inverse functions, $f^{{-1}}(f(x)) = x$ for all $x$ in the domain of $f$",
                f"Therefore, $f^{{-1}}(f({test_val})) = {test_val}$"
            ),
        )
    
    else:  # evaluate_inverse
        # Evaluate the inverse at a specific point
        a_val = nonzero(-4, 4)
        b_val = nonzero(-8, 8)
        
        f_expr = a_val * x + b_val
        test_val = nonzero(-10, 10)
        
        ans = (test_val - b_val) / a_val
        
        return problem(
            question=f"If $f(x) = {latex(f_expr)}$, find $f^{{-1}}({test_val})$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"First find $f^{{-1}}(x)$. Let $y = {latex(f_expr)}$",
                f"Solve for $x$: $y - {b_val} = {a_val}x$",
                f"$x = \\frac{{y - {b_val}}}{{{a_val}}}$",
                f"So $f^{{-1}}(x) = \\frac{{x - {b_val}}}{{{a_val}}}$",
                f"Now evaluate: $f^{{-1}}({test_val}) = \\frac{{{test_val} - {b_val}}}{{{a_val}}} = {latex(ans)}$"
            ),
        )

emit(generate())