"""
geometry - similar_triangles (hard)
Generated: 2026-02-22T04:08:48.613572
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: Two similar triangles with nested configuration, find missing side
        # using multiple proportions
        small_base = randint(3, 6)
        small_height = randint(4, 7)
        scale = randint(2, 3)
        large_base = small_base * scale
        large_height = small_height * scale
        
        # Additional segment created by similar triangles
        segment_on_large = randint(2, 4)
        corresponding_segment = Rational(segment_on_large * small_base, large_base)
        
        d = Diagram(width=350, height=280, padding=30)
        # Large triangle
        d.polygon([(0, 0), (large_base, 0), (large_base * Rational(2, 5), large_height)], 
                  labels=['A', 'B', 'C'])
        # Small triangle (similar, nested)
        small_x_offset = large_base * Rational(2, 5) - small_base * Rational(2, 5)
        d.polygon([(small_x_offset, 0), (small_x_offset + small_base, 0), 
                   (large_base * Rational(2, 5), small_height)], 
                  labels=['D', 'E', 'C'], fill="none")
        
        d.tick_marks((0, 0), (large_base * Rational(2, 5), large_height), 2)
        d.tick_marks((small_x_offset, 0), (large_base * Rational(2, 5), small_height), 2)
        d.segment_label((0, 0), (small_x_offset, 0), f"{float(small_x_offset):.1f}")
        d.segment_label((small_x_offset, 0), (small_x_offset + small_base, 0), str(small_base))
        d.segment_label((small_x_offset + small_base, 0), (large_base, 0), "x")
        
        ans = large_base - small_base - float(small_x_offset)
        
        return problem(
            question=f"In the diagram, triangles $ABC$ and $DEC$ are similar with $\\angle ACB \\cong \\angle DCE$. Given that $DE = {small_base}$ and the ratio of similarity is ${scale}:1$, and $AD = {float(small_x_offset):.1f}$, find $EB = x$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Since the triangles are similar with ratio ${scale}:1$, we have $AB = {scale} \\cdot DE = {scale} \\cdot {small_base} = {large_base}$",
                f"We know $AB = AD + DE + EB$",
                f"${large_base} = {float(small_x_offset):.1f} + {small_base} + x$",
                f"$x = {large_base} - {float(small_x_offset):.1f} - {small_base} = {ans}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Type 2: Shadow problem with two objects
        height1 = randint(5, 8)
        shadow1 = randint(6, 10)
        shadow2 = randint(12, 20)
        
        # Calculate height2 using similar triangles
        ans = Rational(height1 * shadow2, shadow1)
        
        return problem(
            question=f"A pole that is ${height1}$ meters tall casts a shadow ${shadow1}$ meters long. At the same time, a building casts a shadow ${shadow2}$ meters long. How tall is the building (in meters)?",
            answer=ans,
            difficulty=(1650, 1750),
            topic="geometry/similar_triangles",
            solution=steps(
                f"The angle of the sun creates similar right triangles",
                f"Set up proportion: $\\frac{{\\text{{height}}}}{{\\text{{shadow}}}} = \\frac{{{height1}}}{{{shadow1}}} = \\frac{{h}}{{{shadow2}}}$",
                f"Cross multiply: ${shadow1} \\cdot h = {height1} \\cdot {shadow2}$",
                f"${shadow1}h = {height1 * shadow2}$",
                f"$h = \\frac{{{height1 * shadow2}}}{{{shadow1}}} = {latex(ans)}$ meters"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # Type 3: Nested similar triangles with altitude, find segment lengths
        base = randint(12, 20)
        altitude = randint(8, 12)
        x_coord = randint(4, 8)
        
        # Point on base creates two similar triangles
        # Using altitude from vertex to base
        left_base = x_coord
        right_base = base - x_coord
        
        # Height of altitude from top to the foot
        # Similar triangle from foot to edge
        ans = Rational(altitude * left_base, base)
        
        d = Diagram(width=350, height=280, padding=30)
        d.polygon([(0, 0), (base, 0), (x_coord, altitude)], labels=['A', 'B', 'C'])
        d.line((x_coord, altitude), (x_coord, 0), dashed=True)
        d.right_angle((x_coord, 0), (0, 0), (x_coord, altitude))
        d.point(x_coord, 0, 'D')
        d.segment_label((0, 0), (x_coord, 0), str(left_base))
        d.segment_label((x_coord, 0), (base, 0), str(right_base))
        d.segment_label((x_coord, 0), (x_coord, altitude), "h")
        
        return problem(
            question=f"In triangle $ABC$, altitude $CD$ is drawn to side $AB$. If $AD = {left_base}$, $DB = {right_base}$, and triangles $ACD$ and $CBD$ are similar to triangle $ABC$, find the ratio of the altitude $CD$ to the side $CB$. Express as a simplified fraction.",
            answer=Rational(left_base, base),
            difficulty=(1700, 1800),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Triangle $ACD \\sim$ triangle $CBA$ (by AA similarity)",
                f"This gives us the proportion: $\\frac{{CD}}{{CB}} = \\frac{{AD}}{{AB}}$",
                f"We have $AD = {left_base}$ and $AB = {left_base} + {right_base} = {base}$",
                f"Therefore: $\\frac{{CD}}{{CB}} = \\frac{{{left_base}}}{{{base}}} = {latex(Rational(left_base, base))}$"
            ),
            image=d.render(),
            calculator="scientific"
        )
    
    else:
        # Type 4: Complex proportion problem with three similar triangles
        side1 = randint(4, 7)
        side2 = randint(5, 9)
        ratio_num = randint(2, 4)
        ratio_den = randint(3, 5)
        if ratio_num >= ratio_den:
            ratio_num, ratio_den = ratio_den, ratio_num
        
        # Third triangle related by compound proportion
        ans = Rational(side1 * side2 * ratio_num, side1 * ratio_den)
        ans = simplify(ans)
        
        return problem(
            question=f"Three similar triangles have corresponding sides in the following relationships: Triangle $A$ has a side of length ${side1}$, Triangle $B$ has the corresponding side of length ${side2}$. Triangle $C$ has a side whose length relates to Triangle $A$'s corresponding side in the ratio ${ratio_num}:{ratio_den}$. Find the length of the side in Triangle $C$ that corresponds to the side of length ${side2}$ in Triangle $B$.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="geometry/similar_triangles",
            solution=steps(
                f"First find the ratio between Triangle $A$ and Triangle $B$: $\\frac{{{side2}}}{{{side1}}}$",
                f"Triangle $C$ relates to Triangle $A$ by ratio $\\frac{{{ratio_num}}}{{{ratio_den}}}$",
                f"To find the corresponding side in Triangle $C$ to the side ${side2}$ in Triangle $B$:",
                f"Use compound proportion: $\\frac{{\\text{{side in C}}}}{{\\text{{side in A}}}} = \\frac{{{ratio_num}}}{{{ratio_den}}}$",
                f"Side in $A$ corresponding to ${side2}$ in $B$ is ${side1}$",
                f"Side in $C = {side1} \\cdot \\frac{{{ratio_num}}}{{{ratio_den}}} = {latex(Rational(side1 * ratio_num, ratio_den))}$",
                f"But we need the side corresponding to ${side2}$ in $B$",
                f"Scale by $\\frac{{{side2}}}{{{side1}}}$: ${latex(Rational(side1 * ratio_num, ratio_den))} \\cdot \\frac{{{side2}}}{{{side1}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())