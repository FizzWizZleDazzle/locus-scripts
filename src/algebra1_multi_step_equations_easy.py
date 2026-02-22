"""
algebra1 - multi_step_equations (easy)
Generated: 2026-02-22T03:48:52.884638
"""

from problem_utils import *

def generate():
    # For EASIER multi-step equations (1000-1300), we want simple problems
    # that require 2-3 steps but with small, clean numbers
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type: ax + b = c (two-step)
        # ELO ~1000-1200
        a_val = choice([2, 3, 4, 5])
        sol = randint(-5, 5)
        b_val = nonzero(-10, 10)
        c_val = a_val * sol + b_val
        
        equation = f"{a_val}x + {b_val} = {c_val}"
        if b_val < 0:
            equation = f"{a_val}x - {-b_val} = {c_val}"
        
        return problem(
            question=f"Solve for $x$: ${equation}$",
            answer=sol,
            difficulty=(1000, 1200),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"${equation}$",
                f"Subtract ${b_val}$ from both sides: ${a_val}x = {c_val - b_val}$",
                f"Divide both sides by ${a_val}$: $x = {sol}$"
            )
        )
    
    elif problem_type == 2:
        # Type: ax + b = cx + d (variables on both sides)
        # ELO ~1200-1300
        sol = randint(-4, 4)
        a_val = choice([2, 3, 4, 5])
        c_val = choice([1, 2, 3])
        if a_val == c_val:
            c_val += 1
        b_val = nonzero(-8, 8)
        d_val = c_val * sol + b_val - a_val * sol
        
        left = f"{a_val}x + {b_val}" if b_val >= 0 else f"{a_val}x - {-b_val}"
        right = f"{c_val}x + {d_val}" if d_val >= 0 else f"{c_val}x - {-d_val}"
        
        return problem(
            question=f"Solve for $x$: ${left} = {right}$",
            answer=sol,
            difficulty=(1200, 1300),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"${left} = {right}$",
                f"Subtract ${c_val}x$ from both sides: ${a_val - c_val}x + {b_val} = {d_val}$",
                f"Subtract ${b_val}$ from both sides: ${a_val - c_val}x = {d_val - b_val}$",
                f"Divide both sides by ${a_val - c_val}$: $x = {sol}$"
            )
        )
    
    elif problem_type == 3:
        # Type: a(x + b) = c (distribution needed)
        # ELO ~1100-1250
        a_val = choice([2, 3, 4])
        sol = randint(-5, 5)
        b_val = nonzero(-6, 6)
        c_val = a_val * (sol + b_val)
        
        inner = f"x + {b_val}" if b_val >= 0 else f"x - {-b_val}"
        
        return problem(
            question=f"Solve for $x$: ${a_val}({inner}) = {c_val}$",
            answer=sol,
            difficulty=(1100, 1250),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"${a_val}({inner}) = {c_val}$",
                f"Distribute: ${a_val}x + {a_val * b_val} = {c_val}$",
                f"Subtract ${a_val * b_val}$ from both sides: ${a_val}x = {c_val - a_val * b_val}$",
                f"Divide both sides by ${a_val}$: $x = {sol}$"
            )
        )
    
    else:
        # Type: (x + a)/b = c (fraction, single variable)
        # ELO ~1050-1200
        b_val = choice([2, 3, 4, 5])
        c_val = randint(-4, 4)
        a_val = nonzero(-6, 6)
        sol = b_val * c_val - a_val
        
        numerator = f"x + {a_val}" if a_val >= 0 else f"x - {-a_val}"
        
        return problem(
            question=f"Solve for $x$: $\\frac{{{numerator}}}{{{b_val}}} = {c_val}$",
            answer=sol,
            difficulty=(1050, 1200),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"$\\frac{{{numerator}}}{{{b_val}}} = {c_val}$",
                f"Multiply both sides by ${b_val}$: ${numerator} = {b_val * c_val}$",
                f"Subtract ${a_val}$ from both sides: $x = {sol}$"
            )
        )

emit(generate())