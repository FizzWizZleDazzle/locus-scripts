"""
multivariable_calculus - line_integrals (medium)
Generated: 2026-02-22T05:44:04.290906
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Line integral of a vector field along a straight line segment
        # Type: ∫_C F·dr where C is a line segment
        
        # Pick a simple vector field F = <P, Q>
        p_coeff = nonzero(-3, 3)
        q_coeff = nonzero(-3, 3)
        
        # Choose if field depends on x, y, or both
        field_type = randint(1, 3)
        if field_type == 1:
            P = p_coeff * x
            Q = q_coeff * y
        elif field_type == 2:
            P = p_coeff * y
            Q = q_coeff * x
        else:
            P = p_coeff
            Q = q_coeff
        
        # Line segment from (x0, y0) to (x1, y1)
        x0, y0 = randint(-3, 3), randint(-3, 3)
        x1, y1 = randint(-3, 3), randint(-3, 3)
        while x1 == x0 and y1 == y0:
            x1, y1 = randint(-3, 3), randint(-3, 3)
        
        # Parameterize: r(t) = (x0, y0) + t((x1-x0), (y1-y0)), t in [0,1]
        x_t = x0 + t * (x1 - x0)
        y_t = y0 + t * (y1 - y0)
        
        # dr = <dx, dy> = <(x1-x0)dt, (y1-y0)dt>
        dx_dt = x1 - x0
        dy_dt = y1 - y0
        
        # Substitute into F·dr
        P_sub = P.subs([(x, x_t), (y, y_t)])
        Q_sub = Q.subs([(x, x_t), (y, y_t)])
        
        integrand = P_sub * dx_dt + Q_sub * dy_dt
        integrand = simplify(integrand)
        
        ans = integrate(integrand, (t, 0, 1))
        ans = simplify(ans)
        
        return problem(
            question=f"Evaluate the line integral $\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ and $C$ is the line segment from $({x0}, {y0})$ to $({x1}, {y1})$.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize the line segment: $\\mathbf{{r}}(t) = \\langle {latex(x_t)}, {latex(y_t)} \\rangle$ for $t \\in [0, 1]$",
                f"Compute $d\\mathbf{{r}} = \\langle {dx_dt}, {dy_dt} \\rangle \\, dt$",
                f"Substitute into $\\mathbf{{F}}$: $\\mathbf{{F}}(\\mathbf{{r}}(t)) = \\langle {latex(P_sub)}, {latex(Q_sub)} \\rangle$",
                f"$\\mathbf{{F}} \\cdot d\\mathbf{{r}} = ({latex(integrand)}) \\, dt$",
                f"$\\int_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\int_0^1 {latex(integrand)} \\, dt = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Line integral of a scalar function along a curve
        # Type: ∫_C f ds
        
        # Pick a simple scalar function
        func_type = randint(1, 2)
        if func_type == 1:
            f = x + y
        else:
            f = x * y
        
        # Use a simple parameterized curve
        curve_type = randint(1, 2)
        if curve_type == 1:
            # Straight line from (0,0) to (a,b)
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            x_t = a_val * t
            y_t = b_val * t
            t_range = (0, 1)
            curve_desc = f"the line segment from $(0, 0)$ to $({a_val}, {b_val})$"
        else:
            # Circle arc or simple curve
            r_val = randint(1, 3)
            x_t = r_val * cos(t)
            y_t = r_val * sin(t)
            t_range = (0, pi/2)
            curve_desc = f"the quarter circle of radius ${r_val}$ from $({r_val}, 0)$ to $(0, {r_val})$"
        
        # Compute ds = sqrt((dx/dt)^2 + (dy/dt)^2) dt
        dx_dt = diff(x_t, t)
        dy_dt = diff(y_t, t)
        ds = sqrt(dx_dt**2 + dy_dt**2)
        
        # Substitute into f
        f_sub = f.subs([(x, x_t), (y, y_t)])
        
        integrand = f_sub * ds
        integrand = simplify(integrand)
        
        ans = integrate(integrand, t_range)
        ans = simplify(ans)
        
        return problem(
            question=f"Evaluate the line integral $\\int_C {latex(f)} \\, ds$ where $C$ is {curve_desc}.",
            answer=ans,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Parameterize $C$: $\\mathbf{{r}}(t) = \\langle {latex(x_t)}, {latex(y_t)} \\rangle$ for $t \\in [{latex(t_range[0])}, {latex(t_range[1])}]$",
                f"Compute $\\frac{{d\\mathbf{{r}}}}{{dt}} = \\langle {latex(dx_dt)}, {latex(dy_dt)} \\rangle$",
                f"$ds = \\left\\|\\frac{{d\\mathbf{{r}}}}{{dt}}\\right\\| dt = {latex(ds)} \\, dt$",
                f"Substitute: $f(\\mathbf{{r}}(t)) = {latex(f_sub)}$",
                f"$\\int_C f \\, ds = \\int_{{{latex(t_range[0])}}}^{{{latex(t_range[1])}}} {latex(integrand)} \\, dt = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Line integral around a simple closed curve (work calculation)
        # Type: ∫_C F·dr around a rectangle or triangle
        
        # Vector field
        p_coeff = nonzero(-2, 2)
        q_coeff = nonzero(-2, 2)
        P = p_coeff * y
        Q = q_coeff * x
        
        # Rectangle with corners at (0,0), (a,0), (a,b), (0,b)
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        
        # Compute along each segment
        # Segment 1: (0,0) to (a,0)
        int1 = integrate(P.subs(y, 0) * a_val, (t, 0, 1))
        
        # Segment 2: (a,0) to (a,b)
        int2 = integrate(Q.subs(x, a_val) * b_val, (t, 0, 1))
        
        # Segment 3: (a,b) to (0,b)
        int3 = integrate(P.subs(y, b_val) * (-a_val), (t, 0, 1))
        
        # Segment 4: (0,b) to (0,0)
        int4 = integrate(Q.subs(x, 0) * (-b_val), (t, 0, 1))
        
        ans = simplify(int1 + int2 + int3 + int4)
        
        return problem(
            question=f"Evaluate $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$ and $C$ is the rectangle with vertices $(0, 0)$, $({a_val}, 0)$, $({a_val}, {b_val})$, $(0, {b_val})$, traversed counterclockwise.",
            answer=ans,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Break into four segments and parameterize each:",
                f"$C_1$: $(0,0)$ to $({a_val},0)$: contribution = ${latex(int1)}$",
                f"$C_2$: $({a_val},0)$ to $({a_val},{b_val})$: contribution = ${latex(int2)}$",
                f"$C_3$: $({a_val},{b_val})$ to $(0,{b_val})$: contribution = ${latex(int3)}$",
                f"$C_4$: $(0,{b_val})$ to $(0,0)$: contribution = ${latex(int4)}$",
                f"Total: ${latex(ans)}$"
            ),
        )
    
    else:
        # Conservative field check or potential function
        # Given F, find potential function φ such that F = ∇φ
        
        # Start with a potential function
        phi_type = randint(1, 2)
        if phi_type == 1:
            a_coeff = nonzero(-3, 3)
            b_coeff = nonzero(-3, 3)
            phi = Rational(a_coeff, 2) * x**2 + Rational(b_coeff, 2) * y**2
        else:
            a_coeff = nonzero(-2, 2)
            phi = a_coeff * x * y
        
        P = diff(phi, x)
        Q = diff(phi, y)
        
        return problem(
            question=f"Find a potential function $\\varphi(x, y)$ for the conservative vector field $\\mathbf{{F}} = \\langle {latex(P)}, {latex(Q)} \\rangle$.",
            answer=phi,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/line_integrals",
            solution=steps(
                f"Since $\\mathbf{{F}} = \\langle P, Q \\rangle$ is conservative, we need $\\nabla \\varphi = \\mathbf{{F}}$",
                f"From $\\frac{{\\partial \\varphi}}{{\\partial x}} = {latex(P)}$, integrate with respect to $x$",
                f"From $\\frac{{\\partial \\varphi}}{{\\partial y}} = {latex(Q)}$, integrate with respect to $y$",
                f"Combining both conditions: $\\varphi(x, y) = {latex(phi)}$ (plus any constant)"
            ),
        )

emit(generate())