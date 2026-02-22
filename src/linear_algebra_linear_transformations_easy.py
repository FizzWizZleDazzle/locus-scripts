"""
linear_algebra - linear_transformations (easy)
Generated: 2026-02-22T06:00:53.731806
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Matrix representation of a simple linear transformation
        # Easier: just apply the transformation to standard basis vectors
        scale_x = nonzero(-3, 3)
        scale_y = nonzero(-3, 3)
        
        question = f"Find the matrix representation of the linear transformation $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ defined by $T\\begin{{pmatrix}} x \\\\ y \\end{{pmatrix}} = \\begin{{pmatrix}} {scale_x}x \\\\ {scale_y}y \\end{{pmatrix}}$"
        
        ans = Matrix([[scale_x, 0], [0, scale_y]])
        
        solution = steps(
            f"Apply $T$ to the standard basis vectors $e_1 = \\begin{{pmatrix}} 1 \\\\ 0 \\end{{pmatrix}}$ and $e_2 = \\begin{{pmatrix}} 0 \\\\ 1 \\end{{pmatrix}}$",
            f"$T(e_1) = \\begin{{pmatrix}} {scale_x} \\\\ 0 \\end{{pmatrix}}$ and $T(e_2) = \\begin{{pmatrix}} 0 \\\\ {scale_y} \\end{{pmatrix}}$",
            f"The matrix has these as columns: ${latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1000, 1150),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )
    
    elif problem_type == 2:
        # Apply a given transformation matrix to a vector
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        v1 = randint(-4, 4)
        v2 = randint(-4, 4)
        
        T = Matrix([[a_val, 0], [0, b_val]])
        v = Matrix([v1, v2])
        ans = T * v
        
        question = f"Let $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ be the linear transformation with matrix ${latex(T)}$. Find $T\\left(\\begin{{pmatrix}} {v1} \\\\ {v2} \\end{{pmatrix}}\\right)$"
        
        solution = steps(
            f"Multiply the matrix by the vector:",
            f"${latex(T)} \\begin{{pmatrix}} {v1} \\\\ {v2} \\end{{pmatrix}} = \\begin{{pmatrix}} {a_val} \\cdot {v1} \\\\ {b_val} \\cdot {v2} \\end{{pmatrix}}$",
            f"$= {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1050, 1200),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )
    
    elif problem_type == 3:
        # Is a given transformation linear? (simple cases)
        is_linear = choice([True, False])
        
        if is_linear:
            c = nonzero(-3, 3)
            question = f"Is the transformation $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ defined by $T\\begin{{pmatrix}} x \\\\ y \\end{{pmatrix}} = \\begin{{pmatrix}} {c}x \\\\ {c}y \\end{{pmatrix}}$ linear?"
            solution = steps(
                f"Check if $T(u + v) = T(u) + T(v)$ and $T(cu) = cT(u)$ for all vectors $u, v$ and scalar $c$",
                f"This transformation scales both components by ${c}$, which is a linear operation",
                f"Yes, it is linear"
            )
        else:
            k = nonzero(-3, 3)
            question = f"Is the transformation $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ defined by $T\\begin{{pmatrix}} x \\\\ y \\end{{pmatrix}} = \\begin{{pmatrix}} x + {k} \\\\ y \\end{{pmatrix}}$ linear?"
            solution = steps(
                f"For a transformation to be linear, $T(0) = 0$ must hold",
                f"$T\\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}} = \\begin{{pmatrix}} {k} \\\\ 0 \\end{{pmatrix}} \\neq \\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}}$",
                f"No, it is not linear"
            )
        
        return problem(
            question=question,
            answer=is_linear,
            difficulty=(1150, 1300),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )
    
    else:
        # Find image of a vector under a simple 2x2 matrix transformation
        a_val = randint(-2, 2)
        b_val = randint(-2, 2)
        c_val = randint(-2, 2)
        d_val = randint(-2, 2)
        
        v1 = nonzero(-3, 3)
        v2 = nonzero(-3, 3)
        
        T = Matrix([[a_val, b_val], [c_val, d_val]])
        v = Matrix([v1, v2])
        ans = T * v
        
        question = f"Find the image of the vector $\\begin{{pmatrix}} {v1} \\\\ {v2} \\end{{pmatrix}}$ under the linear transformation with matrix ${latex(T)}$"
        
        result1 = a_val * v1 + b_val * v2
        result2 = c_val * v1 + d_val * v2
        
        solution = steps(
            f"Multiply the transformation matrix by the vector:",
            f"${latex(T)} \\begin{{pmatrix}} {v1} \\\\ {v2} \\end{{pmatrix}} = \\begin{{pmatrix}} {a_val}({v1}) + {b_val}({v2}) \\\\ {c_val}({v1}) + {d_val}({v2}) \\end{{pmatrix}}$",
            f"$= \\begin{{pmatrix}} {result1} \\\\ {result2} \\end{{pmatrix}}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1100, 1250),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )

emit(generate())