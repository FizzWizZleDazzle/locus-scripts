"""
precalculus - transformations (hard)
Generated: 2026-02-22T04:41:14.707744
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Composition of transformations
        h1 = nonzero(-4, 4)
        k1 = nonzero(-4, 4)
        h2 = nonzero(-4, 4)
        k2 = nonzero(-4, 4)
        a = choice([-2, -1, 2, 3])
        
        base_funcs = [sin(x), cos(x), sqrt(x), x**2, abs(x)]
        f = choice(base_funcs)
        
        # Apply two transformations
        transformed = a * f.subs(x, x - h1) + k1
        final = transformed.subs(x, x - h2) + k2
        
        # Calculate combined shifts
        total_h = h1 + h2
        total_k = k1 + k2
        
        ans = a * f.subs(x, x - total_h) + total_k
        
        return problem(
            question=f"Let $g(x) = {latex(transformed)}$. Find the expression for $h(x) = g(x - {h2}) + {k2}$ in simplified form.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="precalculus/transformations",
            solution=steps(
                f"Start with $g(x) = {latex(transformed)}$",
                f"Substitute $(x - {h2})$ for $x$: $g(x - {h2}) = {latex(a * f.subs(x, (x - h2) - h1) + k1)}$",
                f"Simplify the argument: $g(x - {h2}) = {latex(a * f.subs(x, x - total_h) + k1)}$",
                f"Add ${k2}$: $h(x) = {latex(a * f.subs(x, x - total_h) + k1)} + {k2}$",
                f"Combine constants: $h(x) = {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Finding parameters from transformation description
        a = choice([-3, -2, 2, 3])
        h = nonzero(-5, 5)
        k = nonzero(-5, 5)
        
        base_options = [(x**2, "x^2"), (sqrt(x), "\\sqrt{x}"), (abs(x), "|x|")]
        base_func, base_latex = choice(base_options)
        
        transformed = a * base_func.subs(x, x - h) + k
        
        # Ask for one parameter
        param_choice = randint(1, 3)
        if param_choice == 1:
            ans = a
            unknown = "a"
            known = f"h = {h}, k = {k}"
        elif param_choice == 2:
            ans = h
            unknown = "h"
            known = f"a = {a}, k = {k}"
        else:
            ans = k
            unknown = "k"
            known = f"a = {a}, h = {h}"
        
        return problem(
            question=f"The function $f(x) = {base_latex}$ is transformed to $g(x) = a f(x - h) + k = {latex(transformed)}$. Given {known}, find ${unknown}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/transformations",
            solution=steps(
                f"The general form is $g(x) = a f(x - h) + k = a {base_latex.replace('x', '(x-h)')} + k$",
                f"Comparing with ${latex(transformed)}$, we identify the parameters",
                f"${unknown} = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Reflection and scaling combined
        a = choice([-3, -2, 2, 3])
        h = nonzero(-4, 4)
        k = nonzero(-4, 4)
        
        # Choose base function
        base_options = [(x**2, "x^2", "quadratic"), (x**3, "x^3", "cubic"), (sqrt(x), "\\sqrt{x}", "square root")]
        base_func, base_latex, func_name = choice(base_options)
        
        # Reflection over x-axis or y-axis
        if randint(0, 1) == 0:
            # Reflection over x-axis: -f(x)
            reflected = -base_func
            reflection_type = "x-axis"
            transformed = a * reflected.subs(x, x - h) + k
        else:
            # Reflection over y-axis: f(-x)
            reflected = base_func.subs(x, -x)
            reflection_type = "y-axis"
            transformed = a * reflected.subs(x, x - h) + k
        
        ans = transformed
        
        if reflection_type == "x-axis":
            return problem(
                question=f"The {func_name} function $f(x) = {base_latex}$ is reflected over the x-axis, vertically stretched by a factor of ${abs(a)}$, shifted right by ${h}$ units, and shifted {'up' if k > 0 else 'down'} by ${abs(k)}$ units. Find the resulting function.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/transformations",
                solution=steps(
                    f"Start with $f(x) = {base_latex}$",
                    f"Reflect over x-axis: $-f(x) = -{base_latex}$",
                    f"Vertical stretch by ${abs(a)}$: ${latex(a * reflected)}$",
                    f"Shift right by ${h}$: ${latex(a * reflected.subs(x, x - h))}$",
                    f"Shift {'up' if k > 0 else 'down'} by ${abs(k)}$: ${latex(ans)}$"
                )
            )
        else:
            return problem(
                question=f"The {func_name} function $f(x) = {base_latex}$ is reflected over the y-axis, vertically stretched by a factor of ${abs(a)}$, shifted right by ${h}$ units, and shifted {'up' if k > 0 else 'down'} by ${abs(k)}$ units. Find the resulting function.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/transformations",
                solution=steps(
                    f"Start with $f(x) = {base_latex}$",
                    f"Reflect over y-axis: $f(-x) = {latex(reflected)}$",
                    f"Vertical stretch by ${abs(a)}$: ${latex(a * reflected)}$",
                    f"Shift right by ${h}$: ${latex(a * reflected.subs(x, x - h))}$",
                    f"Shift {'up' if k > 0 else 'down'} by ${abs(k)}$: ${latex(ans)}$"
                )
            )
    
    elif problem_type == 4:
        # Horizontal stretch/compression
        b = choice([2, 3, Rational(1, 2), Rational(1, 3)])
        h = nonzero(-4, 4)
        k = nonzero(-4, 4)
        
        base_options = [(sin(x), "\\sin(x)"), (cos(x), "\\cos(x)"), (x**2, "x^2")]
        base_func, base_latex = choice(base_options)
        
        # Horizontal transformation: f(b(x-h)) + k
        transformed = base_func.subs(x, b * (x - h)) + k
        
        if b > 1:
            factor_desc = f"compressed horizontally by a factor of ${latex(b)}$"
        else:
            factor_desc = f"stretched horizontally by a factor of ${latex(1/b)}$"
        
        ans = transformed
        
        return problem(
            question=f"The function $f(x) = {base_latex}$ is {factor_desc}, shifted right by ${h}$ units, and shifted {'up' if k > 0 else 'down'} by ${abs(k)}$ units. Find the resulting function $g(x)$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="precalculus/transformations",
            solution=steps(
                f"Start with $f(x) = {base_latex}$",
                f"Horizontal {'compression' if b > 1 else 'stretch'}: $f({latex(b)}x) = {latex(base_func.subs(x, b*x))}$",
                f"Shift right by ${h}$: $f({latex(b)}(x - {h})) = {latex(base_func.subs(x, b*(x-h)))}$",
                f"Shift {'up' if k > 0 else 'down'} by ${abs(k)}$: $g(x) = {latex(ans)}$"
            )
        )
    
    else:
        # Inverse of transformation
        a = choice([-2, 2, 3])
        h = nonzero(-4, 4)
        k = nonzero(-4, 4)
        
        base_func = x**3
        transformed = a * (x - h)**3 + k
        
        # To find inverse: solve y = a(x-h)^3 + k for x
        y_sym = symbols('y')
        equation = Eq(y_sym, transformed)
        x_solution = solve(equation, x)[0]
        
        ans = x_solution
        
        return problem(
            question=f"Find the inverse function of $f(x) = {latex(transformed)}$. Express your answer as a function of $x$.",
            answer=ans.subs(y_sym, x),
            difficulty=(1750, 1900),
            topic="precalculus/transformations",
            solution=steps(
                f"Let $y = {latex(transformed)}$",
                f"Solve for $x$: $y - {k} = {a}(x - {h})^3$",
                f"$\\frac{{y - {k}}}{{{a}}} = (x - {h})^3$",
                f"$x - {h} = \\sqrt[3]{{\\frac{{y - {k}}}{{{a}}}}}$",
                f"$x = \\sqrt[3]{{\\frac{{y - {k}}}{{{a}}}}} + {h}$",
                f"Replace $y$ with $x$: $f^{{-1}}(x) = {latex(ans.subs(y_sym, x))}$"
            )
        )

emit(generate())