"""
geometry - surface_area (medium)
Generated: 2026-02-22T04:15:08.189892
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['rectangular_prism', 'cylinder', 'sphere', 'cube', 'cone'])
    
    if problem_type == 'rectangular_prism':
        length = randint(3, 12)
        width = randint(3, 12)
        height = randint(3, 12)
        
        surface_area = 2 * (length * width + length * height + width * height)
        
        d = Diagram(width=300, height=250, padding=40)
        
        # Draw a 3D rectangular prism in isometric view
        base_x, base_y = 50, 50
        l_scale, w_scale, h_scale = 40, 25, 35
        
        # Front face vertices
        p1 = (base_x, base_y)
        p2 = (base_x + l_scale, base_y)
        p3 = (base_x + l_scale, base_y + h_scale)
        p4 = (base_x, base_y + h_scale)
        
        # Back face vertices (offset for depth)
        p5 = (base_x + w_scale, base_y + w_scale)
        p6 = (base_x + l_scale + w_scale, base_y + w_scale)
        p7 = (base_x + l_scale + w_scale, base_y + h_scale + w_scale)
        p8 = (base_x + w_scale, base_y + h_scale + w_scale)
        
        # Draw visible edges
        d.polygon([p1, p2, p3, p4], fill="none")  # Front face
        d.polygon([p5, p6, p7, p8], fill="none")  # Back face
        d.line(p2, p6)  # Right edge
        d.line(p3, p7)  # Top right edge
        d.line(p4, p8)  # Top left edge
        
        # Labels
        d.segment_label(p1, p2, str(length))
        d.segment_label(p2, p3, str(height))
        d.segment_label(p2, p6, str(width))
        
        return problem(
            question=f"Find the surface area of a rectangular prism with length ${length}$, width ${width}$, and height ${height}$.",
            answer=surface_area,
            difficulty=(1300, 1450),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area formula: $SA = 2(lw + lh + wh)$",
                f"$SA = 2({length} \\cdot {width} + {length} \\cdot {height} + {width} \\cdot {height})$",
                f"$SA = 2({length * width} + {length * height} + {width * height})$",
                f"$SA = 2({length * width + length * height + width * height})$",
                f"$SA = {surface_area}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 'cylinder':
        radius = randint(2, 10)
        height = randint(4, 15)
        
        surface_area = 2 * pi * radius * (radius + height)
        
        d = Diagram(width=250, height=300, padding=40)
        
        center_x, base_y = 125, 80
        top_y = base_y + height * 8
        
        # Draw cylinder
        d.circle((center_x, base_y), radius * 8, fill="none")
        d.ellipse(center_x, top_y, radius * 8, radius * 3)
        d.line((center_x - radius * 8, base_y), (center_x - radius * 8, top_y))
        d.line((center_x + radius * 8, base_y), (center_x + radius * 8, top_y))
        
        # Labels
        d.segment_label((center_x, base_y), (center_x + radius * 8, base_y), f"r={radius}")
        d.segment_label((center_x + radius * 8 + 10, base_y), (center_x + radius * 8 + 10, top_y), f"h={height}")
        
        return problem(
            question=f"Find the surface area of a cylinder with radius ${radius}$ and height ${height}$. Express your answer in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1350, 1500),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area formula: $SA = 2\\pi r(r + h)$",
                f"$SA = 2\\pi({radius})({radius} + {height})$",
                f"$SA = 2\\pi({radius})({radius + height})$",
                f"$SA = {2 * radius * (radius + height)}\\pi$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'sphere':
        radius = randint(3, 12)
        
        surface_area = 4 * pi * radius**2
        
        d = Diagram(width=250, height=250, padding=40)
        
        center = (125, 125)
        d.circle(center, radius * 10, fill="none")
        d.ellipse(center[0], center[1], radius * 10, radius * 3)
        d.line((center[0], center[1] - radius * 10), (center[0], center[1] + radius * 10), dashed=True)
        d.segment_label(center, (center[0] + radius * 10, center[1]), f"r={radius}")
        
        return problem(
            question=f"Find the surface area of a sphere with radius ${radius}$. Express your answer in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1300, 1450),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area formula: $SA = 4\\pi r^2$",
                f"$SA = 4\\pi({radius})^2$",
                f"$SA = 4\\pi({radius**2})$",
                f"$SA = {4 * radius**2}\\pi$"
            ),
            image=d.render()
        )
    
    elif problem_type == 'cube':
        side = randint(3, 15)
        
        surface_area = 6 * side**2
        
        d = Diagram(width=250, height=250, padding=40)
        
        base_x, base_y = 60, 60
        s = 40
        
        # Front face
        p1 = (base_x, base_y)
        p2 = (base_x + s, base_y)
        p3 = (base_x + s, base_y + s)
        p4 = (base_x, base_y + s)
        
        # Back face
        p5 = (base_x + s/2, base_y + s/2)
        p6 = (base_x + s + s/2, base_y + s/2)
        p7 = (base_x + s + s/2, base_y + s + s/2)
        p8 = (base_x + s/2, base_y + s + s/2)
        
        d.polygon([p1, p2, p3, p4], fill="none")
        d.polygon([p5, p6, p7, p8], fill="none")
        d.line(p2, p6)
        d.line(p3, p7)
        d.line(p4, p8)
        
        d.segment_label(p1, p2, f"s={side}")
        
        return problem(
            question=f"Find the surface area of a cube with side length ${side}$.",
            answer=surface_area,
            difficulty=(1300, 1400),
            topic="geometry/surface_area",
            solution=steps(
                f"Surface area formula: $SA = 6s^2$",
                f"$SA = 6({side})^2$",
                f"$SA = 6({side**2})$",
                f"$SA = {surface_area}$"
            ),
            image=d.render()
        )
    
    else:  # cone
        radius = randint(3, 10)
        height = randint(5, 15)
        slant_height = sqrt(radius**2 + height**2)
        
        surface_area = pi * radius * (radius + slant_height)
        
        d = Diagram(width=250, height=300, padding=40)
        
        apex = (125, 50)
        base_center = (125, 200)
        
        d.circle(base_center, radius * 8, fill="none")
        d.line(apex, (base_center[0] - radius * 8, base_center[1]))
        d.line(apex, (base_center[0] + radius * 8, base_center[1]))
        
        d.segment_label(base_center, (base_center[0] + radius * 8, base_center[1]), f"r={radius}")
        d.segment_label(apex, (base_center[0] + radius * 8, base_center[1]), f"l={latex(slant_height)}")
        
        return problem(
            question=f"Find the surface area of a cone with radius ${radius}$ and height ${height}$. Express your answer in terms of $\\pi$.",
            answer=surface_area,
            difficulty=(1450, 1600),
            topic="geometry/surface_area",
            solution=steps(
                f"First find slant height: $l = \\sqrt{{r^2 + h^2}} = \\sqrt{{{radius}^2 + {height}^2}} = \\sqrt{{{radius**2 + height**2}}} = {latex(slant_height)}$",
                f"Surface area formula: $SA = \\pi r(r + l)$",
                f"$SA = \\pi({radius})({radius} + {latex(slant_height)})$",
                f"$SA = {latex(surface_area)}$"
            ),
            image=d.render()
        )

emit(generate())