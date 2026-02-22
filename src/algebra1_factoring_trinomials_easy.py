"""
algebra1 - factoring_trinomials (easy)
Generated: 2026-02-22T04:00:42.070028
"""

from problem_utils import *

def generate():
    # For EASIER factoring trinomials (1000-1300 ELO), we want:
    # - Leading coefficient of 1 (x^2 + bx + c)
    # - Small integer roots
    # - Straightforward factoring
    
    problem_type = randint(1, 3)
    
    if problem_type == 1:
        # Easiest: both roots positive, small numbers
        # ELO ~1000-1100
        r1 = randint(1, 5)
        r2 = randint(1, 5)
        
        factored = (x + r1) * (x + r2)
        expr = expand(factored)
        ans = factor(expr)
        
        b_coeff = r1 + r2
        c_coeff = r1 * r2
        
        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"We need two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"The numbers are ${r1}$ and ${r2}$ because ${r1} \\cdot {r2} = {c_coeff}$ and ${r1} + {r2} = {b_coeff}$",
                f"Therefore: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Medium: one positive, one negative root
        # ELO ~1100-1200
        r1 = randint(1, 6)
        r2 = randint(1, 6)
        
        # Randomly decide which is positive/negative
        if randint(0, 1) == 0:
            factored = (x + r1) * (x - r2)
        else:
            factored = (x - r1) * (x + r2)
        
        expr = expand(factored)
        ans = factor(expr)
        
        # Extract coefficients for solution
        b_coeff = expr.as_coefficients_dict()[x]
        c_coeff = expr.as_coefficients_dict()[1]
        
        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"We need two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"Since the constant term is {'negative' if c_coeff < 0 else 'positive'}, the two numbers have {'opposite' if c_coeff < 0 else 'the same'} signs",
                f"Therefore: ${latex(ans)}$"
            )
        )
    
    else:
        # Slightly harder: both roots negative
        # ELO ~1200-1300
        r1 = randint(1, 5)
        r2 = randint(1, 5)
        
        factored = (x - r1) * (x - r2)
        expr = expand(factored)
        ans = factor(expr)
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"We need two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"Both numbers must be negative since their sum is negative but product is positive",
                f"The numbers are $-{r1}$ and $-{r2}$ because $(-{r1}) \\cdot (-{r2}) = {c_coeff}$ and $(-{r1}) + (-{r2}) = {b_coeff}$",
                f"Therefore: ${latex(ans)}$"
            )
        )

emit(generate())