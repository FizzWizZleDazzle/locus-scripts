"""
algebra1 - exponent_rules (medium)
Generated: 2026-02-22T03:58:00.226289
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplify product of powers: x^a * x^b = x^(a+b)
        exp1 = randint(2, 6)
        exp2 = randint(2, 6)
        ans = x**(exp1 + exp2)
        
        return problem(
            question=f"Simplify: $x^{{{exp1}}} \\cdot x^{{{exp2}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Use the product rule: $x^a \\cdot x^b = x^{{a+b}}$",
                f"$x^{{{exp1}}} \\cdot x^{{{exp2}}} = x^{{{exp1}+{exp2}}}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Power of a power: (x^a)^b = x^(ab)
        exp1 = randint(2, 5)
        exp2 = randint(2, 4)
        ans = x**(exp1 * exp2)
        
        return problem(
            question=f"Simplify: $\\left(x^{{{exp1}}}\\right)^{{{exp2}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Use the power rule: $(x^a)^b = x^{{ab}}$",
                f"$\\left(x^{{{exp1}}}\\right)^{{{exp2}}} = x^{{{exp1} \\cdot {exp2}}}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Quotient rule: x^a / x^b = x^(a-b)
        exp1 = randint(5, 9)
        exp2 = randint(2, 4)
        ans = x**(exp1 - exp2)
        
        return problem(
            question=f"Simplify: $\\frac{{x^{{{exp1}}}}}{{x^{{{exp2}}}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Use the quotient rule: $\\frac{{x^a}}{{x^b}} = x^{{a-b}}$",
                f"$\\frac{{x^{{{exp1}}}}}{{x^{{{exp2}}}}} = x^{{{exp1}-{exp2}}}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Negative exponent: x^(-a) = 1/x^a
        exp1 = randint(2, 5)
        ans = 1/x**exp1
        
        return problem(
            question=f"Simplify: $x^{{-{exp1}}}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Use the negative exponent rule: $x^{{-a}} = \\frac{{1}}{{x^a}}$",
                f"$x^{{-{exp1}}} = \\frac{{1}}{{x^{{{exp1}}}}}$"
            )
        )
    
    else:
        # Combined rules: (x^a * x^b)^c
        exp1 = randint(2, 4)
        exp2 = randint(2, 4)
        exp3 = randint(2, 3)
        ans = x**((exp1 + exp2) * exp3)
        
        return problem(
            question=f"Simplify: $\\left(x^{{{exp1}}} \\cdot x^{{{exp2}}}\\right)^{{{exp3}}}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"First use product rule inside parentheses: $x^{{{exp1}}} \\cdot x^{{{exp2}}} = x^{{{exp1}+{exp2}}}$",
                f"$= \\left(x^{{{exp1+exp2}}}\\right)^{{{exp3}}}$",
                f"Now use power rule: $\\left(x^{{{exp1+exp2}}}\\right)^{{{exp3}}} = x^{{{exp1+exp2} \\cdot {exp3}}}$",
                f"$= {latex(ans)}$"
            )
        )

emit(generate())