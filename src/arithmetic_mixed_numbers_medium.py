"""
arithmetic - mixed_numbers (medium)
Generated: 2026-02-22T03:41:41.674311
"""

from problem_utils import *

def generate():
    # Choose operation type
    op_type = choice(['add', 'subtract', 'multiply', 'divide'])
    
    # Generate random mixed numbers - construct from clean parts
    # First mixed number
    whole1 = randint(1, 5)
    numer1 = randint(1, 7)
    denom1 = randint(numer1 + 1, 10)  # Ensure proper fraction
    
    # Second mixed number
    whole2 = randint(1, 5)
    numer2 = randint(1, 7)
    denom2 = randint(numer2 + 1, 10)  # Ensure proper fraction
    
    # Convert to improper fractions for calculation
    improper1 = Rational(whole1 * denom1 + numer1, denom1)
    improper2 = Rational(whole2 * denom2 + numer2, denom2)
    
    # Perform operation
    if op_type == 'add':
        result = improper1 + improper2
        op_symbol = '+'
        op_word = 'Add'
    elif op_type == 'subtract':
        # Ensure positive result
        if improper1 < improper2:
            improper1, improper2 = improper2, improper1
            whole1, whole2 = whole2, whole1
            numer1, numer2 = numer2, numer1
            denom1, denom2 = denom2, denom1
        result = improper1 - improper2
        op_symbol = '-'
        op_word = 'Subtract'
    elif op_type == 'multiply':
        result = improper1 * improper2
        op_symbol = '\\times'
        op_word = 'Multiply'
    else:  # divide
        result = improper1 / improper2
        op_symbol = '\\div'
        op_word = 'Divide'
    
    # Format mixed numbers for display
    mixed1_latex = f"{whole1}\\frac{{{numer1}}}{{{denom1}}}"
    mixed2_latex = f"{whole2}\\frac{{{numer2}}}{{{denom2}}}"
    
    # Convert result to mixed number if improper
    result_whole = int(result)
    result_remainder = result - result_whole
    
    if result_remainder == 0:
        answer_latex = str(result_whole)
        answer_value = result_whole
    elif abs(result) < 1:
        # Proper fraction
        answer_latex = f"\\frac{{{result.p}}}{{{result.q}}}"
        answer_value = result
    else:
        # Mixed number
        if result < 0:
            result_whole = int(result) - 1
            result_remainder = result - result_whole
        answer_whole = abs(result_whole)
        frac_part = abs(result_remainder)
        if result < 0:
            answer_latex = f"-{answer_whole}\\frac{{{frac_part.p}}}{{{frac_part.q}}}"
        else:
            answer_latex = f"{answer_whole}\\frac{{{frac_part.p}}}{{{frac_part.q}}}"
        answer_value = result
    
    # Build solution steps
    improper1_latex = f"\\frac{{{improper1.p}}}{{{improper1.q}}}"
    improper2_latex = f"\\frac{{{improper2.p}}}{{{improper2.q}}}"
    
    solution_steps = [
        f"Convert mixed numbers to improper fractions:",
        f"${mixed1_latex} = {improper1_latex}$ and ${mixed2_latex} = {improper2_latex}$"
    ]
    
    if op_type in ['add', 'subtract']:
        # Find LCD
        from math import gcd
        lcm = (denom1 * denom2) // gcd(denom1, denom2)
        mult1 = lcm // denom1
        mult2 = lcm // denom2
        new_numer1 = improper1.p * mult1
        new_numer2 = improper2.p * mult2
        
        solution_steps.append(f"Find common denominator (LCD = {lcm}):")
        solution_steps.append(f"${improper1_latex} = \\frac{{{new_numer1}}}{{{lcm}}}$ and ${improper2_latex} = \\frac{{{new_numer2}}}{{{lcm}}}$")
        
        if op_type == 'add':
            solution_steps.append(f"Add the numerators: $\\frac{{{new_numer1} + {new_numer2}}}{{{lcm}}} = \\frac{{{result.p}}}{{{result.q}}}$")
        else:
            solution_steps.append(f"Subtract the numerators: $\\frac{{{new_numer1} - {new_numer2}}}{{{lcm}}} = \\frac{{{result.p}}}{{{result.q}}}$")
    elif op_type == 'multiply':
        solution_steps.append(f"Multiply numerators and denominators:")
        solution_steps.append(f"$\\frac{{{improper1.p} \\times {improper2.p}}}{{{improper1.q} \\times {improper2.q}}} = \\frac{{{result.p}}}{{{result.q}}}$")
    else:  # divide
        solution_steps.append(f"Multiply by the reciprocal:")
        solution_steps.append(f"$\\frac{{{improper1.p}}}{{{improper1.q}}} \\times \\frac{{{improper2.q}}}{{{improper2.p}}} = \\frac{{{result.p}}}{{{result.q}}}$")
    
    solution_steps.append(f"Convert back to mixed number: ${answer_latex}$")
    
    # Set difficulty based on operation
    if op_type in ['add', 'subtract']:
        diff = (1300, 1500)
    else:
        diff = (1400, 1600)
    
    return problem(
        question=f"${mixed1_latex} {op_symbol} {mixed2_latex}$",
        answer=answer_value,
        difficulty=diff,
        topic="arithmetic/mixed_numbers",
        solution=steps(*solution_steps),
        answer_type="numeric"
    )

emit(generate())