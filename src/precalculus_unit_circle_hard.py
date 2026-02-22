"""
precalculus - unit_circle (hard)
Generated: 2026-02-22T04:42:59.483760
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Find exact value using sum/difference formulas
        angle_choices = [
            (75, 45, 30),
            (105, 60, 45),
            (15, 45, 30),
            (195, 150, 45),
            (165, 120, 45),
        ]
        target, a1, a2 = choice(angle_choices)
        func_choice = choice(['sin', 'cos', 'tan'])
        
        if target == 75:
            operation = '+'
        elif target == 15:
            operation = '-'
        elif target == 105:
            operation = '+'
        elif target == 195:
            operation = '+'
        elif target == 165:
            operation = '+'
        else:
            operation = choice(['+', '-'])
        
        if func_choice == 'sin':
            ans = sin(target * pi / 180)
        elif func_choice == 'cos':
            ans = cos(target * pi / 180)
        else:
            ans = tan(target * pi / 180)
        
        ans_simplified = simplify(ans)
        
        return problem(
            question=f"Find the exact value of $\\{func_choice}({target}^\\circ)$ using sum or difference formulas.",
            answer=ans_simplified,
            difficulty=(1600, 1750),
            topic="precalculus/unit_circle",
            solution=steps(
                f"Express ${target}^\\circ$ as ${a1}^\\circ {operation} {a2}^\\circ$",
                f"Apply the {func_choice} {'sum' if operation == '+' else 'difference'} formula",
                f"Substitute known values from the unit circle",
                f"$\\{func_choice}({target}^\\circ) = {latex(ans_simplified)}$"
            ),
        )
    
    elif problem_type == 2:
        # Solve trig equation on [0, 2π) requiring multiple identities
        coeff_choices = [2, 3, 4]
        coeff = choice(coeff_choices)
        func_type = choice(['sin_cos', 'double_angle', 'half_angle'])
        
        if func_type == 'sin_cos':
            # sin(x) = cos(x) type or variations
            k = choice([1, -1])
            # 2sin(x)cos(x) = sin(x)
            # sin(2x) = sin(x)
            # Solutions: 0, π/3, π, 5π/3
            angles = [0, pi/3, pi, Rational(5,3)*pi]
            ans = FiniteSet(*angles)
            
            return problem(
                question=f"Solve $\\sin(2x) = \\sin(x)$ for $x \\in [0, 2\\pi)$.",
                answer=ans,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Use the double angle formula: $\\sin(2x) = 2\\sin(x)\\cos(x)$",
                    "$2\\sin(x)\\cos(x) = \\sin(x)$",
                    "$2\\sin(x)\\cos(x) - \\sin(x) = 0$",
                    "$\\sin(x)(2\\cos(x) - 1) = 0$",
                    "$\\sin(x) = 0$ or $\\cos(x) = \\frac{1}{2}$",
                    f"Solutions: ${latex(ans)}$"
                ),
            )
        
        elif func_type == 'double_angle':
            # cos(2x) = cos(x)
            angles = [0, Rational(2,3)*pi, Rational(4,3)*pi]
            ans = FiniteSet(*angles)
            
            return problem(
                question=f"Solve $\\cos(2x) = \\cos(x)$ for $x \\in [0, 2\\pi)$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Use the double angle formula: $\\cos(2x) = 2\\cos^2(x) - 1$",
                    "$2\\cos^2(x) - 1 = \\cos(x)$",
                    "$2\\cos^2(x) - \\cos(x) - 1 = 0$",
                    "Let $u = \\cos(x)$: $2u^2 - u - 1 = 0$",
                    "$(2u + 1)(u - 1) = 0$, so $u = -\\frac{1}{2}$ or $u = 1$",
                    "$\\cos(x) = 1$ gives $x = 0$; $\\cos(x) = -\\frac{1}{2}$ gives $x = \\frac{2\\pi}{3}, \\frac{4\\pi}{3}$",
                    f"Solutions: ${latex(ans)}$"
                ),
            )
        
        else:  # Pythagorean identity problem
            val = choice([Rational(1,2), Rational(1,3), Rational(2,3)])
            angles = [pi/6, Rational(5,6)*pi]
            ans = FiniteSet(*angles)
            
            return problem(
                question=f"Solve $\\sin^2(x) + \\cos(x) = 1$ for $x \\in [0, 2\\pi)$ given $\\cos(x) = \\frac{{1}}{{2}}$.",
                answer=ans,
                difficulty=(1600, 1700),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Use the Pythagorean identity: $\\sin^2(x) = 1 - \\cos^2(x)$",
                    "$1 - \\cos^2(x) + \\cos(x) = 1$",
                    "$-\\cos^2(x) + \\cos(x) = 0$",
                    "$\\cos(x)(1 - \\cos(x)) = 0$",
                    "$\\cos(x) = 0$ or $\\cos(x) = 1$",
                    "But we're given $\\cos(x) = \\frac{1}{2}$, so substitute back to verify",
                    f"Solutions where $\\cos(x) = \\frac{{1}}{{2}}$: ${latex(ans)}$"
                ),
            )
    
    elif problem_type == 3:
        # Reference angle with negative or large angle
        quad = randint(2, 4)
        base_angle = choice([30, 45, 60])
        
        if quad == 2:
            angle = 180 - base_angle
        elif quad == 3:
            angle = 180 + base_angle
        else:
            angle = 360 - base_angle
        
        # Make it harder by adding rotations or using negative
        rotations = choice([0, 1, 2])
        use_negative = choice([True, False])
        
        if use_negative:
            angle = -angle - 360 * rotations
        else:
            angle = angle + 360 * rotations
        
        ans = base_angle
        
        return problem(
            question=f"Find the reference angle for ${angle}^\\circ$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="precalculus/unit_circle",
            solution=steps(
                f"First find the coterminal angle in $[0^\\circ, 360^\\circ)$",
                f"Coterminal angle: ${(angle % 360)}^\\circ$",
                f"Determine which quadrant",
                f"Reference angle: ${ans}^\\circ$"
            ),
        )
    
    elif problem_type == 4:
        # Verify identity (harder ones)
        identity_type = choice(['product_to_sum', 'sum_to_product', 'double_half'])
        
        if identity_type == 'product_to_sum':
            # 2sin(A)cos(B) = sin(A+B) + sin(A-B)
            return problem(
                question="Verify the identity: $2\\sin(3x)\\cos(x) = \\sin(4x) + \\sin(2x)$",
                answer=True,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Use product-to-sum formula: $2\\sin(A)\\cos(B) = \\sin(A+B) + \\sin(A-B)$",
                    "Let $A = 3x$ and $B = x$",
                    "$2\\sin(3x)\\cos(x) = \\sin(3x + x) + \\sin(3x - x)$",
                    "$= \\sin(4x) + \\sin(2x)$ ✓"
                ),
            )
        
        elif identity_type == 'sum_to_product':
            return problem(
                question="Verify the identity: $\\sin(5x) - \\sin(x) = 2\\cos(3x)\\sin(2x)$",
                answer=True,
                difficulty=(1750, 1900),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Use sum-to-product formula: $\\sin(A) - \\sin(B) = 2\\cos\\left(\\frac{A+B}{2}\\right)\\sin\\left(\\frac{A-B}{2}\\right)$",
                    "Let $A = 5x$ and $B = x$",
                    "$\\sin(5x) - \\sin(x) = 2\\cos\\left(\\frac{5x+x}{2}\\right)\\sin\\left(\\frac{5x-x}{2}\\right)$",
                    "$= 2\\cos(3x)\\sin(2x)$ ✓"
                ),
            )
        
        else:
            return problem(
                question="Verify the identity: $\\frac{1 - \\cos(2x)}{\\sin(2x)} = \\tan(x)$",
                answer=True,
                difficulty=(1700, 1850),
                topic="precalculus/unit_circle",
                solution=steps(
                    "Use double angle formulas: $\\cos(2x) = 1 - 2\\sin^2(x)$ and $\\sin(2x) = 2\\sin(x)\\cos(x)$",
                    "$\\frac{1 - (1 - 2\\sin^2(x))}{2\\sin(x)\\cos(x)} = \\frac{2\\sin^2(x)}{2\\sin(x)\\cos(x)}$",
                    "$= \\frac{\\sin(x)}{\\cos(x)} = \\tan(x)$ ✓"
                ),
            )
    
    elif problem_type == 5:
        # Find all solutions to equation (not just [0, 2π))
        k_symbol = symbols('k', integer=True)
        eq_type = choice(['sin_eq', 'cos_eq', 'tan_eq'])
        
        if eq_type == 'sin_eq':
            val = choice([Rational(1,2), Rational(-1,2), sqrt(2)/2, -sqrt(2)/2])
            
            if val == Rational(1,2):
                base_sols = "x = \\frac{\\pi}{6} + 2\\pi k \\text{ or } x = \\frac{5\\pi}{6} + 2\\pi k"
            elif val == Rational(-1,2):
                base_sols = "x = \\frac{7\\pi}{6} + 2\\pi k \\text{ or } x = \\frac{11\\pi}{6} + 2\\pi k"
            elif val == sqrt(2)/2:
                base_sols = "x = \\frac{\\pi}{4} + 2\\pi k \\text{ or } x = \\frac{3\\pi}{4} + 2\\pi k"
            else:
                base_sols = "x = \\frac{5\\pi}{4} + 2\\pi k \\text{ or } x = \\frac{7\\pi}{4} + 2\\pi k"
            
            return problem(
                question=f"Find all solutions to $\\sin(x) = {latex(val)}$ where $k$ is any integer.",
                answer=base_sols,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                answer_type="text",
                solution=steps(
                    f"Find reference angle where $\\sin(\\theta) = |{latex(val)}|$",
                    "Determine which quadrants have the correct sign",
                    f"General solution: ${base_sols}$"
                ),
            )
        
        elif eq_type == 'cos_eq':
            val = choice([Rational(1,2), Rational(-1,2)])
            
            if val == Rational(1,2):
                base_sols = "x = \\frac{\\pi}{3} + 2\\pi k \\text{ or } x = \\frac{5\\pi}{3} + 2\\pi k"
            else:
                base_sols = "x = \\frac{2\\pi}{3} + 2\\pi k \\text{ or } x = \\frac{4\\pi}{3} + 2\\pi k"
            
            return problem(
                question=f"Find all solutions to $\\cos(x) = {latex(val)}$ where $k$ is any integer.",
                answer=base_sols,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                answer_type="text",
                solution=steps(
                    f"Find reference angle where $\\cos(\\theta) = |{latex(val)}|$",
                    "Determine which quadrants have the correct sign",
                    f"General solution: ${base_sols}$"
                ),
            )
        
        else:
            base_sols = "x = \\frac{3\\pi}{4} + \\pi k"
            
            return problem(
                question=f"Find all solutions to $\\tan(x) = -1$ where $k$ is any integer.",
                answer=base_sols,
                difficulty=(1650, 1800),
                topic="precalculus/unit_circle",
                answer_type="text",
                solution=steps(
                    "Find reference angle where $\\tan(\\theta) = 1$",
                    "Reference angle is $\\frac{\\pi}{4}$",
                    "Tangent is negative in quadrants II and IV",
                    "Period of tangent is $\\pi$",
                    f"General solution: ${base_sols}$"
                ),
            )
    
    else:  # problem_type == 6
        # Arc length or sector area using radians
        radius = randint(3, 12)
        angle_num = choice([1, 2, 3, 4, 5])
        angle_den = choice([3, 4, 6])
        angle = Rational(angle_num, angle_den) * pi
        
        use_arc = choice([True, False])
        
        if use_arc:
            arc_length = radius * angle
            ans = simplify(arc_length)
            
            return problem(
                question=f"Find the arc length of a circle with radius ${radius}$ subtended by a central angle of ${latex(angle)}$ radians.",
                answer=ans,
                difficulty=(1