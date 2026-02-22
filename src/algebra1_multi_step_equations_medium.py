"""
algebra1 - multi_step_equations (medium)
Generated: 2026-02-22T03:49:11.716577
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Two-step equation with parentheses: a(x + b) = c
        a = nonzero(-5, 5)
        b = nonzero(-8, 8)
        x_val = nonzero(-6, 6)
        c = a * (x_val + b)
        
        lhs = expand(a * (x + b))
        ans = x_val
        
        return problem(
            question=f"Solve for $x$: ${latex(a)}({latex(x + b)}) = {c}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"Distribute: ${latex(lhs)} = {c}$",
                f"Subtract ${latex(a*b)}$ from both sides: ${latex(a*x)} = {c - a*b}$",
                f"Divide both sides by ${a}$: $x = {ans}$"
            )
        )
    
    elif problem_type == 2:
        # Equation with variables on both sides: ax + b = cx + d
        a = nonzero(-6, 6)
        c = nonzero(-6, 6)
        while a == c:
            c = nonzero(-6, 6)
        
        x_val = nonzero(-5, 5)
        b = c * x_val + nonzero(-8, 8) - a * x_val
        d = c * x_val
        
        ans = x_val
        
        return problem(
            question=f"Solve for $x$: ${latex(a*x + b)} = {latex(c*x + d)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"Subtract ${latex(c*x)}$ from both sides: ${latex((a-c)*x + b)} = {d}$",
                f"Subtract ${b}$ from both sides: ${latex((a-c)*x)} = {d - b}$",
                f"Divide both sides by ${a-c}$: $x = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Equation with distribution on both sides: a(x + b) + c = d(x + e) + f
        a = nonzero(-4, 4)
        d = nonzero(-4, 4)
        while a == d:
            d = nonzero(-4, 4)
        
        b = nonzero(-5, 5)
        e = nonzero(-5, 5)
        x_val = nonzero(-4, 4)
        
        c = nonzero(-6, 6)
        f = a * (x_val + b) + c - d * (x_val + e)
        
        ans = x_val
        
        lhs = expand(a * (x + b)) + c
        rhs = expand(d * (x + e)) + f
        
        return problem(
            question=f"Solve for $x$: ${latex(a)}({latex(x + b)}) + {c} = {latex(d)}({latex(x + e)}) + {f}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"Distribute on both sides: ${latex(lhs)} = {latex(rhs)}$",
                f"Simplify: ${latex(a*x + a*b + c)} = {latex(d*x + d*e + f)}$",
                f"Collect variables on one side: ${latex((a-d)*x)} = {d*e + f - a*b - c}$",
                f"Divide by ${a-d}$: $x = {ans}$"
            )
        )
    
    else:
        # Multi-step with fractions: (ax + b)/c = d
        c = choice([2, 3, 4, 5])
        a = nonzero(-6, 6)
        b = nonzero(-9, 9)
        x_val = nonzero(-4, 4)
        
        # Ensure numerator is divisible by c for clean problem
        numerator = a * x_val + b
        d = numerator // c
        if numerator % c != 0:
            b = c * nonzero(-3, 3) - a * x_val
            numerator = a * x_val + b
            d = numerator // c
        
        ans = x_val
        
        return problem(
            question=f"Solve for $x$: $\\frac{{{latex(a*x + b)}}}{{{c}}} = {d}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="algebra1/multi_step_equations",
            solution=steps(
                f"Multiply both sides by ${c}$: ${latex(a*x + b)} = {c * d}$",
                f"Subtract ${b}$ from both sides: ${latex(a*x)} = {c*d - b}$",
                f"Divide by ${a}$: $x = {ans}$"
            )
        )

emit(generate())