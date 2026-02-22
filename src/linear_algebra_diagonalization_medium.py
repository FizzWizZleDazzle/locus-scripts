"""
linear_algebra - diagonalization (medium)
Generated: 2026-02-22T05:59:58.582743
"""

from problem_utils import *

def generate():
    prob_type = randint(1, 4)
    
    if prob_type == 1:
        # 2x2 matrix with simple eigenvalues - difficulty 1300-1400
        # Reverse engineer: pick eigenvalues, construct diagonal matrix, then similarity transform
        eig1 = nonzero(-3, 3)
        eig2 = nonzero(-3, 3)
        while eig1 == eig2:
            eig2 = nonzero(-3, 3)
        
        # Simple invertible P matrix
        p11, p12 = nonzero(-2, 2), nonzero(-2, 2)
        p21, p22 = nonzero(-2, 2), nonzero(-2, 2)
        P = Matrix([[p11, p12], [p21, p22]])
        while P.det() == 0:
            p22 = nonzero(-2, 2)
            P = Matrix([[p11, p12], [p21, p22]])
        
        D = Matrix([[eig1, 0], [0, eig2]])
        A = P * D * P.inv()
        A = simplify(A)
        
        # Check if entries are reasonable
        if all(abs(entry) < 20 for entry in A):
            ans = D
            
            return problem(
                question=f"Find a diagonal matrix $D$ and an invertible matrix $P$ such that $A = PDP^{{-1}}$ where $A = {latex(A)}$. Enter the diagonal matrix $D$.",
                answer=ans,
                difficulty=(1300, 1400),
                topic="linear_algebra/diagonalization",
                solution=steps(
                    f"Find eigenvalues by solving $\\det(A - \\lambda I) = 0$",
                    f"The characteristic polynomial gives eigenvalues $\\lambda_1 = {eig1}$ and $\\lambda_2 = {eig2}$",
                    f"The diagonal matrix is $D = {latex(ans)}$"
                ),
                answer_type="matrix"
            )
    
    if prob_type == 2:
        # Is matrix diagonalizable? - difficulty 1400-1500
        diag = choice([True, False])
        
        if diag:
            # Create diagonalizable matrix
            eig1 = nonzero(-2, 2)
            eig2 = nonzero(-2, 2)
            while eig1 == eig2:
                eig2 = nonzero(-2, 2)
            
            p11, p12 = nonzero(-2, 2), nonzero(-2, 2)
            p21, p22 = nonzero(-2, 2), nonzero(-2, 2)
            P = Matrix([[p11, p12], [p21, p22]])
            while P.det() == 0:
                p22 = nonzero(-2, 2)
                P = Matrix([[p11, p12], [p21, p22]])
            
            D = Matrix([[eig1, 0], [0, eig2]])
            A = simplify(P * D * P.inv())
            
            if all(abs(entry) < 15 for entry in A):
                return problem(
                    question=f"Is the matrix $A = {latex(A)}$ diagonalizable? Answer True or False.",
                    answer=True,
                    difficulty=(1400, 1500),
                    topic="linear_algebra/diagonalization",
                    solution=steps(
                        f"Find eigenvalues: $\\lambda_1 = {eig1}, \\lambda_2 = {eig2}$",
                        f"Since we have 2 distinct eigenvalues for a $2 \\times 2$ matrix, it is diagonalizable",
                        f"Answer: True"
                    ),
                    answer_type="boolean"
                )
        else:
            # Create non-diagonalizable matrix (defective eigenvalue)
            eig = nonzero(-2, 2)
            # Jordan block
            A = Matrix([[eig, 1], [0, eig]])
            
            return problem(
                question=f"Is the matrix $A = {latex(A)}$ diagonalizable? Answer True or False.",
                answer=False,
                difficulty=(1400, 1500),
                topic="linear_algebra/diagonalization",
                solution=steps(
                    f"Find eigenvalues: $\\lambda = {eig}$ (repeated)",
                    f"Check if there are 2 linearly independent eigenvectors",
                    f"The eigenspace has dimension 1, not 2",
                    f"Answer: False"
                ),
                answer_type="boolean"
            )
    
    if prob_type == 3:
        # Find eigenvalues for diagonalization - difficulty 1300-1500
        eig1 = nonzero(-3, 3)
        eig2 = nonzero(-3, 3)
        while eig1 == eig2:
            eig2 = nonzero(-3, 3)
        
        # Construct triangular or simple matrix with known eigenvalues
        # Upper triangular has eigenvalues on diagonal
        a12 = nonzero(-3, 3)
        A = Matrix([[eig1, a12], [0, eig2]])
        
        ans = FiniteSet(eig1, eig2)
        
        return problem(
            question=f"Find all eigenvalues of the matrix $A = {latex(A)}$. Enter your answer as a set.",
            answer=ans,
            difficulty=(1300, 1500),
            topic="linear_algebra/diagonalization",
            solution=steps(
                f"For an upper triangular matrix, eigenvalues are the diagonal entries",
                f"Eigenvalues: ${{{eig1}, {eig2}}}$"
            ),
            answer_type="set"
        )
    
    # prob_type == 4
    # Compute matrix power using diagonalization - difficulty 1500-1600
    eig1 = choice([0, 1, 2, -1])
    eig2 = choice([0, 1, 2, -1])
    while eig1 == eig2:
        eig2 = choice([0, 1, 2, -1])
    
    # Use simple P matrix
    P = Matrix([[1, 1], [0, 1]])
    D = Matrix([[eig1, 0], [0, eig2]])
    A = P * D * P.inv()
    
    power = randint(2, 4)
    D_power = Matrix([[eig1**power, 0], [0, eig2**power]])
    ans = P * D_power * P.inv()
    
    return problem(
        question=f"Use diagonalization to compute $A^{{{power}}}$ where $A = {latex(A)}$.",
        answer=ans,
        difficulty=(1500, 1600),
        topic="linear_algebra/diagonalization",
        solution=steps(
            f"Find that $A = PDP^{{-1}}$ where $D = {latex(D)}$",
            f"Then $A^{{{power}}} = PD^{{{power}}}P^{{-1}}$",
            f"$D^{{{power}}} = {latex(D_power)}$",
            f"$A^{{{power}}} = {latex(ans)}$"
        ),
        answer_type="matrix"
    )

emit(generate())