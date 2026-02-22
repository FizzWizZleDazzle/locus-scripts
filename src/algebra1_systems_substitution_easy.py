"""
algebra1 - systems_substitution (easy)
Generated: 2026-02-22T03:55:29.838615
"""

from problem_utils import *

def generate():
    # For easier substitution problems (1000-1300), we want:
    # - One variable already isolated (y = ...)
    # - Simple coefficients
    # - Integer solutions
    
    # Pick the solution first (clean integers)
    x_sol = randint(-5, 5)
    y_sol = randint(-5, 5)
    
    # Create first equation: y = mx + b (already solved for y)
    m = nonzero(-3, 3)
    b = y_sol - m * x_sol  # Reverse engineer so (x_sol, y_sol) is on the line
    
    # Create second equation: ax + by = c
    a_coef = nonzero(-4, 4)
    b_coef = nonzero(-4, 4)
    c_val = a_coef * x_sol + b_coef * y_sol  # Reverse engineer
    
    # Determine difficulty based on complexity
    # 1000-1100: Very simple coefficients, no distribution needed
    # 1100-1200: Simple substitution, one-step simplification
    # 1200-1300: Requires distribution or combining like terms
    
    if abs(m) == 1 and abs(a_coef) <= 2 and abs(b_coef) <= 2:
        diff = randint(1000, 1100)
    elif abs(m) <= 2 and abs(a_coef) <= 3:
        diff = randint(1100, 1200)
    else:
        diff = randint(1200, 1300)
    
    # Format equations
    eq1 = Eq(y, m*x + b)
    eq2 = Eq(a_coef*x + b_coef*y, c_val)
    
    # Build solution steps
    # Step 1: Identify substitution
    step1 = f"From the first equation: $y = {latex(m*x + b)}$"
    
    # Step 2: Substitute into second equation
    eq2_subbed = a_coef*x + b_coef*(m*x + b)
    step2 = f"Substitute into ${latex(eq2.lhs)} = {c_val}$: ${latex(eq2_subbed)} = {c_val}$"
    
    # Step 3: Simplify and solve for x
    eq2_simplified = simplify(eq2_subbed)
    step3 = f"Simplify: ${latex(eq2_simplified)} = {c_val}$"
    
    # Step 4: Solve for x
    step4 = f"Solve for $x$: $x = {x_sol}$"
    
    # Step 5: Find y
    step5 = f"Substitute $x = {x_sol}$ into $y = {latex(m*x + b)}$: $y = {latex(m*x_sol + b)} = {y_sol}$"
    
    # Step 6: Write solution as ordered pair
    step6 = f"Solution: $(x, y) = ({x_sol}, {y_sol})$"
    
    answer = (x_sol, y_sol)
    
    return problem(
        question=f"Solve the system using substitution:\n$$\\begin{{align*}}{latex(eq1.lhs)} &= {latex(eq1.rhs)} \\\\ {latex(eq2.lhs)} &= {latex(eq2.rhs)}\\end{{align*}}$$",
        answer=answer,
        difficulty=diff,
        topic="algebra1/systems_substitution",
        solution=steps(step1, step2, step3, step4, step5, step6),
        answer_type="tuple"
    )

emit(generate())