"""
differential_equations - second_order_constant (hard)
Generated: 2026-02-22T05:25:36.135861
"""

from problem_utils import *

def generate():
    # For harder second-order constant coefficient problems (1600-1900 ELO),
    # we'll include various challenging cases:
    # - Repeated roots
    # - Complex roots
    # - Initial value problems requiring all steps
    # - Non-homogeneous equations with particular solutions
    
    problem_type = choice(['repeated_roots', 'complex_roots', 'nonhomogeneous', 'ivp_complex'])
    
    if problem_type == 'repeated_roots':
        # ay'' + by' + cy = 0 with repeated root r
        r = nonzero(-4, 4)
        # For repeated root: (D - r)^2 = D^2 - 2rD + r^2
        # So: y'' - 2ry' + r^2 y = 0
        a_coeff = 1
        b_coeff = -2*r
        c_coeff = r**2
        
        # General solution: y = (C1 + C2*t)*e^(rt)
        C1, C2 = symbols('C_1 C_2')
        general_sol = (C1 + C2*t)*exp(r*t)
        
        question = f"Solve the differential equation: ${latex(a_coeff)}y'' {latex(b_coeff):+}y' {latex(c_coeff):+}y = 0$"
        
        solution_steps = steps(
            f"Write the characteristic equation: $r^2 {latex(b_coeff):+}r {latex(c_coeff):+} = 0$",
            f"Factor: $(r {latex(-r):+})^2 = 0$",
            f"Repeated root: $r = {r}$",
            f"General solution for repeated roots: $y = (C_1 + C_2 t)e^{{{r}t}}$"
        )
        
        ans = general_sol
        difficulty_val = randint(1600, 1750)
        
    elif problem_type == 'complex_roots':
        # ay'' + by' + cy = 0 with complex roots α ± βi
        alpha = nonzero(-3, 3)
        beta = randint(2, 5)
        
        # Characteristic roots: r = α ± βi
        # Characteristic equation: (r - α - βi)(r - α + βi) = r^2 - 2αr + (α^2 + β^2)
        a_coeff = 1
        b_coeff = -2*alpha
        c_coeff = alpha**2 + beta**2
        
        C1, C2 = symbols('C_1 C_2')
        general_sol = exp(alpha*t)*(C1*cos(beta*t) + C2*sin(beta*t))
        
        question = f"Solve the differential equation: $y'' {latex(b_coeff):+}y' {latex(c_coeff):+}y = 0$"
        
        solution_steps = steps(
            f"Write characteristic equation: $r^2 {latex(b_coeff):+}r {latex(c_coeff):+} = 0$",
            f"Use quadratic formula: $r = \\frac{{{latex(-b_coeff)} \\pm \\sqrt{{{latex(b_coeff**2 - 4*c_coeff)}}}}}{{2}}$",
            f"Simplify: $r = {alpha} \\pm {beta}i$",
            f"Complex roots $\\alpha \\pm \\beta i$ give: $y = e^{{\\alpha t}}(C_1\\cos(\\beta t) + C_2\\sin(\\beta t))$",
            f"General solution: $y = e^{{{alpha}t}}(C_1\\cos({beta}t) + C_2\\sin({beta}t))$"
        )
        
        ans = general_sol
        difficulty_val = randint(1650, 1800)
        
    elif problem_type == 'nonhomogeneous':
        # ay'' + by' + cy = f(t) where f(t) is polynomial or exponential
        # Use undetermined coefficients
        
        # Simple case: y'' + ay' + by = polynomial
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-8, 8)
        
        # Make sure not repeated root or pure imaginary for simplicity
        discriminant = a_coeff**2 - 4*b_coeff
        if discriminant == 0 or (discriminant < 0 and a_coeff == 0):
            a_coeff = nonzero(-4, 4)
            b_coeff = a_coeff**2 + randint(1, 5)
        
        # Right-hand side: constant
        d = nonzero(-10, 10)
        
        # Particular solution: yp = A (constant)
        # yp'' = 0, yp' = 0, so b*A = d, A = d/b
        if b_coeff != 0:
            A_val = Rational(d, b_coeff)
            yp = A_val
        else:
            # If b=0, try different problem
            b_coeff = nonzero(-8, 8)
            A_val = Rational(d, b_coeff)
            yp = A_val
        
        C1, C2 = symbols('C_1 C_2')
        # Homogeneous solution depends on roots
        r = symbols('r')
        char_eq = r**2 + a_coeff*r + b_coeff
        roots = solve(char_eq, r)
        
        if len(roots) == 2 and roots[0] != roots[1]:
            r1, r2 = roots[0], roots[1]
            if r1.is_real and r2.is_real:
                yh = C1*exp(r1*t) + C2*exp(r2*t)
            else:
                # Complex roots
                alpha_val = re(r1)
                beta_val = abs(im(r1))
                yh = exp(alpha_val*t)*(C1*cos(beta_val*t) + C2*sin(beta_val*t))
        else:
            r_val = roots[0]
            yh = (C1 + C2*t)*exp(r_val*t)
        
        general_sol = yh + yp
        
        question = f"Find the general solution: $y'' {latex(a_coeff):+}y' {latex(b_coeff):+}y = {latex(d)}$"
        
        solution_steps = steps(
            f"Find homogeneous solution by solving $y'' {latex(a_coeff):+}y' {latex(b_coeff):+}y = 0$",
            f"Characteristic equation: $r^2 {latex(a_coeff):+}r {latex(b_coeff):+} = 0$",
            f"Homogeneous solution: $y_h = {latex(yh)}$",
            f"For particular solution, try $y_p = A$ (constant)",
            f"Substituting: $0 + 0 + {b_coeff}A = {d}$, so $A = {latex(A_val)}$",
            f"General solution: $y = y_h + y_p = {latex(general_sol)}$"
        )
        
        ans = general_sol
        difficulty_val = randint(1700, 1850)
        
    else:  # ivp_complex
        # Initial value problem with complex roots
        alpha = nonzero(-2, 2)
        beta = randint(2, 4)
        
        a_coeff = 1
        b_coeff = -2*alpha
        c_coeff = alpha**2 + beta**2
        
        # Initial conditions
        y0 = nonzero(-5, 5)
        yp0 = nonzero(-5, 5)
        
        # General solution: y = e^(αt)(C1*cos(βt) + C2*sin(βt))
        # y(0) = C1 = y0
        C1_val = y0
        
        # y' = αe^(αt)(C1*cos(βt) + C2*sin(βt)) + e^(αt)(-βC1*sin(βt) + βC2*cos(βt))
        # y'(0) = αC1 + βC2 = yp0
        # So: C2 = (yp0 - α*C1)/β
        C2_val = Rational(yp0 - alpha*C1_val, beta)
        
        particular_sol = exp(alpha*t)*(C1_val*cos(beta*t) + C2_val*sin(beta*t))
        
        question = f"Solve the initial value problem: $y'' {latex(b_coeff):+}y' {latex(c_coeff):+}y = 0$, $y(0) = {y0}$, $y'(0) = {yp0}$"
        
        solution_steps = steps(
            f"Characteristic equation: $r^2 {latex(b_coeff):+}r {latex(c_coeff):+} = 0$",
            f"Roots: $r = {alpha} \\pm {beta}i$",
            f"General solution: $y = e^{{{alpha}t}}(C_1\\cos({beta}t) + C_2\\sin({beta}t))$",
            f"Apply $y(0) = {y0}$: $C_1 = {y0}$",
            f"Differentiate: $y' = {alpha}e^{{{alpha}t}}(C_1\\cos({beta}t) + C_2\\sin({beta}t)) + e^{{{alpha}t}}(-{beta}C_1\\sin({beta}t) + {beta}C_2\\cos({beta}t))$",
            f"Apply $y'(0) = {yp0}$: ${alpha}C_1 + {beta}C_2 = {yp0}$",
            f"Solve for $C_2$: $C_2 = {latex(C2_val)}$",
            f"Particular solution: $y = {latex(particular_sol)}$"
        )
        
        ans = particular_sol
        difficulty_val = randint(1750, 1900)
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty_val,
        topic="differential_equations/second_order_constant",
        solution=solution_steps,
        calculator="scientific"
    )

emit(generate())