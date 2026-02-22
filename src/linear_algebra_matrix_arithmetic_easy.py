"""
linear_algebra - matrix_arithmetic (easy)
Generated: 2026-02-22T05:49:33.374523
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)
    
    if problem_type == 1:
        # Matrix addition (1000-1100)
        rows, cols = randint(2, 3), randint(2, 3)
        A = Matrix([[randint(-5, 5) for _ in range(cols)] for _ in range(rows)])
        B = Matrix([[randint(-5, 5) for _ in range(cols)] for _ in range(rows)])
        ans = A + B
        
        return problem(
            question=f"Add the matrices: ${latex(A)} + {latex(B)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                "Add corresponding elements:",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # Matrix subtraction (1000-1100)
        rows, cols = randint(2, 3), randint(2, 3)
        A = Matrix([[randint(-5, 5) for _ in range(cols)] for _ in range(rows)])
        B = Matrix([[randint(-5, 5) for _ in range(cols)] for _ in range(rows)])
        ans = A - B
        
        return problem(
            question=f"Subtract the matrices: ${latex(A)} - {latex(B)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                "Subtract corresponding elements:",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # Scalar multiplication (1050-1150)
        scalar = nonzero(-5, 5)
        rows, cols = randint(2, 3), randint(2, 3)
        A = Matrix([[randint(-3, 3) for _ in range(cols)] for _ in range(rows)])
        ans = scalar * A
        
        return problem(
            question=f"Multiply the matrix by the scalar: ${scalar} \\cdot {latex(A)}$",
            answer=ans,
            difficulty=(1050, 1150),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                f"Multiply each element by ${scalar}$:",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 4:
        # Simple 2x2 matrix multiplication (1200-1300)
        A = Matrix([[randint(-3, 3) for _ in range(2)] for _ in range(2)])
        B = Matrix([[randint(-3, 3) for _ in range(2)] for _ in range(2)])
        ans = A * B
        
        return problem(
            question=f"Multiply the matrices: ${latex(A)} \\cdot {latex(B)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                "Use matrix multiplication rule:",
                f"Row 1, Col 1: ${A[0,0]} \\cdot {B[0,0]} + {A[0,1]} \\cdot {B[1,0]} = {ans[0,0]}$",
                f"Row 1, Col 2: ${A[0,0]} \\cdot {B[0,1]} + {A[0,1]} \\cdot {B[1,1]} = {ans[0,1]}$",
                f"Row 2, Col 1: ${A[1,0]} \\cdot {B[0,0]} + {A[1,1]} \\cdot {B[1,0]} = {ans[1,0]}$",
                f"Row 2, Col 2: ${A[1,0]} \\cdot {B[0,1]} + {A[1,1]} \\cdot {B[1,1]} = {ans[1,1]}$",
                f"${latex(ans)}$"
            )
        )
    
    elif problem_type == 5:
        # Matrix transpose (1100-1200)
        rows, cols = randint(2, 3), randint(2, 3)
        A = Matrix([[randint(-5, 5) for _ in range(cols)] for _ in range(rows)])
        ans = A.T
        
        return problem(
            question=f"Find the transpose of ${latex(A)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                "Swap rows and columns:",
                f"${latex(ans)}$"
            )
        )
    
    else:
        # Combined addition and scalar multiplication (1150-1250)
        scalar = nonzero(-4, 4)
        rows, cols = randint(2, 2), randint(2, 2)
        A = Matrix([[randint(-3, 3) for _ in range(cols)] for _ in range(rows)])
        B = Matrix([[randint(-3, 3) for _ in range(cols)] for _ in range(rows)])
        ans = A + scalar * B
        
        return problem(
            question=f"Calculate ${latex(A)} + {scalar} \\cdot {latex(B)}$",
            answer=ans,
            difficulty=(1150, 1250),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                f"First multiply ${latex(B)}$ by ${scalar}$: ${latex(scalar * B)}$",
                f"Then add to ${latex(A)}$:",
                f"${latex(ans)}$"
            )
        )

emit(generate())