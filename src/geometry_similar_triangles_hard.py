"""
geometry - similar_triangles (hard)
Generated: 2026-02-22T04:08:48.613572
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # Shadow / indirect measurement problem
        height1 = randint(3, 12)
        shadow1 = randint(4, 15)
        shadow2 = randint(10, 40)
        # Ensure answer is a nice rational
        # height2 / shadow2 = height1 / shadow1
        ans = Rational(height1 * shadow2, shadow1)
        # Force integer answer for cleanliness sometimes
        if not ans.is_Integer:
            # Adjust shadow2 to make it divisible
            shadow2 = shadow1 * randint(2, 6)
            ans = Rational(height1 * shadow2, shadow1)

        contexts = [
            (f"A ${height1}$-meter pole casts a shadow ${shadow1}$ meters long. At the same time, a building casts a shadow ${shadow2}$ meters long. How tall is the building?", "meters"),
            (f"A ${height1}$-foot person casts a shadow ${shadow1}$ feet long. A nearby flagpole casts a shadow ${shadow2}$ feet long. How tall is the flagpole?", "feet"),
            (f"A tree ${height1}$ meters tall casts a shadow ${shadow1}$ meters long. A tower casts a shadow ${shadow2}$ meters long at the same time. Find the height of the tower.", "meters"),
        ]
        q_text, unit = choice(contexts)

        return problem(
            question=q_text,
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/similar_triangles",
            solution=steps(
                f"The sun's angle creates similar right triangles for both objects",
                f"$\\frac{{\\text{{height}}}}{{\\text{{shadow}}}} = \\frac{{{height1}}}{{{shadow1}}} = \\frac{{h}}{{{shadow2}}}$",
                f"${shadow1} \\cdot h = {height1} \\cdot {shadow2} = {height1 * shadow2}$",
                f"$h = \\frac{{{height1 * shadow2}}}{{{shadow1}}} = {latex(ans)}$ {unit}"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Triangle with altitude to hypotenuse - geometric mean
        # In a right triangle with altitude h to hypotenuse c: h^2 = p*q where p+q=c
        # Use whole numbers: pick p, q → h^2 = pq, hypotenuse = p+q
        p = randint(2, 8)
        q = randint(2, 8)
        while p == q:
            q = randint(2, 8)
        hyp = p + q
        h_sq = p * q
        h_val = sqrt(h_sq)

        # Also: leg^2 = p * hyp and other leg^2 = q * hyp
        leg1 = simplify(sqrt(p * hyp))
        leg2 = simplify(sqrt(q * hyp))

        variant = randint(0, 1)
        if variant == 0:
            return problem(
                question=f"In right triangle $ABC$, the altitude from the right angle $C$ to the hypotenuse $AB$ has foot $D$. If $AD = {p}$ and $DB = {q}$, find the length of the altitude $CD$. Simplify your answer.",
                answer=h_val,
                difficulty=(1650, 1750),
                topic="geometry/similar_triangles",
                solution=steps(
                    f"By the geometric mean (altitude) relation: $CD^2 = AD \\cdot DB$",
                    f"$CD^2 = {p} \\cdot {q} = {h_sq}$",
                    f"$CD = \\sqrt{{{h_sq}}} = {latex(h_val)}$"
                ),
                calculator="scientific"
            )
        else:
            return problem(
                question=f"In right triangle $ABC$, the altitude from $C$ to $AB$ meets $AB$ at $D$. Given $AD = {p}$ and $AB = {hyp}$, find the length of leg $BC$. Simplify your answer.",
                answer=leg2,
                difficulty=(1650, 1750),
                topic="geometry/similar_triangles",
                solution=steps(
                    f"By the geometric mean (leg) relation: $BC^2 = DB \\cdot AB$",
                    f"$DB = AB - AD = {hyp} - {p} = {q}$",
                    f"$BC^2 = {q} \\cdot {hyp} = {q * hyp}$",
                    f"$BC = \\sqrt{{{q * hyp}}} = {latex(leg2)}$"
                ),
                calculator="scientific"
            )

    elif problem_type == 3:
        # Similar triangles with algebraic expressions - solve for x
        # Scale factor k, one side of small = a, corresponding side of large = a*k
        # Another pair: small = (bx + c), large = given value
        k = randint(2, 5)
        a_small = randint(3, 8)
        a_large = a_small * k

        b_coeff = randint(1, 4)
        c_const = randint(1, 8)
        x_val = randint(1, 8)
        side_large_2 = b_coeff * x_val + c_const  # small side value when x=x_val
        side_large_2_scaled = side_large_2 * k      # corresponding large side

        return problem(
            question=f"Two similar triangles have corresponding sides $AB = {a_small}$ and $DE = {a_large}$. If another pair of corresponding sides are $BC = {b_coeff}x + {c_const}$ and $EF = {side_large_2_scaled}$, find $x$.",
            answer=x_val,
            difficulty=(1700, 1800),
            topic="geometry/similar_triangles",
            solution=steps(
                f"The scale factor from triangle $ABC$ to $DEF$ is $\\frac{{{a_large}}}{{{a_small}}} = {k}$",
                f"Set up proportion: $\\frac{{BC}}{{EF}} = \\frac{{{a_small}}}{{{a_large}}}$",
                f"$\\frac{{{b_coeff}x + {c_const}}}{{{side_large_2_scaled}}} = \\frac{{{a_small}}}{{{a_large}}} = \\frac{{1}}{{{k}}}$",
                f"${b_coeff}x + {c_const} = \\frac{{{side_large_2_scaled}}}{{{k}}} = {side_large_2}$",
                f"${b_coeff}x = {side_large_2 - c_const}$",
                f"$x = {x_val}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Area ratio from similarity ratio
        scale_num = randint(2, 6)
        scale_den = randint(1, scale_num - 1)
        while scale_den == scale_num:
            scale_den = randint(1, scale_num - 1)
        small_area = randint(4, 20) * scale_den**2
        area_ratio = Rational(scale_num**2, scale_den**2)
        large_area = small_area * area_ratio

        return problem(
            question=f"Two similar triangles have a similarity ratio of ${scale_num}:{scale_den}$. The smaller triangle has an area of ${small_area}$ square units. Find the area of the larger triangle.",
            answer=large_area,
            difficulty=(1750, 1850),
            topic="geometry/similar_triangles",
            solution=steps(
                f"When two figures are similar with ratio $k:1$, their areas are in ratio $k^2:1$",
                f"The similarity ratio is ${scale_num}:{scale_den}$",
                f"The area ratio is $\\left(\\frac{{{scale_num}}}{{{scale_den}}}\\right)^2 = \\frac{{{scale_num**2}}}{{{scale_den**2}}}$",
                f"Large area $= {small_area} \\cdot \\frac{{{scale_num**2}}}{{{scale_den**2}}} = {latex(large_area)}$ square units"
            ),
            calculator="scientific"
        )

    else:
        # Nested similar triangles (triangle inside triangle sharing vertex)
        small_base = randint(3, 7)
        small_height = randint(4, 8)
        scale = randint(2, 4)
        large_base = small_base * scale
        large_height = small_height * scale

        # A segment parallel to the base at height h cuts proportionally
        frac_num = randint(1, scale - 1)
        frac_den = scale
        cut_height = Rational(frac_num * small_height, 1)
        cut_base = Rational(large_base * frac_num, scale)

        return problem(
            question=f"Triangle $PQR$ has base $QR = {large_base}$ and height ${large_height}$. A line parallel to $QR$ cuts the triangle at $\\frac{{{frac_num}}}{{{scale}}}$ of the way up from the base. Find the length of the segment cut off.",
            answer=cut_base,
            difficulty=(1600, 1700),
            topic="geometry/similar_triangles",
            solution=steps(
                f"A line parallel to the base creates a smaller similar triangle",
                f"The ratio of heights is $\\frac{{{frac_num}}}{{{scale}}}$ from the apex, so the similar triangle has height ratio $\\frac{{{scale - frac_num}}}{{{scale}}}$ from apex",
                f"Wait — the line is $\\frac{{{frac_num}}}{{{scale}}}$ of the way from the base, so it is $\\frac{{{scale - frac_num}}}{{{scale}}}$ of the height from the apex",
                f"The segment length is $\\frac{{{scale - frac_num}}}{{{scale}}} \\times {large_base} = {latex(Rational((scale - frac_num) * large_base, scale))}$",
            ),
            calculator="scientific"
        )

emit(generate())
