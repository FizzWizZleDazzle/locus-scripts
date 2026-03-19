# linear_algebra - linear_transformations (easy)
# Generated: 2026-03-08T21:15:00.814056

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("linear_algebra/linear_transformations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Matrix-vector multiplication
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = randint(-5, 5)
        v1 = randint(-8, 8)
        v2 = randint(-8, 8)
        
        result1 = a * v1 + b * v2
        result2 = c * v1 + d * v2
        
        problem(
            question="Let \\(T: \\mathbb{R}^2 \\to \\mathbb{R}^2\\) be the linear transformation with matrix \\(A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\). Find \\(T\\begin{pmatrix} $(v1) \\\\ $(v2) \\end{pmatrix}\\).",
            answer=fmt_tuple([result1, result2]),
            difficulty=(700, 900),
            answer_type="tuple",
            solution=steps(
                "Given: \\(A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\), \\(\\mathbf{v} = \\begin{pmatrix} $(v1) \\\\ $(v2) \\end{pmatrix}\\)",
                "Compute \\(A\\mathbf{v}\\): First row: \\($(a) \\cdot $(v1) + $(b) \\cdot $(v2) = $(result1)\\)",
                "Second row: \\($(c) \\cdot $(v1) + $(d) \\cdot $(v2) = $(result2)\\)",
                sol("Answer", fmt_tuple([result1, result2]))
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Image of standard basis vector
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        basis = rand([1, 2])
        
        if basis == 1
            result = fmt_tuple([a, c])
            vec_str = "\\mathbf{e}_1 = \\begin{pmatrix} 1 \\\\ 0 \\end{pmatrix}"
            explanation = "The first column of the matrix gives \\(T(\\mathbf{e}_1)\\)"
        else
            result = fmt_tuple([b, d])
            vec_str = "\\mathbf{e}_2 = \\begin{pmatrix} 0 \\\\ 1 \\end{pmatrix}"
            explanation = "The second column of the matrix gives \\(T(\\mathbf{e}_2)\\)"
        end
        
        problem(
            question="A linear transformation \\(T: \\mathbb{R}^2 \\to \\mathbb{R}^2\\) has matrix \\(\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\). Find \\(T($(vec_str))\\).",
            answer=result,
            difficulty=(700, 850),
            answer_type="tuple",
            solution=steps(
                "Given: \\(T\\) has matrix \\(A = \\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\)",
                explanation,
                sol("Answer", result)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Find matrix given images of basis vectors
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-8, 8)
        
        problem(
            question="Find the matrix of the linear transformation \\(T: \\mathbb{R}^2 \\to \\mathbb{R}^2\\) such that \\(T\\begin{pmatrix} 1 \\\\ 0 \\end{pmatrix} = \\begin{pmatrix} $(a) \\\\ $(c) \\end{pmatrix}\\) and \\(T\\begin{pmatrix} 0 \\\\ 1 \\end{pmatrix} = \\begin{pmatrix} $(b) \\\\ $(d) \\end{pmatrix}\\).",
            answer=fmt_matrix([[a, b], [c, d]]),
            difficulty=(800, 1000),
            answer_type="matrix",
            solution=steps(
                "The matrix of \\(T\\) has columns equal to the images of the standard basis vectors",
                "Column 1: \\(T(\\mathbf{e}_1) = \\begin{pmatrix} $(a) \\\\ $(c) \\end{pmatrix}\\)",
                "Column 2: \\(T(\\mathbf{e}_2) = \\begin{pmatrix} $(b) \\\\ $(d) \\end{pmatrix}\\)",
                sol("Answer", "\\(\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\)")
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Check if vector is in kernel
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = randint(-5, 5)
        
        # Make sure matrix is not zero
        if a == 0 && b == 0 && c == 0 && d == 0
            a = nonzero(-5, 5)
        end
        
        is_kernel = rand([true, false])
        
        if is_kernel
            # Find a vector in the kernel: solve Av = 0
            if a != 0
                v2 = nonzero(-8, 8)
                v1 = -(b * v2) ÷ a
                if a * v1 + b * v2 != 0
                    v1 = 0
                    v2 = 0
                end
            elseif b != 0
                v1 = nonzero(-8, 8)
                v2 = 0
                if a * v1 + b * v2 != 0
                    v1 = 0
                    v2 = 0
                end
            else
                v1 = 0
                v2 = 0
            end
            
            # Verify
            result1 = a * v1 + b * v2
            result2 = c * v1 + d * v2
            ans = "Yes"
        else
            # Pick random non-kernel vector
            v1 = randint(-8, 8)
            v2 = randint(-8, 8)
            result1 = a * v1 + b * v2
            result2 = c * v1 + d * v2
            
            # Make sure it's not in kernel
            if result1 == 0 && result2 == 0
                v1 = v1 + nonzero(1, 3)
                result1 = a * v1 + b * v2
                result2 = c * v1 + d * v2
            end
            
            ans = "No"
        end
        
        problem(
            question="Let \\(T: \\mathbb{R}^2 \\to \\mathbb{R}^2\\) have matrix \\(\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}\\). Is \\(\\begin{pmatrix} $(v1) \\\\ $(v2) \\end{pmatrix}\\) in the kernel of \\(T\\)? Answer Yes or No.",
            answer=ans,
            difficulty=(900, 1100),
            answer_type="text",
            solution=steps(
                "A vector \\(\\mathbf{v}\\) is in the kernel if \\(T(\\mathbf{v}) = \\mathbf{0}\\)",
                "Compute: \\(T\\begin{pmatrix} $(v1) \\\\ $(v2) \\end{pmatrix} = \\begin{pmatrix} $(result1) \\\\ $(result2) \\end{pmatrix}\\)",
                is_kernel ? "This equals the zero vector, so the answer is Yes" : "This is not the zero vector, so the answer is No",
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Composition of transformations
        a1 = randint(-4, 4)
        b1 = randint(-4, 4)
        c1 = randint(-4, 4)
        d1 = randint(-4, 4)
        
        a2 = randint(-4, 4)
        b2 = randint(-4, 4)
        c2 = randint(-4, 4)
        d2 = randint(-4, 4)
        
        # Compute matrix product (S ∘ T means apply T first, then S, so S*T)
        result_a = a2 * a1 + b2 * c1
        result_b = a2 * b1 + b2 * d1
        result_c = c2 * a1 + d2 * c1
        result_d = c2 * b1 + d2 * d1
        
        problem(
            question="Let \\(T: \\mathbb{R}^2 \\to \\mathbb{R}^2\\) have matrix \\(A = \\begin{bmatrix} $(a1) & $(b1) \\\\ $(c1) & $(d1) \\end{bmatrix}\\) and \\(S: \\mathbb{R}^2 \\to \\mathbb{R}^2\\) have matrix \\(B = \\begin{bmatrix} $(a2) & $(b2) \\\\ $(c2) & $(d2) \\end{bmatrix}\\). Find the matrix of the composition \\(S \\circ T\\).",
            answer=fmt_matrix([[result_a, result_b], [result_c, result_d]]),
            difficulty=(1000, 1200),
            answer_type="matrix",
            solution=steps(
                "The matrix of \\(S \\circ T\\) is the product \\(BA\\)",
                "Compute: \\(\\begin{bmatrix} $(a2) & $(b2) \\\\ $(c2) & $(d2) \\end{bmatrix} \\begin{bmatrix} $(a1) & $(b1) \\\\ $(c1) & $(d1) \\end{bmatrix}\\)",
                "Entry (1,1): \\($(a2) \\cdot $(a1) + $(b2) \\cdot $(c1) = $(result_a)\\)",
                "Entry (1,2): \\($(a2) \\cdot $(b1) + $(b2) \\cdot $(d1) = $(result_b)\\)",
                "Entry (2,1): \\($(c2) \\cdot $(a1) + $(d2) \\cdot $(c1) = $(result_c)\\)",
                "Entry (2,2): \\($(c2) \\cdot $(b1) + $(d2) \\cdot $(d1) = $(result_d)\\)",
                sol("Answer", "\\(\\begin{bmatrix} $(result_a) & $(result_b) \\\\ $(result_c) & $(result_d) \\end{bmatrix}\\)")
            ),
            time=180
        )
    end
end