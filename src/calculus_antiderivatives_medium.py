"""
calculus - antiderivatives (medium)
Generated: 2026-02-22T05:11:34.344324
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Basic power rule antiderivative (1200-1400)
        n = randint(2, 5)
        coeff = nonzero(-5, 5)
        expr = coeff * x**n
        ans = integrate(expr, x)
        
        return problem(
            question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
            answer=ans,
            difficulty=(1200, 1400),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Apply the power rule for integration: $\\int x^n \\, dx = \\frac{{x^{{n+1}}}}{{n+1}} + C$",
                f"$\\int {latex(expr)} \\, dx = {latex(coeff)} \\cdot \\frac{{x^{{{n+1}}}}}{{{n+1}}} + C$",
                f"$= {latex(ans)} + C$"
            ),
        )
    
    elif problem_type == 2:
        # Polynomial antiderivative (1300-1500)
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        c = nonzero(-8, 8)
        expr = a*x**2 + b*x + c
        ans = integrate(expr, x)
        
        return problem(
            question=f"Find the antiderivative: $\\int \\left({latex(expr)}\\right) dx$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate term by term:",
                f"$\\int {latex(a*x**2)} \\, dx = {latex(integrate(a*x**2, x))}$",
                f"$\\int {latex(b*x)} \\, dx = {latex(integrate(b*x, x))}$",
                f"$\\int {latex(c)} \\, dx = {latex(c*x)}$",
                f"Combining: ${latex(ans)} + C$"
            ),
        )
    
    elif problem_type == 3:
        # Trig function antiderivative (1300-1500)
        trig_choice = randint(1, 3)
        coeff = nonzero(-3, 3)
        
        if trig_choice == 1:
            expr = coeff * sin(x)
            ans = integrate(expr, x)
            rule = "\\int \\sin(x) \\, dx = -\\cos(x) + C"
        elif trig_choice == 2:
            expr = coeff * cos(x)
            ans = integrate(expr, x)
            rule = "\\int \\cos(x) \\, dx = \\sin(x) + C"
        else:
            expr = coeff * sec(x)**2
            ans = integrate(expr, x)
            rule = "\\int \\sec^2(x) \\, dx = \\tan(x) + C"
        
        return problem(
            question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Use the trigonometric integration rule: ${rule}$",
                f"$\\int {latex(expr)} \\, dx = {latex(ans)} + C$"
            ),
        )
    
    elif problem_type == 4:
        # Exponential antiderivative (1400-1600)
        coeff = nonzero(-4, 4)
        exp_choice = choice([True, False])
        
        if exp_choice:
            expr = coeff * exp(x)
            ans = integrate(expr, x)
            return problem(
                question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
                answer=ans,
                difficulty=(1400, 1600),
                topic="calculus/antiderivatives",
                solution=steps(
                    f"Recall that $\\int e^x \\, dx = e^x + C$",
                    f"$\\int {latex(expr)} \\, dx = {latex(ans)} + C$"
                ),
            )
        else:
            base = choice([2, 3, 5])
            expr = base**x
            ans = integrate(expr, x)
            return problem(
                question=f"Find the antiderivative: $\\int {latex(expr)} \\, dx$",
                answer=ans,
                difficulty=(1400, 1600),
                topic="calculus/antiderivatives",
                solution=steps(
                    f"Use the formula $\\int a^x \\, dx = \\frac{{a^x}}{{\\ln(a)}} + C$",
                    f"$\\int {latex(expr)} \\, dx = {latex(ans)} + C$"
                ),
            )
    
    else:
        # Mixed polynomial with fractional/negative exponents (1400-1600)
        coeff1 = nonzero(-3, 3)
        coeff2 = nonzero(-5, 5)
        
        expr = coeff1 * x**(-1) + coeff2 * sqrt(x)
        ans_part1 = coeff1 * log(x)
        ans_part2 = integrate(coeff2 * sqrt(x), x)
        ans = ans_part1 + ans_part2
        
        return problem(
            question=f"Find the antiderivative: $\\int \\left({latex(coeff1/x)} + {latex(coeff2*sqrt(x))}\\right) dx$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="calculus/antiderivatives",
            solution=steps(
                f"Integrate term by term:",
                f"$\\int {latex(coeff1/x)} \\, dx = {latex(ans_part1)}$",
                f"$\\int {latex(coeff2*sqrt(x))} \\, dx = \\int {latex(coeff2)} x^{{1/2}} \\, dx = {latex(ans_part2)}$",
                f"Combining: ${latex(ans)} + C$"
            ),
        )

emit(generate())