"""
arithmetic - multiplication (hard)
Generated: 2026-02-22T03:39:16.222083
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Multi-digit multiplication with strategic choice of numbers
        a = randint(23, 97)
        b = randint(23, 97)
        ans = a * b
        return problem(
            question=f"Calculate ${a} \\times {b}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Break down: ${a} \\times {b}$",
                f"Using standard multiplication algorithm",
                f"${a} \\times {b} = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Three-number multiplication
        a = randint(12, 35)
        b = randint(12, 35)
        c = randint(11, 25)
        ans = a * b * c
        return problem(
            question=f"Calculate ${a} \\times {b} \\times {c}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="arithmetic/multiplication",
            solution=steps(
                f"First multiply ${a} \\times {b} = {a*b}$",
                f"Then multiply ${a*b} \\times {c} = {ans}$"
            ),
        )
    
    elif problem_type == 3:
        # Multiplication with powers of numbers near 10
        base = choice([9, 11, 19, 21, 49, 51, 99, 101])
        multiplier = randint(7, 15)
        ans = base * multiplier
        return problem(
            question=f"Calculate ${base} \\times {multiplier}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Use mental math strategy for ${base} \\times {multiplier}$",
                f"${base} \\times {multiplier} = {ans}$"
            ),
        )
    
    elif problem_type == 4:
        # Product of consecutive integers
        start = randint(15, 28)
        length = randint(3, 4)
        factors = [start + i for i in range(length)]
        ans = 1
        for f in factors:
            ans *= f
        factors_str = " \\times ".join(map(str, factors))
        return problem(
            question=f"Calculate the product of {length} consecutive integers: ${factors_str}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Multiply consecutive integers: ${factors_str}$",
                " \\times ".join([f"${factors[i]} = {eval('*'.join(map(str, factors[:i+1])))}$" for i in range(len(factors))]),
                f"Final answer: ${ans}$"
            ),
        )
    
    else:
        # Squaring two-digit numbers
        base = randint(23, 87)
        ans = base * base
        return problem(
            question=f"Calculate ${base}^2$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="arithmetic/multiplication",
            solution=steps(
                f"Square ${base}$: ${base}^2 = {base} \\times {base}$",
                f"${base}^2 = {ans}$"
            ),
        )

emit(generate())