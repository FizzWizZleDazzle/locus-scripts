# linear_algebra - matrix_inverses (very_hard)
# Generated: 2026-03-08T21:09:06.083649

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_inverses")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Competition: Find matrix inverse with specific eigenvalue constraints
        λ1 = nonzero(-5, 5)
        λ2 = nonzero(-5, 5)
        while λ2 == λ1
            λ2 = nonzero(-5, 5)
        end
        
        # Construct diagonalizable matrix with known eigenvalues
        P = [[randint(-3, 3), randint(-3, 3)], [randint(-3, 3), randint(-3, 3)]]
        while abs(P[1][1] * P[2][2] - P[1][2] * P[2][1]) < 1
            P = [[randint(-3, 3), randint(-3, 3)], [randint(-3, 3), randint(-3, 3)]]
        end
        
        D = [[λ1, 0], [0, λ2]]
        
        # A = P * D * P^(-1), so A^(-1) = P * D^(-1) * P^(-1)
        det_P = P[1][1] * P[2][2] - P[1][2] * P[2][1]
        P_inv = [[P[2][2]//det_P, -P[1][2]//det_P], [-P[2][1]//det_P, P[1][1]//det_P]]
        
        A = [[P[1][1]*λ1*P_inv[1][1] + P[1][2]*λ2*P_inv[2][1], P[1][1]*λ1*P_inv[1][2] + P[1][2]*λ2*P_inv[2][2]],
             [P[2][1]*λ1*P_inv[1][1] + P[2][2]*λ2*P_inv[2][1], P[2][1]*λ1*P_inv[1][2] + P[2][2]*λ2*P_inv[2][2]]]
        
        A_inv = [[P[1][1]*(1//λ1)*P_inv[1][1] + P[1][2]*(1//λ2)*P_inv[2][1], P[1][1]*(1//λ1)*P_inv[1][2] + P[1][2]*(1//λ2)*P_inv[2][2]],
                 [P[2][1]*(1//λ1)*P_inv[1][1] + P[2][2]*(1//λ2)*P_inv[2][1], P[2][1]*(1//λ1)*P_inv[1][2] + P[2][2]*(1//λ2)*P_inv[2][2]]]
        
        problem(
            question="Let \\(A = $(fmt_matrix(A))\\) have eigenvalues \\(\\lambda_1 = $(λ1)\\) and \\(\\lambda_2 = $(λ2)\\). Find \\(A^{-1}\\).",
            answer=fmt_matrix(A_inv),
            difficulty=(2600, 2900),
            answer_type="matrix",
            solution=steps(
                "Since \\(A\\) has eigenvalues \\(\\lambda_1 = $(λ1)\\) and \\(\\lambda_2 = $(λ2)\\), the eigenvalues of \\(A^{-1}\\) are \\(\\frac{1}{$(λ1)}\\) and \\(\\frac{1}{$(λ2)}\\)",
                "Compute determinant: \\(\\det(A) = $(A[1][1] * A[2][2] - A[1][2] * A[2][1])\\)",
                "Apply inverse formula: \\(A^{-1} = \\frac{1}{\\det(A)} \\begin{pmatrix} $(A[2][2]) & $(-A[1][2]) \\\\ $(-A[2][1]) & $(A[1][1]) \\end{pmatrix}\\)",
                sol("Answer", fmt_matrix(A_inv))
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad: Matrix commutator and inverse
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        # Construct matrix with det != 0
        A = [[a, b], [0, c]]
        
        det_A = a * c
        A_inv = [[1//a, -b//(a*c)], [0, 1//c]]
        
        # Commutator [A, A^(-1)] = AA^(-1) - A^(-1)A = 0 (always)
        trace_comm = 0
        
        problem(
            question="Let \\(A = $(fmt_matrix(A))\\) and let \\([A, A^{-1}] = AA^{-1} - A^{-1}A\\) denote the commutator. Find \\(\\text{tr}([A, A^{-1}])\\).",
            answer=trace_comm,
            difficulty=(3200, 3500),
            solution=steps(
                "Note that \\(AA^{-1} = A^{-1}A = I\\) for any invertible matrix",
                "Therefore \\([A, A^{-1}] = AA^{-1} - A^{-1}A = I - I = 0\\)",
                "The trace of the zero matrix is 0",
                sol("Answer", trace_comm)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Competition: Inverse of matrix power
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        
        det_M = a*d - b*c
        while abs(det_M) < 2
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            c = nonzero(-3, 3)
            d = nonzero(-3, 3)
            det_M = a*d - b*c
        end
        
        M = [[a, b], [c, d]]
        
        # (M^3)^(-1) = (M^(-1))^3
        M_inv = [[d//det_M, -b//det_M], [-c//det_M, a//det_M]]
        
        # Compute (M^(-1))^2
        M_inv_2 = [
            [M_inv[1][1]*M_inv[1][1] + M_inv[1][2]*M_inv[2][1], M_inv[1][1]*M_inv[1][2] + M_inv[1][2]*M_inv[2][2]],
            [M_inv[2][1]*M_inv[1][1] + M_inv[2][2]*M_inv[2][1], M_inv[2][1]*M_inv[1][2] + M_inv[2][2]*M_inv[2][2]]
        ]
        
        # Compute (M^(-1))^3
        M_inv_3 = [
            [M_inv_2[1][1]*M_inv[1][1] + M_inv_2[1][2]*M_inv[2][1], M_inv_2[1][1]*M_inv[1][2] + M_inv_2[1][2]*M_inv[2][2]],
            [M_inv_2[2][1]*M_inv[1][1] + M_inv_2[2][2]*M_inv[2][1], M_inv_2[2][1]*M_inv[1][2] + M_inv_2[2][2]*M_inv[2][2]]
        ]
        
        problem(
            question="Given \\(M = $(fmt_matrix(M))\\), find \\((M^3)^{-1}\\).",
            answer=fmt_matrix(M_inv_3),
            difficulty=(2500, 2800),
            answer_type="matrix",
            solution=steps(
                "Use the property \\((M^3)^{-1} = (M^{-1})^3\\)",
                "Compute \\(M^{-1} = \\frac{1}{$(det_M)} $(fmt_matrix([[d, -b], [-c, a]])) = $(fmt_matrix(M_inv))\\)",
                "Compute \\((M^{-1})^2\\) and then \\((M^{-1})^3\\) by matrix multiplication",
                sol("Answer", fmt_matrix(M_inv_3))
            ),
            time=300
        )
        
    else
        # Olympiad: Rank-1 perturbation inverse (Sherman-Morrison)
        a = nonzero(-5, 5)
        u = [[randint(-3, 3)], [randint(-3, 3)]]
        v = [[randint(-3, 3)], [randint(-3, 3)]]
        
        while u[1][1] == 0 && u[2][1] == 0
            u = [[randint(-3, 3)], [randint(-3, 3)]]
        end
        while v[1][1] == 0 && v[2][1] == 0
            v = [[randint(-3, 3)], [randint(-3, 3)]]
        end
        
        # A = aI + uv^T
        A = [[a + u[1][1]*v[1][1], u[1][1]*v[2][1]], [u[2][1]*v[1][1], a + u[2][1]*v[2][1]]]
        
        det_A = A[1][1]*A[2][2] - A[1][2]*A[2][1]
        
        while abs(det_A) < 1
            a = nonzero(-5, 5)
            u = [[randint(-3, 3)], [randint(-3, 3)]]
            v = [[randint(-3, 3)], [randint(-3, 3)]]
            A = [[a + u[1][1]*v[1][1], u[1][1]*v[2][1]], [u[2][1]*v[1][1], a + u[2][1]*v[2][1]]]
            det_A = A[1][1]*A[2][2] - A[1][2]*A[2][1]
        end
        
        A_inv = [[A[2][2]//det_A, -A[1][2]//det_A], [-A[2][1]//det_A, A[1][1]//det_A]]
        
        trace_A_inv = A_inv[1][1] + A_inv[2][2]
        
        problem(
            question="Let \\(u = $(fmt_matrix(u))\\), \\(v = $(fmt_matrix(v))\\), and \\(A = $(a)I + uv^T = $(fmt_matrix(A))\\). Find \\(\\text{tr}(A^{-1})\\).",
            answer=trace_A_inv,
            difficulty=(3000, 3400),
            solution=steps(
                "This is a rank-1 perturbation of a diagonal matrix",
                "Compute determinant: \\(\\det(A) = $(det_A)\\)",
                "Find \\(A^{-1} = $(fmt_matrix(A_inv))\\)",
                sol("Trace", trace_A_inv)
            ),
            time=270
        )
    end
end