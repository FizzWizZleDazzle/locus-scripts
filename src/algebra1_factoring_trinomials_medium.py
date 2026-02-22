"""
algebra1 - factoring_trinomials (medium)
Generated: 2026-02-22T04:00:57.880004
"""

from problem_utils import *

def generate():
    # Pick difficulty level within the 1300-1600 standard range
    diff = randint(1300, 1600)
    
    if diff <= 1400:
        # Simpler trinomials: leading coefficient = 1
        # Form: x^2 + bx + c = (x - r1)(x - r2)
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        
        # Avoid r1 == r2 for variety
        while r1 == r2:
            r2 = nonzero(-8, 8)
        
        factored = (x - r1) * (x - r2)
        expr = expand(factored)
        ans = factor(expr)
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        return problem(
            question=f"Factor the trinomial: ${latex(expr)}$",
            answer=ans,
            difficulty=diff,
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"We need to factor ${latex(expr)}$",
                f"Find two numbers that multiply to ${c_coeff}$ and add to ${b_coeff}$",
                f"These numbers are ${-r1}$ and ${-r2}$",
                f"Therefore: ${latex(ans)}$"
            )
        )
    
    else:
        # More challenging: non-unit leading coefficient
        # Form: ax^2 + bx + c where a > 1
        a_val = randint(2, 5)
        r1 = nonzero(-6, 6)
        r2 = nonzero(-6, 6)
        
        # Avoid r1 == r2
        while r1 == r2:
            r2 = nonzero(-6, 6)
        
        # Create (ax - m)(x - n) form for cleaner factoring
        if randint(0, 1) == 0:
            # Form: a(x - r1)(x - r2)
            factored = a_val * (x - r1) * (x - r2)
            expr = expand(factored)
            ans = factor(expr)
            
            product = a_val * r1 * r2
            sum_val = -a_val * (r1 + r2)
            
            return problem(
                question=f"Factor the trinomial: ${latex(expr)}$",
                answer=ans,
                difficulty=diff,
                topic="algebra1/factoring_trinomials",
                grading_mode="factor",
                solution=steps(
                    f"We need to factor ${latex(expr)}$",
                    f"Notice the leading coefficient is ${a_val}$",
                    f"Factor out ${a_val}$: ${a_val}({latex(expand((x - r1)*(x - r2)))})$",
                    f"Factor the remaining trinomial to get: ${latex(ans)}$"
                )
            )
        else:
            # Form: (a1*x - m)(a2*x - n) where a1*a2 = a_val
            factors_of_a = [(i, a_val // i) for i in range(1, a_val + 1) if a_val % i == 0]
            a1, a2 = choice(factors_of_a)
            
            m = nonzero(-5, 5)
            n = nonzero(-5, 5)
            
            factored = (a1 * x - m) * (a2 * x - n)
            expr = expand(factored)
            ans = factor(expr)
            
            return problem(
                question=f"Factor the trinomial: ${latex(expr)}$",
                answer=ans,
                difficulty=diff,
                topic="algebra1/factoring_trinomials",
                grading_mode="factor",
                solution=steps(
                    f"We need to factor ${latex(expr)}$",
                    f"The leading coefficient is ${a_val}$, so we look for factors of the form $(a_1 x + b_1)(a_2 x + b_2)$",
                    f"Using the AC method or trial and error:",
                    f"${latex(ans)}$"
                )
            )

emit(generate())