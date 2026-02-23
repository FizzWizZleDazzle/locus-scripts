"""
multivariable_calculus - line_integrals (hard)
Generated: 2026-02-22T05:44:47.706376
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Conservative 3D field: evaluate via potential function
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        # phi = a*x*y + b*y*z + c*x*z
        F_x = a_val * y + c_val * z
        F_y = a_val * x + b_val * z
        F_z = b_val * y + c_val * x
        x0, y0, z0 = randint(-3, 3), randint(-3, 3), randint(-3, 3)
        x1, y1, z1 = randint(-3, 3), randint(-3, 3), randint(-3, 3)
        while x1 == x0 and y1 == y0 and z1 == z0:
            x1, y1, z1 = randint(-3, 3), randint(-3, 3), randint(-3, 3)
        f_start = a_val * x0 * y0 + b_val * y0 * z0 + c_val * x0 * z0
        f_end = a_val * x1 * y1 + b_val * y1 * z1 + c_val * x1 * z1
        ans = f_end - f_start
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(F_x)}, {latex(F_y)}, {latex(F_z)} \\rangle$ along any path from $({x0},{y0},{z0})$ to $({x1},{y1},{z1})$.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"$\\mathbf{{F}} = \\nabla\\varphi$ where $\\varphi = {latex(a_val*x*y + b_val*y*z + c_val*x*z)}$",
                f"$\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\varphi({x1},{y1},{z1}) - \\varphi({x0},{y0},{z0})$",
                f"$= {f_end} - {f_start} = {ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Line integral along helix r(t) = <cos t, sin t, t>
        t_end = choice([1, 2, 3, 4])
        # F = <y, -x, z>, F·r' = -sin²t - cos²t + t = -1 + t
        # integral from 0 to t_end of (-1 + t) dt = [-t + t²/2]
        ans = Rational(-t_end**2, 2) + Rational(t_end**2, 2)
        # Re-derive correctly: int_0^T (-1+t)dt = -T + T^2/2
        ans = -t_end + Rational(t_end**2, 2)
        return problem(
            question=f"Evaluate $\\int_C (y\\,dx - x\\,dy + z\\,dz)$ where $C$: $\\mathbf{{r}}(t) = \\langle \\cos t, \\sin t, t \\rangle$, $t \\in [0,{t_end}]$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"$\\mathbf{{r}}'(t) = \\langle -\\sin t, \\cos t, 1 \\rangle$",
                f"Integrand: $y(-\\sin t) - x(\\cos t) + z = -\\sin^2 t - \\cos^2 t + t = -1 + t$",
                f"$\\int_0^{{{t_end}}} (-1+t)\\,dt = \\left[-t + \\frac{{t^2}}{{2}}\\right]_0^{{{t_end}}} = -{t_end} + \\frac{{{t_end**2}}}{{2}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Work done by F = <ax, by> along segment from (0,0) to (p,q)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        p_val = nonzero(-4, 4)
        q_val = nonzero(-4, 4)
        # r(t) = <p*t, q*t>, r'(t) = <p, q>
        # F(r(t)) = <a*p*t, b*q*t>
        # F·r' = a*p²*t + b*q²*t = (a*p² + b*q²)*t
        dot = a_val * p_val**2 + b_val * q_val**2
        ans = Rational(dot, 2)
        return problem(
            question=f"Find the work done by $\\mathbf{{F}} = \\langle {a_val}x, {b_val}y \\rangle$ along the segment from $(0,0)$ to $({p_val},{q_val})$.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize: $\\mathbf{{r}}(t) = \\langle {p_val}t, {q_val}t \\rangle$, $t \\in [0,1]$",
                f"$\\mathbf{{F}}(\\mathbf{{r}}(t)) = \\langle {a_val}\\cdot{p_val}t, {b_val}\\cdot{q_val}t \\rangle$",
                f"$\\mathbf{{F}} \\cdot \\mathbf{{r}}' = {a_val*p_val}\\cdot{p_val}\\cdot t + {b_val*q_val}\\cdot{q_val}\\cdot t = {dot}t$",
                f"$W = \\int_0^1 {dot}t\\,dt = \\frac{{{dot}}}{{2}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # ∫_C xy ds along circle x²+y²=r², answer = 0
        a_val = randint(1, 6)
        ans = 0
        return problem(
            question=f"Evaluate $\\int_C xy\\,ds$ where $C$: $x^2+y^2={a_val**2}$ (full circle, CCW).",
            answer=ans,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize: $x = {a_val}\\cos t$, $y = {a_val}\\sin t$, $ds = {a_val}\\,dt$, $t \\in [0,2\\pi]$",
                f"$xy = {a_val**2}\\cos t \\sin t = \\frac{{{a_val**2}}}{{2}}\\sin(2t)$",
                f"$\\int_0^{{2\\pi}} \\frac{{{a_val**2}}}{{2}}\\sin(2t) \\cdot {a_val}\\,dt = \\frac{{{a_val**3}}}{{2}} \\cdot 0 = 0$",
                f"(The integral of $\\sin(2t)$ over a full period is zero.)"
            ),
            calculator="scientific"
        )

    elif problem_type == 5:
        # Green's theorem: ∮ F·dr over rectangle [0,a]×[0,b]
        # P = c*y + ..., Q = d*x + ..., curl = dQ/dx - dP/dy = d - c
        c_coeff = nonzero(-4, 4)
        d_coeff = nonzero(-4, 4)
        # Make c_coeff != d_coeff so answer is nonzero
        while c_coeff == d_coeff:
            d_coeff = nonzero(-4, 4)
        extra_p = nonzero(-3, 3)
        extra_q = nonzero(-3, 3)
        P = c_coeff * y + extra_p * x
        Q = d_coeff * x + extra_q * y
        curl = diff(Q, x) - diff(P, y)
        a_val = randint(1, 5)
        b_val = randint(1, 5)
        area = a_val * b_val
        ans = curl * area
        return problem(
            question=f"Use Green's Theorem to evaluate $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ and $C$ is the boundary of $[0,{a_val}] \\times [0,{b_val}]$ (CCW).",
            answer=ans,
            difficulty=(1750, 1900),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Green's Theorem: $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right) dA$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {d_coeff}$, $\\frac{{\\partial P}}{{\\partial y}} = {c_coeff}$",
                f"Curl $= {d_coeff} - {c_coeff} = {latex(curl)}$",
                f"$\\iint_D {latex(curl)}\\,dA = {latex(curl)} \\cdot {a_val} \\cdot {b_val} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # 2D line integral with quadratic field along parabola y=x²
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        x_end = randint(1, 4)
        P = a_val * x
        Q = b_val * y
        # r(t) = <t, t²>, r'(t) = <1, 2t>
        P_sub = P.subs(x, t)
        Q_sub = Q.subs([(x, t), (y, t**2)])
        integrand = simplify(P_sub * 1 + Q_sub * 2 * t)
        ans = simplify(integrate(integrand, (t, 0, x_end)))
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ along the parabola $y = x^2$ from $(0,0)$ to $({x_end},{x_end**2})$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize: $x = t$, $y = t^2$, $t \\in [0,{x_end}]$",
                f"$d\\mathbf{{r}} = \\langle 1, 2t \\rangle\\,dt$",
                f"$\\mathbf{{F}} \\cdot d\\mathbf{{r}} = {a_val}t + {b_val}t^2 \\cdot 2t = {latex(integrand)}\\,dt$",
                f"$\\int_0^{{{x_end}}} {latex(integrand)}\\,dt = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
