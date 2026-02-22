"""
algebra1 - two_step_equations (easy)
Generated: 2026-02-22T03:47:49.571653
"""

from problem_utils import *

def generate():
    # For EASIER two-step equations (1000-1300 range), we want simple problems
    # Types: ax + b = c or x/a + b = c or ax - b = c
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type: ax + b = c (most basic two-step)
        a = nonzero(-5, 5)
        x_val = randint(-10, 10)
        b = nonzero(-10, 10)
        c = a * x_val + b
        
        equation = Eq(a*x + b, c)
        ans = x_val
        
        return problem(
            question=f"Solve for $x$: ${latex(a*x + b)} = {c}$",
            answer=ans,
            difficulty=(1000, 1200),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"Given: ${latex(equation)}$",
                f"Subtract ${b}$ from both sides: ${latex(a*x)} = {c - b}$",
                f"Divide both sides by ${a}$: $x = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Type: ax - b = c
        a = nonzero(-5, 5)
        x_val = randint(-10, 10)
        b = nonzero(1, 10)
        c = a * x_val - b
        
        equation = Eq(a*x - b, c)
        ans = x_val
        
        return problem(
            question=f"Solve for $x$: ${latex(a*x - b)} = {c}$",
            answer=ans,
            difficulty=(1000, 1200),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"Given: ${latex(equation)}$",
                f"Add ${b}$ to both sides: ${latex(a*x)} = {c + b}$",
                f"Divide both sides by ${a}$: $x = {ans}$"
            ),
        )
    
    elif problem_type == 3:
        # Type: x/a + b = c (division version, easier numbers)
        a = choice([2, 3, 4, 5])
        x_val = a * randint(-8, 8)  # Make sure x is divisible by a
        b = randint(-10, 10)
        c = x_val // a + b
        
        equation = Eq(x/a + b, c)
        ans = x_val
        
        return problem(
            question=f"Solve for $x$: $\\frac{{x}}{{{a}}} + {b} = {c}$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"Given: ${latex(equation)}$",
                f"Subtract ${b}$ from both sides: $\\frac{{x}}{{{a}}} = {c - b}$",
                f"Multiply both sides by ${a}$: $x = {ans}$"
            ),
        )
    
    else:
        # Type: b + ax = c (variable term second, slightly different)
        a = nonzero(-5, 5)
        x_val = randint(-10, 10)
        b = nonzero(-10, 10)
        c = b + a * x_val
        
        equation = Eq(b + a*x, c)
        ans = x_val
        
        return problem(
            question=f"Solve for $x$: ${b + latex(a*x)} = {c}$",
            answer=ans,
            difficulty=(1000, 1200),
            topic="algebra1/two_step_equations",
            solution=steps(
                f"Given: ${latex(equation)}$",
                f"Subtract ${b}$ from both sides: ${latex(a*x)} = {c - b}$",
                f"Divide both sides by ${a}$: $x = {ans}$"
            ),
        )

emit(generate())