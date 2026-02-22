"""
multivariable_calculus - greens_theorem (medium)
Generated: 2026-02-22T05:45:50.834917
"""

from problem_utils import *

def generate():
    problem_type = choice(['line_integral_to_double', 'circulation', 'area_via_greens', 'mixed_partial_check'])
    
    if problem_type == 'line_integral_to_double':
        # Standard Green's theorem: convert line integral to double integral
        # ∮_C (P dx + Q dy) = ∬_R (∂Q/∂x - ∂P/∂y) dA
        
        # Pick simple P and Q where the partial derivatives are clean
        p_type = choice(['poly', 'trig'])
        
        if p_type == 'poly':
            a1 = nonzero(-4, 4)
            b1 = nonzero(-4, 4)
            P_expr = a1 * x + b1 * y
            
            a2 = nonzero(-4, 4)
            b2 = nonzero(-4, 4)
            Q_expr = a2 * x + b2 * y
        else:
            a1 = choice([-2, -1, 1, 2])
            P_expr = a1 * sin(y)
            
            a2 = choice([-2, -1, 1, 2])
            Q_expr = a2 * cos(x)
        
        # Compute ∂Q/∂x - ∂P/∂y
        dQ_dx = diff(Q_expr, x)
        dP_dy = diff(P_expr, y)
        integrand = simplify(dQ_dx - dP_dy)
        
        # Region: simple rectangle or circle
        region_type = choice(['rectangle', 'circle'])
        
        if region_type == 'rectangle':
            x1, x2 = sorted([randint(-3, 0), randint(1, 3)])
            y1, y2 = sorted([randint(-3, 0), randint(1, 3)])
            region_desc = f"the rectangle with vertices $({x1},{y1})$, $({x2},{y1})$, $({x2},{y2})$, $({x1},{y2})$"
            
            # Compute the double integral
            inner = integrate(integrand, (y, y1, y2))
            ans = integrate(inner, (x, x1, x2))
            
            sol = steps(
                f"By Green's theorem: $\\oint_C \\left({latex(P_expr)}\\right)dx + \\left({latex(Q_expr)}\\right)dy = \\iint_R \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)dA$",
                f"Compute $\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$ and $\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"So the integrand is ${latex(integrand)}$",
                f"$\\int_{{{x1}}}^{{{x2}}} \\int_{{{y1}}}^{{{y2}}} {latex(integrand)} \\, dy \\, dx = {latex(ans)}$"
            )
        else:
            r = randint(1, 3)
            region_desc = f"the circle $x^2 + y^2 = {r**2}$"
            
            # For circle, compute using polar or by direct integration
            # For constant integrand, answer is integrand * area
            if integrand.is_number:
                ans = integrand * pi * r**2
                sol = steps(
                    f"By Green's theorem: $\\oint_C \\left({latex(P_expr)}\\right)dx + \\left({latex(Q_expr)}\\right)dy = \\iint_R \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)dA$",
                    f"Compute $\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$ and $\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                    f"So the integrand is ${latex(integrand)}$",
                    f"The area of the circle is $\\pi \\cdot {r}^2 = {latex(pi * r**2)}$",
                    f"Answer: ${latex(integrand)} \\cdot {latex(pi * r**2)} = {latex(ans)}$"
                )
            else:
                # Use polar coordinates
                integrand_polar = integrand.subs([(x, r*cos(t)), (y, r*sin(t))])
                inner = integrate(integrand_polar * r, (r, 0, r))
                ans = integrate(inner, (t, 0, 2*pi))
                ans = simplify(ans)
                sol = steps(
                    f"By Green's theorem: $\\oint_C \\left({latex(P_expr)}\\right)dx + \\left({latex(Q_expr)}\\right)dy = \\iint_R \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)dA$",
                    f"Compute $\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$ and $\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                    f"So the integrand is ${latex(integrand)}$",
                    f"Using polar coordinates: $\\int_0^{{2\\pi}} \\int_0^{{{r}}} {latex(integrand)} \\, r \\, dr \\, d\\theta = {latex(ans)}$"
                )
        
        return problem(
            question=f"Use Green's theorem to evaluate $\\oint_C \\left({latex(P_expr)}\\right)dx + \\left({latex(Q_expr)}\\right)dy$ where $C$ is {region_desc}, oriented counterclockwise.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/greens_theorem",
            solution=sol
        )
    
    elif problem_type == 'circulation':
        # Compute circulation using Green's theorem
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        P_expr = -a * y
        Q_expr = b * x
        
        dQ_dx = diff(Q_expr, x)
        dP_dy = diff(P_expr, y)
        curl = simplify(dQ_dx - dP_dy)
        
        # Rectangle region
        x1, x2 = 0, randint(2, 4)
        y1, y2 = 0, randint(2, 4)
        
        area = (x2 - x1) * (y2 - y1)
        ans = curl * area
        
        return problem(
            question=f"Calculate the circulation $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}}$ where $\\mathbf{{F}} = \\langle {latex(P_expr)}, {latex(Q_expr)} \\rangle$ and $C$ is the boundary of the rectangle $[{x1},{x2}] \\times [{y1},{y2}]$, oriented counterclockwise.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Using Green's theorem: $\\oint_C \\mathbf{{F}} \\cdot d\\mathbf{{r}} = \\iint_R \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right) dA$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$, $\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"Curl: ${latex(curl)}$",
                f"Area of rectangle: ${area}$",
                f"Answer: ${latex(curl)} \\cdot {area} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 'area_via_greens':
        # Use Green's theorem to find area: A = (1/2)∮(x dy - y dx)
        r = randint(2, 5)
        
        return problem(
            question=f"Use Green's theorem with $P = -y$ and $Q = x$ to find the area enclosed by the circle $x^2 + y^2 = {r**2}$.",
            answer=pi * r**2,
            difficulty=(1400, 1600),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Green's theorem: $\\iint_R \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right) dA = \\oint_C (P\\,dx + Q\\,dy)$",
                f"With $P = -y$ and $Q = x$: $\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = 1 - (-1) = 2$",
                f"So $2 \\cdot \\text{{Area}} = \\oint_C (-y\\,dx + x\\,dy)$",
                f"Therefore: $\\text{{Area}} = \\frac{1}{2} \\oint_C (x\\,dy - y\\,dx)$",
                f"The area of the circle is $\\pi r^2 = \\pi \\cdot {r}^2 = {latex(pi * r**2)}$"
            )
        )
    
    else:  # mixed_partial_check
        # Check if Green's theorem applies by verifying mixed partials
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        # Create P and Q where sometimes ∂Q/∂x = ∂P/∂y and sometimes not
        conservative = choice([True, False])
        
        if conservative:
            P_expr = a * x * y + b * y**2
            Q_expr = Rational(a, 2) * x**2 + 2 * b * x * y + c
            dQ_dx = diff(Q_expr, x)
            dP_dy = diff(P_expr, y)
            ans = 0  # Conservative field has zero circulation
        else:
            P_expr = a * x * y + b * y
            Q_expr = c * x**2 + b * y
            dQ_dx = diff(Q_expr, x)
            dP_dy = diff(P_expr, y)
            ans = dQ_dx - dP_dy
        
        x1, x2 = 0, randint(2, 3)
        y1, y2 = 0, randint(2, 3)
        area = (x2 - x1) * (y2 - y1)
        final_ans = simplify(ans * area)
        
        return problem(
            question=f"Evaluate $\\oint_C \\left({latex(P_expr)}\\right)dx + \\left({latex(Q_expr)}\\right)dy$ where $C$ is the rectangle $[{x1},{x2}] \\times [{y1},{y2}]$ oriented counterclockwise.",
            answer=final_ans,
            difficulty=(1300, 1500),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Apply Green's theorem: $\\oint_C P\\,dx + Q\\,dy = \\iint_R \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right) dA$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$",
                f"$\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"Integrand: ${latex(simplify(dQ_dx - dP_dy))}$",
                f"Area: ${area}$",
                f"Answer: ${latex(final_ans)}$"
            )
        )

emit(generate())