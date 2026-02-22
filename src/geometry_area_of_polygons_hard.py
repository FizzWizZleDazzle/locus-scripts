"""
geometry - area_of_polygons (hard)
Generated: 2026-02-22T04:12:56.165774
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Composite polygon - L-shape or T-shape decomposition
        w1 = randint(8, 15)
        h1 = randint(6, 12)
        w2 = randint(4, 7)
        h2 = randint(4, 8)
        
        orientation = choice(['L', 'T'])
        
        if orientation == 'L':
            # L-shape: large rectangle minus cutout
            total_w = w1
            total_h = h1
            cutout_w = w1 - w2
            cutout_h = h1 - h2
            
            area = w1 * h1 - cutout_w * cutout_h
            
            d = Diagram(width=300, height=250)
            points = [(0, 0), (w1, 0), (w1, h2), (w2, h2), (w2, h1), (0, h1)]
            d.polygon(points, labels=['A', 'B', 'C', 'D', 'E', 'F'])
            d.segment_label((0, 0), (w1, 0), f"{w1}")
            d.segment_label((w1, 0), (w1, h2), f"{h2}")
            d.segment_label((w2, h2), (w2, h1), f"{h1 - h2}")
            d.segment_label((0, 0), (0, h1), f"{h1}")
            d.segment_label((w2, h1), (0, h1), f"{w2}")
            
            return problem(
                question=f"Find the area of the L-shaped polygon shown below (all angles are right angles).",
                answer=area,
                difficulty=(1600, 1700),
                topic="geometry/area_of_polygons",
                solution=steps(
                    f"Decompose the L-shape into two rectangles:",
                    f"Bottom rectangle: ${w1} \\times {h2} = {w1 * h2}$ square units",
                    f"Top left rectangle: ${w2} \\times {h1 - h2} = {w2 * (h1 - h2)}$ square units",
                    f"Total area: ${w1 * h2} + {w2 * (h1 - h2)} = {area}$ square units"
                ),
                image=d.render()
            )
        else:
            # T-shape
            top_w = w1
            top_h = h2
            bottom_w = w2
            bottom_h = h1
            
            area = top_w * top_h + bottom_w * bottom_h
            
            offset = (top_w - bottom_w) // 2
            
            d = Diagram(width=300, height=250)
            points = [(0, 0), (top_w, 0), (top_w, top_h), (offset + bottom_w, top_h), 
                     (offset + bottom_w, top_h + bottom_h), (offset, top_h + bottom_h), 
                     (offset, top_h), (0, top_h)]
            d.polygon(points)
            d.segment_label((0, 0), (top_w, 0), f"{top_w}")
            d.segment_label((0, 0), (0, top_h), f"{top_h}")
            d.segment_label((offset, top_h), (offset, top_h + bottom_h), f"{bottom_h}")
            d.segment_label((offset, top_h + bottom_h), (offset + bottom_w, top_h + bottom_h), f"{bottom_w}")
            
            return problem(
                question=f"Find the area of the T-shaped polygon shown below (all angles are right angles).",
                answer=area,
                difficulty=(1600, 1700),
                topic="geometry/area_of_polygons",
                solution=steps(
                    f"Decompose the T-shape into two rectangles:",
                    f"Top horizontal rectangle: ${top_w} \\times {top_h} = {top_w * top_h}$ square units",
                    f"Bottom vertical rectangle: ${bottom_w} \\times {bottom_h} = {bottom_w * bottom_h}$ square units",
                    f"Total area: ${top_w * top_h} + {bottom_w * bottom_h} = {area}$ square units"
                ),
                image=d.render()
            )
    
    elif problem_type == 2:
        # Trapezoid with given diagonals and angle
        b1 = randint(6, 12)
        b2 = randint(10, 18)
        h = randint(5, 10)
        
        area = Rational(1, 2) * (b1 + b2) * h
        
        d = Diagram(width=300, height=200)
        offset = (b2 - b1) / 2
        points = [(0, 0), (b2, 0), (offset + b1, h), (offset, h)]
        d.polygon(points, labels=['A', 'B', 'C', 'D'])
        d.segment_label((0, 0), (b2, 0), f"{b2}")
        d.segment_label((offset, h), (offset + b1, h), f"{b1}")
        d.line((offset + b1/2, h), (offset + b1/2, 0), dashed=True)
        d.segment_label((offset + b1/2, h), (offset + b1/2, 0), f"{h}")
        
        return problem(
            question=f"A trapezoid has parallel sides of length ${b1}$ and ${b2}$, with a height of ${h}$. Find its area.",
            answer=area,
            difficulty=(1650, 1750),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Use the trapezoid area formula: $A = \\frac{{1}}{{2}}(b_1 + b_2)h$",
                f"$A = \\frac{{1}}{{2}}({b1} + {b2}) \\cdot {h}$",
                f"$A = \\frac{{1}}{{2}} \\cdot {b1 + b2} \\cdot {h}$",
                f"$A = {latex(area)}$ square units"
            ),
            image=d.render()
        )
    
    elif problem_type == 3:
        # Regular polygon with apothem
        n = choice([5, 6, 8])
        s = randint(4, 10)
        
        if n == 5:
            name = "pentagon"
            apothem_val = round(s / (2 * tan(pi/5)), 2)
        elif n == 6:
            name = "hexagon"
            apothem_val = round(s * sqrt(3) / 2, 2)
        else:
            name = "octagon"
            apothem_val = round(s * (1 + sqrt(2)) / 2, 2)
        
        perimeter = n * s
        area = round(Rational(1, 2) * perimeter * apothem_val, 2)
        
        return problem(
            question=f"A regular {name} has a side length of ${s}$ and an apothem of ${apothem_val}$. Find its area.",
            answer=area,
            difficulty=(1700, 1800),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"For a regular polygon: $A = \\frac{{1}}{{2}} \\cdot \\text{{perimeter}} \\cdot \\text{{apothem}}$",
                f"Perimeter $= {n} \\times {s} = {perimeter}$",
                f"$A = \\frac{{1}}{{2}} \\cdot {perimeter} \\cdot {apothem_val}$",
                f"$A = {area}$ square units"
            )
        )
    
    elif problem_type == 4:
        # Rhombus with diagonals
        d1 = randint(8, 16)
        d2 = randint(6, 14)
        
        area = Rational(1, 2) * d1 * d2
        
        d_obj = Diagram(width=300, height=250)
        points = [(0, d2/2), (d1/2, 0), (0, -d2/2), (-d1/2, 0)]
        d_obj.polygon(points, labels=['A', 'B', 'C', 'D'])
        d_obj.line((-d1/2, 0), (d1/2, 0), dashed=True)
        d_obj.line((0, -d2/2), (0, d2/2), dashed=True)
        d_obj.segment_label((-d1/2, 0), (d1/2, 0), f"{d1}")
        d_obj.segment_label((0, -d2/2), (0, d2/2), f"{d2}")
        
        return problem(
            question=f"A rhombus has diagonals of length ${d1}$ and ${d2}$. Find its area.",
            answer=area,
            difficulty=(1650, 1750),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"The area of a rhombus is $A = \\frac{{1}}{{2}} d_1 d_2$ where $d_1$ and $d_2$ are the diagonals",
                f"$A = \\frac{{1}}{{2}} \\cdot {d1} \\cdot {d2}$",
                f"$A = {latex(area)}$ square units"
            ),
            image=d_obj.render()
        )
    
    else:
        # Irregular quadrilateral using triangulation
        x1, y1 = 0, 0
        x2, y2 = randint(8, 12), 0
        x3, y3 = randint(10, 15), randint(6, 10)
        x4, y4 = randint(2, 6), randint(5, 9)
        
        # Area using shoelace formula
        area = abs((x1*y2 - x2*y1) + (x2*y3 - x3*y2) + (x3*y4 - x4*y3) + (x4*y1 - x1*y4)) / 2
        
        # Calculate diagonal lengths for problem statement
        diag_AC = round(sqrt((x3 - x1)**2 + (y3 - y1)**2), 1)
        
        # Areas of triangles ABC and ACD
        area_ABC = abs((x1*y2 - x2*y1) + (x2*y3 - x3*y2) + (x3*y1 - x1*y3)) / 2
        area_ACD = abs((x1*y3 - x3*y1) + (x3*y4 - x4*y3) + (x4*y1 - x1*y4)) / 2
        
        d_obj = Diagram(width=300, height=250)
        points = [(x1, y1), (x2, y2), (x3, y3), (x4, y4)]
        d_obj.polygon(points, labels=['A', 'B', 'C', 'D'])
        d_obj.line((x1, y1), (x3, y3), dashed=True)
        
        return problem(
            question=f"A quadrilateral ABCD has vertices at A$(0, 0)$, B$({x2}, 0)$, C$({x3}, {y3})$, and D$({x4}, {y4})$. Find its area using the shoelace formula.",
            answer=area,
            difficulty=(1750, 1850),
            topic="geometry/area_of_polygons",
            solution=steps(
                f"Using the shoelace formula: $A = \\frac{{1}}{{2}}|x_1(y_2 - y_4) + x_2(y_3 - y_1) + x_3(y_4 - y_2) + x_4(y_1 - y_3)|$",
                f"$A = \\frac{{1}}{{2}}|{x1}({y2} - {y4}) + {x2}({y3} - {y1}) + {x3}({y4} - {y2}) + {x4}({y1} - {y3})|$",
                f"$A = \\frac{{1}}{{2}}|{x1*(y2-y4)} + {x2*(y3-y1)} + {x3*(y4-y2)} + {x4*(y1-y3)}|$",
                f"$A = \\frac{{1}}{{2}} \\cdot {2*area} = {area}$ square units"
            ),
            image=d_obj.render()
        )

emit(generate())