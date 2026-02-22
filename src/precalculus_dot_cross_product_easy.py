"""
precalculus - dot_cross_product (easy)
Generated: 2026-02-22T04:56:54.499756
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Simple 2D dot product with small integer vectors
        v1_x, v1_y = randint(-5, 5), randint(-5, 5)
        v2_x, v2_y = randint(-5, 5), randint(-5, 5)
        
        ans = v1_x * v2_x + v1_y * v2_y
        
        return problem(
            question=f"Find the dot product of $\\vec{{u}} = \\langle {v1_x}, {v1_y} \\rangle$ and $\\vec{{v}} = \\langle {v2_x}, {v2_y} \\rangle$.",
            answer=ans,
            difficulty=(1000, 1150),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Use the dot product formula: $\\vec{{u}} \\cdot \\vec{{v}} = u_1 v_1 + u_2 v_2$",
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({v1_x})({v2_x}) + ({v1_y})({v2_y})$",
                f"$= {v1_x * v2_x} + {v1_y * v2_y}$",
                f"$= {ans}$"
            )
        )
    
    elif problem_type == 2:
        # Simple 3D dot product with small integers
        v1_x, v1_y, v1_z = randint(-4, 4), randint(-4, 4), randint(-4, 4)
        v2_x, v2_y, v2_z = randint(-4, 4), randint(-4, 4), randint(-4, 4)
        
        ans = v1_x * v2_x + v1_y * v2_y + v1_z * v2_z
        
        return problem(
            question=f"Compute $\\langle {v1_x}, {v1_y}, {v1_z} \\rangle \\cdot \\langle {v2_x}, {v2_y}, {v2_z} \\rangle$.",
            answer=ans,
            difficulty=(1050, 1200),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Use the dot product formula: $\\vec{{u}} \\cdot \\vec{{v}} = u_1 v_1 + u_2 v_2 + u_3 v_3$",
                f"$= ({v1_x})({v2_x}) + ({v1_y})({v2_y}) + ({v1_z})({v2_z})$",
                f"$= {v1_x * v2_x} + {v1_y * v2_y} + {v1_z * v2_z}$",
                f"$= {ans}$"
            )
        )
    
    elif problem_type == 3:
        # Simple 2D cross product (scalar result in 2D)
        v1_x, v1_y = randint(-5, 5), randint(-5, 5)
        v2_x, v2_y = randint(-5, 5), randint(-5, 5)
        
        ans = v1_x * v2_y - v1_y * v2_x
        
        return problem(
            question=f"Find the magnitude of the cross product (scalar in 2D) of $\\vec{{u}} = \\langle {v1_x}, {v1_y} \\rangle$ and $\\vec{{v}} = \\langle {v2_x}, {v2_y} \\rangle$.",
            answer=ans,
            difficulty=(1100, 1250),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"In 2D, the cross product gives a scalar: $u_1 v_2 - u_2 v_1$",
                f"$= ({v1_x})({v2_y}) - ({v1_y})({v2_x})$",
                f"$= {v1_x * v2_y} - {v1_y * v2_x}$",
                f"$= {ans}$"
            )
        )
    
    else:
        # Dot product equals zero (orthogonal vectors) - find missing component
        v1_x, v1_y = nonzero(-6, 6), nonzero(-6, 6)
        v2_x = nonzero(-6, 6)
        
        # v1_x * v2_x + v1_y * v2_y = 0
        # v2_y = -v1_x * v2_x / v1_y
        
        if (v1_x * v2_x) % v1_y == 0:
            ans = -(v1_x * v2_x) // v1_y
        else:
            ans = Rational(-v1_x * v2_x, v1_y)
        
        return problem(
            question=f"Find the value of $k$ such that $\\langle {v1_x}, {v1_y} \\rangle$ and $\\langle {v2_x}, k \\rangle$ are orthogonal.",
            answer=ans,
            difficulty=(1150, 1300),
            topic="precalculus/dot_cross_product",
            solution=steps(
                f"Two vectors are orthogonal when their dot product equals zero",
                f"$\\langle {v1_x}, {v1_y} \\rangle \\cdot \\langle {v2_x}, k \\rangle = 0$",
                f"${v1_x} \\cdot {v2_x} + {v1_y} \\cdot k = 0$",
                f"${v1_x * v2_x} + {v1_y}k = 0$",
                f"${v1_y}k = {-v1_x * v2_x}$",
                f"$k = {latex(ans)}$"
            )
        )

emit(generate())