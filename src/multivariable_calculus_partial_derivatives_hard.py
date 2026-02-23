"""
multivariable_calculus - partial_derivatives (hard)
Generated: 2026-02-22T05:34:28.324036
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Mixed partial f_xy
        func_type = choice(['poly', 'trig', 'exp'])
        if func_type == 'poly':
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            c = nonzero(-4, 4)
            xp = randint(2, 4)
            yp = randint(2, 4)
            f = a * x**xp * y**yp + b * x**2 * y + c * x * y**2
        elif func_type == 'trig':
            a = nonzero(-3, 3)
            b = nonzero(2, 5)
            f = a * sin(b * x * y)
        else:
            a = nonzero(-2, 2)
            b = nonzero(1, 4)
            c = nonzero(1, 4)
            f = a * exp(b * x + c * y)
        f_xy = simplify(diff(diff(f, x), y))
        return problem(
            question=f"Find $\\frac{{\\partial^2 f}}{{\\partial x \\partial y}}$ for $f(x,y) = {latex(f)}$",
            answer=f_xy,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(diff(f, x))}$",
                f"Differentiate with respect to $y$:",
                f"$\\frac{{\\partial^2 f}}{{\\partial x \\partial y}} = {latex(f_xy)}$"
            )
        )

    elif problem_type == 2:
        # Chain rule: f(u(t), v(t)), find df/dt
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        m = randint(1, 3)
        n = randint(1, 3)
        u_func = m * t**2
        v_func = n * t
        f_expr = a * x**2 + b * y**2
        f_u_sub = diff(f_expr, x).subs(x, u_func)
        f_v_sub = diff(f_expr, y).subs(y, v_func)
        du_dt = diff(u_func, t)
        dv_dt = diff(v_func, t)
        ans = simplify(f_u_sub * du_dt + f_v_sub * dv_dt)
        return problem(
            question=f"Let $f(u,v) = {latex(a)}u^2 + {latex(b)}v^2$ where $u = {latex(u_func)}$, $v = {latex(v_func)}$. Find $\\frac{{df}}{{dt}}$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"$\\frac{{\\partial f}}{{\\partial u}} = {latex(2*a)}u$, $\\frac{{\\partial f}}{{\\partial v}} = {latex(2*b)}v$",
                f"$\\frac{{du}}{{dt}} = {latex(du_dt)}$, $\\frac{{dv}}{{dt}} = {latex(dv_dt)}$",
                f"Chain rule: $\\frac{{df}}{{dt}} = \\frac{{\\partial f}}{{\\partial u}}\\frac{{du}}{{dt}} + \\frac{{\\partial f}}{{\\partial v}}\\frac{{dv}}{{dt}}$",
                f"$= {latex(ans)}$"
            )
        )

    elif problem_type == 3:
        # Directional derivative
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(1, 3)
        f = a * x**2 + b * y**2 + c * x * y
        x0 = randint(-2, 2)
        y0 = randint(-2, 2)
        v1 = choice([-3, -2, -1, 1, 2, 3])
        v2 = choice([-3, -2, -1, 1, 2, 3])
        v_mag = sqrt(v1**2 + v2**2)
        grad_x = diff(f, x).subs([(x, x0), (y, y0)])
        grad_y = diff(f, y).subs([(x, x0), (y, y0)])
        ans = simplify((grad_x * v1 + grad_y * v2) / v_mag)
        return problem(
            question=f"Find the directional derivative of $f(x,y) = {latex(f)}$ at $({x0},{y0})$ in direction $\\langle {v1}, {v2} \\rangle$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"Gradient: $\\nabla f = \\langle {latex(diff(f,x))}, {latex(diff(f,y))} \\rangle$",
                f"At $({x0},{y0})$: $\\nabla f = \\langle {latex(grad_x)}, {latex(grad_y)} \\rangle$",
                f"Unit vector: $\\mathbf{{u}} = \\frac{{1}}{{{latex(v_mag)}}}\\langle {v1}, {v2} \\rangle$",
                f"$D_\\mathbf{{u}}f = \\nabla f \\cdot \\mathbf{{u}} = {latex(ans)}$"
            )
        )

    elif problem_type == 4:
        # Implicit differentiation via partial derivatives: F(x,y) = 0
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(1, 3)
        const = randint(1, 8)
        F = a * x**2 + b * y**2 + c * x * y - const
        F_x = diff(F, x)
        F_y = diff(F, y)
        ans = simplify(-F_x / F_y)
        return problem(
            question=f"Use implicit differentiation to find $\\frac{{dy}}{{dx}}$ for ${latex(F)} = 0$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"$\\frac{{dy}}{{dx}} = -\\frac{{F_x}}{{F_y}}$",
                f"$F_x = {latex(F_x)}$",
                f"$F_y = {latex(F_y)}$",
                f"$\\frac{{dy}}{{dx}} = {latex(ans)}$"
            )
        )

    else:
        # Higher-order mixed partials
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(1, 2)
        xp = randint(3, 4)
        yp = randint(3, 4)
        f = a * x**xp * y**yp + b * x * y**3 + c * x**2 * y**2
        order_type = choice(['xxy', 'xyy', 'xyx'])
        if order_type == 'xxy':
            ans = simplify(diff(diff(diff(f, x), x), y))
            notation = "\\frac{\\partial^3 f}{\\partial y \\partial x^2}"
        elif order_type == 'xyy':
            ans = simplify(diff(diff(diff(f, x), y), y))
            notation = "\\frac{\\partial^3 f}{\\partial y^2 \\partial x}"
        else:
            ans = simplify(diff(diff(diff(f, x), y), x))
            notation = "\\frac{\\partial^3 f}{\\partial x \\partial y \\partial x}"
        return problem(
            question=f"Find ${notation}$ for $f(x,y) = {latex(f)}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="multivariable_calculus/partial_derivatives",
            solution=steps(
                f"$\\frac{{\\partial f}}{{\\partial x}} = {latex(diff(f, x))}$",
                f"Continue differentiating step by step",
                f"${notation} = {latex(ans)}$"
            )
        )

emit(generate())
