"""
multivariable_calculus - double_integrals (hard)
Generated: 2026-02-22T05:39:52.897468
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Reverse order: 0 <= x <= a, x^2 <= y <= cx (compute in original order)
        a = randint(1, 3)
        c = randint(2, 4)
        coeff = nonzero(-2, 2)
        integrand = choice([x*y, x**2 + y, coeff*x*y**2, coeff*x**2*y])
        inner_y = integrate(integrand, (y, x**2, c*x))
        ans = integrate(inner_y, (x, 0, a))
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{a}}} \\int_{{x^2}}^{{{c}x}} {latex(integrand)} \\, dy \\, dx$",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Inner ($y$ from $x^2$ to ${c}x$): $\\int_{{x^2}}^{{{c}x}} {latex(integrand)} \\, dy = {latex(inner_y)}$",
                f"Outer: $\\int_0^{{{a}}} {latex(inner_y)} \\, dx = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Polar coordinates over disk
        r_max = randint(2, 5)
        power = randint(1, 3)
        integrand_cart = (x**2 + y**2)**power
        # polar: r^(2p), with Jacobian r
        r_power = 2*power + 1
        r_integral = Rational(r_max**r_power, r_power) * 2 * pi
        ans = r_integral
        return problem(
            question=f"Evaluate $\\iint_D (x^2+y^2)^{{{power}}} \\, dA$ over the disk $x^2+y^2 \\le {r_max**2}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Polar: $x=r\\cos\\theta$, $y=r\\sin\\theta$, $dA = r \\, dr \\, d\\theta$",
                f"$(x^2+y^2)^{{{power}}} = r^{{{2*power}}}$",
                f"$\\int_0^{{2\\pi}} \\int_0^{{{r_max}}} r^{{{2*power}}} \\cdot r \\, dr \\, d\\theta = \\int_0^{{2\\pi}} \\frac{{{r_max}^{{{2*power+1}}}}}{{{2*power+1}}} d\\theta$",
                f"$= \\frac{{2\\pi \\cdot {r_max**r_power}}}{{{r_power}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Region between y = x and y = x^2
        a = randint(1, 2)
        coeff = nonzero(-3, 3)
        func_choice = choice(['x_plus_y', 'xy', 'coeff_x'])
        if func_choice == 'x_plus_y':
            integrand = x + coeff*y
        elif func_choice == 'xy':
            integrand = coeff * x * y
        else:
            integrand = coeff * x
        inner = integrate(integrand, (y, x**2, x))
        ans = integrate(inner, (x, 0, a))
        return problem(
            question=f"Evaluate $\\iint_R {latex(integrand)} \\, dA$ where $R$ is bounded by $y=x$ and $y=x^2$, $0 \\le x \\le {a}$.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Region: $0 \\le x \\le {a}$, $x^2 \\le y \\le x$",
                f"$\\int_0^{{{a}}} \\int_{{x^2}}^x {latex(integrand)} \\, dy \\, dx$",
                f"Inner: $= {latex(inner)}$",
                f"Outer: $= {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Polar sector
        r_val = randint(2, 5)
        angle_frac = choice([Rational(1, 4), Rational(1, 3), Rational(1, 2), Rational(2, 3)])
        theta_max = angle_frac * pi
        integrand_r = r**2
        ans = integrate(integrate(r * integrand_r, (r, 0, r_val)), (t, 0, theta_max))
        if angle_frac == Rational(1, 4):
            angle_str = "\\frac{\\pi}{4}"
        elif angle_frac == Rational(1, 3):
            angle_str = "\\frac{\\pi}{3}"
        elif angle_frac == Rational(1, 2):
            angle_str = "\\frac{\\pi}{2}"
        else:
            angle_str = "\\frac{2\\pi}{3}"
        return problem(
            question=f"Evaluate $\\iint_R r^2 \\, dA$ over $0 \\le r \\le {r_val}$, $0 \\le \\theta \\le {angle_str}$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"$dA = r \\, dr \\, d\\theta$",
                f"$\\int_0^{{{angle_str}}} \\int_0^{{{r_val}}} r^3 \\, dr \\, d\\theta = \\int_0^{{{angle_str}}} \\frac{{{r_val**4}}}{{4}} \\, d\\theta$",
                f"$= \\frac{{{r_val**4}}}{{4}} \\cdot {angle_str} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    else:
        # Type I region with variable bounds
        b = randint(2, 4)
        c = nonzero(-2, 2)
        func_choice = choice(['x_plus_cy', 'xy', 'cx2'])
        if func_choice == 'x_plus_cy':
            integrand = x + c*y
        elif func_choice == 'xy':
            integrand = c * x * y
        else:
            integrand = c * x**2
        a_lim = randint(1, 2)
        inner = integrate(integrand, (x, y, b))
        ans = integrate(inner, (y, 0, a_lim))
        return problem(
            question=f"Evaluate $\\int_{{0}}^{{{a_lim}}} \\int_{{y}}^{{{b}}} {latex(integrand)} \\, dx \\, dy$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="multivariable_calculus/double_integrals",
            solution=steps(
                f"Region: $0 \\le y \\le {a_lim}$, $y \\le x \\le {b}$",
                f"Inner: $\\int_y^{{{b}}} {latex(integrand)} \\, dx = {latex(inner)}$",
                f"Outer: $= {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())
