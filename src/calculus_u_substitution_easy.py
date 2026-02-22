"""
calculus - u_substitution (easy)
Generated: 2026-02-22T05:12:24.203042
"""

from problem_utils import *

def generate():
    # For easier u-substitution problems (1000-1300 ELO), we want:
    # - Clear u substitution where u is a simple linear or polynomial expression
    # - The derivative du is explicitly present (or easily scaled)
    # - Result is a basic integral after substitution
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: ∫ (ax+b)^n dx where n ≠ -1
        # ELO ~1000-1150: Direct power rule after u-sub
        a_val = nonzero(-3, 3)
        b_val = randint(-5, 5)
        n_val = choice([2, 3, 4, 5])
        
        u_expr = a_val * x + b_val
        integrand = u_expr**n_val
        
        # After substitution: (1/a) ∫ u^n du = (1/a) * u^(n+1)/(n+1) + C
        ans = (u_expr**(n_val + 1)) / (a_val * (n_val + 1))
        
        question = f"\\int {latex(integrand)} \\, dx"
        
        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = {latex(a_val)} \\, dx$, so $dx = \\frac{{1}}{{{latex(a_val)}}} \\, du$",
            f"The integral becomes $\\frac{{1}}{{{latex(a_val)}}} \\int u^{{{n_val}}} \\, du$",
            f"$= \\frac{{1}}{{{latex(a_val)}}} \\cdot \\frac{{u^{{{n_val+1}}}}}{{{n_val+1}}} + C$",
            f"$= {latex(ans)} + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1150),
            topic="calculus/u_substitution",
            solution=sol
        )
    
    elif problem_type == 2:
        # Type 2: ∫ x(x^2 + c)^n dx
        # ELO ~1100-1250: Need to recognize x dx relates to d(x^2)
        c_val = nonzero(-5, 5)
        n_val = choice([2, 3, 4])
        
        u_expr = x**2 + c_val
        integrand = x * (u_expr)**n_val
        
        # u = x^2 + c, du = 2x dx, so x dx = (1/2) du
        # ∫ u^n * (1/2) du = (1/2) * u^(n+1)/(n+1) + C
        ans = (u_expr**(n_val + 1)) / (2 * (n_val + 1))
        
        question = f"\\int {latex(integrand)} \\, dx"
        
        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = 2x \\, dx$, so $x \\, dx = \\frac{{1}}{{2}} \\, du$",
            f"The integral becomes $\\frac{{1}}{{2}} \\int u^{{{n_val}}} \\, du$",
            f"$= \\frac{{1}}{{2}} \\cdot \\frac{{u^{{{n_val+1}}}}}{{{n_val+1}}} + C$",
            f"$= {latex(ans)} + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1250),
            topic="calculus/u_substitution",
            solution=sol
        )
    
    elif problem_type == 3:
        # Type 3: ∫ sin(ax) or cos(ax) dx
        # ELO ~1000-1200: Simplest trig u-substitution
        a_val = nonzero(-4, 4)
        trig_choice = choice(['sin', 'cos'])
        
        if trig_choice == 'sin':
            integrand = sin(a_val * x)
            # u = ax, du = a dx
            # ∫ sin(u) * (1/a) du = -(1/a)cos(u) + C
            ans = -cos(a_val * x) / a_val
        else:
            integrand = cos(a_val * x)
            ans = sin(a_val * x) / a_val
        
        question = f"\\int {latex(integrand)} \\, dx"
        
        sol = steps(
            f"Let $u = {latex(a_val * x)}$",
            f"Then $du = {latex(a_val)} \\, dx$, so $dx = \\frac{{1}}{{{latex(a_val)}}} \\, du$",
            f"The integral becomes $\\frac{{1}}{{{latex(a_val)}}} \\int {trig_choice}(u) \\, du$",
            f"$= {latex(ans)} + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1200),
            topic="calculus/u_substitution",
            solution=sol
        )
    
    else:
        # Type 4: ∫ e^(ax+b) dx
        # ELO ~1050-1250: Exponential u-substitution
        a_val = nonzero(-3, 3)
        b_val = randint(-5, 5)
        
        u_expr = a_val * x + b_val
        integrand = exp(u_expr)
        
        # u = ax+b, du = a dx
        # ∫ e^u * (1/a) du = (1/a)e^u + C
        ans = exp(u_expr) / a_val
        
        question = f"\\int {latex(integrand)} \\, dx"
        
        sol = steps(
            f"Let $u = {latex(u_expr)}$",
            f"Then $du = {latex(a_val)} \\, dx$, so $dx = \\frac{{1}}{{{latex(a_val)}}} \\, du$",
            f"The integral becomes $\\frac{{1}}{{{latex(a_val)}}} \\int e^u \\, du$",
            f"$= \\frac{{1}}{{{latex(a_val)}}} e^u + C$",
            f"$= {latex(ans)} + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1050, 1250),
            topic="calculus/u_substitution",
            solution=sol
        )

emit(generate())