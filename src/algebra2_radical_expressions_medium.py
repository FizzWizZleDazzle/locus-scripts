"""
algebra2 - radical_expressions (medium)
Generated: 2026-02-22T04:25:57.017724
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplify sqrt(a^2 * b) where b is prime
        base = randint(2, 8)
        inner_factor = choice([2, 3, 5, 7, 11, 13])
        radicand = base**2 * inner_factor
        ans = base * sqrt(inner_factor)
        
        return problem(
            question=f"Simplify $\\sqrt{{{radicand}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Factor the radicand: $\\sqrt{{{radicand}}} = \\sqrt{{{base}^2 \\cdot {inner_factor}}}$",
                f"Separate into two radicals: $\\sqrt{{{base}^2}} \\cdot \\sqrt{{{inner_factor}}}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Add or subtract radicals: a*sqrt(n) + b*sqrt(n)
        n = choice([2, 3, 5, 6, 7, 10])
        a_coeff = nonzero(-8, 8)
        b_coeff = nonzero(-8, 8)
        ans = (a_coeff + b_coeff) * sqrt(n)
        
        sign = "+" if b_coeff > 0 else ""
        return problem(
            question=f"Simplify ${a_coeff}\\sqrt{{{n}}} {sign} {b_coeff}\\sqrt{{{n}}}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Combine like terms (both have $\\sqrt{{{n}}}$)",
                f"$({a_coeff} {sign} {b_coeff})\\sqrt{{{n}}}$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Multiply radicals: sqrt(a) * sqrt(b)
        a_val = randint(2, 12)
        b_val = randint(2, 12)
        product = a_val * b_val
        ans = simplify(sqrt(product))
        
        return problem(
            question=f"Simplify $\\sqrt{{{a_val}}} \\cdot \\sqrt{{{b_val}}}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use the property $\\sqrt{{a}} \\cdot \\sqrt{{b}} = \\sqrt{{ab}}$",
                f"$\\sqrt{{{a_val} \\cdot {b_val}}} = \\sqrt{{{product}}}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Rationalize denominator: a / sqrt(b)
        a_val = nonzero(-10, 10)
        b_val = choice([2, 3, 5, 6, 7, 10])
        ans = simplify(a_val * sqrt(b_val) / b_val)
        
        return problem(
            question=f"Rationalize the denominator: $\\frac{{{a_val}}}{{\\sqrt{{{b_val}}}}}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Multiply numerator and denominator by $\\sqrt{{{b_val}}}$",
                f"$\\frac{{{a_val} \\cdot \\sqrt{{{b_val}}}}}{{\\sqrt{{{b_val}}} \\cdot \\sqrt{{{b_val}}}}} = \\frac{{{a_val}\\sqrt{{{b_val}}}}}{{{b_val}}}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    else:
        # Simplify (sqrt(a) + sqrt(b))^2
        a_val = choice([2, 3, 5, 7])
        b_val = choice([2, 3, 5, 7])
        while b_val == a_val:
            b_val = choice([2, 3, 5, 7])
        
        ans = simplify((sqrt(a_val) + sqrt(b_val))**2)
        
        return problem(
            question=f"Expand and simplify $(\\sqrt{{{a_val}}} + \\sqrt{{{b_val}}})^2$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use $(a + b)^2 = a^2 + 2ab + b^2$",
                f"$(\\sqrt{{{a_val}}})^2 + 2\\sqrt{{{a_val}}}\\sqrt{{{b_val}}} + (\\sqrt{{{b_val}}})^2$",
                f"${a_val} + 2\\sqrt{{{a_val * b_val}}} + {b_val}$",
                f"${latex(ans)}$"
            )
        )

emit(generate())