"""
arithmetic - fractions (medium)
Generated: 2026-02-22T03:40:35.405380
"""

from problem_utils import *

def generate():
    problem_type = choice(['add', 'subtract', 'multiply', 'divide', 'mixed'])
    
    if problem_type == 'add':
        # Addition of two fractions
        denom1 = randint(2, 12)
        denom2 = randint(2, 12)
        numer1 = randint(1, denom1 - 1)
        numer2 = randint(1, denom2 - 1)
        
        frac1 = Rational(numer1, denom1)
        frac2 = Rational(numer2, denom2)
        ans = frac1 + frac2
        
        return problem(
            question=f"${latex(frac1)} + {latex(frac2)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="arithmetic/fractions",
            solution=steps(
                f"Find common denominator: LCM of ${denom1}$ and ${denom2}$ is ${denom1 * denom2 // gcd(denom1, denom2)}$",
                f"Convert fractions: ${latex(frac1)} = {latex(Rational(numer1 * (denom1 * denom2 // gcd(denom1, denom2)) // denom1, denom1 * denom2 // gcd(denom1, denom2)))}$ and ${latex(frac2)} = {latex(Rational(numer2 * (denom1 * denom2 // gcd(denom1, denom2)) // denom2, denom1 * denom2 // gcd(denom1, denom2)))}$",
                f"Add numerators: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'subtract':
        # Subtraction of two fractions
        denom1 = randint(2, 12)
        denom2 = randint(2, 12)
        numer1 = randint(2, denom1 * 2)
        numer2 = randint(1, denom2 - 1)
        
        frac1 = Rational(numer1, denom1)
        frac2 = Rational(numer2, denom2)
        ans = frac1 - frac2
        
        return problem(
            question=f"${latex(frac1)} - {latex(frac2)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="arithmetic/fractions",
            solution=steps(
                f"Find common denominator: LCM of ${denom1}$ and ${denom2}$ is ${denom1 * denom2 // gcd(denom1, denom2)}$",
                f"Convert and subtract: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'multiply':
        # Multiplication of two fractions
        denom1 = randint(2, 10)
        denom2 = randint(2, 10)
        numer1 = randint(1, 12)
        numer2 = randint(1, 12)
        
        frac1 = Rational(numer1, denom1)
        frac2 = Rational(numer2, denom2)
        ans = frac1 * frac2
        
        return problem(
            question=f"${latex(frac1)} \\times {latex(frac2)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="arithmetic/fractions",
            solution=steps(
                f"Multiply numerators and denominators: $\\frac{{{numer1} \\times {numer2}}}{{{denom1} \\times {denom2}}} = \\frac{{{numer1 * numer2}}}{{{denom1 * denom2}}}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 'divide':
        # Division of two fractions
        denom1 = randint(2, 10)
        denom2 = randint(2, 10)
        numer1 = randint(1, 12)
        numer2 = randint(1, 12)
        
        frac1 = Rational(numer1, denom1)
        frac2 = Rational(numer2, denom2)
        ans = frac1 / frac2
        
        return problem(
            question=f"${latex(frac1)} \\div {latex(frac2)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="arithmetic/fractions",
            solution=steps(
                f"Multiply by reciprocal: ${latex(frac1)} \\times {latex(Rational(denom2, numer2))}$",
                f"Multiply: $\\frac{{{numer1} \\times {denom2}}}{{{denom1} \\times {numer2}}} = \\frac{{{numer1 * denom2}}}{{{denom1 * numer2}}}$",
                f"Simplify: ${latex(ans)}$"
            )
        )
    
    else:  # mixed operations
        # Mixed operation: addition and multiplication
        denom1 = randint(2, 8)
        denom2 = randint(2, 8)
        denom3 = randint(2, 8)
        numer1 = randint(1, 10)
        numer2 = randint(1, 10)
        numer3 = randint(1, 10)
        
        frac1 = Rational(numer1, denom1)
        frac2 = Rational(numer2, denom2)
        frac3 = Rational(numer3, denom3)
        
        ans = frac1 * frac2 + frac3
        
        return problem(
            question=f"${latex(frac1)} \\times {latex(frac2)} + {latex(frac3)}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="arithmetic/fractions",
            solution=steps(
                f"Multiply first: ${latex(frac1)} \\times {latex(frac2)} = {latex(frac1 * frac2)}$",
                f"Add: ${latex(frac1 * frac2)} + {latex(frac3)}$",
                f"Simplify: ${latex(ans)}$"
            )
        )

emit(generate())