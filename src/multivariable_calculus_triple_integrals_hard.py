"""
multivariable_calculus - triple_integrals (hard)
Generated: 2026-02-22T05:41:24.619982
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Spherical coordinates: volume of sphere
        R = randint(2, 6)
        ans = Rational(4, 3) * pi * R**3
        return problem(
            question=f"Evaluate $\\iiint_E \\rho^2 \\sin(\\varphi) \\, d\\rho \\, d\\varphi \\, d\\theta$ where $E$ is the sphere $\\rho \\le {R}$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{2\\pi}} \\int_0^{{\\pi}} \\int_0^{{{R}}} \\rho^2 \\sin(\\varphi) \\, d\\rho \\, d\\varphi \\, d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\int_0^{{\\pi}} \\frac{{{R}^3}}{{3}} \\sin\\varphi \\, d\\varphi \\, d\\theta = \\int_0^{{2\\pi}} \\frac{{2 \\cdot {R**3}}}{{3}} \\, d\\theta$",
                f"$= \\frac{{4\\pi \\cdot {R**3}}}{{3}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 2:
        # Cylindrical: integral over cylinder
        R = randint(2, 5)
        h = randint(2, 6)
        ans = pi * R**2 * h
        return problem(
            question=f"Evaluate $\\iiint_E r \\, dz \\, dr \\, d\\theta$ where $E$: $r \\le {R}$, $0 \\le z \\le {h}$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{2\\pi}} \\int_0^{{{R}}} \\int_0^{{{h}}} r \\, dz \\, dr \\, d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\int_0^{{{R}}} {h} r \\, dr \\, d\\theta = \\int_0^{{2\\pi}} {h} \\cdot \\frac{{{R}^2}}{{2}} \\, d\\theta$",
                f"$= {Rational(h * R**2, 2)} \\cdot 2\\pi = {latex(ans)}$"
            ),
        )

    elif problem_type == 3:
        # Reversed order integral
        a = randint(2, 4)
        ans = Rational(a**4, 12)
        return problem(
            question=f"Evaluate by reversing order: $\\int_0^{{{a}}} \\int_y^{{{a}}} \\int_0^x z \\, dz \\, dx \\, dy$",
            answer=ans,
            difficulty=(1750, 1900),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Region: $0 \\le y \\le x \\le {a}$, $0 \\le z \\le x$",
                f"Reverse to: $\\int_0^{{{a}}} \\int_z^{{{a}}} \\int_0^x z \\, dy \\, dx \\, dz$",
                f"Inner: $\\int_0^x z \\, dy = zx$",
                f"$\\int_z^{{{a}}} zx \\, dx = z \\cdot \\frac{{{a}^2 - z^2}}{{2}}$",
                f"$\\int_0^{{{a}}} \\frac{{z({a}^2-z^2)}}{{2}} \\, dz = \\frac{1}{{2}}\\left[\\frac{{{a}^2 z^2}}{{2}} - \\frac{{z^4}}{{4}}\\right]_0^{{{a}}} = {latex(ans)}$"
            ),
        )

    elif problem_type == 4:
        # Mass with density z over a box
        a = randint(2, 5)
        ans = Rational(a**4, 2)
        return problem(
            question=f"Find the mass of $0 \\le x,y,z \\le {a}$ with density $\\rho = z$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"$\\int_0^{{{a}}} \\int_0^{{{a}}} \\int_0^{{{a}}} z \\, dx \\, dy \\, dz = {a}^2 \\int_0^{{{a}}} z \\, dz$",
                f"$= {a**2} \\cdot \\frac{{{a}^2}}{{2}} = {latex(ans)}$"
            ),
        )

    else:
        # Volume between paraboloid and plane
        R = randint(2, 4)
        ans = Rational(pi * R**4, 2)
        return problem(
            question=f"Find the volume between $z = x^2+y^2$ and $z = {R**2}$ using cylindrical coordinates.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"In cylindrical: $\\int_0^{{2\\pi}} \\int_0^{{{R}}} \\int_{{r^2}}^{{{R**2}}} r \\, dz \\, dr \\, d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\int_0^{{{R}}} r({R**2}-r^2) \\, dr \\, d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\left[\\frac{{{R**2}r^2}}{{2}}-\\frac{{r^4}}{{4}}\\right]_0^{{{R}}} d\\theta = \\int_0^{{2\\pi}} \\frac{{{R**4}}}{{4}} \\, d\\theta$",
                f"$= \\frac{{\\pi {R**4}}}{{2}} = {latex(ans)}$"
            ),
        )

emit(generate())
