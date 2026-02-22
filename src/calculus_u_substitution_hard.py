"""
calculus - u_substitution (hard)
Generated: 2026-02-22T05:13:01.416242
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Type 1: Trigonometric substitution with polynomial inside
        # Difficulty: 1600-1750
        power = choice([2, 3])
        coeff = randint(2, 5)
        inner_linear = choice([2*x, 3*x, x + 1, 2*x - 1])
        
        if power == 2:
            trig_func = choice([sin, cos])
            integrand = trig_func(inner_linear)**power * diff(inner_linear, x)
        else:
            trig_func = choice([sin, cos])
            integrand = trig_func(inner_linear)**power * diff(inner_linear, x)
        
        # Clean it up
        integrand = expand(integrand)
        ans = integrate(integrand, x)
        
        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(inner_linear)}$, then $du = {latex(diff(inner_linear, x))} dx$",
                f"The integral becomes $\\int {latex(trig_func(Symbol('u'))**power)} \\, du$",
                f"Integrate to get ${latex(integrate(trig_func(Symbol('u'))**power, Symbol('u')))}$",
                f"Substitute back: ${latex(ans)} + C$"
            ),
            calculator="none"
        )
    
    elif problem_type == 2:
        # Type 2: Exponential with linear substitution
        # Difficulty: 1650-1800
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        linear = a*x + b
        
        integrand = exp(linear) * a
        ans = integrate(integrand, x)
        
        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(linear)}$, then $du = {latex(a)} dx$",
                f"The integral becomes $\\int e^u \\, du$",
                f"Integrate to get $e^u + C$",
                f"Substitute back: ${latex(ans)} + C$"
            ),
            calculator="none"
        )
    
    elif problem_type == 3:
        # Type 3: Rational function requiring substitution
        # Difficulty: 1700-1850
        a = randint(2, 5)
        b = nonzero(-4, 4)
        inner = a*x + b
        
        integrand = a / inner
        ans = integrate(integrand, x)
        
        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(inner)}$, then $du = {latex(a)} dx$",
                f"The integral becomes $\\int \\frac{{1}}{{u}} \\, du$",
                f"Integrate to get $\\ln|u| + C$",
                f"Substitute back: ${latex(ans)} + C$"
            ),
            calculator="none"
        )
    
    elif problem_type == 4:
        # Type 4: Product requiring u-substitution with chain rule reversal
        # Difficulty: 1750-1900
        a = randint(2, 4)
        inner = x**2 + randint(1, 5)
        
        integrand = x * sin(inner)
        ans = integrate(integrand, x)
        
        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(inner)}$, then $du = {latex(diff(inner, x))} dx$",
                f"Notice that $x \\, dx = \\frac{{1}}{{2}} du$",
                f"The integral becomes $\\frac{{1}}{{2}} \\int \\sin(u) \\, du$",
                f"Integrate to get $-\\frac{{1}}{{2}} \\cos(u) + C$",
                f"Substitute back: ${latex(ans)} + C$"
            ),
            calculator="none"
        )
    
    else:
        # Type 5: Composite function with power and inner function
        # Difficulty: 1700-1850
        a = randint(2, 4)
        b = nonzero(-3, 3)
        power = randint(2, 4)
        inner = a*x + b
        
        integrand = inner**power * a
        ans = integrate(integrand, x)
        
        return problem(
            question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(inner)}$, then $du = {latex(a)} dx$",
                f"The integral becomes $\\int u^{{{power}}} \\, du$",
                f"Integrate to get $\\frac{{u^{{{power+1}}}}}{{{power+1}}} + C$",
                f"Substitute back: ${latex(ans)} + C$"
            ),
            calculator="none"
        )

emit(generate())