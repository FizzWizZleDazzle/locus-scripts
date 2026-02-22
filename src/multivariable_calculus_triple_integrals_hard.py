"""
multivariable_calculus - triple_integrals (hard)
Generated: 2026-02-22T05:41:24.619982
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Spherical coordinates triple integral (1650-1850)
        # Reverse engineer: integrate over a sphere or cone
        shape_type = choice(['sphere', 'cone'])
        
        if shape_type == 'sphere':
            R = randint(2, 5)
            # Volume of sphere using spherical coordinates
            # ∫∫∫ ρ²sin(φ) dρ dφ dθ
            ans = Rational(4, 3) * pi * R**3
            
            return problem(
                question=f"Evaluate the triple integral \\[\\iiint_E \\rho^2 \\sin(\\varphi) \\, d\\rho \\, d\\varphi \\, d\\theta\\] where $E$ is the sphere of radius ${R}$ centered at the origin in spherical coordinates $(\\rho, \\varphi, \\theta)$ where $0 \\le \\rho \\le {R}$, $0 \\le \\varphi \\le \\pi$, $0 \\le \\theta \\le 2\\pi$.",
                answer=ans,
                difficulty=(1650, 1750),
                topic="multivariable_calculus/triple_integrals",
                solution=steps(
                    f"Set up the integral: $\\int_0^{{2\\pi}} \\int_0^{{\\pi}} \\int_0^{{{R}}} \\rho^2 \\sin(\\varphi) \\, d\\rho \\, d\\varphi \\, d\\theta$",
                    f"Integrate with respect to $\\rho$: $\\int_0^{{2\\pi}} \\int_0^{{\\pi}} \\left[\\frac{{\\rho^3}}{{3}}\\right]_0^{{{R}}} \\sin(\\varphi) \\, d\\varphi \\, d\\theta = \\int_0^{{2\\pi}} \\int_0^{{\\pi}} \\frac{{{R**3}}}{{3}} \\sin(\\varphi) \\, d\\varphi \\, d\\theta$",
                    f"Integrate with respect to $\\varphi$: $\\int_0^{{2\\pi}} \\frac{{{R**3}}}{{3}} \\left[-\\cos(\\varphi)\\right]_0^{{\\pi}} d\\theta = \\int_0^{{2\\pi}} \\frac{{{R**3}}}{{3}} \\cdot 2 \\, d\\theta$",
                    f"Integrate with respect to $\\theta$: $\\frac{{{2*R**3}}}{{3}} \\cdot 2\\pi = {latex(ans)}$"
                ),
            )
        else:
            # Cone in spherical coordinates
            h = randint(2, 4)
            R = randint(2, 4)
            alpha = atan(Rational(R, h))
            # Volume under cone
            ans = Rational(1, 3) * pi * R**2 * h
            
            return problem(
                question=f"Use spherical coordinates to find the volume of the solid cone with height ${h}$ and base radius ${R}$. Set up as a triple integral over the region where $0 \\le \\rho \\le {h}/\\cos(\\varphi)$, $0 \\le \\varphi \\le \\arctan({R}/{h})$, $0 \\le \\theta \\le 2\\pi$.",
                answer=ans,
                difficulty=(1700, 1850),
                topic="multivariable_calculus/triple_integrals",
                solution=steps(
                    f"The integral is $\\int_0^{{2\\pi}} \\int_0^{{\\arctan({R}/{h})}} \\int_0^{{{h}/\\cos(\\varphi)}} \\rho^2 \\sin(\\varphi) \\, d\\rho \\, d\\varphi \\, d\\theta$",
                    f"This evaluates to the volume of a cone: $\\frac{{1}}{{3}}\\pi r^2 h = \\frac{{1}}{{3}}\\pi \\cdot {R**2} \\cdot {h} = {latex(ans)}$"
                ),
            )
    
    elif problem_type == 2:
        # Cylindrical coordinates (1650-1800)
        R = randint(2, 4)
        h = randint(2, 5)
        
        # Volume of cylinder
        ans = pi * R**2 * h
        
        return problem(
            question=f"Evaluate \\[\\iiint_E r \\, dz \\, dr \\, d\\theta\\] where $E$ is the cylinder ${{x^2 + y^2 \\le {R**2}}}$, ${{0 \\le z \\le {h}}}$ in cylindrical coordinates.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Set up the integral: $\\int_0^{{2\\pi}} \\int_0^{{{R}}} \\int_0^{{{h}}} r \\, dz \\, dr \\, d\\theta$",
                f"Integrate with respect to $z$: $\\int_0^{{2\\pi}} \\int_0^{{{R}}} r \\cdot {h} \\, dr \\, d\\theta$",
                f"Integrate with respect to $r$: $\\int_0^{{2\\pi}} {h} \\cdot \\frac{{r^2}}{{2}}\\Big|_0^{{{R}}} d\\theta = \\int_0^{{2\\pi}} {h} \\cdot \\frac{{{R**2}}}{{2}} \\, d\\theta$",
                f"Integrate with respect to $\\theta$: ${h} \\cdot \\frac{{{R**2}}}{{2}} \\cdot 2\\pi = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # Change of order of integration (1700-1900)
        a = randint(1, 3)
        
        # Reverse engineer a region where changing order simplifies
        ans = Rational(a**4, 12)
        
        return problem(
            question=f"Reverse the order of integration and evaluate: \\[\\int_0^{{{a}}} \\int_y^{{{a}}} \\int_0^x z \\, dz \\, dx \\, dy\\]",
            answer=ans,
            difficulty=(1750, 1900),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"The region is $0 \\le y \\le x \\le {a}$ and $0 \\le z \\le x$",
                f"Reversing order: $0 \\le z \\le x \\le {a}$ and $0 \\le y \\le x$",
                f"New integral: $\\int_0^{{{a}}} \\int_z^{{{a}}} \\int_0^x z \\, dy \\, dx \\, dz$",
                f"Integrate with respect to $y$: $\\int_0^{{{a}}} \\int_z^{{{a}}} zx \\, dx \\, dz$",
                f"Integrate with respect to $x$: $\\int_0^{{{a}}} z \\cdot \\frac{{x^2}}{{2}}\\Big|_z^{{{a}}} dz = \\int_0^{{{a}}} \\frac{{z}}{{2}}({a**2} - z^2) \\, dz$",
                f"Integrate: $\\frac{{1}}{{2}}\\left[{a**2}\\frac{{z^2}}{{2}} - \\frac{{z^4}}{{4}}\\right]_0^{{{a}}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 4:
        # Mass with variable density (1650-1800)
        a = randint(2, 4)
        
        # Density ρ(x,y,z) = z over a box
        ans = Rational(a**4, 2)
        
        return problem(
            question=f"Find the mass of the solid box ${{0 \\le x \\le {a}, 0 \\le y \\le {a}, 0 \\le z \\le {a}}}$ with density function $\\rho(x,y,z) = z$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"Mass $= \\iiint_E \\rho(x,y,z) \\, dV = \\int_0^{{{a}}} \\int_0^{{{a}}} \\int_0^{{{a}}} z \\, dx \\, dy \\, dz$",
                f"Integrate with respect to $x$: $\\int_0^{{{a}}} \\int_0^{{{a}}} {a}z \\, dy \\, dz$",
                f"Integrate with respect to $y$: $\\int_0^{{{a}}} {a**2}z \\, dz$",
                f"Integrate with respect to $z$: ${a**2} \\cdot \\frac{{z^2}}{{2}}\\Big|_0^{{{a}}} = {latex(ans)}$"
            ),
        )
    
    else:
        # Intersection of surfaces (1700-1850)
        R = randint(2, 4)
        
        # Volume between paraboloid and plane
        ans = Rational(pi * R**4, 2)
        
        return problem(
            question=f"Find the volume of the region bounded above by $z = {R**2}$ and below by $z = x^2 + y^2$ using cylindrical coordinates.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="multivariable_calculus/triple_integrals",
            solution=steps(
                f"In cylindrical coordinates: $z = r^2$ (paraboloid) and $z = {R**2}$ (plane)",
                f"They intersect when $r^2 = {R**2}$, so $r = {R}$",
                f"Volume $= \\int_0^{{2\\pi}} \\int_0^{{{R}}} \\int_{{r^2}}^{{{R**2}}} r \\, dz \\, dr \\, d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\int_0^{{{R}}} r({R**2} - r^2) \\, dr \\, d\\theta$",
                f"$= \\int_0^{{2\\pi}} \\left[\\frac{{{R**2}r^2}}{{2}} - \\frac{{r^4}}{{4}}\\right]_0^{{{R}}} d\\theta = \\int_0^{{2\\pi}} \\frac{{{R**4}}}{{4}} \\, d\\theta$",
                f"$= \\frac{{{R**4}}}{{4}} \\cdot 2\\pi = {latex(ans)}$"
            ),
        )

emit(generate())