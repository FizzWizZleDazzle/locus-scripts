"""
calculus - integration_by_parts (easy)
Generated: 2026-02-22T05:13:17.268202
"""

from problem_utils import *

def generate():
    # For integration by parts at 1000-1300 ELO, we want the EASIEST possible problems
    # These should be straightforward applications where u and dv choices are obvious
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: ∫ x * e^x dx (classic simple example)
        # u = x, dv = e^x dx
        # du = dx, v = e^x
        # Result: x*e^x - e^x + C
        
        question = r"\int x e^{x} \, dx"
        ans = x*exp(x) - exp(x)
        
        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            r"Let $u = x$ and $dv = e^{x} \, dx$",
            r"Then $du = dx$ and $v = e^{x}$",
            r"$\int x e^{x} \, dx = x e^{x} - \int e^{x} \, dx$",
            r"$= x e^{x} - e^{x} + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/integration_by_parts",
            solution=solution
        )
    
    elif problem_type == 2:
        # Type 2: ∫ x * e^(ax) dx where a is a small integer
        a = choice([2, 3])
        
        question = rf"\int x e^{{{a}x}} \, dx"
        # u = x, dv = e^(ax) dx
        # du = dx, v = e^(ax)/a
        # Result: x*e^(ax)/a - e^(ax)/a^2 + C
        ans = x*exp(a*x)/a - exp(a*x)/(a**2)
        
        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            rf"Let $u = x$ and $dv = e^{{{a}x}} \, dx$",
            rf"Then $du = dx$ and $v = \frac{{1}}{{{a}}} e^{{{a}x}}$",
            rf"$\int x e^{{{a}x}} \, dx = \frac{{x}}{{{a}}} e^{{{a}x}} - \int \frac{{1}}{{{a}}} e^{{{a}x}} \, dx$",
            rf"$= \frac{{x}}{{{a}}} e^{{{a}x}} - \frac{{1}}{{{a**2}}} e^{{{a}x}} + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1200, 1300),
            topic="calculus/integration_by_parts",
            solution=solution
        )
    
    elif problem_type == 3:
        # Type 3: ∫ x * sin(x) dx
        question = r"\int x \sin(x) \, dx"
        # u = x, dv = sin(x) dx
        # du = dx, v = -cos(x)
        # Result: -x*cos(x) + sin(x) + C
        ans = -x*cos(x) + sin(x)
        
        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            r"Let $u = x$ and $dv = \sin(x) \, dx$",
            r"Then $du = dx$ and $v = -\cos(x)$",
            r"$\int x \sin(x) \, dx = -x \cos(x) - \int (-\cos(x)) \, dx$",
            r"$= -x \cos(x) + \sin(x) + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/integration_by_parts",
            solution=solution
        )
    
    else:
        # Type 4: ∫ x * cos(x) dx
        question = r"\int x \cos(x) \, dx"
        # u = x, dv = cos(x) dx
        # du = dx, v = sin(x)
        # Result: x*sin(x) + cos(x) + C
        ans = x*sin(x) + cos(x)
        
        solution = steps(
            r"Use integration by parts: $\int u \, dv = uv - \int v \, du$",
            r"Let $u = x$ and $dv = \cos(x) \, dx$",
            r"Then $du = dx$ and $v = \sin(x)$",
            r"$\int x \cos(x) \, dx = x \sin(x) - \int \sin(x) \, dx$",
            r"$= x \sin(x) + \cos(x) + C$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1200),
            topic="calculus/integration_by_parts",
            solution=solution
        )

emit(generate())