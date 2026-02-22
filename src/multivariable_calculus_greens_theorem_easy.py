"""
multivariable_calculus - greens_theorem (easy)
Generated: 2026-02-22T05:45:11.434535
"""

from problem_utils import *

def generate():
    # For easier Green's theorem problems (1000-1300), we focus on:
    # - Simple closed curves (rectangles, triangles)
    # - Simple vector fields with constant or linear components
    # - Direct application of the theorem without complex calculations
    
    problem_type = randint(1, 3)
    
    if problem_type == 1:
        # Type 1: Verify Green's theorem on a rectangle with simple vector field
        # F = P i + Q j where P and Q are simple linear functions
        
        # Simple coefficients
        p_coeff = randint(1, 3)
        q_coeff = randint(1, 3)
        
        # Vector field: F = p_coeff*y i + q_coeff*x j
        P = p_coeff * y
        Q = q_coeff * x
        
        # Rectangle boundaries
        x_max = randint(2, 4)
        y_max = randint(2, 4)
        
        # Compute partial derivatives
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        
        # Double integral: ∬(∂Q/∂x - ∂P/∂y) dA
        integrand = dQ_dx - dP_dy
        ans = integrate(integrate(integrand, (x, 0, x_max)), (y, 0, y_max))
        
        return problem(
            question=f"Use Green's theorem to evaluate the line integral $\\oint_C ({latex(P)})\\,dx + ({latex(Q)})\\,dy$ where $C$ is the rectangle with vertices $(0,0)$, $({x_max},0)$, $({x_max},{y_max})$, and $(0,{y_max})$, oriented counterclockwise.",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Green's theorem states: $\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)\\,dA$",
                f"Here $P = {latex(P)}$ and $Q = {latex(Q)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$",
                f"$\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = {latex(integrand)}$",
                f"$\\iint_D {latex(integrand)}\\,dA = \\int_0^{{{y_max}}} \\int_0^{{{x_max}}} {latex(integrand)}\\,dx\\,dy = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Compute ∂Q/∂x - ∂P/∂y for a simple vector field
        # This tests understanding of the core formula without the full integral
        
        p_x_coeff = nonzero(-3, 3)
        q_y_coeff = nonzero(-3, 3)
        
        # F = p_x_coeff*x i + q_y_coeff*y j
        P = p_x_coeff * x
        Q = q_y_coeff * y
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        ans = dQ_dx - dP_dy
        
        return problem(
            question=f"For the vector field $\\mathbf{{F}} = ({latex(P)})\\mathbf{{i}} + ({latex(Q)})\\mathbf{{j}}$, compute $\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}$ where $P = {latex(P)}$ and $Q = {latex(Q)}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"$P = {latex(P)}$, so $\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"$Q = {latex(Q)}$, so $\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = {latex(dQ_dx)} - ({latex(dP_dy)}) = {latex(ans)}$"
            )
        )
    
    else:
        # Type 3: Green's theorem on a triangle with very simple vector field
        
        # Simple constant field components
        const_p = randint(1, 4)
        const_q = randint(1, 4)
        
        P = const_p
        Q = const_q
        
        # Right triangle with legs along axes
        base = randint(2, 4)
        height = randint(2, 4)
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        integrand = dQ_dx - dP_dy
        
        # Area of triangle
        area = Rational(base * height, 2)
        ans = integrand * area
        
        return problem(
            question=f"Use Green's theorem to evaluate $\\oint_C {const_p}\\,dx + {const_q}\\,dy$ where $C$ is the triangle with vertices $(0,0)$, $({base},0)$, and $(0,{height})$, oriented counterclockwise.",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Green's theorem: $\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)\\,dA$",
                f"Here $P = {const_p}$ and $Q = {const_q}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$ and $\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = {latex(integrand)}$",
                f"The area of the triangle is $\\frac{{1}}{{2}} \\cdot {base} \\cdot {height} = {latex(area)}$",
                f"$\\iint_D {latex(integrand)}\\,dA = {latex(integrand)} \\cdot {latex(area)} = {ans}$"
            ),
            calculator="scientific"
        )

emit(generate())