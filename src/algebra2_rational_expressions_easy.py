"""
algebra2 - rational_expressions (easy)
Generated: 2026-02-22T04:23:13.838829
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simplify a simple rational expression (single fraction)
        # ELO 1000-1100: Basic simplification with common factors
        factor1 = nonzero(-5, 5)
        factor2 = nonzero(-5, 5)
        common = nonzero(2, 4)
        
        numerator = common * factor1
        denominator = common * factor2
        
        expr = numerator * x / (denominator * x)
        ans = simplify(expr)
        
        return problem(
            question=f"Simplify: $\\frac{{{latex(numerator * x)}}}{{{latex(denominator * x)}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Factor out common factor from numerator and denominator",
                f"$\\frac{{{latex(numerator * x)}}}{{{latex(denominator * x)}}} = \\frac{{{common} \\cdot {factor1} \\cdot x}}{{{common} \\cdot {factor2} \\cdot x}}$",
                f"Cancel common factors of ${common}$ and $x$",
                f"${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Add/subtract rational expressions with same denominator
        # ELO 1100-1200: Same denominator, combine numerators
        denom = nonzero(2, 6)
        num1_coeff = nonzero(-5, 5)
        num2_coeff = nonzero(-5, 5)
        
        expr1 = num1_coeff * x / denom
        expr2 = num2_coeff * x / denom
        
        operation = choice(['+', '-'])
        if operation == '+':
            expr = expr1 + expr2
            ans = simplify(expr)
            op_symbol = "+"
        else:
            expr = expr1 - expr2
            ans = simplify(expr)
            op_symbol = "-"
        
        return problem(
            question=f"Simplify: $\\frac{{{latex(num1_coeff * x)}}}{{{denom}}} {op_symbol} \\frac{{{latex(num2_coeff * x)}}}{{{denom}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Since denominators are the same, combine numerators",
                f"$\\frac{{{latex(num1_coeff * x)} {op_symbol} {latex(num2_coeff * x)}}}{{{denom}}}$",
                f"Simplify the numerator: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Multiply two simple rational expressions
        # ELO 1200-1300: Multiply and simplify
        num1 = nonzero(2, 5)
        denom1 = nonzero(2, 5)
        num2 = nonzero(2, 5)
        denom2 = nonzero(2, 5)
        
        expr = (num1 * x / denom1) * (num2 / (denom2 * x))
        ans = simplify(expr)
        
        return problem(
            question=f"Multiply and simplify: $\\frac{{{latex(num1 * x)}}}{{{denom1}}} \\cdot \\frac{{{num2}}}{{{latex(denom2 * x)}}}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Multiply numerators and denominators",
                f"$\\frac{{{latex(num1 * x)} \\cdot {num2}}}{{{denom1} \\cdot {latex(denom2 * x)}}}$",
                f"$\\frac{{{latex(num1 * num2 * x)}}}{{{latex(denom1 * denom2 * x)}}}$",
                f"Cancel common factor $x$",
                f"${latex(ans)}$"
            ),
        )
    
    else:
        # Type 4: Divide two simple rational expressions
        # ELO 1200-1300: Divide (multiply by reciprocal)
        num1 = nonzero(2, 6)
        denom1 = nonzero(2, 6)
        num2 = nonzero(2, 6)
        denom2 = nonzero(2, 6)
        
        expr = (num1 * x / denom1) / (num2 * x / denom2)
        ans = simplify(expr)
        
        return problem(
            question=f"Divide and simplify: $\\frac{{{latex(num1 * x)}}}{{{denom1}}} \\div \\frac{{{latex(num2 * x)}}}{{{denom2}}}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Multiply by the reciprocal",
                f"$\\frac{{{latex(num1 * x)}}}{{{denom1}}} \\cdot \\frac{{{denom2}}}{{{latex(num2 * x)}}}$",
                f"$\\frac{{{latex(num1 * x)} \\cdot {denom2}}}{{{denom1} \\cdot {latex(num2 * x)}}}$",
                f"Cancel common factor $x$",
                f"${latex(ans)}$"
            ),
        )

emit(generate())