"""
calculus - antiderivatives (easy)
Generated: 2026-02-22T05:11:14.532816
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple power rule: ∫x^n dx
        n = randint(1, 4)
        expr = x**n
        ans = x**(n+1) / (n+1) + c
        
        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1000, 1100),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use the power rule: $\\int x^n \\, dx = \\frac{{x^{{n+1}}}}{{n+1}} + C$",
                f"For $n = {n}$: $\\int {latex(expr)} \\, dx = \\frac{{x^{{{n+1}}}}}{{{n+1}}} + C$",
                f"${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Constant multiple: ∫k*x^n dx
        k = nonzero(-5, 5)
        n = randint(1, 3)
        expr = k * x**n
        ans = k * x**(n+1) / (n+1) + c
        
        return problem(
            question=f"\\int {latex(expr)} \\, dx",
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Factor out the constant: $\\int {latex(expr)} \\, dx = {k} \\int x^{{{n}}} \\, dx$",
                f"Apply power rule: ${k} \\cdot \\frac{{x^{{{n+1}}}}}{{{n+1}}} + C$",
                f"${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Simple polynomial: ∫(ax^2 + bx) dx
        a_val = nonzero(-4, 4)
        b_val = nonzero(-6, 6)
        expr = a_val * x**2 + b_val * x
        ans = a_val * x**3 / 3 + b_val * x**2 / 2 + c
        
        return problem(
            question=f"\\int \\left({latex(expr)}\\right) dx",
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate term by term: $\\int \\left({latex(expr)}\\right) dx$",
                f"$\\int {latex(a_val * x**2)} \\, dx + \\int {latex(b_val * x)} \\, dx$",
                f"${latex(a_val * x**3 / 3)} + {latex(b_val * x**2 / 2)} + C$",
                f"${latex(ans)}$"
            ),
        )
    
    else:
        # Constant term included: ∫(ax + b) dx
        a_val = nonzero(-5, 5)
        b_val = nonzero(-8, 8)
        expr = a_val * x + b_val
        ans = a_val * x**2 / 2 + b_val * x + c
        
        return problem(
            question=f"\\int \\left({latex(expr)}\\right) dx",
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate term by term: $\\int \\left({latex(expr)}\\right) dx$",
                f"$\\int {latex(a_val * x)} \\, dx + \\int {b_val} \\, dx$",
                f"${latex(a_val * x**2 / 2)} + {b_val}x + C$",
                f"${latex(ans)}$"
            ),
        )

emit(generate())