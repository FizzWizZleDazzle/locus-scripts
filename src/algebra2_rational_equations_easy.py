"""
algebra2 - rational_equations (easy)
Generated: 2026-02-22T04:24:21.474848
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple rational equation with one fraction equal to a constant
        # Example: x/a = b, solve for x
        a_val = nonzero(-8, 8)
        b_val = nonzero(-8, 8)
        
        # Answer is x = a*b
        ans_val = a_val * b_val
        
        eq = Eq(x / a_val, b_val)
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans_val,
            difficulty=(1000, 1100),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Start with ${latex(eq)}$",
                f"Multiply both sides by ${a_val}$",
                f"$x = {b_val} \\cdot {a_val}$",
                f"$x = {ans_val}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Rational equation with x in numerator: (ax + b)/c = d
        a_val = nonzero(-5, 5)
        b_val = nonzero(-8, 8)
        c_val = nonzero(-6, 6)
        d_val = nonzero(-6, 6)
        
        # Solve: ax + b = c*d, so x = (c*d - b)/a
        numerator = c_val * d_val - b_val
        if numerator % a_val == 0:
            ans_val = numerator // a_val
        else:
            ans_val = Rational(numerator, a_val)
        
        eq = Eq((a_val*x + b_val) / c_val, d_val)
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans_val,
            difficulty=(1100, 1200),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Start with ${latex(eq)}$",
                f"Multiply both sides by ${c_val}$",
                f"${latex(a_val*x + b_val)} = {c_val * d_val}$",
                f"${latex(a_val*x)} = {c_val * d_val - b_val}$",
                f"$x = {latex(ans_val)}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Two fractions equal: a/x = b/c
        a_val = nonzero(-9, 9)
        b_val = nonzero(-9, 9)
        c_val = nonzero(-9, 9)
        
        # Cross multiply: a*c = b*x, so x = a*c/b
        numerator = a_val * c_val
        if numerator % b_val == 0:
            ans_val = numerator // b_val
        else:
            ans_val = Rational(numerator, b_val)
        
        eq = Eq(a_val / x, b_val / c_val)
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans_val,
            difficulty=(1200, 1300),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Start with ${latex(eq)}$",
                f"Cross multiply: ${a_val} \\cdot {c_val} = {b_val} \\cdot x$",
                f"${a_val * c_val} = {b_val}x$",
                f"$x = \\frac{{{a_val * c_val}}}{{{b_val}}}$",
                f"$x = {latex(ans_val)}$"
            )
        )
    
    else:
        # Type 4: Simple proportion with variable in denominator: a/(x+b) = c
        a_val = nonzero(-9, 9)
        b_val = nonzero(-8, 8)
        c_val = nonzero(-6, 6)
        
        # Solve: a = c(x+b), a = cx + cb, cx = a - cb, x = (a - cb)/c
        numerator = a_val - c_val * b_val
        if numerator % c_val == 0:
            ans_val = numerator // c_val
        else:
            ans_val = Rational(numerator, c_val)
        
        eq = Eq(a_val / (x + b_val), c_val)
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans_val,
            difficulty=(1200, 1300),
            topic="algebra2/rational_equations",
            solution=steps(
                f"Start with ${latex(eq)}$",
                f"Multiply both sides by $(x + {b_val})$",
                f"${a_val} = {c_val}(x + {b_val})$",
                f"${a_val} = {c_val}x + {c_val * b_val}$",
                f"${c_val}x = {a_val - c_val * b_val}$",
                f"$x = {latex(ans_val)}$"
            )
        )

emit(generate())