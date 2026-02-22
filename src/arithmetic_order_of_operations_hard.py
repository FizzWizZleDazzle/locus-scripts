"""
arithmetic - order_of_operations (hard)
Generated: 2026-02-22T03:45:16.883450
"""

from problem_utils import *

def generate():
    # For harder order of operations (1600-1900), we need:
    # - Multiple nested operations
    # - Mix of operations (powers, multiplication, division, addition, subtraction)
    # - Fractions or negative numbers
    # - 4-6 operations total
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Complex nested expression with powers and fractions
        # Work backwards from a clean answer
        ans = randint(1, 20)
        
        # Build: a - b * (c + d)^2 / e
        e = choice([2, 4, 5])
        inner_sum = randint(2, 5)
        c = randint(1, inner_sum - 1)
        d = inner_sum - c
        squared = inner_sum ** 2
        
        # Make b * squared / e give us something clean
        product = choice([i for i in range(2, 40) if i % e == 0])
        b = product // e
        quotient = product // e
        
        a = ans + b * squared // e
        
        expr_latex = f"{a} - {b} \\cdot ({c} + {d})^2 \\div {e}"
        
        sol = steps(
            f"First, evaluate the parentheses: ${c} + {d} = {inner_sum}$",
            f"Next, evaluate the exponent: ${inner_sum}^2 = {squared}$",
            f"Then multiply: ${b} \\cdot {squared} = {b * squared}$",
            f"Then divide: ${b * squared} \\div {e} = {quotient}$",
            f"Finally subtract: ${a} - {quotient} = {ans}$"
        )
        
        return problem(
            question=f"Evaluate: ${expr_latex}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="arithmetic/order_of_operations",
            solution=sol
        )
    
    elif problem_type == 2:
        # Type 2: Multiple nested parentheses with mixed operations
        # [(a + b) * c - d] / e + f
        ans = randint(5, 25)
        f_val = randint(1, 10)
        before_add = ans - f_val
        
        e = choice([2, 3, 4, 5])
        numerator = before_add * e
        
        d = randint(1, 10)
        before_subtract = numerator + d
        
        c = choice([2, 3, 4, 5])
        inner_sum = before_subtract // c if before_subtract % c == 0 else (before_subtract // c + 1)
        
        if before_subtract % c != 0:
            c = choice([i for i in [2, 3, 4, 5] if before_subtract % i == 0])
            inner_sum = before_subtract // c
        
        a = randint(1, inner_sum - 1)
        b = inner_sum - a
        
        expr_latex = f"\\frac{{({a} + {b}) \\cdot {c} - {d}}}{{{e}}} + {f_val}"
        
        sol = steps(
            f"Evaluate innermost parentheses: ${a} + {b} = {inner_sum}$",
            f"Multiply: ${inner_sum} \\cdot {c} = {before_subtract}$",
            f"Subtract: ${before_subtract} - {d} = {numerator}$",
            f"Divide: ${numerator} \\div {e} = {before_add}$",
            f"Add: ${before_add} + {f_val} = {ans}$"
        )
        
        return problem(
            question=f"Evaluate: ${expr_latex}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="arithmetic/order_of_operations",
            solution=sol
        )
    
    elif problem_type == 3:
        # Type 3: Expression with multiple exponents and operations
        # a^2 + b * c^2 - d^2
        ans = randint(10, 50)
        
        d = randint(2, 5)
        d_sq = d ** 2
        
        before_subtract = ans + d_sq
        
        c = randint(2, 4)
        c_sq = c ** 2
        
        b = choice([i for i in range(1, 6) if (before_subtract - i * c_sq) > 0])
        a_sq = before_subtract - b * c_sq
        
        # Find if a_sq is a perfect square
        a = int(a_sq ** 0.5)
        if a * a != a_sq:
            a = randint(2, 5)
            a_sq = a ** 2
            before_subtract = a_sq + b * c_sq
            ans = before_subtract - d_sq
        
        expr_latex = f"{a}^2 + {b} \\cdot {c}^2 - {d}^2"
        
        sol = steps(
            f"Evaluate all exponents first: ${a}^2 = {a_sq}$, ${c}^2 = {c_sq}$, ${d}^2 = {d_sq}$",
            f"Multiply: ${b} \\cdot {c_sq} = {b * c_sq}$",
            f"Add: ${a_sq} + {b * c_sq} = {before_subtract}$",
            f"Subtract: ${before_subtract} - {d_sq} = {ans}$"
        )
        
        return problem(
            question=f"Evaluate: ${expr_latex}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="arithmetic/order_of_operations",
            solution=sol
        )
    
    else:
        # Type 4: Complex fraction with operations in numerator and denominator
        # (a * b + c^2) / (d - e)
        ans = randint(5, 20)
        
        d = randint(10, 20)
        e = randint(1, d - 2)
        denominator = d - e
        
        numerator = ans * denominator
        
        c = randint(2, 5)
        c_sq = c ** 2
        
        product = numerator - c_sq
        if product <= 0:
            c = 2
            c_sq = 4
            product = numerator - c_sq
        
        b = choice([i for i in [2, 3, 4, 5] if product % i == 0])
        a = product // b
        
        expr_latex = f"\\frac{{{a} \\cdot {b} + {c}^2}}{{{d} - {e}}}"
        
        sol = steps(
            f"Evaluate the numerator: ${a} \\cdot {b} = {product}$",
            f"Evaluate the exponent: ${c}^2 = {c_sq}$",
            f"Complete numerator: ${product} + {c_sq} = {numerator}$",
            f"Evaluate the denominator: ${d} - {e} = {denominator}$",
            f"Divide: ${numerator} \\div {denominator} = {ans}$"
        )
        
        return problem(
            question=f"Evaluate: ${expr_latex}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="arithmetic/order_of_operations",
            solution=sol
        )

emit(generate())