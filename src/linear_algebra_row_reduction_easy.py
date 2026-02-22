"""
linear_algebra - row_reduction (easy)
Generated: 2026-02-22T05:48:13.508676
"""

from problem_utils import *

def generate():
    problem_type = choice(['2x2_simple', '2x2_swap', '3x2_simple', '2x3_simple'])
    
    if problem_type == '2x2_simple':
        # Simple 2x2 already in row echelon form or one step away
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        M = Matrix([[a, b], [0, c]])
        
        question = f"The matrix ${latex(M)}$ is already in row echelon form. What is the leading entry in row 2?"
        ans = c
        difficulty = (1000, 1100)
        solution = steps(
            f"Row echelon form has leading entries (pivots) that move right as we go down rows",
            f"Row 1 has leading entry ${a}$",
            f"Row 2 has leading entry ${c}$"
        )
    
    elif problem_type == '2x2_swap':
        # 2x2 that needs one row swap
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        M = Matrix([[0, a], [b, c]])
        ans = Matrix([[b, c], [0, a]])
        
        question = f"Perform row operations to put ${latex(M)}$ into row echelon form. What is the resulting matrix?"
        difficulty = (1100, 1200)
        solution = steps(
            f"Starting matrix: ${latex(M)}$",
            f"Row 1 starts with 0, so swap rows 1 and 2",
            f"$R_1 \\leftrightarrow R_2$",
            f"Result: ${latex(ans)}$"
        )
    
    elif problem_type == '3x2_simple':
        # 3x2 matrix needing one elimination
        a = nonzero(-2, 2)
        b = nonzero(-2, 2)
        c = a * randint(2, 3)
        d = nonzero(-2, 2)
        e = nonzero(-2, 2)
        
        M = Matrix([[a, b], [c, d], [0, e]])
        
        multiplier = c // a
        new_d = d - multiplier * b
        ans = Matrix([[a, b], [0, new_d], [0, e]])
        
        question = f"Use row reduction to eliminate the first entry of row 2 in ${latex(M)}$. What is the resulting matrix?"
        difficulty = (1200, 1300)
        solution = steps(
            f"Starting matrix: ${latex(M)}$",
            f"To eliminate the ${c}$ in row 2, perform $R_2 \\to R_2 - {multiplier}R_1$",
            f"New row 2: $[{c}, {d}] - {multiplier}[{a}, {b}] = [0, {new_d}]$",
            f"Result: ${latex(ans)}$"
        )
    
    else:  # problem_type == '2x3_simple'
        # 2x3 matrix already in REF or needing simple elimination
        a = nonzero(-2, 2)
        b = nonzero(-2, 2)
        c = nonzero(-2, 2)
        
        if choice([True, False]):
            # Already in REF
            d = nonzero(-2, 2)
            e = nonzero(-2, 2)
            M = Matrix([[a, b, c], [0, d, e]])
            
            question = f"Is the matrix ${latex(M)}$ in row echelon form? Answer True or False."
            ans = True
            difficulty = (1000, 1100)
            solution = steps(
                f"Check if matrix ${latex(M)}$ is in row echelon form",
                f"Row 1 leading entry is in column 1",
                f"Row 2 leading entry is in column 2 (to the right of row 1's leading entry)",
                f"All entries below leading entries are zero",
                f"Therefore, the matrix is in row echelon form: True"
            )
        else:
            # Simple elimination needed
            mult = randint(2, 3)
            d = mult * a
            e = nonzero(-2, 2)
            f = nonzero(-2, 2)
            
            M = Matrix([[a, b, c], [d, e, f]])
            
            new_e = e - mult * b
            new_f = f - mult * c
            ans = Matrix([[a, b, c], [0, new_e, new_f]])
            
            question = f"Perform row reduction to eliminate the first entry of row 2 in ${latex(M)}$. What is the resulting matrix?"
            difficulty = (1200, 1300)
            solution = steps(
                f"Starting matrix: ${latex(M)}$",
                f"Perform $R_2 \\to R_2 - {mult}R_1$",
                f"New row 2: $[{d}, {e}, {f}] - {mult}[{a}, {b}, {c}] = [0, {new_e}, {new_f}]$",
                f"Result: ${latex(ans)}$"
            )
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty,
        topic="linear_algebra/row_reduction",
        solution=solution
    )

emit(generate())