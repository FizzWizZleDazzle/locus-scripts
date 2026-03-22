# linear_algebra - linear_independence (medium)
# Generated: 2026-03-08T21:12:28.921017

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/linear_independence")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # Check if set of 2D vectors is linearly independent (1200-1400)
        a1, a2 = randint(-8, 8), randint(-8, 8)
        b1, b2 = randint(-8, 8), randint(-8, 8)
        
        # Make sure not parallel
        while a1 * b2 == a2 * b1 || (a1 == 0 && a2 == 0) || (b1 == 0 && b2 == 0)
            a1, a2 = randint(-8, 8), randint(-8, 8)
            b1, b2 = randint(-8, 8), randint(-8, 8)
        end
        
        det_val = a1 * b2 - a2 * b1
        is_independent = det_val != 0
        
        problem(
            question="Determine whether the vectors \\(\\mathbf{v}_1 = \\begin{bmatrix} $(a1) \\\\ $(a2) \\end{bmatrix}\\) and \\(\\mathbf{v}_2 = \\begin{bmatrix} $(b1) \\\\ $(b2) \\end{bmatrix}\\) are linearly independent. Answer 'yes' or 'no'.",
            answer=is_independent ? "yes" : "no",
            difficulty=(1200, 1400),
            solution=steps(
                "Check if \\(c_1\\mathbf{v}_1 + c_2\\mathbf{v}_2 = \\mathbf{0}\\) has only the trivial solution",
                "Form matrix: \\(\\begin{bmatrix} $(a1) & $(b1) \\\\ $(a2) & $(b2) \\end{bmatrix}\\)",
                "Compute determinant: \\($(a1) \\cdot $(b2) - $(a2) \\cdot $(b1) = $(det_val)\\)",
                is_independent ? "Since determinant ≠ 0, the vectors are linearly independent" : "Since determinant = 0, the vectors are linearly dependent"
            ),
            time=120
        )
        
    elseif prob_type == 2
        # Find if 3 vectors in R^3 are independent (1300-1500)
        a1, a2, a3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        b1, b2, b3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        c1, c2, c3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        
        # Compute determinant
        det_val = a1 * (b2 * c3 - b3 * c2) - a2 * (b1 * c3 - b3 * c1) + a3 * (b1 * c2 - b2 * c1)
        
        # Ensure non-zero determinant (re-pick all three vectors to avoid stuck loops when a,b are proportional)
        while det_val == 0
            a1, a2, a3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
            b1, b2, b3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
            c1, c2, c3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
            det_val = a1 * (b2 * c3 - b3 * c2) - a2 * (b1 * c3 - b3 * c1) + a3 * (b1 * c2 - b2 * c1)
        end
        
        is_independent = det_val != 0
        
        problem(
            question="Are the vectors \\(\\mathbf{v}_1 = \\begin{bmatrix} $(a1) \\\\ $(a2) \\\\ $(a3) \\end{bmatrix}\\), \\(\\mathbf{v}_2 = \\begin{bmatrix} $(b1) \\\\ $(b2) \\\\ $(b3) \\end{bmatrix}\\), and \\(\\mathbf{v}_3 = \\begin{bmatrix} $(c1) \\\\ $(c2) \\\\ $(c3) \\end{bmatrix}\\) linearly independent? Answer 'yes' or 'no'.",
            answer=is_independent ? "yes" : "no",
            difficulty=(1300, 1500),
            solution=steps(
                "Form matrix \\(A = \\begin{bmatrix} $(a1) & $(b1) & $(c1) \\\\ $(a2) & $(b2) & $(c2) \\\\ $(a3) & $(b3) & $(c3) \\end{bmatrix}\\)",
                "Compute determinant using cofactor expansion",
                "\\(\\det(A) = $(det_val)\\)",
                is_independent ? "Since \\(\\det(A) \\neq 0\\), the vectors are linearly independent" : "Since \\(\\det(A) = 0\\), the vectors are linearly dependent"
            ),
            time=180
        )
        
    elseif prob_type == 3
        # Given dependent vectors, find the relationship (1400-1600)
        r1, r2 = randint(-5, 5), randint(-5, 5)
        a1, a2 = randint(-8, 8), randint(-8, 8)
        
        while a1 == 0 && a2 == 0
            a1, a2 = randint(-8, 8), randint(-8, 8)
        end
        
        b1 = r1 * a1
        b2 = r1 * a2
        c1 = r2 * a1
        c2 = r2 * a2
        
        problem(
            question="The vectors \\(\\mathbf{v}_1 = \\begin{bmatrix} $(a1) \\\\ $(a2) \\end{bmatrix}\\), \\(\\mathbf{v}_2 = \\begin{bmatrix} $(b1) \\\\ $(b2) \\end{bmatrix}\\), and \\(\\mathbf{v}_3 = \\begin{bmatrix} $(c1) \\\\ $(c2) \\end{bmatrix}\\) are linearly dependent. Find the scalar \\(k\\) such that \\(\\mathbf{v}_3 = k \\mathbf{v}_1\\).",
            answer=r2,
            difficulty=(1400, 1600),
            solution=steps(
                "Notice that \\(\\mathbf{v}_2 = $(r1)\\mathbf{v}_1\\) and \\(\\mathbf{v}_3 = $(r2)\\mathbf{v}_1\\)",
                "Check: \\($(r2) \\cdot \\begin{bmatrix} $(a1) \\\\ $(a2) \\end{bmatrix} = \\begin{bmatrix} $(c1) \\\\ $(c2) \\end{bmatrix}\\)",
                sol("Therefore k =", r2)
            ),
            time=150
        )
        
    elseif prob_type == 4
        # Determine maximum number of independent vectors (1500-1700)
        n_vecs = rand(3:5)
        dim = rand(2:3)
        
        max_independent = min(n_vecs, dim)
        
        problem(
            question="What is the maximum number of linearly independent vectors you can have in \\(\\mathbb{R}^{$(dim)}\\) when choosing from a set of $(n_vecs) vectors?",
            answer=max_independent,
            difficulty=(1500, 1700),
            solution=steps(
                "The dimension of \\(\\mathbb{R}^{$(dim)}\\) is $(dim)",
                "Any set of linearly independent vectors in \\(\\mathbb{R}^{$(dim)}\\) can have at most $(dim) vectors",
                "We have $(n_vecs) vectors available, so the maximum is \\(\\min($(n_vecs), $(dim)) = $(max_independent)\\)",
                sol("Answer:", max_independent)
            ),
            time=90
        )
        
    else
        # Check if polynomial set is independent (1600-1800)
        # Use polynomials {1, x, x^2} vs {1, x, 1+x}
        is_standard = rand(Bool)
        
        if is_standard
            problem(
                question="Are the polynomials \\(p_1(x) = 1\\), \\(p_2(x) = x\\), and \\(p_3(x) = x^2\\) linearly independent in the vector space of polynomials of degree at most 2? Answer 'yes' or 'no'.",
                answer="yes",
                difficulty=(1600, 1800),
                solution=steps(
                    "Suppose \\(c_1(1) + c_2(x) + c_3(x^2) = 0\\) for all \\(x\\)",
                    "This means \\(c_1 + c_2 x + c_3 x^2 = 0\\) as a polynomial",
                    "For this to hold for all \\(x\\), we need \\(c_1 = 0\\), \\(c_2 = 0\\), \\(c_3 = 0\\)",
                    "Only the trivial solution exists, so the polynomials are linearly independent"
                ),
                time=180
            )
        else
            a = randint(2, 5)
            problem(
                question="Are the polynomials \\(p_1(x) = 1\\), \\(p_2(x) = x\\), and \\(p_3(x) = $(a) + x\\) linearly independent? Answer 'yes' or 'no'.",
                answer="no",
                difficulty=(1600, 1800),
                solution=steps(
                    "Notice that \\(p_3(x) = $(a) \\cdot p_1(x) + p_2(x)\\)",
                    "This gives us \\($(a) p_1(x) + p_2(x) - p_3(x) = 0\\) (non-trivial combination)",
                    "Since we found a non-trivial linear combination equal to zero, the set is linearly dependent",
                    "Answer: no"
                ),
                time=180
            )
        end
    end
end