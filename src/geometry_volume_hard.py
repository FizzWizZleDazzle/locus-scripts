"""
geometry - volume (hard)
Generated: 2026-02-22T04:16:50.515516
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Composite solid volume (cylinder with hemisphere)
        r = randint(3, 8)
        h = randint(8, 15)
        
        cyl_vol = pi * r**2 * h
        hemisphere_vol = Rational(2, 3) * pi * r**3
        total_vol = cyl_vol + hemisphere_vol
        
        return problem(
            question=f"A solid consists of a cylinder with radius ${r}$ and height ${h}$, topped with a hemisphere of the same radius. Find the total volume. Leave your answer in terms of $\\pi$.",
            answer=total_vol,
            difficulty=(1600, 1700),
            topic="geometry/volume",
            solution=steps(
                f"Volume of cylinder: $V_{{\\text{{cyl}}}} = \\pi r^2 h = \\pi ({r})^2 ({h}) = {latex(cyl_vol)}$",
                f"Volume of hemisphere: $V_{{\\text{{hem}}}} = \\frac{{2}}{{3}}\\pi r^3 = \\frac{{2}}{{3}}\\pi ({r})^3 = {latex(hemisphere_vol)}$",
                f"Total volume: $V = {latex(cyl_vol)} + {latex(hemisphere_vol)} = {latex(total_vol)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Cone inscribed in sphere
        R = randint(4, 10)
        h_ratio = choice([Rational(3, 2), Rational(4, 3), Rational(5, 3)])
        h = R * h_ratio
        
        # For cone inscribed in sphere with apex at top of sphere
        # and base as a great circle, height = R and base radius = R
        # But we'll use a cone with height h and find base radius
        r_squared = R**2 - (h - R)**2
        r_squared_simplified = simplify(r_squared)
        
        cone_vol = Rational(1, 3) * pi * r_squared_simplified * h
        cone_vol_simplified = simplify(cone_vol)
        
        return problem(
            question=f"A cone is inscribed in a sphere of radius ${R}$. The apex of the cone is at the top of the sphere, and the height of the cone is ${latex(h)}$. Find the volume of the cone in terms of $\\pi$.",
            answer=cone_vol_simplified,
            difficulty=(1700, 1800),
            topic="geometry/volume",
            solution=steps(
                f"The base of the cone is at distance ${latex(h - R)}$ from the sphere's center.",
                f"Using the sphere equation, the base radius satisfies: $r^2 + ({latex(h - R)})^2 = {R}^2$",
                f"Base radius squared: $r^2 = {R**2} - {latex((h-R)**2)} = {latex(r_squared_simplified)}$",
                f"Cone volume: $V = \\frac{{1}}{{3}}\\pi r^2 h = \\frac{{1}}{{3}}\\pi ({latex(r_squared_simplified)})({latex(h)}) = {latex(cone_vol_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Frustum of pyramid
        a = randint(6, 12)
        b = randint(2, a - 2)
        h = randint(5, 10)
        
        vol = Rational(1, 3) * h * (a**2 + a*b + b**2)
        
        return problem(
            question=f"A frustum of a square pyramid has a lower base with side length ${a}$, an upper base with side length ${b}$, and height ${h}$. Find its volume.",
            answer=vol,
            difficulty=(1650, 1750),
            topic="geometry/volume",
            solution=steps(
                f"Frustum volume formula: $V = \\frac{{1}}{{3}}h(A_1 + \\sqrt{{A_1 A_2}} + A_2)$",
                f"Where $A_1 = {a}^2 = {a**2}$ and $A_2 = {b}^2 = {b**2}$",
                f"Alternative formula for square bases: $V = \\frac{{1}}{{3}}h(a^2 + ab + b^2)$",
                f"$V = \\frac{{1}}{{3}}({h})({a**2} + {a*b} + {b**2}) = \\frac{{1}}{{3}}({h})({a**2 + a*b + b**2}) = {latex(vol)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Sphere with cylindrical hole drilled through
        R = randint(5, 10)
        r = randint(2, R - 2)
        
        # Height of remaining material
        h_half_squared = R**2 - r**2
        h = 2 * sqrt(h_half_squared)
        
        sphere_vol = Rational(4, 3) * pi * R**3
        cyl_vol = pi * r**2 * h
        
        # Actually use the sphere with hole formula
        remaining_vol = Rational(4, 3) * pi * (h_half_squared)**Rational(3, 2)
        remaining_vol_simplified = simplify(remaining_vol)
        
        return problem(
            question=f"A cylindrical hole of radius ${r}$ is drilled completely through the center of a sphere of radius ${R}$. Find the volume of the remaining solid in terms of $\\pi$.",
            answer=remaining_vol_simplified,
            difficulty=(1750, 1850),
            topic="geometry/volume",
            solution=steps(
                f"The height of the remaining band is $h = 2\\sqrt{{{R}^2 - {r}^2}} = 2\\sqrt{{{R**2 - r**2}}} = {latex(h)}$",
                f"Remarkably, volume depends only on height: $V = \\frac{{4}}{{3}}\\pi \\left(\\frac{{h}}{{2}}\\right)^3$",
                f"$V = \\frac{{4}}{{3}}\\pi \\left(\\sqrt{{{R**2 - r**2}}}\\right)^3 = \\frac{{4}}{{3}}\\pi ({R**2 - r**2})^{{3/2}}$",
                f"$V = {latex(remaining_vol_simplified)}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Oblique cylinder or composite volume
        r = randint(3, 7)
        h_vertical = randint(8, 14)
        slant = randint(3, 6)
        
        # Volume of oblique cylinder is still base area times height
        vol = pi * r**2 * h_vertical
        
        actual_height = sqrt(h_vertical**2 + slant**2)
        
        return problem(
            question=f"An oblique cylinder has a circular base of radius ${r}$. The axis of the cylinder makes an angle with the vertical such that the vertical height is ${h_vertical}$ while the horizontal displacement is ${slant}$. Find the volume in terms of $\\pi$.",
            answer=vol,
            difficulty=(1600, 1700),
            topic="geometry/volume",
            solution=steps(
                f"For an oblique cylinder, Cavalieri's principle tells us volume equals base area times perpendicular height.",
                f"The perpendicular (vertical) height is ${h_vertical}$.",
                f"Base area: $A = \\pi r^2 = \\pi ({r})^2 = {latex(pi * r**2)}$",
                f"Volume: $V = A \\cdot h = {latex(pi * r**2)} \\cdot {h_vertical} = {latex(vol)}$"
            ),
            calculator="scientific"
        )

emit(generate())