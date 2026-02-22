"""
differential_equations - exact_equations (easy)
Generated: 2026-02-22T05:21:35.471571
"""

from problem_utils import *

def generate():
    # For easier exact equations (1000-1300 ELO), we want simple problems where:
    # - The exactness condition is easy to check
    # - Integration is straightforward
    # - The implicit solution is simple
    
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # Easiest: Simple separable form that's also exact
        # (2x + y)dx + (x)dy = 0
        # M = 2x + y, N = x
        # dM/dy = 1, dN/dx = 1, so exact
        # ELO ~1000-1100
        
        a = randint(2, 5)
        b = randint(1, 4)
        
        M = a*x + b*y
        N = b*x
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        # Verify exactness
        assert dM_dy == dN_dx
        
        # Find solution by integrating M with respect to x
        f = integrate(M, x)  # gives a*x^2/2 + b*x*y
        # Add any function of y alone: take derivative with respect to y
        df_dy = diff(f, y)
        # df_dy should equal N, so we need df_dy + g'(y) = N
        g_prime = N - df_dy
        
        if g_prime == 0:
            C_const = symbols('C')
            solution = Eq(f, C_const)
        else:
            g = integrate(g_prime, y)
            C_const = symbols('C')
            solution = Eq(f + g, C_const)
        
        question = f"Verify that the differential equation $({latex(M)})dx + ({latex(N)})dy = 0$ is exact and find its implicit solution."
        
        ans = solution
        
        sol_steps = steps(
            f"Check exactness: $M = {latex(M)}$, $N = {latex(N)}$",
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$, $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
            f"Since $\\frac{{\\partial M}}{{\\partial y}} = \\frac{{\\partial N}}{{\\partial x}}$, the equation is exact.",
            f"Integrate $M$ with respect to $x$: $\\int ({latex(M)})dx = {latex(f)} + g(y)$",
            f"Differentiate with respect to $y$: $\\frac{{\\partial}}{{\\partial y}}[{latex(f)} + g(y)] = {latex(df_dy)} + g'(y)$",
            f"Set equal to $N$: ${latex(df_dy)} + g'(y) = {latex(N)}$",
            f"Solve for $g'(y)$: $g'(y) = {latex(g_prime)}$" if g_prime != 0 else f"$g'(y) = 0$, so $g(y) = 0$",
            f"Therefore, the implicit solution is ${latex(solution)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )
    
    elif difficulty_choice == 2:
        # Medium-easy: Check if exact (yes)
        # (2xy + 3)dx + (x^2 + 4y)dy = 0
        # ELO ~1100-1200
        
        a = randint(2, 4)
        b = randint(1, 3)
        c = randint(2, 5)
        
        M = a*x*y + b
        N = x**2 + c*y
        
        dM_dy = diff(M, y)
        dN_dx = diff(N, x)
        
        # Verify exactness
        assert dM_dy == dN_dx
        
        # Integrate M with respect to x
        f = integrate(M, x)
        df_dy = diff(f, y)
        g_prime = N - df_dy
        g = integrate(g_prime, y)
        
        C_const = symbols('C')
        solution = Eq(f + g, C_const)
        
        question = f"Solve the exact differential equation $({latex(M)})dx + ({latex(N)})dy = 0$."
        
        sol_steps = steps(
            f"Verify exactness: $M = {latex(M)}$, $N = {latex(N)}$",
            f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$, $\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$ ✓",
            f"Integrate $M$ with respect to $x$: ${latex(f)} + g(y)$",
            f"Differentiate: $\\frac{{\\partial}}{{\\partial y}}[{latex(f)}] = {latex(df_dy)}$",
            f"From $N$: ${latex(df_dy)} + g'(y) = {latex(N)}$",
            f"$g'(y) = {latex(g_prime)}$, so $g(y) = {latex(g)}$",
            f"Solution: ${latex(solution)}$"
        )
        
        return problem(
            question=question,
            answer=solution,
            difficulty=(1100, 1200),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="equation"
        )
    
    else:
        # Check exactness (students determine yes/no)
        # ELO ~1200-1300
        
        is_exact = choice([True, False])
        
        if is_exact:
            # Make an exact equation
            a = randint(2, 4)
            b = randint(1, 3)
            M = a*x*y + b*x
            N = a*x**2/2 + y
            
            dM_dy = diff(M, y)
            dN_dx = diff(N, x)
            
            question = f"Is the differential equation $({latex(M)})dx + ({latex(N)})dy = 0$ exact?"
            ans = True
            
            sol_steps = steps(
                f"$M = {latex(M)}$, $N = {latex(N)}$",
                f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
                f"$\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
                f"Since $\\frac{{\\partial M}}{{\\partial y}} = \\frac{{\\partial N}}{{\\partial x}}$, the equation is exact."
            )
        else:
            # Make a non-exact equation
            a = randint(2, 4)
            b = randint(1, 3)
            c = randint(1, 3)
            M = a*x + b*y
            N = c*x + y
            
            dM_dy = diff(M, y)
            dN_dx = diff(N, x)
            
            # Make sure they're different
            while dM_dy == dN_dx:
                c = randint(1, 5)
                N = c*x + y
                dN_dx = diff(N, x)
            
            question = f"Is the differential equation $({latex(M)})dx + ({latex(N)})dy = 0$ exact?"
            ans = False
            
            sol_steps = steps(
                f"$M = {latex(M)}$, $N = {latex(N)}$",
                f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(dM_dy)}$",
                f"$\\frac{{\\partial N}}{{\\partial x}} = {latex(dN_dx)}$",
                f"Since $\\frac{{\\partial M}}{{\\partial y}} \\neq \\frac{{\\partial N}}{{\\partial x}}$, the equation is not exact."
            )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1300),
            topic="differential_equations/exact_equations",
            solution=sol_steps,
            answer_type="boolean"
        )

emit(generate())