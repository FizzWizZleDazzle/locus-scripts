"""
linear_algebra - matrix_inverses (medium)
Generated: 2026-02-22T05:51:15.984753
"""

from problem_utils import *

def generate():
    problem_type = choice(['2x2_inverse', '2x2_determinant_check', '3x3_inverse', 'verify_inverse'])
    
    if problem_type == '2x2_inverse':
        # Generate a 2x2 invertible matrix
        # Start with integer entries that give a nice inverse
        det = choice([-2, -1, 1, 2])
        a_val = nonzero(-3, 3)
        b_val = randint(-3, 3)
        c_val = randint(-3, 3)
        # d chosen so determinant = det
        d_val = (det + a_val * c_val) // a_val if a_val != 0 else nonzero(-3, 3)
        
        # Rebuild to ensure integer determinant
        a_val = nonzero(-3, 3)
        d_val = nonzero(-3, 3)
        b_val = randint(-2, 2)
        c_val = randint(-2, 2)
        
        # Check det != 0
        det = a_val * d_val - b_val * c_val
        if det == 0:
            d_val += 1
            det = a_val * d_val - b_val * c_val
        
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        M_inv = M.inv()
        
        return problem(
            question=f"Find the inverse of the matrix $A = {latex(M)}$",
            answer=M_inv,
            difficulty=(1300, 1450),
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"For a $2 \\times 2$ matrix $A = \\begin{{pmatrix}} a & b \\\\ c & d \\end{{pmatrix}}$, the inverse is $A^{{-1}} = \\frac{{1}}{{ad-bc}} \\begin{{pmatrix}} d & -b \\\\ -c & a \\end{{pmatrix}}$",
                f"Calculate the determinant: $\\det(A) = ({a_val})({d_val}) - ({b_val})({c_val}) = {det}$",
                f"Since $\\det(A) \\neq 0$, the matrix is invertible",
                f"$A^{{-1}} = \\frac{{1}}{{{det}}} \\begin{{pmatrix}} {d_val} & {-b_val} \\\\ {-c_val} & {a_val} \\end{{pmatrix}} = {latex(M_inv)}$"
            )
        )
    
    elif problem_type == '2x2_determinant_check':
        # Give a singular matrix and ask if it's invertible
        a_val = nonzero(-4, 4)
        b_val = nonzero(-4, 4)
        # Make it singular: set c, d so det = 0
        c_val = nonzero(-3, 3)
        d_val = (b_val * c_val) // a_val if a_val != 0 else b_val
        
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        det = M.det()
        
        if det == 0:
            ans = False
            inv_text = "not invertible"
        else:
            ans = True
            inv_text = "invertible"
        
        return problem(
            question=f"Is the matrix $A = {latex(M)}$ invertible? (Answer true or false)",
            answer=ans,
            difficulty=(1300, 1400),
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"A matrix is invertible if and only if its determinant is nonzero",
                f"Calculate $\\det(A) = ({a_val})({d_val}) - ({b_val})({c_val}) = {det}$",
                f"Since $\\det(A) = {det}$, the matrix is {inv_text}"
            )
        )
    
    elif problem_type == '3x3_inverse':
        # Generate a simple 3x3 invertible matrix
        # Use a diagonal or nearly diagonal matrix for cleaner arithmetic
        diag_type = choice(['diagonal', 'upper_triangular'])
        
        if diag_type == 'diagonal':
            d1, d2, d3 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
            M = Matrix([[d1, 0, 0], [0, d2, 0], [0, 0, d3]])
            M_inv = M.inv()
            
            return problem(
                question=f"Find the inverse of the matrix $A = {latex(M)}$",
                answer=M_inv,
                difficulty=(1350, 1500),
                topic="linear_algebra/matrix_inverses",
                solution=steps(
                    f"This is a diagonal matrix",
                    f"The inverse of a diagonal matrix is obtained by inverting each diagonal entry",
                    f"$A^{{-1}} = {latex(M_inv)}$"
                )
            )
        else:
            # Upper triangular with 1s on diagonal for easier inverse
            a_val = randint(-2, 2)
            b_val = randint(-2, 2)
            c_val = randint(-2, 2)
            M = Matrix([[1, a_val, b_val], [0, 1, c_val], [0, 0, 1]])
            M_inv = M.inv()
            
            return problem(
                question=f"Find the inverse of the matrix $A = {latex(M)}$",
                answer=M_inv,
                difficulty=(1450, 1600),
                topic="linear_algebra/matrix_inverses",
                solution=steps(
                    f"This is an upper triangular matrix with 1s on the diagonal",
                    f"Calculate determinant: $\\det(A) = 1 \\cdot 1 \\cdot 1 = 1 \\neq 0$, so it's invertible",
                    f"Using row reduction or the formula for matrix inverse:",
                    f"$A^{{-1}} = {latex(M_inv)}$"
                )
            )
    
    else:  # verify_inverse
        # Give two matrices and ask to verify if they are inverses
        a_val = nonzero(-2, 2)
        d_val = nonzero(-2, 2)
        b_val = choice([-1, 0, 1])
        c_val = choice([-1, 0, 1])
        
        det = a_val * d_val - b_val * c_val
        if det == 0:
            d_val += 1
            det = a_val * d_val - b_val * c_val
        
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        
        if choice([True, False]):
            # Give the correct inverse
            M_inv = M.inv()
            product = M * M_inv
            ans = True
            are_text = "are"
        else:
            # Give a wrong matrix
            M_inv = Matrix([[d_val, -b_val + 1], [-c_val, a_val]])
            product = M * M_inv
            ans = (product == eye(2))
            are_text = "are" if ans else "are not"
        
        return problem(
            question=f"Verify whether $B = {latex(M_inv)}$ is the inverse of $A = {latex(M)}$ (Answer true or false)",
            answer=ans,
            difficulty=(1350, 1500),
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"Two matrices are inverses if their product is the identity matrix",
                f"Calculate $AB = {latex(M)} {latex(M_inv)} = {latex(product)}$",
                f"Since $AB = {latex(product)}$, they {are_text} inverses"
            )
        )

emit(generate())