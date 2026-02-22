"""
differential_equations - systems_of_odes (hard)
Generated: 2026-02-22T05:33:14.270574
"""

from problem_utils import *

def generate():
    problem_type = choice(['eigenvalue_system', 'phase_portrait', 'stability_analysis', 'nonhomogeneous_system'])
    
    if problem_type == 'eigenvalue_system':
        # System x' = Ax, find general solution using eigenvalues/eigenvectors
        # Construct matrix with known eigenvalues and eigenvectors
        lambda1 = nonzero(-3, 3)
        lambda2 = nonzero(-3, 3)
        while lambda2 == lambda1:
            lambda2 = nonzero(-3, 3)
        
        # Create a matrix with these eigenvalues
        # Use a diagonal matrix then apply a change of basis
        a = nonzero(-2, 2)
        b = nonzero(-2, 2)
        c = nonzero(-2, 2)
        d = nonzero(-2, 2)
        
        # Ensure det != 0
        while a*d - b*c == 0:
            d = nonzero(-2, 2)
        
        A = Matrix([[a, b], [c, d]])
        
        # Compute eigenvalues symbolically
        eigs = A.eigenvals()
        eigvects = A.eigenvects()
        
        # Check if we have two distinct real eigenvalues
        if len(eigvects) != 2:
            # Fallback to a simple diagonal-like matrix
            A = Matrix([[lambda1, 0], [0, lambda2]])
            eigs = {lambda1: 1, lambda2: 1}
            eigvects = [(lambda1, 1, [Matrix([1, 0])]), (lambda2, 1, [Matrix([0, 1])])]
        
        question = f"Solve the system $\\mathbf{{x}}' = {latex(A)} \\mathbf{{x}}$. Find the general solution."
        
        # Build solution string with constants
        v1 = eigvects[0][2][0]
        v2 = eigvects[1][2][0]
        lam1 = eigvects[0][0]
        lam2 = eigvects[1][0]
        
        sol_vec = Matrix([
            [v1[0] * exp(lam1 * t)],
            [v1[1] * exp(lam1 * t)]
        ]) * Symbol('C_1') + Matrix([
            [v2[0] * exp(lam2 * t)],
            [v2[1] * exp(lam2 * t)]
        ]) * Symbol('C_2')
        
        solution_steps = steps(
            f"Find eigenvalues: $\\det({latex(A - Matrix([[Symbol('lambda'), 0], [0, Symbol('lambda')]]))}) = 0$",
            f"Eigenvalues: $\\lambda_1 = {latex(lam1)}, \\lambda_2 = {latex(lam2)}$",
            f"Eigenvector for $\\lambda_1$: ${latex(v1)}$",
            f"Eigenvector for $\\lambda_2$: ${latex(v2)}$",
            f"General solution: $\\mathbf{{x}}(t) = C_1 {latex(v1)} e^{{{latex(lam1)} t}} + C_2 {latex(v2)} e^{{{latex(lam2)} t}}$"
        )
        
        return problem(
            question=question,
            answer=sol_vec,
            difficulty=(1650, 1850),
            topic="differential_equations/systems_of_odes",
            solution=solution_steps,
            grading_mode="equivalent"
        )
    
    elif problem_type == 'phase_portrait':
        # Determine stability and behavior from eigenvalues
        case = choice(['stable_node', 'unstable_node', 'saddle', 'stable_spiral', 'unstable_spiral'])
        
        if case == 'stable_node':
            lambda1 = randint(-5, -1)
            lambda2 = randint(-5, -1)
            A = Matrix([[lambda1, 0], [0, lambda2]])
            answer = "stable node"
            explanation = "Both eigenvalues are negative, so all trajectories approach the origin."
            
        elif case == 'unstable_node':
            lambda1 = randint(1, 5)
            lambda2 = randint(1, 5)
            A = Matrix([[lambda1, 0], [0, lambda2]])
            answer = "unstable node"
            explanation = "Both eigenvalues are positive, so all trajectories move away from the origin."
            
        elif case == 'saddle':
            lambda1 = randint(-4, -1)
            lambda2 = randint(1, 4)
            A = Matrix([[lambda1, 0], [0, lambda2]])
            answer = "saddle point"
            explanation = "Eigenvalues have opposite signs, creating a saddle point."
            
        elif case == 'stable_spiral':
            re_part = randint(-3, -1)
            im_part = randint(1, 4)
            a = re_part
            b = im_part
            A = Matrix([[a, -b], [b, a]])
            answer = "stable spiral"
            explanation = f"Complex eigenvalues $\\lambda = {a} \\pm {b}i$ with negative real part create a stable spiral."
            
        else:  # unstable_spiral
            re_part = randint(1, 3)
            im_part = randint(1, 4)
            a = re_part
            b = im_part
            A = Matrix([[a, -b], [b, a]])
            answer = "unstable spiral"
            explanation = f"Complex eigenvalues $\\lambda = {a} \\pm {b}i$ with positive real part create an unstable spiral."
        
        question = f"Classify the equilibrium point at the origin for the system $\\mathbf{{x}}' = {latex(A)} \\mathbf{{x}}$."
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1600, 1800),
            topic="differential_equations/systems_of_odes",
            solution=steps(
                f"Find eigenvalues of ${latex(A)}$",
                explanation,
                f"Classification: {answer}"
            ),
            answer_type="text"
        )
    
    elif problem_type == 'stability_analysis':
        # Given a matrix, determine if origin is asymptotically stable
        trace_val = randint(-6, 6)
        det_val = randint(1, 10)
        
        # Ensure trace^2 - 4*det conditions for real/complex eigenvalues
        discriminant = trace_val**2 - 4*det_val
        
        if trace_val < 0 and det_val > 0:
            answer = True  # Stable
            reason = "Trace is negative and determinant is positive, ensuring both eigenvalues have negative real parts."
        elif trace_val > 0 and det_val > 0:
            answer = False  # Unstable
            reason = "Trace is positive, so at least one eigenvalue has positive real part."
        elif det_val < 0:
            answer = False  # Saddle, unstable
            reason = "Determinant is negative, so eigenvalues have opposite signs (saddle point)."
        else:
            answer = False
            reason = "System is not asymptotically stable."
        
        # Construct a matrix with given trace and determinant
        a = randint(-3, 3)
        d = trace_val - a
        bc = det_val - a*d
        
        if bc <= 0:
            b = 1
            c = bc
        else:
            b = randint(1, 3)
            c = bc // b if bc % b == 0 else bc
        
        A = Matrix([[a, b], [c, d]])
        actual_trace = A.trace()
        actual_det = A.det()
        
        question = f"Is the origin an asymptotically stable equilibrium for $\\mathbf{{x}}' = {latex(A)} \\mathbf{{x}}$?"
        
        return problem(
            question=question,
            answer=answer,
            difficulty=(1650, 1850),
            topic="differential_equations/systems_of_odes",
            solution=steps(
                f"Compute trace: $tr(A) = {actual_trace}$",
                f"Compute determinant: $\\det(A) = {actual_det}$",
                reason,
                f"Answer: {'Yes' if answer else 'No'}"
            ),
            answer_type="boolean"
        )
    
    else:  # nonhomogeneous_system
        # Solve x' = Ax + b using particular solution
        lambda1 = nonzero(-2, 2)
        lambda2 = nonzero(-2, 2)
        while lambda2 == lambda1:
            lambda2 = nonzero(-2, 2)
        
        A = Matrix([[lambda1, 0], [0, lambda2]])
        b1 = nonzero(-5, 5)
        b2 = nonzero(-5, 5)
        b_vec = Matrix([b1, b2])
        
        # Particular solution is constant: x_p = -A^(-1) * b
        x_p = -A.inv() * b_vec
        
        question = f"Find a particular solution to $\\mathbf{{x}}' = {latex(A)} \\mathbf{{x}} + {latex(b_vec)}$."
        
        return problem(
            question=question,
            answer=x_p,
            difficulty=(1700, 1900),
            topic="differential_equations/systems_of_odes",
            solution=steps(
                "For constant forcing term, try constant particular solution $\\mathbf{x}_p$",
                f"Then $0 = {latex(A)} \\mathbf{{x}}_p + {latex(b_vec)}$",
                f"So $\\mathbf{{x}}_p = -{latex(A)}^{{-1}} {latex(b_vec)}$",
                f"$\\mathbf{{x}}_p = {latex(x_p)}$"
            ),
            answer_type="matrix"
        )

emit(generate())