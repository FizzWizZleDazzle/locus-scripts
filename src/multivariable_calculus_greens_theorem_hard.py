"""
multivariable_calculus - greens_theorem (hard)
Generated: 2026-02-22T05:46:20.574563
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Green's theorem on a polynomial line integral around a closed curve
        # Pick a region and compute circulation using Green's theorem
        
        # Choose coefficients for vector field F = <P, Q>
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        c_coeff = nonzero(-4, 4)
        d_coeff = nonzero(-4, 4)
        
        # Create P and Q with partial derivatives
        P = a_coeff*x**2 + b_coeff*y
        Q = c_coeff*x + d_coeff*y**2
        
        # Compute curl (∂Q/∂x - ∂P/∂y)
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        curl = dQ_dx - dP_dy
        
        # Use a simple rectangular region [0,a] × [0,b]
        x_lim = randint(1, 3)
        y_lim = randint(1, 3)
        
        # Integrate curl over the region
        ans = integrate(integrate(curl, (y, 0, y_lim)), (x, 0, x_lim))
        
        region_desc = f"rectangle with vertices $(0,0)$, $({x_lim},0)$, $({x_lim},{y_lim})$, $(0,{y_lim})$"
        
        return problem(
            question=f"Use Green's theorem to evaluate $\\oint_C {latex(P)}\\,dx + {latex(Q)}\\,dy$ where $C$ is the boundary of the {region_desc}, traversed counterclockwise.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Green's theorem states $\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)\\,dA$",
                f"Here $P = {latex(P)}$ and $Q = {latex(Q)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$",
                f"$\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = {latex(curl)}$",
                f"$\\iint_D {latex(curl)}\\,dA = \\int_0^{{{x_lim}}} \\int_0^{{{y_lim}}} {latex(curl)}\\,dy\\,dx = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Green's theorem to find area using line integral
        # Area = (1/2) ∮ (x dy - y dx)
        
        # Circular region: x = a*cos(t), y = a*sin(t)
        radius = randint(2, 5)
        
        # Area of circle
        ans = pi * radius**2
        
        return problem(
            question=f"Use Green's theorem to find the area enclosed by the circle $x^2 + y^2 = {radius**2}$. (Hint: Area $= \\frac{{1}}{{2}}\\oint_C x\\,dy - y\\,dx$)",
            answer=ans,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Using the formula Area $= \\frac{{1}}{{2}}\\oint_C x\\,dy - y\\,dx$",
                f"By Green's theorem with $P = -y$ and $Q = x$:",
                f"Area $= \\frac{{1}}{{2}}\\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)\\,dA = \\frac{{1}}{{2}}\\iint_D (1 - (-1))\\,dA = \\iint_D 1\\,dA$",
                f"For the circle $x^2 + y^2 = {radius**2}$:",
                f"Area $= \\pi r^2 = \\pi \\cdot {radius}^2 = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Verify Green's theorem by computing both line integral and double integral
        # Use a triangular region for tractability
        
        # Vector field coefficients
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-3, 3)
        
        P = a_coeff*y
        Q = b_coeff*x
        
        # Compute curl
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        curl = simplify(dQ_dx - dP_dy)
        
        # Triangle with vertices (0,0), (a,0), (0,b)
        a_val = randint(2, 4)
        b_val = randint(2, 4)
        
        # Double integral over triangle
        ans = integrate(integrate(curl, (y, 0, b_val - b_val*x/a_val)), (x, 0, a_val))
        
        return problem(
            question=f"Use Green's theorem to evaluate $\\oint_C {latex(P)}\\,dx + {latex(Q)}\\,dy$ where $C$ is the boundary of the triangle with vertices $(0,0)$, $({a_val},0)$, and $(0,{b_val})$, traversed counterclockwise.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"By Green's theorem: $\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)\\,dA$",
                f"$P = {latex(P)}$, $Q = {latex(Q)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$, $\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"Curl $= {latex(curl)}$",
                f"The triangle has bounds: $0 \\le x \\le {a_val}$, $0 \\le y \\le {b_val} - \\frac{{{b_val}}}{{{a_val}}}x$",
                f"$\\int_0^{{{a_val}}} \\int_0^{{{b_val} - b_val*x/{a_val}}} {latex(curl)}\\,dy\\,dx = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Type 4: Green's theorem with exponential or trigonometric functions
        
        # Choose functions
        func_choice = randint(1, 2)
        
        if func_choice == 1:
            # Exponential
            P = exp(x) + y
            Q = exp(y) + x
        else:
            # Trigonometric
            P = sin(y) + x
            Q = cos(x) + y
        
        dQ_dx = diff(Q, x)
        dP_dy = diff(P, y)
        curl = simplify(dQ_dx - dP_dy)
        
        # Use square region [0,1] × [0,1] for simpler computation
        ans = integrate(integrate(curl, (y, 0, 1)), (x, 0, 1))
        
        return problem(
            question=f"Use Green's theorem to evaluate $\\oint_C {latex(P)}\\,dx + {latex(Q)}\\,dy$ where $C$ is the boundary of the unit square $[0,1] \\times [0,1]$, traversed counterclockwise.",
            answer=ans,
            difficulty=(1750, 1900),
            topic="multivariable_calculus/greens_theorem",
            solution=steps(
                f"Apply Green's theorem: $\\oint_C P\\,dx + Q\\,dy = \\iint_D \\left(\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}}\\right)\\,dA$",
                f"$P = {latex(P)}$, $Q = {latex(Q)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} = {latex(dQ_dx)}$",
                f"$\\frac{{\\partial P}}{{\\partial y}} = {latex(dP_dy)}$",
                f"$\\frac{{\\partial Q}}{{\\partial x}} - \\frac{{\\partial P}}{{\\partial y}} = {latex(curl)}$",
                f"$\\int_0^1 \\int_0^1 {latex(curl)}\\,dy\\,dx = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())