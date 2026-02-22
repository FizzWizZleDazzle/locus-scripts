"""
arithmetic - mixed_numbers (easy)
Generated: 2026-02-22T03:41:19.999323
"""

from problem_utils import *

def generate():
    # Pick operation type
    operation = choice(['add', 'subtract', 'multiply'])
    
    if operation == 'add':
        # Addition of mixed numbers
        # Keep it simple: same denominator or easy conversion
        whole1 = randint(1, 5)
        whole2 = randint(1, 5)
        
        # Use simple denominators
        denom = choice([2, 3, 4, 5, 6, 8])
        
        num1 = randint(1, denom - 1)
        num2 = randint(1, denom - 1)
        
        # Create mixed numbers as improper fractions for calculation
        frac1 = Rational(whole1 * denom + num1, denom)
        frac2 = Rational(whole2 * denom + num2, denom)
        
        ans = frac1 + frac2
        
        difficulty_level = randint(1100, 1300)
        
        question = f"${whole1}\\frac{{{num1}}}{{{denom}}} + {whole2}\\frac{{{num2}}}{{{denom}}}$"
        
        solution_steps = [
            f"Convert to improper fractions: $\\frac{{{whole1 * denom + num1}}}{{{denom}}} + \\frac{{{whole2 * denom + num2}}}{{{denom}}}$",
            f"Add the numerators: $\\frac{{{whole1 * denom + num1 + whole2 * denom + num2}}}{{{denom}}}$",
        ]
        
        # Convert answer to mixed number format
        if ans.q == 1:
            solution_steps.append(f"Answer: ${ans.p}$")
        else:
            whole_part = ans.p // ans.q
            remainder = ans.p % ans.q
            if whole_part > 0:
                solution_steps.append(f"Answer: ${whole_part}\\frac{{{remainder}}}{{{ans.q}}}$")
            else:
                solution_steps.append(f"Answer: $\\frac{{{ans.p}}}{{{ans.q}}}$")
        
    elif operation == 'subtract':
        # Subtraction of mixed numbers
        whole1 = randint(2, 6)
        whole2 = randint(1, whole1)
        
        denom = choice([2, 3, 4, 5, 6, 8])
        
        num1 = randint(1, denom - 1)
        num2 = randint(1, denom - 1)
        
        frac1 = Rational(whole1 * denom + num1, denom)
        frac2 = Rational(whole2 * denom + num2, denom)
        
        # Ensure positive result
        if frac1 < frac2:
            frac1, frac2 = frac2, frac1
            whole1, whole2 = whole2, whole1
            num1, num2 = num2, num1
        
        ans = frac1 - frac2
        
        difficulty_level = randint(1150, 1300)
        
        question = f"${whole1}\\frac{{{num1}}}{{{denom}}} - {whole2}\\frac{{{num2}}}{{{denom}}}$"
        
        solution_steps = [
            f"Convert to improper fractions: $\\frac{{{whole1 * denom + num1}}}{{{denom}}} - \\frac{{{whole2 * denom + num2}}}{{{denom}}}$",
            f"Subtract the numerators: $\\frac{{{(whole1 * denom + num1) - (whole2 * denom + num2)}}}{{{denom}}}$",
        ]
        
        if ans.q == 1:
            solution_steps.append(f"Answer: ${ans.p}$")
        else:
            whole_part = ans.p // ans.q
            remainder = ans.p % ans.q
            if whole_part > 0:
                solution_steps.append(f"Answer: ${whole_part}\\frac{{{remainder}}}{{{ans.q}}}$")
            else:
                solution_steps.append(f"Answer: $\\frac{{{ans.p}}}{{{ans.q}}}$")
    
    else:  # multiply
        # Multiplication: mixed number by whole number (easier)
        whole1 = randint(1, 4)
        denom = choice([2, 3, 4, 5])
        num1 = randint(1, denom - 1)
        
        multiplier = randint(2, 4)
        
        frac1 = Rational(whole1 * denom + num1, denom)
        ans = frac1 * multiplier
        
        difficulty_level = randint(1200, 1300)
        
        question = f"${whole1}\\frac{{{num1}}}{{{denom}}} \\times {multiplier}$"
        
        solution_steps = [
            f"Convert to improper fraction: $\\frac{{{whole1 * denom + num1}}}{{{denom}}} \\times {multiplier}$",
            f"Multiply: $\\frac{{{(whole1 * denom + num1) * multiplier}}}{{{denom}}}$",
        ]
        
        if ans.q == 1:
            solution_steps.append(f"Answer: ${ans.p}$")
        else:
            whole_part = ans.p // ans.q
            remainder = ans.p % ans.q
            if whole_part > 0:
                solution_steps.append(f"Answer: ${whole_part}\\frac{{{remainder}}}{{{ans.q}}}$")
            else:
                solution_steps.append(f"Answer: $\\frac{{{ans.p}}}{{{ans.q}}}$")
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty_level,
        topic="arithmetic/mixed_numbers",
        solution=steps(*solution_steps),
        calculator="none"
    )

emit(generate())