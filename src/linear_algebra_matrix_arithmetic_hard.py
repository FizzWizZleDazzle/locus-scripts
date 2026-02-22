"""
linear_algebra - matrix_arithmetic (hard)
Generated: 2026-02-22T05:50:22.459850
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Matrix multiplication with parameters, then find determinant
        # 1600-1700 difficulty
        size = choice([2, 3])
        if size == 2:
            # Create two 2x2 matrices
            A = Matrix([[nonzero(-3, 3), nonzero(-3, 3)],
                       [nonzero(-3, 3), nonzero(-3, 3)]])
            B = Matrix([[nonzero(-3, 3), nonzero(-3, 3)],
                       [nonzero(-3, 3), nonzero(-3, 3)]])
            C = A * B
            ans = C.det()
            
            return problem(
                question=f"Let $A = {latex(A)}$ and $B = {latex(B)}$. Find $\\det(AB)$.",
                answer=ans,
                difficulty=(1600, 1700),
                topic="linear_algebra/matrix_arithmetic",
                solution=steps(
                    f"First compute $AB$:",
                    f"$AB = {latex(A)} {latex(B)} = {latex(C)}$",
                    f"Now find the determinant:",
                    f"$\\det(AB) = {ans}$"
                ),
                calculator="scientific"
            )
        else:
            # 3x3 matrices
            A = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
            B = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
            C = A * B
            ans = C.det()
            
            return problem(
                question=f"Let $A = {latex(A)}$ and $B = {latex(B)}$. Find $\\det(AB)$.",
                answer=ans,
                difficulty=(1700, 1800),
                topic="linear_algebra/matrix_arithmetic",
                solution=steps(
                    f"First compute $AB$:",
                    f"$AB = {latex(C)}$",
                    f"Now find the determinant:",
                    f"$\\det(AB) = {ans}$"
                ),
                calculator="scientific"
            )
    
    elif problem_type == 2:
        # Solve for scalar in matrix equation: k*A + B = C
        # 1650-1750 difficulty
        size = choice([2, 3])
        if size == 2:
            A = Matrix([[nonzero(-3, 3), nonzero(-3, 3)],
                       [nonzero(-3, 3), nonzero(-3, 3)]])
            B = Matrix([[nonzero(-3, 3), nonzero(-3, 3)],
                       [nonzero(-3, 3), nonzero(-3, 3)]])
            k_val = nonzero(-4, 4)
            C = k_val * A + B
            ans = k_val
            
            return problem(
                question=f"Find the scalar $k$ such that $kA + B = C$, where $A = {latex(A)}$, $B = {latex(B)}$, and $C = {latex(C)}$.",
                answer=ans,
                difficulty=(1650, 1750),
                topic="linear_algebra/matrix_arithmetic",
                solution=steps(
                    f"We need $kA + B = C$",
                    f"Rearranging: $kA = C - B$",
                    f"$C - B = {latex(C - B)}$",
                    f"$A = {latex(A)}$",
                    f"Comparing entries: $k = {ans}$"
                )
            )
        else:
            A = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
            B = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
            k_val = nonzero(-3, 3)
            C = k_val * A + B
            ans = k_val
            
            return problem(
                question=f"Find the scalar $k$ such that $kA + B = C$, where $A = {latex(A)}$, $B = {latex(B)}$, and $C = {latex(C)}$.",
                answer=ans,
                difficulty=(1700, 1800),
                topic="linear_algebra/matrix_arithmetic",
                solution=steps(
                    f"We need $kA + B = C$",
                    f"Rearranging: $kA = C - B$",
                    f"$C - B = {latex(C - B)}$",
                    f"Using the (1,1) entry: $k \\cdot {A[0,0]} = {(C-B)[0,0]}$",
                    f"Therefore $k = {ans}$"
                )
            )
    
    elif problem_type == 3:
        # Matrix power computation
        # 1700-1850 difficulty
        # Use diagonal or simple structure for feasibility
        diag_vals = [nonzero(-3, 3) for _ in range(2)]
        power = randint(3, 5)
        A = Matrix([[diag_vals[0], 0],
                   [0, diag_vals[1]]])
        ans = A ** power
        
        return problem(
            question=f"Compute $A^{{{power}}}$ where $A = {latex(A)}$.",
            answer=ans,
            difficulty=(1700, 1800),
            topic="linear_algebra/matrix_arithmetic",
            answer_type="matrix",
            solution=steps(
                f"Since $A$ is diagonal, $A^{{{power}}}$ is also diagonal",
                f"Each diagonal entry is raised to the power {power}:",
                f"$A^{{{power}}} = {latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Linear combination: find coefficients such that aA + bB = C
        # 1750-1850 difficulty
        A = Matrix([[1, 0], [0, 1]])  # Identity
        B = Matrix([[nonzero(-2, 2), nonzero(-2, 2)],
                   [nonzero(-2, 2), nonzero(-2, 2)]])
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        C = a_val * A + b_val * B
        ans = (a_val, b_val)
        
        return problem(
            question=f"Find scalars $a$ and $b$ such that $aI + bB = C$, where $I$ is the $2 \\times 2$ identity matrix, $B = {latex(B)}$, and $C = {latex(C)}$. Enter your answer as an ordered pair $(a, b)$.",
            answer=ans,
            difficulty=(1750, 1850),
            topic="linear_algebra/matrix_arithmetic",
            answer_type="tuple",
            solution=steps(
                f"We have $aI + bB = C$",
                f"$a\\begin{{bmatrix}} 1 & 0 \\\\ 0 & 1 \\end{{bmatrix}} + b{latex(B)} = {latex(C)}$",
                f"From the (1,1) entry: $a + b \\cdot {B[0,0]} = {C[0,0]}$",
                f"From the (1,2) entry: $b \\cdot {B[0,1]} = {C[0,1]}$",
                f"Solving: $b = {b_val}$ and $a = {a_val}$",
                f"Answer: $(a, b) = {ans}$"
            )
        )
    
    elif problem_type == 5:
        # Trace of matrix product/sum
        # 1650-1750 difficulty
        A = Matrix([[nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)],
                   [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)],
                   [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]])
        B = Matrix([[nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)],
                   [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)],
                   [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]])
        C = A * B
        ans = C.trace()
        
        return problem(
            question=f"Find $\\text{{tr}}(AB)$ where $A = {latex(A)}$ and $B = {latex(B)}$.",
            answer=ans,
            difficulty=(1650, 1750),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                f"First compute $AB = {latex(C)}$",
                f"The trace is the sum of diagonal entries:",
                f"$\\text{{tr}}(AB) = {C[0,0]} + {C[1,1]} + {C[2,2]} = {ans}$"
            ),
            calculator="scientific"
        )
    
    else:
        # Matrix equation: solve for X in AX + B = C
        # 1800-1900 difficulty
        A = Matrix([[nonzero(-2, 2), nonzero(-2, 2)],
                   [nonzero(-2, 2), nonzero(-2, 2)]])
        while A.det() == 0:
            A = Matrix([[nonzero(-2, 2), nonzero(-2, 2)],
                       [nonzero(-2, 2), nonzero(-2, 2)]])
        
        X = Matrix([[nonzero(-3, 3), nonzero(-3, 3)],
                   [nonzero(-3, 3), nonzero(-3, 3)]])
        B = Matrix([[nonzero(-3, 3), nonzero(-3, 3)],
                   [nonzero(-3, 3), nonzero(-3, 3)]])
        C = A * X + B
        ans = X
        
        return problem(
            question=f"Solve for the matrix $X$ in the equation $AX + B = C$, where $A = {latex(A)}$, $B = {latex(B)}$, and $C = {latex(C)}$.",
            answer=ans,
            difficulty=(1800, 1900),
            topic="linear_algebra/matrix_arithmetic",
            answer_type="matrix",
            solution=steps(
                f"Rearranging: $AX = C - B$",
                f"$C - B = {latex(C - B)}$",
                f"Multiply both sides by $A^{{-1}}$:",
                f"$X = A^{{-1}}(C - B)$",
                f"$A^{{-1}} = {latex(A.inv())}$",
                f"$X = {latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())