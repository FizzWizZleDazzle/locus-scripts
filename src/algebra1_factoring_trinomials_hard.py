"""
algebra1 - factoring_trinomials (hard)
Generated: 2026-02-22T04:01:25.742080
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Trinomial with leading coefficient > 1 and larger coefficients
        # Example: 6x^2 + 19x + 10 = (2x + 5)(3x + 2)
        a1 = choice([2, 3, 4, 5, 6])
        a2 = choice([2, 3, 4, 5])
        if a1 == a2:
            a2 += 1
        
        b1 = nonzero(-8, 8)
        b2 = nonzero(-8, 8)
        
        # Construct factored form first
        factored = (a1*x + b1) * (a2*x + b2)
        expr = expand(factored)
        
        # Extract coefficients for solution steps
        A = a1 * a2
        B = a1*b2 + a2*b1
        C = b1 * b2
        
        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=factored,
            difficulty=(1600, 1750),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"We need to factor ${latex(expr)}$",
                f"Since the leading coefficient is ${A}$, look for factors $(ax + b)(cx + d)$",
                f"We need $ac = {A}$, $bd = {C}$, and $ad + bc = {B}$",
                f"Trying $a = {a1}$, $c = {a2}$, $b = {b1}$, $d = {b2}$:",
                f"Check: $({a1})({a2}) = {A}$, $({b1})({b2}) = {C}$, $({a1})({b2}) + ({a2})({b1}) = {a1*b2 + a2*b1} = {B}$ ✓",
                f"Answer: ${latex(factored)}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Factor by grouping (4 terms that come from trinomial with large leading coefficient)
        # Start with (ax + b)(cx + d) where grouping method is needed
        a1 = choice([3, 4, 5, 6, 7])
        a2 = choice([2, 3, 4, 5])
        b1 = nonzero(-7, 7)
        b2 = nonzero(-7, 7)
        
        factored = (a1*x + b1) * (a2*x + b2)
        expr = expand(factored)
        
        A = a1 * a2
        B = a1*b2 + a2*b1
        C = b1 * b2
        
        # Show grouping method
        m1 = a1 * b2
        m2 = a2 * b1
        
        return problem(
            question=f"Factor using the grouping method: ${latex(expr)}$",
            answer=factored,
            difficulty=(1650, 1800),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Factor ${latex(expr)}$ by splitting the middle term",
                f"Find two numbers that multiply to $({A})({C}) = {A*C}$ and add to ${B}$",
                f"Those numbers are ${m1}$ and ${m2}$",
                f"Rewrite: ${A}x^2 + {m1}x + {m2}x + {C}$",
                f"Group: $({A}x^2 + {m1}x) + ({m2}x + {C})$",
                f"Factor each group: ${a1}x({a2}x + {b2}) + {b1}({a2}x + {b2})$",
                f"Factor out common binomial: ${latex(factored)}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Perfect square trinomial with leading coefficient
        # (ax + b)^2 = a^2x^2 + 2abx + b^2
        a_val = choice([2, 3, 4, 5])
        b_val = nonzero(-6, 6)
        
        factored = (a_val*x + b_val)**2
        expr = expand(factored)
        
        A = a_val**2
        B = 2*a_val*b_val
        C = b_val**2
        
        return problem(
            question=f"Factor completely (recognize the pattern): ${latex(expr)}$",
            answer=factored,
            difficulty=(1600, 1750),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Check if ${latex(expr)}$ is a perfect square trinomial",
                f"First term: ${A}x^2 = ({a_val}x)^2$",
                f"Last term: ${C} = ({b_val})^2$",
                f"Middle term check: $2({a_val}x)({b_val}) = {B}x$ ✓",
                f"This is a perfect square: ${latex(factored)}$"
            )
        )
    
    elif problem_type == 4:
        # Type 4: Difference of squares with coefficients
        # a^2x^2 - b^2 = (ax - b)(ax + b)
        a_val = choice([2, 3, 4, 5, 6])
        b_val = choice([3, 4, 5, 6, 7, 9])
        
        factored = (a_val*x - b_val) * (a_val*x + b_val)
        expr = expand(factored)
        
        return problem(
            question=f"Factor using difference of squares: ${latex(expr)}$",
            answer=factored,
            difficulty=(1550, 1700),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"Recognize ${latex(expr)}$ as a difference of squares",
                f"${latex(expr)} = ({a_val}x)^2 - ({b_val})^2$",
                f"Apply $a^2 - b^2 = (a-b)(a+b)$",
                f"${latex(factored)}$"
            )
        )
    
    else:
        # Type 5: Trinomial requiring GCF extraction first, then factoring
        gcf = choice([2, 3, 4, 5])
        a1 = choice([1, 2, 3])
        a2 = choice([1, 2, 3])
        b1 = nonzero(-5, 5)
        b2 = nonzero(-5, 5)
        
        inner_factored = (a1*x + b1) * (a2*x + b2)
        inner_expanded = expand(inner_factored)
        expr = expand(gcf * inner_expanded)
        ans = gcf * inner_factored
        
        return problem(
            question=f"Factor completely: ${latex(expr)}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra1/factoring_trinomials",
            grading_mode="factor",
            solution=steps(
                f"First factor out the GCF from ${latex(expr)}$",
                f"GCF = ${gcf}$, so ${latex(expr)} = {gcf}({latex(inner_expanded)})$",
                f"Now factor the trinomial ${latex(inner_expanded)}$",
                f"${latex(inner_expanded)} = {latex(inner_factored)}$",
                f"Complete answer: ${latex(ans)}$"
            )
        )

emit(generate())