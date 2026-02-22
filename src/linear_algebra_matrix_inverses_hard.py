"""
linear_algebra - matrix_inverses (hard)
Generated: 2026-02-22T05:51:49.647760
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # 3x3 matrix inverse with one parameter to find
        # Given that A is invertible and A^(-1) has a specific form, find the parameter
        param_val = nonzero(-3, 3)
        other_vals = [nonzero(-2, 2) for _ in range(8)]
        
        # Construct a nice invertible matrix
        det_val = choice([1, -1, 2, -2])
        A = Matrix([
            [other_vals[0], other_vals[1], other_vals[2]],
            [other_vals[3], other_vals[4], other_vals[5]],
            [other_vals[6], other_vals[7], param_val]
        ])
        
        # Make sure it's invertible by construction
        A = Matrix([
            [2, 1, 0],
            [1, nonzero(-2, 2), 1],
            [0, 1, param_val]
        ])
        
        # Ensure det != 0
        det_A = A.det()
        if det_A == 0:
            param_val = nonzero(-3, 3)
            A[2, 2] = param_val
        
        A_inv = A.inv()
        target_entry = A_inv[randint(0, 2), randint(0, 2)]
        
        question = f"Let $A = {latex(A)}$. Find the $({randint(1,3)},{randint(1,3)})$ entry of $A^{{-1}}$."
        
        return problem(
            question=f"Let $A = {latex(A)}$. If $A$ is invertible, compute $A^{{-1}}$ and find its $(2,3)$ entry.",
            answer=A_inv[1, 2],
            difficulty=(1600, 1700),
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"Compute $\\det(A) = {latex(A.det())}$",
                f"Since $\\det(A) \\neq 0$, the inverse exists",
                f"Using the formula $A^{{-1}} = \\frac{{1}}{{\\det(A)}} \\text{{adj}}(A)$",
                f"$A^{{-1}} = {latex(A_inv)}$",
                f"The $(2,3)$ entry is ${latex(A_inv[1,2])}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 2:
        # Find unknown entries given A * A_inv = I
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        
        # Create 2x2 matrix with unknowns
        det_val = nonzero(-4, 4)
        A = Matrix([[a_val, b_val], [nonzero(-2, 2), det_val]])
        
        # Ensure invertible
        while A.det() == 0:
            A[1, 0] = nonzero(-2, 2)
        
        A_inv = A.inv()
        
        # Hide one entry and ask for it
        i, j = randint(0, 1), randint(0, 1)
        hidden = A_inv[i, j]
        
        return problem(
            question=f"Let $A = {latex(A)}$ and suppose $A \\cdot B = I$ where $I$ is the identity matrix. Find the $({i+1},{j+1})$ entry of $B$.",
            answer=hidden,
            difficulty=(1650, 1750),
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"Since $A \\cdot B = I$, we have $B = A^{{-1}}$",
                f"Compute $\\det(A) = {latex(A.det())}$",
                f"$A^{{-1}} = \\frac{{1}}{{{latex(A.det())}}} {latex(A.det() * A_inv)}$",
                f"$A^{{-1}} = {latex(A_inv)}$",
                f"The $({i+1},{j+1})$ entry is ${latex(hidden)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 3:
        # 3x3 inverse using row operations
        # Create from a simple diagonal or triangular matrix
        diag_vals = [nonzero(-2, 2) for _ in range(3)]
        A = Matrix([
            [diag_vals[0], nonzero(-1, 1), nonzero(-1, 1)],
            [0, diag_vals[1], nonzero(-1, 1)],
            [0, 0, diag_vals[2]]
        ])
        
        A_inv = A.inv()
        
        return problem(
            question=f"Find the inverse of $A = {latex(A)}$.",
            answer=A_inv,
            difficulty=(1700, 1800),
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"Since $A$ is upper triangular, $\\det(A) = {latex(A.det())}$",
                f"Using augmented matrix $[A|I]$ and row reduction:",
                f"After row operations, we obtain:",
                f"$A^{{-1}} = {latex(A_inv)}$"
            ),
            answer_type="matrix",
            calculator="scientific"
        )
    
    elif problem_type == 4:
        # Matrix equation solving: Given A^(-1), solve AX = B
        A = Matrix([
            [nonzero(-2, 2), nonzero(-1, 2)],
            [nonzero(-2, 2), nonzero(-2, 2)]
        ])
        
        while A.det() == 0:
            A[1, 1] = nonzero(-2, 2)
        
        A_inv = A.inv()
        B = Matrix([nonzero(-3, 3), nonzero(-3, 3)])
        X = A_inv * B
        
        return problem(
            question=f"Given that $A = {latex(A)}$ and $B = {latex(B)}$, solve for the matrix $X$ in the equation $AX = B$.",
            answer=X,
            difficulty=(1650, 1750),
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"Multiply both sides by $A^{{-1}}$: $A^{{-1}}AX = A^{{-1}}B$",
                f"This gives $X = A^{{-1}}B$",
                f"Compute $A^{{-1}} = {latex(A_inv)}$",
                f"$X = {latex(A_inv)} {latex(B)} = {latex(X)}$"
            ),
            answer_type="matrix",
            calculator="scientific"
        )
    
    else:
        # Condition for invertibility: find parameter value
        k_val = nonzero(-4, 4)
        A = Matrix([
            [2, 1, k],
            [1, k, 1],
            [k, 1, 2]
        ])
        
        det_expr = A.det()
        # Solve for when det = 0
        singular_values = solve(det_expr, k)
        
        if len(singular_values) > 0 and singular_values[0].is_real:
            bad_k = singular_values[0]
            return problem(
                question=f"For what value of $k$ is the matrix $A = {latex(A)}$ NOT invertible?",
                answer=bad_k,
                difficulty=(1700, 1850),
                topic="linear_algebra/matrix_inverses",
                solution=steps(
                    f"A matrix is not invertible when $\\det(A) = 0$",
                    f"Compute $\\det(A) = {latex(det_expr)}$",
                    f"Set $\\det(A) = 0$ and solve:",
                    f"${latex(det_expr)} = 0$",
                    f"$k = {latex(bad_k)}$"
                ),
                calculator="scientific"
            )
        else:
            # Fallback to a simpler determinant problem
            A = Matrix([[1, 2, k], [0, k, 1], [1, 0, 1]])
            det_expr = A.det()
            singular_values = solve(det_expr, k)
            bad_k = singular_values[0] if singular_values else 0
            
            return problem(
                question=f"For what value of $k$ is the matrix $A = {latex(A)}$ singular (non-invertible)?",
                answer=bad_k,
                difficulty=(1750, 1850),
                topic="linear_algebra/matrix_inverses",
                solution=steps(
                    f"A matrix is singular when $\\det(A) = 0$",
                    f"$\\det(A) = {latex(det_expr)}$",
                    f"Solving ${latex(det_expr)} = 0$ gives $k = {latex(bad_k)}$"
                ),
                calculator="scientific"
            )

emit(generate())