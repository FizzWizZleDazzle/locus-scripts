"""
linear_algebra - matrix_inverses (easy)
Generated: 2026-02-22T05:50:48.819812
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # Type 1: 2x2 matrix inverse with simple integer entries (ELO ~1000-1100)
        # Start with an invertible matrix with determinant ±1 for clean inverse
        det_sign = choice([-1, 1])
        a_val = randint(1, 3)
        d_val = randint(1, 3)
        b_val = randint(0, 2)
        c_val = (a_val * d_val - det_sign) // b_val if b_val != 0 else randint(1, 2)
        
        # Ensure determinant is exactly det_sign
        if b_val == 0:
            c_val = 0
            d_val = det_sign // a_val if a_val != 0 else 1
            a_val = det_sign if a_val == 0 else a_val
        
        # Simpler approach: use determinant = 1 or -1
        a_val = choice([1, 2])
        d_val = choice([1, 2])
        b_val = choice([0, 1])
        c_val = (a_val * d_val - det_sign) // 1 - b_val if b_val != 0 else (a_val * d_val - det_sign)
        
        # Even simpler: construct from inverse first
        inv_a = randint(1, 3)
        inv_d = randint(1, 3)
        inv_b = randint(-2, 2)
        inv_c = randint(-2, 2)
        
        M_inv = Matrix([[inv_a, inv_b], [inv_c, inv_d]])
        det_inv = M_inv.det()
        
        if det_inv == 0:
            M_inv = Matrix([[1, 0], [0, 1]])
        
        M = M_inv.inv()
        ans = M_inv
        
        difficulty_val = 1050
        
        return problem(
            question=f"Find the inverse of the matrix $A = {latex(M)}$",
            answer=ans,
            difficulty=difficulty_val,
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"For a $2 \\times 2$ matrix $\\begin{{pmatrix}} a & b \\\\ c & d \\end{{pmatrix}}$, the inverse is $\\frac{{1}}{{ad-bc}}\\begin{{pmatrix}} d & -b \\\\ -c & a \\end{{pmatrix}}$",
                f"Calculate determinant: $\\det(A) = {latex(M[0,0])} \\cdot {latex(M[1,1])} - {latex(M[0,1])} \\cdot {latex(M[1,0])} = {latex(M.det())}$",
                f"Apply formula: $A^{{-1}} = {latex(ans)}$"
            ),
        )
    
    elif problem_type == 2:
        # Type 2: Check if a 2x2 matrix is invertible (ELO ~1100-1200)
        det_val = choice([0, nonzero(-5, 5)])
        
        if det_val == 0:
            # Construct singular matrix
            a_val = randint(1, 4)
            b_val = randint(1, 4)
            k = randint(2, 3)
            M = Matrix([[a_val, b_val], [k*a_val, k*b_val]])
            ans = False
        else:
            # Construct invertible matrix
            a_val = randint(1, 3)
            d_val = randint(1, 3)
            b_val = randint(0, 2)
            c_val = (det_val + b_val * a_val) // d_val if d_val != 0 else randint(1, 2)
            M = Matrix([[a_val, b_val], [c_val, d_val]])
            if M.det() != 0:
                ans = True
            else:
                ans = False
        
        difficulty_val = 1150
        
        return problem(
            question=f"Is the matrix $A = {latex(M)}$ invertible? Answer True or False.",
            answer=ans,
            difficulty=difficulty_val,
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"A matrix is invertible if and only if its determinant is nonzero",
                f"$\\det(A) = {latex(M[0,0])} \\cdot {latex(M[1,1])} - {latex(M[0,1])} \\cdot {latex(M[1,0])} = {latex(M.det())}$",
                f"Since $\\det(A) {'\\neq' if M.det() != 0 else '='} 0$, the matrix is {'' if ans else 'not '}invertible",
                f"Answer: {ans}"
            ),
        )
    
    elif problem_type == 3:
        # Type 3: Determinant of 2x2 matrix (ELO ~1000-1100)
        a_val = randint(1, 5)
        b_val = randint(1, 5)
        c_val = randint(1, 5)
        d_val = randint(1, 5)
        
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        ans = M.det()
        
        difficulty_val = 1050
        
        return problem(
            question=f"Find the determinant of $A = {latex(M)}$",
            answer=ans,
            difficulty=difficulty_val,
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"For a $2 \\times 2$ matrix $\\begin{{pmatrix}} a & b \\\\ c & d \\end{{pmatrix}}$, $\\det = ad - bc$",
                f"$\\det(A) = ({a_val})({d_val}) - ({b_val})({c_val}) = {a_val*d_val} - {b_val*c_val} = {ans}$"
            ),
        )
    
    else:
        # Type 4: Inverse of diagonal 2x2 matrix (ELO ~1200-1300)
        a_val = nonzero(1, 4)
        d_val = nonzero(1, 4)
        
        M = Matrix([[a_val, 0], [0, d_val]])
        ans = Matrix([[Rational(1, a_val), 0], [0, Rational(1, d_val)]])
        
        difficulty_val = 1250
        
        return problem(
            question=f"Find the inverse of the diagonal matrix $A = {latex(M)}$",
            answer=ans,
            difficulty=difficulty_val,
            topic="linear_algebra/matrix_inverses",
            solution=steps(
                f"For a diagonal matrix, the inverse is obtained by taking reciprocals of diagonal entries",
                f"$A^{{-1}} = {latex(ans)}$"
            ),
        )

emit(generate())