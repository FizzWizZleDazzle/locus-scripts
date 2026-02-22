"""
algebra1 - two_step_equations (medium)
Generated: 2026-02-22T03:47:57.811973
"""

from problem_utils import *

def generate():
    # Two-step equation: ax + b = c
    # Standard difficulty for two-step equations: 1300-1600
    
    # Pick a clean solution first
    solution_x = randint(-10, 10)
    
    # Pick coefficient and constants
    a = nonzero(-8, 8)
    b = nonzero(-15, 15)
    
    # Calculate what the right side should be
    c = a * solution_x + b
    
    # Create the equation
    equation = Eq(a*x + b, c)
    
    # Solve to verify
    ans = solve(equation, x)[0]
    
    # Build solution steps
    step1 = f"Start with ${latex(equation)}$"
    
    # Step 2: Subtract b from both sides
    if b > 0:
        step2 = f"Subtract ${b}$ from both sides: ${latex(a*x)} = {c - b}$"
    else:
        step2 = f"Add ${-b}$ to both sides: ${latex(a*x)} = {c - b}$"
    
    # Step 3: Divide by a
    if a == 1:
        step3 = f"$x = {ans}$"
    elif a == -1:
        step3 = f"Multiply both sides by $-1$: $x = {ans}$"
    else:
        step3 = f"Divide both sides by ${a}$: $x = {ans}$"
    
    return problem(
        question=f"Solve for $x$: ${latex(equation)}$",
        answer=ans,
        difficulty=(1300, 1400),
        topic="algebra1/two_step_equations",
        solution=steps(step1, step2, step3),
        grading_mode="equivalent"
    )

emit(generate())