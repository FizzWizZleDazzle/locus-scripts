"""
linear_algebra - eigenvalues (medium)
Generated: 2026-02-22T05:58:43.499052
"""

from problem_utils import *

def generate():
    difficulty_choice = randint(1, 3)
    
    if difficulty_choice == 1:
        # 1300-1400: 2x2 matrix with integer eigenvalues, simple characteristic polynomial
        # Construct from eigenvalues
        lambda1 = randint(-3, 3)
        lambda2 = randint(-3, 3)
        while lambda2 == lambda1:
            lambda2 = randint(-3, 3)
        
        # Simple diagonal matrix or nearly diagonal
        if randint(0, 1) == 0:
            # Diagonal matrix
            M = Matrix([[lambda1, 0], [0, lambda2]])
        else:
            # Upper triangular
            off_diag = nonzero(-2, 2)
            M = Matrix([[lambda1, off_diag], [0, lambda2]])
        
        eigenvals = sorted([lambda1, lambda2])
        ans = FiniteSet(*eigenvals)
        
        M_latex = latex(M)
        char_poly = M.charpoly(x)
        
        solution_steps = steps(
            f"Find the characteristic polynomial: $\\det(A - \\lambda I) = 0$",
            f"$\\det\\left({latex(M - x*eye(2))}\\right) = 0$",
            f"${latex(char_poly.as_expr())} = 0$",
            f"Solve for $\\lambda$: ${latex(eigenvals[0])}, {latex(eigenvals[1])}$"
        )
        
        return problem(
            question=f"Find all eigenvalues of the matrix $A = {M_latex}$",
            answer=ans,
            difficulty=(1300, 1400),
            topic="linear_algebra/eigenvalues",
            solution=solution_steps,
            answer_type="set"
        )
    
    elif difficulty_choice == 2:
        # 1400-1500: 2x2 matrix requiring characteristic polynomial factoring
        # Build from eigenvalues
        lambda1 = nonzero(-4, 4)
        lambda2 = nonzero(-4, 4)
        
        # Create a general 2x2 matrix with these eigenvalues
        # Use trace and determinant relationships
        trace_val = lambda1 + lambda2
        det_val = lambda1 * lambda2
        
        # Random 2x2 with prescribed trace and determinant
        a_val = randint(-3, 3)
        d_val = trace_val - a_val
        # det = ad - bc, so bc = ad - det
        bc_product = a_val * d_val - det_val
        
        # Find b, c such that bc = bc_product
        if bc_product == 0:
            b_val = 0
            c_val = nonzero(-3, 3)
        else:
            divisors = [i for i in range(1, abs(bc_product) + 1) if bc_product % i == 0]
            if divisors:
                b_val = choice(divisors) * (1 if bc_product > 0 else -1)
                c_val = bc_product // b_val
            else:
                b_val = 1
                c_val = bc_product
        
        M = Matrix([[a_val, b_val], [c_val, d_val]])
        
        # Verify eigenvalues
        actual_eigenvals = M.eigenvals()
        eigenvals_list = sorted([k for k in actual_eigenvals.keys()])
        ans = FiniteSet(*eigenvals_list)
        
        M_latex = latex(M)
        char_poly = M.charpoly(x)
        
        solution_steps = steps(
            f"Compute the characteristic polynomial: $\\det(A - \\lambda I) = 0$",
            f"$\\det\\left({latex(M - x*eye(2))}\\right) = 0$",
            f"${latex(char_poly.as_expr())} = 0$",
            f"${latex(factor(char_poly.as_expr()))} = 0$",
            f"Eigenvalues: $\\lambda = {latex(eigenvals_list[0])}, {latex(eigenvals_list[1])}$"
        )
        
        return problem(
            question=f"Find all eigenvalues of $A = {M_latex}$",
            answer=ans,
            difficulty=(1400, 1500),
            topic="linear_algebra/eigenvalues",
            solution=solution_steps,
            answer_type="set"
        )
    
    else:
        # 1500-1600: 3x3 matrix with integer eigenvalues, or 2x2 with one repeated eigenvalue
        if randint(0, 1) == 0:
            # 3x3 diagonal or triangular
            lambda1 = randint(-3, 3)
            lambda2 = randint(-3, 3)
            lambda3 = randint(-3, 3)
            
            # Upper triangular for simplicity
            M = Matrix([
                [lambda1, nonzero(-2, 2), nonzero(-2, 2)],
                [0, lambda2, nonzero(-2, 2)],
                [0, 0, lambda3]
            ])
            
            eigenvals = sorted([lambda1, lambda2, lambda3])
            ans = FiniteSet(*eigenvals)
            
            M_latex = latex(M)
            
            solution_steps = steps(
                f"For a triangular matrix, eigenvalues are the diagonal entries",
                f"Eigenvalues: ${latex(lambda1)}, {latex(lambda2)}, {latex(lambda3)}$"
            )
            
            return problem(
                question=f"Find all eigenvalues of $A = {M_latex}$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="linear_algebra/eigenvalues",
                solution=solution_steps,
                answer_type="set"
            )
        else:
            # 2x2 with repeated eigenvalue
            lambda_val = nonzero(-4, 4)
            off_diag = nonzero(-3, 3)
            
            # Matrix with repeated eigenvalue
            M = Matrix([[lambda_val, off_diag], [0, lambda_val]])
            
            ans = FiniteSet(lambda_val)
            M_latex = latex(M)
            char_poly = M.charpoly(x)
            
            solution_steps = steps(
                f"Compute characteristic polynomial: $\\det(A - \\lambda I) = 0$",
                f"${latex(char_poly.as_expr())} = 0$",
                f"This gives a repeated eigenvalue: $\\lambda = {latex(lambda_val)}$ (multiplicity 2)"
            )
            
            return problem(
                question=f"Find all distinct eigenvalues of $A = {M_latex}$",
                answer=ans,
                difficulty=(1500, 1600),
                topic="linear_algebra/eigenvalues",
                solution=solution_steps,
                answer_type="set"
            )

emit(generate())