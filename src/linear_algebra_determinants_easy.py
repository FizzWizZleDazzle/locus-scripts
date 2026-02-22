"""
linear_algebra - determinants (easy)
Generated: 2026-02-22T05:52:08.269563
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # 2x2 determinant with small integers (ELO ~1000-1100)
        a_val = randint(-3, 3)
        b_val = randint(-3, 3)
        c_val = randint(-3, 3)
        d_val = randint(-3, 3)
        
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        ans = M.det()
        
        return problem(
            question=f"Calculate the determinant of $\\begin{{bmatrix}} {a_val} & {b_val} \\\\ {c_val} & {d_val} \\end{{bmatrix}}$",
            answer=ans,
            difficulty=(1000, 1100),
            topic="linear_algebra/determinants",
            solution=steps(
                f"For a $2 \\times 2$ matrix $\\begin{{bmatrix}} a & b \\\\ c & d \\end{{bmatrix}}$, the determinant is $ad - bc$",
                f"$\\det(M) = ({a_val})({d_val}) - ({b_val})({c_val})$",
                f"$\\det(M) = {a_val * d_val} - {b_val * c_val}$",
                f"$\\det(M) = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # 2x2 determinant with one parameter (ELO ~1100-1200)
        a_val = nonzero(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = nonzero(-3, 3)
        
        M = Matrix([[a_val, b_val], [c_val, x]])
        det_expr = M.det()
        ans = det_expr
        
        return problem(
            question=f"Find the determinant of $\\begin{{bmatrix}} {a_val} & {b_val} \\\\ {c_val} & x \\end{{bmatrix}}$ in terms of $x$",
            answer=ans,
            difficulty=(1100, 1200),
            topic="linear_algebra/determinants",
            solution=steps(
                f"For a $2 \\times 2$ matrix $\\begin{{bmatrix}} a & b \\\\ c & d \\end{{bmatrix}}$, the determinant is $ad - bc$",
                f"$\\det(M) = ({a_val})(x) - ({b_val})({c_val})$",
                f"$\\det(M) = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 3:
        # 3x3 diagonal or triangular matrix (ELO ~1100-1200)
        diagonal = choice([True, False])
        
        if diagonal:
            a_val = nonzero(-4, 4)
            b_val = nonzero(-4, 4)
            c_val = nonzero(-4, 4)
            M = Matrix([[a_val, 0, 0], [0, b_val, 0], [0, 0, c_val]])
            ans = M.det()
            
            return problem(
                question=f"Calculate the determinant of the diagonal matrix $\\begin{{bmatrix}} {a_val} & 0 & 0 \\\\ 0 & {b_val} & 0 \\\\ 0 & 0 & {c_val} \\end{{bmatrix}}$",
                answer=ans,
                difficulty=(1100, 1200),
                topic="linear_algebra/determinants",
                solution=steps(
                    "For a diagonal matrix, the determinant is the product of the diagonal entries",
                    f"$\\det(M) = ({a_val})({b_val})({c_val})$",
                    f"$\\det(M) = {ans}$"
                ),
            )
        else:
            # Upper triangular
            a_val = nonzero(-3, 3)
            b_val = nonzero(-3, 3)
            c_val = nonzero(-3, 3)
            d_val = randint(-3, 3)
            e_val = randint(-3, 3)
            f_val = randint(-3, 3)
            M = Matrix([[a_val, d_val, e_val], [0, b_val, f_val], [0, 0, c_val]])
            ans = M.det()
            
            return problem(
                question=f"Calculate the determinant of the upper triangular matrix $\\begin{{bmatrix}} {a_val} & {d_val} & {e_val} \\\\ 0 & {b_val} & {f_val} \\\\ 0 & 0 & {c_val} \\end{{bmatrix}}$",
                answer=ans,
                difficulty=(1200, 1300),
                topic="linear_algebra/determinants",
                solution=steps(
                    "For a triangular matrix, the determinant is the product of the diagonal entries",
                    f"$\\det(M) = ({a_val})({b_val})({c_val})$",
                    f"$\\det(M) = {ans}$"
                ),
            )
    
    else:
        # Solve for x when det = 0 (ELO ~1200-1300)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        
        M = Matrix([[x, a_val], [b_val, c_val]])
        det_expr = M.det()
        solutions = solve(det_expr, x)
        ans = solutions[0]
        
        return problem(
            question=f"Find the value of $x$ such that $\\det\\begin{{bmatrix}} x & {a_val} \\\\ {b_val} & {c_val} \\end{{bmatrix}} = 0$",
            answer=ans,
            difficulty=(1200, 1300),
            topic="linear_algebra/determinants",
            solution=steps(
                f"Calculate the determinant: $\\det(M) = x \\cdot {c_val} - {a_val} \\cdot {b_val}$",
                f"Set equal to zero: ${latex(det_expr)} = 0$",
                f"Solve for $x$: $x = {latex(ans)}$"
            ),
        )

emit(generate())