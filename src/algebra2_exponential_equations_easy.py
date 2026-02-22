"""
algebra2 - exponential_equations (easy)
Generated: 2026-02-22T04:29:27.399474
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Simple exponential equation b^x = value (1000-1150)
        # b^x = b^answer, so x = answer
        base = choice([2, 3, 4, 5])
        answer_val = randint(2, 4)
        rhs = base ** answer_val
        
        return problem(
            question=f"Solve for $x$: ${base}^x = {rhs}$",
            answer=answer_val,
            difficulty=(1000, 1150),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Rewrite ${rhs}$ as a power of ${base}$: ${rhs} = {base}^{{{answer_val}}}$",
                f"So ${base}^x = {base}^{{{answer_val}}}$",
                f"Therefore $x = {answer_val}$"
            )
        )
    
    elif problem_type == 2:
        # Type 2: Simple exponential with coefficient: k*b^x = value (1100-1250)
        base = choice([2, 3, 5])
        coeff = choice([2, 3, 4, 5])
        answer_val = randint(1, 3)
        rhs = coeff * (base ** answer_val)
        
        return problem(
            question=f"Solve for $x$: ${coeff} \\cdot {base}^x = {rhs}$",
            answer=answer_val,
            difficulty=(1100, 1250),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Divide both sides by ${coeff}$: ${base}^x = \\frac{{{rhs}}}{{{coeff}}} = {base**answer_val}$",
                f"Rewrite ${base**answer_val}$ as ${base}^{{{answer_val}}}$",
                f"Therefore $x = {answer_val}$"
            )
        )
    
    elif problem_type == 3:
        # Type 3: Exponential with same base on both sides: b^(x+k) = b^m (1150-1300)
        base = choice([2, 3, 4, 5])
        k = nonzero(-3, 3)
        m = randint(2, 5)
        answer_val = m - k
        
        if k > 0:
            lhs_exp = f"x + {k}"
        elif k < 0:
            lhs_exp = f"x - {-k}"
        else:
            lhs_exp = "x"
            
        return problem(
            question=f"Solve for $x$: ${base}^{{{lhs_exp}}} = {base}^{{{m}}}$",
            answer=answer_val,
            difficulty=(1150, 1300),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Since the bases are equal, set the exponents equal:",
                f"${lhs_exp} = {m}$",
                f"$x = {m} - ({k}) = {answer_val}$" if k != 0 else f"$x = {m}$"
            )
        )
    
    else:
        # Type 4: Simple exponential equation with fractional base (1200-1300)
        base = choice([2, 3, 5])
        answer_val = randint(2, 4)
        rhs_num = 1
        rhs_denom = base ** answer_val
        
        return problem(
            question=f"Solve for $x$: ${base}^x = \\frac{{1}}{{{rhs_denom}}}$",
            answer=-answer_val,
            difficulty=(1200, 1300),
            topic="algebra2/exponential_equations",
            solution=steps(
                f"Rewrite $\\frac{{1}}{{{rhs_denom}}}$ as a power of ${base}$",
                f"$\\frac{{1}}{{{rhs_denom}}} = \\frac{{1}}{{{base}^{{{answer_val}}}}} = {base}^{{-{answer_val}}}$",
                f"So ${base}^x = {base}^{{-{answer_val}}}$",
                f"Therefore $x = -{answer_val}$"
            )
        )

emit(generate())