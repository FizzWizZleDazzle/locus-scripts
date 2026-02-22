"""
linear_algebra - linear_transformations (medium)
Generated: 2026-02-22T06:01:24.126665
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Matrix of a linear transformation given by a formula
        # Difficulty: 1300-1500
        # Find the matrix representation of T: R^2 -> R^2
        
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        d_val = nonzero(-3, 3)
        
        # Create transformation T([x, y]) = [a*x + b*y, c*x + d*y]
        transformation_matrix = Matrix([[a_val, b_val], [c_val, d_val]])
        
        # Format the transformation nicely
        term1_x = f"{a_val}x" if a_val != 1 else "x" if a_val != -1 else "-x"
        term1_y = f"{abs(b_val)}y" if abs(b_val) != 1 else "y"
        sign1 = "+" if b_val > 0 else "-"
        
        term2_x = f"{c_val}x" if c_val != 1 else "x" if c_val != -1 else "-x"
        term2_y = f"{abs(d_val)}y" if abs(d_val) != 1 else "y"
        sign2 = "+" if d_val > 0 else "-"
        
        question = f"Find the standard matrix for the linear transformation $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ defined by $T\\begin{{pmatrix}} x \\\\ y \\end{{pmatrix}} = \\begin{{pmatrix}} {term1_x} {sign1} {term1_y} \\\\ {term2_x} {sign2} {term2_y} \\end{{pmatrix}}$"
        
        solution = steps(
            f"The standard matrix $[T]$ has columns that are the images of the standard basis vectors.",
            f"$T(\\mathbf{{e}}_1) = T\\begin{{pmatrix}} 1 \\\\ 0 \\end{{pmatrix}} = \\begin{{pmatrix}} {a_val} \\\\ {c_val} \\end{{pmatrix}}$",
            f"$T(\\mathbf{{e}}_2) = T\\begin{{pmatrix}} 0 \\\\ 1 \\end{{pmatrix}} = \\begin{{pmatrix}} {b_val} \\\\ {d_val} \\end{{pmatrix}}$",
            f"Therefore, $[T] = {latex(transformation_matrix)}$"
        )
        
        return problem(
            question=question,
            answer=transformation_matrix,
            difficulty=(1300, 1500),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )
    
    elif problem_type == 2:
        # Image of a vector under a transformation
        # Difficulty: 1300-1400
        
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        d_val = nonzero(-3, 3)
        
        v_x = nonzero(-4, 4)
        v_y = nonzero(-4, 4)
        
        transformation_matrix = Matrix([[a_val, b_val], [c_val, d_val]])
        vector = Matrix([v_x, v_y])
        result = transformation_matrix * vector
        
        question = f"Let $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ be the linear transformation with standard matrix ${latex(transformation_matrix)}$. Find $T\\begin{{pmatrix}} {v_x} \\\\ {v_y} \\end{{pmatrix}}$."
        
        solution = steps(
            f"Compute the matrix-vector product:",
            f"$T\\begin{{pmatrix}} {v_x} \\\\ {v_y} \\end{{pmatrix}} = {latex(transformation_matrix)} \\begin{{pmatrix}} {v_x} \\\\ {v_y} \\end{{pmatrix}}$",
            f"$= \\begin{{pmatrix}} {a_val}({v_x}) + {b_val}({v_y}) \\\\ {c_val}({v_x}) + {d_val}({v_y}) \\end{{pmatrix}}$",
            f"$= {latex(result)}$"
        )
        
        return problem(
            question=question,
            answer=result,
            difficulty=(1300, 1400),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )
    
    elif problem_type == 3:
        # Composition of linear transformations
        # Difficulty: 1400-1600
        
        a1, b1 = nonzero(-2, 2), nonzero(-2, 2)
        c1, d1 = nonzero(-2, 2), nonzero(-2, 2)
        
        a2, b2 = nonzero(-2, 2), nonzero(-2, 2)
        c2, d2 = nonzero(-2, 2), nonzero(-2, 2)
        
        T_matrix = Matrix([[a1, b1], [c1, d1]])
        S_matrix = Matrix([[a2, b2], [c2, d2]])
        
        composition = S_matrix * T_matrix
        
        question = f"Let $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ and $S: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ be linear transformations with standard matrices $[T] = {latex(T_matrix)}$ and $[S] = {latex(S_matrix)}$. Find the standard matrix of the composition $S \\circ T$."
        
        solution = steps(
            f"The standard matrix of $S \\circ T$ is $[S][T]$:",
            f"$[S \\circ T] = {latex(S_matrix)} {latex(T_matrix)}$",
            f"$= {latex(composition)}$"
        )
        
        return problem(
            question=question,
            answer=composition,
            difficulty=(1400, 1600),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )
    
    else:
        # Determine if transformation is linear
        # Difficulty: 1500-1600
        # We'll ask about a specific transformation and whether it's linear
        
        transformation_choice = randint(1, 2)
        
        if transformation_choice == 1:
            # Non-linear: T(x, y) = (x + 1, y)
            question = f"Is the transformation $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ defined by $T\\begin{{pmatrix}} x \\\\ y \\end{{pmatrix}} = \\begin{{pmatrix}} x + 1 \\\\ y \\end{{pmatrix}}$ a linear transformation?"
            
            answer = False
            
            solution = steps(
                f"For $T$ to be linear, we need $T(\\mathbf{{0}}) = \\mathbf{{0}}$.",
                f"$T\\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}} = \\begin{{pmatrix}} 0 + 1 \\\\ 0 \\end{{pmatrix}} = \\begin{{pmatrix}} 1 \\\\ 0 \\end{{pmatrix}} \\neq \\begin{{pmatrix}} 0 \\\\ 0 \\end{{pmatrix}}$",
                f"Since $T$ does not map the zero vector to the zero vector, $T$ is not linear."
            )
        else:
            # Non-linear: T(x, y) = (x^2, y)
            question = f"Is the transformation $T: \\mathbb{{R}}^2 \\to \\mathbb{{R}}^2$ defined by $T\\begin{{pmatrix}} x \\\\ y \\end{{pmatrix}} = \\begin{{pmatrix}} x^2 \\\\ y \\end{{pmatrix}}$ a linear transformation?"
            
            answer = False
            
            solution = steps(
                f"For $T$ to be linear, we need $T(c\\mathbf{{v}}) = cT(\\mathbf{{v}})$ for all scalars $c$ and vectors $\\mathbf{{v}}$.",
                f"Let $\\mathbf{{v}} = \\begin{{pmatrix}} 1 \\\\ 0 \\end{{pmatrix}}$ and $c = 2$.",
                f"$T(2\\mathbf{{v}}) = T\\begin{{pmatrix}} 2 \\\\ 0 \\end{{pmatrix}} = \\begin{{pmatrix}} 4 \\\\ 0 \\end{{pmatrix}}$",
                f"$2T(\\mathbf{{v}}) = 2T\\begin{{pmatrix}} 1 \\\\ 0 \\end{{pmatrix}} = 2\\begin{{pmatrix}} 1 \\\\ 0 \\end{{pmatrix}} = \\begin{{pmatrix}} 2 \\\\ 0 \\end{{pmatrix}}$",
                f"Since $T(2\\mathbf{{v}}) \\neq 2T(\\mathbf{{v}})$, $T$ is not linear."
            )
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1500, 1600),
            topic="linear_algebra/linear_transformations",
            solution=solution
        )

emit(generate())