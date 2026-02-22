"""
differential_equations - undetermined_coefficients (medium)
Generated: 2026-02-22T05:27:42.285819
"""

from problem_utils import *

def generate():
    # Method of undetermined coefficients for second-order linear ODEs
    # Standard difficulty: 1300-1600 range
    
    problem_type = choice(['exponential', 'polynomial', 'trig', 'mixed'])
    
    if problem_type == 'exponential':
        # y'' + ay' + by = Ce^(rx) where r is not a root of characteristic equation
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-6, 6)
        
        # Characteristic equation: m^2 + a*m + b = 0
        char_roots = solve(m**2 + a_coeff*m + b_coeff, m)
        
        # Choose r different from characteristic roots
        r_val = nonzero(-3, 3)
        if char_roots:
            while any(abs(complex(r_val - root)) < 0.1 for root in char_roots):
                r_val = nonzero(-3, 3)
        
        C_val = nonzero(-5, 5)
        
        question = f"Find a particular solution to the differential equation: $$y'' {'+' if a_coeff > 0 else ''}{a_coeff if abs(a_coeff) != 1 else ('-' if a_coeff == -1 else '')}y' {'+' if b_coeff > 0 else ''}{b_coeff}y = {C_val}e^{{{r_val}x}}$$"
        
        # Particular solution: y_p = A*e^(rx)
        A = symbols('A')
        y_p = A * exp(r_val * x)
        y_p_prime = diff(y_p, x)
        y_p_double_prime = diff(y_p_prime, x)
        
        lhs = y_p_double_prime + a_coeff * y_p_prime + b_coeff * y_p
        lhs_simplified = simplify(lhs)
        
        # Solve for A
        A_val = solve(Eq(lhs_simplified, C_val * exp(r_val * x)), A)[0]
        
        ans = A_val * exp(r_val * x)
        
        solution = steps(
            f"Assume particular solution of form $y_p = Ae^{{{r_val}x}}$",
            f"Compute derivatives: $y_p' = {latex(diff(A * exp(r_val * x), x))}$ and $y_p'' = {latex(diff(diff(A * exp(r_val * x), x), x))}$",
            f"Substitute into DE: ${latex(lhs_simplified)} = {C_val}e^{{{r_val}x}}$",
            f"Simplify: ${latex(factor(lhs_simplified / exp(r_val * x)))}A = {C_val}$",
            f"Solve: $A = {latex(A_val)}$",
            f"Particular solution: $y_p = {latex(ans)}$"
        )
        
        difficulty = (1300, 1450)
        
    elif problem_type == 'polynomial':
        # y'' + ay' + by = polynomial (constant term non-zero ensures no repeated root issues)
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-5, 5)
        
        # Make sure b != 0 (otherwise 0 is a root)
        while b_coeff == 0:
            b_coeff = nonzero(-5, 5)
        
        poly_deg = choice([0, 1, 2])
        
        if poly_deg == 0:
            C_val = nonzero(-8, 8)
            rhs = C_val
            
            question = f"Find a particular solution to: $$y'' {'+' if a_coeff > 0 else ''}{a_coeff if abs(a_coeff) != 1 else ('-' if a_coeff == -1 else '')}y' {'+' if b_coeff > 0 else ''}{b_coeff}y = {C_val}$$"
            
            # y_p = A (constant)
            A_val = Rational(C_val, b_coeff)
            ans = A_val
            
            solution = steps(
                f"Assume particular solution $y_p = A$ (constant)",
                f"Then $y_p' = 0$ and $y_p'' = 0$",
                f"Substitute: ${b_coeff}A = {C_val}$",
                f"Solve: $A = {latex(A_val)}$",
                f"Particular solution: $y_p = {latex(ans)}$"
            )
            difficulty = (1300, 1400)
            
        elif poly_deg == 1:
            c1 = nonzero(-5, 5)
            c0 = nonzero(-5, 5)
            rhs = c1*x + c0
            
            question = f"Find a particular solution to: $$y'' {'+' if a_coeff > 0 else ''}{a_coeff if abs(a_coeff) != 1 else ('-' if a_coeff == -1 else '')}y' {'+' if b_coeff > 0 else ''}{b_coeff}y = {latex(rhs)}$$"
            
            # y_p = Ax + B
            A, B = symbols('A B')
            y_p = A*x + B
            y_p_prime = diff(y_p, x)
            y_p_double_prime = diff(y_p_prime, x)
            
            lhs = y_p_double_prime + a_coeff * y_p_prime + b_coeff * y_p
            lhs_expanded = expand(lhs)
            
            # Collect coefficients
            coeff_system = [
                Eq(lhs_expanded.coeff(x, 1), c1),
                Eq(lhs_expanded.coeff(x, 0), c0)
            ]
            
            sol = solve(coeff_system, [A, B])
            ans = sol[A]*x + sol[B]
            
            solution = steps(
                f"Assume $y_p = Ax + B$",
                f"Then $y_p' = A$ and $y_p'' = 0$",
                f"Substitute: ${latex(lhs_expanded)} = {latex(rhs)}$",
                f"Match coefficients: $A = {latex(sol[A])}$, $B = {latex(sol[B])}$",
                f"Particular solution: $y_p = {latex(ans)}$"
            )
            difficulty = (1400, 1550)
            
        else:  # poly_deg == 2
            c2 = nonzero(-3, 3)
            c1 = nonzero(-4, 4)
            c0 = nonzero(-4, 4)
            rhs = c2*x**2 + c1*x + c0
            
            question = f"Find a particular solution to: $$y'' {'+' if a_coeff > 0 else ''}{a_coeff if abs(a_coeff) != 1 else ('-' if a_coeff == -1 else '')}y' {'+' if b_coeff > 0 else ''}{b_coeff}y = {latex(rhs)}$$"
            
            # y_p = Ax^2 + Bx + C
            A, B, C = symbols('A B C')
            y_p = A*x**2 + B*x + C
            y_p_prime = diff(y_p, x)
            y_p_double_prime = diff(y_p_prime, x)
            
            lhs = y_p_double_prime + a_coeff * y_p_prime + b_coeff * y_p
            lhs_expanded = expand(lhs)
            
            coeff_system = [
                Eq(lhs_expanded.coeff(x, 2), c2),
                Eq(lhs_expanded.coeff(x, 1), c1),
                Eq(lhs_expanded.coeff(x, 0), c0)
            ]
            
            sol = solve(coeff_system, [A, B, C])
            ans = sol[A]*x**2 + sol[B]*x + sol[C]
            
            solution = steps(
                f"Assume $y_p = Ax^2 + Bx + C$",
                f"Compute: $y_p' = 2Ax + B$, $y_p'' = 2A$",
                f"Substitute and collect like terms",
                f"Match coefficients to get $A = {latex(sol[A])}$, $B = {latex(sol[B])}$, $C = {latex(sol[C])}$",
                f"Particular solution: $y_p = {latex(ans)}$"
            )
            difficulty = (1450, 1600)
    
    else:  # trig or mixed
        a_coeff = nonzero(-3, 3)
        b_coeff = nonzero(-6, 6)
        
        omega = choice([1, 2])
        C_val = nonzero(-4, 4)
        
        trig_func = choice([sin, cos])
        trig_name = 'sin' if trig_func == sin else 'cos'
        
        question = f"Find a particular solution to: $$y'' {'+' if a_coeff > 0 else ''}{a_coeff if abs(a_coeff) != 1 else ('-' if a_coeff == -1 else '')}y' {'+' if b_coeff > 0 else ''}{b_coeff}y = {C_val}\\{trig_name}({omega}x)$$"
        
        # y_p = A*cos(wx) + B*sin(wx)
        A, B = symbols('A B')
        y_p = A*cos(omega*x) + B*sin(omega*x)
        y_p_prime = diff(y_p, x)
        y_p_double_prime = diff(y_p_prime, x)
        
        lhs = y_p_double_prime + a_coeff * y_p_prime + b_coeff * y_p
        lhs_expanded = expand(lhs)
        
        # Match with C*trig_func(omega*x)
        if trig_func == sin:
            coeff_system = [
                Eq(lhs_expanded.coeff(sin(omega*x)), C_val),
                Eq(lhs_expanded.coeff(cos(omega*x)), 0)
            ]
        else:
            coeff_system = [
                Eq(lhs_expanded.coeff(cos(omega*x)), C_val),
                Eq(lhs_expanded.coeff(sin(omega*x)), 0)
            ]
        
        sol = solve(coeff_system, [A, B])
        ans = sol[A]*cos(omega*x) + sol[B]*sin(omega*x)
        
        solution = steps(
            f"Assume $y_p = A\\cos({omega}x) + B\\sin({omega}x)$",
            f"Compute derivatives and substitute into DE",
            f"Match coefficients of $\\sin({omega}x)$ and $\\cos({omega}x)$",
            f"Solve system: $A = {latex(sol[A])}$, $B = {latex(sol[B])}$",
            f"Particular solution: $y_p = {latex(ans)}$"
        )
        difficulty = (1450, 1600)
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty,
        topic="differential_equations/undetermined_coefficients",
        solution=solution,
        calculator="scientific"
    )

emit(generate())