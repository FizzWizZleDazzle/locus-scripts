"""
linear_algebra - eigenvalues (hard)
Generated: 2026-02-22T05:59:15.577016
"""

from problem_utils import *

def generate():
    problem_type = choice(['characteristic_polynomial', 'parametric_eigenvalues', 'algebraic_multiplicity', 'eigenspace_dimension', 'trace_determinant'])
    
    if problem_type == 'characteristic_polynomial':
        # Generate a 3x3 matrix with known eigenvalues
        eigenvals = [nonzero(-4, 4), nonzero(-4, 4), nonzero(-4, 4)]
        
        # Create diagonal matrix with these eigenvalues
        D = Matrix([[eigenvals[0], 0, 0],
                    [0, eigenvals[1], 0],
                    [0, 0, eigenvals[2]]])
        
        # Create a random invertible transformation matrix
        P = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                    [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                    [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
        
        # Ensure P is invertible by checking determinant
        while P.det() == 0:
            P = Matrix([[nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                        [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)],
                        [nonzero(-2, 2), nonzero(-2, 2), nonzero(-2, 2)]])
        
        A = P * D * P.inv()
        A = A.applyfunc(lambda e: simplify(e))
        
        # Compute characteristic polynomial
        lam = symbols('lambda')
        char_poly = (A - lam * eye(3)).det()
        char_poly = expand(char_poly)
        
        ans = char_poly
        
        return problem(
            question=f"Find the characteristic polynomial of the matrix $A = {latex(A)}$",
            answer=ans,
            difficulty=(1600, 1750),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"The characteristic polynomial is $\\det(A - \\lambda I)$",
                f"$A - \\lambda I = {latex(A - lam * eye(3))}$",
                f"Computing the determinant yields: ${latex(char_poly)}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'parametric_eigenvalues':
        # Matrix with parameter that affects eigenvalues
        param = symbols('a')
        val1 = nonzero(-3, 3)
        val2 = nonzero(-3, 3)
        
        A = Matrix([[val1, param],
                    [0, val2]])
        
        # For this triangular matrix, eigenvalues are diagonal entries
        # Ask for what value of a makes one eigenvalue equal to a specific value
        target = nonzero(-5, 5)
        
        # Since eigenvalues are val1 and val2, ask when one equals target
        if randint(0, 1) == 0:
            # Make val1 = target (impossible if they're different)
            # Better: use non-triangular
            pass
        
        # Use a better parametric case
        k_val = nonzero(-3, 3)
        A = Matrix([[k_val, a],
                    [a, k_val]])
        
        # Eigenvalues are k_val ± a
        # Ask for value of a that makes largest eigenvalue equal to target
        target_eval = nonzero(1, 6)
        ans = target_eval - k_val
        
        return problem(
            question=f"For what value of $a$ does the matrix $A = {latex(A)}$ have ${target_eval}$ as its largest eigenvalue?",
            answer=ans,
            difficulty=(1650, 1800),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Find the characteristic polynomial: $\\det(A - \\lambda I) = \\det{latex(A - symbols('lambda')*eye(2))}$",
                f"This gives $(({k_val} - \\lambda))^2 - a^2 = 0$",
                f"Eigenvalues are $\\lambda = {k_val} \\pm a$",
                f"For largest eigenvalue to be ${target_eval}$: ${k_val} + |a| = {target_eval}$",
                f"Therefore $a = \\pm {abs(ans)}$, taking positive: $a = {ans}$"
            ),
            calculator="scientific"
        )
    
    elif problem_type == 'algebraic_multiplicity':
        # 4x4 matrix with repeated eigenvalues
        eval1 = nonzero(-3, 3)
        eval2 = nonzero(-3, 3)
        while eval2 == eval1:
            eval2 = nonzero(-3, 3)
        
        # Create block diagonal matrix
        A = Matrix([[eval1, 1, 0, 0],
                    [0, eval1, 0, 0],
                    [0, 0, eval2, 1],
                    [0, 0, 0, eval2]])
        
        ans = 2  # algebraic multiplicity of eval1
        
        return problem(
            question=f"What is the algebraic multiplicity of the eigenvalue $\\lambda = {eval1}$ for the matrix $A = {latex(A)}$?",
            answer=ans,
            difficulty=(1600, 1700),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"The characteristic polynomial is $\\det(A - \\lambda I)$",
                f"For this upper triangular matrix, the characteristic polynomial is $(\\lambda - {eval1})^2(\\lambda - {eval2})^2$",
                f"The algebraic multiplicity of $\\lambda = {eval1}$ is the exponent in this factorization: $2$"
            ),
            calculator="none"
        )
    
    elif problem_type == 'eigenspace_dimension':
        # Matrix where geometric multiplicity < algebraic multiplicity
        eval_val = nonzero(-3, 3)
        
        A = Matrix([[eval_val, 1, 0],
                    [0, eval_val, 1],
                    [0, 0, eval_val]])
        
        # This is Jordan block, geometric multiplicity is 1
        ans = 1
        
        return problem(
            question=f"Find the dimension of the eigenspace corresponding to $\\lambda = {eval_val}$ for the matrix $A = {latex(A)}$",
            answer=ans,
            difficulty=(1700, 1850),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"The eigenspace is $\\text{{null}}(A - {eval_val}I)$",
                f"$A - {eval_val}I = {latex(A - eval_val*eye(3))}$",
                f"Row reduce to find nullity: this matrix has rank 2",
                f"Dimension of eigenspace = $3 - 2 = 1$"
            ),
            calculator="none"
        )
    
    else:  # trace_determinant
        # Use trace and determinant relationships with eigenvalues
        # For 2x2 matrix with known trace and det, find eigenvalues
        trace_val = nonzero(-6, 6)
        det_val = nonzero(-8, 8)
        
        # Eigenvalues satisfy: λ₁ + λ₂ = trace, λ₁λ₂ = det
        # They are roots of λ² - trace·λ + det = 0
        
        discriminant = trace_val**2 - 4*det_val
        
        if discriminant >= 0:
            lam1 = (trace_val + sqrt(discriminant)) / 2
            lam2 = (trace_val - sqrt(discriminant)) / 2
            ans = FiniteSet(lam1, lam2)
        else:
            # Complex eigenvalues
            real_part = Rational(trace_val, 2)
            imag_part = sqrt(-discriminant) / 2
            ans = FiniteSet(real_part + I*imag_part, real_part - I*imag_part)
        
        return problem(
            question=f"A $2 \\times 2$ matrix has trace ${trace_val}$ and determinant ${det_val}$. Find its eigenvalues.",
            answer=ans,
            difficulty=(1650, 1800),
            topic="linear_algebra/eigenvalues",
            solution=steps(
                f"Let eigenvalues be $\\lambda_1, \\lambda_2$",
                f"We know $\\lambda_1 + \\lambda_2 = {trace_val}$ and $\\lambda_1 \\lambda_2 = {det_val}$",
                f"Eigenvalues are roots of $\\lambda^2 - {trace_val}\\lambda + {det_val} = 0$",
                f"Using quadratic formula: $\\lambda = \\frac{{{trace_val} \\pm \\sqrt{{{trace_val**2} - {4*det_val}}}}}{2}$",
                f"Eigenvalues are ${latex(ans)}$"
            ),
            calculator="scientific"
        )

emit(generate())