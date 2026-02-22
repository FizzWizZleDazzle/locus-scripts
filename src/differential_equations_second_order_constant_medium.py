"""
differential_equations - second_order_constant (medium)
Generated: 2026-02-22T05:24:57.613871
"""

from problem_utils import *

def generate():
    problem_type = choice(['homogeneous', 'nonhomogeneous_simple'])
    
    if problem_type == 'homogeneous':
        # Generate ay'' + by' + cy = 0
        # Choose roots first for clean solution
        root_type = choice(['real_distinct', 'real_repeated', 'complex'])
        
        if root_type == 'real_distinct':
            r1 = nonzero(-4, 4)
            r2 = nonzero(-4, 4)
            while r2 == r1:
                r2 = nonzero(-4, 4)
            
            # Characteristic equation: (r - r1)(r - r2) = r^2 - (r1+r2)r + r1*r2
            b_coeff = -(r1 + r2)
            c_coeff = r1 * r2
            
            # For simplicity, set a = 1
            a_coeff = 1
            
            diff_eq = f"y'' {b_coeff:+d}y' {c_coeff:+d}y = 0"
            
            if r1 < r2:
                r1, r2 = r2, r1
            
            ans_expr = f"C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}}"
            if r1 == 1:
                ans_expr = f"C_1 e^{{t}} + C_2 e^{{{r2}t}}"
            if r2 == 1:
                ans_expr = f"C_1 e^{{{r1}t}} + C_2 e^{{t}}"
            if r1 == -1:
                ans_expr = f"C_1 e^{{-t}} + C_2 e^{{{r2}t}}"
            if r2 == -1:
                ans_expr = f"C_1 e^{{{r1}t}} + C_2 e^{{-t}}"
            
            ans = f"y = {ans_expr}"
            
            solution_steps = steps(
                f"Find the characteristic equation: $r^2 {b_coeff:+d}r {c_coeff:+d} = 0$",
                f"Factor: $(r - {r1})(r - {r2}) = 0$",
                f"Roots: $r_1 = {r1}, r_2 = {r2}$",
                f"General solution: ${ans}$"
            )
            
            difficulty = (1300, 1450)
            
        elif root_type == 'real_repeated':
            r = nonzero(-4, 4)
            
            # (r - r)^2 = r^2 - 2r*r + r^2
            b_coeff = -2 * r
            c_coeff = r * r
            a_coeff = 1
            
            diff_eq = f"y'' {b_coeff:+d}y' {c_coeff:+d}y = 0"
            
            if r == 1:
                ans = f"y = (C_1 + C_2 t)e^t"
            elif r == -1:
                ans = f"y = (C_1 + C_2 t)e^{{-t}}"
            else:
                ans = f"y = (C_1 + C_2 t)e^{{{r}t}}"
            
            solution_steps = steps(
                f"Characteristic equation: $r^2 {b_coeff:+d}r {c_coeff:+d} = 0$",
                f"Factor: $(r - {r})^2 = 0$",
                f"Repeated root: $r = {r}$",
                f"General solution: ${ans}$"
            )
            
            difficulty = (1400, 1550)
            
        else:  # complex roots
            # r = α ± βi where α, β are integers
            alpha = randint(-3, 3)
            beta = randint(1, 3)
            
            # (r - (α + βi))(r - (α - βi)) = r^2 - 2αr + (α^2 + β^2)
            b_coeff = -2 * alpha
            c_coeff = alpha**2 + beta**2
            a_coeff = 1
            
            diff_eq = f"y'' {b_coeff:+d}y' {c_coeff:+d}y = 0"
            
            if alpha == 0:
                ans = f"y = C_1 \\cos({beta}t) + C_2 \\sin({beta}t)"
            elif alpha == 1:
                ans = f"y = e^t(C_1 \\cos({beta}t) + C_2 \\sin({beta}t))"
            elif alpha == -1:
                ans = f"y = e^{{-t}}(C_1 \\cos({beta}t) + C_2 \\sin({beta}t))"
            else:
                ans = f"y = e^{{{alpha}t}}(C_1 \\cos({beta}t) + C_2 \\sin({beta}t))"
            
            solution_steps = steps(
                f"Characteristic equation: $r^2 {b_coeff:+d}r {c_coeff:+d} = 0$",
                f"Using quadratic formula: $r = \\frac{{{-b_coeff} \\pm \\sqrt{{{b_coeff**2} - 4({c_coeff})}}}}{{2}}$",
                f"Complex roots: $r = {alpha} \\pm {beta}i$",
                f"General solution: ${ans}$"
            )
            
            difficulty = (1450, 1600)
    
    else:  # nonhomogeneous_simple
        # Simple case: y'' + ay' + by = constant
        r1 = nonzero(-3, 3)
        r2 = nonzero(-3, 3)
        while r2 == r1:
            r2 = nonzero(-3, 3)
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        rhs = nonzero(-10, 10)
        
        diff_eq = f"y'' {b_coeff:+d}y' {c_coeff:+d}y = {rhs}"
        
        # Particular solution: y_p = constant k, so y_p'' = 0, y_p' = 0
        # c*k = rhs, so k = rhs/c
        y_p = Rational(rhs, c_coeff)
        
        if r1 < r2:
            r1, r2 = r2, r1
        
        hom_part = f"C_1 e^{{{r1}t}} + C_2 e^{{{r2}t}}"
        if r1 == 1:
            hom_part = f"C_1 e^t + C_2 e^{{{r2}t}}"
        if r2 == 1:
            hom_part = f"C_1 e^{{{r1}t}} + C_2 e^t"
        
        ans = f"y = {hom_part} + {latex(y_p)}"
        
        solution_steps = steps(
            f"Solve homogeneous equation: $y'' {b_coeff:+d}y' {c_coeff:+d}y = 0$",
            f"Characteristic equation: $(r - {r1})(r - {r2}) = 0$",
            f"Homogeneous solution: $y_h = {hom_part}$",
            f"Particular solution (constant): $y_p = {latex(y_p)}$",
            f"General solution: ${ans}$"
        )
        
        difficulty = (1500, 1600)
    
    return problem(
        question=f"Find the general solution to the differential equation: ${diff_eq}$",
        answer=ans,
        difficulty=difficulty,
        topic="differential_equations/second_order_constant",
        solution=solution_steps,
        answer_type="expression"
    )

emit(generate())