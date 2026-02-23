"""
multivariable_calculus - line_integrals (medium)
Generated: 2026-02-22T05:44:04.290906
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # F·dr along segment: F = <px, qy>
        p_coeff = nonzero(-5, 5)
        q_coeff = nonzero(-5, 5)
        P = p_coeff * x
        Q = q_coeff * y
        x0, y0 = randint(-4, 4), randint(-4, 4)
        x1, y1 = randint(-4, 4), randint(-4, 4)
        while x1 == x0 and y1 == y0:
            x1, y1 = randint(-4, 4), randint(-4, 4)
        x_t = x0 + t * (x1 - x0)
        y_t = y0 + t * (y1 - y0)
        dx_dt = x1 - x0
        dy_dt = y1 - y0
        P_sub = P.subs([(x, x_t), (y, y_t)])
        Q_sub = Q.subs([(x, x_t), (y, y_t)])
        integrand = simplify(P_sub * dx_dt + Q_sub * dy_dt)
        ans = simplify(integrate(integrand, (t, 0, 1)))
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ along the segment from $({x0},{y0})$ to $({x1},{y1})$.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize: $\\mathbf{{r}}(t) = \\langle {latex(x_t)}, {latex(y_t)} \\rangle$, $t \\in [0,1]$",
                f"$d\\mathbf{{r}} = \\langle {dx_dt}, {dy_dt} \\rangle \\, dt$",
                f"$\\mathbf{{F}} \\cdot d\\mathbf{{r}} = ({latex(integrand)}) \\, dt$",
                f"$\\int_0^1 {latex(integrand)} \\, dt = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # F·dr along segment: F = <py, qx>
        p_coeff = nonzero(-5, 5)
        q_coeff = nonzero(-5, 5)
        P = p_coeff * y
        Q = q_coeff * x
        x0, y0 = randint(-3, 3), randint(-3, 3)
        x1, y1 = randint(-3, 3), randint(-3, 3)
        while x1 == x0 and y1 == y0:
            x1, y1 = randint(-3, 3), randint(-3, 3)
        x_t = x0 + t * (x1 - x0)
        y_t = y0 + t * (y1 - y0)
        dx_dt = x1 - x0
        dy_dt = y1 - y0
        P_sub = P.subs([(x, x_t), (y, y_t)])
        Q_sub = Q.subs([(x, x_t), (y, y_t)])
        integrand = simplify(P_sub * dx_dt + Q_sub * dy_dt)
        ans = simplify(integrate(integrand, (t, 0, 1)))
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ along the segment from $({x0},{y0})$ to $({x1},{y1})$.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize: $\\mathbf{{r}}(t) = \\langle {latex(x_t)}, {latex(y_t)} \\rangle$, $t \\in [0,1]$",
                f"$d\\mathbf{{r}} = \\langle {dx_dt}, {dy_dt} \\rangle \\, dt$",
                f"$\\mathbf{{F}} \\cdot d\\mathbf{{r}} = ({latex(integrand)}) \\, dt$",
                f"$\\int_0^1 {latex(integrand)} \\, dt = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Scalar line integral ∫f ds along straight line from origin
        func_type = randint(1, 3)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        if func_type == 1:
            f = a_val * x + b_val * y
        elif func_type == 2:
            f = a_val * x
        else:
            f = b_val * y
        x_t = a_val * t
        y_t = b_val * t
        dx_dt = diff(x_t, t)
        dy_dt = diff(y_t, t)
        ds = sqrt(dx_dt**2 + dy_dt**2)
        f_sub = f.subs([(x, x_t), (y, y_t)])
        integrand = simplify(f_sub * ds)
        ans = simplify(integrate(integrand, (t, 0, 1)))
        return problem(
            question=f"Evaluate $\\int_C {latex(f)} \\, ds$ where $C$ is the segment from $(0,0)$ to $({a_val},{b_val})$.",
            answer=ans,
            difficulty=(1350, 1550),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize: $x = {latex(x_t)}$, $y = {latex(y_t)}$, $t \\in [0,1]$",
                f"$ds = \\sqrt{{{latex(dx_dt)}^2 + {latex(dy_dt)}^2}} \\, dt = {latex(ds)} \\, dt$",
                f"$f(\\mathbf{{r}}(t)) = {latex(f_sub)}$",
                f"$\\int_C {latex(f)} \\, ds = \\int_0^1 {latex(integrand)} \\, dt = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Closed curve integral around rectangle using direct computation
        p_coeff = nonzero(-3, 3)
        q_coeff = nonzero(-3, 3)
        P = p_coeff * y
        Q = q_coeff * x
        a_val = randint(1, 5)
        b_val = randint(1, 5)
        int1 = integrate(P.subs(y, 0) * a_val, (t, 0, 1))
        int2 = integrate(Q.subs(x, a_val) * b_val, (t, 0, 1))
        int3 = integrate(P.subs(y, b_val) * (-a_val), (t, 0, 1))
        int4 = integrate(Q.subs(x, 0) * (-b_val), (t, 0, 1))
        ans = simplify(int1 + int2 + int3 + int4)
        return problem(
            question=f"Evaluate $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ and $C$ is the rectangle with vertices $(0,0)$, $({a_val},0)$, $({a_val},{b_val})$, $(0,{b_val})$ (CCW).",
            answer=ans,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Segment $C_1$: $(0,0) \\to ({a_val},0)$: $\\int = {latex(int1)}$",
                f"Segment $C_2$: $({a_val},0) \\to ({a_val},{b_val})$: $\\int = {latex(int2)}$",
                f"Segment $C_3$: $({a_val},{b_val}) \\to (0,{b_val})$: $\\int = {latex(int3)}$",
                f"Segment $C_4$: $(0,{b_val}) \\to (0,0)$: $\\int = {latex(int4)}$",
                f"Total: ${latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 5:
        # Conservative field: find potential function
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        phi_type = randint(1, 3)
        if phi_type == 1:
            phi = Rational(a_coeff, 2) * x**2 + Rational(b_coeff, 2) * y**2
        elif phi_type == 2:
            phi = a_coeff * x * y
        else:
            phi = a_coeff * x**2 * y + b_coeff * x
        P = diff(phi, x)
        Q = diff(phi, y)
        return problem(
            question=f"Find a potential function $\\varphi(x,y)$ for $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$.",
            answer=phi,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Check: $\\frac{{\\partial Q}}{{\\partial x}} = {latex(diff(Q,x))}$, $\\frac{{\\partial P}}{{\\partial y}} = {latex(diff(P,y))}$ (equal, so conservative)",
                f"Integrate $P$ w.r.t. $x$: $\\varphi = {latex(integrate(P, x))} + g(y)$",
                f"Differentiate w.r.t. $y$ and match $Q$: $g'(y) = 0$",
                f"$\\varphi(x,y) = {latex(phi)}$ (plus constant)"
            ),
            calculator="scientific"
        )

    else:
        # Conservative field: evaluate line integral via potential
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        phi = a_coeff * x**2 + b_coeff * y**2
        P = diff(phi, x)
        Q = diff(phi, y)
        x0, y0 = randint(-3, 3), randint(-3, 3)
        x1, y1 = randint(-3, 3), randint(-3, 3)
        while x1 == x0 and y1 == y0:
            x1, y1 = randint(-3, 3), randint(-3, 3)
        f_start = phi.subs([(x, x0), (y, y0)])
        f_end = phi.subs([(x, x1), (y, y1)])
        ans = f_end - f_start
        return problem(
            question=f"Evaluate $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ along any path from $({x0},{y0})$ to $({x1},{y1})$.",
            answer=ans,
            difficulty=(1400, 1580),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"$\\mathbf{{F}} = \\nabla \\varphi$ where $\\varphi = {latex(phi)}$ (conservative field)",
                f"$\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\varphi({x1},{y1}) - \\varphi({x0},{y0})$",
                f"$= {latex(f_end)} - {latex(f_start)} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
