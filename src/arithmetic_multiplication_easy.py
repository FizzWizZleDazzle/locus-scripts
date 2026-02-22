"""
arithmetic - multiplication (easy)
Generated: 2026-02-22T03:38:50.816491
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Single digit multiplication (1000-1100 ELO)
        a_val = randint(2, 9)
        b_val = randint(2, 9)
        ans = a_val * b_val
        
        return problem(
            question=f"${a_val} \\times {b_val} = ?$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/multiplication",
            solution=f"${a_val} \\times {b_val} = {ans}$"
        )
    
    elif problem_type == 2:
        # Single digit times double digit (1100-1200 ELO)
        a_val = randint(2, 9)
        b_val = randint(10, 20)
        ans = a_val * b_val
        
        return problem(
            question=f"${a_val} \\times {b_val} = ?$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Multiply ${a_val} \\times {b_val}$",
                f"${a_val} \\times {b_val} = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Two-digit times single digit with regrouping (1150-1250 ELO)
        tens = randint(2, 9)
        ones = randint(2, 9)
        a_val = tens * 10 + ones
        b_val = randint(2, 9)
        ans = a_val * b_val
        
        return problem(
            question=f"${a_val} \\times {b_val} = ?$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Break down: ${a_val} = {tens * 10} + {ones}$",
                f"${b_val} \\times {tens * 10} = {b_val * tens * 10}$",
                f"${b_val} \\times {ones} = {b_val * ones}$",
                f"${b_val * tens * 10} + {b_val * ones} = {ans}$"
            )
        )
    
    else:
        # Multiply by 10, 100 (1050-1150 ELO)
        a_val = randint(2, 99)
        multiplier = choice([10, 100])
        ans = a_val * multiplier
        
        zeros = "0" if multiplier == 10 else "00"
        
        return problem(
            question=f"${a_val} \\times {multiplier} = ?$",
            answer=ans,
            difficulty=(1050, 1150),
            topic="arithmetic/multiplication",
            solution=steps(
                f"When multiplying by ${multiplier}$, add {len(zeros)} zero(s) to the end",
                f"${a_val} \\times {multiplier} = {ans}$"
            )
        )

emit(generate())