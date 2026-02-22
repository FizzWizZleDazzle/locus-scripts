"""
algebra1 - systems_elimination (medium)
Generated: 2026-02-22T03:57:09.080276
"""

from problem_utils import *

def generate():
    # Pick solution first (x, y values)
    x_val = randint(-10, 10)
    y_val = randint(-10, 10)
    
    # Create two equations that have this solution
    # ax + by = c and dx + ey = f
    a = nonzero(-5, 5)
    b = nonzero(-5, 5)
    c = a * x_val + b * y_val
    
    d = nonzero(-5, 5)
    e = nonzero(-5, 5)
    # Make sure the system isn't degenerate (determinant != 0)
    while a * e - b * d == 0:
        d = nonzero(-5, 5)
        e = nonzero(-5, 5)
    f = d * x_val + e * y_val
    
    # Decide difficulty based on coefficient size and solution complexity
    max_coeff = max(abs(a), abs(b), abs(c), abs(d), abs(e), abs(f))
    if max_coeff <= 3 and abs(x_val) <= 5 and abs(y_val) <= 5:
        difficulty = randint(1300, 1400)
    else:
        difficulty = randint(1400, 1600)
    
    # Format the equations nicely
    def format_term(coeff, var, first=False):
        if coeff == 0:
            return ""
        sign = "+" if coeff > 0 and not first else ""
        if coeff == -1:
            sign = "-"
        elif coeff == 1:
            if first:
                return var
            else:
                return f"+{var}"
        if abs(coeff) == 1:
            return f"{sign}{var}"
        return f"{sign}{abs(coeff)}{var}" if coeff < 0 or not first else f"{coeff}{var}"
    
    eq1_left = format_term(a, "x", True) + format_term(b, "y")
    eq2_left = format_term(d, "x", True) + format_term(e, "y")
    
    # Build solution steps
    # Choose elimination variable
    if abs(a) <= abs(b):
        # Eliminate x
        mult1 = abs(d)
        mult2 = abs(a)
        elim_var = "x"
        
        # Multiply equations
        new_a1 = a * mult1
        new_b1 = b * mult1
        new_c1 = c * mult1
        
        new_a2 = d * mult2
        new_b2 = e * mult2
        new_c2 = f * mult2
        
        # Make coefficients opposite signs
        if a * d > 0:
            new_a2 = -new_a2
            new_b2 = -new_b2
            new_c2 = -new_c2
        
        resulting_b = new_b1 + new_b2
        resulting_c = new_c1 + new_c2
        
        step1 = f"Multiply equation (1) by ${mult1}$: ${latex(new_a1)}x {'+' if new_b1 >= 0 else ''}{latex(new_b1)}y = {latex(new_c1)}$"
        step2 = f"Multiply equation (2) by ${mult2 if new_a2 > 0 else -mult2}$: ${latex(new_a2)}x {'+' if new_b2 >= 0 else ''}{latex(new_b2)}y = {latex(new_c2)}$"
        step3 = f"Add the equations to eliminate $x$: ${latex(resulting_b)}y = {latex(resulting_c)}$"
        step4 = f"Solve for $y$: $y = {latex(y_val)}$"
        step5 = f"Substitute $y = {latex(y_val)}$ into equation (1): ${latex(a)}x {'+' if b >= 0 else ''}{latex(b)}({latex(y_val)}) = {latex(c)}$"
        step6 = f"Solve for $x$: $x = {latex(x_val)}$"
    else:
        # Eliminate y
        mult1 = abs(e)
        mult2 = abs(b)
        elim_var = "y"
        
        new_a1 = a * mult1
        new_b1 = b * mult1
        new_c1 = c * mult1
        
        new_a2 = d * mult2
        new_b2 = e * mult2
        new_c2 = f * mult2
        
        if b * e > 0:
            new_a2 = -new_a2
            new_b2 = -new_b2
            new_c2 = -new_c2
        
        resulting_a = new_a1 + new_a2
        resulting_c = new_c1 + new_c2
        
        step1 = f"Multiply equation (1) by ${mult1}$: ${latex(new_a1)}x {'+' if new_b1 >= 0 else ''}{latex(new_b1)}y = {latex(new_c1)}$"
        step2 = f"Multiply equation (2) by ${mult2 if new_a2 > 0 else -mult2}$: ${latex(new_a2)}x {'+' if new_b2 >= 0 else ''}{latex(new_b2)}y = {latex(new_c2)}$"
        step3 = f"Add the equations to eliminate $y$: ${latex(resulting_a)}x = {latex(resulting_c)}$"
        step4 = f"Solve for $x$: $x = {latex(x_val)}$"
        step5 = f"Substitute $x = {latex(x_val)}$ into equation (1): ${latex(a)}({latex(x_val)}) {'+' if b >= 0 else ''}{latex(b)}y = {latex(c)}$"
        step6 = f"Solve for $y$: $y = {latex(y_val)}$"
    
    return problem(
        question=f"Solve the system using elimination:<br>$\\begin{{cases}} {eq1_left} = {c} \\\\ {eq2_left} = {f} \\end{{cases}}$",
        answer=fmt_tuple(x_val, y_val),
        difficulty=difficulty,
        topic="algebra1/systems_elimination",
        solution=steps(step1, step2, step3, step4, step5, step6, f"Solution: $(x, y) = ({latex(x_val)}, {latex(y_val)})$"),
        answer_type="tuple"
    )

emit(generate())