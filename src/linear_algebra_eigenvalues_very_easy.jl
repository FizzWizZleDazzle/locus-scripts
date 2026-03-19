# linear_algebra - eigenvalues (very_easy)
# Generated: 2026-03-08T21:12:52.075263

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/eigenvalues")
    
    prob_type = choice(1:4)
    
    if prob_type == 1
        # ELO 150-300: Recognize definition of eigenvalue
        λ = randint(-8, 8)
        v1 = randint(-5, 5)
        v2 = nonzero(-5, 5)
        
        question_text = "If \$\\vec{v} = \\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}\$ is an eigenvector of matrix \$A\$ with eigenvalue \$\\lambda = $(λ)\$, what is \$A\\vec{v}\$ equal to?"
        
        ans_v1 = λ * v1
        ans_v2 = λ * v2
        answer_text = "$(fmt_matrix([ans_v1, ans_v2]))"
        
        solution_text = steps(
            "By definition, if \$\\vec{v}\$ is an eigenvector with eigenvalue \$\\lambda\$, then \$A\\vec{v} = \\lambda \\vec{v}\$",
            sol("Computation", "A\\vec{v} = $(λ) \\cdot \\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}"),
            sol("Answer", "\\begin{bmatrix} $(ans_v1) \\\\ $(ans_v2) \\end{bmatrix}")
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(150, 300),
            solution=solution_text,
            answer_type="matrix",
            time=45
        )
        
    elseif prob_type == 2
        # ELO 300-500: Check if a value is an eigenvalue using characteristic equation
        λ = randint(-6, 6)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        det_val = (a - λ) * (d - λ) - b * c
        
        question_text = "For matrix \$A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$, compute \$\\det(A - $(λ)I)\$."
        
        solution_text = steps(
            sol("Setup", "A - $(λ)I = \\begin{bmatrix} $(a) - $(λ) & $(b) \\\\ $(c) & $(d) - $(λ) \\end{bmatrix} = \\begin{bmatrix} $(a - λ) & $(b) \\\\ $(c) & $(d - λ) \\end{bmatrix}"),
            sol("Determinant formula", "\\det(A - $(λ)I) = ($(a - λ))($(d - λ)) - ($(b))($(c))"),
            sol("Answer", det_val)
        )
        
        problem(
            question=question_text,
            answer=det_val,
            difficulty=(300, 500),
            solution=solution_text,
            time=60
        )
        
    elseif prob_type == 3
        # ELO 400-600: Verify eigenvector by direct computation
        λ = randint(-5, 5)
        v1 = randint(-4, 4)
        v2 = nonzero(-4, 4)
        
        # Construct A such that A*v = λ*v
        # Simple diagonal or triangular matrix
        if choice([true, false])
            a11 = λ
            a22 = randint(-6, 6)
            a12 = 0
            a21 = 0
        else
            a11 = λ
            a22 = λ
            a12 = randint(-3, 3)
            a21 = 0
        end
        
        av1 = a11 * v1 + a12 * v2
        av2 = a21 * v1 + a22 * v2
        
        question_text = "Given matrix \$A = \\begin{bmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{bmatrix}\$ and vector \$\\vec{v} = \\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}\$, compute \$A\\vec{v}\$."
        
        answer_text = "$(fmt_matrix([av1, av2]))"
        
        solution_text = steps(
            sol("Matrix multiplication", "A\\vec{v} = \\begin{bmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{bmatrix} \\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}"),
            sol("Row 1", "$(a11) \\cdot $(v1) + $(a12) \\cdot $(v2) = $(av1)"),
            sol("Row 2", "$(a21) \\cdot $(v1) + $(a22) \\cdot $(v2) = $(av2)"),
            sol("Answer", "\\begin{bmatrix} $(av1) \\\\ $(av2) \\end{bmatrix}")
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(400, 600),
            solution=solution_text,
            answer_type="matrix",
            time=75
        )
        
    else
        # ELO 500-700: Compute trace or determinant (properties related to eigenvalues)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        if choice([true, false])
            # Trace
            trace_val = a + d
            question_text = "Find the trace of matrix \$A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$."
            
            solution_text = steps(
                "The trace of a matrix is the sum of its diagonal entries",
                sol("Computation", "\\text{tr}(A) = $(a) + $(d)"),
                sol("Answer", trace_val)
            )
            
            problem(
                question=question_text,
                answer=trace_val,
                difficulty=(500, 650),
                solution=solution_text,
                time=45
            )
        else
            # Determinant
            det_val = a * d - b * c
            question_text = "Find the determinant of matrix \$A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\$."
            
            solution_text = steps(
                "For a 2×2 matrix, \$\\det(A) = ad - bc\$",
                sol("Computation", "\\det(A) = ($(a))($(d)) - ($(b))($(c))"),
                sol("Answer", det_val)
            )
            
            problem(
                question=question_text,
                answer=det_val,
                difficulty=(500, 700),
                solution=solution_text,
                time=60
            )
        end
    end
end