"""
arithmetic - fractions (hard)
Generated: 2026-02-22T03:41:01.147777
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Complex fraction addition/subtraction with different denominators
        num1 = randint(2, 9)
        denom1 = randint(3, 12)
        num2 = randint(2, 9)
        denom2 = randint(3, 12)
        
        # Ensure denominators are different and coprime for interesting problems
        while denom2 == denom1 or gcd(denom1, denom2) > 2:
            denom2 = randint(3, 12)
        
        operation = choice(['+', '-'])
        
        frac1 = Rational(num1, denom1)
        frac2 = Rational(num2, denom2)
        
        if operation == '+':
            ans = frac1 + frac2
            op_sym = '+'
        else:
            ans = frac1 - frac2
            op_sym = '-'
        
        lcm_val = lcm(denom1, denom2)
        mult1 = lcm_val // denom1
        mult2 = lcm_val // denom2
        new_num1 = num1 * mult1
        new_num2 = num2 * mult2
        
        if operation == '+':
            result_num = new_num1 + new_num2
        else:
            result_num = new_num1 - new_num2
        
        return problem(
            question=f"Simplify: $\\frac{{{num1}}}{{{denom1}}} {op_sym} \\frac{{{num2}}}{{{denom2}}}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="arithmetic/fractions",
            solution=steps(
                f"Find LCD of {denom1} and {denom2}: LCD = {lcm_val}",
                f"$\\frac{{{num1}}}{{{denom1}}} \\cdot \\frac{{{mult1}}}{{{mult1}}} = \\frac{{{new_num1}}}{{{lcm_val}}}$",
                f"$\\frac{{{num2}}}{{{denom2}}} \\cdot \\frac{{{mult2}}}{{{mult2}}} = \\frac{{{new_num2}}}{{{lcm_val}}}$",
                f"$\\frac{{{new_num1}}}{{{lcm_val}}} {op_sym} \\frac{{{new_num2}}}{{{lcm_val}}} = \\frac{{{result_num}}}{{{lcm_val}}}$",
                f"Simplified: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Multiplication of three fractions
        num1, denom1 = randint(2, 8), randint(3, 9)
        num2, denom2 = randint(2, 8), randint(3, 9)
        num3, denom3 = randint(2, 8), randint(3, 9)
        
        frac1 = Rational(num1, denom1)
        frac2 = Rational(num2, denom2)
        frac3 = Rational(num3, denom3)
        
        ans = frac1 * frac2 * frac3
        
        return problem(
            question=f"Multiply and simplify: $\\frac{{{num1}}}{{{denom1}}} \\times \\frac{{{num2}}}{{{denom2}}} \\times \\frac{{{num3}}}{{{denom3}}}$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="arithmetic/fractions",
            solution=steps(
                f"Multiply numerators: ${num1} \\times {num2} \\times {num3} = {num1*num2*num3}$",
                f"Multiply denominators: ${denom1} \\times {denom2} \\times {denom3} = {denom1*denom2*denom3}$",
                f"Result: $\\frac{{{num1*num2*num3}}}{{{denom1*denom2*denom3}}}$",
                f"Simplified: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Complex fraction (fraction divided by fraction)
        num1, denom1 = randint(2, 9), randint(3, 10)
        num2, denom2 = randint(2, 9), randint(3, 10)
        
        frac1 = Rational(num1, denom1)
        frac2 = Rational(num2, denom2)
        
        ans = frac1 / frac2
        
        return problem(
            question=f"Simplify: $\\frac{{\\frac{{{num1}}}{{{denom1}}}}}{{\\frac{{{num2}}}{{{denom2}}}}}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="arithmetic/fractions",
            solution=steps(
                f"Multiply by reciprocal: $\\frac{{{num1}}}{{{denom1}}} \\times \\frac{{{denom2}}}{{{num2}}}$",
                f"Multiply: $\\frac{{{num1} \\times {denom2}}}{{{denom1} \\times {num2}}} = \\frac{{{num1*denom2}}}{{{denom1*num2}}}$",
                f"Simplified: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Mixed operations with fractions
        num1, denom1 = randint(1, 7), randint(2, 8)
        num2, denom2 = randint(1, 7), randint(2, 8)
        num3, denom3 = randint(1, 7), randint(2, 8)
        
        while denom2 == denom1:
            denom2 = randint(2, 8)
        
        frac1 = Rational(num1, denom1)
        frac2 = Rational(num2, denom2)
        frac3 = Rational(num3, denom3)
        
        # (a/b + c/d) * e/f
        ans = (frac1 + frac2) * frac3
        
        intermediate = frac1 + frac2
        
        return problem(
            question=f"Simplify: $\\left(\\frac{{{num1}}}{{{denom1}}} + \\frac{{{num2}}}{{{denom2}}}\\right) \\times \\frac{{{num3}}}{{{denom3}}}$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="arithmetic/fractions",
            solution=steps(
                f"First add the fractions in parentheses",
                f"LCD of {denom1} and {denom2} is {lcm(denom1, denom2)}",
                f"$\\frac{{{num1}}}{{{denom1}}} + \\frac{{{num2}}}{{{denom2}}} = {latex(intermediate)}$",
                f"Now multiply: ${latex(intermediate)} \\times \\frac{{{num3}}}{{{denom3}}}$",
                f"Result: ${latex(ans)}$"
            )
        )
    
    else:
        # Division of mixed fractions with addition
        num1, denom1 = randint(2, 8), randint(3, 9)
        num2, denom2 = randint(2, 8), randint(3, 9)
        num3, denom3 = randint(2, 8), randint(3, 9)
        
        frac1 = Rational(num1, denom1)
        frac2 = Rational(num2, denom2)
        frac3 = Rational(num3, denom3)
        
        # a/b ÷ c/d + e/f
        ans = (frac1 / frac2) + frac3
        
        intermediate = frac1 / frac2
        
        return problem(
            question=f"Simplify: $\\frac{{{num1}}}{{{denom1}}} \\div \\frac{{{num2}}}{{{denom2}}} + \\frac{{{num3}}}{{{denom3}}}$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="arithmetic/fractions",
            solution=steps(
                f"Division first (order of operations)",
                f"$\\frac{{{num1}}}{{{denom1}}} \\div \\frac{{{num2}}}{{{denom2}}} = \\frac{{{num1}}}{{{denom1}}} \\times \\frac{{{denom2}}}{{{num2}}} = {latex(intermediate)}$",
                f"Now add: ${latex(intermediate)} + \\frac{{{num3}}}{{{denom3}}}$",
                f"Result: ${latex(ans)}$"
            )
        )

emit(generate())