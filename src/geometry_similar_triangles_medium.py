"""
geometry - similar_triangles (medium)
Generated: 2026-02-22T04:08:11.236877
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Basic similar triangles with one unknown side (1300-1400)
        scale = Rational(randint(2, 4), 1)
        small_side1 = randint(3, 8)
        small_side2 = randint(3, 8)
        large_side1 = small_side1 * scale
        
        # Unknown is large_side2
        ans = small_side2 * scale
        
        d = Diagram(width=400, height=200, padding=30)
        # Small triangle
        t1_points = [(0, 0), (small_side1, 0), (small_side1, small_side2)]
        d.polygon(t1_points, labels=['A', 'B', 'C'])
        d.segment_label((0, 0), (small_side1, 0), str(small_side1))
        d.segment_label((small_side1, 0), (small_side1, small_side2), str(small_side2))
        
        # Large triangle
        offset = small_side1 + 3
        t2_points = [(offset, 0), (offset + large_side1, 0), (offset + large_side1, ans)]
        d.polygon(t2_points, labels=['D', 'E', 'F'])
        d.segment_label((offset, 0), (offset + large_side1, 0), str(int(large_side1)))
        d.segment_label((offset + large_side1, 0), (offset + large_side1, ans), 'x')
        
        return problem(
            question=f"Triangle ABC is similar to triangle DEF. If AB = {small_side1}, BC = {small_side2}, and DE = {int(large_side1)}, find EF.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Since triangles ABC and DEF are similar, corresponding sides are proportional",
                f"$\\frac{{AB}}{{DE}} = \\frac{{BC}}{{EF}}$",
                f"$\\frac{{{small_side1}}}{{{int(large_side1)}}} = \\frac{{{small_side2}}}{{x}}$",
                f"$x = \\frac{{{small_side2} \\cdot {int(large_side1)}}}{{{small_side1}}} = {ans}$"
            ),
            image=d.render()
        )
    
    elif problem_type == 2:
        # Similar triangles with proportional sides (1400-1500)
        scale = Rational(randint(2, 5), 1)
        s1 = randint(4, 10)
        s2 = randint(4, 10)
        s3 = randint(4, 10)
        
        large1 = s1 * scale
        large2 = s2 * scale
        
        # Given large1, large2, s1, find s2
        ans = s2
        
        return problem(
            question=f"Two similar triangles have corresponding sides in proportion. The smaller triangle has sides {s1} and x. The larger triangle has corresponding sides {int(large1)} and {int(large2)}. Find x.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Set up proportion of corresponding sides:",
                f"$\\frac{{{s1}}}{{{int(large1)}}} = \\frac{{x}}{{{int(large2)}}}$",
                f"$x = \\frac{{{s1} \\cdot {int(large2)}}}{{{int(large1)}}}$",
                f"$x = \\frac{{{s1 * large2}}}{{{int(large1)}}} = {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Scale factor problem (1300-1400)
        side1 = randint(6, 15)
        side2 = randint(6, 15)
        scale = randint(2, 4)
        
        ans = scale
        
        return problem(
            question=f"Two similar triangles have corresponding sides of length {side1} and {side1 * scale}. What is the scale factor from the smaller triangle to the larger triangle?",
            answer=ans,
            difficulty=(1300, 1400),
            topic="geometry/similar_triangles",
            solution=steps(
                f"The scale factor is the ratio of corresponding sides",
                f"Scale factor = $\\frac{{{side1 * scale}}}{{{side1}}} = {scale}$"
            )
        )
    
    else:
        # Two triangles with altitude or height (1500-1600)
        small_base = randint(4, 8)
        small_height = randint(3, 7)
        scale = Rational(randint(2, 4), 1)
        large_base = small_base * scale
        
        # Find large height
        ans = small_height * scale
        
        d = Diagram(width=400, height=250, padding=30)
        # Small triangle
        t1 = [(0, 0), (small_base, 0), (small_base/2, small_height)]
        d.polygon(t1, labels=['A', 'B', 'C'])
        d.segment_label((0, 0), (small_base, 0), str(small_base))
        d.line((small_base/2, 0), (small_base/2, small_height), dashed=True)
        d.segment_label((small_base/2, 0), (small_base/2, small_height), str(small_height))
        
        # Large triangle
        offset = small_base + 4
        t2 = [(offset, 0), (offset + large_base, 0), (offset + large_base/2, ans)]
        d.polygon(t2, labels=['D', 'E', 'F'])
        d.segment_label((offset, 0), (offset + large_base, 0), str(int(large_base)))
        d.line((offset + large_base/2, 0), (offset + large_base/2, ans), dashed=True)
        d.segment_label((offset + large_base/2, 0), (offset + large_base/2, ans), 'h')
        
        return problem(
            question=f"Triangle ABC is similar to triangle DEF. Triangle ABC has base {small_base} and height {small_height}. Triangle DEF has base {int(large_base)}. Find the height h of triangle DEF.",
            answer=ans,
            difficulty=(1500, 1600),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Similar triangles have proportional corresponding dimensions",
                f"$\\frac{{\\text{{base of ABC}}}}{{\\text{{base of DEF}}}} = \\frac{{\\text{{height of ABC}}}}{{\\text{{height of DEF}}}}$",
                f"$\\frac{{{small_base}}}{{{int(large_base)}}} = \\frac{{{small_height}}}{{h}}$",
                f"$h = \\frac{{{small_height} \\cdot {int(large_base)}}}{{{small_base}}} = {ans}$"
            ),
            image=d.render()
        )

emit(generate())