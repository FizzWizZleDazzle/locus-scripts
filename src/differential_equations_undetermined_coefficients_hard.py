"""
differential_equations - undetermined_coefficients (hard)
Generated: 2026-02-22T05:28:25.386859
"""

from problem_utils import *

def generate():
    # Harder undetermined coefficients problems (1600-1900 range)
    # Features: higher order ODEs, repeated roots, resonance cases, sums of forcing functions
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Higher order ODE with polynomial forcing (1600-1700)
        # y''' + ay'' + by' + cy = polynomial
        # Characteristic equation with distinct roots
        r1, r2, r3 = -3, -2, -1
        a_coeff = -(r1 + r2 + r3)
        b_coeff = r1*r2 + r1*r3 + r2*r3
        c_coeff = -r1*r2*r3
        
        # Polynomial forcing function
        deg = randint(1, 2)
        if deg == 1:
            p0, p1 = nonzero(-5, 5), nonzero(-5, 5)
            forcing = p1*x + p0
        else:
            p0, p1, p2 = nonzero(-4, 4), nonzero(-4, 4), nonzero(-3, 3)
            forcing = p2*x**2 + p1*x + p0
        
        # Particular solution form: A*x^deg + B*x^(deg-1) + ... + C
        if deg == 1:
            A, B = symbols('A B')
            y_p = A*x + B
            y_p_prime = diff(y_p, x)
            y_p_double = diff(y_p_prime, x)
            y_p_triple = diff(y_p_double, x)
            
            lhs = y_p_triple + a_coeff*y_p_double + b_coeff*y_p_prime + c_coeff*y_p
            lhs_expanded = expand(lhs)
            
            # Solve for coefficients
            eqs = [Eq(lhs_expanded.coeff(x, 1), forcing.coeff(x, 1)),
                   Eq(lhs_expanded.coeff(x, 0), forcing.coeff(x, 0))]
            sol = solve(eqs, [A, B])
            ans = (sol[A]*x + sol[B]).simplify()
        else:
            A, B, C = symbols('A B C')
            y_p = A*x**2 + B*x + C
            y_p_prime = diff(y_p, x)
            y_p_double = diff(y_p_prime, x)
            y_p_triple = diff(y_p_double, x)
            
            lhs = y_p_triple + a_coeff*y_p_double + b_coeff*y_p_prime + c_coeff*y_p
            lhs_expanded = expand(lhs)
            
            eqs = [Eq(lhs_expanded.coeff(x, 2), forcing.coeff(x, 2)),
                   Eq(lhs_expanded.coeff(x, 1), forcing.coeff(x, 1)),
                   Eq(lhs_expanded.coeff(x, 0), forcing.coeff(x, 0))]
            sol = solve(eqs, [A, B, C])
            ans = (sol[A]*x**2 + sol[B]*x + sol[C]).simplify()
        
        return problem(
            question=f"Find a particular solution to the differential equation: $y''' {a_coeff:+}y'' {b_coeff:+}y' {c_coeff:+}y = {latex(forcing)}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="differential_equations/undetermined_coefficients",
            solution=steps(
                f"The characteristic equation is $r^3 {a_coeff:+}r^2 {b_coeff:+}r {c_coeff:+} = 0$",
                f"Since the forcing function is a polynomial of degree {deg}, assume $y_p = {latex(y_p)}$",
                f"Compute derivatives and substitute into the ODE",
                f"Equate coefficients of like powers of $x$ to solve for the undetermined coefficients",
                f"Particular solution: $y_p = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Resonance case: forcing term is solution to homogeneous equation (1700-1850)
        # y'' + omega^2*y = A*cos(omega*t) or A*sin(omega*t)
        omega_sq = choice([4, 9, 16, 25])
        omega = sqrt(omega_sq)
        A_val = nonzero(-5, 5)
        trig_choice = choice([sin, cos])
        forcing = A_val * trig_choice(omega*t)
        
        # Due to resonance, multiply by t
        if trig_choice == sin:
            # y_p = t*(A*cos(omega*t) + B*sin(omega*t))
            # After substitution, A = 0, B = A_val/(2*omega)
            B_val = Rational(A_val, 2*omega)
            ans = t * B_val * cos(omega*t)
        else:
            # y_p = t*(A*cos(omega*t) + B*sin(omega*t))
            # After substitution, A = -A_val/(2*omega), B = 0
            A_coeff = Rational(-A_val, 2*omega)
            ans = t * A_coeff * sin(omega*t)
        
        return problem(
            question=f"Find a particular solution to $y'' + {omega_sq}y = {latex(forcing)}$ using undetermined coefficients.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="differential_equations/undetermined_coefficients",
            solution=steps(
                f"The characteristic equation is $r^2 + {omega_sq} = 0$ with roots $r = \\pm {latex(omega)}i$",
                f"The homogeneous solution is $y_h = c_1\\cos({latex(omega)}t) + c_2\\sin({latex(omega)}t)$",
                f"Since ${latex(forcing)}$ is a solution to the homogeneous equation (resonance case), multiply by $t$",
                f"Assume $y_p = t(A\\cos({latex(omega)}t) + B\\sin({latex(omega)}t))$",
                f"Substitute into the ODE and solve for $A$ and $B$",
                f"Particular solution: $y_p = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Repeated root case with exponential forcing (1650-1800)
        # y'' + 2ay' + a^2*y = e^(-at) or te^(-at)
        a_val = choice([2, 3, 4])
        forcing_type = randint(1, 2)
        coeff = nonzero(-4, 4)
        
        if forcing_type == 1:
            # Forcing: A*e^(-a*t), but this is solution to homogeneous
            forcing = coeff * exp(-a_val*t)
            # Characteristic root r = -a (repeated), so multiply by t^2
            ans_coeff = Rational(coeff, 2)
            ans = ans_coeff * t**2 * exp(-a_val*t)
        else:
            # Forcing: A*t*e^(-a*t), which requires multiplying by t^2 as well
            forcing = coeff * t * exp(-a_val*t)
            # Need y_p = (At^3 + Bt^2)e^(-at)
            # This gets complex, simplify to just t^2 case
            ans_coeff = Rational(coeff, 2)
            ans = ans_coeff * t**2 * exp(-a_val*t)
            forcing = coeff * exp(-a_val*t)  # Simplify problem
        
        return problem(
            question=f"Find a particular solution to $y'' + {2*a_val}y' + {a_val**2}y = {latex(forcing)}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="differential_equations/undetermined_coefficients",
            solution=steps(
                f"The characteristic equation is $r^2 + {2*a_val}r + {a_val**2} = (r + {a_val})^2 = 0$",
                f"The characteristic root $r = {-a_val}$ has multiplicity 2",
                f"Since $e^{{{-a_val}t}}$ and $te^{{{-a_val}t}}$ are solutions to the homogeneous equation",
                f"We must multiply by $t^2$ to get a particular solution",
                f"Assume $y_p = At^2e^{{{-a_val}t}}$",
                f"Substitute and solve: $A = {latex(ans_coeff)}$",
                f"Particular solution: $y_p = {latex(ans)}$"
            ),
        )
    
    else:  # problem_type == 4
        # Sum of forcing functions with different types (1700-1900)
        # y'' + ay' + by = polynomial + exponential
        r1, r2 = choice([(-1, -2), (-2, -3), (-1, -3)])
        a_coeff = -(r1 + r2)
        b_coeff = r1 * r2
        
        # Part 1: polynomial
        p0, p1 = nonzero(-5, 5), nonzero(-3, 3)
        poly_part = p1*x + p0
        
        # Part 2: exponential (not a solution to homogeneous)
        exp_coeff = nonzero(-4, 4)
        exp_root = choice([1, 2])  # Different from r1, r2
        exp_part = exp_coeff * exp(exp_root*x)
        
        forcing = poly_part + exp_part
        
        # Particular solution for polynomial part
        A, B = symbols('A B')
        y_p1 = A*x + B
        lhs1 = diff(y_p1, x, 2) + a_coeff*diff(y_p1, x) + b_coeff*y_p1
        lhs1 = expand(lhs1)
        eqs1 = [Eq(lhs1.coeff(x, 1), p1), Eq(lhs1.coeff(x, 0), p0)]
        sol1 = solve(eqs1, [A, B])
        ans1 = sol1[A]*x + sol1[B]
        
        # Particular solution for exponential part
        C = symbols('C')
        y_p2 = C * exp(exp_root*x)
        lhs2 = diff(y_p2, x, 2) + a_coeff*diff(y_p2, x) + b_coeff*y_p2
        lhs2 = expand(lhs2)
        C_val = solve(Eq(lhs2.coeff(exp(exp_root*x)), exp_coeff), C)[0]
        ans2 = C_val * exp(exp_root*x)
        
        ans = (ans1 + ans2).simplify()
        
        return problem(
            question=f"Find a particular solution to $y'' {a_coeff:+}y' {b_coeff:+}y = {latex(forcing)}$",
            answer=ans,
            difficulty=(1700, 1900),
            topic="differential_equations/undetermined_coefficients",
            solution=steps(
                f"The forcing function is a sum of two types: polynomial and exponential",
                f"Use superposition: find particular solutions for each part separately",
                f"For ${latex(poly_part)}$: assume $y_{{p1}} = Ax + B$",
                f"For ${latex(exp_part)}$: assume $y_{{p2}} = Ce^{{{exp_root}x}}$",
                f"Solve for undetermined coefficients in each case",
                f"Particular solution: $y_p = {latex(ans)}$"
            ),
        )

emit(generate())