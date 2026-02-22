"""
algebra2 - exponential_equations (medium)
Generated: 2026-02-22T04:29:44.142583
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple exponential equation a^x = b (1300-1400)
        base = choice([2, 3, 4, 5])
        exponent_ans = randint(2, 4)
        rhs = base ** exponent_ans
        
        eq = Eq(base**x, rhs)
        ans = exponent_ans
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"We have ${latex(eq)}$",
                f"Rewrite ${rhs}$ as ${base}^{{{exponent_ans}}}$",
                f"So ${base}^x = {base}^{{{exponent_ans}}}$",
                f"Therefore $x = {exponent_ans}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Exponential with coefficient: a * b^x = c (1400-1500)
        base = choice([2, 3, 5])
        coeff = randint(2, 5)
        exponent_ans = randint(2, 4)
        rhs = coeff * (base ** exponent_ans)
        
        eq = Eq(coeff * base**x, rhs)
        ans = exponent_ans
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"We have ${latex(eq)}$",
                f"Divide both sides by ${coeff}$: ${base}^x = {rhs // coeff}$",
                f"Rewrite ${rhs // coeff}$ as ${base}^{{{exponent_ans}}}$",
                f"So ${base}^x = {base}^{{{exponent_ans}}}$",
                f"Therefore $x = {exponent_ans}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Exponential with linear exponent: a^(bx+c) = d (1500-1600)
        base = choice([2, 3, 4])
        b_coeff = randint(2, 3)
        c_val = nonzero(-3, 3)
        exponent_ans = randint(1, 3)
        power = b_coeff * exponent_ans + c_val
        rhs = base ** power
        
        eq = Eq(base**(b_coeff*x + c_val), rhs)
        ans = exponent_ans
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"We have ${latex(eq)}$",
                f"Rewrite ${rhs}$ as ${base}^{{{power}}}$",
                f"So ${base}^{{{latex(b_coeff*x + c_val)}}} = {base}^{{{power}}}$",
                f"Therefore ${latex(b_coeff*x + c_val)} = {power}$",
                f"${latex(b_coeff*x)} = {power - c_val}$",
                f"$x = {ans}$"
            )
        )
    
    else:
        # Type 4: Same base on both sides: a^(bx+c) = a^(dx+e) (1400-1500)
        base = choice([2, 3, 5])
        b_coeff = randint(2, 4)
        d_coeff = randint(1, b_coeff - 1)
        c_val = nonzero(-4, 4)
        exponent_ans = randint(1, 4)
        e_val = (b_coeff - d_coeff) * exponent_ans + c_val
        
        eq = Eq(base**(b_coeff*x + c_val), base**(d_coeff*x + e_val))
        ans = exponent_ans
        
        return problem(
            question=f"Solve for $x$: ${latex(eq)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"We have ${latex(eq)}$",
                f"Since the bases are equal, the exponents must be equal:",
                f"${latex(b_coeff*x + c_val)} = {latex(d_coeff*x + e_val)}$",
                f"${latex((b_coeff - d_coeff)*x)} = {e_val - c_val}$",
                f"$x = {ans}$"
            )
        )

emit(generate())