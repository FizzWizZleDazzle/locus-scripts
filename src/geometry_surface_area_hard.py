"""
geometry - surface_area (hard)
Generated: 2026-02-22T04:15:34.529430
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Composite solid: cylinder with hemisphere on top
        r = randint(3, 8)
        h = randint(8, 15)
        
        cylinder_lateral = 2 * pi * r * h
        cylinder_base = pi * r**2
        hemisphere = 2 * pi * r**2
        
        total_sa = cylinder_lateral + cylinder_base + hemisphere
        total_sa = simplify(total_sa)
        
        return problem(
            question=f"A solid consists of a cylinder with radius ${r}$ cm and height ${h}$ cm, topped with a hemisphere of the same radius. Find the total surface area of the composite solid in terms of $\\pi$.",
            answer=total_sa,
            difficulty=(1650, 1750),
            topic="geometry/surface_area",
            solution=steps(
                f"The surface area consists of three parts:",
                f"1. Lateral surface of cylinder: $2\\pi rh = 2\\pi({r})({h}) = {latex(cylinder_lateral)}$ cm²",
                f"2. Base of cylinder: $\\pi r^2 = \\pi({r})^2 = {latex(cylinder_base)}$ cm²",
                f"3. Hemisphere (half of sphere): $2\\pi r^2 = 2\\pi({r})^2 = {latex(hemisphere)}$ cm²",
                f"Total surface area = ${latex(cylinder_lateral)} + {latex(cylinder_base)} + {latex(hemisphere)} = {latex(total_sa)}$ cm²"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Cone with slant height given, find surface area
        r = randint(5, 12)
        l = randint(r + 3, r + 10)  # slant height must be > radius
        
        lateral_sa = pi * r * l
        base_sa = pi * r**2
        total_sa = simplify(lateral_sa + base_sa)
        
        return problem(
            question=f"A cone has a base radius of ${r}$ units and a slant height of ${l}$ units. Find the total surface area of the cone in terms of $\\pi$.",
            answer=total_sa,
            difficulty=(1600, 1700),
            topic="geometry/surface_area",
            solution=steps(
                f"Total surface area of cone = lateral area + base area",
                f"Lateral area = $\\pi r \\ell = \\pi({r})({l}) = {latex(lateral_sa)}$ square units",
                f"Base area = $\\pi r^2 = \\pi({r})^2 = {latex(base_sa)}$ square units",
                f"Total surface area = ${latex(lateral_sa)} + {latex(base_sa)} = {latex(total_sa)}$ square units"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Rectangular prism with constraint: surface area given, find dimension
        l = randint(6, 12)
        w = randint(4, 10)
        h = randint(5, 10)
        
        sa_value = 2 * (l * w + l * h + w * h)
        
        # Now present it as finding h given SA, l, and w
        return problem(
            question=f"A rectangular prism has length ${l}$ cm, width ${w}$ cm, and total surface area ${sa_value}$ cm². Find the height of the prism.",
            answer=h,
            difficulty=(1650, 1750),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area formula: $SA = 2(lw + lh + wh)$",
                f"Substitute known values: ${sa_value} = 2({l} \\cdot {w} + {l}h + {w}h)$",
                f"${sa_value} = 2({l * w} + {l}h + {w}h)$",
                f"${sa_value} = {2 * l * w} + {2 * l}h + {2 * w}h$",
                f"${sa_value - 2 * l * w} = {2 * l + 2 * w}h$",
                f"$h = \\frac{{{sa_value - 2 * l * w}}}{{{2 * l + 2 * w}}} = {h}$ cm"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Square pyramid with given base side and slant height
        s = randint(6, 14)
        l = randint(s, s + 8)  # slant height
        
        base_area = s**2
        lateral_area = 2 * s * l  # 4 triangles, each (1/2)*s*l
        total_sa = base_area + lateral_area
        
        return problem(
            question=f"A square pyramid has a base with side length ${s}$ meters and a slant height of ${l}$ meters. Find the total surface area of the pyramid.",
            answer=total_sa,
            difficulty=(1650, 1750),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area = base area + lateral area",
                f"Base area = $s^2 = {s}^2 = {base_area}$ m²",
                f"The pyramid has 4 congruent triangular faces",
                f"Each triangle has area $\\frac{{1}}{{2}} \\times \\text{{base}} \\times \\text{{slant height}} = \\frac{{1}}{{2}} \\times {s} \\times {l} = {Rational(s * l, 2)}$ m²",
                f"Lateral area = $4 \\times {Rational(s * l, 2)} = {lateral_area}$ m²",
                f"Total surface area = ${base_area} + {lateral_area} = {total_sa}$ m²"
            ),
            calculator="scientific"
        )
    
    else:  # problem_type == 5
        # Sphere with changed radius - compare surface areas
        r1 = randint(3, 8)
        scale = choice([2, 3])
        r2 = r1 * scale
        
        sa1 = 4 * pi * r1**2
        sa2 = 4 * pi * r2**2
        ratio = simplify(sa2 / sa1)
        
        return problem(
            question=f"A sphere has radius ${r1}$ cm. If the radius is increased to ${r2}$ cm, by what factor does the surface area increase?",
            answer=ratio,
            difficulty=(1700, 1800),
            topic="geometry/surface_area",
            solution=steps(
                f"Original surface area: $SA_1 = 4\\pi r_1^2 = 4\\pi({r1})^2 = {latex(sa1)}$ cm²",
                f"New surface area: $SA_2 = 4\\pi r_2^2 = 4\\pi({r2})^2 = {latex(sa2)}$ cm²",
                f"Factor of increase = $\\frac{{SA_2}}{{SA_1}} = \\frac{{{latex(sa2)}}}{{{latex(sa1)}}} = {latex(ratio)}$",
                f"When radius is multiplied by ${scale}$, surface area is multiplied by ${scale}^2 = {scale**2}$"
            ),
            calculator="scientific"
        )

emit(generate())