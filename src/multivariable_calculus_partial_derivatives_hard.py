"""
multivariable_calculus - partial_derivatives (hard)
Generated: 2026-02-22T05:34:28.324036
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Mixed partial derivatives with verification (Clairaut's theorem)
        func_type = choice(['poly', 'trig', 'exp'])
        
        if func_type == 'poly':
            a, b, c = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
            f = a * x**3 * y**2 + b * x**2 * y**3 + c * x * y
            
        elif func_type == 'trig':
            a, b = nonzero(-3, 3), nonzero(2, 4)
            f = a * sin(b * x * y)
            
        else:  # exp
            a, b, c = nonzero(-2, 2), nonzero(1, 3), nonzero(1, 3)
            f = a * exp(b * x + c * y)
        
        f_xy = diff(diff(f, x), y)
        f_yx = diff(diff(f, y), x)
        ans = simplify(f_xy)
        
        return problem(
            question=f"Find $\\frac{{\\partial^2 f}}{{\\partial x \\partial y}}$ for $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"First find $\\frac{{\\partial f}}{{\\partial x}} = {latex(diff(f, x))}$",
                f"Then differentiate with respect to $y$:",
                f"$\\frac{{\\partial^2 f}}{{\\partial x \\partial y}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Chain rule for multivariable functions
        a, b = nonzero(-3, 3), nonzero(-3, 3)
        m, n = nonzero(1, 3), nonzero(1, 3)
        
        # f(u,v) with u = u(t), v = v(t)
        u_func = m * t**2
        v_func = n * t
        f_expr = a * x**2 + b * y**2  # where x=u, y=v
        
        # Compute df/dt using chain rule
        f_u = 2 * a * x
        f_v = 2 * b * y
        du_dt = diff(u_func, t)
        dv_dt = diff(v_func, t)
        
        # Substitute u and v
        f_u_sub = f_u.subs(x, u_func)
        f_v_sub = f_v.subs(y, v_func)
        
        ans = simplify(f_u_sub * du_dt + f_v_sub * dv_dt)
        
        return problem(
            question=f"Let $f(u,v) = {latex(f_expr.subs([(x,u_func), (y,v_func)])}}$ where $u = {latex(u_func)}$ and $v = {latex(v_func)}$. Find $\\frac{{df}}{{dt}}$ using the chain rule.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Express $f$ in terms of $u$ and $v$: $f(u,v) = {latex(a)}u^2 + {latex(b)}v^2$",
                f"$\\frac{{\\partial f}}{{\\partial u}} = {latex(2*a)}u$, $\\frac{{\\partial f}}{{\\partial v}} = {latex(2*b)}v$",
                f"$\\frac{{du}}{{dt}} = {latex(du_dt)}$, $\\frac{{dv}}{{dt}} = {latex(dv_dt)}$",
                f"By chain rule: $\\frac{{df}}{{dt}} = \\frac{{\\partial f}}{{\\partial u}}\\frac{{du}}{{dt}} + \\frac{{\\partial f}}{{\\partial v}}\\frac{{dv}}{{dt}}$",
                f"Substituting: $\\frac{{df}}{{dt}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Directional derivative
        a, b, c = nonzero(-3, 3), nonzero(-3, 3), nonzero(1, 3)
        f = a * x**2 + b * y**2 + c * x * y
        
        x0, y0 = randint(-2, 2), randint(-2, 2)
        v1, v2 = nonzero(-3, 3), nonzero(-3, 3)
        
        # Normalize direction vector
        v_mag = sqrt(v1**2 + v2**2)
        
        # Gradient at point
        grad_x = diff(f, x).subs([(x, x0), (y, y0)])
        grad_y = diff(f, y).subs([(x, x0), (y, y0)])
        
        # Directional derivative (without normalizing for harder problem)
        ans = simplify((grad_x * v1 + grad_y * v2) / v_mag)
        
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ at the point $({x0}, {y0})$ in the direction of the vector $\\mathbf{{v}} = \\langle {v1}, {v2} \\rangle$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Find the gradient: $\\nabla f = \\langle {latex(diff(f,x))}, {latex(diff(f,y))} \\rangle$",
                f"At $({x0},{y0})$: $\\nabla f({x0},{y0}) = \\langle {latex(grad_x)}, {latex(grad_y)} \\rangle$",
                f"Normalize $\\mathbf{{v}}$: $\\mathbf{{u}} = \\frac{{1}}{{{latex(v_mag)}}}\\langle {v1}, {v2} \\rangle$",
                f"$D_{{\mathbf{{u}}}}f = \\nabla f \\cdot \\mathbf{{u}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Implicit differentiation with partial derivatives
        a, b, c = nonzero(-3, 3), nonzero(-3, 3), nonzero(1, 3)
        F = a * x**2 + b * y**2 + c * x * y - randint(1, 5)
        
        F_x = diff(F, x)
        F_y = diff(F, y)
        
        ans = simplify(-F_x / F_y)
        
        return problem(
            question=f"Use implicit differentiation to find $\\frac{{\\partial y}}{{\\partial x}}$ for the equation ${latex(F)} = 0$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"For $F(x,y) = {latex(F)} = 0$, use $\\frac{{\\partial y}}{{\\partial x}} = -\\frac{{F_x}}{{F_y}}$",
                f"$F_x = {latex(F_x)}$",
                f"$F_y = {latex(F_y)}$",
                f"Therefore: $\\frac{{\\partial y}}{{\\partial x}} = {latex(ans)}$"
            )
        )
    
    else:  # problem_type == 5
        # Higher order mixed partials
        a, b, c = nonzero(-2, 2), nonzero(-2, 2), nonzero(1, 2)
        f = a * x**3 * y**2 + b * x * y**3 + c * x**2 * y**2
        
        order_type = choice(['xxy', 'xyy', 'xyx'])
        
        if order_type == 'xxy':
            ans = diff(diff(diff(f, x), x), y)
            notation = "\\frac{\\partial^3 f}{\\partial y \\partial x^2}"
        elif order_type == 'xyy':
            ans = diff(diff(diff(f, x), y), y)
            notation = "\\frac{\\partial^3 f}{\\partial y^2 \\partial x}"
        else:  # xyx
            ans = diff(diff(diff(f, x), y), x)
            notation = "\\frac{\\partial^3 f}{\\partial x \\partial y \\partial x}"
        
        ans = simplify(ans)
        
        return problem(
            question=f"Find ${notation}$ for $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Compute the partial derivatives in order:",
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(diff(f, x))}$",
                f"Continue differentiating to get:",
                f"${notation} = {latex(ans)}$"
            )
        )

emit(generate())