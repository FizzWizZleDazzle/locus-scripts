# linear_algebra - eigenvalues (medium)
# Generated: 2026-03-08T21:13:17.690395

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/eigenvalues")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # 2x2 matrix eigenvalue computation (1200-1400)
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        
        # Generate a diagonal or triangular matrix for clean computation
        if choice([true, false])
            # Diagonal matrix
            A = [[λ1, 0], [0, λ2]]
            matrix_str = "\\begin{bmatrix} $(λ1) & 0 \\\\ 0 & $(λ2) \\end{bmatrix}"
        else
            # Upper triangular
            b = randint(-5, 5)
            A = [[λ1, b], [0, λ2]]
            matrix_str = "\\begin{bmatrix} $(λ1) & $(b) \\\\ 0 & $(λ2) \\end{bmatrix}"
        end
        
        eigenvalues = Set([λ1, λ2])
        
        problem(
            question="Find all eigenvalues of the matrix \\\$A = $(matrix_str)\\\$",
            answer=fmt_set(eigenvalues),
            difficulty=(1200, 1400),
            answer_type="set",
            solution=steps(
                "Given matrix A = $(matrix_str)",
                "For triangular/diagonal matrices, eigenvalues are the diagonal entries",
                sol("Characteristic equation gives eigenvalues", eigenvalues),
                "Answer: \\\$\\{$(λ1), $(λ2)\\}\\\$"
            ),
            time=120
        )
        
    elseif problem_type == 2
        # 2x2 matrix with characteristic polynomial (1300-1500)
        λ1 = randint(-6, 6)
        λ2 = randint(-6, 6)
        
        # Construct matrix with known eigenvalues
        # Use A = [[a, b], [c, d]] where trace = a+d = λ1+λ2, det = ad-bc = λ1*λ2
        trace = λ1 + λ2
        det = λ1 * λ2
        
        a = randint(-4, 4)
        d = trace - a
        # Choose b, c such that ad - bc = det
        b = choice([-3, -2, -1, 1, 2, 3])
        if b != 0
            c = (a * d - det) // b
        else
            c = randint(-3, 3)
        end
        
        matrix_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
        
        eigenvalues = Set([λ1, λ2])
        
        problem(
            question="Find the eigenvalues of \\\$A = $(matrix_str)\\\$",
            answer=fmt_set(eigenvalues),
            difficulty=(1300, 1500),
            answer_type="set",
            solution=steps(
                "Compute characteristic polynomial: \\\$\\det(A - \\lambda I) = 0\\\$",
                "For 2×2 matrix: \\\$\\lambda^2 - \\text{tr}(A)\\lambda + \\det(A) = 0\\\$",
                "Trace = $(trace), Determinant = $(det)",
                "\\\$\\lambda^2 - $(trace)\\lambda + $(det) = 0\\\$",
                "Solving gives eigenvalues: \\\$\\{$(λ1), $(λ2)\\}\\\$"
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Eigenvector verification (1400-1600)
        λ = randint(-7, 7)
        v1 = nonzero(-5, 5)
        v2 = nonzero(-5, 5)
        
        # Construct matrix such that A*v = λ*v
        # For simplicity, use diagonal form in eigenvector basis
        a = randint(-4, 4)
        A = [[a, v1], [0, a]]  # Will have eigenvalue a
        
        # Actually, construct more carefully
        # Let's use A*v = λ*v directly
        # If v = [v1, v2], then Av = [a*v1 + b*v2, c*v1 + d*v2] = [λ*v1, λ*v2]
        # So: a*v1 + b*v2 = λ*v1, c*v1 + d*v2 = λ*v2
        
        b = randint(-3, 3)
        a = v1 != 0 ? λ + (b * v2) ÷ v1 : λ
        c = randint(-3, 3)
        d = v2 != 0 ? λ + (c * v1) ÷ v2 : λ
        
        matrix_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
        vector_str = "\\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}"
        
        problem(
            question="Verify that \\\$\\mathbf{v} = $(vector_str)\\\$ is an eigenvector of \\\$A = $(matrix_str)\\\$ and find the corresponding eigenvalue.",
            answer=λ,
            difficulty=(1400, 1600),
            solution=steps(
                "Compute \\\$A\\mathbf{v}\\\$:",
                "\\\$A\\mathbf{v} = \\begin{bmatrix} $(a*v1 + b*v2) \\\\ $(c*v1 + d*v2) \\end{bmatrix}\\\$",
                "Check if \\\$A\\mathbf{v} = \\lambda\\mathbf{v}\\\$:",
                "\\\$\\begin{bmatrix} $(a*v1 + b*v2) \\\\ $(c*v1 + d*v2) \\end{bmatrix} = \\lambda \\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}\\\$",
                sol("Eigenvalue", λ)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Trace and determinant relationship (1500-1700)
        λ1 = randint(-6, 6)
        λ2 = randint(-6, 6)
        
        trace = λ1 + λ2
        det = λ1 * λ2
        
        given = choice(["trace_det", "sum_product"])
        
        if given == "trace_det"
            problem(
                question="A 2×2 matrix has trace $(trace) and determinant $(det). Find the sum of its eigenvalues.",
                answer=trace,
                difficulty=(1500, 1700),
                solution=steps(
                    "For any matrix, trace = sum of eigenvalues",
                    "Given: tr(A) = $(trace)",
                    "Also, det(A) = product of eigenvalues = $(det)",
                    sol("Sum of eigenvalues", trace)
                ),
                time=90
            )
        else
            problem(
                question="The eigenvalues of a 2×2 matrix are $(λ1) and $(λ2). Find the determinant of the matrix.",
                answer=det,
                difficulty=(1400, 1600),
                solution=steps(
                    "For any matrix, det(A) = product of eigenvalues",
                    "Eigenvalues: λ₁ = $(λ1), λ₂ = $(λ2)",
                    "det(A) = λ₁ · λ₂ = $(λ1) · $(λ2)",
                    sol("Determinant", det)
                ),
                time=90
            )
        end
        
    else
        # 3x3 diagonal or triangular matrix (1300-1500)
        λ1 = randint(-6, 6)
        λ2 = randint(-6, 6)
        λ3 = randint(-6, 6)
        
        if choice([true, false])
            # Diagonal
            matrix_str = "\\begin{bmatrix} $(λ1) & 0 & 0 \\\\ 0 & $(λ2) & 0 \\\\ 0 & 0 & $(λ3) \\end{bmatrix}"
        else
            # Upper triangular
            a = randint(-3, 3)
            b = randint(-3, 3)
            c = randint(-3, 3)
            matrix_str = "\\begin{bmatrix} $(λ1) & $(a) & $(b) \\\\ 0 & $(λ2) & $(c) \\\\ 0 & 0 & $(λ3) \\end{bmatrix}"
        end
        
        eigenvalues = Set([λ1, λ2, λ3])
        
        problem(
            question="Find all eigenvalues of \\\$A = $(matrix_str)\\\$",
            answer=fmt_set(eigenvalues),
            difficulty=(1300, 1500),
            answer_type="set",
            solution=steps(
                "For a triangular matrix, eigenvalues are the diagonal entries",
                "Read off diagonal: $(λ1), $(λ2), $(λ3)",
                sol("Eigenvalues", eigenvalues),
                "Answer: \\\$\\{$(λ1), $(λ2), $(λ3)\\}\\\$"
            ),
            time=120
        )
    end
end