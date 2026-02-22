"""
differential_equations - characteristic_equation (medium)
Generated: 2026-02-22T05:26:15.688608
"""

from problem_utils import *

def generate():
    # Choose difficulty level within standard range
    difficulty_level = randint(1300, 1600)
    
    # For characteristic equations of 2nd order linear homogeneous ODEs
    # with constant coefficients: ay'' + by' + cy = 0
    # Characteristic equation: ar^2 + br + c = 0
    
    if difficulty_level <= 1400:
        # Simpler case: distinct real roots
        # Start with roots and work backward
        r1 = nonzero(-5, 5)
        r2 = nonzero(-5, 5)
        while r2 == r1:
            r2 = nonzero(-5, 5)
        
        # Characteristic equation: (r - r1)(r - r2) = 0
        # Expanded: r^2 - (r1+r2)r + r1*r2 = 0
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        # We'll use a=1 for simplicity
        a_coeff = 1
        
        # The ODE is y'' + b_coeff*y' + c_coeff*y = 0
        ode_latex = "y'' "
        if b_coeff >= 0:
            ode_latex += f"+ {b_coeff}y' "
        else:
            ode_latex += f"{b_coeff}y' "
        if c_coeff >= 0:
            ode_latex += f"+ {c_coeff}y = 0"
        else:
            ode_latex += f"{c_coeff}y = 0"
        
        char_eq = r**2 + b_coeff*r + c_coeff
        
        question = f"Find the characteristic equation and its roots for the differential equation ${ode_latex}$"
        
        # Answer is the set of roots
        ans = FiniteSet(r1, r2)
        
        solution_steps = steps(
            f"The characteristic equation is obtained by substituting $y = e^{{rt}}$",
            f"This gives: ${latex(char_eq)} = 0$",
            f"Factoring: $(r - {r1})(r - {r2}) = 0$",
            f"Roots are: $r = {r1}, {r2}$"
        )
        
    else:
        # More complex cases for higher difficulty
        case = choice(['repeated', 'complex'])
        
        if case == 'repeated':
            # Repeated root case
            r1 = nonzero(-4, 4)
            
            # (r - r1)^2 = r^2 - 2*r1*r + r1^2 = 0
            a_coeff = 1
            b_coeff = -2 * r1
            c_coeff = r1**2
            
            ode_latex = "y'' "
            if b_coeff >= 0:
                ode_latex += f"+ {b_coeff}y' "
            else:
                ode_latex += f"{b_coeff}y' "
            if c_coeff >= 0:
                ode_latex += f"+ {c_coeff}y = 0"
            else:
                ode_latex += f"{c_coeff}y = 0"
            
            char_eq = r**2 + b_coeff*r + c_coeff
            
            question = f"Find the characteristic equation and its roots for the differential equation ${ode_latex}$"
            
            ans = FiniteSet(r1)
            
            solution_steps = steps(
                f"The characteristic equation is: ${latex(char_eq)} = 0$",
                f"Factoring: $(r - {r1})^2 = 0$",
                f"This gives a repeated root: $r = {r1}$ (multiplicity 2)"
            )
            
        else:
            # Complex roots case: r = alpha ± beta*i
            alpha = nonzero(-3, 3)
            beta = randint(1, 4)
            
            # (r - (alpha + beta*i))(r - (alpha - beta*i))
            # = r^2 - 2*alpha*r + (alpha^2 + beta^2)
            a_coeff = 1
            b_coeff = -2 * alpha
            c_coeff = alpha**2 + beta**2
            
            ode_latex = "y'' "
            if b_coeff >= 0:
                ode_latex += f"+ {b_coeff}y' "
            else:
                ode_latex += f"{b_coeff}y' "
            if c_coeff >= 0:
                ode_latex += f"+ {c_coeff}y = 0"
            else:
                ode_latex += f"{c_coeff}y = 0"
            
            char_eq = r**2 + b_coeff*r + c_coeff
            
            question = f"Find the characteristic equation and its roots for the differential equation ${ode_latex}$"
            
            # For complex roots, return as expressions
            root1 = alpha + beta*I
            root2 = alpha - beta*I
            ans = FiniteSet(root1, root2)
            
            solution_steps = steps(
                f"The characteristic equation is: ${latex(char_eq)} = 0$",
                f"Using the quadratic formula: $r = \\frac{{-({b_coeff}) \\pm \\sqrt{{({b_coeff})^2 - 4(1)({c_coeff})}}}}{{2(1)}}$",
                f"Discriminant: $\\Delta = {b_coeff**2} - {4*c_coeff} = {b_coeff**2 - 4*c_coeff}$",
                f"Since $\\Delta < 0$, we have complex roots: $r = {alpha} \\pm {beta}i$"
            )
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty_level,
        topic="differential_equations/characteristic_equation",
        solution=solution_steps,
        answer_type="set"
    )

emit(generate())