"""
linear_algebra - determinants (hard)
Generated: 2026-02-22T05:52:58.033578
"""

from problem_utils import *

def generate():
    problem_type = randint(1, 5)
    
    if problem_type == 1:
        # Determinant of 3x3 with parameters
        param = choice([a, b, c, d, k, m])
        v1 = randint(-2, 2)
        v2 = randint(-2, 2)
        v3 = nonzero(-3, 3)
        v4 = nonzero(-2, 2)
        
        M = Matrix([
            [param, v1, v2],
            [v3, param, v4],
            [v2, v1, param**2]
        ])
        
        det_expr = M.det()
        det_simplified = simplify(det_expr)
        
        return problem(
            question=f"Find the determinant of the matrix $\\begin{{pmatrix}} {latex(param)} & {v1} & {v2} \\\\ {v3} & {latex(param)} & {v4} \\\\ {v2} & {v1} & {latex(param**2)} \\end{{pmatrix}}$",
            answer=det_simplified,
            difficulty=(1650, 1750),
            topic="linear_algebra/determinants",
            solution=steps(
                f"Use cofactor expansion or the rule of Sarrus for a $3 \\times 3$ matrix",
                f"$\\det(M) = {latex(M[0,0])}({latex(M[1,1])} \\cdot {latex(M[2,2])} - {latex(M[1,2])} \\cdot {latex(M[2,1])}) - {latex(M[0,1])}({latex(M[1,0])} \\cdot {latex(M[2,2])} - {latex(M[1,2])} \\cdot {latex(M[2,0])}) + {latex(M[0,2])}({latex(M[1,0])} \\cdot {latex(M[2,1])} - {latex(M[1,1])} \\cdot {latex(M[2,0])})$",
                f"Simplifying: ${latex(det_simplified)}$"
            )
        )
    
    elif problem_type == 2:
        # Find parameter value for which determinant equals a specific value
        target = choice([0, 1, -1])
        v1 = nonzero(-3, 3)
        v2 = nonzero(-3, 3)
        v3 = nonzero(-2, 2)
        v4 = nonzero(-2, 2)
        
        M = Matrix([
            [x, v1, v2],
            [v3, x, v4],
            [v2, v1, x]
        ])
        
        det_expr = M.det()
        equation = Eq(det_expr, target)
        solutions = solve(equation, x)
        
        # Pick one real solution or the simplest one
        if solutions:
            ans = solutions[0] if len(solutions) == 1 else solutions
            if isinstance(ans, list):
                ans = FiniteSet(*[sol for sol in ans if sol.is_real])
            
            return problem(
                question=f"Find all real values of $x$ for which $\\det\\begin{{pmatrix}} x & {v1} & {v2} \\\\ {v3} & x & {v4} \\\\ {v2} & {v1} & x \\end{{pmatrix}} = {target}$",
                answer=ans,
                difficulty=(1700, 1800),
                topic="linear_algebra/determinants",
                solution=steps(
                    f"Calculate the determinant: ${latex(det_expr)}$",
                    f"Set equal to ${target}$: ${latex(equation)}$",
                    f"Solve: $x \\in {latex(ans)}$"
                )
            )
    
    elif problem_type == 3:
        # Determinant with row operations or special structure
        v1 = nonzero(-3, 3)
        v2 = nonzero(-3, 3)
        v3 = nonzero(-3, 3)
        v4 = nonzero(-2, 2)
        v5 = nonzero(-2, 2)
        v6 = nonzero(-2, 2)
        
        # Create matrix with two proportional rows modified
        M = Matrix([
            [v1, v2, v3],
            [2*v1, 2*v2 + v4, 2*v3],
            [v5, v6, nonzero(-3, 3)]
        ])
        
        det_val = M.det()
        
        return problem(
            question=f"Compute $\\det\\begin{{pmatrix}} {v1} & {v2} & {v3} \\\\ {2*v1} & {2*v2 + v4} & {2*v3} \\\\ {v5} & {v6} & {M[2,2]} \\end{{pmatrix}}$",
            answer=det_val,
            difficulty=(1600, 1700),
            topic="linear_algebra/determinants",
            solution=steps(
                f"Notice that row 2 is almost $2 \\times$ row 1",
                f"Use row operation: $R_2 \\to R_2 - 2R_1$",
                f"This gives row 2 as $(0, {v4}, 0)$",
                f"Expand along row 2: $\\det = {v4} \\cdot ({v1} \\cdot {M[2,2]} - {v3} \\cdot {v5})$",
                f"$= {latex(det_val)}$"
            )
        )
    
    elif problem_type == 4:
        # 4x4 determinant with special structure
        v1 = nonzero(-2, 2)
        v2 = nonzero(-2, 2)
        v3 = nonzero(-2, 2)
        v4 = nonzero(-2, 2)
        
        # Upper triangular or block structure
        M = Matrix([
            [v1, v2, v3, v4],
            [0, v2, v3, v1],
            [0, 0, v1, v2],
            [0, 0, 0, v3]
        ])
        
        det_val = M.det()
        
        return problem(
            question=f"Find the determinant of $\\begin{{pmatrix}} {v1} & {v2} & {v3} & {v4} \\\\ 0 & {v2} & {v3} & {v1} \\\\ 0 & 0 & {v1} & {v2} \\\\ 0 & 0 & 0 & {v3} \\end{{pmatrix}}$",
            answer=det_val,
            difficulty=(1600, 1700),
            topic="linear_algebra/determinants",
            solution=steps(
                f"This is an upper triangular matrix",
                f"The determinant is the product of diagonal entries",
                f"$\\det = {v1} \\cdot {v2} \\cdot {v1} \\cdot {v3} = {det_val}$"
            )
        )
    
    else:
        # Determinant property: det(AB) = det(A)det(B)
        v1 = nonzero(-2, 2)
        v2 = nonzero(-2, 2)
        v3 = nonzero(-2, 2)
        v4 = nonzero(-2, 2)
        
        A = Matrix([
            [v1, v2],
            [v3, v4]
        ])
        
        B = Matrix([
            [v4, -v2],
            [-v3, v1]
        ])
        
        det_A = A.det()
        det_B = B.det()
        det_product = det_A * det_B
        
        return problem(
            question=f"Let $A = \\begin{{pmatrix}} {v1} & {v2} \\\\ {v3} & {v4} \\end{{pmatrix}}$ and $B = \\begin{{pmatrix}} {v4} & {-v2} \\\\ {-v3} & {v1} \\end{{pmatrix}}$. Find $\\det(AB)$.",
            answer=det_product,
            difficulty=(1650, 1800),
            topic="linear_algebra/determinants",
            solution=steps(
                f"Use the property $\\det(AB) = \\det(A) \\cdot \\det(B)$",
                f"$\\det(A) = {v1} \\cdot {v4} - {v2} \\cdot {v3} = {det_A}$",
                f"$\\det(B) = {v4} \\cdot {v1} - ({-v2}) \\cdot ({-v3}) = {det_B}$",
                f"$\\det(AB) = {det_A} \\cdot {det_B} = {det_product}$"
            )
        )

emit(generate())