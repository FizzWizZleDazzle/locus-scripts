"""
calculus - area_between_curves (easy)
Generated: 2026-02-22T05:15:47.519777
"""

from problem_utils import *

def generate():
    # For EASIER area between curves problems (1000-1300), we want:
    # - Simple polynomial functions
    # - Easy intersection points (often given or obvious like 0, 1, 2)
    # - Clean integrals that result in simple fractions or integers
    
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Horizontal line above a simple parabola on [0, a]
        # ELO ~1000-1150
        a_val = randint(1, 3)
        k = randint(1, 4)
        
        # Area = k*a - (a^3/3) = a(k - a^2/3) = a(3k - a^2)/3
        area_val = Rational(a_val * (3*k - a_val**2), 3)
        
        question = f"Find the area between $y = {k}$ and $y = x^2$ from $x = 0$ to $x = {a_val}$."
        
        solution = steps(
            f"The area is $\\int_0^{{{a_val}}} \\left({k} - x^2\\right) dx$",
            f"$= \\left[{k}x - \\frac{{x^3}}{{3}}\\right]_0^{{{a_val}}}$",
            f"$= {k}({a_val}) - \\frac{{{a_val}^3}}{{3}}$",
            f"$= {k*a_val} - \\frac{{{a_val**3}}}{{3}} = {latex(area_val)}$"
        )
        
        return problem(
            question=question,
            answer=area_val,
            difficulty=(1000, 1150),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Two lines intersecting, find area between them
        # ELO ~1100-1250
        x1 = randint(0, 2)
        x2 = x1 + randint(2, 4)
        
        # Line 1: y = m1*x + b1 (upper)
        # Line 2: y = m2*x + b2 (lower)
        # Keep it simple: horizontal line and slanted line
        
        h = randint(2, 5)  # height of horizontal line
        m = randint(1, 2)  # slope of lower line
        
        # Upper: y = h
        # Lower: y = m*x
        # Intersect when h = m*x, so x = h/m
        # Use interval [0, h/m] for clean answer
        
        if h % m == 0:
            x2 = h // m
            area_val = Rational(h * x2, 2)
            
            question = f"Find the area between $y = {h}$ and $y = {m}x$ from $x = 0$ to $x = {x2}$."
            
            solution = steps(
                f"The area is $\\int_0^{{{x2}}} \\left({h} - {m}x\\right) dx$",
                f"$= \\left[{h}x - \\frac{{{m}x^2}}{{2}}\\right]_0^{{{x2}}}$",
                f"$= {h}({x2}) - \\frac{{{m}({x2})^2}}{{2}}$",
                f"$= {h*x2} - {m*x2**2//2} = {latex(area_val)}$"
            )
            
            return problem(
                question=question,
                answer=area_val,
                difficulty=(1100, 1250),
                topic="calculus/area_between_curves",
                solution=solution,
                calculator="scientific"
            )
    
    elif problem_type == 3:
        # Type 3: Parabola above x-axis on symmetric interval
        # ELO ~1150-1300
        a_val = randint(1, 3)
        c = randint(1, 4)
        
        # y = c - x^2 from -a to a
        # Area = 2*int_0^a (c - x^2) dx = 2(c*a - a^3/3) = 2a(3c - a^2)/3
        
        area_val = Rational(2*a_val*(3*c - a_val**2), 3)
        
        question = f"Find the area between $y = {c} - x^2$ and the $x$-axis from $x = -{a_val}$ to $x = {a_val}$."
        
        solution = steps(
            f"The area is $\\int_{{{-a_val}}}^{{{a_val}}} ({c} - x^2) dx$",
            f"By symmetry: $= 2\\int_0^{{{a_val}}} ({c} - x^2) dx$",
            f"$= 2\\left[{c}x - \\frac{{x^3}}{{3}}\\right]_0^{{{a_val}}}$",
            f"$= 2\\left({c*a_val} - \\frac{{{a_val**3}}}{{3}}\\right) = {latex(area_val)}$"
        )
        
        return problem(
            question=question,
            answer=area_val,
            difficulty=(1150, 1300),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )
    
    else:
        # Type 4: Two parabolas, one above the other
        # ELO ~1200-1300
        a_val = randint(1, 2)
        
        # Upper: y = a - x^2
        # Lower: y = x^2 - a
        # Difference: 2a - 2x^2
        # From -a to a: area = 2*int_0^a (2a - 2x^2) dx = 4*int_0^a (a - x^2) dx
        
        area_val = Rational(4*a_val*(3*a_val - a_val**2), 3)
        area_val = Rational(8*a_val**3, 3)
        
        question = f"Find the area between $y = {a_val} - x^2$ and $y = x^2 - {a_val}$ from $x = -{a_val}$ to $x = {a_val}$."
        
        solution = steps(
            f"The area is $\\int_{{{-a_val}}}^{{{a_val}}} \\left[({a_val} - x^2) - (x^2 - {a_val})\\right] dx$",
            f"$= \\int_{{{-a_val}}}^{{{a_val}}} ({2*a_val} - 2x^2) dx$",
            f"By symmetry: $= 2\\int_0^{{{a_val}}} ({2*a_val} - 2x^2) dx$",
            f"$= 2\\left[{2*a_val}x - \\frac{{2x^3}}{{3}}\\right]_0^{{{a_val}}}$",
            f"$= 2\\left({2*a_val*a_val} - \\frac{{2({a_val})^3}}{{3}}\\right) = {latex(area_val)}$"
        )
        
        return problem(
            question=question,
            answer=area_val,
            difficulty=(1200, 1300),
            topic="calculus/area_between_curves",
            solution=solution,
            calculator="scientific"
        )

emit(generate())