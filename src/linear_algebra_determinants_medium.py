"""
linear_algebra - determinants (medium)
Generated: 2026-02-22T05:52:28.435974
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # 2x2 determinant calculation (1200-1400)
        a_val = nonzero(-5, 5)
        b_val = nonzero(-5, 5)
        c_val = nonzero(-5, 5)
        d_val = nonzero(-5, 5)
        
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        ans = M.det()
        
        return problem(
            question=f"Find the determinant of the matrix $\\begin{{bmatrix}} {a_val} & {b_val} \\\\ {c_val} & {d_val} \\end{{bmatrix}}$",
            answer=ans,
            difficulty=(1200, 1400),
            topic="linear_algebra/determinants",
            solution=steps(
                f"Use the formula $\\det(A) = ad - bc$",
                f"$\\det(A) = ({a_val})({d_val}) - ({b_val})({c_val})$",
                f"$\\det(A) = {a_val * d_val} - {b_val * c_val}$",
                f"$\\det(A) = {ans}$"
            ),
        )
    
    elif problem_type == 2:
        # 3x3 determinant using cofactor expansion (1400-1600)
        a_val = randint(-3, 3)
        b_val = nonzero(-3, 3)
        c_val = randint(-3, 3)
        d_val = nonzero(-3, 3)
        e_val = randint(-3, 3)
        f_val = nonzero(-3, 3)
        g_val = randint(-3, 3)
        h_val = nonzero(-3, 3)
        i_val = randint(-3, 3)
        
        M = Matrix([[a_val, b_val, c_val], 
                    [d_val, e_val, f_val], 
                    [g_val, h_val, i_val]])
        ans = M.det()
        
        minor1 = e_val * i_val - f_val * h_val
        minor2 = d_val * i_val - f_val * g_val
        minor3 = d_val * h_val - e_val * g_val
        
        return problem(
            question=f"Find the determinant of the matrix $\\begin{{bmatrix}} {a_val} & {b_val} & {c_val} \\\\ {d_val} & {e_val} & {f_val} \\\\ {g_val} & {h_val} & {i_val} \\end{{bmatrix}}$",
            answer=ans,
            difficulty=(1400, 1600),
            topic="linear_algebra/determinants",
            solution=steps(
                f"Expand along the first row:",
                f"$\\det(A) = {a_val} \\begin{{vmatrix}} {e_val} & {f_val} \\\\ {h_val} & {i_val} \\end{{vmatrix}} - {b_val} \\begin{{vmatrix}} {d_val} & {f_val} \\\\ {g_val} & {i_val} \\end{{vmatrix}} + {c_val} \\begin{{vmatrix}} {d_val} & {e_val} \\\\ {g_val} & {h_val} \\end{{vmatrix}}$",
                f"$= {a_val}({minor1}) - {b_val}({minor2}) + {c_val}({minor3})$",
                f"$= {a_val * minor1} - {b_val * minor2} + {c_val * minor3}$",
                f"$= {ans}$"
            ),
        )
    
    elif problem_type == 3:
        # Determinant with variables - solve for parameter (1400-1600)
        target = nonzero(-10, 10)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        
        # Matrix [[x, a], [b, c]] with det = target
        # det = xc - ab = target
        # x = (target + ab) / c
        if c_val * (target + a_val * b_val) % c_val == 0:
            x_ans = (target + a_val * b_val) // c_val
        else:
            x_ans = Rational(target + a_val * b_val, c_val)
        
        return problem(
            question=f"Find the value of $x$ such that $\\det\\begin{{bmatrix}} x & {a_val} \\\\ {b_val} & {c_val} \\end{{bmatrix}} = {target}$",
            answer=x_ans,
            difficulty=(1300, 1500),
            topic="linear_algebra/determinants",
            solution=steps(
                f"Set up the determinant equation: $x \\cdot {c_val} - {a_val} \\cdot {b_val} = {target}$",
                f"${c_val}x - {a_val * b_val} = {target}$",
                f"${c_val}x = {target + a_val * b_val}$",
                f"$x = {latex(x_ans)}$"
            ),
        )
    
    else:
        # Determinant of triangular matrix (1300-1500)
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        c_val = nonzero(-4, 4)
        d_val = randint(-3, 3)
        e_val = randint(-3, 3)
        f_val = randint(-3, 3)
        
        M = Matrix([[a_val, d_val, e_val], 
                    [0, b_val, f_val], 
                    [0, 0, c_val]])
        ans = a_val * b_val * c_val
        
        return problem(
            question=f"Find the determinant of the upper triangular matrix $\\begin{{bmatrix}} {a_val} & {d_val} & {e_val} \\\\ 0 & {b_val} & {f_val} \\\\ 0 & 0 & {c_val} \\end{{bmatrix}}$",
            answer=ans,
            difficulty=(1300, 1500),
            topic="linear_algebra/determinants",
            solution=steps(
                f"For a triangular matrix, the determinant is the product of diagonal entries",
                f"$\\det(A) = {a_val} \\cdot {b_val} \\cdot {c_val}$",
                f"$\\det(A) = {ans}$"
            ),
        )

emit(generate())