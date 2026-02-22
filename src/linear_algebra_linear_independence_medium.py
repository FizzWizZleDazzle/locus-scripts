"""
linear_algebra - linear_independence (medium)
Generated: 2026-02-22T05:57:32.470629
"""

from problem_utils import *

def generate():
    problem_type = choice(['2d_vectors', '3d_vectors', 'symbolic_2d', 'symbolic_3d'])
    
    if problem_type == '2d_vectors':
        # Two vectors in R^2 - check if linearly independent
        # Make them either dependent or independent
        is_independent = choice([True, False])
        
        if is_independent:
            # Create two independent vectors
            v1_x, v1_y = nonzero(-5, 5), nonzero(-5, 5)
            # Ensure v2 is not a scalar multiple of v1
            v2_x = nonzero(-5, 5)
            # Make sure v2_y makes them independent (not proportional)
            v2_y = nonzero(-5, 5)
            # Check they're not proportional
            while v1_x * v2_y == v1_y * v2_x:
                v2_y = nonzero(-5, 5)
            
            v1 = Matrix([v1_x, v1_y])
            v2 = Matrix([v2_x, v2_y])
            ans = True
            
            det_val = v1_x * v2_y - v1_y * v2_x
            
            solution = steps(
                f"Form a matrix with vectors as columns: $A = {latex(Matrix([[v1_x, v2_x], [v1_y, v2_y]]))}$",
                f"Calculate determinant: $\\det(A) = {v1_x} \\cdot {v2_y} - {v1_y} \\cdot {v2_x} = {det_val}$",
                f"Since $\\det(A) \\neq 0$, the vectors are linearly independent.",
            )
        else:
            # Create two dependent vectors (one is scalar multiple of other)
            v1_x, v1_y = nonzero(-4, 4), nonzero(-4, 4)
            scalar = choice([-3, -2, 2, 3])
            v2_x, v2_y = scalar * v1_x, scalar * v1_y
            
            v1 = Matrix([v1_x, v1_y])
            v2 = Matrix([v2_x, v2_y])
            ans = False
            
            solution = steps(
                f"Form a matrix with vectors as columns: $A = {latex(Matrix([[v1_x, v2_x], [v1_y, v2_y]]))}$",
                f"Calculate determinant: $\\det(A) = {v1_x} \\cdot {v2_y} - {v1_y} \\cdot {v2_x} = 0$",
                f"Since $\\det(A) = 0$, the vectors are linearly dependent.",
                f"Note: ${latex(v2)} = {scalar} \\cdot {latex(v1)}$",
            )
        
        question = f"Are the vectors ${latex(v1)}$ and ${latex(v2)}$ linearly independent?"
        difficulty = (1300, 1400)
        
    elif problem_type == '3d_vectors':
        # Three vectors in R^3 - check if linearly independent
        is_independent = choice([True, False])
        
        if is_independent:
            # Create three independent vectors by constructing matrix with non-zero det
            while True:
                v1 = Matrix([nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)])
                v2 = Matrix([nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)])
                v3 = Matrix([nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)])
                
                M = Matrix([[v1[0], v2[0], v3[0]], 
                           [v1[1], v2[1], v3[1]], 
                           [v1[2], v2[2], v3[2]]])
                det_val = M.det()
                
                if det_val != 0:
                    break
            
            ans = True
            
            solution = steps(
                f"Form a matrix with vectors as columns: $A = {latex(M)}$",
                f"Calculate determinant: $\\det(A) = {det_val}$",
                f"Since $\\det(A) \\neq 0$, the vectors are linearly independent.",
            )
        else:
            # Make third vector a linear combination of first two
            v1 = Matrix([nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)])
            v2 = Matrix([nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)])
            c1, c2 = nonzero(-2, 2), nonzero(-2, 2)
            v3 = c1 * v1 + c2 * v2
            
            M = Matrix([[v1[0], v2[0], v3[0]], 
                       [v1[1], v2[1], v3[1]], 
                       [v1[2], v2[2], v3[2]]])
            
            ans = False
            
            solution = steps(
                f"Form a matrix with vectors as columns: $A = {latex(M)}$",
                f"Calculate determinant: $\\det(A) = 0$",
                f"Since $\\det(A) = 0$, the vectors are linearly dependent.",
                f"Note: ${latex(v3)} = {c1} \\cdot {latex(v1)} + {c2} \\cdot {latex(v2)}$",
            )
        
        question = f"Are the vectors ${latex(v1)}$, ${latex(v2)}$, and ${latex(v3)}$ linearly independent?"
        difficulty = (1400, 1500)
        
    elif problem_type == 'symbolic_2d':
        # Two 2D vectors with a parameter - find when they're dependent
        v1_x, v1_y = nonzero(-4, 4), nonzero(-4, 4)
        v2_x = nonzero(-4, 4)
        # v2_y will be 'a' (parameter)
        
        v1 = Matrix([v1_x, v1_y])
        v2_str = f"\\begin{{pmatrix}} {v2_x} \\\\ a \\end{{pmatrix}}"
        
        # For dependence: v1_x * a - v1_y * v2_x = 0
        # So a = v1_y * v2_x / v1_x
        ans = Rational(v1_y * v2_x, v1_x)
        
        question = f"For what value of $a$ are the vectors ${latex(v1)}$ and ${v2_str}$ linearly dependent?"
        
        solution = steps(
            f"Vectors are linearly dependent when determinant equals zero:",
            f"$\\det\\begin{{pmatrix}} {v1_x} & {v2_x} \\\\ {v1_y} & a \\end{{pmatrix}} = 0$",
            f"${v1_x} \\cdot a - {v1_y} \\cdot {v2_x} = 0$",
            f"${v1_x}a = {v1_y * v2_x}$",
            f"$a = {latex(ans)}$",
        )
        difficulty = (1500, 1600)
        
    else:  # symbolic_3d
        # Simpler 3D case with parameter
        v1_x, v1_y, v1_z = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        v2_x, v2_y, v2_z = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        
        # Third vector is (something, something, a)
        v3_x, v3_y = nonzero(-3, 3), nonzero(-3, 3)
        
        v1 = Matrix([v1_x, v1_y, v1_z])
        v2 = Matrix([v2_x, v2_y, v2_z])
        v3_str = f"\\begin{{pmatrix}} {v3_x} \\\\ {v3_y} \\\\ a \\end{{pmatrix}}"
        
        # Det calculation for when det = 0
        M_symbolic = Matrix([[v1_x, v2_x, v3_x], 
                            [v1_y, v2_y, v3_y], 
                            [v1_z, v2_z, a]])
        
        det_expr = M_symbolic.det()
        # Solve for a
        ans_vals = solve(det_expr, a)
        ans = ans_vals[0] if ans_vals else 0
        
        question = f"For what value of $a$ are the vectors ${latex(v1)}$, ${latex(v2)}$, and ${v3_str}$ linearly dependent?"
        
        solution = steps(
            f"Vectors are linearly dependent when determinant equals zero:",
            f"$\\det{latex(Matrix([[v1_x, v2_x, v3_x], [v1_y, v2_y, v3_y], [v1_z, v2_z, 'a']]))} = 0$",
            f"Expanding: ${latex(det_expr)} = 0$",
            f"$a = {latex(ans)}$",
        )
        difficulty = (1500, 1600)
    
    return problem(
        question=question,
        answer=ans,
        difficulty=difficulty,
        topic="linear_algebra/linear_independence",
        solution=solution,
    )

emit(generate())