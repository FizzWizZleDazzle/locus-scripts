"""
differential_equations - exact_equations (hard)
Generated: 2026-02-22T05:22:36.394900
"""

from problem_utils import *

def generate():
    # For exact equations (1600-1900 ELO), we need complex problems involving:
    # - Non-trivial exactness checking
    # - Integration that requires careful path selection
    # - Problems requiring integrating factors
    # - Mixed partial derivatives verification
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Exact equation with trigonometric and polynomial terms (1600-1700)
        # M(x,y)dx + N(x,y)dy = 0 where M_y = N_x
        
        # Build from a potential function F(x,y)
        # F = x^2*y + sin(y) + x*y^2
        a_coef = nonzero(-3, 3)
        b_coef = nonzero(-3, 3)
        
        F = a_coef*x**2*y + sin(y) + b_coef*x*y**2
        M = diff(F, x)
        N = diff(F, y)
        
        ans = simplify(F)
        
        return problem(
            question=f"Solve the exact differential equation: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$",
            answer=fmt_equation(ans, "C"),
            difficulty=(1600, 1700),
            topic="differential_equations/exact_equations",
            answer_type="equation",
            solution=steps(
                f"Check if exact: $M = {latex(M)}$, $N = {latex(N)}$",
                f"$\\frac{{\\partial M}}{{\\partial y}} = {latex(diff(M, y))}$",
                f"$\\frac{{\\partial N}}{{\\partial x}} = {latex(diff(N, x))}$",
                f"Since $\\frac{{\\partial M}}{{\\partial y}} = \\frac{{\\partial N}}{{\\partial x}}$, the equation is exact.",
                f"Find $F(x,y)$ where $\\frac{{\\partial F}}{{\\partial x}} = {latex(M)}$",
                f"Integrate: $F = \\int {latex(M)} \\, dx = {latex(integrate(M, x))} + g(y)$",
                f"Take $\\frac{{\\partial F}}{{\\partial y}} = {latex(diff(integrate(M, x), y))} + g'(y) = {latex(N)}$",
                f"So $g'(y) = {latex(simplify(N - diff(integrate(M, x), y)))}$",
                f"Integrate: $g(y) = {latex(integrate(simplify(N - diff(integrate(M, x), y)), y))}$",
                f"Therefore, $F(x,y) = {latex(ans)} = C$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Equation requiring integrating factor mu(x) (1700-1800)
        # Start with exact equation and multiply by e^(-kx) to get non-exact
        k = nonzero(-2, 2)
        a_coef = nonzero(-3, 3)
        
        # Original exact: (2xy + y^2)dx + (x^2 + 2xy)dy = 0
        # Make non-exact by construction
        M = 2*x*y + a_coef*y**2
        N = x**2 + 2*x*y - a_coef*y**2
        
        # Check (M_y - N_x)/N to find integrating factor
        M_y = diff(M, y)
        N_x = diff(N, x)
        
        ratio = simplify((M_y - N_x)/N)
        
        # If ratio is function of x only, mu = exp(integral of ratio)
        if y not in ratio.free_symbols:
            mu = exp(integrate(ratio, x))
            M_new = simplify(mu * M)
            N_new = simplify(mu * N)
            
            F = simplify(integrate(M_new, x) + integrate(N_new - diff(integrate(M_new, x), y), y))
            
            return problem(
                question=f"Solve the differential equation: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$",
                answer=fmt_equation(F, "C"),
                difficulty=(1700, 1800),
                topic="differential_equations/exact_equations",
                answer_type="equation",
                solution=steps(
                    f"Check exactness: $\\frac{{\\partial M}}{{\\partial y}} = {latex(M_y)}$, $\\frac{{\\partial N}}{{\\partial x}} = {latex(N_x)}$",
                    f"Not exact since $\\frac{{\\partial M}}{{\\partial y}} \\neq \\frac{{\\partial N}}{{\\partial x}}$",
                    f"Check $\\frac{{M_y - N_x}}{{N}} = {latex(ratio)}$ (function of $x$ only)",
                    f"Integrating factor: $\\mu(x) = e^{{\\int {latex(ratio)} dx}} = {latex(mu)}$",
                    f"Multiply equation by $\\mu$: $\\left({latex(M_new)}\\right)dx + \\left({latex(N_new)}\\right)dy = 0$",
                    f"Now exact. Solution: ${latex(F)} = C$"
                )
            )
    
    elif problem_type == 3:
        # Type 3: Exact equation with exponential terms (1650-1750)
        a = nonzero(-2, 2)
        b = nonzero(-2, 2)
        
        # F = e^x * y + x^a * y^b
        F = exp(x)*y + x**2*y**b
        M = diff(F, x)
        N = diff(F, y)
        
        ans = simplify(F)
        
        return problem(
            question=f"Solve the exact differential equation: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$",
            answer=fmt_equation(ans, "C"),
            difficulty=(1650, 1750),
            topic="differential_equations/exact_equations",
            answer_type="equation",
            solution=steps(
                f"Verify exactness: $M = {latex(M)}$, $N = {latex(N)}$",
                f"$M_y = {latex(diff(M, y))}$, $N_x = {latex(diff(N, x))}$",
                f"Exact since $M_y = N_x$",
                f"Integrate $M$ with respect to $x$: $\\int {latex(M)} \\, dx = {latex(integrate(M, x))} + h(y)$",
                f"Differentiate with respect to $y$: ${latex(diff(integrate(M, x), y))} + h'(y) = {latex(N)}$",
                f"Solve for $h'(y)$: $h'(y) = {latex(simplify(N - diff(integrate(M, x), y)))}$",
                f"Integrate: $h(y) = {latex(integrate(simplify(N - diff(integrate(M, x), y)), y))}$",
                f"Solution: ${latex(ans)} = C$"
            )
        )
    
    else:
        # Type 4: Complex exact equation with rational terms (1750-1900)
        a = choice([2, 3])
        b = choice([2, 3])
        
        # F = x^a*y^b + ln(x)*y + x/y
        F = x**a * y**b + log(x)*y + x/y
        M = diff(F, x)
        N = diff(F, y)
        
        ans = simplify(F)
        
        return problem(
            question=f"Solve the exact differential equation: $\\left({latex(M)}\\right)dx + \\left({latex(N)}\\right)dy = 0$",
            answer=fmt_equation(ans, "C"),
            difficulty=(1750, 1900),
            topic="differential_equations/exact_equations",
            answer_type="equation",
            solution=steps(
                f"Check exactness for $M = {latex(M)}$ and $N = {latex(N)}$",
                f"Compute $\\frac{{\\partial M}}{{\\partial y}} = {latex(diff(M, y))}$",
                f"Compute $\\frac{{\\partial N}}{{\\partial x}} = {latex(diff(N, x))}$",
                f"Since $M_y = N_x$, the equation is exact",
                f"Find potential function: $F(x,y) = \\int M \\, dx = {latex(integrate(M, x))} + g(y)$",
                f"Use condition $\\frac{{\\partial F}}{{\\partial y}} = N$:",
                f"${latex(diff(integrate(M, x), y))} + g'(y) = {latex(N)}$",
                f"Therefore $g'(y) = {latex(simplify(N - diff(integrate(M, x), y)))}$",
                f"Integrating: $g(y) = {latex(integrate(simplify(N - diff(integrate(M, x), y)), y))}$",
                f"Final solution: ${latex(ans)} = C$"
            )
        )

emit(generate())