"""
linear_algebra - matrix_arithmetic (medium)
Generated: 2026-02-22T05:49:47.087911
"""

from problem_utils import *

def generate():
    problem_type = choice(['add', 'subtract', 'scalar_mult', 'matrix_mult', 'transpose'])
    
    if problem_type == 'add':
        rows = randint(2, 3)
        cols = randint(2, 3)
        
        A_entries = [[nonzero(-8, 8) for _ in range(cols)] for _ in range(rows)]
        B_entries = [[nonzero(-8, 8) for _ in range(cols)] for _ in range(rows)]
        
        A = Matrix(A_entries)
        B = Matrix(B_entries)
        ans = A + B
        
        return problem(
            question=f"Compute $A + B$ where $A = {latex(A)}$ and $B = {latex(B)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                f"Add corresponding entries:",
                f"${latex(ans)}$"
            ),
        )
    
    elif problem_type == 'subtract':
        rows = randint(2, 3)
        cols = randint(2, 3)
        
        A_entries = [[nonzero(-8, 8) for _ in range(cols)] for _ in range(rows)]
        B_entries = [[nonzero(-8, 8) for _ in range(cols)] for _ in range(rows)]
        
        A = Matrix(A_entries)
        B = Matrix(B_entries)
        ans = A - B
        
        return problem(
            question=f"Compute $A - B$ where $A = {latex(A)}$ and $B = {latex(B)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                f"Subtract corresponding entries:",
                f"${latex(ans)}$"
            ),
        )
    
    elif problem_type == 'scalar_mult':
        rows = randint(2, 3)
        cols = randint(2, 3)
        scalar = nonzero(-5, 5)
        
        A_entries = [[nonzero(-6, 6) for _ in range(cols)] for _ in range(rows)]
        A = Matrix(A_entries)
        ans = scalar * A
        
        return problem(
            question=f"Compute ${scalar} \\cdot A$ where $A = {latex(A)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                f"Multiply each entry by ${scalar}$:",
                f"${latex(ans)}$"
            ),
        )
    
    elif problem_type == 'matrix_mult':
        m = randint(2, 3)
        n = randint(2, 3)
        p = randint(2, 3)
        
        A_entries = [[nonzero(-5, 5) for _ in range(n)] for _ in range(m)]
        B_entries = [[nonzero(-5, 5) for _ in range(p)] for _ in range(n)]
        
        A = Matrix(A_entries)
        B = Matrix(B_entries)
        ans = A * B
        
        solution_text = f"The product is a ${m} \\times {p}$ matrix.<br>"
        solution_text += f"Compute each entry using row-column multiplication:<br>"
        solution_text += f"${latex(ans)}$"
        
        return problem(
            question=f"Compute $AB$ where $A = {latex(A)}$ and $B = {latex(B)}$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="linear_algebra/matrix_arithmetic",
            solution=solution_text,
        )
    
    else:  # transpose
        rows = randint(2, 3)
        cols = randint(2, 3)
        
        if rows == cols:
            cols = rows + 1
        
        A_entries = [[nonzero(-8, 8) for _ in range(cols)] for _ in range(rows)]
        A = Matrix(A_entries)
        ans = A.T
        
        return problem(
            question=f"Find the transpose $A^T$ of $A = {latex(A)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="linear_algebra/matrix_arithmetic",
            solution=steps(
                f"Swap rows and columns:",
                f"$A^T = {latex(ans)}$"
            ),
        )

emit(generate())