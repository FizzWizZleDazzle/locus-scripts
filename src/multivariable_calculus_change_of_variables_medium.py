"""
multivariable_calculus - change_of_variables (medium)
Generated: 2026-02-22T05:42:28.051773
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Change of variables in double integral - rectangular to polar
        # ELO 1300-1400: straightforward polar substitution
        r_max = randint(2, 5)
        integrand_type = choice(['r', 'r^2', '1'])
        
        if integrand_type == 'r':
            # ∫∫ r dr dθ over a circle
            ans = pi * r_max**3 / 3
            integrand_str = "r"
            work = steps(
                f"Convert to polar coordinates: $x = r\\cos\\theta$, $y = r\\sin\\theta$, $dA = r\\,dr\\,d\\theta$",
                f"The region is $0 \\leq r \\leq {r_max}$, $0 \\leq \\theta \\leq 2\\pi$",
                f"$\\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r \\cdot r\\,dr\\,d\\theta = \\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r^2\\,dr\\,d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\left[\\frac{{r^3}}{{3}}\\right]_0^{{{r_max}}} d\\theta = \\int_0^{{2\\pi}} \\frac{{{r_max**3}}}{{3}}\\,d\\theta$",
                f"$= \\frac{{{r_max**3}}}{{3}} \\cdot 2\\pi = \\frac{{{2*r_max**3}\\pi}}{{3}}$"
            )
            ans_latex = f"\\frac{{{2*r_max**3}\\pi}}{{3}}"
        elif integrand_type == 'r^2':
            ans = pi * r_max**4 / 2
            integrand_str = "r^2"
            work = steps(
                f"Convert to polar coordinates: $dA = r\\,dr\\,d\\theta$",
                f"The region is $0 \\leq r \\leq {r_max}$, $0 \\leq \\theta \\leq 2\\pi$",
                f"$\\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r^2 \\cdot r\\,dr\\,d\\theta = \\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r^3\\,dr\\,d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\left[\\frac{{r^4}}{{4}}\\right]_0^{{{r_max}}} d\\theta = \\int_0^{{2\\pi}} \\frac{{{r_max**4}}}{{4}}\\,d\\theta$",
                f"$= \\frac{{{r_max**4}}}{{4}} \\cdot 2\\pi = \\frac{{{r_max**4}\\pi}}{{2}}$"
            )
            ans_latex = f"\\frac{{{r_max**4}\\pi}}{{2}}"
        else:
            ans = pi * r_max**2
            integrand_str = "1"
            work = steps(
                f"Convert to polar coordinates: $dA = r\\,dr\\,d\\theta$",
                f"The region is $0 \\leq r \\leq {r_max}$, $0 \\leq \\theta \\leq 2\\pi$",
                f"$\\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r\\,dr\\,d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\left[\\frac{{r^2}}{{2}}\\right]_0^{{{r_max}}} d\\theta = \\int_0^{{2\\pi}} \\frac{{{r_max**2}}}{{2}}\\,d\\theta$",
                f"$= \\frac{{{r_max**2}}}{{2}} \\cdot 2\\pi = {r_max**2}\\pi$"
            )
            ans_latex = f"{r_max**2}\\pi"
        
        return problem(
            question=f"Evaluate $\\iint_D {integrand_str}\\,dA$ where $D$ is the disk $x^2 + y^2 \\leq {r_max**2}$ using polar coordinates.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/change_of_variables",
            solution=work
        )
    
    elif problem_type == 2:
        # Jacobian computation - 2D transformation
        # ELO 1400-1500: compute Jacobian determinant
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        
        # u = ax + by, v = cx + dy
        c_coeff = nonzero(-3, 3)
        d_coeff = nonzero(-3, 3)
        
        # Make sure determinant is nonzero
        det = a_coeff * d_coeff - b_coeff * c_coeff
        if det == 0:
            d_coeff = d_coeff + 1
            det = a_coeff * d_coeff - b_coeff * c_coeff
        
        u_expr = a_coeff * x + b_coeff * y
        v_expr = c_coeff * x + d_coeff * y
        
        ans = abs(det)
        
        return problem(
            question=f"Find the absolute value of the Jacobian $\\left|\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}\\right|$ for the transformation $u = {latex(u_expr)}$, $v = {latex(v_expr)}$.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The Jacobian is $\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} \\frac{{\\partial u}}{{\\partial x}} & \\frac{{\\partial u}}{{\\partial y}} \\\\ \\frac{{\\partial v}}{{\\partial x}} & \\frac{{\\partial v}}{{\\partial y}} \\end{{vmatrix}}$",
                f"$\\frac{{\\partial u}}{{\\partial x}} = {a_coeff}$, $\\frac{{\\partial u}}{{\\partial y}} = {b_coeff}$",
                f"$\\frac{{\\partial v}}{{\\partial x}} = {c_coeff}$, $\\frac{{\\partial v}}{{\\partial y}} = {d_coeff}$",
                f"$\\frac{{\\partial(u,v)}}{{\\partial(x,y)}} = \\begin{{vmatrix}} {a_coeff} & {b_coeff} \\\\ {c_coeff} & {d_coeff} \\end{{vmatrix}} = {a_coeff} \\cdot {d_coeff} - {b_coeff} \\cdot {c_coeff} = {det}$",
                f"$\\left|\\frac{{\\partial(u,v)}}{{\\partial(x,y)}}\\right| = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Change of variables in integral - linear substitution
        # ELO 1300-1500: u-substitution in double integral
        a_val = randint(2, 4)
        b_val = randint(2, 4)
        
        # Integral over rectangle in uv-plane
        u_min, u_max = 0, randint(2, 4)
        v_min, v_max = 0, randint(2, 4)
        
        # x = au, y = bv, so Jacobian = ab
        jacobian = a_val * b_val
        area_uv = (u_max - u_min) * (v_max - v_min)
        ans = jacobian * area_uv
        
        return problem(
            question=f"Evaluate $\\iint_R dA$ where $R$ is the region in the $xy$-plane defined by $0 \\leq x \\leq {a_val * u_max}$, $0 \\leq y \\leq {b_val * v_max}$, using the change of variables $x = {a_val}u$, $y = {b_val}v$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"The Jacobian is $\\frac{{\\partial(x,y)}}{{\\partial(u,v)}} = \\begin{{vmatrix}} {a_val} & 0 \\\\ 0 & {b_val} \\end{{vmatrix}} = {jacobian}$",
                f"Under the transformation, $0 \\leq x \\leq {a_val * u_max}$ becomes $0 \\leq u \\leq {u_max}$",
                f"And $0 \\leq y \\leq {b_val * v_max}$ becomes $0 \\leq v \\leq {v_max}$",
                f"$\\iint_R dA = \\int_0^{{{u_max}}} \\int_0^{{{v_max}}} {jacobian}\\,dv\\,du = {jacobian} \\cdot {u_max} \\cdot {v_max} = {ans}$"
            )
        )
    
    else:
        # Polar coordinates sector integral
        # ELO 1400-1600: integral over sector with function
        r_max = randint(2, 4)
        theta_frac = choice([2, 3, 4, 6])  # fraction of full circle
        
        # Integral of r over a sector
        angle = 2 * pi / theta_frac
        ans = r_max**3 / (3 * theta_frac)
        
        if theta_frac == 2:
            angle_str = "\\pi"
            ans_expr = f"\\frac{{{r_max**3}\\pi}}{{6}}"
        elif theta_frac == 4:
            angle_str = "\\frac{\\pi}{2}"
            ans_expr = f"\\frac{{{r_max**3}\\pi}}{{12}}"
        elif theta_frac == 3:
            angle_str = "\\frac{2\\pi}{3}"
            ans_expr = f"\\frac{{{r_max**3}\\pi}}{{9}}"
        else:
            angle_str = "\\frac{\\pi}{3}"
            ans_expr = f"\\frac{{{r_max**3}\\pi}}{{18}}"
        
        return problem(
            question=f"Evaluate $\\iint_D r\\,dA$ where $D$ is the region $0 \\leq r \\leq {r_max}$, $0 \\leq \\theta \\leq {angle_str}$ in polar coordinates.",
            answer=float(ans),
            difficulty=(1400, 1500),
            topic="multivariable_calculus/change_of_variables",
            solution=steps(
                f"In polar coordinates, $dA = r\\,dr\\,d\\theta$",
                f"$\\iint_D r\\,dA = \\int_0^{{{angle_str}}} \\int_0^{{{r_max}}} r \\cdot r\\,dr\\,d\\theta = \\int_0^{{{angle_str}}} \\int_0^{{{r_max}}} r^2\\,dr\\,d\\theta$",
                f"$= \\int_0^{{{angle_str}}} \\left[\\frac{{r^3}}{{3}}\\right]_0^{{{r_max}}} d\\theta = \\int_0^{{{angle_str}}} \\frac{{{r_max**3}}}{{3}}\\,d\\theta$",
                f"$= \\frac{{{r_max**3}}}{{3}} \\cdot {angle_str} = {ans_expr}$"
            ),
            calculator="scientific"
        )

emit(generate())