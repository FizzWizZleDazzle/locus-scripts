"""
linear_algebra - vector_spaces (medium)
Generated: 2026-02-22T05:53:56.640327
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Linear independence check for 2-3 vectors in R^2 or R^3
        dim = choice([2, 3])
        num_vecs = choice([2, 3])
        
        if randint(0, 1) == 0:  # Make linearly dependent
            if dim == 2:
                v1_vals = [nonzero(-4, 4), nonzero(-4, 4)]
                scalar = choice([2, 3, -2, -3])
                v2_vals = [scalar * v1_vals[0], scalar * v1_vals[1]]
                vectors = [Matrix(v1_vals), Matrix(v2_vals)]
                ans = False
            else:  # dim == 3
                v1_vals = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
                v2_vals = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
                # Make v3 a linear combination
                s1, s2 = choice([1, 2, -1]), choice([1, 2, -1])
                v3_vals = [s1*v1_vals[0] + s2*v2_vals[0], 
                          s1*v1_vals[1] + s2*v2_vals[1],
                          s1*v1_vals[2] + s2*v2_vals[2]]
                vectors = [Matrix(v1_vals), Matrix(v2_vals), Matrix(v3_vals)]
                ans = False
        else:  # Make linearly independent
            if dim == 2 and num_vecs == 2:
                v1_vals = [nonzero(-4, 4), nonzero(-4, 4)]
                v2_vals = [nonzero(-4, 4), nonzero(-4, 4)]
                # Ensure not parallel
                while v1_vals[0] * v2_vals[1] == v1_vals[1] * v2_vals[0]:
                    v2_vals = [nonzero(-4, 4), nonzero(-4, 4)]
                vectors = [Matrix(v1_vals), Matrix(v2_vals)]
                ans = True
            else:  # 3D
                v1_vals = [1, 0, 0]
                v2_vals = [0, 1, 0]
                if num_vecs == 3:
                    v3_vals = [0, 0, 1]
                    vectors = [Matrix(v1_vals), Matrix(v2_vals), Matrix(v3_vals)]
                else:
                    vectors = [Matrix(v1_vals), Matrix(v2_vals)]
                ans = True
        
        vec_strs = [f"\\begin{{bmatrix}} {' \\\\ '.join(map(str, v))} \\end{{bmatrix}}" 
                    for v in vectors]
        question = f"Are the vectors {', '.join(vec_strs)} linearly independent?"
        
        M = Matrix.hstack(*vectors)
        rref_M = M.rref()[0]
        
        solution = steps(
            f"Form matrix with vectors as columns: ${latex(M)}$",
            f"Reduce to RREF: ${latex(rref_M)}$",
            f"{'All columns have pivots, so vectors are linearly independent.' if ans else 'Not all columns have pivots, so vectors are linearly dependent.'}"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1450),
            topic="linear_algebra/vector_spaces",
            solution=solution
        )
    
    elif problem_type == 2:
        # Find basis for span of vectors
        dim = choice([2, 3])
        
        if dim == 2:
            v1_vals = [nonzero(-3, 3), nonzero(-3, 3)]
            scalar = choice([2, 3, -2])
            v2_vals = [scalar * v1_vals[0], scalar * v1_vals[1]]
            v3_vals = [nonzero(-3, 3), nonzero(-3, 3)]
            while v3_vals[0] * v1_vals[1] == v3_vals[1] * v1_vals[0]:
                v3_vals = [nonzero(-3, 3), nonzero(-3, 3)]
            
            vectors = [Matrix(v1_vals), Matrix(v2_vals), Matrix(v3_vals)]
            basis = [Matrix(v1_vals), Matrix(v3_vals)]
        else:
            v1_vals = [1, 0, 0]
            v2_vals = [0, 1, 0]
            v3_vals = [1, 1, 0]
            vectors = [Matrix(v1_vals), Matrix(v2_vals), Matrix(v3_vals)]
            basis = [Matrix(v1_vals), Matrix(v2_vals)]
        
        vec_strs = [f"\\begin{{bmatrix}} {' \\\\ '.join(map(str, v))} \\end{{bmatrix}}" 
                    for v in vectors]
        question = f"Find a basis for the span of {', '.join(vec_strs)}. Enter your answer as a list of column vectors."
        
        ans = basis
        
        M = Matrix.hstack(*vectors)
        rref_M = M.rref()[0]
        
        solution = steps(
            f"Form matrix with vectors as columns: ${latex(M)}$",
            f"Reduce to RREF: ${latex(rref_M)}$",
            f"Pivot columns correspond to basis vectors",
            f"Basis: {', '.join([latex(v) for v in basis])}"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1550),
            topic="linear_algebra/vector_spaces",
            solution=solution
        )
    
    elif problem_type == 3:
        # Determine dimension of subspace
        dim = choice([3, 4])
        
        if dim == 3:
            # Span of 2 independent vectors in R^3
            v1_vals = [1, 0, nonzero(-2, 2)]
            v2_vals = [0, 1, nonzero(-2, 2)]
            ans = 2
            vectors = [Matrix(v1_vals), Matrix(v2_vals)]
        else:
            # Span of 3 independent vectors in R^4
            v1_vals = [1, 0, 0, 0]
            v2_vals = [0, 1, 0, 0]
            v3_vals = [0, 0, 1, 0]
            ans = 3
            vectors = [Matrix(v1_vals), Matrix(v2_vals), Matrix(v3_vals)]
        
        vec_strs = [f"\\begin{{bmatrix}} {' \\\\ '.join(map(str, v))} \\end{{bmatrix}}" 
                    for v in vectors]
        question = f"What is the dimension of the subspace spanned by {', '.join(vec_strs)}?"
        
        M = Matrix.hstack(*vectors)
        
        solution = steps(
            f"Form matrix with vectors as columns: ${latex(M)}$",
            f"Count the number of linearly independent vectors",
            f"The dimension is ${ans}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1300, 1450),
            topic="linear_algebra/vector_spaces",
            solution=solution
        )
    
    elif problem_type == 4:
        # Check if vector is in span
        v1_vals = [1, 0, nonzero(-2, 2)]
        v2_vals = [0, 1, nonzero(-2, 2)]
        
        if randint(0, 1) == 0:  # In span
            c1, c2 = nonzero(-3, 3), nonzero(-3, 3)
            test_vals = [c1 * v1_vals[0] + c2 * v2_vals[0],
                        c1 * v1_vals[1] + c2 * v2_vals[1],
                        c1 * v1_vals[2] + c2 * v2_vals[2]]
            ans = True
        else:  # Not in span
            test_vals = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
            # Make sure third component doesn't match
            while test_vals[2] == test_vals[0] * v1_vals[2] + test_vals[1] * v2_vals[2]:
                test_vals[2] = nonzero(-3, 3)
            ans = False
        
        v1 = Matrix(v1_vals)
        v2 = Matrix(v2_vals)
        test = Matrix(test_vals)
        
        vec_strs = [f"\\begin{{bmatrix}} {' \\\\ '.join(map(str, v))} \\end{{bmatrix}}" 
                    for v in [v1, v2]]
        test_str = f"\\begin{{bmatrix}} {' \\\\ '.join(map(str, test))} \\end{{bmatrix}}"
        
        question = f"Is the vector {test_str} in the span of {', '.join(vec_strs)}?"
        
        M = Matrix.hstack(v1, v2, test)
        rref_M = M.rref()[0]
        
        solution = steps(
            f"Form augmented matrix: ${latex(M)}$",
            f"Reduce to RREF: ${latex(rref_M)}$",
            f"{'The system is consistent, so the vector is in the span.' if ans else 'The system is inconsistent, so the vector is not in the span.'}"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1350, 1500),
            topic="linear_algebra/vector_spaces",
            solution=solution
        )
    
    else:  # problem_type == 5
        # Find coordinates relative to a basis
        # Simple basis in R^2
        b1_vals = [1, nonzero(-2, 2)]
        b2_vals = [0, 1]
        
        c1, c2 = nonzero(-3, 3), nonzero(-3, 3)
        v_vals = [c1 * b1_vals[0] + c2 * b2_vals[0],
                 c1 * b1_vals[1] + c2 * b2_vals[1]]
        
        b1 = Matrix(b1_vals)
        b2 = Matrix(b2_vals)
        v = Matrix(v_vals)
        
        ans = Matrix([c1, c2])
        
        basis_strs = [f"\\begin{{bmatrix}} {' \\\\ '.join(map(str, vec))} \\end{{bmatrix}}" 
                     for vec in [b1, b2]]
        v_str = f"\\begin{{bmatrix}} {' \\\\ '.join(map(str, v))} \\end{{bmatrix}}"
        
        question = f"Find the coordinates of {v_str} relative to the basis $\\mathcal{{B}} = \\{{ {', '.join(basis_strs)} \\}}$. Enter as a column vector."
        
        P = Matrix.hstack(b1, b2)
        
        solution = steps(
            f"We need to solve ${latex(P)} \\mathbf{{c}} = {latex(v)}$",
            f"where $\\mathbf{{c}} = \\begin{{bmatrix}} c_1 \\\\ c_2 \\end{{bmatrix}}$",
            f"Solving gives $\\mathbf{{c}} = {latex(ans)}$"
        )
        
        return problem(
            question=question,
            answer=ans,
            difficulty=(1400, 1600),
            topic="linear_algebra/vector_spaces",
            solution=solution
        )

emit(generate())