"""
algebra1 - one_step_equations (easy)
Generated: 2026-02-22T03:46:53.660170
"""

from problem_utils import *

def generate():
    # For one-step equations in the 1000-1300 ELO range, we want simple problems
    # like x + a = b, x - a = b, a*x = b, x/a = b
    
    equation_type = randint(1, 4)
    
    if equation_type == 1:
        # Addition: x + a = b
        a_val = nonzero(-10, 10)
        x_val = nonzero(-10, 10)
        b_val = x_val + a_val
        
        if a_val > 0:
            question = f"$x + {a_val} = {b_val}$"
        else:
            question = f"$x - {-a_val} = {b_val}$"
        
        solution_text = steps(
            f"Subtract ${a_val}$ from both sides" if a_val > 0 else f"Add ${-a_val}$ to both sides",
            f"$x = {b_val} - ({a_val}) = {x_val}$"
        )
        difficulty_val = (1000, 1200)
        
    elif equation_type == 2:
        # Subtraction: x - a = b
        a_val = nonzero(-10, 10)
        x_val = nonzero(-10, 10)
        b_val = x_val - a_val
        
        if a_val > 0:
            question = f"$x - {a_val} = {b_val}$"
        else:
            question = f"$x + {-a_val} = {b_val}$"
        
        solution_text = steps(
            f"Add ${a_val}$ to both sides" if a_val > 0 else f"Subtract ${-a_val}$ from both sides",
            f"$x = {b_val} + {a_val} = {x_val}$"
        )
        difficulty_val = (1000, 1200)
        
    elif equation_type == 3:
        # Multiplication: a*x = b
        a_val = nonzero(-8, 8)
        x_val = nonzero(-10, 10)
        b_val = a_val * x_val
        
        question = f"${a_val}x = {b_val}$"
        
        solution_text = steps(
            f"Divide both sides by ${a_val}$",
            f"$x = \\frac{{{b_val}}}{{{a_val}}} = {x_val}$"
        )
        difficulty_val = (1100, 1250)
        
    else:
        # Division: x/a = b
        a_val = nonzero(-8, 8)
        b_val = nonzero(-10, 10)
        x_val = a_val * b_val
        
        question = f"$\\frac{{x}}{{{a_val}}} = {b_val}$"
        
        solution_text = steps(
            f"Multiply both sides by ${a_val}$",
            f"$x = {b_val} \\cdot {a_val} = {x_val}$"
        )
        difficulty_val = (1100, 1250)
    
    return problem(
        question=question,
        answer=x_val,
        difficulty=difficulty_val,
        topic="algebra1/one_step_equations",
        solution=solution_text,
        answer_type="numeric"
    )

emit(generate())