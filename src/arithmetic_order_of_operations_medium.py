"""
arithmetic - order_of_operations (medium)
Generated: 2026-02-22T03:44:49.409998
"""

from problem_utils import *

def generate():
    # Choose problem type based on difficulty range
    problem_type = choice(['basic', 'with_exponents', 'with_fractions', 'nested'])
    
    if problem_type == 'basic':
        # 1300-1400: Basic order of operations with 3-4 operations
        a = randint(2, 9)
        b = randint(2, 9)
        c = randint(2, 9)
        d = randint(1, 9)
        
        # Create expression: a * b + c - d or a + b * c - d
        if choice([True, False]):
            expr_str = f"{a} \\times {b} + {c} - {d}"
            step1 = f"First multiply: ${a} \\times {b} = {a*b}$"
            step2 = f"Then add: ${a*b} + {c} = {a*b + c}$"
            step3 = f"Finally subtract: ${a*b + c} - {d} = {a*b + c - d}$"
            ans = a * b + c - d
        else:
            expr_str = f"{a} + {b} \\times {c} - {d}"
            step1 = f"First multiply: ${b} \\times {c} = {b*c}$"
            step2 = f"Then add: ${a} + {b*c} = {a + b*c}$"
            step3 = f"Finally subtract: ${a + b*c} - {d} = {a + b*c - d}$"
            ans = a + b * c - d
        
        return problem(
            question=f"Evaluate: ${expr_str}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="arithmetic/order_of_operations",
            solution=steps(step1, step2, step3)
        )
    
    elif problem_type == 'with_exponents':
        # 1400-1500: Order of operations with exponents
        a = randint(2, 5)
        b = randint(2, 3)
        c = randint(2, 6)
        d = randint(1, 10)
        
        # Create expression: a^b + c * d or c * d - a^b
        if choice([True, False]):
            expr_str = f"{a}^{b} + {c} \\times {d}"
            step1 = f"First evaluate exponent: ${a}^{b} = {a**b}$"
            step2 = f"Then multiply: ${c} \\times {d} = {c*d}$"
            step3 = f"Finally add: ${a**b} + {c*d} = {a**b + c*d}$"
            ans = a**b + c * d
        else:
            expr_str = f"{c} \\times {d} - {a}^{b}"
            step1 = f"First evaluate exponent: ${a}^{b} = {a**b}$"
            step2 = f"Then multiply: ${c} \\times {d} = {c*d}$"
            step3 = f"Finally subtract: ${c*d} - {a**b} = {c*d - a**b}$"
            ans = c * d - a**b
        
        return problem(
            question=f"Evaluate: ${expr_str}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="arithmetic/order_of_operations",
            solution=steps(step1, step2, step3)
        )
    
    elif problem_type == 'with_fractions':
        # 1450-1550: Order of operations with division
        a = randint(3, 8)
        b = randint(2, 4)
        c = randint(2, 5)
        d = randint(10, 30)
        # Make d divisible by c for clean answer
        d = c * randint(3, 8)
        
        expr_str = f"{d} \\div {c} + {a} \\times {b}"
        step1 = f"First divide: ${d} \\div {c} = {d//c}$"
        step2 = f"Then multiply: ${a} \\times {b} = {a*b}$"
        step3 = f"Finally add: ${d//c} + {a*b} = {d//c + a*b}$"
        ans = d // c + a * b
        
        return problem(
            question=f"Evaluate: ${expr_str}$",
            answer=ans,
            difficulty=(1450, 1550),
            topic="arithmetic/order_of_operations",
            solution=steps(step1, step2, step3)
        )
    
    else:  # nested
        # 1500-1600: Nested operations with parentheses
        a = randint(2, 6)
        b = randint(2, 5)
        c = randint(2, 4)
        d = randint(1, 8)
        e = randint(2, 5)
        
        # Create expression: (a + b) * c - d^e or a * (b + c) - d^e
        if choice([True, False]):
            expr_str = f"({a} + {b}) \\times {c} - {d}^{e}"
            step1 = f"First evaluate parentheses: ${a} + {b} = {a+b}$"
            step2 = f"Then evaluate exponent: ${d}^{e} = {d**e}$"
            step3 = f"Then multiply: ${a+b} \\times {c} = {(a+b)*c}$"
            step4 = f"Finally subtract: ${(a+b)*c} - {d**e} = {(a+b)*c - d**e}$"
            ans = (a + b) * c - d**e
        else:
            expr_str = f"{a} \\times ({b} + {c}) - {d}^{e}"
            step1 = f"First evaluate parentheses: ${b} + {c} = {b+c}$"
            step2 = f"Then evaluate exponent: ${d}^{e} = {d**e}$"
            step3 = f"Then multiply: ${a} \\times {b+c} = {a*(b+c)}$"
            step4 = f"Finally subtract: ${a*(b+c)} - {d**e} = {a*(b+c) - d**e}$"
            ans = a * (b + c) - d**e
        
        return problem(
            question=f"Evaluate: ${expr_str}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="arithmetic/order_of_operations",
            solution=steps(step1, step2, step3, step4)
        )

emit(generate())