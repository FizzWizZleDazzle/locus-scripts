"""
linear_algebra - diagonalization (hard)
Generated: 2026-02-22T06:00:31.678105
"""

from problem_utils import *

def generate():
    problem_type = choice(['diagonalizable_2x2', 'diagonalizable_3x3', 'eigenvector_find', 'power_matrix', 'not_diagonalizable'])
    
    if problem_type == 'diagonalizable_2x2':
        # Create a 2x2 matrix with known eigenvalues and eigenvectors
        lam1 = nonzero(-4, 4)
        lam2 = nonzero(-4, 4)
        while lam2 == lam1:
            lam2 = nonzero(-4, 4)
        
        # Create random eigenvector matrix P
        p11, p12 = nonzero(-3, 3), nonzero(-3, 3)
        p21, p22 = nonzero(-3, 3), nonzero(-3, 3)
        P = Matrix([[p11, p12], [p21, p22]])
        
        # Check if P is invertible
        if P.det() == 0:
            p22 = p22 + nonzero(1, 2)
            P = Matrix([[p11, p12], [p21, p22]])
        
        D = Matrix([[lam1, 0], [0, lam2]])
        A = P * D * P.inv()
        A = simplify(A)
        
        # Answer is the diagonal matrix
        ans = D
        
        return problem(
            question=f"Find the diagonal matrix $D$ such that $A = PDP^{{-1}}$ where $A = {latex(A)}$ and $P = {latex(P)}$",
            answer=fmt_matrix(ans),
            difficulty=(1600, 1750),
            topic="linear_algebra/diagonalization",
            answer_type="matrix",
            solution=steps(
                f"We need to find $D = P^{{-1}}AP$",
                f"First compute $P^{{-1}} = {latex(P.inv())}$",
                f"Then compute $P^{{-1}}A = {latex(P.inv() * A)}$",
                f"Finally $D = (P^{{-1}}A)P = {latex(ans)}$",
                f"The diagonal entries are the eigenvalues: ${lam1}$ and ${lam2}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'diagonalizable_3x3':
        # Create a 3x3 diagonalizable matrix with distinct eigenvalues
        lam1 = nonzero(-3, 3)
        lam2 = nonzero(-3, 3)
        lam3 = nonzero(-3, 3)
        while lam2 == lam1:
            lam2 = nonzero(-3, 3)
        while lam3 == lam1 or lam3 == lam2:
            lam3 = nonzero(-3, 3)
        
        # Simple eigenvectors
        P = Matrix([[1, 0, 1], [0, 1, 0], [1, 1, 1]])
        D = Matrix([[lam1, 0, 0], [0, lam2, 0], [0, 0, lam3]])
        A = P * D * P.inv()
        A = simplify(A)
        
        eigenvalues_set = FiniteSet(lam1, lam2, lam3)
        
        return problem(
            question=f"Find all eigenvalues of the matrix $A = {latex(A)}$",
            answer=fmt_set(eigenvalues_set),
            difficulty=(1650, 1800),
            topic="linear_algebra/diagonalization",
            answer_type="set",
            solution=steps(
                f"Compute the characteristic polynomial $\\det(A - \\lambda I)$",
                f"The characteristic equation is $(\\lambda - {lam1})(\\lambda - {lam2})(\\lambda - {lam3}) = 0$",
                f"The eigenvalues are $\\lambda_1 = {lam1}$, $\\lambda_2 = {lam2}$, $\\lambda_3 = {lam3}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'eigenvector_find':
        # Given matrix and eigenvalue, find eigenvector
        lam_known = nonzero(-3, 3)
        lam_other = nonzero(-3, 3)
        while lam_other == lam_known:
            lam_other = nonzero(-3, 3)
        
        # Construct matrix with known eigenvector [1, k]
        k = nonzero(-3, 3)
        v = Matrix([1, k])
        
        # A*v = lambda*v means [[a, b], [c, d]] * [[1], [k]] = lam_known * [[1], [k]]
        # a + b*k = lam_known
        # c + d*k = lam_known * k
        
        a_val = lam_known - k
        c_val = randint(-2, 2)
        d_val = lam_known * k - c_val
        
        A = Matrix([[a_val, 1], [c_val, d_val]])
        
        # Verify it's an eigenvector
        test = A * v - lam_known * v
        if test != Matrix([0, 0]):
            # Adjust to make it work
            A = Matrix([[lam_known, 0], [0, lam_known]]) + Matrix([[0, -k], [0, 0]])
        
        return problem(
            question=f"Find an eigenvector corresponding to eigenvalue $\\lambda = {lam_known}$ for the matrix $A = {latex(A)}$",
            answer=fmt_matrix(v),
            difficulty=(1600, 1700),
            topic="linear_algebra/diagonalization",
            answer_type="matrix",
            grading_mode="equivalent",
            solution=steps(
                f"Solve $(A - {lam_known}I)\\mathbf{{v}} = \\mathbf{{0}}$",
                f"$A - {lam_known}I = {latex(A - lam_known * eye(2))}$",
                f"Row reduce to find the null space",
                f"One eigenvector is $\\mathbf{{v}} = {latex(v)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'power_matrix':
        # Use diagonalization to compute A^n
        lam1 = choice([2, -2, 3, -1])
        lam2 = choice([1, -1, 2])
        while lam2 == lam1:
            lam2 = choice([1, -1, 2])
        
        P = Matrix([[1, 1], [0, 1]])
        D = Matrix([[lam1, 0], [0, lam2]])
        A = P * D * P.inv()
        
        n_val = randint(5, 10)
        
        D_n = Matrix([[lam1**n_val, 0], [0, lam2**n_val]])
        A_n = P * D_n * P.inv()
        ans = simplify(A_n)
        
        return problem(
            question=f"If $A = {latex(A)} = PDP^{{-1}}$ where $P = {latex(P)}$ and $D = {latex(D)}$, compute $A^{{{n_val}}}$",
            answer=fmt_matrix(ans),
            difficulty=(1700, 1850),
            topic="linear_algebra/diagonalization",
            answer_type="matrix",
            solution=steps(
                f"Use the fact that $A^n = PD^nP^{{-1}}$",
                f"$D^{{{n_val}}} = {latex(D_n)}$",
                f"$A^{{{n_val}}} = P \\cdot D^{{{n_val}}} \\cdot P^{{-1}} = {latex(P)} {latex(D_n)} {latex(P.inv())}$",
                f"$A^{{{n_val}}} = {latex(ans)}$"
            ),
            calculator="scientific"
        )
    
    else:  # not_diagonalizable
        # Create a defective matrix (repeated eigenvalue without enough eigenvectors)
        lam = nonzero(-3, 3)
        # Jordan block form - not diagonalizable
        A = Matrix([[lam, 1], [0, lam]])
        
        ans = False
        
        return problem(
            question=f"Is the matrix $A = {latex(A)}$ diagonalizable over $\\mathbb{{R}}$?",
            answer=ans,
            difficulty=(1750, 1900),
            topic="linear_algebra/diagonalization",
            answer_type="boolean",
            solution=steps(
                f"Find eigenvalues by solving $\\det(A - \\lambda I) = 0$",
                f"$(\\lambda - {lam})^2 = 0$, so $\\lambda = {lam}$ with algebraic multiplicity 2",
                f"Find eigenvectors: $(A - {lam}I)\\mathbf{{v}} = {latex(A - lam*eye(2))}\\mathbf{{v}} = \\mathbf{{0}}$",
                f"The null space is 1-dimensional (geometric multiplicity 1)",
                f"Since geometric multiplicity $<$ algebraic multiplicity, $A$ is not diagonalizable"
            )
        )

emit(generate())