"""
linear_algebra - eigenvalues (hard)
Generated: 2026-02-22T05:59:15.577016
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # Characteristic polynomial of a 3x3 matrix (build from known eigenvalues)
        eig_vals = [nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)]
        D = Matrix([[eig_vals[0], 0, 0], [0, eig_vals[1], 0], [0, 0, eig_vals[2]]])
        P = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                    [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                    [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
        while P.det() == 0:
            P = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                        [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                        [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
        A = P * D * P.inv()
        A = A.applyfunc(lambda e: simplify(e))
        lam = symbols('lambda')
        char_poly = expand((A - lam * eye(3)).det())
        ans = char_poly
        return problem(
            question=f"Find the characteristic polynomial of $A = {latex(A)}$.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"$\\det(A - \\lambda I)$",
                f"$= {latex(char_poly)}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 2:
        # Parametric: symmetric 2x2 [[k,a],[a,k]], eigenvalues k±a
        k_val = nonzero(-4, 4)
        target_eval = nonzero(1, 7)
        # largest eigenvalue is k + |a| = target_eval
        a_ans = target_eval - k_val
        # Only positive a gives this as max if a > 0
        while a_ans <= 0:
            target_eval = nonzero(1, 7)
            a_ans = target_eval - k_val
        a_sym = symbols('a')
        A = Matrix([[k_val, a_sym], [a_sym, k_val]])
        return problem(
            question=f"For what value of $a > 0$ does $A = {latex(A)}$ have ${target_eval}$ as its largest eigenvalue?",
            answer=a_ans,
            difficulty=(1650, 1800),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Eigenvalues of this symmetric matrix are $\\lambda = {k_val} \\pm a$",
                f"Largest eigenvalue: ${k_val} + a = {target_eval}$",
                f"$a = {target_eval} - {k_val} = {a_ans}$"
            ),
            calculator="scientific"
        )

    elif problem_type == 3:
        # Algebraic multiplicity from 4x4 block diagonal
        eval1 = nonzero(-4, 4)
        eval2 = nonzero(-4, 4)
        while eval2 == eval1:
            eval2 = nonzero(-4, 4)
        A = Matrix([
            [eval1, 1, 0, 0],
            [0, eval1, 0, 0],
            [0, 0, eval2, 1],
            [0, 0, 0, eval2]
        ])
        ans = 2
        return problem(
            question=f"What is the algebraic multiplicity of $\\lambda = {eval1}$ for $A = {latex(A)}$?",
            answer=ans,
            difficulty=(1600, 1700),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"$A$ is upper triangular; characteristic polynomial: $(\\lambda - {eval1})^2(\\lambda - {eval2})^2$",
                f"Algebraic multiplicity of $\\lambda = {eval1}$: $2$"
            ),
            calculator="none"
        )

    elif problem_type == 4:
        # Geometric multiplicity (Jordan block): always 1 for 3x3 Jordan block
        eval_val = nonzero(-4, 4)
        A = Matrix([
            [eval_val, 1, 0],
            [0, eval_val, 1],
            [0, 0, eval_val]
        ])
        ans = 1
        return problem(
            question=f"Find the dimension of the eigenspace for $\\lambda = {eval_val}$ for $A = {latex(A)}$.",
            answer=ans,
            difficulty=(1700, 1850),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"$A - {eval_val}I = {latex(A - eval_val*eye(3))}$, which has rank 2",
                f"Nullity $= 3 - 2 = 1$"
            ),
            calculator="none"
        )

    elif problem_type == 5:
        # Trace and determinant: find eigenvalues via quadratic
        # Pick integer eigenvalues so discriminant is a perfect square
        lambda1 = randint(-6, 6)
        lambda2 = randint(-6, 6)
        while lambda2 == lambda1:
            lambda2 = randint(-6, 6)
        trace_val = lambda1 + lambda2
        det_val = lambda1 * lambda2
        ans = FiniteSet(lambda1, lambda2)
        return problem(
            question=f"A $2\\times2$ matrix has trace ${trace_val}$ and determinant ${det_val}$. Find its eigenvalues.",
            answer=ans,
            difficulty=(1620, 1760),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Eigenvalues satisfy $\\lambda^2 - {trace_val}\\lambda + {det_val} = 0$",
                f"$\\lambda = \\frac{{{trace_val} \\pm \\sqrt{{{trace_val}^2 - 4\\cdot{det_val}}}}}{{2}} = \\frac{{{trace_val} \\pm \\sqrt{{{trace_val**2 - 4*det_val}}}}}{{2}}$",
                f"$\\lambda = {lambda1}$ or $\\lambda = {lambda2}$"
            ),
            answer_type="set",
            calculator="scientific"
        )

    else:
        # 3x3 diagonal with one repeated value: find eigenvalues and multiplicities
        eig1 = randint(-5, 5)
        eig2 = randint(-5, 5)
        while eig2 == eig1:
            eig2 = randint(-5, 5)
        eig3 = eig1  # repeated
        M = Matrix([[eig1, 0, 0], [0, eig2, 0], [0, 0, eig3]])
        ans = FiniteSet(eig1, eig2)
        return problem(
            question=f"Find all distinct eigenvalues of $A = {latex(M)}$ and state each algebraic multiplicity.",
            answer=ans,
            difficulty=(1600, 1720),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Diagonal matrix: eigenvalues are the diagonal entries ${eig1}, {eig2}, {eig3}$",
                f"Distinct eigenvalues: $\\lambda = {eig1}$ (multiplicity 2), $\\lambda = {eig2}$ (multiplicity 1)"
            ),
            answer_type="set"
        )

emit(generate())
