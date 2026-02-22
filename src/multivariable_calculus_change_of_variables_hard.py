"""
multivariable_calculus - change_of_variables (hard)
Generated: 2026-02-22T05:42:59.192727
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Jacobian determinant for polar/cylindrical coordinates with transformation
        r_var, theta_var = symbols('r theta', real=True, positive=True)
        
        # Create a transformation with parameters
        a_val = randint(2, 4)
        b_val = randint(1, 3)
        
        # Transformation: x = ar*cos(theta), y = br*sin(theta)
        x_trans = a_val * r_var * cos(theta_var)
        y_trans = b_val * r_var * sin(theta_var)
        
        # Compute Jacobian matrix
        J = Matrix([
            [diff(x_trans, r_var), diff(x_trans, theta_var)],
            [diff(y_trans, r_var), diff(y_trans, theta_var)]
        ])
        
        jacobian_det = simplify(J.det())
        ans = jacobian_det
        
        return problem(
            question=f"Consider the transformation $x = {latex(x_trans)}$, $y = {latex(y_trans)}$. Compute the Jacobian determinant $\\frac{{\\partial(x,y)}}{{\\partial(r,\\theta)}}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The Jacobian matrix is $J = \\begin{{pmatrix}} \\frac{{\\partial x}}{{\\partial r}} & \\frac{{\\partial x}}{{\\partial \\theta}} \\\\ \\frac{{\\partial y}}{{\\partial r}} & \\frac{{\\partial y}}{{\\partial \\theta}} \\end{{pmatrix}}$",
                f"$\\frac{{\\partial x}}{{\\partial r}} = {latex(diff(x_trans, r_var))}$, $\\frac{{\\partial x}}{{\\partial \\theta}} = {latex(diff(x_trans, theta_var))}$",
                f"$\\frac{{\\partial y}}{{\\partial r}} = {latex(diff(y_trans, r_var))}$, $\\frac{{\\partial y}}{{\\partial \\theta}} = {latex(diff(y_trans, theta_var))}$",
                f"$J = {latex(J)}$",
                f"$\\det(J) = {latex(jacobian_det)}$"
            ),
        )
    
    elif problem_type == 2:
        # Convert integral using change of variables (ellipse to circle)
        u_var, v_var = symbols('u v', real=True)
        
        a_val = randint(2, 5)
        b_val = randint(2, 5)
        while b_val == a_val:
            b_val = randint(2, 5)
        
        # Transformation x = au, y = bv transforms x^2/a^2 + y^2/b^2 <= 1 to u^2 + v^2 <= 1
        # Jacobian is ab
        integrand_orig = 1  # Just computing area
        jacobian = a_val * b_val
        
        # The transformed integral over unit disk gives pi
        ans = jacobian * pi
        
        return problem(
            question=f"Using the change of variables $u = \\frac{{x}}{{{a_val}}}$, $v = \\frac{{y}}{{{b_val}}}$, evaluate the integral $\\iint_R \\, dA$ where $R$ is the region $\\frac{{x^2}}{{{a_val**2}}} + \\frac{{y^2}}{{{b_val**2}}} \\leq 1$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The transformation is $x = {a_val}u$, $y = {b_val}v$",
                f"The Jacobian is $\\frac{{\\partial(x,y)}}{{\\partial(u,v)}} = {a_val} \\cdot {b_val} = {jacobian}$",
                f"The region $R$ transforms to $u^2 + v^2 \\leq 1$ (unit disk)",
                f"$\\iint_R \\, dA = \\iint_{{u^2+v^2 \\leq 1}} {jacobian} \\, du\\,dv = {jacobian} \\cdot \\pi = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # 3D Jacobian with spherical-like coordinates
        rho_var, phi_var, theta_var = symbols('rho phi theta', real=True, positive=True)
        
        # Spherical coordinates with a twist
        scale = randint(2, 4)
        
        x_trans = scale * rho_var * sin(phi_var) * cos(theta_var)
        y_trans = scale * rho_var * sin(phi_var) * sin(theta_var)
        z_trans = rho_var * cos(phi_var)
        
        J = Matrix([
            [diff(x_trans, rho_var), diff(x_trans, phi_var), diff(x_trans, theta_var)],
            [diff(y_trans, rho_var), diff(y_trans, phi_var), diff(y_trans, theta_var)],
            [diff(z_trans, rho_var), diff(z_trans, phi_var), diff(z_trans, theta_var)]
        ])
        
        jacobian_det = simplify(J.det())
        ans = jacobian_det
        
        return problem(
            question=f"Compute the Jacobian determinant $\\frac{{\\partial(x,y,z)}}{{\\partial(\\rho,\\phi,\\theta)}}$ for the transformation $x = {latex(x_trans)}$, $y = {latex(y_trans)}$, $z = {latex(z_trans)}$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"Compute partial derivatives:",
                f"$\\frac{{\\partial x}}{{\\partial \\rho}} = {latex(diff(x_trans, rho_var))}$, $\\frac{{\\partial x}}{{\\partial \\phi}} = {latex(diff(x_trans, phi_var))}$, $\\frac{{\\partial x}}{{\\partial \\theta}} = {latex(diff(x_trans, theta_var))}$",
                f"$\\frac{{\\partial y}}{{\\partial \\rho}} = {latex(diff(y_trans, rho_var))}$, $\\frac{{\\partial y}}{{\\partial \\phi}} = {latex(diff(y_trans, phi_var))}$, $\\frac{{\\partial y}}{{\\partial \\theta}} = {latex(diff(y_trans, theta_var))}$",
                f"$\\frac{{\\partial z}}{{\\partial \\rho}} = {latex(diff(z_trans, rho_var))}$, $\\frac{{\\partial z}}{{\\partial \\phi}} = {latex(diff(z_trans, phi_var))}$, $\\frac{{\\partial z}}{{\\partial \\theta}} = {latex(diff(z_trans, theta_var))}$",
                f"The Jacobian determinant simplifies to ${latex(jacobian_det)}$"
            ),
        )
    
    else:  # problem_type == 4
        # Change of variables with composition
        u_var, v_var = symbols('u v', real=True)
        
        # Linear transformation with non-trivial coefficients
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        d_val = nonzero(-3, 3)
        
        # Ensure non-zero determinant
        while a_val * d_val - b_val * c_val == 0:
            d_val = nonzero(-3, 3)
        
        x_trans = a_val * u_var + b_val * v_var
        y_trans = c_val * u_var + d_val * v_var
        
        # Function to integrate
        k = randint(1, 3)
        integrand = x**k
        
        # Jacobian
        jacobian_det = abs(a_val * d_val - b_val * c_val)
        
        # Substitute and simplify
        integrand_uv = integrand.subs([(x, x_trans), (y, y_trans)])
        transformed_integrand = simplify(integrand_uv * jacobian_det)
        ans = transformed_integrand
        
        return problem(
            question=f"Given the transformation $x = {latex(x_trans)}$, $y = {latex(y_trans)}$, rewrite the integrand ${latex(integrand)} \\, dA$ in terms of $u$ and $v$ (include the Jacobian).",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"Substitute $x = {latex(x_trans)}$ into ${latex(integrand)}$: ${latex(integrand_uv)}$",
                f"Compute Jacobian: $\\frac{{\\partial(x,y)}}{{\\partial(u,v)}} = \\begin{{vmatrix}} {a_val} & {b_val} \\\\ {c_val} & {d_val} \\end{{vmatrix}} = {a_val * d_val - b_val * c_val}$",
                f"Taking absolute value: $|\\frac{{\\partial(x,y)}}{{\\partial(u,v)}}| = {jacobian_det}$",
                f"The integrand becomes ${latex(transformed_integrand)} \\, du\\,dv$"
            ),
        )

emit(generate())