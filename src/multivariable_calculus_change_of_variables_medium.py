"""
multivariable_calculus - change_of_variables (medium)
Generated: 2026-02-22T05:42:28.051773
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Polar: ∫∫ r^n dA over disk of radius r_max
        r_max = randint(2, 6)
        n_pow = randint(1, 3)
        # ∫_0^{2pi} ∫_0^{r_max} r^n * r dr dtheta = 2pi * r_max^(n+2)/(n+2)
        ans = Rational(2, n_pow + 2) * pi * r_max**(n_pow + 2)
        integrand_str = f"r^{n_pow}" if n_pow > 1 else "r"
        return problem(
            question=f"Use polar coordinates to evaluate $\\iint_D {integrand_str}\\,dA$ where $D$: $x^2+y^2 \\le {r_max**2}$.",
            answer=ans,
            difficulty=(1300, 1450),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"In polar: $dA = r\\,dr\\,d\\theta$; region: $0 \\le r \\le {r_max}$, $0 \\le \\theta \\le 2\\pi$",
                f"$\\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r^{{{n_pow}}} \\cdot r\\,dr\\,d\\theta = 2\\pi \\int_0^{{{r_max}}} r^{{{n_pow+1}}}\\,dr$",
                f"$= 2\\pi \\cdot \\frac{{{r_max}^{{{n_pow+2}}}}}{{{n_pow+2}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Jacobian of linear transformation (absolute value)
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        c_coeff = nonzero(-4, 4)
        d_coeff = nonzero(-4, 4)
        det = a_coeff * d_coeff - b_coeff * c_coeff
        while det == 0:
            d_coeff = nonzero(-4, 4)
            det = a_coeff * d_coeff - b_coeff * c_coeff
        u_expr = a_coeff * x + b_coeff * y
        v_expr = c_coeff * x + d_coeff * y
        ans = abs(det)
        return problem(
            question=f"Find $\\left|\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}\\right|$ for $u = {latex(u_expr)}$, $v = {latex(v_expr)}$.",
            answer=ans,
            difficulty=(1350, 1500),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {a_coeff} & {b_coeff} \\\\ {c_coeff} & {d_coeff} \\end{{vmatrix}} = {a_coeff}\\cdot{d_coeff} - {b_coeff}\\cdot{c_coeff} = {det}$",
                f"$\\left|\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}\\right| = {ans}$"
            ),
        )

    elif problem_type == 3:
        # Area via scaling substitution
        a_val = randint(2, 5)
        b_val = randint(2, 5)
        u_max = randint(2, 5)
        v_max = randint(2, 5)
        jacobian = a_val * b_val
        area_uv = u_max * v_max
        ans = jacobian * area_uv
        return problem(
            question=f"Evaluate $\\iint_R dA$ over $[0,{a_val*u_max}] \\times [0,{b_val*v_max}]$ using $x={a_val}u$, $y={b_val}v$.",
            answer=ans,
            difficulty=(1300, 1450),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"Jacobian: $\\frac{{\\partial(x,y)}}{{\\partial(u,v)}} = {a_val}\\cdot{b_val} = {jacobian}$",
                f"Region in $uv$: $0 \\le u \\le {u_max}$, $0 \\le v \\le {v_max}$",
                f"$\\iint_R dA = \\int_0^{{{u_max}}} \\int_0^{{{v_max}}} {jacobian}\\,dv\\,du = {jacobian} \\cdot {u_max} \\cdot {v_max} = {ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Polar sector integral of r^2
        r_max = randint(2, 5)
        theta_frac = choice([2, 3, 4, 6])
        # ∫_0^{2pi/theta_frac} ∫_0^r_max r^2 * r dr dtheta
        theta_end = Rational(2, theta_frac) * pi
        ans = simplify(theta_end * Rational(r_max**4, 4))
        if theta_frac == 2:
            angle_str = "\\pi"
        elif theta_frac == 3:
            angle_str = "\\frac{2\\pi}{3}"
        elif theta_frac == 4:
            angle_str = "\\frac{\\pi}{2}"
        else:
            angle_str = "\\frac{\\pi}{3}"
        return problem(
            question=f"Evaluate $\\iint_D r^2\\,dA$ where $D$: $0 \\le r \\le {r_max}$, $0 \\le \\theta \\le {angle_str}$.",
            answer=ans,
            difficulty=(1400, 1550),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\iint_D r^2\\,dA = \\int_0^{{{angle_str}}} \\int_0^{{{r_max}}} r^2 \\cdot r\\,dr\\,d\\theta$",
                f"$= \\int_0^{{{angle_str}}} \\frac{{{r_max}^4}}{{4}}\\,d\\theta = \\frac{{{r_max**4}}}{{4}} \\cdot {angle_str} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 5:
        # Change of variables integral with substitution u = x+y, v = x-y
        a_val = randint(1, 4)
        b_val = randint(1, 4)
        # Region: 0≤x≤a, 0≤y≤b -> rectangle in uv-plane? Use a simpler approach:
        # Integrate c over [0,a]x[0,b] using u=cx, v=dy
        c_val = randint(2, 5)
        d_val = randint(2, 5)
        f_coeff = nonzero(-3, 3)
        # f(x,y) = f_coeff, just area
        # f(x,y) = f_coeff * (x+y), integrate over [0,a]x[0,b]
        # direct ans: f_coeff * (a^2*b/2 + a*b^2/2)
        ans = f_coeff * (Rational(a_val**2 * b_val, 2) + Rational(a_val * b_val**2, 2))
        return problem(
            question=f"Evaluate $\\iint_R {latex(f_coeff*(x+y))}\\,dA$ where $R = [0,{a_val}]\\times[0,{b_val}]$.",
            answer=ans,
            difficulty=(1350, 1500),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"$\\int_0^{{{a_val}}} \\int_0^{{{b_val}}} {f_coeff}(x+y)\\,dy\\,dx$",
                f"Inner integral: $\\int_0^{{{b_val}}} {f_coeff}(x+y)\\,dy = {f_coeff}\\left[xy + \\frac{{y^2}}{{2}}\\right]_0^{{{b_val}}} = {f_coeff}({b_val}x + {Rational(b_val**2,2)})$",
                f"$\\int_0^{{{a_val}}} {f_coeff}({b_val}x + {Rational(b_val**2,2)})\\,dx = {f_coeff}\\left[\\frac{{{b_val}x^2}}{{2}} + {Rational(b_val**2,2)}x\\right]_0^{{{a_val}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # Polar: evaluate ∫∫ x² + y² dA over disk
        r_max = randint(2, 5)
        # ∫_0^{2pi} ∫_0^{r_max} r^2 * r dr dtheta = 2pi * r_max^4/4
        ans = Rational(1, 2) * pi * r_max**4
        return problem(
            question=f"Use polar coordinates to evaluate $\\iint_D (x^2+y^2)\\,dA$ where $D$: $x^2+y^2 \\le {r_max**2}$.",
            answer=ans,
            difficulty=(1400, 1580),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"In polar: $x^2+y^2 = r^2$, $dA = r\\,dr\\,d\\theta$",
                f"$\\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r^2 \\cdot r\\,dr\\,d\\theta = 2\\pi \\int_0^{{{r_max}}} r^3\\,dr$",
                f"$= 2\\pi \\cdot \\frac{{{r_max}^4}}{{4}} = \\frac{{\\pi {r_max**4}}}{{2}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
