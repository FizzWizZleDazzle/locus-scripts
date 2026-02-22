"""
geometry - surface_area (easy)
Generated: 2026-02-22T04:14:37.673488
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Rectangular prism surface area - simplest case
        length = randint(3, 10)
        width = randint(3, 10)
        height = randint(3, 10)
        
        surface_area = 2 * (length * width + length * height + width * height)
        
        d = Diagram(width=300, height=250, padding=40)
        # Draw a simple 3D rectangular prism
        # Front face
        d.polygon([(0, 0), (length*15, 0), (length*15, height*15), (0, height*15)], 
                  labels=['', '', '', ''])
        # Top face (parallelogram for perspective)
        offset = width * 5
        d.polygon([(0, height*15), (length*15, height*15), 
                   (length*15 + offset, height*15 + offset), (offset, height*15 + offset)],
                  labels=['', '', '', ''])
        # Right face
        d.polygon([(length*15, 0), (length*15 + offset, offset), 
                   (length*15 + offset, height*15 + offset), (length*15, height*15)],
                  labels=['', '', '', ''])
        
        # Labels
        d.text(length*7.5, -10, f"{length}")
        d.text(-15, height*7.5, f"{height}")
        d.text(length*15 + offset + 10, height*7.5 + offset/2, f"{width}")
        
        return problem(
            question=f"Find the surface area of a rectangular prism with length ${length}$, width ${width}$, and height ${height}$.",
            answer=surface_area,
            difficulty=(1000, 1100),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area of rectangular prism = $2(lw + lh + wh)$",
                f"$= 2({length} \\cdot {width} + {length} \\cdot {height} + {width} \\cdot {height})$",
                f"$= 2({length * width} + {length * height} + {width * height})$",
                f"$= 2({length * width + length * height + width * height})$",
                f"$= {surface_area}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Cube surface area
        side = randint(3, 12)
        surface_area = 6 * side * side
        
        d = Diagram(width=300, height=250, padding=40)
        # Draw cube
        s = side * 15
        offset = s // 2
        d.polygon([(0, 0), (s, 0), (s, s), (0, s)], labels=['', '', '', ''])
        d.polygon([(0, s), (s, s), (s + offset, s + offset), (offset, s + offset)], labels=['', '', '', ''])
        d.polygon([(s, 0), (s + offset, offset), (s + offset, s + offset), (s, s)], labels=['', '', '', ''])
        d.text(s/2, -10, f"{side}")
        
        return problem(
            question=f"Find the surface area of a cube with side length ${side}$.",
            answer=surface_area,
            difficulty=(1050, 1150),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area of cube = $6s^2$",
                f"$= 6 \\cdot {side}^2$",
                f"$= 6 \\cdot {side * side}$",
                f"$= {surface_area}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Cylinder surface area
        radius = randint(2, 8)
        height = randint(4, 12)
        
        # Answer as expression with pi
        surface_area = 2 * pi * radius * (radius + height)
        
        return problem(
            question=f"Find the surface area of a cylinder with radius ${radius}$ and height ${height}$. Leave your answer in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1200, 1300),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area of cylinder = $2\\pi r(r + h)$",
                f"$= 2\\pi \\cdot {radius} \\cdot ({radius} + {height})$",
                f"$= 2\\pi \\cdot {radius} \\cdot {radius + height}$",
                f"$= {latex(surface_area)}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Surface area of a prism given individual face areas
        # Two triangular faces and three rectangular faces
        base = randint(3, 8)
        face1_area = randint(10, 30)
        face2_area = randint(10, 30)
        face3_area = randint(10, 30)
        
        total_surface_area = 2 * base + face1_area + face2_area + face3_area
        
        return problem(
            question=f"A triangular prism has two triangular bases, each with area ${base}$. The three rectangular faces have areas ${face1_area}$, ${face2_area}$, and ${face3_area}$. Find the total surface area.",
            answer=total_surface_area,
            difficulty=(1100, 1200),
            topic="geometry/surface_area",
            solution=steps(
                f"Total surface area = area of both bases + area of all lateral faces",
                f"$= 2 \\cdot {base} + {face1_area} + {face2_area} + {face3_area}$",
                f"$= {2 * base} + {face1_area + face2_area + face3_area}$",
                f"$= {total_surface_area}$"
            ),
            calculator="scientific"
        )

emit(generate())