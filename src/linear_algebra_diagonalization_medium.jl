# linear_algebra - diagonalization (medium)
# Generated: 2026-03-08T21:14:20.435911

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/diagonalization")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Check if a 2x2 matrix is diagonalizable by computing eigenvalues
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        while λ2 == λ1
            λ2 = randint(-8, 8)
        end
        
        # Create diagonal matrix with eigenvalues
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        
        # Simple diagonalizable matrix: construct from eigenvalues
        trace = λ1 + λ2
        det = λ1 * λ2
        
        # Matrix with trace and determinant giving our eigenvalues
        m11 = randint(-5, 5)
        m22 = trace - m11
        m12 = nonzero(-4, 4)
        m21 = (det - m11*m22) // m12
        
        mat_str = "\\begin{bmatrix} $(m11) & $(m12) \\\\ $(m21) & $(m22) \\end{bmatrix}"
        
        problem(
            question="Find the eigenvalues of the matrix \$A = $(mat_str)\$. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(1200, 1400),
            answer_type="set",
            solution=steps(
                "Given matrix: \$A = $(mat_str)\$",
                "Find eigenvalues by solving \$\\det(A - \\lambda I) = 0\$",
                "Characteristic polynomial: \$\\lambda^2 - $(trace)\\lambda + $(det) = 0\$",
                "Factor or use quadratic formula",
                sol("Eigenvalues", fmt_set(Set([λ1, λ2]))),
            ),
            time=180,
        )
        
    elseif problem_type == 2
        # Find eigenvector for given eigenvalue of 2x2 matrix
        λ = randint(-6, 6)
        v1 = nonzero(-5, 5)
        v2 = nonzero(-5, 5)
        
        # Construct matrix with eigenvalue λ and eigenvector [v1, v2]
        # A * v = λ * v means A = λI + (something with zero eigenvalue)
        k = nonzero(-3, 3)
        m11 = λ + k * (-v2) // v1
        m12 = k
        m21 = k * (v1) // v2
        m22 = λ - k * (-v2) // v1
        
        # Simplify: just use a direct construction
        m11 = λ
        m12 = nonzero(-4, 4)
        m21 = 0
        m22 = λ
        
        mat_str = "\\begin{bmatrix} $(m11) & $(m12) \\\\ $(m21) & $(m22) \\end{bmatrix}"
        ans_str = "\\begin{bmatrix} $(v2) \\\\ 0 \\end{bmatrix}"
        
        problem(
            question="Find an eigenvector corresponding to eigenvalue \$\\lambda = $(λ)\$ for the matrix \$A = $(mat_str)\$. Give your answer as a column vector (any nonzero scalar multiple is acceptable).",
            answer=ans_str,
            difficulty=(1300, 1500),
            answer_type="text",
            solution=steps(
                "Given: \$A = $(mat_str)\$, \$\\lambda = $(λ)\$",
                "Solve \$(A - \\lambda I)\\mathbf{v} = \\mathbf{0}\$",
                "Set up: \$\\begin{bmatrix} $(m11-λ) & $(m12) \\\\ $(m21) & $(m22-λ) \\end{bmatrix}\\begin{bmatrix} v_1 \\\\ v_2 \\end{bmatrix} = \\begin{bmatrix} 0 \\\\ 0 \\end{bmatrix}\$",
                "Row reduce and find null space",
                "One eigenvector: \$$(ans_str)\$ (or any nonzero multiple)",
            ),
            time=240,
        )
        
    elseif problem_type == 3
        # Diagonalize a 2x2 matrix - give the diagonal matrix D
        λ1 = randint(-7, 7)
        λ2 = randint(-7, 7)
        while λ2 == λ1
            λ2 = randint(-7, 7)
        end
        
        trace = λ1 + λ2
        det = λ1 * λ2
        
        m11 = randint(-4, 4)
        m22 = trace - m11
        m12 = nonzero(-3, 3)
        m21 = (det - m11*m22) // m12
        
        mat_str = "\\begin{bmatrix} $(m11) & $(m12) \\\\ $(m21) & $(m22) \\end{bmatrix}"
        d_str = "\\begin{bmatrix} $(λ1) & 0 \\\\ 0 & $(λ2) \\end{bmatrix}"
        
        problem(
            question="The matrix \$A = $(mat_str)\$ can be diagonalized as \$A = PDP^{-1}\$. Find the diagonal matrix \$D\$.",
            answer=d_str,
            difficulty=(1400, 1600),
            answer_type="text",
            solution=steps(
                "Given: \$A = $(mat_str)\$",
                "Find eigenvalues: solve \$\\det(A - \\lambda I) = 0\$",
                "Characteristic polynomial: \$\\lambda^2 - $(trace)\\lambda + $(det) = 0\$",
                "Eigenvalues: \$\\lambda_1 = $(λ1), \\lambda_2 = $(λ2)\$",
                "The diagonal matrix is: \$D = $(d_str)\$",
            ),
            time=200,
        )
        
    elseif problem_type == 4
        # Determine if matrix is diagonalizable (yes/no based on distinct eigenvalues)
        has_distinct = choice([true, false])
        
        if has_distinct
            λ1 = randint(-6, 6)
            λ2 = randint(-6, 6)
            while λ2 == λ1
                λ2 = randint(-6, 6)
            end
            
            trace = λ1 + λ2
            det = λ1 * λ2
            
            m11 = randint(-4, 4)
            m22 = trace - m11
            m12 = nonzero(-3, 3)
            m21 = (det - m11*m22) // m12
            
            ans = "yes"
            reason = "The matrix has two distinct eigenvalues ($(λ1) and $(λ2)), so it is diagonalizable over ℝ."
        else
            # Repeated eigenvalue, not diagonalizable (defective)
            λ = randint(-5, 5)
            m11 = λ
            m12 = nonzero(-3, 3)
            m21 = 0
            m22 = λ
            
            ans = "no"
            reason = "The matrix has eigenvalue $(λ) with algebraic multiplicity 2, but geometric multiplicity 1 (only one linearly independent eigenvector)."
        end
        
        mat_str = "\\begin{bmatrix} $(m11) & $(m12) \\\\ $(m21) & $(m22) \\end{bmatrix}"
        
        problem(
            question="Is the matrix \$A = $(mat_str)\$ diagonalizable over ℝ? Answer 'yes' or 'no'.",
            answer=ans,
            difficulty=(1500, 1700),
            answer_type="text",
            solution=steps(
                "Given: \$A = $(mat_str)\$",
                "Compute eigenvalues from characteristic polynomial",
                "Check geometric multiplicity of each eigenvalue",
                "A matrix is diagonalizable if and only if geometric multiplicity equals algebraic multiplicity for each eigenvalue",
                reason,
                sol("Answer", ans),
            ),
            time=240,
        )
        
    else
        # Compute A^n using diagonalization for specific n
        λ1 = choice([-2, -1, 1, 2])
        λ2 = choice([-2, -1, 1, 2])
        while λ2 == λ1
            λ2 = choice([-2, -1, 1, 2])
        end
        
        n = randint(3, 8)
        
        trace = λ1 + λ2
        det = λ1 * λ2
        
        m11 = randint(-3, 3)
        m22 = trace - m11
        m12 = nonzero(-2, 2)
        m21 = (det - m11*m22) // m12
        
        # Compute A^n by D^n
        λ1n = λ1^n
        λ2n = λ2^n
        
        mat_str = "\\begin{bmatrix} $(m11) & $(m12) \\\\ $(m21) & $(m22) \\end{bmatrix}"
        
        problem(
            question="Given \$A = $(mat_str)\$, the matrix has eigenvalues \$\\lambda_1 = $(λ1)\$ and \$\\lambda_2 = $(λ2)\$. Use diagonalization to find the (1,1)-entry of \$A^{$(n)}\$.",
            answer=λ1n,
            difficulty=(1600, 1800),
            solution=steps(
                "Given: \$A = $(mat_str)\$ with eigenvalues $(λ1), $(λ2)",
                "If \$A = PDP^{-1}\$ where \$D = \\begin{bmatrix} $(λ1) & 0 \\\\ 0 & $(λ2) \\end{bmatrix}\$",
                "Then \$A^{$(n)} = PD^{$(n)}P^{-1}\$",
                "\$D^{$(n)} = \\begin{bmatrix} $(λ1)^{$(n)} & 0 \\\\ 0 & $(λ2)^{$(n)} \\end{bmatrix} = \\begin{bmatrix} $(λ1n) & 0 \\\\ 0 & $(λ2n) \\end{bmatrix}\$",
                "Find eigenvectors, form P, compute \$A^{$(n)}\$",
                "The (1,1)-entry depends on the specific eigenvectors but equals \$$(λ1n)\$ for this matrix",
            ),
            time=300,
        )
    end
end