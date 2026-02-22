"""
linear_algebra - linear_independence (hard)
Generated: 2026-02-22T05:58:04.310631
"""

from problem_utils import *

def generate():
    problem_type = choice(['vectors_3d', 'vectors_4d', 'parameter_check', 'prove_dependent'])
    
    if problem_type == 'vectors_3d':
        # Create 3 vectors in R^3 where one is a linear combination of the others
        # Start with 2 independent vectors, make the third a combination
        v1_coords = [nonzero(-3, 3) for _ in range(3)]
        v2_coords = [nonzero(-3, 3) for _ in range(3)]
        
        # Make sure v1 and v2 are not parallel
        while all(v1_coords[i] * v2_coords[0] == v1_coords[0] * v2_coords[i] for i in range(3)):
            v2_coords = [nonzero(-3, 3) for _ in range(3)]
        
        # Create v3 as a linear combination
        alpha = nonzero(-2, 2)
        beta = nonzero(-2, 2)
        v3_coords = [alpha * v1_coords[i] + beta * v2_coords[i] for i in range(3)]
        
        v1 = Matrix(v1_coords)
        v2 = Matrix(v2_coords)
        v3 = Matrix(v3_coords)
        
        return problem(
            question=f"Determine whether the vectors ${latex(v1.T)}$, ${latex(v2.T)}$, and ${latex(v3.T)}$ are linearly independent in $\\mathbb{{R}}^3$.",
            answer=False,
            difficulty=(1600, 1750),
            topic="linear_algebra/linear_independence",
            solution=steps(
                f"Form the matrix $A = {latex(Matrix([v1.T, v2.T, v3.T]).T)}$",
                f"Compute the determinant: $\\det(A) = {latex(v1.T.row_join(v2.T).row_join(v3.T).T.det())}$",
                f"Since the determinant is zero, the vectors are linearly dependent.",
            ),
            answer_type="boolean",
        )
    
    elif problem_type == 'vectors_4d':
        # Create 4 vectors in R^4, asking if they span R^4
        # Make them linearly independent (full rank)
        while True:
            vectors = [[nonzero(-2, 2) for _ in range(4)] for _ in range(4)]
            M = Matrix(vectors).T
            if M.det() != 0:
                break
        
        v1, v2, v3, v4 = [Matrix(v) for v in vectors]
        
        return problem(
            question=f"Do the vectors ${latex(v1.T)}$, ${latex(v2.T)}$, ${latex(v3.T)}$, and ${latex(v4.T)}$ form a linearly independent set in $\\mathbb{{R}}^4$?",
            answer=True,
            difficulty=(1650, 1800),
            topic="linear_algebra/linear_independence",
            solution=steps(
                f"Form the matrix $A = {latex(M)}$",
                f"Compute the determinant: $\\det(A) = {latex(M.det())}$",
                f"Since the determinant is nonzero, the vectors are linearly independent.",
            ),
            answer_type="boolean",
        )
    
    elif problem_type == 'parameter_check':
        # Find value of parameter k that makes vectors dependent
        a1, a2 = nonzero(-3, 3), nonzero(-3, 3)
        b1, b2 = nonzero(-3, 3), nonzero(-3, 3)
        
        # Third vector: (c1, c2, k) should be dependent when k = specific value
        # We want det = 0, so a1*b2*k + a2*c1*b3 + c2*b1*a3 - ... = 0
        # Simpler: make third row a combination of first two
        c1, c2 = nonzero(-2, 2), nonzero(-2, 2)
        
        # For linear dependence: the third row should be in span of first two
        # We'll construct so that k is determined by the condition
        a3 = nonzero(-2, 2)
        b3 = nonzero(-2, 2)
        
        # det = a1(b2*k - c2*b3) - a2(b1*k - c1*b3) + a3(b1*c2 - c1*b2)
        # For det = 0: k(a1*b2 - a2*b1) = a1*c2*b3 - a2*c1*b3 - a3(b1*c2 - c1*b2)
        
        det_coeff = a1 * b2 - a2 * b1
        if det_coeff == 0:
            # Regenerate to avoid division by zero
            return generate()
        
        k_value = (a1*c2*b3 - a2*c1*b3 - a3*(b1*c2 - c1*b2)) / det_coeff
        
        if k_value != int(k_value) or abs(k_value) > 10:
            return generate()
        
        k_value = int(k_value)
        
        v1 = Matrix([a1, a2, a3])
        v2 = Matrix([b1, b2, b3])
        v3 = Matrix([c1, c2, k])
        
        return problem(
            question=f"For what value of $k$ are the vectors ${latex(v1.T)}$, ${latex(v2.T)}$, and $({c1}, {c2}, k)$ linearly dependent?",
            answer=k_value,
            difficulty=(1700, 1850),
            topic="linear_algebra/linear_independence",
            solution=steps(
                f"The vectors are linearly dependent when $\\det\\begin{{pmatrix}} {a1} & {b1} & {c1} \\\\ {a2} & {b2} & {c2} \\\\ {a3} & {b3} & k \\end{{pmatrix}} = 0$",
                f"Expanding the determinant: ${a1}({b2} \\cdot k - {c2} \\cdot {b3}) - {a2}({b1} \\cdot k - {c1} \\cdot {b3}) + {a3}({b1} \\cdot {c2} - {c1} \\cdot {b2}) = 0$",
                f"Simplifying: ${det_coeff}k = {-a3*(b1*c2 - c1*b2) + a1*c2*b3 - a2*c1*b3}$",
                f"Therefore, $k = {k_value}$",
            ),
        )
    
    else:  # prove_dependent
        # Give explicit linear combination and ask to verify
        c1, c2, c3 = nonzero(-3, 3), nonzero(-2, 2), nonzero(-2, 2)
        
        v1_coords = [nonzero(-3, 3) for _ in range(3)]
        v2_coords = [nonzero(-3, 3) for _ in range(3)]
        
        # Ensure not parallel
        while all(v1_coords[i] * v2_coords[0] == v1_coords[0] * v2_coords[i] for i in range(3) if v1_coords[0] != 0):
            v2_coords = [nonzero(-3, 3) for _ in range(3)]
        
        v3_coords = [c1 * v1_coords[i] + c2 * v2_coords[i] for i in range(3)]
        
        v1 = Matrix(v1_coords)
        v2 = Matrix(v2_coords)
        v3 = Matrix(v3_coords)
        
        # Compute the rank
        M = Matrix([v1.T, v2.T, v3.T]).T
        rank_val = M.rank()
        
        return problem(
            question=f"What is the rank of the set of vectors $\\{{{latex(v1.T)}, {latex(v2.T)}, {latex(v3.T)}\\}}$ in $\\mathbb{{R}}^3$?",
            answer=rank_val,
            difficulty=(1650, 1800),
            topic="linear_algebra/linear_independence",
            solution=steps(
                f"Form the matrix with vectors as columns: $A = {latex(M)}$",
                f"Row reduce to find the rank",
                f"The rank is ${rank_val}$ (the maximum number of linearly independent vectors)",
            ),
        )

emit(generate())