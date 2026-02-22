"""
algebra1 - systems_elimination (easy)
Generated: 2026-02-22T03:56:45.993910
"""

from problem_utils import *

def generate():
    # For systems of linear equations using elimination method
    # ELO 1000-1300: EASIER problems
    
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # ELO ~1000-1100: Very simple elimination, coefficients already match
        # One variable has matching coefficients (just add or subtract)
        sol_x = randint(-5, 5)
        sol_y = randint(-5, 5)
        
        # Create system where one coefficient matches
        coeff_match = choice([1, 2, 3])
        a1 = coeff_match
        a2 = coeff_match
        
        b1 = nonzero(-3, 3)
        b2 = nonzero(-3, 3)
        
        # Make sure we can eliminate by subtraction
        c1 = a1 * sol_x + b1 * sol_y
        c2 = a2 * sol_x + b2 * sol_y
        
        eq1_latex = f"{a1}x " + (f"+ {b1}y" if b1 > 0 else f"{b1}y") + f" = {c1}"
        eq2_latex = f"{a2}x " + (f"+ {b2}y" if b2 > 0 else f"{b2}y") + f" = {c2}"
        
        solution_steps = steps(
            f"Given system: ${eq1_latex}$ and ${eq2_latex}$",
            f"Since both equations have ${a1}x$, subtract equation 2 from equation 1",
            f"$({b1}y) - ({b2}y) = {c1} - ({c2})$",
            f"${b1 - b2}y = {c1 - c2}$",
            f"$y = {sol_y}$",
            f"Substitute $y = {sol_y}$ into first equation:",
            f"${a1}x + {b1}({sol_y}) = {c1}$",
            f"${a1}x = {c1 - b1*sol_y}$",
            f"$x = {sol_x}$"
        )
        
        ans = fmt_tuple(sol_x, sol_y)
        elo = (1000, 1100)
        
    elif difficulty_choice == 2:
        # ELO ~1100-1200: Simple elimination, multiply one equation by small integer
        sol_x = randint(-4, 4)
        sol_y = randint(-4, 4)
        
        a1 = choice([1, 2, 3])
        multiplier = choice([2, 3])
        a2 = a1 * multiplier
        
        b1 = nonzero(-3, 3)
        b2 = nonzero(-3, 3)
        
        c1 = a1 * sol_x + b1 * sol_y
        c2 = a2 * sol_x + b2 * sol_y
        
        eq1_latex = f"{a1}x " + (f"+ {b1}y" if b1 > 0 else f"{b1}y") + f" = {c1}"
        eq2_latex = f"{a2}x " + (f"+ {b2}y" if b2 > 0 else f"{b2}y") + f" = {c2}"
        
        new_c1 = c1 * multiplier
        new_b1 = b1 * multiplier
        
        solution_steps = steps(
            f"Given system: ${eq1_latex}$ and ${eq2_latex}$",
            f"Multiply equation 1 by ${multiplier}$:",
            f"${a2}x " + (f"+ {new_b1}y" if new_b1 > 0 else f"{new_b1}y") + f" = {new_c1}$",
            f"Subtract equation 2 from the new equation:",
            f"$({new_b1}y) - ({b2}y) = {new_c1} - ({c2})$",
            f"${new_b1 - b2}y = {new_c1 - c2}$",
            f"$y = {sol_y}$",
            f"Substitute $y = {sol_y}$ into first equation:",
            f"${a1}x + {b1}({sol_y}) = {c1}$",
            f"$x = {sol_x}$"
        )
        
        ans = fmt_tuple(sol_x, sol_y)
        elo = (1100, 1200)
        
    else:
        # ELO ~1200-1300: Standard elimination, need to choose which variable to eliminate
        sol_x = randint(-3, 3)
        sol_y = randint(-3, 3)
        
        a1 = nonzero(-3, 3)
        b1 = nonzero(-3, 3)
        a2 = nonzero(-3, 3)
        b2 = nonzero(-3, 3)
        
        # Make sure the system is actually solvable with different slopes
        while a1 * b2 == a2 * b1:
            a2 = nonzero(-3, 3)
            b2 = nonzero(-3, 3)
        
        c1 = a1 * sol_x + b1 * sol_y
        c2 = a2 * sol_x + b2 * sol_y
        
        eq1_latex = f"{a1}x " + (f"+ {b1}y" if b1 > 0 else f"{b1}y") + f" = {c1}"
        eq2_latex = f"{a2}x " + (f"+ {b2}y" if b2 > 0 else f"{b2}y") + f" = {c2}"
        
        # Eliminate x by multiplying
        mult1 = abs(a2)
        mult2 = abs(a1)
        
        new_a = mult1 * a1
        new_b1 = mult1 * b1
        new_c1 = mult1 * c1
        
        new_a2 = mult2 * a2
        new_b2 = mult2 * b2
        new_c2 = mult2 * c2
        
        solution_steps = steps(
            f"Given system: ${eq1_latex}$ and ${eq2_latex}$",
            f"To eliminate $x$, multiply equation 1 by ${mult1}$ and equation 2 by ${mult2}$:",
            f"Equation 1 becomes: ${new_a}x " + (f"+ {new_b1}y" if new_b1 > 0 else f"{new_b1}y") + f" = {new_c1}$",
            f"Equation 2 becomes: ${new_a2}x " + (f"+ {new_b2}y" if new_b2 > 0 else f"{new_b2}y") + f" = {new_c2}$",
            f"Subtract to eliminate $x$: $({new_b1} - ({new_b2}))y = {new_c1} - ({new_c2})$",
            f"${new_b1 - new_b2}y = {new_c1 - new_c2}$",
            f"$y = {sol_y}$",
            f"Substitute back: $x = {sol_x}$"
        )
        
        ans = fmt_tuple(sol_x, sol_y)
        elo = (1200, 1300)
    
    question_text = f"Solve the system using elimination:\n$$\\begin{{cases}} {eq1_latex} \\\\ {eq2_latex} \\end{{cases}}$$"
    
    return problem(
        question=question_text,
        answer=ans,
        difficulty=elo,
        topic="algebra1/systems_elimination",
        solution=solution_steps,
        answer_type="tuple"
    )

emit(generate())