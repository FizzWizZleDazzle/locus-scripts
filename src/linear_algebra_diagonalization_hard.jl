# linear_algebra - diagonalization (hard)
# Generated: 2026-03-08T21:14:23.834183

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/diagonalization")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Eigenvalue/eigenvector computation for 2x2 matrix (1800-2000)
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        while λ2 == λ1
            λ2 = randint(-8, 8)
        end
        
        # Create eigenvectors
        v1 = [nonzero(-3, 3), nonzero(-3, 3)]
        v2 = [nonzero(-3, 3), nonzero(-3, 3)]
        while v1[1] * v2[2] == v1[2] * v2[1]  # ensure linearly independent
            v2 = [nonzero(-3, 3), nonzero(-3, 3)]
        end
        
        # Construct matrix A = PDP^(-1)
        P = [v1[1] v2[1]; v1[2] v2[2]]
        D = [λ1 0; 0 λ2]
        det_P = v1[1] * v2[2] - v1[2] * v2[1]
        P_inv = [v2[2] -v2[1]; -v1[2] v1[1]] .// det_P
        A = P * D * P_inv
        
        a11, a12 = Rational.(A[1, :])
        a21, a22 = Rational.(A[2, :])
        
        problem(
            question="Find all eigenvalues of the matrix \\(A = $(fmt_matrix([a11 a12; a21 a22]))\\). Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(1800, 2000),
            answer_type="set",
            solution=steps(
                "Compute the characteristic polynomial \\(\\det(A - \\lambda I) = 0\\)",
                "\\(\\det\\begin{pmatrix}$(a11) - \\lambda & $(a12) \\\\ $(a21) & $(a22) - \\lambda\\end{pmatrix} = ($(a11) - \\lambda)($(a22) - \\lambda) - $(a12 * a21)\\)",
                "Expand and solve: \\(\\lambda^2 - $(a11 + a22)\\lambda + $(a11*a22 - a12*a21) = 0\\)",
                "Eigenvalues: \\(\\{$(λ1), $(λ2)\\}\\)"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Diagonalizability check (2000-2200)
        λ = randint(-6, 6)
        
        if choice([true, false])
            # Diagonalizable case: distinct eigenvalues or full set of eigenvectors
            λ2 = randint(-6, 6)
            while λ2 == λ
                λ2 = randint(-6, 6)
            end
            
            v1 = [nonzero(-3, 3), nonzero(-3, 3)]
            v2 = [nonzero(-3, 3), nonzero(-3, 3)]
            while v1[1] * v2[2] == v1[2] * v2[1]
                v2 = [nonzero(-3, 3), nonzero(-3, 3)]
            end
            
            P = [v1[1] v2[1]; v1[2] v2[2]]
            D = [λ 0; 0 λ2]
            det_P = v1[1] * v2[2] - v1[2] * v2[1]
            P_inv = [v2[2] -v2[1]; -v1[2] v1[1]] .// det_P
            A = P * D * P_inv
            
            is_diag = "Yes"
            explanation = "The matrix has two distinct eigenvalues (\\($(λ)\\) and \\($(λ2)\\)), so it has two linearly independent eigenvectors and is diagonalizable."
        else
            # Non-diagonalizable case: repeated eigenvalue with geometric multiplicity < algebraic multiplicity
            a = nonzero(-4, 4)
            A = [λ a; 0 λ]
            
            is_diag = "No"
            explanation = "The matrix has eigenvalue \\($(λ)\\) with algebraic multiplicity 2 but geometric multiplicity 1 (only one linearly independent eigenvector), so it is not diagonalizable."
        end
        
        a11, a12 = Rational.(A[1, :])
        a21, a22 = Rational.(A[2, :])
        
        problem(
            question="Is the matrix \\(A = $(fmt_matrix([a11 a12; a21 a22]))\\) diagonalizable? Answer Yes or No.",
            answer=is_diag,
            difficulty=(2000, 2200),
            answer_type="string",
            solution=steps(
                "Find the characteristic polynomial and eigenvalues",
                "Check the geometric multiplicity of each eigenvalue",
                explanation,
                "Answer: \\(\\text{$(is_diag)}\\)"
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Matrix power using diagonalization (2100-2300)
        λ1 = choice([-2, -1, 2, 3])
        λ2 = choice([-2, -1, 2, 3])
        while λ2 == λ1
            λ2 = choice([-2, -1, 2, 3])
        end
        
        n = randint(5, 12)
        
        v1 = [1, nonzero(-2, 2)]
        v2 = [nonzero(-2, 2), 1]
        
        P = [v1[1] v2[1]; v1[2] v2[2]]
        D = [λ1 0; 0 λ2]
        det_P = v1[1] * v2[2] - v1[2] * v2[1]
        P_inv = [v2[2] -v2[1]; -v1[2] v1[1]] .// det_P
        A = P * D * P_inv
        
        # Compute A^n
        D_n = [λ1^n 0; 0 λ2^n]
        A_n = P * D_n * P_inv
        
        a11, a12 = Rational.(A[1, :])
        a21, a22 = Rational.(A[2, :])
        
        ans11, ans12 = Rational.(A_n[1, :])
        ans21, ans22 = Rational.(A_n[2, :])
        
        problem(
            question="Let \\(A = $(fmt_matrix([a11 a12; a21 a22]))\\). Compute \\(A^{$(n)}\\) and enter the element in row 1, column 1.",
            answer=ans11,
            difficulty=(2100, 2300),
            solution=steps(
                "Diagonalize \\(A = PDP^{-1}\\) where \\(D = $(fmt_matrix([λ1 0; 0 λ2]))\\)",
                "Then \\(A^{$(n)} = PD^{$(n)}P^{-1}\\)",
                "Compute \\(D^{$(n)} = $(fmt_matrix([λ1^n 0; 0 λ2^n]))\\)",
                "Multiply to get \\(A^{$(n)}_{11} = $(ans11)\\)"
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Finding diagonal matrix D (1900-2100)
        λ1 = randint(-7, 7)
        λ2 = randint(-7, 7)
        while λ2 == λ1
            λ2 = randint(-7, 7)
        end
        
        v1 = [1, nonzero(-3, 3)]
        v2 = [nonzero(-3, 3), 1]
        
        P = [v1[1] v2[1]; v1[2] v2[2]]
        D = [λ1 0; 0 λ2]
        det_P = v1[1] * v2[2] - v1[2] * v2[1]
        P_inv = [v2[2] -v2[1]; -v1[2] v1[1]] .// det_P
        A = P * D * P_inv
        
        a11, a12 = Rational.(A[1, :])
        a21, a22 = Rational.(A[2, :])
        
        p11, p12 = Rational.(P[1, :])
        p21, p22 = Rational.(P[2, :])
        
        problem(
            question="Given \\(A = $(fmt_matrix([a11 a12; a21 a22]))\\) and \\(P = $(fmt_matrix([p11 p12; p21 p22]))\\), find the diagonal matrix \\(D\\) such that \\(A = PDP^{-1}\\). Enter the element \\(D_{11}\\) (top-left entry).",
            answer=λ1,
            difficulty=(1900, 2100),
            solution=steps(
                "We have \\(D = P^{-1}AP\\)",
                "The diagonal entries of \\(D\\) are the eigenvalues of \\(A\\)",
                "Since \\(P\\) has eigenvectors as columns, \\(D_{11}\\) corresponds to the eigenvalue for the first column of \\(P\\)",
                "Answer: \\(D_{11} = $(λ1)\\)"
            ),
            time=240
        )
        
    else  # problem_type == 5
        # Trace and determinant via eigenvalues (1800-2000)
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        λ3 = randint(-8, 8)
        
        trace_val = λ1 + λ2 + λ3
        det_val = λ1 * λ2 * λ3
        
        quantity = choice(["trace", "determinant"])
        
        if quantity == "trace"
            ans = trace_val
            answer_str = "The trace equals the sum of eigenvalues: \\($(λ1) + $(λ2) + $(λ3) = $(trace_val)\\)"
        else
            ans = det_val
            answer_str = "The determinant equals the product of eigenvalues: \\(($(λ1))($(λ2))($(λ3)) = $(det_val)\\)"
        end
        
        problem(
            question="A \\(3 \\times 3\\) matrix \\(A\\) has eigenvalues \\($(λ1)\\), \\($(λ2)\\), and \\($(λ3)\\). Find the $(quantity) of \\(A\\).",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Recall that for any matrix, the trace is the sum of eigenvalues and the determinant is the product of eigenvalues",
                answer_str,
                "Answer: \\($(ans)\\)"
            ),
            time=120
        )
    end
end