"""
linear_algebra - diagonalization (easy)
Generated: 2026-02-22T05:59:32.910958
"""

from problem_utils import *

def generate():
    prob_type = randint(1, 4)
    
    if prob_type == 1:
        # Type 1: Check if a matrix is diagonal (1000-1100)
        # Generate a diagonal matrix and ask if it's diagonal
        n = randint(2, 3)
        diag_vals = [nonzero(-5, 5) for _ in range(n)]
        M = Matrix.diag(*diag_vals)
        
        return problem(
            question=f"Is the matrix $A = {latex(M)}$ a diagonal matrix? (Answer true or false)",
            answer=True,
            difficulty=(1000, 1100),
            topic="linear_algebra/diagonalization",
            solution=steps(
                "A matrix is diagonal if all off-diagonal entries are zero",
                f"Matrix $A$ has entries ${latex(M)}$",
                "All off-diagonal entries are 0",
                "Therefore, $A$ is diagonal"
            ),
        )
    
    elif prob_type == 2:
        # Type 2: Find eigenvalues of a 2x2 diagonal matrix (1100-1200)
        # For diagonal matrices, eigenvalues are the diagonal entries
        d1, d2 = nonzero(-5, 5), nonzero(-5, 5)
        M = Matrix([[d1, 0], [0, d2]])
        eigenvals = sorted([d1, d2])
        ans = FiniteSet(*eigenvals)
        
        return problem(
            question=f"Find all eigenvalues of the diagonal matrix $A = {latex(M)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="linear_algebra/diagonalization",
            solution=steps(
                "For a diagonal matrix, the eigenvalues are the diagonal entries",
                f"The diagonal entries are ${d1}$ and ${d2}$",
                f"Therefore, the eigenvalues are ${latex(ans)}$"
            ),
        )
    
    elif prob_type == 3:
        # Type 3: Check if a given vector is an eigenvector of a diagonal matrix (1200-1300)
        d1, d2 = nonzero(-5, 5), nonzero(-5, 5)
        while d1 == d2:
            d2 = nonzero(-5, 5)
        
        M = Matrix([[d1, 0], [0, d2]])
        
        # Create a standard basis vector as eigenvector
        if randint(0, 1) == 0:
            v = Matrix([1, 0])
            eigenval = d1
        else:
            v = Matrix([0, 1])
            eigenval = d2
        
        Av = M * v
        
        return problem(
            question=f"Is $v = {latex(v)}$ an eigenvector of $A = {latex(M)}$? (Answer true or false)",
            answer=True,
            difficulty=(1200, 1300),
            topic="linear_algebra/diagonalization",
            solution=steps(
                f"Compute $Av = {latex(M)} {latex(v)} = {latex(Av)}$",
                f"We have $Av = {latex(Av)} = {eigenval} {latex(v)}$",
                f"Since $Av = \\lambda v$ with $\\lambda = {eigenval}$, $v$ is an eigenvector"
            ),
        )
    
    else:
        # Type 4: Identify which matrix is already diagonalized (1100-1200)
        d1, d2 = nonzero(-5, 5), nonzero(-5, 5)
        diag_matrix = Matrix([[d1, 0], [0, d2]])
        
        # Create a non-diagonal matrix
        a, b = nonzero(-4, 4), nonzero(-4, 4)
        non_diag = Matrix([[d1, b], [0, d2]])
        
        return problem(
            question=f"Which matrix is in diagonal form: $A = {latex(diag_matrix)}$ or $B = {latex(non_diag)}$? (Answer A or B)",
            answer="A",
            difficulty=(1100, 1200),
            topic="linear_algebra/diagonalization",
            solution=steps(
                "A matrix is in diagonal form if all off-diagonal entries are zero",
                f"Matrix $A = {latex(diag_matrix)}$ has only diagonal entries",
                f"Matrix $B = {latex(non_diag)}$ has off-diagonal entry ${b}$ in position (1,2)",
                "Therefore, $A$ is in diagonal form"
            ),
        )

emit(generate())