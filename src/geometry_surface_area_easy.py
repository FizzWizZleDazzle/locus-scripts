"""
geometry - surface_area (easy)
Generated: 2026-02-22T04:14:37.673488
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Rectangular prism
        length = randint(2, 15)
        width = randint(2, 15)
        height = randint(2, 15)
        surface_area = 2 * (length*width + length*height + width*height)

        d = Diagram(width=300, height=250, padding=40)
        d.polygon([(0,0),(length*15,0),(length*15,height*15),(0,height*15)], labels=['','','',''])
        offset = width * 5
        d.polygon([(0,height*15),(length*15,height*15),(length*15+offset,height*15+offset),(offset,height*15+offset)], labels=['','','',''])
        d.polygon([(length*15,0),(length*15+offset,offset),(length*15+offset,height*15+offset),(length*15,height*15)], labels=['','','',''])
        d.text(length*7.5,-10,f"{length}")
        d.text(-15,height*7.5,f"{height}")
        d.text(length*15+offset+10,height*7.5+offset//2,f"{width}")

        return problem(
            question=f"Find the surface area of a rectangular prism with length ${length}$, width ${width}$, and height ${height}$.",
            answer=surface_area,
            difficulty=(1000, 1100),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 2(lw + lh + wh)$",
                f"$= 2({length} \\cdot {width} + {length} \\cdot {height} + {width} \\cdot {height})$",
                f"$= 2({length*width} + {length*height} + {width*height})$",
                f"$= 2 \\cdot {length*width + length*height + width*height} = {surface_area}$"
            ),
            image=d.render(),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Cube
        side = randint(2, 15)
        surface_area = 6 * side**2

        d = Diagram(width=300, height=250, padding=40)
        s = side * 15
        offset = s // 2
        d.polygon([(0,0),(s,0),(s,s),(0,s)], labels=['','','',''])
        d.polygon([(0,s),(s,s),(s+offset,s+offset),(offset,s+offset)], labels=['','','',''])
        d.polygon([(s,0),(s+offset,offset),(s+offset,s+offset),(s,s)], labels=['','','',''])
        d.text(s/2,-10,f"{side}")

        return problem(
            question=f"Find the surface area of a cube with side length ${side}$.",
            answer=surface_area,
            difficulty=(1050, 1150),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 6s^2 = 6 \\cdot {side}^2 = 6 \\cdot {side**2} = {surface_area}$"
            ),
            image=d.render(),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Cylinder (terms of pi)
        radius = randint(2, 12)
        height = randint(2, 15)
        surface_area = 2 * pi * radius * (radius + height)

        return problem(
            question=f"Find the surface area of a cylinder with radius ${radius}$ and height ${height}$. Leave your answer in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1200, 1300),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 2\\pi r(r + h) = 2\\pi \\cdot {radius} \\cdot ({radius} + {height})$",
                f"$= 2\\pi \\cdot {radius} \\cdot {radius + height} = {2*radius*(radius+height)}\\pi$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Triangular prism (given all face areas)
        tri_base_area = randint(4, 25)
        face1 = randint(8, 40)
        face2 = randint(8, 40)
        face3 = randint(8, 40)
        total = 2 * tri_base_area + face1 + face2 + face3

        return problem(
            question=f"A triangular prism has two triangular bases each with area ${tri_base_area}$. The three rectangular faces have areas ${face1}$, ${face2}$, and ${face3}$. Find the total surface area.",
            answer=total,
            difficulty=(1100, 1200),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 2 \\cdot \\text{{base area}} + \\text{{lateral faces}}$",
                f"$= 2 \\cdot {tri_base_area} + {face1} + {face2} + {face3}$",
                f"$= {2*tri_base_area} + {face1+face2+face3} = {total}$"
            ),
            calculator="scientific"
        )

    else:
        # Sphere (terms of pi)
        radius = randint(2, 12)
        surface_area = 4 * pi * radius**2

        return problem(
            question=f"Find the surface area of a sphere with radius ${radius}$. Leave your answer in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1150, 1250),
            topic="geometry/surface_area",
            solution=steps(
                f"$SA = 4\\pi r^2 = 4\\pi \\cdot {radius}^2 = {4*radius**2}\\pi$"
            ),
            calculator="scientific"
        )

emit(generate())
