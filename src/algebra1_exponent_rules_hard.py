"""
algebra1 - exponent_rules (hard)
Generated: 2026-02-22T03:58:26.371899
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplify expression with negative and fractional exponents
        base_exp = randint(2, 4)
        num_exp = randint(1, 3)
        denom_exp = base_exp + randint(1, 2)
        
        coeff_num = randint(2, 5)
        coeff_denom = randint(2, 5)
        
        # Create (coeff_num * x^num_exp) / (coeff_denom * x^denom_exp)
        # Answer should be simplified form
        
        final_coeff = Rational(coeff_num, coeff_denom)
        final_exp = num_exp - denom_exp
        
        if final_coeff == 1:
            ans = x**final_exp
        else:
            ans = final_coeff * x**final_exp
        
        return problem(
            question=f"Simplify: $\\frac{{{coeff_num}x^{{{num_exp}}}}}{{{coeff_denom}x^{{{denom_exp}}}}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Apply quotient rule: $\\frac{{{coeff_num}}}{{{coeff_denom}}} \\cdot \\frac{{x^{{{num_exp}}}}}{{x^{{{denom_exp}}}}}$",
                f"Simplify coefficient and subtract exponents: $\\frac{{{coeff_num}}}{{{coeff_denom}}} \\cdot x^{{{num_exp}-{denom_exp}}}$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Simplify (x^a * y^b)^c / (x^d * y^e) with negative exponents
        a = randint(2, 4)
        b = randint(2, 4)
        c = randint(2, 3)
        d = randint(1, 3)
        e = randint(1, 3)
        
        # Result: x^(ac-d) * y^(bc-e)
        x_exp = a*c - d
        y_exp = b*c - e
        
        ans = x**x_exp * y**y_exp
        
        return problem(
            question=f"Simplify: $\\frac{{(x^{{{a}}}y^{{{b}}})^{{{c}}}}}{{x^{{{d}}}y^{{{e}}}}}$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Apply power rule to numerator: $(x^{{{a}}}y^{{{b}}})^{{{c}}} = x^{{{a*c}}}y^{{{b*c}}}$",
                f"Apply quotient rule: $\\frac{{x^{{{a*c}}}y^{{{b*c}}}}}{{x^{{{d}}}y^{{{e}}}}} = x^{{{a*c}-{d}}}y^{{{b*c}-{e}}}$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Solve equation with exponents: a^(2x+b) = a^(cx+d)
        base = choice([2, 3, 5])
        b = randint(1, 4)
        d = randint(1, 4)
        c = randint(3, 5)
        
        # 2x + b = cx + d
        # 2x - cx = d - b
        # x(2-c) = d - b
        # x = (d-b)/(2-c)
        
        ans = Rational(d - b, 2 - c)
        
        return problem(
            question=f"Solve for $x$: ${base}^{{2x+{b}}} = {base}^{{{c}x+{d}}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Since the bases are equal, set the exponents equal: $2x + {b} = {c}x + {d}$",
                f"Solve for $x$: $2x - {c}x = {d} - {b}$",
                f"${2-c}x = {d-b}$",
                f"$x = {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Simplify expression with multiple operations and negative exponents
        a = randint(2, 4)
        b = randint(2, 4)
        c = randint(2, 3)
        
        # (x^a)^c * x^(-b)
        final_exp = a*c - b
        ans = x**final_exp
        
        return problem(
            question=f"Simplify: $(x^{{{a}}})^{{{c}}} \\cdot x^{{-{b}}}$",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Apply power rule: $(x^{{{a}}})^{{{c}}} = x^{{{a*c}}}$",
                f"Apply product rule: $x^{{{a*c}}} \\cdot x^{{-{b}}} = x^{{{a*c}+(-{b})}}$",
                f"${latex(ans)}$"
            )
        )
    
    else:
        # Complex: (x^a / x^b)^c * (x^d)^e with result having negative exponent
        a = randint(3, 5)
        b = randint(4, 6)
        c = randint(2, 3)
        d = randint(1, 2)
        e = randint(2, 3)
        
        # ((a-b)*c + d*e)
        final_exp = (a - b) * c + d * e
        ans = x**final_exp
        
        return problem(
            question=f"Simplify: $\\left(\\frac{{x^{{{a}}}}}{{x^{{{b}}}}}\\right)^{{{c}}} \\cdot (x^{{{d}}})^{{{e}}}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="algebra1/exponent_rules",
            solution=steps(
                f"Apply quotient rule inside parentheses: $\\left(x^{{{a}-{b}}}\\right)^{{{c}}} \\cdot (x^{{{d}}})^{{{e}}}$",
                f"Apply power rule to each term: $x^{{({a-b}) \\cdot {c}}} \\cdot x^{{{d} \\cdot {e}}}$",
                f"Simplify: $x^{{{(a-b)*c}}} \\cdot x^{{{d*e}}}$",
                f"Apply product rule: $x^{{{(a-b)*c}+{d*e}}}$",
                f"${latex(ans)}$"
            )
        )

emit(generate())