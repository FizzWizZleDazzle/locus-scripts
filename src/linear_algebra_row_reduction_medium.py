"""
linear_algebra - row_reduction (medium)
Generated: 2026-02-22T05:48:41.374526
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 4)
    
    if problem_type == 1:
        # 2x2 system to RREF (1300-1400 difficulty)
        # Start with RREF and work backward
        pivot1 = 1
        pivot2 = 1
        val = nonzero(-5, 5)
        
        # RREF form: [[1, 0, a], [0, 1, b]]
        a_ans = nonzero(-8, 8)
        b_ans = nonzero(-8, 8)
        
        # Create a non-RREF augmented matrix
        # Apply row operations backward
        r1_mult = nonzero(-3, 3)
        r2_mult = nonzero(-3, 3)
        
        row1 = [r1_mult, 0, r1_mult * a_ans]
        row2 = [0, r2_mult, r2_mult * b_ans]
        
        # Add a multiple of one row to another
        mult = randint(-2, 2)
        if mult != 0:
            row2[0] += mult * row1[0]
            row2[2] += mult * row1[2]
        
        M = Matrix([[row1[0], row1[1], row1[2]], 
                    [row2[0], row2[1], row2[2]]])
        
        ans = Matrix([[1, 0, a_ans], [0, 1, b_ans]])
        
        return problem(
            question=f"Reduce the augmented matrix to RREF:\\n${latex(M)}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="linear_algebra/row_reduction",
            solution=steps(
                f"Start with ${latex(M)}$",
                f"Scale row 1 by $\\frac{{1}}{{{row1[0]}}}$ to get leading 1" if row1[0] != 1 else "Row 1 already has leading 1",
                f"Scale row 2 by $\\frac{{1}}{{{row2[1]}}}$ to get leading 1 in second position" if row2[1] != 1 else "Row 2 already has leading 1 in position 2",
                f"Eliminate entries above and below pivots",
                f"RREF: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 2:
        # 3x3 matrix to row echelon form (1400-1500 difficulty)
        # Start simple and add complexity
        
        # Build a matrix with nice structure
        a11 = nonzero(-3, 3)
        a12 = nonzero(-4, 4)
        a13 = nonzero(-4, 4)
        
        a21 = nonzero(-3, 3)
        a22 = nonzero(-4, 4)
        a23 = nonzero(-4, 4)
        
        a31 = nonzero(-3, 3)
        a32 = nonzero(-4, 4)
        a33 = nonzero(-4, 4)
        
        M = Matrix([[a11, a12, a13],
                    [a21, a22, a23],
                    [a31, a32, a33]])
        
        ans = M.echelon_form()
        
        return problem(
            question=f"Reduce to row echelon form:\\n${latex(M)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="linear_algebra/row_reduction",
            solution=steps(
                f"Start with ${latex(M)}$",
                f"Use row operations to create zeros below the first pivot",
                f"Continue row reduction to get upper triangular form",
                f"Row echelon form: ${latex(ans)}$"
            )
        )
    
    elif problem_type == 3:
        # 2x3 augmented matrix to RREF (1400-1500 difficulty)
        # Could have unique solution or parametric
        
        # Unique solution case
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        
        # Solution values
        x_val = nonzero(-5, 5)
        y_val = nonzero(-5, 5)
        
        # Build system: ax + by = c, dx + ey = f
        e = nonzero(-3, 3)
        
        # Make sure system is consistent and has unique solution
        # Check determinant is non-zero
        if a * e - b * d == 0:
            e += 1
        
        rhs1 = a * x_val + b * y_val
        rhs2 = d * x_val + e * y_val
        
        M = Matrix([[a, b, rhs1],
                    [d, e, rhs2]])
        
        ans = Matrix([[1, 0, x_val],
                      [0, 1, y_val]])
        
        return problem(
            question=f"Find the RREF of the augmented matrix:\\n${latex(M)}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="linear_algebra/row_reduction",
            solution=steps(
                f"Start with ${latex(M)}$",
                f"Get leading 1 in first row",
                f"Eliminate below first pivot",
                f"Get leading 1 in second row",
                f"Eliminate above second pivot",
                f"RREF: ${latex(ans)}$"
            )
        )
    
    else:
        # 3x4 augmented matrix (1500-1600 difficulty)
        # Construct from known RREF
        
        x1_val = nonzero(-4, 4)
        x2_val = nonzero(-4, 4)
        x3_val = nonzero(-4, 4)
        
        # RREF will be [[1, 0, 0, x1_val], [0, 1, 0, x2_val], [0, 0, 1, x3_val]]
        
        # Work backward - start with RREF and apply inverse operations
        rref = Matrix([[1, 0, 0, x1_val],
                       [0, 1, 0, x2_val],
                       [0, 0, 1, x3_val]])
        
        # Create original by scaling and adding rows
        s1 = nonzero(-2, 2)
        s2 = nonzero(-2, 2)
        s3 = nonzero(-2, 2)
        
        M = Matrix([[s1, 0, 0, s1 * x1_val],
                    [0, s2, 0, s2 * x2_val],
                    [0, 0, s3, s3 * x3_val]])
        
        # Add some row to another to make it more interesting
        add_mult = randint(1, 2)
        M[1, :] = M[1, :] + add_mult * M[0, :]
        
        ans = rref
        
        return problem(
            question=f"Find the RREF:\\n${latex(M)}$",
            answer=ans,
            difficulty=(1500, 1600),
            topic="linear_algebra/row_reduction",
            solution=steps(
                f"Start with ${latex(M)}$",
                f"Apply row operations systematically",
                f"Scale rows to get leading 1's",
                f"Eliminate entries above and below each pivot",
                f"RREF: ${latex(ans)}$"
            )
        )

emit(generate())