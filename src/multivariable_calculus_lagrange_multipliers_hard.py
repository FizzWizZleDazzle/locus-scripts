"""
multivariable_calculus - lagrange_multipliers (hard)
Generated: 2026-02-22T05:38:35.453285
"""

from problem_utils import *

def generate():
    problem_type = choice(['optimize_constraint', 'optimize_two_constraints', 'conditional_extrema'])
    
    if problem_type == 'optimize_constraint':
        # Find extrema of f(x,y) subject to g(x,y) = c
        # Choose a problem where the answer is clean
        
        variant = choice(['sum_of_squares', 'product', 'distance'])
        
        if variant == 'sum_of_squares':
            # Minimize x^2 + y^2 subject to ax + by = c
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            c_val = nonzero(-5, 5)
            
            f_expr = x**2 + y**2
            g_expr = a_val*x + b_val*y - c_val
            
            # Using Lagrange: ∇f = λ∇g
            # 2x = λa, 2y = λb, ax + by = c
            # x = λa/2, y = λb/2
            # a(λa/2) + b(λb/2) = c
            # λ(a^2 + b^2)/2 = c
            # λ = 2c/(a^2 + b^2)
            lambda_val = Rational(2*c_val, a_val**2 + b_val**2)
            x_val = lambda_val * a_val / 2
            y_val = lambda_val * b_val / 2
            ans_val = x_val**2 + y_val**2
            
            return problem(
                question=f"Find the minimum value of $f(x,y) = {latex(f_expr)}$ subject to the constraint ${latex(a_val*x + b_val*y)} = {c_val}$ using Lagrange multipliers.",
                answer=ans_val,
                difficulty=(1600, 1750),
                topic="multivariable_calculus/lagrange_multipliers",
                solution=steps(
                    f"Set up the Lagrangian: $\\mathcal{{L}}(x,y,\\lambda) = {latex(f_expr)} - \\lambda({latex(g_expr)})$",
                    f"Find partial derivatives: $\\frac{{\\partial \\mathcal{{L}}}}{{\\partial x}} = 2x - {a_val}\\lambda = 0$",
                    f"$\\frac{{\\partial \\mathcal{{L}}}}{{\\partial y}} = 2y - {b_val}\\lambda = 0$",
                    f"$\\frac{{\\partial \\mathcal{{L}}}}{{\\partial \\lambda}} = -({latex(a_val*x + b_val*y - c_val)}) = 0$",
                    f"From first two equations: $x = \\frac{{{a_val}\\lambda}}{{2}}$, $y = \\frac{{{b_val}\\lambda}}{{2}}$",
                    f"Substitute into constraint: ${a_val} \\cdot \\frac{{{a_val}\\lambda}}{{2}} + {b_val} \\cdot \\frac{{{b_val}\\lambda}}{{2}} = {c_val}$",
                    f"Solve: $\\lambda = {latex(lambda_val)}$",
                    f"Therefore: $x = {latex(x_val)}$, $y = {latex(y_val)}$",
                    f"Minimum value: $f({latex(x_val)}, {latex(y_val)}) = {latex(ans_val)}$"
                ),
                calculator="scientific"
            )
            
        elif variant == 'product':
            # Maximize xy subject to x + y = c (or similar)
            c_val = randint(4, 10)
            
            f_expr = x * y
            g_expr = x + y - c_val
            
            # ∇f = λ∇g: y = λ, x = λ, x + y = c
            # x = y, 2x = c, so x = y = c/2
            x_val = Rational(c_val, 2)
            y_val = Rational(c_val, 2)
            ans_val = x_val * y_val
            
            return problem(
                question=f"Find the maximum value of $f(x,y) = xy$ subject to the constraint $x + y = {c_val}$ using Lagrange multipliers.",
                answer=ans_val,
                difficulty=(1600, 1700),
                topic="multivariable_calculus/lagrange_multipliers",
                solution=steps(
                    f"Set up $\\nabla f = \\lambda \\nabla g$ where $g(x,y) = x + y - {c_val}$",
                    f"$\\nabla f = (y, x)$ and $\\nabla g = (1, 1)$",
                    f"This gives: $y = \\lambda$ and $x = \\lambda$",
                    f"Therefore $x = y$",
                    f"Substitute into constraint: $x + x = {c_val}$, so $x = {latex(x_val)}$",
                    f"Thus $y = {latex(y_val)}$",
                    f"Maximum value: $f({latex(x_val)}, {latex(y_val)}) = {latex(ans_val)}$"
                ),
                calculator="scientific"
            )
            
        else:  # distance
            # Minimize distance from origin to ellipse or curve
            a_val = randint(2, 4)
            b_val = randint(2, 4)
            c_val = randint(3, 8)
            
            # Minimize x^2 + y^2 subject to x^2/a^2 + y^2/b^2 = 1
            f_expr = x**2 + y**2
            g_expr = x**2/a_val**2 + y**2/b_val**2 - 1
            
            # ∇f = λ∇g: (2x, 2y) = λ(2x/a^2, 2y/b^2)
            # x = λx/a^2, y = λy/b^2
            # If x ≠ 0: λ = a^2, If y ≠ 0: λ = b^2
            # Minimum distance at (0, ±b) if b < a, or (±a, 0) if a < b
            if a_val < b_val:
                ans_val = a_val**2
            else:
                ans_val = b_val**2
            
            return problem(
                question=f"Find the minimum value of $f(x,y) = x^2 + y^2$ subject to the constraint $\\frac{{x^2}}{{{a_val**2}}} + \\frac{{y^2}}{{{b_val**2}}} = 1$ using Lagrange multipliers.",
                answer=ans_val,
                difficulty=(1700, 1850),
                topic="multivariable_calculus/lagrange_multipliers",
                solution=steps(
                    f"Set up $\\nabla f = \\lambda \\nabla g$ where $g(x,y) = \\frac{{x^2}}{{{a_val**2}}} + \\frac{{y^2}}{{{b_val**2}}} - 1$",
                    f"$(2x, 2y) = \\lambda\\left(\\frac{{2x}}{{{a_val**2}}}, \\frac{{2y}}{{{b_val**2}}}\\right)$",
                    f"This gives: $x = \\frac{{\\lambda x}}{{{a_val**2}}}$ and $y = \\frac{{\\lambda y}}{{{b_val**2}}}$",
                    f"If $x \\neq 0$: $\\lambda = {a_val**2}$. If $y \\neq 0$: $\\lambda = {b_val**2}$",
                    f"Critical points occur at $({{'±'+str(a_val)}}, 0)$ and $(0, {{'±'+str(b_val)}})$",
                    f"Evaluating $f$: at $(±{a_val}, 0)$: $f = {a_val**2}$; at $(0, ±{b_val})$: $f = {b_val**2}$",
                    f"Minimum value: ${ans_val}$"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 'optimize_two_constraints':
        # Optimize with two constraints (harder)
        # Maximize x + y + z subject to x^2 + y^2 = 1 and x + z = 1
        
        f_expr = x + y + z
        # From x + z = 1, we get z = 1 - x
        # So maximize x + y + (1-x) = 1 + y subject to x^2 + y^2 = 1
        # Max when y = 1, giving f = 2
        
        ans_val = 2
        
        return problem(
            question=f"Find the maximum value of $f(x,y,z) = x + y + z$ subject to the constraints $x^2 + y^2 = 1$ and $x + z = 1$ using Lagrange multipliers.",
            answer=ans_val,
            difficulty=(1750, 1900),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"Set up $\\nabla f = \\lambda_1 \\nabla g_1 + \\lambda_2 \\nabla g_2$ where $g_1 = x^2 + y^2 - 1$ and $g_2 = x + z - 1$",
                f"$(1, 1, 1) = \\lambda_1(2x, 2y, 0) + \\lambda_2(1, 0, 1)$",
                f"This gives: $1 = 2\\lambda_1 x + \\lambda_2$, $1 = 2\\lambda_1 y$, $1 = \\lambda_2$",
                f"From third equation: $\\lambda_2 = 1$",
                f"From second equation: $\\lambda_1 = \\frac{1}{2y}$",
                f"From first equation: $1 = 2\\cdot\\frac{1}{2y}\\cdot x + 1$, so $x = 0$",
                f"From $x^2 + y^2 = 1$ with $x = 0$: $y = ±1$",
                f"From $x + z = 1$ with $x = 0$: $z = 1$",
                f"At $(0, 1, 1)$: $f = 0 + 1 + 1 = 2$. At $(0, -1, 1)$: $f = 0$",
                f"Maximum value: $2$"
            ),
            calculator="scientific"
        )
    
    else:  # conditional_extrema
        # Find all critical points and classify
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        c_val = randint(2, 6)
        
        # Minimize x^2 + y^2 subject to (x-a)^2 + (y-b)^2 = c^2
        # Closest point on circle to origin
        dist_to_center = sqrt(a_val**2 + b_val**2)
        
        # Closest point is at distance |r - d| from origin where r = c, d = dist to center
        if c_val < float(dist_to_center):
            min_dist_sq = (float(dist_to_center) - c_val)**2
        else:
            min_dist_sq = (c_val - float(dist_to_center))**2
        
        # Compute exact answer
        x_closest = a_val * (1 - Rational(c_val, dist_to_center))
        y_closest = b_val * (1 - Rational(c_val, dist_to_center))
        ans_val = simplify(x_closest**2 + y_closest**2)
        
        return problem(
            question=f"Find the minimum value of $f(x,y) = x^2 + y^2$ subject to the constraint $(x - {a_val})^2 + (y - {b_val})^2 = {c_val**2}$ using Lagrange multipliers.",
            answer=ans_val,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/lagrange_multipliers",
            solution=steps(
                f"The constraint is a circle centered at $({a_val}, {b_val})$ with radius ${c_val}$",
                f"Set up $\\nabla f = \\lambda \\nabla g$ where $g(x,y) = (x-{a_val})^2 + (y-{b_val})^2 - {c_val**2}$",
                f"$(2x, 2y) = \\lambda(2(x-{a_val}), 2(y-{b_val}))$",
                f"This gives: $x = \\lambda(x - {a_val})$ and $y = \\lambda(y - {b_val})$",
                f"Solving: $x(1-\\lambda) = -{a_val}\\lambda$ and $y(1-\\lambda) = -{b_val}\\lambda$",
                f"The minimum distance from origin to circle is along the line from origin to center",
                f"Distance from origin to center: $\\sqrt{{{a_val}^2 + {b_val}^2}} = {latex(dist_to_center)}$",
                f"Closest point on circle to origin is at distance ${latex(dist_to_center)} - {c_val} = {latex(dist_to_center - c_val)}$",
                f"Minimum value: ${latex(ans_val)}$"
            ),
            calculator="scientific"
        )

emit(generate())