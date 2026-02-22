"""
arithmetic - mixed_numbers (hard)
Generated: 2026-02-22T03:42:19.259372
"""

from problem_utils import *

def generate():
    # For harder mixed number problems (1600-1900 ELO), we'll create problems involving:
    # - Complex operations with multiple mixed numbers
    # - Multi-step word problems
    # - Operations requiring multiple conversions
    # - Problems with larger numbers or multiple fractions
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Complex multiplication/division chain with mixed numbers
        whole1, num1, den1 = randint(2, 5), randint(1, 7), randint(2, 8)
        while num1 >= den1:
            num1, den1 = randint(1, 7), randint(2, 8)
        
        whole2, num2, den2 = randint(1, 4), randint(1, 5), randint(2, 6)
        while num2 >= den2:
            num2, den2 = randint(1, 5), randint(2, 6)
        
        whole3, num3, den3 = randint(1, 3), randint(1, 4), randint(2, 5)
        while num3 >= den3:
            num3, den3 = randint(1, 4), randint(2, 5)
        
        frac1 = Rational(whole1 * den1 + num1, den1)
        frac2 = Rational(whole2 * den2 + num2, den2)
        frac3 = Rational(whole3 * den3 + num3, den3)
        
        # Either multiply three or multiply two and divide by third
        if randint(0, 1) == 0:
            result = frac1 * frac2 * frac3
            operation = "multiplication"
            question = f"${whole1}\\frac{{{num1}}}{{{den1}}} \\times {whole2}\\frac{{{num2}}}{{{den2}}} \\times {whole3}\\frac{{{num3}}}{{{den3}}}$"
            step1 = f"Convert to improper fractions: $\\frac{{{frac1.p}}}{{{frac1.q}}} \\times \\frac{{{frac2.p}}}{{{frac2.q}}} \\times \\frac{{{frac3.p}}}{{{frac3.q}}}$"
            step2 = f"Multiply numerators and denominators: $\\frac{{{frac1.p * frac2.p * frac3.p}}}{{{frac1.q * frac2.q * frac3.q}}}$"
        else:
            result = (frac1 * frac2) / frac3
            operation = "mixed"
            question = f"${whole1}\\frac{{{num1}}}{{{den1}}} \\times {whole2}\\frac{{{num2}}}{{{den2}}} \\div {whole3}\\frac{{{num3}}}{{{den3}}}$"
            step1 = f"Convert to improper fractions: $\\frac{{{frac1.p}}}{{{frac1.q}}} \\times \\frac{{{frac2.p}}}{{{frac2.q}}} \\div \\frac{{{frac3.p}}}{{{frac3.q}}}$"
            step2 = f"Multiply by reciprocal: $\\frac{{{frac1.p}}}{{{frac1.q}}} \\times \\frac{{{frac2.p}}}{{{frac2.q}}} \\times \\frac{{{frac3.q}}}{{{frac3.p}}}$"
        
        if result.q == 1:
            answer_str = str(result.p)
            step3 = f"Simplify to get ${result.p}$"
        else:
            whole_part = result.p // result.q
            num_part = result.p % result.q
            if whole_part > 0:
                answer_str = f"{whole_part}\\frac{{{num_part}}}{{{result.q}}}"
                step3 = f"Simplify and convert to mixed number: ${answer_str}$"
            else:
                answer_str = f"\\frac{{{result.p}}}{{{result.q}}}"
                step3 = f"Simplify: ${answer_str}$"
        
        return problem(
            question=f"Calculate: {question}",
            answer=answer_str,
            difficulty=(1600, 1750),
            topic="arithmetic/mixed_numbers",
            solution=steps(step1, step2, step3)
        )
    
    elif problem_type == 2:
        # Word problem with multiple mixed number operations
        whole1, num1, den1 = randint(3, 8), randint(1, 3), randint(4, 4)
        whole2, num2, den2 = randint(2, 5), randint(1, 2), randint(3, 3)
        whole3, num3, den3 = randint(1, 3), randint(1, 1), randint(2, 2)
        
        frac1 = Rational(whole1 * den1 + num1, den1)
        frac2 = Rational(whole2 * den2 + num2, den2)
        frac3 = Rational(whole3 * den3 + num3, den3)
        
        result = frac1 - frac2 + frac3
        
        question = f"A carpenter has a board that is ${whole1}\\frac{{{num1}}}{{{den1}}}$ feet long. He cuts off ${whole2}\\frac{{{num2}}}{{{den2}}}$ feet, then adds a piece that is ${whole3}\\frac{{{num3}}}{{{den3}}}$ feet long. What is the total length of the board now?"
        
        step1 = f"Convert to improper fractions: $\\frac{{{frac1.p}}}{{{frac1.q}}} - \\frac{{{frac2.p}}}{{{frac2.q}}} + \\frac{{{frac3.p}}}{{{frac3.q}}}$"
        
        # Find common denominator
        from math import gcd
        lcm_denom = (frac1.q * frac2.q * frac3.q) // gcd(gcd(frac1.q, frac2.q), frac3.q)
        common_denom = frac1.q * frac2.q // gcd(frac1.q, frac2.q)
        common_denom = common_denom * frac3.q // gcd(common_denom, frac3.q)
        
        step2 = f"Find common denominator and compute: $\\frac{{{result.p}}}{{{result.q}}}$"
        
        if result.q == 1:
            answer_str = str(result.p)
            step3 = f"The board is ${result.p}$ feet long"
        else:
            whole_part = result.p // result.q
            num_part = result.p % result.q
            if whole_part > 0:
                answer_str = f"{whole_part}\\frac{{{num_part}}}{{{result.q}}}"
                step3 = f"Convert to mixed number: ${answer_str}$ feet"
            else:
                answer_str = f"\\frac{{{result.p}}}{{{result.q}}}"
                step3 = f"The board is ${answer_str}$ feet long"
        
        return problem(
            question=question,
            answer=answer_str,
            difficulty=(1650, 1800),
            topic="arithmetic/mixed_numbers",
            solution=steps(step1, step2, step3)
        )
    
    elif problem_type == 3:
        # Complex addition/subtraction with three mixed numbers requiring common denominator
        whole1, num1, den1 = randint(4, 9), randint(1, 4), randint(5, 5)
        whole2, num2, den2 = randint(3, 7), randint(2, 5), randint(6, 6)
        while num2 >= den2:
            num2 = randint(2, 5)
        whole3, num3, den3 = randint(2, 6), randint(1, 7), randint(8, 8)
        while num3 >= den3:
            num3 = randint(1, 7)
        
        frac1 = Rational(whole1 * den1 + num1, den1)
        frac2 = Rational(whole2 * den2 + num2, den2)
        frac3 = Rational(whole3 * den3 + num3, den3)
        
        # Randomly choose operations
        if randint(0, 1) == 0:
            result = frac1 + frac2 - frac3
            question = f"${whole1}\\frac{{{num1}}}{{{den1}}} + {whole2}\\frac{{{num2}}}{{{den2}}} - {whole3}\\frac{{{num3}}}{{{den3}}}$"
        else:
            result = frac1 - frac2 + frac3
            question = f"${whole1}\\frac{{{num1}}}{{{den1}}} - {whole2}\\frac{{{num2}}}{{{den2}}} + {whole3}\\frac{{{num3}}}{{{den3}}}$"
        
        step1 = f"Convert to improper fractions: $\\frac{{{frac1.p}}}{{{frac1.q}}}, \\frac{{{frac2.p}}}{{{frac2.q}}}, \\frac{{{frac3.p}}}{{{frac3.q}}}$"
        
        # Common denominator
        from math import gcd
        common_denom = frac1.q * frac2.q // gcd(frac1.q, frac2.q)
        common_denom = common_denom * frac3.q // gcd(common_denom, frac3.q)
        
        step2 = f"Find common denominator ({common_denom}) and compute"
        
        if result.q == 1:
            answer_str = str(result.p)
            step3 = f"Result: ${result.p}$"
        else:
            whole_part = result.p // result.q
            num_part = result.p % result.q
            if whole_part > 0:
                answer_str = f"{whole_part}\\frac{{{num_part}}}{{{result.q}}}"
                step3 = f"Simplify to mixed number: ${answer_str}$"
            else:
                answer_str = f"\\frac{{{result.p}}}{{{result.q}}}"
                step3 = f"Result: ${answer_str}$"
        
        return problem(
            question=f"Calculate: {question}",
            answer=answer_str,
            difficulty=(1600, 1750),
            topic="arithmetic/mixed_numbers",
            solution=steps(step1, step2, step3)
        )
    
    else:
        # Division problem with large mixed numbers
        whole1, num1, den1 = randint(5, 12), randint(1, 5), randint(6, 6)
        while num1 >= den1:
            num1 = randint(1, 5)
        whole2, num2, den2 = randint(2, 4), randint(1, 3), randint(4, 4)
        while num2 >= den2:
            num2 = randint(1, 3)
        
        frac1 = Rational(whole1 * den1 + num1, den1)
        frac2 = Rational(whole2 * den2 + num2, den2)
        
        result = frac1 / frac2
        
        question = f"${whole1}\\frac{{{num1}}}{{{den1}}} \\div {whole2}\\frac{{{num2}}}{{{den2}}}$"
        
        step1 = f"Convert to improper fractions: $\\frac{{{frac1.p}}}{{{frac1.q}}} \\div \\frac{{{frac2.p}}}{{{frac2.q}}}$"
        step2 = f"Multiply by reciprocal: $\\frac{{{frac1.p}}}{{{frac1.q}}} \\times \\frac{{{frac2.q}}}{{{frac2.p}}} = \\frac{{{frac1.p * frac2.q}}}{{{frac1.q * frac2.p}}}$"
        
        if result.q == 1:
            answer_str = str(result.p)
            step3 = f"Simplify: ${result.p}$"
        else:
            whole_part = result.p // result.q
            num_part = result.p % result.q
            if whole_part > 0:
                answer_str = f"{whole_part}\\frac{{{num_part}}}{{{result.q}}}"
                step3 = f"Simplify to mixed number: ${answer_str}$"
            else:
                answer_str = f"\\frac{{{result.p}}}{{{result.q}}}"
                step3 = f"Simplify: ${answer_str}$"
        
        return problem(
            question=f"Calculate: {question}",
            answer=answer_str,
            difficulty=(1700, 1850),
            topic="arithmetic/mixed_numbers",
            solution=steps(step1, step2, step3)
        )

emit(generate())