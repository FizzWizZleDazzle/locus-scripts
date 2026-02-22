"""
differential_equations - characteristic_equation (hard)
Generated: 2026-02-22T05:26:46.117468
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 4)
    
    if difficulty_choice == 1:
        # Complex roots with higher order or complex coefficients (1600-1700)
        order = choice([3, 4])
        
        if order == 3:
            # Third order with one real root and two complex roots
            r1 = nonzero(-3, 3)
            alpha = nonzero(-2, 2)
            beta = randint(1, 3)
            
            # Characteristic equation: (r - r1)(r - alpha - beta*i)(r - alpha + beta*i)
            # = (r - r1)(r^2 - 2*alpha*r + alpha^2 + beta^2)
            
            a2 = -(r1 + 2*alpha)
            a1 = r1*2*alpha + alpha**2 + beta**2
            a0 = -r1*(alpha**2 + beta**2)
            
            ans_parts = [f"r = {r1}", f"r = {alpha} + {beta}i", f"r = {alpha} - {beta}i"]
            ans_str = fmt_set(ans_parts)
            
            return problem(
                question=f"Find all roots of the characteristic equation $r^3 + {a2}r^2 + {a1}r + {a0} = 0$",
                answer=ans_str,
                difficulty=(1600, 1700),
                topic="differential_equations/characteristic_equation",
                answer_type="set",
                solution=steps(
                    f"Try rational roots using the rational root theorem",
                    f"Testing $r = {r1}$: $({r1})^3 + {a2}({r1})^2 + {a1}({r1}) + {a0} = 0$ ✓",
                    f"Factor out $(r - {r1})$ to get $r^2 + {-2*alpha}r + {alpha**2 + beta**2} = 0$",
                    f"Use quadratic formula: $r = \\frac{{{2*alpha} \\pm \\sqrt{{{4*alpha**2} - {4*(alpha**2 + beta**2)}}}}}{2}$",
                    f"$r = \\frac{{{2*alpha} \\pm \\sqrt{{-{4*beta**2}}}}}{2} = {alpha} \\pm {beta}i$",
                    f"Roots: $r = {r1}, {alpha} + {beta}i, {alpha} - {beta}i$"
                ),
            )
        else:
            # Fourth order with repeated roots (1650-1750)
            r1 = nonzero(-3, 3)
            r2 = nonzero(-3, 3)
            while r2 == r1:
                r2 = nonzero(-3, 3)
            
            # (r - r1)^2 * (r - r2)^2
            poly = expand((x - r1)**2 * (x - r2)**2)
            coeffs = [poly.coeff(x, i) for i in range(5)]
            
            ans_parts = [f"r = {r1}", f"r = {r2}"]
            ans_str = fmt_set(ans_parts)
            
            return problem(
                question=f"Find all distinct roots of the characteristic equation ${latex(poly)} = 0$",
                answer=ans_str,
                difficulty=(1650, 1750),
                topic="differential_equations/characteristic_equation",
                answer_type="set",
                solution=steps(
                    f"Factor the polynomial: ${latex(poly)} = (r - {r1})^2(r - {r2})^2$",
                    f"The roots are $r = {r1}$ (multiplicity 2) and $r = {r2}$ (multiplicity 2)",
                    f"Distinct roots: $r = {r1}, {r2}$"
                ),
            )
    
    elif difficulty_choice == 2:
        # Construct DE from general solution and find characteristic equation (1700-1800)
        r1 = nonzero(-4, 4)
        r2 = nonzero(-4, 4)
        while r2 == r1:
            r2 = nonzero(-4, 4)
        
        # Characteristic equation (r - r1)(r - r2) = r^2 - (r1+r2)r + r1*r2
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        char_eq = f"r^2 {'+' if b_coeff >= 0 else ''}{b_coeff}r {'+' if c_coeff >= 0 else ''}{c_coeff} = 0"
        
        ans_str = fmt_set([f"r = {r1}", f"r = {r2}"])
        
        return problem(
            question=f"The general solution to a second-order linear homogeneous differential equation is $y = c_1 e^{{{r1}t}} + c_2 e^{{{r2}t}}$. Find the roots of its characteristic equation.",
            answer=ans_str,
            difficulty=(1700, 1800),
            topic="differential_equations/characteristic_equation",
            answer_type="set",
            solution=steps(
                f"From the general solution $y = c_1 e^{{{r1}t}} + c_2 e^{{{r2}t}}$, the characteristic roots are $r = {r1}$ and $r = {r2}$",
                f"The characteristic equation must be $(r - {r1})(r - {r2}) = 0$",
                f"Expanding: ${char_eq}$",
                f"Roots: $r = {r1}, {r2}$"
            ),
        )
    
    elif difficulty_choice == 3:
        # Characteristic equation with parameter (1750-1850)
        r1 = nonzero(-3, 3)
        r2 = nonzero(-3, 3)
        while r2 == r1:
            r2 = nonzero(-3, 3)
        
        # r^2 + k*r + (r1*r2) = 0 should have roots r1 and r2
        # So k = -(r1 + r2)
        product = r1 * r2
        ans_k = -(r1 + r2)
        
        return problem(
            question=f"For what value of $k$ does the characteristic equation $r^2 + kr + {product} = 0$ have roots $r = {r1}$ and $r = {r2}$?",
            answer=ans_k,
            difficulty=(1750, 1850),
            topic="differential_equations/characteristic_equation",
            solution=steps(
                f"By Vieta's formulas, if $r = {r1}$ and $r = {r2}$ are roots, then:",
                f"Sum of roots: ${r1} + {r2} = -k$",
                f"Product of roots: ${r1} \\cdot {r2} = {product}$ ✓",
                f"Therefore $k = -{r1 + r2} = {ans_k}$"
            ),
        )
    
    else:
        # Higher order with mixed real and complex roots (1800-1900)
        r1 = nonzero(-2, 2)
        alpha = nonzero(-2, 2)
        beta = randint(1, 2)
        
        # (r - r1)^2 * (r^2 - 2*alpha*r + alpha^2 + beta^2)
        quad_part = x**2 - 2*alpha*x + alpha**2 + beta**2
        poly = expand((x - r1)**2 * quad_part)
        
        ans_parts = [f"r = {r1}", f"r = {alpha} + {beta}i", f"r = {alpha} - {beta}i"]
        ans_str = fmt_set(ans_parts)
        
        return problem(
            question=f"Find all distinct roots of the characteristic equation ${latex(poly)} = 0$",
            answer=ans_str,
            difficulty=(1800, 1900),
            topic="differential_equations/characteristic_equation",
            answer_type="set",
            calculator="scientific",
            solution=steps(
                f"Factor out $(r - {r1})^2$: ${latex(poly)} = (r - {r1})^2({latex(quad_part)})$",
                f"From $(r - {r1})^2 = 0$: $r = {r1}$ (multiplicity 2)",
                f"From ${latex(quad_part)} = 0$:",
                f"$r = \\frac{{{2*alpha} \\pm \\sqrt{{{4*alpha**2 - 4*(alpha**2 + beta**2)}}}}}{2}$",
                f"$r = \\frac{{{2*alpha} \\pm {2*beta}i}}{2} = {alpha} \\pm {beta}i$",
                f"Distinct roots: $r = {r1}, {alpha} + {beta}i, {alpha} - {beta}i$"
            ),
        )

emit(generate())