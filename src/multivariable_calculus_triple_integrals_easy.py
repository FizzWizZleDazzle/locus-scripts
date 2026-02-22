"""
multivariable_calculus - triple_integrals (easy)
Generated: 2026-02-22T05:40:20.547679
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Integrate a constant over a rectangular box
        # ∫∫∫ c dV over [a,b]×[c,d]×[e,f]
        constant = randint(1, 5)
        x1, x2 = sorted([randint(0, 3), randint(4, 6)])
        y1, y2 = sorted([randint(0, 2), randint(3, 5)])
        z1, z2 = sorted([randint(0, 2), randint(3, 5)])
        
        volume = (x2 - x1) * (y2 - y1) * (z2 - z1)
        ans = constant * volume
        
        return problem(
            question=f"Evaluate the triple integral $\\int_{{{z1}}}^{{{z2}}} \\int_{{{y1}}}^{{{y2}}} \\int_{{{x1}}}^{{{x2}}} {constant} \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Since the integrand is constant, the integral equals the constant times the volume of the region.",
                f"Volume = $(${x2} - {x1}$) \\cdot (${y2} - {y1}$) \\cdot (${z2} - {z1}$) = {volume}$",
                f"Result = ${constant} \\cdot {volume} = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Integrate a simple power of one variable
        # ∫∫∫ x^n dV over [0,a]×[0,b]×[0,c]
        power = randint(1, 2)
        a_val = randint(1, 3)
        b_val = randint(1, 3)
        c_val = randint(1, 3)
        
        # ∫_0^a x^n dx = a^(n+1)/(n+1)
        x_integral = Rational(a_val**(power+1), power+1)
        ans = x_integral * b_val * c_val
        
        if power == 1:
            integrand_str = "x"
        else:
            integrand_str = f"x^{{{power}}}"
        
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{c_val}}} \\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} {integrand_str} \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Integrate with respect to $x$ first:",
                f"$\\int_{{0}}^{{{a_val}}} {integrand_str} \\, dx = \\left[\\frac{{x^{{{power+1}}}}}{{{power+1}}}\\right]_{{0}}^{{{a_val}}} = {latex(x_integral)}$",
                f"Now integrate with respect to $y$:",
                f"$\\int_{{0}}^{{{b_val}}} {latex(x_integral)} \\, dy = {latex(x_integral * b_val)}$",
                f"Finally integrate with respect to $z$:",
                f"$\\int_{{0}}^{{{c_val}}} {latex(x_integral * b_val)} \\, dz = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Integrate xyz over a unit cube or simple box
        a_val = randint(1, 2)
        b_val = randint(1, 2)
        c_val = randint(1, 2)
        
        # ∫_0^a ∫_0^b ∫_0^c xyz dx dy dz = (a²/2)(b²/2)(c²/2)
        ans = Rational(a_val**2, 2) * Rational(b_val**2, 2) * Rational(c_val**2, 2)
        
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{c_val}}} \\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} xyz \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Integrate with respect to $x$:",
                f"$\\int_{{0}}^{{{a_val}}} xyz \\, dx = yz \\cdot \\left[\\frac{{x^2}}{{2}}\\right]_{{0}}^{{{a_val}}} = \\frac{{{a_val**2}}}{{2}}yz$",
                f"Integrate with respect to $y$:",
                f"$\\int_{{0}}^{{{b_val}}} \\frac{{{a_val**2}}}{{2}}yz \\, dy = \\frac{{{a_val**2}}}{{2}}z \\cdot \\left[\\frac{{y^2}}{{2}}\\right]_{{0}}^{{{b_val}}} = \\frac{{{a_val**2} \\cdot {b_val**2}}}{{4}}z$",
                f"Integrate with respect to $z$:",
                f"$\\int_{{0}}^{{{c_val}}} \\frac{{{a_val**2} \\cdot {b_val**2}}}{{4}}z \\, dz = \\frac{{{a_val**2} \\cdot {b_val**2}}}{{4}} \\cdot \\left[\\frac{{z^2}}{{2}}\\right]_{{0}}^{{{c_val}}} = {latex(ans)}$"
            ),
        )
    
    else:
        # Type 4: Sum of simple functions x + y + z
        a_val = randint(1, 2)
        b_val = randint(1, 2)
        c_val = randint(1, 2)
        
        # ∫∫∫ (x+y+z) dV = ∫∫∫ x dV + ∫∫∫ y dV + ∫∫∫ z dV
        # Each integral = (a²/2)bc for x, etc.
        x_part = Rational(a_val**2, 2) * b_val * c_val
        y_part = a_val * Rational(b_val**2, 2) * c_val
        z_part = a_val * b_val * Rational(c_val**2, 2)
        ans = x_part + y_part + z_part
        
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{c_val}}} \\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} (x + y + z) \\, dx \\, dy \\, dz$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Split the integral: $\\int_{{0}}^{{{c_val}}} \\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} x \\, dx \\, dy \\, dz + \\int_{{0}}^{{{c_val}}} \\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} y \\, dx \\, dy \\, dz + \\int_{{0}}^{{{c_val}}} \\int_{{0}}^{{{b_val}}} \\int_{{0}}^{{{a_val}}} z \\, dx \\, dy \\, dz$",
                f"First integral: $\\frac{{{a_val**2}}}{{2}} \\cdot {b_val} \\cdot {c_val} = {latex(x_part)}$",
                f"Second integral: ${a_val} \\cdot \\frac{{{b_val**2}}}{{2}} \\cdot {c_val} = {latex(y_part)}$",
                f"Third integral: ${a_val} \\cdot {b_val} \\cdot \\frac{{{c_val**2}}}{{2}} = {latex(z_part)}$",
                f"Sum: ${latex(x_part)} + {latex(y_part)} + {latex(z_part)} = {latex(ans)}$"
            ),
        )

emit(generate())