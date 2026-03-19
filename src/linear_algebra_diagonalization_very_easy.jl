# linear_algebra - diagonalization (very_easy)
# Generated: 2026-03-08T21:13:43.795908

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/diagonalization")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # ELO 200-300: Recognize what diagonalization means
        question = "What does it mean for a matrix \\(A\\) to be diagonalizable?"
        answer = "There exists an invertible matrix P such that P^(-1)AP is diagonal"
        difficulty = (200, 300)
        solution = steps(
            "A matrix is diagonalizable if it can be written in the form \\(A = PDP^{-1}\\)",
            "where \\(D\\) is a diagonal matrix",
            "This means \\(P^{-1}AP = D\\)"
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            answer_type="text",
            time=30
        )
    elseif problem_type == 2
        # ELO 300-400: Identify eigenvalues from diagonal matrix
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        question = "If \\(D = \\begin{pmatrix} $(λ1) & 0 \\\\ 0 & $(λ2) \\end{pmatrix}\\), what are the eigenvalues of \\(D\\)?"
        answer = fmt_set(Set([λ1, λ2]))
        difficulty = (300, 400)
        solution = steps(
            sol("Given", "D = \\begin{pmatrix} $(λ1) & 0 \\\\ 0 & $(λ2) \\end{pmatrix}"),
            "For a diagonal matrix, the eigenvalues are the diagonal entries",
            "Eigenvalues: \\(\\{$(λ1), $(λ2)\\}\\)"
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            answer_type="set",
            time=45
        )
    elseif problem_type == 3
        # ELO 400-500: Find eigenvalues of 2x2 matrix (simple case)
        λ = randint(-6, 6)
        a = randint(-5, 5)
        question = "Find the eigenvalues of \\(A = \\begin{pmatrix} $(λ) & $(a) \\\\ 0 & $(λ) \\end{pmatrix}\\)"
        answer = fmt_set(Set([λ]))
        difficulty = (400, 500)
        solution = steps(
            sol("Given", "A = \\begin{pmatrix} $(λ) & $(a) \\\\ 0 & $(λ) \\end{pmatrix}"),
            "For an upper triangular matrix, eigenvalues are the diagonal entries",
            "Both diagonal entries are $(λ), so eigenvalue: \\(\\{$(λ)\\}\\)"
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            answer_type="set",
            time=60
        )
    elseif problem_type == 4
        # ELO 500-600: Count eigenvectors needed
        n = rand(2:5)
        question = "How many linearly independent eigenvectors does an \\($(n) \\times $(n)\\) matrix need to be diagonalizable?"
        answer = n
        difficulty = (500, 600)
        solution = steps(
            "A matrix is diagonalizable if and only if it has \\(n\\) linearly independent eigenvectors",
            "For an \\($(n) \\times $(n)\\) matrix, we need exactly \\($(n)\\) linearly independent eigenvectors",
            sol("Answer", n)
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            time=45
        )
    elseif problem_type == 5
        # ELO 600-700: Verify eigenvalue
        λ = randint(-5, 5)
        a = randint(-4, 4)
        b = randint(-4, 4)
        c = randint(-4, 4)
        d = λ - a
        question = "Verify that \\(\\lambda = $(λ)\\) is an eigenvalue of \\(A = \\begin{pmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{pmatrix}\\) by computing \\(\\det(A - \\lambda I)\\)"
        det_val = (a - λ) * (d - λ) - b * c
        answer = det_val
        difficulty = (600, 700)
        solution = steps(
            sol("Given", "A = \\begin{pmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{pmatrix}, \\lambda = $(λ)"),
            "Compute \\(A - $(λ)I = \\begin{pmatrix} $(a - λ) & $(b) \\\\ $(c) & $(d - λ) \\end{pmatrix}\\)",
            "Calculate determinant: \\(($(a - λ))($(d - λ)) - ($(b))($(c)) = $(det_val)\\)",
            "Since \\(\\det(A - \\lambda I) = $(det_val)\\), " * (det_val == 0 ? "\\(\\lambda = $(λ)\\) is an eigenvalue" : "\\(\\lambda = $(λ)\\) is NOT an eigenvalue")
        )
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            time=90
        )
    else
        # ELO 650-700: True/False about diagonalization
        statements = [
            ("Every matrix is diagonalizable", "False"),
            ("A diagonal matrix is diagonalizable", "True"),
            ("If a matrix has n distinct eigenvalues, it is diagonalizable", "True"),
            ("The identity matrix is diagonalizable", "True"),
            ("A matrix with repeated eigenvalues is never diagonalizable", "False")
        ]
        stmt, ans = choice(statements)
        question = "True or False: $(stmt)?"
        answer = ans
        difficulty = (650, 700)
        if ans == "True"
            solution = steps(
                "Statement: $(stmt)",
                "This statement is TRUE",
                "Explanation: " * (stmt == "A diagonal matrix is diagonalizable" ? "A diagonal matrix D satisfies D = I·D·I" :
                                  stmt == "If a matrix has n distinct eigenvalues, it is diagonalizable" ? "Distinct eigenvalues guarantee n linearly independent eigenvectors" :
                                  "The identity matrix I is already diagonal")
            )
        else
            solution = steps(
                "Statement: $(stmt)",
                "This statement is FALSE",
                "Explanation: " * (stmt == "Every matrix is diagonalizable" ? "Some matrices (e.g., \\(\\begin{pmatrix} 1 & 1 \\\\ 0 & 1 \\end{pmatrix}\\)) are not diagonalizable" :
                                  "A matrix with repeated eigenvalues CAN be diagonalizable if it has enough eigenvectors")
            )
        end
        problem(
            question=question,
            answer=answer,
            difficulty=difficulty,
            solution=solution,
            answer_type="text",
            time=60
        )
    end
end