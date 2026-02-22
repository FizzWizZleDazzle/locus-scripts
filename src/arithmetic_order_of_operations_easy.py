"""
arithmetic - order_of_operations (easy)
Generated: 2026-02-22T03:44:29.200055
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple two-number operation (1000-1100)
        # e.g., "5 + 3 × 2"
        a = randint(2, 9)
        b = randint(2, 9)
        c = randint(2, 9)
        
        op_choice = randint(1, 2)
        if op_choice == 1:
            # Addition and multiplication
            ans = a + b * c
            question_str = f"{a} + {b} \\times {c}"
            solution_str = steps(
                f"Follow order of operations: multiply first",
                f"${b} \\times {c} = {b*c}$",
                f"${a} + {b*c} = {ans}$"
            )
        else:
            # Subtraction and multiplication
            ans = a - b * c
            question_str = f"{a} - {b} \\times {c}"
            solution_str = steps(
                f"Follow order of operations: multiply first",
                f"${b} \\times {c} = {b*c}$",
                f"${a} - {b*c} = {ans}$"
            )
        
        return problem(
            question=f"${question_str}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/order_of_operations",
            solution=solution_str
        )
    
    elif problem_type == 2:
        # Simple parentheses (1100-1200)
        # e.g., "(4 + 2) × 3"
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 9)
        
        op_choice = randint(1, 2)
        if op_choice == 1:
            # (a + b) × c
            ans = (a + b) * c
            question_str = f"({a} + {b}) \\times {c}"
            solution_str = steps(
                f"Evaluate parentheses first",
                f"${a} + {b} = {a+b}$",
                f"${a+b} \\times {c} = {ans}$"
            )
        else:
            # (a - b) × c
            ans = (a - b) * c
            question_str = f"({a} - {b}) \\times {c}"
            solution_str = steps(
                f"Evaluate parentheses first",
                f"${a} - {b} = {a-b}$",
                f"${a-b} \\times {c} = {ans}$"
            )
        
        return problem(
            question=f"${question_str}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/order_of_operations",
            solution=solution_str
        )
    
    elif problem_type == 3:
        # Division and multiplication (1100-1200)
        # e.g., "12 ÷ 3 × 2"
        # Choose dividend that divides evenly
        divisor = randint(2, 6)
        quotient = randint(2, 9)
        dividend = divisor * quotient
        multiplier = randint(2, 9)
        
        ans = quotient * multiplier
        question_str = f"{dividend} \\div {divisor} \\times {multiplier}"
        
        return problem(
            question=f"${question_str}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/order_of_operations",
            solution=steps(
                f"Evaluate left to right (division and multiplication have equal precedence)",
                f"${dividend} \\div {divisor} = {quotient}$",
                f"${quotient} \\times {multiplier} = {ans}$"
            )
        )
    
    else:
        # Three operations with parentheses (1200-1300)
        # e.g., "2 × (6 + 3) - 4"
        a = randint(2, 5)
        b = randint(3, 9)
        c = randint(2, 8)
        d = randint(2, 9)
        
        op_choice = randint(1, 2)
        if op_choice == 1:
            # a × (b + c) - d
            ans = a * (b + c) - d
            question_str = f"{a} \\times ({b} + {c}) - {d}"
            solution_str = steps(
                f"Evaluate parentheses first",
                f"${b} + {c} = {b+c}$",
                f"Multiply next: ${a} \\times {b+c} = {a*(b+c)}$",
                f"Subtract: ${a*(b+c)} - {d} = {ans}$"
            )
        else:
            # a × (b - c) + d
            ans = a * (b - c) + d
            question_str = f"{a} \\times ({b} - {c}) + {d}"
            solution_str = steps(
                f"Evaluate parentheses first",
                f"${b} - {c} = {b-c}$",
                f"Multiply next: ${a} \\times {b-c} = {a*(b-c)}$",
                f"Add: ${a*(b-c)} + {d} = {ans}$"
            )
        
        return problem(
            question=f"${question_str}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/order_of_operations",
            solution=solution_str
        )

emit(generate())