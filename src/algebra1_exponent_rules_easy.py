"""
algebra1 - exponent_rules (easy)
Generated: 2026-02-22T03:57:45.740326
"""

from problem_utils import *

def generate():
    problem_type = choice(['simplify_product', 'simplify_quotient', 'power_of_power', 'evaluate_small'])
    
    if problem_type == 'simplify_product':
        # x^a * x^b = x^(a+b)
        base_var = choice([x, y, a, b])
        exp1 = randint(2, 5)
        exp2 = randint(2, 5)
        
        expr = base_var**exp1 * base_var**exp2
        ans = base_var**(exp1 + exp2)
        
        return problem(
            question=f"Simplify: ${latex(expr)}$",
            answer=ans,
            difficulty=(1000, 1200),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Use the product rule: ${latex(base_var)}^{{{exp1}}} \\cdot {latex(base_var)}^{{{exp2}}} = {latex(base_var)}^{{{exp1}+{exp2}}}$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 'simplify_quotient':
        # x^a / x^b = x^(a-b) where a > b
        base_var = choice([x, y, a, b])
        exp1 = randint(4, 7)
        exp2 = randint(2, exp1-1)
        
        expr = base_var**exp1 / base_var**exp2
        ans = base_var**(exp1 - exp2)
        
        return problem(
            question=f"Simplify: $\\frac{{{latex(base_var**exp1)}}}{{{latex(base_var**exp2)}}}$",
            answer=ans,
            difficulty=(1100, 1250),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Use the quotient rule: $\\frac{{{latex(base_var)}^{{{exp1}}}}}{{{latex(base_var)}^{{{exp2}}}}} = {latex(base_var)}^{{{exp1}-{exp2}}}$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 'power_of_power':
        # (x^a)^b = x^(a*b)
        base_var = choice([x, y, a, b])
        exp1 = randint(2, 4)
        exp2 = randint(2, 3)
        
        expr = (base_var**exp1)**exp2
        ans = base_var**(exp1 * exp2)
        
        return problem(
            question=f"Simplify: ${latex(expr)}$",
            answer=ans,
            difficulty=(1050, 1200),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Use the power rule: $({latex(base_var)}^{{{exp1}}})^{{{exp2}}} = {latex(base_var)}^{{{exp1} \\cdot {exp2}}}$",
                f"${latex(ans)}$"
            )
        )
    
    else:  # evaluate_small
        # Evaluate a numeric expression with small exponents
        base = randint(2, 4)
        exp = randint(2, 3)
        
        ans = base**exp
        
        return problem(
            question=f"Evaluate: ${base}^{{{exp}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"${base}^{{{exp}}}$ means multiply ${base}$ by itself ${exp}$ times",
                f"${base}^{{{exp}}} = {ans}$"
            )
        )

emit(generate())