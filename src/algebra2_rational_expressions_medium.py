"""
algebra2 - rational_expressions (medium)
Generated: 2026-02-22T04:23:33.825812
"""

from problem_utils import *

def generate():
    problem_type = choice(['simplify', 'add_subtract', 'multiply', 'divide'])
    
    if problem_type == 'simplify':
        # Simplify a rational expression
        # Build from factored form to ensure clean simplification
        common_factor = choice([x + randint(1, 5), x - randint(1, 5)])
        numerator_other = choice([x + nonzero(-5, 5), x - nonzero(-5, 5), nonzero(-5, 5)])
        denominator_other = choice([x + nonzero(-5, 5), x - nonzero(-5, 5), nonzero(-5, 5)])
        
        # Ensure denominator_other is different from numerator_other for non-trivial problem
        while numerator_other == denominator_other:
            denominator_other = choice([x + nonzero(-5, 5), x - nonzero(-5, 5), nonzero(-5, 5)])
        
        numerator = expand(common_factor * numerator_other)
        denominator = expand(common_factor * denominator_other)
        
        expr = numerator / denominator
        ans = simplify(expr)
        
        return problem(
            question=f"Simplify: $\\frac{{{latex(numerator)}}}{{{latex(denominator)}}}$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Factor numerator: ${latex(numerator)} = {latex(factor(numerator))}$",
                f"Factor denominator: ${latex(denominator)} = {latex(factor(denominator))}$",
                f"Cancel common factor ${latex(common_factor)}$",
                f"Result: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 'add_subtract':
        # Add or subtract rational expressions with different denominators
        denom1 = x + randint(1, 5)
        denom2 = x + randint(1, 5)
        while denom2 == denom1:
            denom2 = x + randint(1, 5)
        
        num1 = nonzero(-5, 5)
        num2 = nonzero(-5, 5)
        
        operation = choice(['+', '-'])
        
        if operation == '+':
            expr = num1/denom1 + num2/denom2
            op_text = "+"
        else:
            expr = num1/denom1 - num2/denom2
            op_text = "-"
        
        ans = simplify(expr)
        
        lcd = expand(denom1 * denom2)
        
        return problem(
            question=f"Simplify: $\\frac{{{num1}}}{{{latex(denom1)}}} {op_text} \\frac{{{num2}}}{{{latex(denom2)}}}$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Find LCD: ${latex(lcd)}$",
                f"Rewrite with common denominator: $\\frac{{{num1} \\cdot {latex(denom2)}}}{{{latex(lcd)}}} {op_text} \\frac{{{num2} \\cdot {latex(denom1)}}}{{{latex(lcd)}}}$",
                f"Combine numerators: $\\frac{{{latex(expand(num1*denom2))} {op_text} {latex(expand(num2*denom1))}}}{{{latex(lcd)}}}$",
                f"Simplify: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 'multiply':
        # Multiply rational expressions
        num1 = x + nonzero(-5, 5)
        denom1 = x + nonzero(-5, 5)
        while denom1 == num1:
            denom1 = x + nonzero(-5, 5)
        
        num2 = x + nonzero(-5, 5)
        denom2 = x + nonzero(-5, 5)
        while denom2 == num2:
            denom2 = x + nonzero(-5, 5)
        
        expr = (num1/denom1) * (num2/denom2)
        ans = simplify(expr)
        
        return problem(
            question=f"Multiply and simplify: $\\frac{{{latex(num1)}}}{{{latex(denom1)}}} \\cdot \\frac{{{latex(num2)}}}{{{latex(denom2)}}}$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Multiply numerators and denominators: $\\frac{{({latex(num1)})({latex(num2)})}}{{({latex(denom1)})({latex(denom2)})}}$",
                f"Expand: $\\frac{{{latex(expand(num1*num2))}}}{{{latex(expand(denom1*denom2))}}}$",
                f"Simplify: ${latex(ans)}$"
            ),
        )
    
    else:  # divide
        # Divide rational expressions
        num1 = x + nonzero(-5, 5)
        denom1 = x + nonzero(-5, 5)
        while denom1 == num1:
            denom1 = x + nonzero(-5, 5)
        
        num2 = x + nonzero(-5, 5)
        denom2 = x + nonzero(-5, 5)
        while denom2 == num2:
            denom2 = x + nonzero(-5, 5)
        
        expr = (num1/denom1) / (num2/denom2)
        ans = simplify(expr)
        
        return problem(
            question=f"Divide and simplify: $\\frac{{{latex(num1)}}}{{{latex(denom1)}}} \\div \\frac{{{latex(num2)}}}{{{latex(denom2)}}}$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="algebra2/rational_expressions",
            solution=steps(
                f"Multiply by reciprocal: $\\frac{{{latex(num1)}}}{{{latex(denom1)}}} \\cdot \\frac{{{latex(denom2)}}}{{{latex(num2)}}}$",
                f"Multiply: $\\frac{{({latex(num1)})({latex(denom2)})}}{{({latex(denom1)})({latex(num2)})}}$",
                f"Expand: $\\frac{{{latex(expand(num1*denom2))}}}{{{latex(expand(denom1*num2))}}}$",
                f"Simplify: ${latex(ans)}$"
            ),
        )

emit(generate())