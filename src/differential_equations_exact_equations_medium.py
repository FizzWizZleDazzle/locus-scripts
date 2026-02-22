"""
differential_equations - exact_equations (medium)
Generated: 2026-02-22T05:22:03.153996
"""

from problem_utils import *

def generate():
    # Generate an exact differential equation
    # We'll create problems of the form M(x,y)dx + N(x,y)dy = 0
    # where ∂M/∂y = ∂N/∂x (exactness condition)
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple polynomial exact equation (ELO ~1300-1400)
        # Start with a potential function F(x,y) and derive M, N from it
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        
        # Potential function: F(x,y) = a*x^2 + b*xy + c*y^2
        F = a_val*x**2 + b_val*x*y + c_val*y**2
        M = diff(F, x)
        N = diff(F, y)
        
        # Verify exactness
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        question = f"Determine if the differential equation ${latex(M)}\\,dx + ({latex(N)})\\,dy = 0$ is exact."
        
        is_exact = simplify(dM_dy - dN_dx) == 0
        ans = is_exact
        
        if is_exact:
            sol_steps = steps(
                f"Check if $\\frac{{\\partial M}}{{\\partial y}} = \\frac{{\\partial N}}{{\\partial x}}$",
                f"$M = {latex(M)}$, so $\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
                f"$N = {latex(N)}$, so $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
                f"Since $\\frac{{\\partial M}}{{\\partial y}} = \\frac{{\\partial N}}{{\\partial x}}$, the equation is exact."
            )
        else:
            sol_steps = steps(
                f"Check if $\\frac{{\\partial M}}{{\\partial y}} = \\frac{{\\partial N}}{{\\partial x}}$",
                f"$M = {latex(M)}$, so $\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
                f"$N = {latex(N)}$, so $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
                f"Since $\\frac{{\\partial M}}{{\\partial y}} \\neq \\frac{{\\partial N}}{{\\partial x}}$, the equation is not exact."
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1400),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="boolean"
        )
    
    elif problem_type == 2:
        # Type 2: Find the solution of an exact equation (ELO ~1400-1500)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        
        # Potential function: F(x,y) = a*x*y + b*x^2
        F = a_val*x*y + b_val*x**2
        M = diff(F, x)
        N = diff(F, y)
        
        # Solution is F(x,y) = C
        ans = Eq(F, c)
        
        question = f"Solve the exact differential equation ${latex(M)}\\,dx + ({latex(N)})\\,dy = 0$. Express your answer as an equation in terms of $x$, $y$, and an arbitrary constant $c$."
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        # Integrate M with respect to x
        integral_M = integrate(M, x)
        
        sol_steps = steps(
            f"Verify exactness: $\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$ and $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$. The equation is exact.",
            f"Integrate $M = {latex(M)}$ with respect to $x$: $\\int {latex(M)}\\,dx = {latex(integral_M)} + g(y)$",
            f"Differentiate with respect to $y$: $\\frac{{\\partial}}{{\\partial y}}[{latex(integral_M)} + g(y)] = {latex(diff(integral_M, y))} + g'(y)$",
            f"Set equal to $N = {latex(N)}$: ${latex(diff(integral_M, y))} + g'(y) = {latex(N)}$",
            f"Solve for $g'(y)$ and integrate to find $g(y)$",
            f"Solution: ${latex(F)} = c$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )
    
    elif problem_type == 3:
        # Type 3: Exact equation with exponential/trig (ELO ~1500-1600)
        a_val = nonzero(-2, 2)
        
        # Potential function: F(x,y) = a*x*e^y
        F = a_val*x*exp(y)
        M = diff(F, x)
        N = diff(F, y)
        
        ans = Eq(F, c)
        
        question = f"Solve the exact differential equation ${latex(M)}\\,dx + ({latex(N)})\\,dy = 0$. Express your answer as an equation in terms of $x$, $y$, and an arbitrary constant $c$."
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        sol_steps = steps(
            f"Check exactness: $\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$, $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$. Exact.",
            f"Integrate $M = {latex(M)}$ with respect to $x$: $F(x,y) = {latex(integrate(M, x))} + g(y)$",
            f"Differentiate with respect to $y$ and compare to $N$",
            f"Solution: ${latex(F)} = c$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1500, 1600),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )
    
    else:
        # Type 4: Check exactness with more complex terms (ELO ~1400-1500)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        
        # Create a non-exact equation by design
        M = a_val*x + b_val*y**2
        N = c_val*x*y
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        is_exact = simplify(dM_dy - dN_dx) == 0
        ans = is_exact
        
        question = f"Is the differential equation ${latex(M)}\\,dx + ({latex(N)})\\,dy = 0$ exact?"
        
        sol_steps = steps(
            f"Compute $\\frac{{\\partial M}}{{\\partial y}}$ where $M = {latex(M)}$",
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
            f"Compute $\\frac{{\\partial N}}{{\\partial x}}$ where $N = {latex(N)}$",
            f"$\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
            f"Compare: {latex(dM_dy)} {'=' if is_exact else '≠'} {latex(dN_dx)}",
            f"The equation is {'exact' if is_exact else 'not exact'}."
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1500),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="boolean"
        )

emit(generate())