"""
geometry - pythagorean_theorem (hard)
Generated: 2026-02-22T04:18:09.833872
"""

from problem_utils import *
from svg_utils import Diagram

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # 3D Pythagorean theorem - space diagonal of rectangular prism
        a_val = randint(3, 8)
        b_val = randint(3, 8)
        c_val = randint(3, 8)
        
        # Calculate space diagonal
        ans = sqrt(a_val**2 + b_val**2 + c_val**2)
        ans_simplified = simplify(ans)
        
        return problem(
            question=f"A rectangular prism has dimensions ${a_val}$, ${b_val}$, and ${c_val}$. Find the length of the space diagonal (from one corner to the opposite corner through the interior).",
            answer=ans_simplified,
            difficulty=(1650, 1750),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"The space diagonal $d$ of a rectangular prism satisfies $d^2 = a^2 + b^2 + c^2$",
                f"$d^2 = {a_val}^2 + {b_val}^2 + {c_val}^2 = {a_val**2} + {b_val**2} + {c_val**2} = {a_val**2 + b_val**2 + c_val**2}$",
                f"$d = \\sqrt{{{a_val**2 + b_val**2 + c_val**2}}} = {latex(ans_simplified)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Pythagorean theorem with algebraic expressions
        k_val = randint(2, 5)
        m_val = randint(1, 4)
        
        # Legs are k*n and (k*n + m), hypotenuse is (k*n + m + 1)
        # This ensures a clean solution
        leg1 = k_val * n
        leg2 = k_val * n + m_val
        hyp = k_val * n + m_val + 1
        
        # Solve for n: (k*n)^2 + (k*n + m)^2 = (k*n + m + 1)^2
        eq = Eq(leg1**2 + leg2**2, hyp**2)
        solutions = solve(eq, n)
        ans = [sol for sol in solutions if sol > 0][0]
        
        return problem(
            question=f"A right triangle has legs of length ${latex(leg1)}$ and ${latex(leg2)}$, and hypotenuse of length ${latex(hyp)}$. Find the positive value of $n$.",
            answer=ans,
            difficulty=(1600, 1700),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"Using the Pythagorean theorem: $({latex(leg1)})^2 + ({latex(leg2)})^2 = ({latex(hyp)})^2$",
                f"${latex(expand(leg1**2))} + {latex(expand(leg2**2))} = {latex(expand(hyp**2))}$",
                f"${latex(expand(leg1**2 + leg2**2))} = {latex(expand(hyp**2))}$",
                f"${latex(expand(leg1**2 + leg2**2 - hyp**2))} = 0$",
                f"$n = {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Distance from point to line using Pythagorean theorem
        # Vertical/horizontal line for simplicity at harder level means complex coordinates
        
        x_coord = randint(-8, 8)
        y_coord = randint(2, 9)
        line_pos = randint(-6, 6)
        
        if randint(0, 1) == 0:
            # Distance from (x_coord, y_coord) to vertical line x = line_pos
            horizontal_dist = abs(x_coord - line_pos)
            # Find point on perpendicular at distance d from the point
            target_dist = randint(8, 15)
            
            # Using Pythagorean: vertical_dist^2 + horizontal_dist^2 = target_dist^2
            ans = sqrt(target_dist**2 - horizontal_dist**2)
            
            return problem(
                question=f"Point $P = ({x_coord}, {y_coord})$ is ${target_dist}$ units away from point $Q$ on the vertical line $x = {line_pos}$. If $Q$ is above $P$, what is the $y$-coordinate of $Q$?",
                answer=y_coord + ans,
                difficulty=(1700, 1800),
                topic="geometry/pythagorean_theorem",
                solution=steps(
                    f"The horizontal distance from $P$ to the line $x = {line_pos}$ is $|{x_coord} - {line_pos}| = {horizontal_dist}$",
                    f"Let the vertical distance be $h$. By the Pythagorean theorem:",
                    f"$h^2 + {horizontal_dist}^2 = {target_dist}^2$",
                    f"$h^2 = {target_dist**2} - {horizontal_dist**2} = {target_dist**2 - horizontal_dist**2}$",
                    f"$h = {latex(ans)}$",
                    f"Since $Q$ is above $P$, the $y$-coordinate is ${y_coord} + {latex(ans)} = {latex(y_coord + ans)}$"
                ),
                calculator="scientific"
            )
        else:
            # Distance from (x_coord, y_coord) to horizontal line y = line_pos
            vertical_dist = abs(y_coord - line_pos)
            target_dist = randint(8, 15)
            
            ans = sqrt(target_dist**2 - vertical_dist**2)
            
            return problem(
                question=f"Point $P = ({x_coord}, {y_coord})$ is ${target_dist}$ units away from point $Q$ on the horizontal line $y = {line_pos}$. If $Q$ is to the right of $P$, what is the $x$-coordinate of $Q$?",
                answer=x_coord + ans,
                difficulty=(1700, 1800),
                topic="geometry/pythagorean_theorem",
                solution=steps(
                    f"The vertical distance from $P$ to the line $y = {line_pos}$ is $|{y_coord} - {line_pos}| = {vertical_dist}$",
                    f"Let the horizontal distance be $d$. By the Pythagorean theorem:",
                    f"$d^2 + {vertical_dist}^2 = {target_dist}^2$",
                    f"$d^2 = {target_dist**2} - {vertical_dist**2} = {target_dist**2 - vertical_dist**2}$",
                    f"$d = {latex(ans)}$",
                    f"Since $Q$ is to the right of $P$, the $x$-coordinate is ${x_coord} + {latex(ans)} = {latex(x_coord + ans)}$"
                ),
                calculator="scientific"
            )
    
    else:
        # Pythagorean theorem with nested radicals or complex setup
        # Ladder problem with two positions
        
        h1 = randint(8, 15)
        d1 = randint(3, 7)
        ladder_len_sq = h1**2 + d1**2
        
        # New distance from wall
        d2 = d1 + randint(2, 4)
        
        # New height: h2^2 + d2^2 = ladder_len_sq
        h2_sq = ladder_len_sq - d2**2
        ans = sqrt(h2_sq)
        
        return problem(
            question=f"A ladder is leaning against a wall. Initially, the base is ${d1}$ feet from the wall and reaches a height of ${h1}$ feet. The base is pulled ${d2 - d1}$ feet farther from the wall. How high up the wall does the ladder reach now?",
            answer=ans,
            difficulty=(1650, 1750),
            topic="geometry/pythagorean_theorem",
            solution=steps(
                f"First, find the ladder length using the Pythagorean theorem:",
                f"$L^2 = {h1}^2 + {d1}^2 = {h1**2} + {d1**2} = {ladder_len_sq}$",
                f"The ladder length is $L = \\sqrt{{{ladder_len_sq}}}$ feet",
                f"In the new position, base is ${d2}$ feet from wall. Let new height be $h$:",
                f"$h^2 + {d2}^2 = {ladder_len_sq}$",
                f"$h^2 = {ladder_len_sq} - {d2**2} = {h2_sq}$",
                f"$h = \\sqrt{{{h2_sq}}} = {latex(ans)}$ feet"
            ),
            calculator="scientific"
        )

emit(generate())