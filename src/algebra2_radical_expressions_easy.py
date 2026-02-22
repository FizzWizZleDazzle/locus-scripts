"""
algebra2 - radical_expressions (easy)
Generated: 2026-02-22T04:25:39.499579
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplify sqrt of perfect square
        # ELO 1000-1100
        base = randint(2, 12)
        value = base**2
        ans = base
        
        return problem(
            question=f"Simplify: $\\sqrt{{{value}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Recognize that ${value} = {base}^2$",
                f"Therefore $\\sqrt{{{value}}} = {base}$"
            )
        )
    
    elif problem_type == 2:
        # Simplify sqrt(a^2 * b) where b is small
        # ELO 1100-1200
        base = randint(2, 8)
        small_num = choice([2, 3, 5, 6, 7])
        value = base**2 * small_num
        ans = base * sqrt(small_num)
        
        return problem(
            question=f"Simplify: $\\sqrt{{{value}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Factor: ${value} = {base**2} \\cdot {small_num} = {base}^2 \\cdot {small_num}$",
                f"Extract perfect square: $\\sqrt{{{value}}} = \\sqrt{{{base}^2 \\cdot {small_num}}} = {base}\\sqrt{{{small_num}}}$"
            )
        )
    
    elif problem_type == 3:
        # Add or subtract like radicals
        # ELO 1200-1300
        coeff1 = randint(2, 8)
        coeff2 = randint(2, 8)
        radical_num = choice([2, 3, 5, 6, 7])
        operation = choice(['+', '-'])
        
        if operation == '+':
            result_coeff = coeff1 + coeff2
        else:
            result_coeff = coeff1 - coeff2
        
        ans = result_coeff * sqrt(radical_num)
        
        return problem(
            question=f"Simplify: ${coeff1}\\sqrt{{{radical_num}}} {operation} {coeff2}\\sqrt{{{radical_num}}}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Combine like radicals (both have $\\sqrt{{{radical_num}}}$)",
                f"${coeff1}\\sqrt{{{radical_num}}} {operation} {coeff2}\\sqrt{{{radical_num}}} = ({coeff1} {operation} {coeff2})\\sqrt{{{radical_num}}}$",
                f"$= {result_coeff}\\sqrt{{{radical_num}}}$"
            )
        )
    
    elif problem_type == 4:
        # Multiply sqrt(a) * sqrt(b)
        # ELO 1100-1200
        num1 = randint(2, 9)
        num2 = randint(2, 9)
        product = num1 * num2
        
        # Check if product is a perfect square
        sqrt_product = int(product**0.5)
        if sqrt_product**2 == product:
            ans = sqrt_product
        else:
            ans = sqrt(product)
        
        return problem(
            question=f"Simplify: $\\sqrt{{{num1}}} \\cdot \\sqrt{{{num2}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use the property $\\sqrt{{a}} \\cdot \\sqrt{{b}} = \\sqrt{{ab}}$",
                f"$\\sqrt{{{num1}}} \\cdot \\sqrt{{{num2}}} = \\sqrt{{{num1} \\cdot {num2}}} = \\sqrt{{{product}}}$",
                f"$= {latex(ans)}$"
            )
        )
    
    else:
        # Simplify coefficient * sqrt
        # ELO 1000-1100
        coeff = randint(2, 6)
        base = randint(2, 5)
        value = base**2
        ans = coeff * base
        
        return problem(
            question=f"Simplify: ${coeff}\\sqrt{{{value}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Simplify $\\sqrt{{{value}}} = \\sqrt{{{base}^2}} = {base}$",
                f"${coeff}\\sqrt{{{value}}} = {coeff} \\cdot {base} = {ans}$"
            )
        )

emit(generate())