"""
precalculus - inverse_functions (hard)
Generated: 2026-02-22T04:39:55.548503
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Composition of inverses with rational functions
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        # f(x) = (ax + b) / (x + c), ensure it has an inverse
        f_expr = (a*x + b) / (x + c)
        
        # Find inverse by solving y = f(x) for x
        y_sym = symbols('y')
        eq = Eq(y_sym, (a*x + b) / (x + c))
        inv_solutions = solve(eq, x)
        f_inv = inv_solutions[0].subs(y_sym, x)
        
        # Pick a value to evaluate f^{-1}(f(value))
        val = nonzero(-3, 3)
        while val == -c:  # avoid domain issues
            val = nonzero(-3, 3)
        
        ans = val
        
        return problem(
            question=f"Let $f(x) = \\frac{{{latex(a*x + b)}}}{{{latex(x + c)}}}$. Find $f^{{-1}}(f({val}))$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"By the property of inverse functions, $f^{{-1}}(f(x)) = x$ for all $x$ in the domain of $f$.",
                f"Check that ${val}$ is in the domain: $x \\neq {-c}$, and ${val} \\neq {-c}$.",
                f"Therefore, $f^{{-1}}(f({val})) = {val}$."
            )
        )
    
    elif problem_type == 2:
        # Find inverse of a more complex function
        a = nonzero(-3, 3)
        b = nonzero(1, 4)
        c = nonzero(-5, 5)
        
        # f(x) = a*sqrt(x - b) + c, x >= b
        f_expr = a*sqrt(x - b) + c
        
        # To find inverse: y = a*sqrt(x - b) + c
        # y - c = a*sqrt(x - b)
        # (y - c)/a = sqrt(x - b)
        # ((y - c)/a)^2 = x - b
        # x = ((y - c)/a)^2 + b
        
        y_sym = symbols('y')
        inv_expr = ((y_sym - c)/a)**2 + b
        ans = inv_expr.subs(y_sym, x)
        
        domain_restriction = f"x \\geq {c}" if a > 0 else f"x \\leq {c}"
        
        return problem(
            question=f"Find the inverse function $f^{{-1}}(x)$ of $f(x) = {latex(f_expr)}$ where $x \\geq {b}$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"Start with $y = {latex(f_expr)}$",
                f"Solve for $x$: $y - {c} = {latex(a*sqrt(x - b))}$",
                f"$\\frac{{y - {c}}}{{{a}}} = {latex(sqrt(x - b))}$",
                f"$\\left(\\frac{{y - {c}}}{{{a}}}\\right)^2 = x - {b}$",
                f"$x = \\left(\\frac{{y - {c}}}{{{a}}}\\right)^2 + {b}$",
                f"Replace $y$ with $x$: $f^{{-1}}(x) = {latex(ans)}$",
                f"Domain of $f^{{-1}}$: ${domain_restriction}$"
            )
        )
    
    elif problem_type == 3:
        # Verify if two functions are inverses by composition
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # f(x) = ax + b, g(x) = (x - b)/a
        f_expr = a*x + b
        g_expr = (x - b)/a
        
        # Check f(g(x))
        fog = simplify(f_expr.subs(x, g_expr))
        gof = simplify(g_expr.subs(x, f_expr))
        
        ans = True
        
        return problem(
            question=f"Verify whether $f(x) = {latex(f_expr)}$ and $g(x) = {latex(g_expr)}$ are inverse functions by showing that $f(g(x)) = x$ and $g(f(x)) = x$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"Compute $f(g(x))$:",
                f"$f(g(x)) = f\\left({latex(g_expr)}\\right) = {latex(a)}\\left({latex(g_expr)}\\right) + {b}$",
                f"$= {latex(simplify(a*g_expr))} + {b} = {latex(fog)}$",
                f"Compute $g(f(x))$:",
                f"$g(f(x)) = g({latex(f_expr)}) = \\frac{{({latex(f_expr)}) - {b}}}{{{a}}}$",
                f"$= \\frac{{{latex(simplify(f_expr - b))}}}{{{a}}} = {latex(gof)}$",
                f"Since both compositions equal $x$, the functions are inverses."
            ),
            answer_type="boolean"
        )
    
    elif problem_type == 4:
        # Find value given restricted inverse
        a = randint(2, 4)
        b = nonzero(-3, 3)
        
        # f(x) = (x + b)^a for x >= -b
        # f^{-1}(x) = x^(1/a) - b
        
        # Find f^{-1}(k) for some value k
        base = randint(1, 3)
        k = base**a
        
        ans = base - b
        
        return problem(
            question=f"Let $f(x) = (x + {b})^{a}$ for $x \\geq {-b}$. Find $f^{{-1}}({k})$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"To find $f^{{-1}}({k})$, we need to solve $f(x) = {k}$",
                f"$(x + {b})^{a} = {k}$",
                f"$x + {b} = \\sqrt[{a}]{{{k}}} = {base}$",
                f"$x = {base} - {b} = {ans}$",
                f"Therefore, $f^{{-1}}({k}) = {ans}$"
            )
        )
    
    else:
        # Find inverse of exponential/logarithmic composition
        a = randint(2, 5)
        b = nonzero(-4, 4)
        
        # f(x) = a^(x + b)
        # To find inverse: y = a^(x + b)
        # log_a(y) = x + b
        # x = log_a(y) - b
        
        f_expr = a**(x + b)
        ans = log(x, a) - b
        
        return problem(
            question=f"Find the inverse function $f^{{-1}}(x)$ of $f(x) = {a}^{{x + {b}}}$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="precalculus/inverse_functions",
            solution=steps(
                f"Start with $y = {a}^{{x + {b}}}$",
                f"Take $\\log_{{{a}}}$ of both sides: $\\log_{{{a}}}(y) = x + {b}$",
                f"Solve for $x$: $x = \\log_{{{a}}}(y) - {b}$",
                f"Replace $y$ with $x$: $f^{{-1}}(x) = \\log_{{{a}}}(x) - {b}$"
            )
        )

emit(generate())