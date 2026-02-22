"""
algebra1 - systems_substitution (medium)
Generated: 2026-02-22T03:55:52.410804
"""

from problem_utils import *

def generate():
    # Choose the type of system and difficulty
    problem_type = choice(['basic_substitution', 'expression_substitution', 'both_standard'])
    
    if problem_type == 'basic_substitution':
        # 1300-1400: One equation already solved for a variable
        # Create a clean solution first
        x_val = randint(-5, 5)
        y_val = randint(-5, 5)
        
        # First equation: y = mx + b (already solved)
        m = nonzero(-3, 3)
        b = y_val - m * x_val
        
        # Second equation: ax + by = c
        a_coeff = nonzero(-4, 4)
        b_coeff = nonzero(-4, 4)
        c_val = a_coeff * x_val + b_coeff * y_val
        
        eq1_str = f"y = {latex(m*x + b)}"
        eq2_str = f"{latex(a_coeff*x + b_coeff*y)} = {c_val}"
        
        solution_text = steps(
            f"Given $y = {latex(m*x + b)}$ from the first equation",
            f"Substitute into ${latex(a_coeff*x + b_coeff*y)} = {c_val}$",
            f"${latex(a_coeff*x + b_coeff*(m*x + b))} = {c_val}$",
            f"${latex(expand(a_coeff*x + b_coeff*(m*x + b)))} = {c_val}$",
            f"Solving for $x$: $x = {x_val}$",
            f"Substitute back: $y = {latex(m*x_val + b)} = {y_val}$",
            f"Solution: $(x, y) = ({x_val}, {y_val})$"
        )
        
        difficulty_rating = randint(1300, 1400)
        
    elif problem_type == 'expression_substitution':
        # 1400-1500: Need to solve one equation for a variable first
        x_val = randint(-4, 4)
        y_val = randint(-4, 4)
        
        # First equation: ax + by = c (need to solve for one variable)
        a1 = nonzero(-3, 3)
        b1 = nonzero(-3, 3)
        c1 = a1 * x_val + b1 * y_val
        
        # Second equation: dx + ey = f
        a2 = nonzero(-4, 4)
        b2 = nonzero(-4, 4)
        c2 = a2 * x_val + b2 * y_val
        
        eq1_str = f"{latex(a1*x + b1*y)} = {c1}"
        eq2_str = f"{latex(a2*x + b2*y)} = {c2}"
        
        # Solve first equation for y
        y_expr = (c1 - a1*x) / b1
        
        solution_text = steps(
            f"Solve first equation for $y$: ${latex(b1*y)} = {latex(c1 - a1*x)}$",
            f"$y = {latex(y_expr)}$",
            f"Substitute into ${latex(a2*x + b2*y)} = {c2}$",
            f"${latex(a2*x + b2*y_expr)} = {c2}$",
            f"${latex(simplify(a2*x + b2*y_expr))} = {c2}$",
            f"Solving for $x$: $x = {x_val}$",
            f"Substitute back: $y = {latex(y_expr.subs(x, x_val))} = {y_val}$",
            f"Solution: $(x, y) = ({x_val}, {y_val})$"
        )
        
        difficulty_rating = randint(1400, 1500)
        
    else:  # both_standard
        # 1500-1600: Both equations in standard form, requires more steps
        x_val = randint(-3, 3)
        y_val = randint(-3, 3)
        
        # Create two equations in standard form
        a1 = nonzero(-4, 4)
        b1 = nonzero(-4, 4)
        c1 = a1 * x_val + b1 * y_val
        
        a2 = nonzero(-4, 4)
        b2 = nonzero(-4, 4)
        # Make sure system is not too similar
        while abs(a2 * b1 - a1 * b2) < 2:
            a2 = nonzero(-4, 4)
            b2 = nonzero(-4, 4)
        c2 = a2 * x_val + b2 * y_val
        
        eq1_str = f"{latex(a1*x + b1*y)} = {c1}"
        eq2_str = f"{latex(a2*x + b2*y)} = {c2}"
        
        # Solve first equation for y (or x, whichever is simpler)
        if abs(b1) == 1:
            y_expr = (c1 - a1*x) / b1
            var_solved = "y"
        else:
            y_expr = (c1 - a1*x) / b1
            var_solved = "y"
        
        solution_text = steps(
            f"Solve first equation for $y$: ${latex(b1*y)} = {latex(c1 - a1*x)}$",
            f"$y = {latex(y_expr)}$",
            f"Substitute into second equation: ${latex(a2*x + b2*y)} = {c2}$",
            f"${latex(a2*x + b2*y_expr)} = {c2}$",
            f"Simplify and solve for $x$",
            f"$x = {x_val}$",
            f"Substitute back: $y = {y_val}$",
            f"Solution: $(x, y) = ({x_val}, {y_val})$"
        )
        
        difficulty_rating = randint(1500, 1600)
    
    question_text = f"Solve the system using substitution:<br>${eq1_str}$<br>${eq2_str}$"
    
    return problem(
        question=question_text,
        answer=fmt_tuple([x_val, y_val]),
        difficulty=difficulty_rating,
        topic="algebra1/systems_substitution",
        solution=solution_text,
        answer_type="tuple"
    )

emit(generate())