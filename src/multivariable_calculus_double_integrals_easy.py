"""
multivariable_calculus - double_integrals (easy)
Generated: 2026-02-22T05:38:57.585888
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Double integral of a constant over a rectangle
        # ∫∫ c dA over [a,b] × [c,d]
        const = randint(1, 5)
        x_lower = randint(0, 3)
        x_upper = x_lower + randint(1, 4)
        y_lower = randint(0, 3)
        y_upper = y_lower + randint(1, 4)
        
        width = x_upper - x_lower
        height = y_upper - y_lower
        ans = const * width * height
        
        return problem(
            question=f"Evaluate the double integral $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} {const} \\, dy \\, dx$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"First integrate with respect to $y$: $\\int_{{{y_lower}}}^{{{y_upper}}} {const} \\, dy = {const}y \\Big|_{{{y_lower}}}^{{{y_upper}}} = {const}({y_upper} - {y_lower}) = {const * height}$",
                f"Then integrate with respect to $x$: $\\int_{{{x_lower}}}^{{{x_upper}}} {const * height} \\, dx = {const * height}x \\Big|_{{{x_lower}}}^{{{x_upper}}} = {const * height}({x_upper} - {x_lower}) = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Double integral of x over a rectangle
        # ∫∫ x dA over [a,b] × [c,d]
        x_lower = randint(0, 2)
        x_upper = x_lower + randint(2, 4)
        y_lower = randint(0, 2)
        y_upper = y_lower + randint(2, 3)
        
        # Answer: (b²-a²)/2 * (d-c)
        x_part = (x_upper**2 - x_lower**2) / 2
        y_part = y_upper - y_lower
        ans = Rational(int(x_part * y_part * 2), 2)
        
        return problem(
            question=f"Evaluate the double integral $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} x \\, dy \\, dx$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"First integrate with respect to $y$: $\\int_{{{y_lower}}}^{{{y_upper}}} x \\, dy = xy \\Big|_{{{y_lower}}}^{{{y_upper}}} = x({y_upper} - {y_lower}) = {y_part}x$",
                f"Then integrate with respect to $x$: $\\int_{{{x_lower}}}^{{{x_upper}}} {y_part}x \\, dx = {y_part} \\cdot \\frac{{x^2}}{2} \\Big|_{{{x_lower}}}^{{{x_upper}}} = {y_part} \\cdot \\frac{{{x_upper**2} - {x_lower**2}}}{2} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Double integral of y over a rectangle
        # ∫∫ y dA over [a,b] × [c,d]
        x_lower = randint(0, 2)
        x_upper = x_lower + randint(2, 3)
        y_lower = randint(0, 2)
        y_upper = y_lower + randint(2, 4)
        
        # Answer: (b-a) * (d²-c²)/2
        x_part = x_upper - x_lower
        y_part = (y_upper**2 - y_lower**2) / 2
        ans = Rational(int(x_part * y_part * 2), 2)
        
        return problem(
            question=f"Evaluate the double integral $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} y \\, dy \\, dx$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"First integrate with respect to $y$: $\\int_{{{y_lower}}}^{{{y_upper}}} y \\, dy = \\frac{{y^2}}{2} \\Big|_{{{y_lower}}}^{{{y_upper}}} = \\frac{{{y_upper**2} - {y_lower**2}}}{2} = {latex(Rational(int(y_part*2), 2))}$",
                f"Then integrate with respect to $x$: $\\int_{{{x_lower}}}^{{{x_upper}}} {latex(Rational(int(y_part*2), 2))} \\, dx = {latex(Rational(int(y_part*2), 2))} \\cdot x \\Big|_{{{x_lower}}}^{{{x_upper}}} = {latex(Rational(int(y_part*2), 2))} \\cdot ({x_upper} - {x_lower}) = {latex(ans)}$"
            ),
        )
    
    else:
        # Type 4: Double integral of xy over a rectangle
        # ∫∫ xy dA over [a,b] × [c,d]
        x_lower = randint(0, 2)
        x_upper = x_lower + randint(1, 3)
        y_lower = randint(0, 2)
        y_upper = y_lower + randint(1, 3)
        
        # Answer: (b²-a²)/2 * (d²-c²)/2
        x_part = (x_upper**2 - x_lower**2) / 2
        y_part = (y_upper**2 - y_lower**2) / 2
        ans = Rational(int(x_part * y_part * 4), 4)
        
        return problem(
            question=f"Evaluate the double integral $\\int_{{{x_lower}}}^{{{x_upper}}} \\int_{{{y_lower}}}^{{{y_upper}}} xy \\, dy \\, dx$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"First integrate with respect to $y$: $\\int_{{{y_lower}}}^{{{y_upper}}} xy \\, dy = x \\cdot \\frac{{y^2}}{2} \\Big|_{{{y_lower}}}^{{{y_upper}}} = x \\cdot \\frac{{{y_upper**2} - {y_lower**2}}}{2} = {latex(Rational(int(y_part*2), 2))}x$",
                f"Then integrate with respect to $x$: $\\int_{{{x_lower}}}^{{{x_upper}}} {latex(Rational(int(y_part*2), 2))}x \\, dx = {latex(Rational(int(y_part*2), 2))} \\cdot \\frac{{x^2}}{2} \\Big|_{{{x_lower}}}^{{{x_upper}}} = {latex(Rational(int(y_part*2), 2))} \\cdot \\frac{{{x_upper**2} - {x_lower**2}}}{2} = {latex(ans)}$"
            ),
        )

emit(generate())