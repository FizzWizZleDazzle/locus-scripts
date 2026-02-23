"""
multivariable_calculus - change_of_variables (hard)
Generated: 2026-02-22T05:42:59.192727
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Elliptic polar: x = ar*cos(t), y = br*sin(t)
        r_var, theta_var = symbols('r theta', real=True, positive=True)
        a_val = randint(2, 5)
        b_val = randint(2, 5)
        while b_val == a_val:
            b_val = randint(2, 5)
        x_trans = a_val * r_var * cos(theta_var)
        y_trans = b_val * r_var * sin(theta_var)
        J = Matrix([
            [diff(x_trans, r_var), diff(x_trans, theta_var)],
            [diff(y_trans, r_var), diff(y_trans, theta_var)]
        ])
        ans = simplify(J.det())
        return problem(
            question=f"Compute the Jacobian $\\frac{{\\partial(x,y)}}{{\\partial(r,\\theta)}}$ for $x = {a_val}r\\cos\\theta$, $y = {b_val}r\\sin\\theta$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial x}}{{\\partial r}} = {a_val}\\cos\\theta$, $\\frac{{\\partial x}}{{\\partial\\theta}} = -{a_val}r\\sin\\theta$",
                f"$\\frac{{\\partial y}}{{\\partial r}} = {b_val}\\sin\\theta$, $\\frac{{\\partial y}}{{\\partial\\theta}} = {b_val}r\\cos\\theta$",
                f"$J = {a_val}\\cos\\theta \\cdot {b_val}r\\cos\\theta - (-{a_val}r\\sin\\theta)\\cdot{b_val}\\sin\\theta$",
                f"$= {a_val*b_val}r(\\cos^2\\theta + \\sin^2\\theta) = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # Ellipse area via change of variables
        a_val = randint(2, 6)
        b_val = randint(2, 6)
        while b_val == a_val:
            b_val = randint(2, 6)
        jacobian = a_val * b_val
        ans = jacobian * pi
        return problem(
            question=f"Using $u = x/{a_val}$, $v = y/{b_val}$, evaluate $\\iint_R dA$ where $R$: $\\frac{{x^2}}{{{a_val**2}}} + \\frac{{y^2}}{{{b_val**2}}} \\le 1$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"Substitution $x = {a_val}u$, $y = {b_val}v$ maps $R$ to unit disk $u^2+v^2 \\le 1$",
                f"Jacobian: $|\\partial(x,y)/\\partial(u,v)| = {a_val}\\cdot{b_val} = {jacobian}$",
                f"$\\iint_R dA = \\iint_{{u^2+v^2 \\le 1}} {jacobian}\\,du\\,dv = {jacobian}\\cdot\\pi = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Polar integral: ∫∫ f(x²+y²) over annulus or disk
        r1 = randint(1, 3)
        r2 = randint(r1 + 1, r1 + 4)
        n_pow = randint(1, 3)
        # ∫_0^{2pi} ∫_{r1}^{r2} r^{n_pow} * r dr dtheta = 2pi * [r^{n_pow+2}/(n_pow+2)]_{r1}^{r2}
        val = Rational(r2**(n_pow + 2) - r1**(n_pow + 2), n_pow + 2)
        ans = 2 * pi * val
        integrand_str = f"(x^2+y^2)^{{{Rational(n_pow,2)}}}" if n_pow % 2 == 1 else f"(x^2+y^2)^{{{n_pow//2}}}"
        return problem(
            question=f"Evaluate $\\iint_D r^{{{n_pow}}}\\,dA$ where $D$: ${r1**2} \\le x^2+y^2 \\le {r2**2}$ (annulus).",
            answer=ans,
            difficulty=(1650, 1780),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"In polar: $dA = r\\,dr\\,d\\theta$; region: ${r1} \\le r \\le {r2}$, $0 \\le \\theta \\le 2\\pi$",
                f"$\\int_0^{{2\\pi}} \\int_{{{r1}}}^{{{r2}}} r^{{{n_pow}}} \\cdot r\\,dr\\,d\\theta = 2\\pi \\int_{{{r1}}}^{{{r2}}} r^{{{n_pow+1}}}\\,dr$",
                f"$= 2\\pi \\left[\\frac{{r^{{{n_pow+2}}}}}{{{n_pow+2}}}\\right]_{{{r1}}}^{{{r2}}} = 2\\pi \\cdot \\frac{{{r2**(n_pow+2)} - {r1**(n_pow+2)}}}{{{n_pow+2}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Spherical coordinate Jacobian (scaled)
        rho_var, phi_var, theta_var = symbols('rho phi theta', real=True, positive=True)
        scale = randint(2, 4)
        x_trans = scale * rho_var * sin(phi_var) * cos(theta_var)
        y_trans = scale * rho_var * sin(phi_var) * sin(theta_var)
        z_trans = rho_var * cos(phi_var)
        J = Matrix([
            [diff(x_trans, rho_var), diff(x_trans, phi_var), diff(x_trans, theta_var)],
            [diff(y_trans, rho_var), diff(y_trans, phi_var), diff(y_trans, theta_var)],
            [diff(z_trans, rho_var), diff(z_trans, phi_var), diff(z_trans, theta_var)]
        ])
        ans = simplify(J.det())
        return problem(
            question=f"Compute $\\frac{{\\partial(x,y,z)}}{{\\partial(\\rho,\\phi,\\theta)}}$ for $x={latex(x_trans)}$, $y={latex(y_trans)}$, $z={latex(z_trans)}$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"Compute the $3\\times3$ Jacobian matrix of partial derivatives.",
                f"$\\frac{{\\partial x}}{{\\partial\\rho}} = {latex(diff(x_trans,rho_var))}$, $\\frac{{\\partial y}}{{\\partial\\rho}} = {latex(diff(y_trans,rho_var))}$, $\\frac{{\\partial z}}{{\\partial\\rho}} = {latex(diff(z_trans,rho_var))}$",
                f"The determinant simplifies to ${latex(ans)}$"
            ),
        )

    elif problem_type == 5:
        # Rewrite integrand using linear substitution
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        d_val = nonzero(-4, 4)
        det = a_val * d_val - b_val * c_val
        while det == 0:
            d_val = nonzero(-4, 4)
            det = a_val * d_val - b_val * c_val
        u_var, v_var = symbols('u v', real=True)
        x_trans = a_val * u_var + b_val * v_var
        y_trans = c_val * u_var + d_val * v_var
        k = randint(1, 3)
        integrand = x**k
        jacobian_det = abs(det)
        integrand_uv = integrand.subs(x, x_trans)
        transformed = simplify(integrand_uv * jacobian_det)
        ans = transformed
        return problem(
            question=f"With $x = {latex(x_trans)}$, $y = {latex(y_trans)}$, rewrite ${latex(integrand)}\\,dA$ in terms of $u,v$ (include Jacobian).",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"Jacobian: $|\\partial(x,y)/\\partial(u,v)| = |{a_val}\\cdot{d_val} - {b_val}\\cdot{c_val}| = {jacobian_det}$",
                f"Substitute $x = {latex(x_trans)}$: ${latex(integrand_uv)}$",
                f"Integrand becomes ${latex(transformed)}\\,du\\,dv$"
            ),
        )

    else:
        # Polar: ∫∫ 1/(x²+y²) over annulus [r1²,r2²]
        r1 = randint(1, 3)
        r2 = randint(r1 + 1, r1 + 4)
        # ∫_0^{2pi} ∫_{r1}^{r2} 1/r^2 * r dr dtheta = 2pi * ln(r2/r1)
        ans = 2 * pi * log(Rational(r2, r1))
        return problem(
            question=f"Use polar coordinates to evaluate $\\iint_D \\frac{{1}}{{x^2+y^2}}\\,dA$ where $D$: ${r1**2} \\le x^2+y^2 \\le {r2**2}$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"In polar: $\\frac{{1}}{{x^2+y^2}} = \\frac{{1}}{{r^2}}$, $dA = r\\,dr\\,d\\theta$",
                f"$\\int_0^{{2\\pi}} \\int_{{{r1}}}^{{{r2}}} \\frac{{1}}{{r^2}} \\cdot r\\,dr\\,d\\theta = 2\\pi \\int_{{{r1}}}^{{{r2}}} \\frac{{1}}{{r}}\\,dr$",
                f"$= 2\\pi [\\ln r]_{{{r1}}}^{{{r2}}} = 2\\pi \\ln\\frac{{{r2}}}{{{r1}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
