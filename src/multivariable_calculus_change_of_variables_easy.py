"""
multivariable_calculus - change_of_variables (easy)
Generated: 2026-02-22T05:41:49.603662
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple Jacobian computation for linear change of variables (1000-1100)
        # u = ax + by, v = cx + dy with simple integer coefficients
        a_val = choice([1, 2])
        b_val = choice([1, 2])
        c_val = choice([1, 2])
        d_val = choice([1, 2])
        
        # Make sure Jacobian is non-zero
        if a_val * d_val == b_val * c_val:
            d_val += 1
        
        u_expr = a_val * x + b_val * y
        v_expr = c_val * x + d_val * y
        
        # Compute Jacobian
        jacobian_matrix = Matrix([
            [diff(u_expr, x), diff(u_expr, y)],
            [diff(v_expr, x), diff(v_expr, y)]
        ])
        
        ans = jacobian_matrix.det()
        
        return problem(
            question=f"Given the change of variables $u = {latex(u_expr)}$ and $v = {latex(v_expr)}$, compute the Jacobian $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The Jacobian is $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} \\frac{{\\partial u}}{{\\partial x}} & \\frac{{\\partial u}}{{\\partial y}} \\\\ \\frac{{\\partial v}}{{\\partial x}} & \\frac{{\\partial v}}{{\\partial y}} \\end{{vmatrix}}$",
                f"$\\frac{{\\partial u}}{{\\partial x}} = {latex(diff(u_expr, x))}$, $\\frac{{\\partial u}}{{\\partial y}} = {latex(diff(u_expr, y))}$",
                f"$\\frac{{\\partial v}}{{\\partial x}} = {latex(diff(v_expr, x))}$, $\\frac{{\\partial v}}{{\\partial y}} = {latex(diff(v_expr, y))}$",
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {latex(diff(u_expr, x))} & {latex(diff(u_expr, y))} \\\\ {latex(diff(v_expr, x))} & {latex(diff(v_expr, y))} \\end{{vmatrix}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Polar coordinates Jacobian (1100-1200)
        # Standard transformation x = r*cos(theta), y = r*sin(theta)
        
        r, theta = symbols('r theta', real=True, positive=True)
        x_expr = r * cos(theta)
        y_expr = r * sin(theta)
        
        jacobian_matrix = Matrix([
            [diff(x_expr, r), diff(x_expr, theta)],
            [diff(y_expr, r), diff(y_expr, theta)]
        ])
        
        ans = simplify(jacobian_matrix.det())
        
        return problem(
            question=f"For the polar coordinate transformation $x = r\\cos(\\theta)$ and $y = r\\sin(\\theta)$, compute the Jacobian $\\frac{{\\partial(x,y)}}{{\\partial(r,\\theta)}}$.",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The Jacobian is $\\frac{{\\partial(x,y)}}{{\\partial(r,\\theta)}} = \\begin{{vmatrix}} \\frac{{\\partial x}}{{\\partial r}} & \\frac{{\\partial x}}{{\\partial \\theta}} \\\\ \\frac{{\\partial y}}{{\\partial r}} & \\frac{{\\partial y}}{{\\partial \\theta}} \\end{{vmatrix}}$",
                f"$\\frac{{\\partial x}}{{\\partial r}} = \\cos(\\theta)$, $\\frac{{\\partial x}}{{\\partial \\theta}} = -r\\sin(\\theta)$",
                f"$\\frac{{\\partial y}}{{\\partial r}} = \\sin(\\theta)$, $\\frac{{\\partial y}}{{\\partial \\theta}} = r\\cos(\\theta)$",
                f"$\\frac{{\\partial(x,y)}}{{\\partial(r,\\theta)}} = \\begin{{vmatrix}} \\cos(\\theta) & -r\\sin(\\theta) \\\\ \\sin(\\theta) & r\\cos(\\theta) \\end{{vmatrix}}$",
                f"$= \\cos(\\theta) \\cdot r\\cos(\\theta) - (-r\\sin(\\theta)) \\cdot \\sin(\\theta) = r\\cos^2(\\theta) + r\\sin^2(\\theta) = r$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Simple scaling transformation (1000-1100)
        # u = ax, v = by
        a_val = randint(2, 4)
        b_val = randint(2, 4)
        
        u_expr = a_val * x
        v_expr = b_val * y
        
        jacobian_matrix = Matrix([
            [diff(u_expr, x), diff(u_expr, y)],
            [diff(v_expr, x), diff(v_expr, y)]
        ])
        
        ans = jacobian_matrix.det()
        
        return problem(
            question=f"Given the scaling transformation $u = {a_val}x$ and $v = {b_val}y$, compute the Jacobian $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The Jacobian is $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} \\frac{{\\partial u}}{{\\partial x}} & \\frac{{\\partial u}}{{\\partial y}} \\\\ \\frac{{\\partial v}}{{\\partial x}} & \\frac{{\\partial v}}{{\\partial y}} \\end{{vmatrix}}$",
                f"$\\frac{{\\partial u}}{{\\partial x}} = {a_val}$, $\\frac{{\\partial u}}{{\\partial y}} = 0$",
                f"$\\frac{{\\partial v}}{{\\partial x}} = 0$, $\\frac{{\\partial v}}{{\\partial y}} = {b_val}$",
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {a_val} & 0 \\\\ 0 & {b_val} \\end{{vmatrix}} = {ans}$"
            ),
        )
    
    else:
        # Type 4: Simple linear transformation with interpretation (1200-1300)
        a_val = randint(1, 3)
        b_val = randint(1, 2)
        
        u_expr = a_val * x
        v_expr = b_val * x + y
        
        jacobian_matrix = Matrix([
            [diff(u_expr, x), diff(u_expr, y)],
            [diff(v_expr, x), diff(v_expr, y)]
        ])
        
        ans = jacobian_matrix.det()
        
        return problem(
            question=f"Given the change of variables $u = {latex(u_expr)}$ and $v = {latex(v_expr)}$, compute the Jacobian $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}$.",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The Jacobian is $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} \\frac{{\\partial u}}{{\\partial x}} & \\frac{{\\partial u}}{{\\partial y}} \\\\ \\frac{{\\partial v}}{{\\partial x}} & \\frac{{\\partial v}}{{\\partial y}} \\end{{vmatrix}}$",
                f"$\\frac{{\\partial u}}{{\\partial x}} = {latex(diff(u_expr, x))}$, $\\frac{{\\partial u}}{{\\partial y}} = {latex(diff(u_expr, y))}$",
                f"$\\frac{{\\partial v}}{{\\partial x}} = {latex(diff(v_expr, x))}$, $\\frac{{\\partial v}}{{\\partial y}} = {latex(diff(v_expr, y))}$",
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {latex(diff(u_expr, x))} & {latex(diff(u_expr, y))} \\\\ {latex(diff(v_expr, x))} & {latex(diff(v_expr, y))} \\end{{vmatrix}} = {latex(ans)}$"
            ),
        )

emit(generate())