"""
geometry - volume (medium)
Generated: 2026-02-22T04:16:20.180529
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = choice(['rectangular_prism', 'cylinder', 'sphere', 'cone', 'composite'])
    
    if problem_type == 'rectangular_prism':
        length = randint(3, 12)
        width = randint(3, 12)
        height = randint(3, 12)
        
        volume = length * width * height
        
        d = Diagram(width=300, height=250, padding=40)
        # Draw a 3D rectangular prism
        base_x, base_y = 0, 0
        w_offset = 2
        h_offset = 2
        
        # Bottom face
        bottom = [(base_x, base_y), (base_x + length, base_y), 
                  (base_x + length + w_offset, base_y + w_offset), 
                  (base_x + w_offset, base_y + w_offset)]
        d.polygon(bottom, fill="lightblue")
        
        # Front face
        front = [(base_x, base_y), (base_x + length, base_y),
                 (base_x + length, base_y + height), (base_x, base_y + height)]
        d.polygon(front, fill="lightcyan")
        
        # Side face
        side = [(base_x + length, base_y), (base_x + length + w_offset, base_y + w_offset),
                (base_x + length + w_offset, base_y + height + w_offset), 
                (base_x + length, base_y + height)]
        d.polygon(side, fill="lightsteelblue")
        
        # Labels
        d.text(base_x + length/2, base_y - 1, f"{length}")
        d.text(base_x + length + w_offset + 1, base_y + height/2, f"{width}")
        d.text(base_x - 1, base_y + height/2, f"{height}")
        
        return problem(
            question=f"Find the volume of a rectangular prism with length ${length}$, width ${width}$, and height ${height}$.",
            answer=volume,
            difficulty=(1200, 1350),
            topic="geometry/volume",
            solution=steps(
                f"Volume of rectangular prism: $V = l \\times w \\times h$",
                f"$V = {length} \\times {width} \\times {height}$",
                f"$V = {volume}$ cubic units"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 'cylinder':
        radius = randint(2, 10)
        height = randint(4, 15)
        
        # Use exact form with pi
        volume_expr = pi * radius**2 * height
        
        d = Diagram(width=300, height=280, padding=40)
        # Draw cylinder
        center_x, base_y = 5, 2
        top_y = base_y + height
        
        # Top ellipse
        d.arc((center_x, top_y), radius, 0, 180)
        d.line((center_x - radius, top_y), (center_x - radius, base_y))
        d.line((center_x + radius, top_y), (center_x + radius, base_y))
        d.arc((center_x, base_y), radius, 180, 360)
        d.line((center_x - radius, base_y), (center_x + radius, base_y), dashed=True)
        
        # Labels
        d.text(center_x + radius + 1.5, base_y + height/2, f"h = {height}")
        d.text(center_x, base_y - 1.5, f"r = {radius}")
        d.line((center_x, base_y), (center_x + radius, base_y))
        
        return problem(
            question=f"Find the volume of a cylinder with radius ${radius}$ and height ${height}$. Express your answer in terms of $\\pi$.",
            answer=volume_expr,
            difficulty=(1300, 1450),
            topic="geometry/volume",
            solution=steps(
                f"Volume of cylinder: $V = \\pi r^2 h$",
                f"$V = \\pi \\cdot {radius}^2 \\cdot {height}$",
                f"$V = \\pi \\cdot {radius**2} \\cdot {height}$",
                f"$V = {radius**2 * height}\\pi$ cubic units"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 'sphere':
        radius = randint(3, 9)
        
        # Use exact form with pi
        volume_expr = Rational(4, 3) * pi * radius**3
        
        d = Diagram(width=300, height=280, padding=40)
        center = (7, 7)
        d.circle(center, radius)
        d.line(center, (center[0] + radius, center[1]))
        d.text(center[0] + radius/2, center[1] - 0.8, f"r = {radius}")
        
        return problem(
            question=f"Find the volume of a sphere with radius ${radius}$. Express your answer in terms of $\\pi$.",
            answer=volume_expr,
            difficulty=(1350, 1500),
            topic="geometry/volume",
            solution=steps(
                f"Volume of sphere: $V = \\frac{{4}}{{3}}\\pi r^3$",
                f"$V = \\frac{{4}}{{3}}\\pi \\cdot {radius}^3$",
                f"$V = \\frac{{4}}{{3}}\\pi \\cdot {radius**3}$",
                f"$V = \\frac{{{4 * radius**3}}}{{3}}\\pi$ cubic units",
                f"$V = {latex(volume_expr)}$ cubic units"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 'cone':
        radius = randint(3, 10)
        height = randint(5, 15)
        
        volume_expr = Rational(1, 3) * pi * radius**2 * height
        
        d = Diagram(width=300, height=280, padding=40)
        apex = (7, 15)
        base_center = (7, 2)
        
        # Draw cone
        d.line((base_center[0] - radius, base_center[1]), apex)
        d.line((base_center[0] + radius, base_center[1]), apex)
        d.arc(base_center, radius, 180, 360)
        d.line((base_center[0] - radius, base_center[1]), (base_center[0] + radius, base_center[1]), dashed=True)
        d.line(base_center, apex, dashed=True)
        
        # Labels
        d.text(base_center[0] - 1.5, (base_center[1] + apex[1])/2, f"h = {height}")
        d.text(base_center[0] + radius/2, base_center[1] - 1, f"r = {radius}")
        d.line(base_center, (base_center[0] + radius, base_center[1]))
        
        return problem(
            question=f"Find the volume of a cone with radius ${radius}$ and height ${height}$. Express your answer in terms of $\\pi$.",
            answer=volume_expr,
            difficulty=(1400, 1550),
            topic="geometry/volume",
            solution=steps(
                f"Volume of cone: $V = \\frac{{1}}{{3}}\\pi r^2 h$",
                f"$V = \\frac{{1}}{{3}}\\pi \\cdot {radius}^2 \\cdot {height}$",
                f"$V = \\frac{{1}}{{3}}\\pi \\cdot {radius**2} \\cdot {height}$",
                f"$V = \\frac{{{radius**2 * height}}}{{3}}\\pi$ cubic units",
                f"$V = {latex(volume_expr)}$ cubic units"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    else:  # composite shape
        # Cylinder with hemisphere on top
        radius = randint(3, 8)
        cyl_height = randint(6, 12)
        
        # Volume = cylinder + hemisphere
        cyl_volume = pi * radius**2 * cyl_height
        hemisphere_volume = Rational(2, 3) * pi * radius**3
        total_volume = cyl_volume + hemisphere_volume
        
        return problem(
            question=f"A solid consists of a cylinder with radius ${radius}$ and height ${cyl_height}$, topped with a hemisphere of the same radius. Find the total volume. Express your answer in terms of $\\pi$.",
            answer=total_volume,
            difficulty=(1500, 1600),
            topic="geometry/volume",
            solution=steps(
                f"Volume = Volume of cylinder + Volume of hemisphere",
                f"Cylinder: $V_{{cyl}} = \\pi r^2 h = \\pi \\cdot {radius}^2 \\cdot {cyl_height} = {radius**2 * cyl_height}\\pi$",
                f"Hemisphere: $V_{{hem}} = \\frac{{2}}{{3}}\\pi r^3 = \\frac{{2}}{{3}}\\pi \\cdot {radius}^3 = \\frac{{{2 * radius**3}}}{{3}}\\pi$",
                f"Total: $V = {radius**2 * cyl_height}\\pi + \\frac{{{2 * radius**3}}}{{3}}\\pi$",
                f"$V = {latex(total_volume)}$ cubic units"
            ),
            calculator="scientific"
        )

emit(generate())