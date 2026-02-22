"""
arithmetic - fractions (easy)
Generated: 2026-02-22T03:40:17.437521
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Simplify a fraction (1000-1100)
        numerator = randint(2, 12)
        common_factor = randint(2, 6)
        denominator = numerator * common_factor
        numerator = numerator * common_factor
        
        # Ensure we get a reducible fraction
        from math import gcd
        g = gcd(numerator, denominator)
        simplified_num = numerator // g
        simplified_den = denominator // g
        
        ans = Rational(simplified_num, simplified_den)
        
        return problem(
            question=f"Simplify the fraction: $\\frac{{{numerator}}}{{{denominator}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/fractions",
            solution=steps(
                f"Find the greatest common divisor of ${numerator}$ and ${denominator}$: GCD = ${g}$",
                f"Divide both numerator and denominator by ${g}$",
                f"$\\frac{{{numerator}}}{{{denominator}}} = \\frac{{{numerator} \\div {g}}}{{{denominator} \\div {g}}} = \\frac{{{simplified_num}}}{{{simplified_den}}}$"
            ),
        )
    
    elif problem_type == 2:
        # Add two fractions with same denominator (1000-1100)
        denominator = randint(3, 12)
        num1 = randint(1, denominator - 1)
        num2 = randint(1, denominator - 1)
        
        ans = Rational(num1 + num2, denominator)
        
        return problem(
            question=f"Add the fractions: $\\frac{{{num1}}}{{{denominator}}} + \\frac{{{num2}}}{{{denominator}}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="arithmetic/fractions",
            solution=steps(
                f"Since the denominators are the same, add the numerators",
                f"$\\frac{{{num1}}}{{{denominator}}} + \\frac{{{num2}}}{{{denominator}}} = \\frac{{{num1} + {num2}}}{{{denominator}}} = \\frac{{{num1 + num2}}}{{{denominator}}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Subtract two fractions with same denominator (1100-1200)
        denominator = randint(4, 12)
        num1 = randint(3, denominator)
        num2 = randint(1, num1 - 1)
        
        ans = Rational(num1 - num2, denominator)
        
        return problem(
            question=f"Subtract the fractions: $\\frac{{{num1}}}{{{denominator}}} - \\frac{{{num2}}}{{{denominator}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/fractions",
            solution=steps(
                f"Since the denominators are the same, subtract the numerators",
                f"$\\frac{{{num1}}}{{{denominator}}} - \\frac{{{num2}}}{{{denominator}}} = \\frac{{{num1} - {num2}}}{{{denominator}}} = \\frac{{{num1 - num2}}}{{{denominator}}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Multiply two simple fractions (1100-1200)
        num1 = randint(1, 6)
        den1 = randint(2, 8)
        num2 = randint(1, 6)
        den2 = randint(2, 8)
        
        ans = Rational(num1 * num2, den1 * den2)
        
        return problem(
            question=f"Multiply the fractions: $\\frac{{{num1}}}{{{den1}}} \\times \\frac{{{num2}}}{{{den2}}}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="arithmetic/fractions",
            solution=steps(
                f"Multiply numerators and denominators",
                f"$\\frac{{{num1}}}{{{den1}}} \\times \\frac{{{num2}}}{{{den2}}} = \\frac{{{num1} \\times {num2}}}{{{den1} \\times {den2}}} = \\frac{{{num1 * num2}}}{{{den1 * den2}}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 5:
        # Add fractions with different denominators (1200-1300)
        den1 = randint(2, 6)
        den2 = randint(2, 6)
        while den2 == den1:
            den2 = randint(2, 6)
        
        num1 = randint(1, den1)
        num2 = randint(1, den2)
        
        from math import gcd
        lcm = (den1 * den2) // gcd(den1, den2)
        
        ans = Rational(num1, den1) + Rational(num2, den2)
        
        return problem(
            question=f"Add the fractions: $\\frac{{{num1}}}{{{den1}}} + \\frac{{{num2}}}{{{den2}}}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/fractions",
            solution=steps(
                f"Find the least common denominator: LCD = ${lcm}$",
                f"Convert to equivalent fractions: $\\frac{{{num1 * (lcm // den1)}}}{{{lcm}}} + \\frac{{{num2 * (lcm // den2)}}}{{{lcm}}}$",
                f"Add: $\\frac{{{num1 * (lcm // den1) + num2 * (lcm // den2)}}}{{{lcm}}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )
    
    else:
        # Divide two simple fractions (1200-1300)
        num1 = randint(1, 6)
        den1 = randint(2, 8)
        num2 = randint(1, 6)
        den2 = randint(2, 8)
        
        ans = Rational(num1 * den2, den1 * num2)
        
        return problem(
            question=f"Divide the fractions: $\\frac{{{num1}}}{{{den1}}} \\div \\frac{{{num2}}}{{{den2}}}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="arithmetic/fractions",
            solution=steps(
                f"Multiply by the reciprocal of the second fraction",
                f"$\\frac{{{num1}}}{{{den1}}} \\times \\frac{{{den2}}}{{{num2}}} = \\frac{{{num1} \\times {den2}}}{{{den1} \\times {num2}}} = \\frac{{{num1 * den2}}}{{{den1 * num2}}}$",
                f"Simplified: ${latex(ans)}$"
            ),
        )

emit(generate())