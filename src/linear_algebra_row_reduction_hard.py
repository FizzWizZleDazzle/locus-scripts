"""
linear_algebra - row_reduction (hard)
Generated: 2026-02-22T05:49:17.272783
"""

from problem_utils import *

def generate():
    problem_type = choice(['rref_4x4', 'parametric_solution', 'rank_nullity', 'reduced_form_with_parameter'])
    
    if problem_type == 'rref_4x4':
        # Create a 4x4 matrix with known RREF
        # Start with RREF and work backwards
        num_pivots = choice([2, 3])
        
        if num_pivots == 2:
            # RREF with 2 pivots
            rref = Matrix([
                [1, 0, randint(-3, 3), randint(-3, 3)],
                [0, 1, randint(-3, 3), randint(-3, 3)],
                [0, 0, 0, 0],
                [0, 0, 0, 0]
            ])
        else:
            # RREF with 3 pivots
            rref = Matrix([
                [1, 0, 0, randint(-3, 3)],
                [0, 1, 0, randint(-3, 3)],
                [0, 0, 1, randint(-3, 3)],
                [0, 0, 0, 0]
            ])
        
        # Apply random row operations to create original matrix
        M = Matrix(rref)
        for _ in range(randint(3, 5)):
            op = choice(['swap', 'scale', 'add'])
            i, j = randint(0, 3), randint(0, 3)
            if op == 'swap' and i != j:
                M.row_swap(i, j)
            elif op == 'scale':
                scalar = nonzero(-2, 2)
                M[i, :] = scalar * M[i, :]
            elif op == 'add' and i != j:
                scalar = nonzero(-2, 2)
                M[i, :] = M[i, :] + scalar * M[j, :]
        
        ans = rref
        
        solution_steps = [
            f"Starting matrix: ${latex(M)}$",
            "Apply row operations to get reduced row echelon form:",
        ]
        
        if num_pivots == 2:
            solution_steps.append("After row reduction, we get 2 pivot columns (columns 1 and 2)")
        else:
            solution_steps.append("After row reduction, we get 3 pivot columns (columns 1, 2, and 3)")
        
        solution_steps.append(f"RREF: ${latex(rref)}$")
        
        return problem(
            question=f"Find the reduced row echelon form (RREF) of the matrix $${latex(M)}$$",
            answer=ans,
            difficulty=(1650, 1800),
            topic="linear_algebra/row_reduction",
            solution=steps(*solution_steps),
            answer_type="matrix"
        )
    
    elif problem_type == 'parametric_solution':
        # System with free variables - find parametric solution
        # Create augmented matrix with one free variable
        # [1  a  | b]
        # [0  0  | 0]
        
        a_val = nonzero(-4, 4)
        b_val = nonzero(-5, 5)
        
        aug_matrix = Matrix([
            [1, a_val, b_val],
            [0, 0, 0]
        ])
        
        # Solution: x1 = b - a*t, x2 = t (where t is free)
        # Express as vector form
        x1_coeff = -a_val
        x1_const = b_val
        
        solution_steps = [
            f"Augmented matrix: ${latex(aug_matrix)}$",
            f"This is already in row echelon form",
            f"From row 1: $x_1 + {a_val}x_2 = {b_val}$",
            f"$x_2$ is a free variable, let $x_2 = t$",
            f"Then $x_1 = {b_val} - {a_val}t = {b_val} + ({x1_coeff})t$",
            f"Parametric solution: $x_1 = {b_val} + {x1_coeff}t, \\quad x_2 = t$"
        ]
        
        # Answer as the coefficient of the free variable in x1
        ans = x1_coeff
        
        return problem(
            question=f"Given the augmented matrix in row echelon form $${latex(aug_matrix)}$$ represents a system with $x_2$ as a free variable (let $x_2 = t$), find the coefficient of $t$ in the expression for $x_1$.",
            answer=ans,
            difficulty=(1600, 1750),
            topic="linear_algebra/row_reduction",
            solution=steps(*solution_steps),
            answer_type="numeric"
        )
    
    elif problem_type == 'rank_nullity':
        # Given matrix, find rank after row reduction
        rows = 4
        cols = 5
        target_rank = choice([2, 3])
        
        # Build matrix with specific rank
        if target_rank == 2:
            M = Matrix([
                [1, 0, randint(-2, 2), randint(-2, 2), randint(-2, 2)],
                [0, 1, randint(-2, 2), randint(-2, 2), randint(-2, 2)],
                [0, 0, 0, 0, 0],
                [0, 0, 0, 0, 0]
            ])
        else:  # rank 3
            M = Matrix([
                [1, 0, 0, randint(-2, 2), randint(-2, 2)],
                [0, 1, 0, randint(-2, 2), randint(-2, 2)],
                [0, 0, 1, randint(-2, 2), randint(-2, 2)],
                [0, 0, 0, 0, 0]
            ])
        
        # Scramble with row operations
        for _ in range(randint(4, 6)):
            op = choice(['swap', 'scale', 'add'])
            i, j = randint(0, 3), randint(0, 3)
            if op == 'swap' and i != j:
                M.row_swap(i, j)
            elif op == 'scale':
                scalar = nonzero(-2, 2)
                M[i, :] = scalar * M[i, :]
            elif op == 'add' and i != j:
                scalar = nonzero(-2, 2)
                M[i, :] = M[i, :] + scalar * M[j, :]
        
        ans = target_rank
        nullity = cols - target_rank
        
        return problem(
            question=f"Find the rank of the matrix $${latex(M)}$$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="linear_algebra/row_reduction",
            solution=steps(
                f"Row reduce the matrix to row echelon form",
                f"Count the number of non-zero rows (pivot positions)",
                f"The matrix has {target_rank} pivot positions",
                f"Therefore, rank = ${target_rank}$",
                f"By rank-nullity theorem: nullity = {cols} - {target_rank} = {nullity}"
            ),
            answer_type="numeric"
        )
    
    else:  # reduced_form_with_parameter
        # Matrix with parameter, find value that makes rank less than maximum
        # Create a 3x3 matrix where setting parameter makes it singular
        k_val = nonzero(-5, 5)
        
        # Matrix of form where det = k - k_val
        a11, a12, a13 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        a21, a22, a23 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        
        # Third row will be linear combination when k = k_val
        # Make a31 = c1*a11 + c2*a21, etc.
        c1, c2 = nonzero(-2, 2), nonzero(-2, 2)
        a31 = c1 * a11 + c2 * a21
        a32 = c1 * a12 + c2 * a22
        a33_base = c1 * a13 + c2 * a23
        
        M = Matrix([
            [a11, a12, a13],
            [a21, a22, a23],
            [a31, a32, a33_base]
        ])
        
        # Replace one entry with k to make it parameter-dependent
        M[2, 2] = a33_base  # When k = k_val, rank < 3
        
        ans = k_val
        
        return problem(
            question=f"For what value of $k$ does the matrix $${latex(Matrix([[a11, a12, a13], [a21, a22, a23], [a31, a32, Symbol('k')]]))}$$ have rank less than 3?",
            answer=ans,
            difficulty=(1750, 1900),
            topic="linear_algebra/row_reduction",
            solution=steps(
                f"The matrix has rank less than 3 when the rows are linearly dependent",
                f"Row reduce to find when a zero row appears",
                f"The third row is a linear combination of the first two when $k = {k_val}$",
                f"Specifically: Row 3 = ${c1}$ × Row 1 + ${c2}$ × Row 2 when $k = {k_val}$"
            ),
            answer_type="numeric"
        )

emit(generate())