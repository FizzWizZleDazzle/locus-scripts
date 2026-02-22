"""
precalculus - vector_operations (easy)
Generated: 2026-02-22T04:55:22.092779
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Vector addition (1000-1100)
        v1_x, v1_y = randint(-5, 5), randint(-5, 5)
        v2_x, v2_y = randint(-5, 5), randint(-5, 5)
        
        ans_x = v1_x + v2_x
        ans_y = v1_y + v2_y
        ans = Matrix([ans_x, ans_y])
        
        return problem(
            question=f"Find $\\vec{{u}} + \\vec{{v}}$ where $\\vec{{u}} = {latex(Matrix([v1_x, v1_y]))}$ and $\\vec{{v}} = {latex(Matrix([v2_x, v2_y]))}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Add corresponding components:",
                f"$\\vec{{u}} + \\vec{{v}} = {latex(Matrix([v1_x, v1_y]))} + {latex(Matrix([v2_x, v2_y]))}$",
                f"$= {latex(Matrix([f'{v1_x}+{v2_x}', f'{v1_y}+{v2_y}']))}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Scalar multiplication (1000-1100)
        scalar = nonzero(-4, 4)
        v_x, v_y = randint(-5, 5), randint(-5, 5)
        
        ans_x = scalar * v_x
        ans_y = scalar * v_y
        ans = Matrix([ans_x, ans_y])
        
        return problem(
            question=f"Find ${scalar}\\vec{{v}}$ where $\\vec{{v}} = {latex(Matrix([v_x, v_y]))}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Multiply each component by ${scalar}$:",
                f"${scalar}\\vec{{v}} = {scalar} \\cdot {latex(Matrix([v_x, v_y]))}$",
                f"$= {latex(Matrix([f'{scalar}·{v_x}', f'{scalar}·{v_y}']))}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Vector subtraction (1100-1200)
        v1_x, v1_y = randint(-5, 5), randint(-5, 5)
        v2_x, v2_y = randint(-5, 5), randint(-5, 5)
        
        ans_x = v1_x - v2_x
        ans_y = v1_y - v2_y
        ans = Matrix([ans_x, ans_y])
        
        return problem(
            question=f"Find $\\vec{{u}} - \\vec{{v}}$ where $\\vec{{u}} = {latex(Matrix([v1_x, v1_y]))}$ and $\\vec{{v}} = {latex(Matrix([v2_x, v2_y]))}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Subtract corresponding components:",
                f"$\\vec{{u}} - \\vec{{v}} = {latex(Matrix([v1_x, v1_y]))} - {latex(Matrix([v2_x, v2_y]))}$",
                f"$= {latex(Matrix([f'{v1_x}-({v2_x})', f'{v1_y}-({v2_y})']))}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Magnitude of a vector (1100-1200)
        # Choose nice Pythagorean values
        pairs = [(3, 4), (5, 12), (8, 6), (7, 24), (15, 8)]
        v_x, v_y = choice(pairs)
        if randint(0, 1):
            v_x = -v_x
        if randint(0, 1):
            v_y = -v_y
        
        ans = sqrt(v_x**2 + v_y**2)
        
        return problem(
            question=f"Find the magnitude of $\\vec{{v}} = {latex(Matrix([v_x, v_y]))}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Use the formula $||\\vec{{v}}|| = \\sqrt{{v_x^2 + v_y^2}}$:",
                f"$||\\vec{{v}}|| = \\sqrt{{{v_x}^2 + {v_y}^2}}$",
                f"$= \\sqrt{{{v_x**2} + {v_y**2}}}$",
                f"$= \\sqrt{{{v_x**2 + v_y**2}}}$",
                f"$= {latex(ans)}$"
            )
        )
    
    elif problem_type == 5:
        # Dot product (1200-1300)
        v1_x, v1_y = randint(-5, 5), randint(-5, 5)
        v2_x, v2_y = randint(-5, 5), randint(-5, 5)
        
        ans = v1_x * v2_x + v1_y * v2_y
        
        return problem(
            question=f"Find $\\vec{{u}} \\cdot \\vec{{v}}$ where $\\vec{{u}} = {latex(Matrix([v1_x, v1_y]))}$ and $\\vec{{v}} = {latex(Matrix([v2_x, v2_y]))}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Use the dot product formula $\\vec{{u}} \\cdot \\vec{{v}} = u_x v_x + u_y v_y$:",
                f"$\\vec{{u}} \\cdot \\vec{{v}} = ({v1_x})({v2_x}) + ({v1_y})({v2_y})$",
                f"$= {v1_x * v2_x} + {v1_y * v2_y}$",
                f"$= {ans}$"
            )
        )
    
    else:
        # Linear combination (1200-1300)
        c1, c2 = nonzero(-3, 3), nonzero(-3, 3)
        v1_x, v1_y = randint(-4, 4), randint(-4, 4)
        v2_x, v2_y = randint(-4, 4), randint(-4, 4)
        
        ans_x = c1 * v1_x + c2 * v2_x
        ans_y = c1 * v1_y + c2 * v2_y
        ans = Matrix([ans_x, ans_y])
        
        return problem(
            question=f"Find ${c1}\\vec{{u}} + {c2}\\vec{{v}}$ where $\\vec{{u}} = {latex(Matrix([v1_x, v1_y]))}$ and $\\vec{{v}} = {latex(Matrix([v2_x, v2_y]))}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="precalculus/vector_operations",
            solution=steps(
                f"Compute each scalar multiplication first:",
                f"${c1}\\vec{{u}} = {c1} \\cdot {latex(Matrix([v1_x, v1_y]))} = {latex(Matrix([c1*v1_x, c1*v1_y]))}$",
                f"${c2}\\vec{{v}} = {c2} \\cdot {latex(Matrix([v2_x, v2_y]))} = {latex(Matrix([c2*v2_x, c2*v2_y]))}$",
                f"Add the results:",
                f"${latex(Matrix([c1*v1_x, c1*v1_y]))} + {latex(Matrix([c2*v2_x, c2*v2_y]))} = {latex(ans)}$"
            )
        )

emit(generate())