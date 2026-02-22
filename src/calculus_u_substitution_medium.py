"""
calculus - u_substitution (medium)
Generated: 2026-02-22T05:12:41.869760
"""

from problem_utils import *

def generate():
    # Choose a random type of u-substitution problem
    problem_type = choice(['polynomial_composed', 'trig_linear', 'exponential', 'rational_power'])
    
    if problem_type == 'polynomial_composed':
        # Integral of form: (ax + b)^n * a dx, where answer is (ax+b)^(n+1)/(a(n+1))
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        n = randint(2, 5)
        
        # The integrand
        integrand = a * (a*x + b)**n
        
        # u = ax + b, du = a dx
        # Integral becomes: u^n du = u^(n+1)/(n+1)
        ans = (a*x + b)**(n+1) / (n+1)
        
        difficulty_rating = 1300 if n <= 3 else 1400
        
        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=difficulty_rating,
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {latex(a)} \\, dx$",
                f"The integral becomes: $\\int u^{{{n}}} \\, du$",
                f"Integrating: $\\frac{{u^{{{n+1}}}}}{{{n+1}}} + C$",
                f"Substituting back: ${latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )
    
    elif problem_type == 'trig_linear':
        # Integral of form: sin(ax + b) * a or cos(ax + b) * a
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        trig_func = choice([sin, cos])
        
        integrand = a * trig_func(a*x + b)
        
        if trig_func == sin:
            ans = -cos(a*x + b)
            integral_result = "-\\cos(u)"
        else:
            ans = sin(a*x + b)
            integral_result = "\\sin(u)"
        
        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=1400,
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {latex(a)} \\, dx$",
                f"The integral becomes: $\\int {latex(trig_func(x))} \\, du$",
                f"Integrating: ${integral_result} + C$",
                f"Substituting back: ${latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )
    
    elif problem_type == 'exponential':
        # Integral of form: e^(ax + b) * a
        a = nonzero(-3, 3)
        b = nonzero(-5, 5)
        
        integrand = a * exp(a*x + b)
        ans = exp(a*x + b)
        
        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=1450,
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {latex(a)} \\, dx$",
                f"The integral becomes: $\\int e^u \\, du$",
                f"Integrating: $e^u + C$",
                f"Substituting back: ${latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )
    
    else:  # rational_power
        # Integral of form: a*(ax + b)^(-1) which gives ln|ax+b|
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        
        integrand = a / (a*x + b)
        ans = log(abs(a*x + b))
        
        return problem(
            question=f"\\int {latex(integrand)} \\, dx",
            answer=ans,
            difficulty=1500,
            topic="calculus/u_substitution",
            solution=steps(
                f"Let $u = {latex(a*x + b)}$",
                f"Then $du = {latex(a)} \\, dx$",
                f"The integral becomes: $\\int \\frac{{1}}{{u}} \\, du$",
                f"Integrating: $\\ln|u| + C$",
                f"Substituting back: ${latex(ans)} + C$"
            ),
            grading_mode="equivalent"
        )

emit(generate())