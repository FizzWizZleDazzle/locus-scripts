"""
linear_algebra - eigenvalues (medium)
Generated: 2026-02-22T05:58:43.499052
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 6)

    if problem_type == 1:
        # 2x2 matrix with distinct integer eigenvalues (diagonal or upper triangular)
        lambda1 = randint(-6, 6)
        lambda2 = randint(-6, 6)
        while lambda2 == lambda1:
            lambda2 = randint(-6, 6)
        if randint(0, 1) == 0:
            M = Matrix([[lambda1, 0], [0, lambda2]])
        else:
            off_diag = nonzero(-4, 4)
            M = Matrix([[lambda1, off_diag], [0, lambda2]])
        ans = FiniteSet(*sorted([lambda1, lambda2]))
        char_poly = M.charpoly(x)
        return problem(
            question=f"Find all eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1300, 1420),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Characteristic polynomial: ${latex(char_poly.as_expr())} = 0$",
                f"Eigenvalues: $\\lambda = {lambda1}$, $\\lambda = {lambda2}$"
            ),
            answer_type="set"
        )

    elif problem_type == 2:
        # 2x2 general matrix with integer eigenvalues (need to factor char poly)
        lambda1 = nonzero(-5, 5)
        lambda2 = nonzero(-5, 5)
        trace_val = lambda1 + lambda2
        det_val = lambda1 * lambda2
        a_val = randint(-3, 3)
        d_val = trace_val - a_val
        bc_product = a_val * d_val - det_val
        if bc_product == 0:
            b_val = 0
            c_val = nonzero(-3, 3)
        else:
            divs = [i for i in range(1, abs(bc_product) + 1) if bc_product % i == 0]
            if divs:
                b_val = choice(divs) * (1 if bc_product > 0 else -1)
                c_val = bc_product // b_val
            else:
                b_val = 1
                c_val = bc_product
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        actual = sorted([k for k in M.eigenvals().keys()])
        ans = FiniteSet(*actual)
        char_poly = M.charpoly(x)
        return problem(
            question=f"Find all eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1380, 1520),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Characteristic polynomial: ${latex(char_poly.as_expr())} = 0$",
                f"Factor: ${latex(factor(char_poly.as_expr()))} = 0$",
                f"Eigenvalues: $\\lambda = {latex(actual[0])}$, $\\lambda = {latex(actual[1])}$"
            ),
            answer_type="set"
        )

    elif problem_type == 3:
        # 3x3 upper triangular with distinct eigenvalues
        lambda1 = randint(-5, 5)
        lambda2 = randint(-5, 5)
        lambda3 = randint(-5, 5)
        while lambda2 == lambda1 or lambda3 == lambda1 or lambda3 == lambda2:
            lambda2 = randint(-5, 5)
            lambda3 = randint(-5, 5)
        M = Matrix([
            [lambda1, nonzero(-3, 3), nonzero(-3, 3)],
            [0, lambda2, nonzero(-3, 3)],
            [0, 0, lambda3]
        ])
        ans = FiniteSet(*sorted([lambda1, lambda2, lambda3]))
        return problem(
            question=f"Find all eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1450, 1580),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"For a triangular matrix, eigenvalues are the diagonal entries.",
                f"Eigenvalues: ${lambda1}$, ${lambda2}$, ${lambda3}$"
            ),
            answer_type="set"
        )

    elif problem_type == 4:
        # 2x2 with one repeated eigenvalue
        lambda_val = nonzero(-5, 5)
        off_diag = nonzero(-4, 4)
        M = Matrix([[lambda_val, off_diag], [0, lambda_val]])
        ans = FiniteSet(lambda_val)
        char_poly = M.charpoly(x)
        return problem(
            question=f"Find all distinct eigenvalues of $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1450, 1580),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Characteristic polynomial: ${latex(char_poly.as_expr())} = 0$",
                f"Repeated eigenvalue: $\\lambda = {lambda_val}$ (multiplicity 2)"
            ),
            answer_type="set"
        )

    elif problem_type == 5:
        # 2x2 symmetric: [[a, b], [b, d]]
        lambda1 = randint(-5, 5)
        lambda2 = randint(-5, 5)
        while lambda2 == lambda1:
            lambda2 = randint(-5, 5)
        tr = lambda1 + lambda2
        det = lambda1 * lambda2
        a_val = randint(-3, 3)
        d_val = tr - a_val
        # for symmetric: b^2 = a*d - det
        b_sq = a_val * d_val - det
        if b_sq > 0:
            import math
            b_approx = int(math.isqrt(b_sq))
            if b_approx * b_approx == b_sq:
                b_val = b_approx
            else:
                # fallback to upper triangular
                M = Matrix([[lambda1, nonzero(-3, 3)], [0, lambda2]])
        else:
            M = Matrix([[lambda1, nonzero(-3, 3)], [0, lambda2]])
        if 'b_val' in dir():
            M = Matrix([[a_val, b_val], [b_val, d_val]])
        actual = sorted([k for k in M.eigenvals().keys()])
        ans = FiniteSet(*actual)
        char_poly = M.charpoly(x)
        return problem(
            question=f"Find all eigenvalues of the symmetric matrix $A = {latex(M)}$.",
            answer=ans,
            difficulty=(1400, 1540),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Characteristic polynomial: ${latex(char_poly.as_expr())} = 0$",
                f"$\\Rightarrow$ Eigenvalues: $\\lambda = {latex(actual[0])}$, $\\lambda = {latex(actual[-1])}$"
            ),
            answer_type="set"
        )

    else:
        # Find trace or determinant given eigenvalues
        lambda1 = randint(-6, 6)
        lambda2 = randint(-6, 6)
        while lambda2 == lambda1:
            lambda2 = randint(-6, 6)
        ask_type = choice(["trace", "det"])
        if ask_type == "trace":
            ans = lambda1 + lambda2
            return problem(
                question=f"A $2\\times2$ matrix has eigenvalues ${lambda1}$ and ${lambda2}$. Find the trace.",
                answer=ans,
                difficulty=(1350, 1480),
                topic="linear_algebra/eigenvalues",
                solution=steps(
                    f"Trace $= \\lambda_1 + \\lambda_2 = {lambda1} + {lambda2} = {ans}$"
                ),
            )
        else:
            ans = lambda1 * lambda2
            return problem(
                question=f"A $2\\times2$ matrix has eigenvalues ${lambda1}$ and ${lambda2}$. Find the determinant.",
                answer=ans,
                difficulty=(1350, 1480),
                topic="linear_algebra/eigenvalues",
                solution=steps(
                    f"Determinant $= \\lambda_1 \\cdot \\lambda_2 = {lambda1} \\cdot {lambda2} = {ans}$"
                ),
            )

emit(generate())
