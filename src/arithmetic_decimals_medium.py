"""
arithmetic - decimals (medium)
Generated: 2026-02-22T03:42:47.349769
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Addition of decimals (1200-1400)
        a = round(uniform(1, 50) + uniform(0.1, 0.99), 2)
        b = round(uniform(1, 50) + uniform(0.1, 0.99), 2)
        ans = round(a + b, 2)
        
        return problem(
            question=f"${{{a}}} + {{{b}}} = ?$",
            answer=ans,
            difficulty=(1200, 1400),
            topic="arithmetic/decimals",
            solution=steps(
                f"Align the decimal points:",
                f"${{{a}}}$",
                f"$+ {{{b}}}$",
                f"$= {{{ans}}}$"
            )
        )
    
    elif problem_type == 2:
        # Subtraction of decimals (1200-1400)
        b = round(uniform(1, 30) + uniform(0.1, 0.99), 2)
        ans = round(uniform(1, 30) + uniform(0.1, 0.99), 2)
        a = round(b + ans, 2)
        
        return problem(
            question=f"${{{a}}} - {{{b}}} = ?$",
            answer=ans,
            difficulty=(1200, 1400),
            topic="arithmetic/decimals",
            solution=steps(
                f"Align the decimal points:",
                f"${{{a}}}$",
                f"$- {{{b}}}$",
                f"$= {{{ans}}}$"
            )
        )
    
    elif problem_type == 3:
        # Multiplication of decimals (1300-1500)
        a = round(uniform(0.1, 9.9), 1)
        b = round(uniform(0.1, 9.9), 1)
        ans = round(a * b, 2)
        
        decimal_places_a = len(str(a).split('.')[1]) if '.' in str(a) else 0
        decimal_places_b = len(str(b).split('.')[1]) if '.' in str(b) else 0
        total_decimals = decimal_places_a + decimal_places_b
        
        return problem(
            question=f"${{{a}}} \\times {{{b}}} = ?$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="arithmetic/decimals",
            solution=steps(
                f"Multiply as whole numbers: ${int(a * 10)} \\times {int(b * 10)} = {int(a * 10) * int(b * 10)}$",
                f"Count decimal places: {decimal_places_a} + {decimal_places_b} = {total_decimals}$",
                f"Place decimal point: ${{{ans}}}$"
            )
        )
    
    elif problem_type == 4:
        # Division of decimals (1400-1600)
        ans = round(uniform(0.1, 9.9), 1)
        b = round(uniform(0.1, 9.9), 1)
        a = round(ans * b, 2)
        ans = round(a / b, 2)
        
        return problem(
            question=f"${{{a}}} \\div {{{b}}} = ?$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="arithmetic/decimals",
            solution=steps(
                f"Rewrite as fraction: $\\frac{{{a}}}{{{b}}}$",
                f"Multiply numerator and denominator by 10 to eliminate decimals in divisor",
                f"$\\frac{{{a * 10}}}{{{b * 10}}} = \\frac{{{int(a * 10)}}}{{{int(b * 10)}}}$",
                f"Divide: ${{{ans}}}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Multi-step: addition and subtraction (1300-1500)
        a = round(uniform(5, 25) + uniform(0.1, 0.99), 2)
        b = round(uniform(1, 15) + uniform(0.1, 0.99), 2)
        c = round(uniform(1, 10) + uniform(0.1, 0.99), 2)
        ans = round(a + b - c, 2)
        
        return problem(
            question=f"${{{a}}} + {{{b}}} - {{{c}}} = ?$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="arithmetic/decimals",
            solution=steps(
                f"Work from left to right:",
                f"First: ${{{a}}} + {{{b}}} = {{{round(a + b, 2)}}}$",
                f"Then: ${{{round(a + b, 2)}}} - {{{c}}} = {{{ans}}}$"
            )
        )

emit(generate())