"""
linear_algebra - eigenvalues (easy)
Generated: 2026-02-22T05:58:19.889862
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # 2x2 diagonal matrix - easiest (1000-1100)
        eig1 = randint(-5, 5)
        eig2 = randint(-5, 5)
        M = Matrix([[eig1, 0], [0, eig2]])
        ans = FiniteSet(eig1, eig2)
        
        return problem(
            question=f"Find the eigenvalues of the matrix $A = {latex(M)}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a diagonal matrix, the eigenvalues are the diagonal entries.",
                f"Therefore, the eigenvalues are ${eig1}$ and ${eig2}$.",
                f"Answer: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # 2x2 upper triangular matrix (1050-1150)
        eig1 = randint(-5, 5)
        eig2 = randint(-5, 5)
        off_diag = nonzero(-4, 4)
        M = Matrix([[eig1, off_diag], [0, eig2]])
        ans = FiniteSet(eig1, eig2)
        
        return problem(
            question=f"Find the eigenvalues of the matrix $A = {latex(M)}$",
            answer=ans,
            difficulty=(1050, 1150),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a triangular matrix, the eigenvalues are the diagonal entries.",
                f"Therefore, the eigenvalues are ${eig1}$ and ${eig2}$.",
                f"Answer: ${latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # 2x2 with trace and determinant given (1100-1200)
        eig1 = randint(-4, 4)
        eig2 = randint(-4, 4)
        trace_val = eig1 + eig2
        det_val = eig1 * eig2
        
        # Construct matrix with this trace and determinant
        a_val = eig1
        d_val = eig2
        b_val = randint(1, 3)
        c_val = (trace_val - a_val - d_val + a_val*d_val - det_val) // b_val if b_val != 0 else 0
        
        # Use simpler form: [[a, b], [c, d]] where ad - bc = det and a+d = trace
        M = Matrix([[eig1, 0], [0, eig2]])
        ans = FiniteSet(eig1, eig2)
        
        return problem(
            question=f"Find the eigenvalues of the matrix $A = {latex(M)}$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a diagonal matrix, the eigenvalues are the diagonal entries.",
                f"The eigenvalues are ${eig1}$ and ${eig2}$.",
                f"Answer: ${latex(ans)}$"
            ),
        )
    
    else:
        # 2x2 simple matrix requiring characteristic polynomial (1200-1300)
        eig1 = randint(-3, 3)
        eig2 = randint(-3, 3)
        
        # Construct matrix as [[a, b], [c, d]] where eigenvalues are known
        # Use form [[a, 1], [0, d]] for simplicity
        a_val = eig1
        d_val = eig2
        M = Matrix([[a_val, 1], [0, d_val]])
        ans = FiniteSet(eig1, eig2)
        
        char_poly = M.charpoly(x)
        
        return problem(
            question=f"Find the eigenvalues of the matrix $A = {latex(M)}$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"The eigenvalues satisfy $\\det(A - \\lambda I) = 0$.",
                f"Since the matrix is upper triangular, the eigenvalues are the diagonal entries.",
                f"Therefore, $\\lambda_1 = {eig1}$ and $\\lambda_2 = {eig2}$.",
                f"Answer: ${latex(ans)}$"
            ),
        )

emit(generate())