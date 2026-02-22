"""
algebra1 - one_step_equations (medium)
Generated: 2026-02-22T03:47:11.752397
"""

from problem_utils import *

def generate():
    # For one-step equations at 1300-1600 ELO range, we want:
    # - 1300: simple addition/subtraction or multiplication/division
    # - 1400-1500: multiplication/division with fractions or negatives
    # - 1600: division with fractions or slightly more complex coefficients
    
    difficulty_choice = randint(1300, 1600)
    
    if difficulty_choice <= 1350:
        # Simple addition/subtraction: x + a = b or x - a = b
        a_val = nonzero(-10, 10)
        solution_val = randint(-15, 15)
        
        if choice([True, False]):
            # x + a = b form
            b_val = solution_val + a_val
            equation = Eq(x + a_val, b_val)
            solution_text = steps(
                f"Subtract ${a_val}$ from both sides",
                f"$x = {b_val} - ({a_val})$",
                f"$x = {solution_val}$"
            )
        else:
            # x - a = b form
            b_val = solution_val - a_val
            equation = Eq(x - a_val, b_val)
            solution_text = steps(
                f"Add ${a_val}$ to both sides",
                f"$x = {b_val} + {a_val}$",
                f"$x = {solution_val}$"
            )
    
    elif difficulty_choice <= 1450:
        # Simple multiplication/division: ax = b or x/a = b
        a_val = nonzero(-8, 8)
        solution_val = nonzero(-12, 12)
        
        if choice([True, False]):
            # ax = b form
            b_val = a_val * solution_val
            equation = Eq(a_val * x, b_val)
            solution_text = steps(
                f"Divide both sides by ${a_val}$",
                f"$x = \\frac{{{b_val}}}{{{a_val}}}$",
                f"$x = {solution_val}$"
            )
        else:
            # x/a = b form
            b_val = solution_val // a_val if solution_val % a_val == 0 else Rational(solution_val, a_val)
            equation = Eq(x / a_val, b_val)
            solution_text = steps(
                f"Multiply both sides by ${a_val}$",
                f"$x = {latex(b_val)} \\cdot {a_val}$",
                f"$x = {solution_val}$"
            )
    
    elif difficulty_choice <= 1550:
        # Multiplication/division with fractions or negatives
        numerator = nonzero(-6, 6)
        denominator = choice([2, 3, 4, 5])
        solution_val = nonzero(-10, 10)
        
        if choice([True, False]):
            # (a/b)x = c form
            coeff = Rational(numerator, denominator)
            c_val = coeff * solution_val
            equation = Eq(coeff * x, c_val)
            solution_text = steps(
                f"Multiply both sides by $\\frac{{{denominator}}}{{{numerator}}}$",
                f"$x = {latex(c_val)} \\cdot \\frac{{{denominator}}}{{{numerator}}}$",
                f"$x = {solution_val}$"
            )
        else:
            # x/(a/b) = c form, which is (b/a)x = c
            c_val = randint(-15, 15)
            solution_val = Rational(numerator * c_val, denominator)
            equation = Eq(x / Rational(denominator, numerator), c_val)
            solution_text = steps(
                f"Multiply both sides by $\\frac{{{denominator}}}{{{numerator}}}$",
                f"$x = {c_val} \\cdot \\frac{{{denominator}}}{{{numerator}}}$",
                f"$x = {latex(solution_val)}$"
            )
    
    else:
        # 1550-1600: Fraction coefficients with fraction solutions
        num1 = nonzero(-5, 5)
        den1 = choice([2, 3, 4, 5])
        num2 = nonzero(-8, 8)
        den2 = choice([2, 3, 4, 5])
        
        coeff = Rational(num1, den1)
        rhs = Rational(num2, den2)
        solution_val = simplify(rhs / coeff)
        
        equation = Eq(coeff * x, rhs)
        solution_text = steps(
            f"Multiply both sides by $\\frac{{{den1}}}{{{num1}}}$",
            f"$x = \\frac{{{num2}}}{{{den2}}} \\cdot \\frac{{{den1}}}{{{num1}}}$",
            f"$x = {latex(solution_val)}$"
        )
    
    return problem(
        question=f"Solve for $x$: ${latex(equation)}$",
        answer=solution_val,
        difficulty=difficulty_choice,
        topic="algebra1/one_step_equations",
        solution=solution_text
    )

emit(generate())