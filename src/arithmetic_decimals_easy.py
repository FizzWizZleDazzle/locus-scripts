"""
arithmetic - decimals (easy)
Generated: 2026-02-22T03:42:31.874057
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Simple decimal addition (1000-1100)
        a = round(uniform(0.1, 9.9), 1)
        b = round(uniform(0.1, 9.9), 1)
        ans = round(a + b, 1)
        return problem(
            question=f"${a} + {b} = ?$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/decimals",
            solution=steps(
                f"Add the decimals: ${a} + {b}$",
                f"${ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Simple decimal subtraction (1000-1100)
        b = round(uniform(0.1, 5.0), 1)
        a = round(uniform(b + 0.1, 9.9), 1)
        ans = round(a - b, 1)
        return problem(
            question=f"${a} - {b} = ?$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/decimals",
            solution=steps(
                f"Subtract the decimals: ${a} - {b}$",
                f"${ans}$"
            ),
        )
    
    elif problem_type == 3:
        # Decimal multiplication by whole number (1100-1200)
        dec = round(uniform(0.1, 9.9), 1)
        whole = randint(2, 9)
        ans = round(dec * whole, 1)
        return problem(
            question=f"${dec} \\times {whole} = ?$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/decimals",
            solution=steps(
                f"Multiply the decimal by the whole number: ${dec} \\times {whole}$",
                f"${ans}$"
            ),
        )
    
    elif problem_type == 4:
        # Simple decimal division (1200-1300)
        divisor = choice([2, 4, 5])
        quotient = round(uniform(0.2, 5.0), 1)
        dividend = round(quotient * divisor, 1)
        ans = round(dividend / divisor, 2)
        return problem(
            question=f"${dividend} \\div {divisor} = ?$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/decimals",
            solution=steps(
                f"Divide the decimal: ${dividend} \\div {divisor}$",
                f"${ans}$"
            ),
        )
    
    elif problem_type == 5:
        # Two decimal addition (1100-1200)
        a = round(uniform(1.0, 9.9), 2)
        b = round(uniform(1.0, 9.9), 2)
        ans = round(a + b, 2)
        return problem(
            question=f"${a} + {b} = ?$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/decimals",
            solution=steps(
                f"Add the decimals, aligning decimal points:",
                f"${a} + {b} = {ans}$"
            ),
        )
    
    else:
        # Decimal multiplication (1200-1300)
        a = round(uniform(0.1, 9.9), 1)
        b = round(uniform(0.1, 9.9), 1)
        ans = round(a * b, 2)
        return problem(
            question=f"${a} \\times {b} = ?$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/decimals",
            solution=steps(
                f"Multiply the decimals: ${a} \\times {b}$",
                f"Count total decimal places: 2",
                f"${ans}$"
            ),
        )

emit(generate())