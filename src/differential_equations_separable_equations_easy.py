"""
differential_equations - separable_equations (easy)
Generated: 2026-02-22T05:18:37.350626
"""

from problem_utils import *

def generate():
    # For EASIER separable equations (1000-1300 ELO), we want:
    # - Direct separation with simple functions
    # - Basic integration on both sides
    # - Minimal algebraic manipulation
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type: dy/dx = ky (simplest exponential growth/decay)
        # ELO ~1000-1100
        k_val = nonzero(-3, 3)
        
        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(k_val)}y$"
        
        # Solution: dy/y = k dx, integrate both sides
        # ln|y| = kx + C
        # y = Ae^(kx)
        
        C = symbols('C')
        ans = Eq(y, C * exp(k_val * x))
        
        solution = steps(
            f"Separate variables: $\\frac{{dy}}{{y}} = {latex(k_val)}dx$",
            f"Integrate both sides: $\\int \\frac{{dy}}{{y}} = \\int {latex(k_val)}dx$",
            f"$\\ln|y| = {latex(k_val * x)} + C_1$",
            f"Exponentiate: $y = e^{{{latex(k_val * x)} + C_1}} = Ce^{{{latex(k_val * x)}}}$",
            f"General solution: ${latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1100),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )
    
    elif problem_type == 2:
        # Type: dy/dx = f(x) (direct integration)
        # ELO ~1100-1200
        coeff = nonzero(-4, 4)
        power = randint(1, 3)
        
        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(coeff * x**power)}$"
        
        # Direct integration
        C = symbols('C')
        integrated = integrate(coeff * x**power, x)
        ans = Eq(y, integrated + C)
        
        solution = steps(
            f"This is separable: $dy = {latex(coeff * x**power)}dx$",
            f"Integrate both sides: $y = \\int {latex(coeff * x**power)}dx$",
            f"$y = {latex(integrated)} + C$",
            f"General solution: ${latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )
    
    elif problem_type == 3:
        # Type: dy/dx = g(y) (separate and integrate)
        # ELO ~1200-1250
        coeff = nonzero(-3, 3)
        
        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(coeff * y**2)}$"
        
        # dy/y^2 = coeff dx
        # -1/y = coeff*x + C1
        # y = -1/(coeff*x + C)
        
        C = symbols('C')
        ans = Eq(y, -1/(coeff * x + C))
        
        solution = steps(
            f"Separate variables: $\\frac{{dy}}{{y^2}} = {latex(coeff)}dx$",
            f"Integrate both sides: $\\int y^{{-2}}dy = \\int {latex(coeff)}dx$",
            f"$-\\frac{{1}}{{y}} = {latex(coeff * x)} + C_1$",
            f"Solve for $y$: $y = -\\frac{{1}}{{{latex(coeff * x)} + C}}$",
            f"General solution: ${latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1250),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )
    
    else:
        # Type: dy/dx = f(x)g(y) simple product
        # ELO ~1250-1300
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        question = f"Solve the differential equation $\\frac{{dy}}{{dx}} = {latex(a_val * x * y)}$"
        
        # dy/y = a*x dx
        # ln|y| = a*x^2/2 + C1
        # y = C*e^(a*x^2/2)
        
        C = symbols('C')
        exponent = simplify(a_val * x**2 / 2)
        ans = Eq(y, C * exp(exponent))
        
        solution = steps(
            f"Separate variables: $\\frac{{dy}}{{y}} = {latex(a_val * x)}dx$",
            f"Integrate both sides: $\\int \\frac{{dy}}{{y}} = \\int {latex(a_val * x)}dx$",
            f"$\\ln|y| = {latex(exponent)} + C_1$",
            f"Exponentiate: $y = Ce^{{{latex(exponent)}}}$",
            f"General solution: ${latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1250, 1300),
            topic="differential_equations/separable_equations",
            solution=solution,
            answer_type="equation"
        )

emit(generate())