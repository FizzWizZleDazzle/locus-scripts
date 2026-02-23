"""
geometry - surface_area (hard)
Generated: 2026-02-22T04:15:34.529430
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Composite: cylinder + hemisphere
        r = randint(2, 10)
        h = randint(4, 15)
        lateral = 2*pi*r*h
        base = pi*r**2
        hemi = 2*pi*r**2
        total = simplify(lateral + base + hemi)

        return problem(
            question=f"A composite solid consists of a cylinder (radius ${r}$, height ${h}$) topped with a hemisphere of the same radius. Find the total surface area in terms of $\\pi$.",
            answer=total,
            difficulty=(1650, 1750),
            topic="geometry/surface_area",
            solution=steps(
                f"Cylinder lateral: $2\\pi rh = 2\\pi({r})({h}) = {2*r*h}\\pi$",
                f"Cylinder base: $\\pi r^2 = {r**2}\\pi$",
                f"Hemisphere curved: $2\\pi r^2 = {2*r**2}\\pi$",
                f"Total $= {latex(total)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Cone: given slant height (no computation needed)
        r = randint(3, 12)
        l = randint(r+2, r+12)
        lateral = pi*r*l
        base = pi*r**2
        total = simplify(lateral + base)

        return problem(
            question=f"A cone has base radius ${r}$ and slant height ${l}$. Find the total surface area in terms of $\\pi$.",
            answer=total,
            difficulty=(1600, 1700),
            topic="geometry/surface_area",
            solution=steps(
                f"Lateral area $= \\pi r l = \\pi({r})({l}) = {r*l}\\pi$",
                f"Base area $= \\pi r^2 = {r**2}\\pi$",
                f"Total $= ({r*l} + {r**2})\\pi = {latex(total)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Square pyramid
        s = randint(4, 14)
        l = randint(s, s+10)
        base_area = s**2
        lateral_area = 2*s*l
        total = base_area + lateral_area

        return problem(
            question=f"A square pyramid has base side length ${s}$ and slant height ${l}$. Find the total surface area.",
            answer=total,
            difficulty=(1650, 1750),
            topic="geometry/surface_area",
            solution=steps(
                f"Base area $= s^2 = {s}^2 = {base_area}$",
                f"4 triangular faces, each area $= \\frac{{1}}{{2}} \\cdot {s} \\cdot {l} = {Rational(s*l,2)}$",
                f"Lateral area $= 4 \\cdot {Rational(s*l,2)} = {lateral_area}$",
                f"Total $= {base_area} + {lateral_area} = {total}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Sphere scale factor / area ratio
        r1 = randint(2, 8)
        scale = randint(2, 5)
        r2 = r1 * scale
        sa1 = 4*pi*r1**2
        sa2 = 4*pi*r2**2
        ratio = simplify(sa2/sa1)

        return problem(
            question=f"A sphere has radius ${r1}$. The radius is increased to ${r2}$. By what factor does the surface area increase?",
            answer=ratio,
            difficulty=(1700, 1800),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA_1 = 4\\pi({r1})^2 = {4*r1**2}\\pi$",
                f"$SA_2 = 4\\pi({r2})^2 = {4*r2**2}\\pi$",
                f"Factor $= \\frac{{SA_2}}{{SA_1}} = \\frac{{{4*r2**2}}}{{{4*r1**2}}} = {latex(ratio)}$",
                f"(Radius scaled by ${scale}$ → area scaled by ${scale}^2 = {scale**2}$)"
            ),
            calculator="scientific"
        )

    elif problem_type == 5:
        # Rectangular prism: find dimension given surface area
        l = randint(3, 14)
        w = randint(3, 14)
        h = randint(3, 14)
        sa = 2*(l*w + l*h + w*h)

        # Vary which dimension to find
        which = choice(['l', 'w', 'h'])
        if which == 'h':
            given1, given2, unknown = l, w, h
            q = f"A rectangular prism has length ${given1}$, width ${given2}$, and surface area ${sa}$. Find the height."
            sol = steps(
                f"$SA = 2(lw+lh+wh) \\Rightarrow {sa} = 2({given1}\\cdot{given2} + {given1}h + {given2}h)$",
                f"${sa} = {2*given1*given2} + {2*(given1+given2)}h$",
                f"$h = \\frac{{{sa - 2*given1*given2}}}{{{2*(given1+given2)}}} = {unknown}$"
            )
        elif which == 'w':
            given1, given2, unknown = l, h, w
            q = f"A rectangular prism has length ${given1}$, height ${given2}$, and surface area ${sa}$. Find the width."
            sol = steps(
                f"$SA = 2(lw+lh+wh) \\Rightarrow {sa} = 2({given1}w + {given1}\\cdot{given2} + w\\cdot{given2})$",
                f"${sa} = {2*given1*given2} + {2*(given1+given2)}w$",
                f"$w = \\frac{{{sa - 2*given1*given2}}}{{{2*(given1+given2)}}} = {unknown}$"
            )
        else:
            given1, given2, unknown = w, h, l
            q = f"A rectangular prism has width ${given1}$, height ${given2}$, and surface area ${sa}$. Find the length."
            sol = steps(
                f"$SA = 2(lw+lh+wh) \\Rightarrow {sa} = 2(l\\cdot{given1} + l\\cdot{given2} + {given1}\\cdot{given2})$",
                f"${sa} = {2*given1*given2} + {2*(given1+given2)}l$",
                f"$l = \\frac{{{sa - 2*given1*given2}}}{{{2*(given1+given2)}}} = {unknown}$"
            )

        return problem(
            question=q,
            answer=unknown,
            difficulty=(1650, 1750),
            topic="geometry/surface_area",
            solution=sol,
            calculator="scientific"
        )

    else:
        # Composite: rectangular prism with cylindrical hole (lateral only)
        l = randint(5, 12)
        w = randint(5, 12)
        h = randint(5, 12)
        r = randint(1, min(l,w)//2)
        # SA = box outer SA - 2 circles (top+bottom of hole) + cylinder inner lateral
        box_sa = 2*(l*w + l*h + w*h)
        hole_circles = 2*pi*r**2
        inner_lateral = 2*pi*r*h
        total = simplify(box_sa - hole_circles + inner_lateral)

        return problem(
            question=f"A rectangular box with dimensions ${l} \\times {w} \\times {h}$ has a cylindrical hole of radius ${r}$ drilled completely through the height. Find the total surface area of the resulting solid in terms of $\\pi$.",
            answer=total,
            difficulty=(1750, 1900),
            topic="geometry/surface_area",
            solution=steps(
                f"Start with the box surface area: $SA_{{box}} = 2({l}\\cdot{w}+{l}\\cdot{h}+{w}\\cdot{h}) = {box_sa}$",
                f"Subtract the two circular openings (top and bottom): $-2\\pi r^2 = -{2*r**2}\\pi$",
                f"Add the inner cylindrical surface: $+2\\pi rh = {2*r*h}\\pi$",
                f"Total $= {box_sa} - {2*r**2}\\pi + {2*r*h}\\pi = {latex(total)}$"
            ),
            calculator="scientific"
        )

emit(generate())
