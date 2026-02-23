"""
geometry - surface_area (medium)
Generated: 2026-02-22T04:15:08.189892
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['rectangular_prism', 'cylinder', 'sphere', 'cube', 'cone', 'find_dimension'])

    if problem_type == 'rectangular_prism':
        length = randint(2, 15)
        width = randint(2, 15)
        height = randint(2, 15)
        surface_area = 2*(length*width + length*height + width*height)

        d = Diagram(width=300, height=250, padding=40)
        bx, by = 50, 50
        l_s, w_s, h_s = 40, 25, 35
        p1=(bx,by); p2=(bx+l_s,by); p3=(bx+l_s,by+h_s); p4=(bx,by+h_s)
        p5=(bx+w_s,by+w_s); p6=(bx+l_s+w_s,by+w_s); p7=(bx+l_s+w_s,by+h_s+w_s); p8=(bx+w_s,by+h_s+w_s)
        d.polygon([p1,p2,p3,p4],fill="none")
        d.polygon([p5,p6,p7,p8],fill="none")
        d.line(p2,p6); d.line(p3,p7); d.line(p4,p8)
        d.segment_label(p1,p2,str(length))
        d.segment_label(p2,p3,str(height))
        d.segment_label(p2,p6,str(width))

        return problem(
            question=f"Find the surface area of a rectangular prism with length ${length}$, width ${width}$, and height ${height}$.",
            answer=surface_area,
            difficulty=(1300, 1450),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 2(lw + lh + wh)$",
                f"$= 2({length}\\cdot{width} + {length}\\cdot{height} + {width}\\cdot{height})$",
                f"$= 2({length*width} + {length*height} + {width*height}) = {surface_area}$"
            ),
            image=d.render(),
            calculator="scientific"
        )

    elif problem_type == 'cylinder':
        radius = randint(2, 12)
        height = randint(3, 15)
        surface_area = 2*pi*radius*(radius+height)

        return problem(
            question=f"Find the surface area of a cylinder with radius ${radius}$ and height ${height}$. Express in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1350, 1500),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 2\\pi r(r+h) = 2\\pi({radius})({radius}+{height})$",
                f"$= 2\\pi({radius})({radius+height}) = {2*radius*(radius+height)}\\pi$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'sphere':
        radius = randint(2, 15)
        surface_area = 4*pi*radius**2

        return problem(
            question=f"Find the surface area of a sphere with radius ${radius}$. Express in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1300, 1450),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 4\\pi r^2 = 4\\pi({radius})^2 = 4\\pi({radius**2}) = {4*radius**2}\\pi$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'cube':
        side = randint(2, 15)
        surface_area = 6*side**2

        return problem(
            question=f"Find the surface area of a cube with side length ${side}$.",
            answer=surface_area,
            difficulty=(1300, 1400),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 6s^2 = 6({side})^2 = 6({side**2}) = {surface_area}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 'cone':
        radius = randint(2, 12)
        height = randint(3, 15)
        slant = simplify(sqrt(radius**2 + height**2))
        surface_area = simplify(pi*radius*(radius + slant))

        return problem(
            question=f"Find the surface area of a cone with base radius ${radius}$ and height ${height}$. Express in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1450, 1600),
            topic="geometry/surface_area",
            solution=steps(
                f"Slant height: $l = \\sqrt{{r^2+h^2}} = \\sqrt{{{radius}^2+{height}^2}} = {latex(slant)}$",
                f"$SA = \\pi r(r+l) = \\pi({radius})({radius}+{latex(slant)}) = {latex(surface_area)}$"
            ),
            calculator="scientific"
        )

    else:  # find_dimension
        # Given SA of rectangular prism, find missing dimension
        l = randint(3, 12)
        w = randint(3, 12)
        h = randint(3, 12)
        sa = 2*(l*w + l*h + w*h)

        # Present as solving for h given l, w, sa
        return problem(
            question=f"A rectangular prism has length ${l}$, width ${w}$, and total surface area ${sa}$. Find the height.",
            answer=h,
            difficulty=(1450, 1600),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 2(lw + lh + wh)$",
                f"${sa} = 2({l}\\cdot{w} + {l}h + {w}h) = {2*l*w} + {2*l+2*w}h$",
                f"${sa - 2*l*w} = {2*l+2*w}h$",
                f"$h = \\frac{{{sa-2*l*w}}}{{{2*l+2*w}}} = {h}$"
            ),
            calculator="scientific"
        )

emit(generate())
