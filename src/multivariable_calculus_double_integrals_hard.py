"""
multivariable_calculus - double_integrals (hard)
Generated: 2026-02-22T05:39:52.897468
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Changing order of integration with non-rectangular region
        a = randint(1, 3)
        b = randint(1, 3)
        c = randint(2, 4)
        
        # Region: 0 <= x <= a, x^2 <= y <= c*x
        integrand = choice([x*y, x**2 + y**2, x*y**2, x**2*y])
        
        # Compute in original order dy dx
        inner_y = integrate(integrand, (y, x**2, c*x))
        ans = integrate(inner_y, (x, 0, a))
        
        question = f"Evaluate the double integral by reversing the order of integration: $$\\int_{{0}}^{{{a}}} \\int_{{x^2}}^{{{c}x}} {latex(integrand)} \\, dy \\, dx$$"
        
        solution_steps = [
            f"Original region: $0 \\le x \\le {a}$, $x^2 \\le y \\le {c}x$",
            f"To reverse order, find bounds: $y = x^2$ and $y = {c}x$ intersect at $x = 0, {c}$",
            f"For fixed $y$: from $y = x^2$ we get $x = \\sqrt{{y}}$, from $y = {c}x$ we get $x = \\frac{{y}}{{{c}}}$",
            f"New region: $0 \\le y \\le {c*a}$, $\\frac{{y}}{{{c}}} \\le x \\le \\sqrt{{y}}$ for $0 \\le y \\le {c**2}$ and $\\frac{{y}}{{{c}}} \\le x \\le {a}$ for ${c**2} \\le y \\le {c*a}$",
            f"Integrate ${latex(integrand)}$ with respect to $y$ first: ${latex(inner_y)}$",
            f"Then integrate with respect to $x$: ${latex(ans)}$"
        ]
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/double_integrals",
            solution=steps(*solution_steps),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Polar coordinates double integral
        r_max = randint(2, 4)
        power = randint(1, 2)
        
        if power == 1:
            # Integrate r over a circle
            integrand_polar = r**2  # r from Jacobian included
            integrand_cart = sqrt(x**2 + y**2)
            ans = integrate(integrate(integrand_polar * r, (r, 0, r_max)), (t, 0, 2*pi))
        else:
            # Integrate r^2 over a circle
            integrand_polar = r**3  # r from Jacobian included
            integrand_cart = x**2 + y**2
            ans = integrate(integrate(integrand_polar * r, (r, 0, r_max)), (t, 0, 2*pi))
        
        question = f"Evaluate the double integral over the disk $x^2 + y^2 \\le {r_max**2}$: $$\\iint_D {latex(integrand_cart)} \\, dA$$"
        
        solution_steps = [
            f"Convert to polar coordinates: $x = r\\cos\\theta$, $y = r\\sin\\theta$, $dA = r \\, dr \\, d\\theta$",
            f"In polar coordinates: ${latex(integrand_cart)} = r^{{{2*power}}}$",
            f"Region becomes: $0 \\le r \\le {r_max}$, $0 \\le \\theta \\le 2\\pi$",
            f"Set up integral: $\\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r^{{{2*power}}} \\cdot r \\, dr \\, d\\theta$",
            f"Integrate with respect to $r$: $\\int_0^{{2\\pi}} \\left[\\frac{{r^{{{2*power+1}}}}}{{{2*power+1}}}\\right]_0^{{{r_max}}} d\\theta = \\int_0^{{2\\pi}} \\frac{{{r_max**{2*power+1}}}}{{{2*power+1}}} d\\theta$",
            f"Integrate with respect to $\\theta$: ${latex(ans)}$"
        ]
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/double_integrals",
            solution=steps(*solution_steps),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Region bounded by two curves - volume under surface
        a = randint(1, 3)
        b = randint(2, 4)
        
        # Region between y = x and y = x^2, 0 <= x <= a
        integrand = choice([x + y, x*y, b*x + y])
        
        inner = integrate(integrand, (y, x**2, x))
        ans = integrate(inner, (x, 0, a))
        
        question = f"Evaluate the double integral over the region bounded by $y = x^2$ and $y = x$ where $0 \\le x \\le {a}$: $$\\iint_R {latex(integrand)} \\, dA$$"
        
        solution_steps = [
            f"Region $R$: $0 \\le x \\le {a}$, $x^2 \\le y \\le x$",
            f"Set up the double integral: $\\int_0^{{{a}}} \\int_{{x^2}}^x {latex(integrand)} \\, dy \\, dx$",
            f"Integrate with respect to $y$: $\\int_0^{{{a}}} \\left[{latex(inner)}\\right] dx$",
            f"Simplify: $\\int_0^{{{a}}} {latex(inner)} \\, dx$",
            f"Integrate with respect to $x$: ${latex(ans)}$"
        ]
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/double_integrals",
            solution=steps(*solution_steps),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Polar region with angle bounds
        r_val = randint(2, 5)
        angle_frac = choice([Rational(1,4), Rational(1,3), Rational(1,2)])
        theta_max = angle_frac * pi
        
        # Integrate r^2 over sector
        integrand = r**2
        ans = integrate(integrate(r * integrand, (r, 0, r_val)), (t, 0, theta_max))
        
        if angle_frac == Rational(1,4):
            angle_str = "\\frac{\\pi}{4}"
        elif angle_frac == Rational(1,3):
            angle_str = "\\frac{\\pi}{3}"
        else:
            angle_str = "\\frac{\\pi}{2}"
        
        question = f"Evaluate the double integral in polar coordinates over the region $0 \\le r \\le {r_val}$, $0 \\le \\theta \\le {angle_str}$: $$\\iint_R r^2 \\, dA$$"
        
        solution_steps = [
            f"In polar coordinates: $dA = r \\, dr \\, d\\theta$",
            f"Set up integral: $\\int_0^{{{angle_str}}} \\int_0^{{{r_val}}} r^2 \\cdot r \\, dr \\, d\\theta$",
            f"Simplify: $\\int_0^{{{angle_str}}} \\int_0^{{{r_val}}} r^3 \\, dr \\, d\\theta$",
            f"Integrate with respect to $r$: $\\int_0^{{{angle_str}}} \\left[\\frac{{r^4}}{{4}}\\right]_0^{{{r_val}}} d\\theta = \\int_0^{{{angle_str}}} \\frac{{{r_val**4}}}{{4}} d\\theta$",
            f"Integrate with respect to $\\theta$: ${latex(ans)}$"
        ]
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/double_integrals",
            solution=steps(*solution_steps),
            calculator="scientific"
        )
    
    else:
        # Type 1 region with polynomial bounds
        a = randint(1, 2)
        b = randint(2, 3)
        c = randint(1, 2)
        
        # Region: 0 <= y <= a, y <= x <= b
        integrand = choice([x + c*y, x*y, x**2 + c*y])
        
        inner = integrate(integrand, (x, y, b))
        ans = integrate(inner, (y, 0, a))
        
        question = f"Evaluate the double integral: $$\\int_{{0}}^{{{a}}} \\int_{{y}}^{{{b}}} {latex(integrand)} \\, dx \\, dy$$"
        
        solution_steps = [
            f"Region: $0 \\le y \\le {a}$, $y \\le x \\le {b}$",
            f"Integrate with respect to $x$: $\\int_0^{{{a}}} \\left[{latex(inner)}\\right]_{{y}}^{{{b}}} dy$",
            f"Evaluate at bounds: $\\int_0^{{{a}}} {latex(inner)} \\, dy$",
            f"Integrate with respect to $y$: ${latex(ans)}$"
        ]
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/double_integrals",
            solution=steps(*solution_steps),
            calculator="scientific"
        )

emit(generate())