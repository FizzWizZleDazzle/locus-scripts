"""
geometry - similar_triangles (medium)
Generated: 2026-02-22T04:08:11.236877
"""

from problem_utils import *
from svg_utils import Diagram

def _make_scale():
    """Return a scale factor that is either an integer 2-8 or simple fraction."""
    if randint(0, 1):
        return Rational(randint(2, 8), 1)
    else:
        num = randint(2, 4)
        den = num + randint(1, 3)
        return Rational(num, den)

def generate():
    problem_type = randint(1, 4)

    if problem_type == 1:
        # Basic similar triangles - find unknown side using proportion
        scale = _make_scale()
        small_side1 = randint(3, 10)
        small_side2 = randint(3, 10)
        large_side1 = small_side1 * scale
        ans = small_side2 * scale

        # Ensure sides are reasonable numbers
        if not ans.is_Integer:
            # Fall back to integer scale
            scale = Rational(randint(2, 6), 1)
            large_side1 = small_side1 * scale
            ans = small_side2 * scale

        d = Diagram(width=400, height=200, padding=30)
        t1_points = [(0,0),(small_side1,0),(small_side1,small_side2)]
        d.polygon(t1_points, labels=['A','B','C'])
        d.segment_label((0,0),(small_side1,0),str(small_side1))
        d.segment_label((small_side1,0),(small_side1,small_side2),str(small_side2))

        offset = small_side1 + 3
        l1 = int(large_side1)
        t2_points = [(offset,0),(offset+l1,0),(offset+l1,int(ans))]
        d.polygon(t2_points, labels=['D','E','F'])
        d.segment_label((offset,0),(offset+l1,0),str(l1))
        d.segment_label((offset+l1,0),(offset+l1,int(ans)),'x')

        return problem(
            question=f"Triangle $ABC$ is similar to triangle $DEF$. If $AB = {small_side1}$, $BC = {small_side2}$, and $DE = {l1}$, find $EF$.",
            answer=ans,
            difficulty=(1300, 1400),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Since triangles $ABC$ and $DEF$ are similar, corresponding sides are proportional",
                f"$\\frac{{AB}}{{DE}} = \\frac{{BC}}{{EF}}$",
                f"$\\frac{{{small_side1}}}{{{l1}}} = \\frac{{{small_side2}}}{{x}}$",
                f"$x = \\frac{{{small_side2} \\cdot {l1}}}{{{small_side1}}} = {latex(ans)}$"
            ),
            image=d.render()
        )

    elif problem_type == 2:
        # Three sides given in one triangle, find side in second using ratio
        scale = randint(2, 7)
        s1 = randint(4, 12)
        s2 = randint(4, 12)
        s3 = randint(4, 12)
        large1 = s1 * scale
        large2 = s2 * scale
        # Given large1, s1, large2 - find s2
        ans = s2

        return problem(
            question=f"Two similar triangles have corresponding sides in proportion. The smaller triangle has sides ${s1}$ and ${s2}$. The larger triangle has the corresponding sides ${large1}$ and ${large2}$. Verify the proportionality and find what $x = {s2}$ equals when $\\frac{{{s1}}}{{{large1}}} = \\frac{{x}}{{{large2}}}$.",
            answer=ans,
            difficulty=(1400, 1500),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Set up proportion: $\\frac{{{s1}}}{{{large1}}} = \\frac{{x}}{{{large2}}}$",
                f"$x = \\frac{{{s1} \\cdot {large2}}}{{{large1}}}$",
                f"$x = \\frac{{{s1 * large2}}}{{{large1}}} = {ans}$"
            )
        )

    elif problem_type == 3:
        # Scale factor problem with wide variety, including fractional scale
        use_fraction = randint(0, 1)
        if use_fraction:
            # Fraction scale: sides a and b with b/a = p/q
            p = randint(2, 5)
            q = randint(p+1, p+5)
            side_a = randint(2, 6) * p
            side_b = side_a * q // p
            scale_ans = Rational(q, p)
            question_str = f"Two similar triangles have corresponding sides of length ${side_a}$ and ${side_b}$. What is the scale factor from the first to the second triangle? Express as a fraction if necessary."
        else:
            scale_num = randint(2, 8)
            side_small = randint(3, 10)
            side_large = side_small * scale_num
            scale_ans = scale_num
            question_str = f"Two similar triangles have corresponding sides of length ${side_small}$ and ${side_large}$. What is the scale factor from the smaller to the larger triangle?"

        return problem(
            question=question_str,
            answer=scale_ans,
            difficulty=(1300, 1400),
            topic="geometry/similar_triangles",
            solution=steps(
                f"The scale factor is the ratio of corresponding sides",
                f"Scale factor = $\\frac{{\\text{{second}}}}{{\\text{{first}}}} = {latex(scale_ans)}$"
            )
        )

    else:
        # Altitude / height proportion problem
        small_base = randint(3, 10)
        small_height = randint(3, 10)
        scale = randint(2, 6)
        large_base = small_base * scale
        ans = small_height * scale

        d = Diagram(width=400, height=250, padding=30)
        t1 = [(0,0),(small_base,0),(small_base/2, small_height)]
        d.polygon(t1, labels=['A','B','C'])
        d.segment_label((0,0),(small_base,0),str(small_base))
        d.line((small_base/2,0),(small_base/2,small_height),dashed=True)
        d.segment_label((small_base/2,0),(small_base/2,small_height),str(small_height))

        offset = small_base + 4
        t2 = [(offset,0),(offset+large_base,0),(offset+large_base/2,ans)]
        d.polygon(t2, labels=['D','E','F'])
        d.segment_label((offset,0),(offset+large_base,0),str(large_base))
        d.line((offset+large_base/2,0),(offset+large_base/2,ans),dashed=True)
        d.segment_label((offset+large_base/2,0),(offset+large_base/2,ans),'h')

        return problem(
            question=f"Triangle $ABC$ is similar to triangle $DEF$. Triangle $ABC$ has base ${small_base}$ and height ${small_height}$. Triangle $DEF$ has base ${large_base}$. Find the height $h$ of triangle $DEF$.",
            answer=ans,
            difficulty=(1500, 1600),
            topic="geometry/similar_triangles",
            solution=steps(
                f"Similar triangles have proportional corresponding dimensions",
                f"$\\frac{{\\text{{base of ABC}}}}{{\\text{{base of DEF}}}} = \\frac{{\\text{{height of ABC}}}}{{\\text{{height of DEF}}}}$",
                f"$\\frac{{{small_base}}}{{{large_base}}} = \\frac{{{small_height}}}{{h}}$",
                f"$h = \\frac{{{small_height} \\cdot {large_base}}}{{{small_base}}} = {ans}$"
            ),
            image=d.render()
        )

emit(generate())
