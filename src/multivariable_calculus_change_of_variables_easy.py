"""
multivariable_calculus - change_of_variables (easy)
Generated: 2026-02-22T05:41:49.603662
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Linear change of variables: u = ax + by, v = cx + dy
        a_val = choice([1, 2, 3])
        b_val = choice([0, 1, 2])
        c_val = choice([0, 1, 2])
        d_val = choice([1, 2, 3])
        if a_val * d_val == b_val * c_val:
            d_val += 1
        u_expr = a_val * x + b_val * y
        v_expr = c_val * x + d_val * y
        ans = a_val * d_val - b_val * c_val
        return problem(
            question=f"Compute the Jacobian $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}$ for $u = {latex(u_expr)}$, $v = {latex(v_expr)}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {a_val} & {b_val} \\\\ {c_val} & {d_val} \\end{{vmatrix}} = {a_val}\\cdot{d_val} - {b_val}\\cdot{c_val} = {ans}$"
            ),
        )

    elif problem_type == 2:
        # Polar coordinates Jacobian (always r)
        r_var, theta_var = symbols('r theta', real=True, positive=True)
        x_expr = r_var * cos(theta_var)
        y_expr = r_var * sin(theta_var)
        J = Matrix([
            [diff(x_expr, r_var), diff(x_expr, theta_var)],
            [diff(y_expr, r_var), diff(y_expr, theta_var)]
        ])
        ans = simplify(J.det())
        return problem(
            question=f"For $x = r\\cos\\theta$, $y = r\\sin\\theta$, compute $\\frac{{\\partial(x,y)}}{{\\partial(r,\\theta)}}$.",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial x}}{{\\partial r}} = \\cos\\theta$, $\\frac{{\\partial x}}{{\\partial\\theta}} = -r\\sin\\theta$",
                f"$\\frac{{\\partial y}}{{\\partial r}} = \\sin\\theta$, $\\frac{{\\partial y}}{{\\partial\\theta}} = r\\cos\\theta$",
                f"$J = r\\cos^2\\theta + r\\sin^2\\theta = r$"
            ),
        )

    elif problem_type == 3:
        # Scaling transformation: u = ax, v = by
        a_val = randint(2, 6)
        b_val = randint(2, 6)
        ans = a_val * b_val
        return problem(
            question=f"Compute $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}$ for $u = {a_val}x$, $v = {b_val}y$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {a_val} & 0 \\\\ 0 & {b_val} \\end{{vmatrix}} = {ans}$"
            ),
        )

    elif problem_type == 4:
        # u = ax, v = bx + cy (shear + scale)
        a_val = randint(1, 4)
        b_val = randint(1, 3)
        c_val = randint(1, 4)
        u_expr = a_val * x
        v_expr = b_val * x + c_val * y
        ans = a_val * c_val
        return problem(
            question=f"Compute $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}$ for $u = {latex(u_expr)}$, $v = {latex(v_expr)}$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {a_val} & 0 \\\\ {b_val} & {c_val} \\end{{vmatrix}} = {a_val}\\cdot{c_val} - 0\\cdot{b_val} = {ans}$"
            ),
        )

    elif problem_type == 5:
        # Inverse Jacobian: given x = f(u,v), find dx/du etc
        a_val = randint(2, 5)
        b_val = randint(2, 5)
        u_var, v_var = symbols('u v', real=True)
        x_expr = a_val * u_var
        y_expr = b_val * v_var
        J = Matrix([
            [diff(x_expr, u_var), diff(x_expr, v_var)],
            [diff(y_expr, u_var), diff(y_expr, v_var)]
        ])
        ans = J.det()
        return problem(
            question=f"For $x = {a_val}u$, $y = {b_val}v$, compute $\\frac{{\\partial(x,y)}}{{\\partial(u,v)}}$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial(x,y)}}{{\\partial(u,v)}} = \\begin{{vmatrix}} {a_val} & 0 \\\\ 0 & {b_val} \\end{{vmatrix}} = {ans}$"
            ),
        )

    else:
        # Linear transformation: x = au + bv, y = cu + dv
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        d_val = nonzero(-3, 3)
        det = a_val * d_val - b_val * c_val
        while det == 0:
            d_val = nonzero(-3, 3)
            det = a_val * d_val - b_val * c_val
        u_var, v_var = symbols('u v', real=True)
        x_expr = a_val * u_var + b_val * v_var
        y_expr = c_val * u_var + d_val * v_var
        ans = det
        return problem(
            question=f"Compute $\\frac{{\\partial(x,y)}}{{\\partial(u,v)}}$ for $x = {latex(x_expr)}$, $y = {latex(y_expr)}$.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial(x,y)}}{{\\partial(u,v)}} = \\begin{{vmatrix}} {a_val} & {b_val} \\\\ {c_val} & {d_val} \\end{{vmatrix}} = {a_val}\\cdot{d_val} - {b_val}\\cdot{c_val} = {ans}$"
            ),
        )

emit(generate())
