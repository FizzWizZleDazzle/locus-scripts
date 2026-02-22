"""
calculus - integration_by_parts (medium)
Generated: 2026-02-22T05:13:46.565867
"""

from problem_utils import *

def generate():
    # Pick a random type of integration by parts problem at the target difficulty
    problem_type = choice(['polynomial_exp', 'polynomial_trig', 'ln_polynomial', 'exp_trig'])
    
    if problem_type == 'polynomial_exp':
        # ∫ x^n * e^(ax) dx where n=1 or 2
        n = randint(1, 2)
        a = nonzero(-3, 3)
        
        if n == 1:
            # ∫ x * e^(ax) dx
            integrand = x * exp(a*x)
            # Answer: (1/a) * x * e^(ax) - (1/a^2) * e^(ax) + C
            ans = (x/a - 1/a**2) * exp(a*x)
            
            sol = steps(
                f"Let $u = x$ and $dv = e^{{{a}x}} dx$",
                f"Then $du = dx$ and $v = \\frac{{1}}{{{a}}}e^{{{a}x}}$",
                f"Using $\\int u\\,dv = uv - \\int v\\,du$:",
                f"$= \\frac{{x}}{{{a}}}e^{{{a}x}} - \\int \\frac{{1}}{{{a}}}e^{{{a}x}} dx$",
                f"$= \\frac{{x}}{{{a}}}e^{{{a}x}} - \\frac{{1}}{{{a**2}}}e^{{{a}x}} + C$",
                f"$= {latex(ans)} + C$"
            )
            diff_range = (1300, 1450)
        else:
            # ∫ x^2 * e^(ax) dx - requires two applications
            integrand = x**2 * exp(a*x)
            ans = (x**2/a - 2*x/a**2 + 2/a**3) * exp(a*x)
            
            sol = steps(
                f"Let $u = x^2$ and $dv = e^{{{a}x}} dx$",
                f"Then $du = 2x\\,dx$ and $v = \\frac{{1}}{{{a}}}e^{{{a}x}}$",
                f"$= \\frac{{x^2}}{{{a}}}e^{{{a}x}} - \\frac{{2}}{{{a}}}\\int x e^{{{a}x}} dx$",
                f"Apply integration by parts again to $\\int x e^{{{a}x}} dx$",
                f"$= \\frac{{x^2}}{{{a}}}e^{{{a}x}} - \\frac{{2}}{{{a}}}\\left(\\frac{{x}}{{{a}}}e^{{{a}x}} - \\frac{{1}}{{{a**2}}}e^{{{a}x}}\\right) + C$",
                f"$= {latex(ans)} + C$"
            )
            diff_range = (1500, 1600)
            
    elif problem_type == 'polynomial_trig':
        # ∫ x * sin(ax) dx or ∫ x * cos(ax) dx
        a = nonzero(-3, 3)
        trig_choice = choice(['sin', 'cos'])
        
        if trig_choice == 'sin':
            integrand = x * sin(a*x)
            # Answer: -x*cos(ax)/a + sin(ax)/a^2 + C
            ans = -x*cos(a*x)/a + sin(a*x)/a**2
            
            sol = steps(
                f"Let $u = x$ and $dv = \\sin({a}x) dx$",
                f"Then $du = dx$ and $v = -\\frac{{1}}{{{a}}}\\cos({a}x)$",
                f"$= -\\frac{{x}}{{{a}}}\\cos({a}x) + \\frac{{1}}{{{a}}}\\int \\cos({a}x) dx$",
                f"$= -\\frac{{x}}{{{a}}}\\cos({a}x) + \\frac{{1}}{{{a**2}}}\\sin({a}x) + C$",
                f"$= {latex(ans)} + C$"
            )
        else:
            integrand = x * cos(a*x)
            # Answer: x*sin(ax)/a + cos(ax)/a^2 + C
            ans = x*sin(a*x)/a + cos(a*x)/a**2
            
            sol = steps(
                f"Let $u = x$ and $dv = \\cos({a}x) dx$",
                f"Then $du = dx$ and $v = \\frac{{1}}{{{a}}}\\sin({a}x)$",
                f"$= \\frac{{x}}{{{a}}}\\sin({a}x) - \\frac{{1}}{{{a}}}\\int \\sin({a}x) dx$",
                f"$= \\frac{{x}}{{{a}}}\\sin({a}x) + \\frac{{1}}{{{a**2}}}\\cos({a}x) + C$",
                f"$= {latex(ans)} + C$"
            )
        diff_range = (1350, 1500)
        
    elif problem_type == 'ln_polynomial':
        # ∫ ln(x) dx or ∫ x*ln(x) dx
        n = choice([0, 1])
        
        if n == 0:
            # ∫ ln(x) dx
            integrand = log(x)
            ans = x*log(x) - x
            
            sol = steps(
                f"Let $u = \\ln(x)$ and $dv = dx$",
                f"Then $du = \\frac{{1}}{{x}} dx$ and $v = x$",
                f"$= x\\ln(x) - \\int x \\cdot \\frac{{1}}{{x}} dx$",
                f"$= x\\ln(x) - \\int 1\\,dx$",
                f"$= x\\ln(x) - x + C$"
            )
            diff_range = (1300, 1450)
        else:
            # ∫ x*ln(x) dx
            integrand = x * log(x)
            ans = x**2*log(x)/2 - x**2/4
            
            sol = steps(
                f"Let $u = \\ln(x)$ and $dv = x\\,dx$",
                f"Then $du = \\frac{{1}}{{x}} dx$ and $v = \\frac{{x^2}}{{2}}$",
                f"$= \\frac{{x^2}}{{2}}\\ln(x) - \\int \\frac{{x^2}}{{2}} \\cdot \\frac{{1}}{{x}} dx$",
                f"$= \\frac{{x^2}}{{2}}\\ln(x) - \\frac{{1}}{{2}}\\int x\\,dx$",
                f"$= \\frac{{x^2}}{{2}}\\ln(x) - \\frac{{x^2}}{{4}} + C$"
            )
            diff_range = (1400, 1550)
            
    else:  # exp_trig
        # ∫ e^x * sin(x) dx or ∫ e^x * cos(x) dx - requires solving for the integral
        trig_choice = choice(['sin', 'cos'])
        
        if trig_choice == 'sin':
            integrand = exp(x) * sin(x)
            ans = exp(x) * (sin(x) - cos(x)) / 2
            
            sol = steps(
                f"Let $u = \\sin(x)$ and $dv = e^x dx$",
                f"Then $du = \\cos(x) dx$ and $v = e^x$",
                f"$I = e^x\\sin(x) - \\int e^x\\cos(x) dx$",
                f"Apply integration by parts again: $u = \\cos(x)$, $dv = e^x dx$",
                f"$I = e^x\\sin(x) - \\left(e^x\\cos(x) + \\int e^x\\sin(x) dx\\right)$",
                f"$I = e^x\\sin(x) - e^x\\cos(x) - I$",
                f"$2I = e^x(\\sin(x) - \\cos(x))$",
                f"$I = {latex(ans)} + C$"
            )
        else:
            integrand = exp(x) * cos(x)
            ans = exp(x) * (sin(x) + cos(x)) / 2
            
            sol = steps(
                f"Let $u = \\cos(x)$ and $dv = e^x dx$",
                f"Then $du = -\\sin(x) dx$ and $v = e^x$",
                f"$I = e^x\\cos(x) + \\int e^x\\sin(x) dx$",
                f"Apply integration by parts again: $u = \\sin(x)$, $dv = e^x dx$",
                f"$I = e^x\\cos(x) + \\left(e^x\\sin(x) - \\int e^x\\cos(x) dx\\right)$",
                f"$I = e^x\\cos(x) + e^x\\sin(x) - I$",
                f"$2I = e^x(\\sin(x) + \\cos(x))$",
                f"$I = {latex(ans)} + C$"
            )
        diff_range = (1500, 1600)
    
    return problem(
        question=f"Evaluate $\\int {latex(integrand)} \\, dx$",
        answer=ans,
        difficulty=diff_range,
        topic="calculus/integration_by_parts",
        solution=sol,
        grading_mode="equivalent"
    )

emit(generate())