"""
geometry - pythagorean_theorem (hard)
Generated: 2026-02-22T04:18:09.833872
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 5)

    if problem_type == 1:
        # 3D space diagonal of rectangular prism - varied dimensions
        a_val = randint(2, 12)
        b_val = randint(2, 12)
        c_val = randint(2, 12)
        # Ensure all three are distinct
        while b_val == a_val:
            b_val = randint(2, 12)
        while c_val == a_val or c_val == b_val:
            c_val = randint(2, 12)

        total_sq = a_val**2 + b_val**2 + c_val**2
        ans = simplify(sqrt(total_sq))

        return problem(
            question=f"A rectangular prism has dimensions ${a_val}$, ${b_val}$, and ${c_val}$. Find the length of the space diagonal (from one corner to the opposite corner through the interior). Simplify your answer.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"First find the diagonal of the base: $d_{{base}}^2 = {a_val}^2 + {b_val}^2 = {a_val**2 + b_val**2}$",
                f"Then use that as a leg with height ${c_val}$: $d^2 = d_{{base}}^2 + {c_val}^2 = {a_val**2 + b_val**2} + {c_val**2} = {total_sq}$",
                f"Equivalently, $d^2 = a^2 + b^2 + c^2 = {a_val}^2 + {b_val}^2 + {c_val}^2 = {total_sq}$",
                f"$d = \\sqrt{{{total_sq}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Algebraic legs: Pythagorean theorem with variable n, solve for n
        k_val = randint(2, 6)
        m_val = randint(1, 5)

        # Legs: k*n and (k*n + m), hypotenuse: (k*n + m + something chosen to make clean solution)
        # Use the form: legs k*n and (k*n+m), then hyp^2 - leg1^2 - leg2^2 = 0 gives a linear equation in n
        # Simple approach: legs are (n, n+m) with some scale, hypotenuse is fixed
        # Use n as symbol
        leg1_expr = k_val * n
        leg2_expr = k_val * n + m_val
        # Pick hyp so that n has a nice positive solution: hyp^2 = leg1^2 + leg2^2
        # Try n_target = randint(2, 6)
        n_target = randint(2, 8)
        hyp_sq = (k_val * n_target)**2 + (k_val * n_target + m_val)**2
        hyp_val = sqrt(hyp_sq)
        if not hyp_val.is_Integer:
            # Find an integer hyp that works differently
            # Instead use a triple-based approach: make it algebraic on simpler terms
            # legs are (3n, 4n), hyp is 5n → trivial. Use (n, n+1, hyp)
            k_val = 1
            m_val = randint(1, 4)
            n_target = randint(3, 10)
            leg1_expr = n
            leg2_expr = n + m_val
            hyp_sq_val = n_target**2 + (n_target + m_val)**2
            hyp_sym = sqrt(hyp_sq_val)
            # Solve symbolically
            eq = Eq(leg1_expr**2 + leg2_expr**2, hyp_sq_val)
            solutions = solve(eq, n)
            pos_solutions = [s for s in solutions if s > 0]
            if not pos_solutions:
                n_target = 3
            ans = n_target
            return problem(
                question=f"A right triangle has legs of length $n$ and $n + {m_val}$. The hypotenuse has length $\\sqrt{{{hyp_sq_val}}}$. Find the positive value of $n$.",
                answer=ans,
                difficulty=(1600, 1700),
                topic="geometry/pythagorean_theorem",
                solution=steps(
                    f"Apply the Pythagorean theorem: $n^2 + (n+{m_val})^2 = {hyp_sq_val}$",
                    f"Expand: $n^2 + n^2 + {2*m_val}n + {m_val**2} = {hyp_sq_val}$",
                    f"$2n^2 + {2*m_val}n + {m_val**2 - hyp_sq_val} = 0$",
                    f"Solve the quadratic equation for $n > 0$",
                    f"$n = {ans}$"
                ),
                calculator="scientific"
            )

        # hyp is integer
        hyp_int = int(hyp_val)
        ans = n_target
        # Express the question with symbolic k*n
        return problem(
            question=f"A right triangle has legs of length ${k_val}n$ and ${k_val}n + {m_val}$, and hypotenuse of length ${hyp_int}$. Find the positive value of $n$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Apply the Pythagorean theorem: $({k_val}n)^2 + ({k_val}n+{m_val})^2 = {hyp_int}^2$",
                f"Expand and simplify to solve for $n$",
                f"$n = {ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Distance between two points on a coordinate plane
        x1, y1 = randint(-8, 8), randint(-8, 8)
        x2, y2 = randint(-8, 8), randint(-8, 8)
        while x2 == x1:
            x2 = randint(-8, 8)
        while y2 == y1:
            y2 = randint(-8, 8)

        dx = abs(x2 - x1)
        dy = abs(y2 - y1)
        dist_sq = dx**2 + dy**2
        ans = simplify(sqrt(dist_sq))

        return problem(
            question=f"Find the exact distance between the points $({x1}, {y1})$ and $({x2}, {y2})$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Use the distance formula (derived from the Pythagorean theorem):",
                f"$d = \\sqrt{{(x_2 - x_1)^2 + (y_2 - y_1)^2}}$",
                f"$d = \\sqrt{{({x2} - {x1})^2 + ({y2} - {y1})^2}}$",
                f"$d = \\sqrt{{({x2 - x1})^2 + ({y2 - y1})^2}}$",
                f"$d = \\sqrt{{{dx**2} + {dy**2}}} = \\sqrt{{{dist_sq}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 4:
        # Ladder sliding problem (two-stage)
        h1 = randint(6, 14)
        d1 = randint(3, 7)
        ladder_sq = h1**2 + d1**2

        # New ground distance
        d2 = d1 + randint(2, 5)
        h2_sq = ladder_sq - d2**2
        if h2_sq <= 0:
            d2 = d1 + 1
            h2_sq = ladder_sq - d2**2
        if h2_sq <= 0:
            h1, d1 = 12, 5
            ladder_sq = h1**2 + d1**2
            d2 = d1 + 3
            h2_sq = ladder_sq - d2**2

        ans = simplify(sqrt(h2_sq))

        return problem(
            question=f"A ladder rests against a wall. Initially, the base is ${d1}$ feet from the wall and the top reaches ${h1}$ feet high. The base is pushed ${d2 - d1}$ feet farther from the wall. How high does the ladder now reach?",
            answer=ans,
            difficulty=(1650, 1750),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"First find the ladder length: $L^2 = {h1}^2 + {d1}^2 = {h1**2} + {d1**2} = {ladder_sq}$",
                f"In the new position, the base is ${d2}$ feet from the wall",
                f"New height $h$: $h^2 + {d2}^2 = {ladder_sq}$",
                f"$h^2 = {ladder_sq} - {d2**2} = {h2_sq}$",
                f"$h = \\sqrt{{{h2_sq}}} = {latex(ans)}$ feet"
            ),
            calculator="scientific"
        )

    else:
        # 3D diagonal in a cube or find a missing dimension given space diagonal
        side = randint(2, 10)
        total_sq = 3 * side**2
        ans = simplify(sqrt(total_sq))

        # Vary: sometimes ask for face diagonal, sometimes space diagonal
        variant = randint(0, 1)
        if variant == 0:
            return problem(
                question=f"Find the space diagonal of a cube with side length ${side}$. Simplify your answer.",
                answer=ans,
                difficulty=(1700, 1800),
                topic="geometry/pythagorean_theorem",
                solution=steps(
                    f"For a cube with side $s$, the space diagonal is $d = s\\sqrt{{3}}$",
                    f"Face diagonal: $f = \\sqrt{{{side}^2 + {side}^2}} = \\sqrt{{{2*side**2}}} = {side}\\sqrt{{2}}$",
                    f"Space diagonal: $d = \\sqrt{{f^2 + {side}^2}} = \\sqrt{{{2*side**2} + {side**2}}} = \\sqrt{{{total_sq}}} = {latex(ans)}$"
                ),
                calculator="scientific"
            )
        else:
            # Given space diagonal, find side
            given_diag_sq = total_sq
            return problem(
                question=f"A cube has a space diagonal of length $\\sqrt{{{given_diag_sq}}}$. Find the side length of the cube.",
                answer=side,
                difficulty=(1700, 1800),
                topic="geometry/pythagorean_theorem",
                solution=steps(
                    f"The space diagonal of a cube with side $s$ satisfies $d^2 = 3s^2$",
                    f"$({given_diag_sq}) = 3s^2$",
                    f"$s^2 = \\frac{{{given_diag_sq}}}{{3}} = {side**2}$",
                    f"$s = {side}$"
                ),
                calculator="scientific"
            )

emit(generate())
