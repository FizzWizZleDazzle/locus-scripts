"""
multivariable_calculus - triple_integrals (medium)
Generated: 2026-02-22T05:40:42.728671
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Rectangular box triple integral (1300-1400)
        # Integrate a polynomial over a rectangular region
        a_lim = randint(1, 3)
        b_lim = randint(1, 3)
        c_lim = randint(1, 3)
        
        # Simple polynomial to integrate
        coeffs = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
        integrand = coeffs[0] * x + coeffs[1] * y + coeffs[2] * z
        
        # Compute the answer
        int_z = integrate(integrand, (z, 0, c_lim))
        int_y = integrate(int_z, (y, 0, b_lim))
        ans = integrate(int_y, (x, 0, a_lim))
        
        return problem(
            question=f"Evaluate $\\int_0^{{{a_lim}}} \\int_0^{{{b_lim}}} \\int_0^{{{c_lim}}} \\left({latex(integrand)}\\right) \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"First integrate with respect to $z$ from $0$ to ${c_lim}$:",
                f"$\\int_0^{{{c_lim}}} \\left({latex(integrand)}\\right) \\, dz = {latex(int_z)}$",
                f"Next integrate with respect to $y$ from $0$ to ${b_lim}$:",
                f"$\\int_0^{{{b_lim}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"Finally integrate with respect to $x$ from $0$ to ${a_lim}$:",
                f"$\\int_0^{{{a_lim}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Triple integral with quadratic function (1400-1500)
        a_lim = randint(1, 2)
        b_lim = randint(1, 2)
        c_lim = randint(1, 2)
        
        # Quadratic integrand
        coeff = nonzero(-2, 2)
        integrand = coeff * x**2 * y * z
        
        int_z = integrate(integrand, (z, 0, c_lim))
        int_y = integrate(int_z, (y, 0, b_lim))
        ans = integrate(int_y, (x, 0, a_lim))
        
        return problem(
            question=f"Evaluate $\\int_0^{{{a_lim}}} \\int_0^{{{b_lim}}} \\int_0^{{{c_lim}}} {latex(integrand)} \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Integrate with respect to $z$:",
                f"$\\int_0^{{{c_lim}}} {latex(integrand)} \\, dz = {latex(int_z)}$",
                f"Integrate with respect to $y$:",
                f"$\\int_0^{{{b_lim}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"Integrate with respect to $x$:",
                f"$\\int_0^{{{a_lim}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Variable bounds in z (1450-1550)
        a_lim = randint(1, 2)
        b_lim = randint(1, 2)
        
        # z goes from 0 to x+y
        integrand = randint(1, 3)
        
        int_z = integrate(integrand, (z, 0, x + y))
        int_y = integrate(int_z, (y, 0, b_lim))
        ans = integrate(int_y, (x, 0, a_lim))
        
        return problem(
            question=f"Evaluate $\\int_0^{{{a_lim}}} \\int_0^{{{b_lim}}} \\int_0^{{x+y}} {integrand} \\, dz \\, dy \\, dx$",
            answer=ans,
            difficulty=(1450, 1550),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Integrate with respect to $z$ from $0$ to $x+y$:",
                f"$\\int_0^{{x+y}} {integrand} \\, dz = {latex(int_z)}$",
                f"Integrate with respect to $y$ from $0$ to ${b_lim}$:",
                f"$\\int_0^{{{b_lim}}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"Integrate with respect to $x$ from $0$ to ${a_lim}$:",
                f"$\\int_0^{{{a_lim}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )
    
    else:
        # Type 4: Triple integral over a tetrahedron region (1500-1600)
        a_val = randint(2, 4)
        
        # Region: 0 ≤ x ≤ a, 0 ≤ y ≤ a-x, 0 ≤ z ≤ a-x-y
        integrand = 1
        
        int_z = integrate(integrand, (z, 0, a_val - x - y))
        int_y = integrate(int_z, (y, 0, a_val - x))
        ans = integrate(int_y, (x, 0, a_val))
        
        return problem(
            question=f"Find the volume of the tetrahedron bounded by $x=0$, $y=0$, $z=0$, and $x+y+z={a_val}$ using a triple integral.",
            answer=ans,
            difficulty=(1500, 1600),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"The region is described by $0 \\leq x \\leq {a_val}$, $0 \\leq y \\leq {a_val}-x$, $0 \\leq z \\leq {a_val}-x-y$",
                f"Volume = $\\int_0^{{{a_val}}} \\int_0^{{{a_val}-x}} \\int_0^{{{a_val}-x-y}} 1 \\, dz \\, dy \\, dx$",
                f"Integrate with respect to $z$: $\\int_0^{{{a_val}-x-y}} 1 \\, dz = {latex(int_z)}$",
                f"Integrate with respect to $y$: $\\int_0^{{{a_val}-x}} {latex(int_z)} \\, dy = {latex(int_y)}$",
                f"Integrate with respect to $x$: $\\int_0^{{{a_val}}} {latex(int_y)} \\, dx = {latex(ans)}$"
            ),
        )

emit(generate())