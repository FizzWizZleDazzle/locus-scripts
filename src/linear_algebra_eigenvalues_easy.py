"""
linear_algebra - eigenvalues (easy)
Generated: 2026-02-22T05:58:19.889862
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # 2x2 diagonal matrix
        eig1 = randint(-8, 8)
        eig2 = randint(-8, 8)
        M = Matrix([[eig1, 0], [0, eig2]])
        ans = FiniteSet(eig1, eig2)
        return problem(
            question=f"Find the eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1000, 1100),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a diagonal matrix, eigenvalues are the diagonal entries.",
                f"Eigenvalues: ${eig1}$ and ${eig2}$."
            ),
            answer_type="set"
        )

    elif problem_type == 2:
        # 2x2 upper triangular matrix
        eig1 = randint(-7, 7)
        eig2 = randint(-7, 7)
        off_diag = nonzero(-5, 5)
        M = Matrix([[eig1, off_diag], [0, eig2]])
        ans = FiniteSet(eig1, eig2)
        return problem(
            question=f"Find the eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1050, 1150),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a triangular matrix, eigenvalues are the diagonal entries.",
                f"Eigenvalues: ${eig1}$ and ${eig2}$."
            ),
            answer_type="set"
        )

    elif problem_type == 3:
        # 2x2 lower triangular matrix
        eig1 = randint(-7, 7)
        eig2 = randint(-7, 7)
        off_diag = nonzero(-5, 5)
        M = Matrix([[eig1, 0], [off_diag, eig2]])
        ans = FiniteSet(eig1, eig2)
        return problem(
            question=f"Find the eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1050, 1150),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a triangular matrix, eigenvalues are the diagonal entries.",
                f"Eigenvalues: ${eig1}$ and ${eig2}$."
            ),
            answer_type="set"
        )

    elif problem_type == 4:
        # 2x2 requiring characteristic polynomial (upper triangular)
        eig1 = randint(-5, 5)
        eig2 = randint(-5, 5)
        off_diag = nonzero(-4, 4)
        M = Matrix([[eig1, off_diag], [0, eig2]])
        ans = FiniteSet(eig1, eig2)
        char_poly = M.charpoly(x)
        return problem(
            question=f"Find the eigenvalues of $A = {latex(M)}$ using $\\det(A-\\lambda I)=0$.",
            answer=ans,
            difficulty=(1150, 1280),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"$\\det(A - \\lambda I) = {latex(char_poly.as_expr())} = 0$",
                f"The matrix is triangular, so eigenvalues are diagonal: $\\lambda_1 = {eig1}$, $\\lambda_2 = {eig2}$."
            ),
            answer_type="set"
        )

    elif problem_type == 5:
        # 3x3 diagonal matrix
        eig1 = randint(-6, 6)
        eig2 = randint(-6, 6)
        eig3 = randint(-6, 6)
        M = Matrix([[eig1, 0, 0], [0, eig2, 0], [0, 0, eig3]])
        ans = FiniteSet(eig1, eig2, eig3)
        return problem(
            question=f"Find the eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1100, 1220),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a diagonal matrix, eigenvalues are the diagonal entries.",
                f"Eigenvalues: ${eig1}$, ${eig2}$, ${eig3}$."
            ),
            answer_type="set"
        )

    else:
        # 2x2 with repeated eigenvalue (Jordan block)
        eig = nonzero(-6, 6)
        off_diag = nonzero(-5, 5)
        M = Matrix([[eig, off_diag], [0, eig]])
        ans = FiniteSet(eig)
        return problem(
            question=f"Find all distinct eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1100, 1230),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a triangular matrix, eigenvalues are the diagonal entries.",
                f"Both diagonal entries are ${eig}$, so the only eigenvalue is ${eig}$."
            ),
            answer_type="set"
        )

emit(generate())
