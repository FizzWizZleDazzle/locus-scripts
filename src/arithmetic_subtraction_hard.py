"""
arithmetic - subtraction (hard)
Generated: 2026-02-22T03:38:39.930944
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Multi-step subtraction with borrowing across multiple zeros
        # e.g., 10000 - 7834
        base = randint(10, 99) * 1000
        subtrahend = randint(base // 2, base - 1000)
        # Ensure multiple zeros to require extensive borrowing
        if randint(0, 1) == 0:
            base = randint(10, 99) * 10000
            subtrahend = randint(base // 2, base - 1000)
        
        answer = base - subtrahend
        
        return problem(
            question=f"Calculate: ${base} - {subtrahend}$",
            answer=answer,
            difficulty=(1600, 1700),
            topic="arithmetic/subtraction",
            solution=steps(
                f"Subtract ${subtrahend}$ from ${base}$",
                f"Borrowing across zeros as needed",
                f"${base} - {subtrahend} = {answer}$"
            )
        )
    
    elif problem_type == 2:
        # Subtraction with mixed operations requiring order of operations
        # e.g., 85 - 3 × 12 + 7
        a = randint(50, 150)
        b = randint(2, 9)
        c = randint(5, 20)
        d = randint(5, 30)
        
        product = b * c
        answer = a - product + d
        
        return problem(
            question=f"Calculate: ${a} - {b} \\times {c} + {d}$",
            answer=answer,
            difficulty=(1650, 1750),
            topic="arithmetic/subtraction",
            solution=steps(
                f"First multiply: ${b} \\times {c} = {product}$",
                f"Then subtract and add left to right: ${a} - {product} + {d}$",
                f"${a - product} + {d} = {answer}$"
            )
        )
    
    elif problem_type == 3:
        # Subtraction word problem with multiple steps
        initial = randint(500, 2000)
        first_expense = randint(100, initial // 3)
        second_expense = randint(50, (initial - first_expense) // 2)
        third_expense = randint(30, (initial - first_expense - second_expense) // 2)
        
        answer = initial - first_expense - second_expense - third_expense
        
        return problem(
            question=f"A store had \\${initial} in the cash register. They spent \\${first_expense} on supplies, \\${second_expense} on utilities, and \\${third_expense} on repairs. How much money remains?",
            answer=answer,
            difficulty=(1600, 1700),
            topic="arithmetic/subtraction",
            solution=steps(
                f"Start with \\${initial}$",
                f"After supplies: ${initial} - {first_expense} = {initial - first_expense}$",
                f"After utilities: ${initial - first_expense} - {second_expense} = {initial - first_expense - second_expense}$",
                f"After repairs: ${initial - first_expense - second_expense} - {third_expense} = {answer}$"
            )
        )
    
    elif problem_type == 4:
        # Subtraction with large numbers and strategic regrouping
        # Five or six digit numbers
        num_digits = choice([5, 6])
        if num_digits == 5:
            minuend = randint(10000, 99999)
        else:
            minuend = randint(100000, 999999)
        
        subtrahend = randint(minuend // 3, minuend - 1000)
        answer = minuend - subtrahend
        
        return problem(
            question=f"Compute: ${minuend} - {subtrahend}$",
            answer=answer,
            difficulty=(1700, 1800),
            topic="arithmetic/subtraction",
            solution=steps(
                f"Align the numbers by place value",
                f"Borrow as necessary from left to right",
                f"${minuend} - {subtrahend} = {answer}$"
            )
        )
    
    else:
        # Complex subtraction involving negative results and absolute values
        # |a - b| - c where a < b
        a = randint(20, 80)
        b = randint(a + 10, a + 50)
        c = randint(5, (b - a) - 5)
        
        intermediate = abs(a - b)
        answer = intermediate - c
        
        return problem(
            question=f"Calculate: $|{a} - {b}| - {c}$",
            answer=answer,
            difficulty=(1750, 1850),
            topic="arithmetic/subtraction",
            solution=steps(
                f"First evaluate inside absolute value: ${a} - {b} = {a - b}$",
                f"Take absolute value: $|{a - b}| = {intermediate}$",
                f"Subtract: ${intermediate} - {c} = {answer}$"
            )
        )

emit(generate())