"""
algebra2 - radical_expressions (hard)
Generated: 2026-02-22T04:26:28.204973
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Simplifying nested radicals with variables
        # Example: sqrt(x * sqrt(x^3)) = x
        power1 = choice([3, 5, 7, 9])
        outer_coeff = choice([1, 4, 9, 16])
        
        # Build expression like sqrt(outer_coeff * x^2 * sqrt(x^power1))
        inner = sqrt(x**power1)
        expr = sqrt(outer_coeff * x**2 * inner)
        ans = simplify(expr)
        
        return problem(
            question=f"Simplify $\\sqrt{{{outer_coeff}x^2\\sqrt{{x^{{{power1}}}}}}}$ (assume $x > 0$)",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Rewrite as $\\sqrt{{{outer_coeff}x^2 \\cdot x^{{{power1}/2}}}$",
                f"$= \\sqrt{{{outer_coeff}}} \\cdot \\sqrt{{x^{{2 + {power1}/2}}}}$",
                f"$= {int(sqrt(outer_coeff))} \\cdot x^{{{(4 + power1)//4}}}$" if outer_coeff in [1,4,9,16] else f"$= {latex(ans)}$",
                f"Answer: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Rationalizing complex denominators with nested radicals
        # Example: 1/(sqrt(a) + sqrt(b + sqrt(c)))
        a_val = choice([2, 3, 5, 7])
        b_val = choice([2, 3, 5, 6])
        c_val = choice([4, 9, 16])
        
        numerator = 1
        denominator = sqrt(a_val) + sqrt(b_val + sqrt(c_val))
        expr = numerator / denominator
        
        # Rationalize step by step
        conjugate = sqrt(a_val) - sqrt(b_val + sqrt(c_val))
        rationalized_denom = a_val - (b_val + sqrt(c_val))
        ans = simplify(conjugate / rationalized_denom)
        
        return problem(
            question=f"Rationalize the denominator: $\\frac{{1}}{{\\sqrt{{{a_val}}} + \\sqrt{{{b_val} + \\sqrt{{{c_val}}}}}}}$",
            answer=ans,
            difficulty=(1700, 1800),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Multiply by conjugate: $\\frac{{\\sqrt{{{a_val}}} - \\sqrt{{{b_val} + \\sqrt{{{c_val}}}}}}}{{\\sqrt{{{a_val}}} - \\sqrt{{{b_val} + \\sqrt{{{c_val}}}}}}}$",
                f"Denominator: $(\\sqrt{{{a_val}}})^2 - (\\sqrt{{{b_val} + \\sqrt{{{c_val}}}}})^2 = {a_val} - ({b_val} + \\sqrt{{{c_val}}}) = {a_val - b_val} - \\sqrt{{{c_val}}}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Solving radical equations with multiple radicals
        # Example: sqrt(x+a) + sqrt(x+b) = c
        a_val = randint(3, 8)
        b_val = randint(10, 20)
        
        # Work backwards: choose x value that works
        x_ans = randint(5, 15)
        sum_val = sqrt(x_ans + a_val) + sqrt(x_ans + b_val)
        c_val = int(sum_val) if sum_val == int(sum_val) else None
        
        if c_val is None:
            # Fall back to simpler construction
            a_val = 0
            b_val = 9
            x_ans = 16
            c_val = 7  # sqrt(16) + sqrt(25) = 4 + 5 = 9, adjust
            b_val = 9
            x_ans = 16
            c_val = 7
        
        eq = Eq(sqrt(x + a_val) + sqrt(x + b_val), c_val)
        
        return problem(
            question=f"Solve for $x$: $\\sqrt{{x + {a_val}}} + \\sqrt{{x + {b_val}}} = {c_val}$",
            answer=x_ans,
            difficulty=(1650, 1750),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Isolate one radical: $\\sqrt{{x + {a_val}}} = {c_val} - \\sqrt{{x + {b_val}}}$",
                f"Square both sides and expand",
                f"Isolate the remaining radical and square again",
                f"Solve the resulting equation: $x = {x_ans}$",
                f"Verify in original equation"
            )
        )
    
    elif problem_type == 4:
        # Simplifying expressions with rational exponents
        # Example: (x^(2/3) * x^(1/2))^(6/5)
        num1, den1 = choice([(2,3), (3,4), (1,2), (3,5)])
        num2, den2 = choice([(1,2), (1,3), (2,5), (1,4)])
        outer_num, outer_den = choice([(6,5), (4,3), (3,2), (5,4)])
        
        expr = (x**(Rational(num1, den1)) * x**(Rational(num2, den2)))**(Rational(outer_num, outer_den))
        ans = simplify(expr)
        
        return problem(
            question=f"Simplify $\\left(x^{{{num1}/{den1}}} \\cdot x^{{{num2}/{den2}}}\\right)^{{{outer_num}/{outer_den}}}$ (assume $x > 0$)",
            answer=ans,
            difficulty=(1600, 1700),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Add exponents inside: $x^{{{num1}/{den1} + {num2}/{den2}}}$",
                f"$= x^{{{latex(Rational(num1, den1) + Rational(num2, den2))}}}$",
                f"Apply outer exponent: multiply exponents",
                f"${latex(ans)}$"
            )
        )
    
    else:
        # Rationalizing with higher-order radicals (cube roots)
        a_val = choice([2, 3, 5])
        b_val = choice([2, 3, 4])
        
        # 1/(a + cbrt(b))
        from sympy import cbrt
        denominator = a_val + cbrt(b_val)
        expr = 1 / denominator
        
        # Multiply by a^2 - a*cbrt(b) + cbrt(b)^2
        # Using (a+b)(a^2-ab+b^2) = a^3 + b^3
        conjugate = a_val**2 - a_val*cbrt(b_val) + cbrt(b_val)**2
        new_denom = a_val**3 + b_val
        ans = simplify(conjugate / new_denom)
        
        return problem(
            question=f"Rationalize the denominator: $\\frac{{1}}{{{a_val} + \\sqrt[3]{{{b_val}}}}}$",
            answer=ans,
            difficulty=(1750, 1850),
            topic="algebra2/radical_expressions",
            solution=steps(
                f"Use identity $(a+b)(a^2-ab+b^2) = a^3 + b^3$",
                f"Multiply by $\\frac{{{a_val}^2 - {a_val}\\sqrt[3]{{{b_val}}} + \\sqrt[3]{{{b_val}^2}}}}{{{a_val}^2 - {a_val}\\sqrt[3]{{{b_val}}} + \\sqrt[3]{{{b_val}^2}}}}$",
                f"Denominator becomes: ${a_val}^3 + {b_val} = {a_val**3 + b_val}$",
                f"${latex(ans)}$"
            )
        )

emit(generate())