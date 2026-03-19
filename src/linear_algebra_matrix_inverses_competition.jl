# linear_algebra - matrix_inverses (competition)
# Generated: 2026-03-08T21:09:19.423972

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_inverses")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Hard inverse problem: Find matrix A such that A^n = given matrix, requires eigenvalue decomposition reasoning
        n = choice([2, 3, 4])
        λ1 = choice([2, 3, 4, -2, -3])
        λ2 = choice([2, 3, 4, -2, -3])
        while λ2 == λ1
            λ2 = choice([2, 3, 4, -2, -3])
        end
        
        # Target matrix is diagonal with eigenvalues λ1^n, λ2^n
        target_11 = λ1^n
        target_22 = λ2^n
        
        # Add off-diagonal randomness via similarity transform
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        det_P = a*d - b*c
        while det_P == 0
            d = nonzero(-3, 3)
            det_P = a*d - b*c
        end
        
        # P * D * P^(-1) where D = diag(λ1^n, λ2^n)
        P_inv_11 = d // det_P
        P_inv_12 = -b // det_P
        P_inv_21 = -c // det_P
        P_inv_22 = a // det_P
        
        M_11 = a * target_11 * P_inv_11 + b * target_22 * P_inv_21
        M_12 = a * target_11 * P_inv_12 + b * target_22 * P_inv_22
        M_21 = c * target_11 * P_inv_11 + d * target_22 * P_inv_21
        M_22 = c * target_11 * P_inv_12 + d * target_22 * P_inv_22
        
        A_11 = a * λ1 * P_inv_11 + b * λ2 * P_inv_21
        A_12 = a * λ1 * P_inv_12 + b * λ2 * P_inv_22
        A_21 = c * λ1 * P_inv_11 + d * λ2 * P_inv_21
        A_22 = c * λ1 * P_inv_12 + d * λ2 * P_inv_22
        
        problem(
            question="Find a \\(2 \\times 2\\) matrix \\(A\\) such that \\(A^{$n} = $(fmt_matrix([[M_11, M_12], [M_21, M_22]]))\\). Give any valid solution with rational entries.",
            answer=fmt_matrix([[A_11, A_12], [A_21, A_22]]),
            difficulty=(3600, 4200),
            solution=steps(
                "Given: \\(A^{$n} = M\\) where \\(M = $(fmt_matrix([[M_11, M_12], [M_21, M_22]]))\\)",
                "Find eigenvalues of \\(M\\): \\(\\lambda_1^{$n} = $target_11\\), \\(\\lambda_2^{$n} = $target_22\\)",
                "Take \\($n\\)-th roots: \\(\\lambda_1 = $λ1\\), \\(\\lambda_2 = $λ2\\)",
                "Diagonalize \\(M = PDP^{-1}\\) and construct \\(A = PD^{1/$n}P^{-1}\\)",
                sol("Answer", fmt_matrix([[A_11, A_12], [A_21, A_22]])),
            ),
            time=420,
        )
        
    elseif problem_type == 2
        # Inverse of block matrix with specific structure
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        det1 = a*d - b*c
        while det1 == 0
            d = nonzero(-5, 5)
            det1 = a*d - b*c
        end
        
        e = nonzero(-4, 4)
        f = nonzero(-4, 4)
        
        # 3x3 block matrix [[a,b,e], [c,d,f], [0,0,1]]
        # Inverse has structure [[d/det1, -b/det1, ...], [-c/det1, a/det1, ...], [0, 0, 1]]
        
        inv_11 = d // det1
        inv_12 = -b // det1
        inv_13 = (b*f - d*e) // det1
        inv_21 = -c // det1
        inv_22 = a // det1
        inv_23 = (c*e - a*f) // det1
        
        problem(
            question="Find the inverse of \\(A = $(fmt_matrix([[a, b, e], [c, d, f], [0, 0, 1]]))\\)",
            answer=fmt_matrix([[inv_11, inv_12, inv_13], [inv_21, inv_22, inv_23], [0, 0, 1]]),
            difficulty=(3400, 3900),
            solution=steps(
                sol("Given", fmt_matrix([[a, b, e], [c, d, f], [0, 0, 1]])),
                "Recognize block structure: lower-right \\(1\\) allows block inversion",
                "Top-left \\(2 \\times 2\\) block has determinant \\($det1\\)",
                "Apply block matrix inverse formula",
                sol("Inverse", fmt_matrix([[inv_11, inv_12, inv_13], [inv_21, inv_22, inv_23], [0, 0, 1]])),
            ),
            time=360,
        )
        
    elseif problem_type == 3
        # Matrix equation AXB = C, solve for X given invertible A, B, C
        # Choose small matrices with clean inverses
        
        # A is 2x2 with clean inverse
        a1 = choice([1, 2, 3])
        a2 = 0
        a3 = 0
        a4 = choice([1, 2, 3])
        
        # B is 2x2 diagonal
        b1 = choice([2, 3, 4, -2])
        b4 = choice([2, 3, 4, -2])
        
        # C is 2x2
        c1 = randint(-8, 8)
        c2 = randint(-8, 8)
        c3 = randint(-8, 8)
        c4 = randint(-8, 8)
        
        # X = A^(-1) C B^(-1)
        x_11 = c1 // (a1 * b1)
        x_12 = c2 // (a1 * b4)
        x_21 = c3 // (a4 * b1)
        x_22 = c4 // (a4 * b4)
        
        problem(
            question="Solve for \\(X\\) in the matrix equation \\(AXB = C\\), where \\(A = $(fmt_matrix([[a1, a2], [a3, a4]]))\\), \\(B = $(fmt_matrix([[b1, 0], [0, b4]]))\\), and \\(C = $(fmt_matrix([[c1, c2], [c3, c4]]))\\).",
            answer=fmt_matrix([[x_11, x_12], [x_21, x_22]]),
            difficulty=(3500, 4100),
            solution=steps(
                "Given: \\(AXB = C\\)",
                "Multiply both sides: \\(A^{-1}(AXB)B^{-1} = A^{-1}CB^{-1}\\)",
                "Simplify: \\(X = A^{-1}CB^{-1}\\)",
                "Compute \\(A^{-1} = $(fmt_matrix([[1//a1, 0], [0, 1//a4]]))\\), \\(B^{-1} = $(fmt_matrix([[1//b1, 0], [0, 1//b4]]))\\)",
                sol("Answer", fmt_matrix([[x_11, x_12], [x_21, x_22]])),
            ),
            time=390,
        )
        
    elseif problem_type == 4
        # Find all 2x2 matrices A where A^2 = A (idempotent, requires eigenvalue analysis)
        # This is research-adjacent: classify all such matrices
        
        k = randint(-5, 5)
        
        problem(
            question="Let \\(A\\) be a \\(2 \\times 2\\) real matrix satisfying \\(A^2 = A\\). Prove that \\(\\text{tr}(A)\\) (the trace of \\(A\\)) must be an integer in \\(\\{0, 1, 2\\}\\), and for each possible trace value, characterize the set of all such matrices. What is the dimension of the space of \\(2 \\times 2\\) idempotent matrices with trace equal to 1?",
            answer="2",
            difficulty=(4200, 4800),
            solution=steps(
                "Given: \\(A^2 = A\\), so eigenvalues \\(\\lambda\\) satisfy \\(\\lambda^2 = \\lambda\\), hence \\(\\lambda \\in \\{0, 1\\}\\)",
                "Trace equals sum of eigenvalues, so \\(\\text{tr}(A) \\in \\{0, 1, 2\\}\\)",
                "For \\(\\text{tr}(A) = 1\\): one eigenvalue is 0, one is 1 (algebraic multiplicity 1 each)",
                "Such matrices are similar to \\(\\begin{pmatrix}1&0\\\\0&0\\end{pmatrix}\\) and form a 2-dimensional space",
                "Parametrization: \\(A = \\begin{pmatrix}a&b\\\\c&1-a\\end{pmatrix}\\) with \\(b = ac/(1-a)\\) (when \\(a \\neq 1\\)) plus rank-1 constraint",
                sol("Dimension", "2"),
            ),
            time=480,
        )
        
    else
        # Inverse via adjugate for 3x3 with parameter, find parameter making matrix non-invertible
        
        p_val = choice([2, 3, 4, 5, 6])
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        # Matrix with parameter p: [[1, 0, a], [0, p, b], [0, 0, c]]
        # Determinant = p*c, non-invertible when p=0
        
        # But make it harder: [[1, a, b], [0, p, c], [0, 0, p-p_val]]
        # det = p(p-p_val), singular when p=0 or p=p_val
        
        problem(
            question="For what values of the parameter \\(p\\) is the matrix \\(M(p) = $(fmt_matrix([[1, a, b], [0, "p", c], [0, 0, "p-$p_val"]]))\\) NOT invertible? Give your answer as a set.",
            answer=fmt_set(Set([0, p_val])),
            answer_type="set",
            difficulty=(3300, 3800),
            solution=steps(
                sol("Given matrix", fmt_matrix([[1, a, b], [0, "p", c], [0, 0, "p-$p_val"]])),
                "Matrix is upper triangular, so determinant is product of diagonal entries",
                "\\(\\det(M) = 1 \\cdot p \\cdot (p - $p_val) = p(p - $p_val)\\)",
                "Matrix is singular when \\(\\det(M) = 0\\), i.e., when \\(p = 0\\) or \\(p = $p_val\\)",
                sol("Answer", fmt_set(Set([0, p_val]))),
            ),
            time=300,
        )
    end
end