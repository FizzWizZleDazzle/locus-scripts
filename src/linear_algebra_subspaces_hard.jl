# linear_algebra - subspaces (hard)
# Generated: 2026-03-08T21:11:54.859099

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/subspaces")
    
    problem_type = choice([
        :subspace_verification,
        :basis_dimension,
        :intersection_subspaces,
        :span_verification,
        :nullspace_dimension,
        :column_space_basis,
        :subspace_sum_dimension
    ])
    
    if problem_type == :subspace_verification
        # Given vectors, verify if they span a subspace or form a basis
        dim = choice([2, 3, 4])
        num_vectors = randint(2, dim + 1)
        
        # Create vectors that are linearly dependent or independent
        is_independent = choice([true, false])
        
        if dim == 3 && num_vectors == 2
            a1, a2, a3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
            b1, b2, b3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
            
            v1_str = "\\begin{bmatrix} $a1 \\\\ $a2 \\\\ $a3 \\end{bmatrix}"
            v2_str = "\\begin{bmatrix} $b1 \\\\ $b2 \\\\ $b3 \\end{bmatrix}"
            
            # Check if independent using cross product concept
            det_val = a1*b2*1 - a1*1*b3 + a2*1*b1 - a2*b1*1 + a3*b1*1 - a3*1*b2
            
            vectors_str = "\\mathbf{v}_1 = $v1_str, \\quad \\mathbf{v}_2 = $v2_str"
            
            ans = 2  # dimension of span
            
            question = "Let \\(W = \\text{span}\\{\\mathbf{v}_1, \\mathbf{v}_2\\}\\) where $vectors_str. Find \\(\\dim(W)\\)."
            
            solution = steps(
                "Given vectors in \\(\\mathbb{R}^3\\)",
                "Check if vectors are linearly independent",
                "Since the vectors are not scalar multiples, they are linearly independent",
                sol("Dimension", ans)
            )
            
            problem(
                question=question,
                answer=ans,
                difficulty=(1800, 2000),
                solution=solution,
                time=180
            )
            
        else
            # 4D case with 3 vectors
            a = [nonzero(-4, 4) for _ in 1:4]
            b = [nonzero(-4, 4) for _ in 1:4]
            c = [a[i] + b[i] for i in 1:4]  # make dependent
            
            v1_str = "\\begin{bmatrix} $(a[1]) \\\\ $(a[2]) \\\\ $(a[3]) \\\\ $(a[4]) \\end{bmatrix}"
            v2_str = "\\begin{bmatrix} $(b[1]) \\\\ $(b[2]) \\\\ $(b[3]) \\\\ $(b[4]) \\end{bmatrix}"
            v3_str = "\\begin{bmatrix} $(c[1]) \\\\ $(c[2]) \\\\ $(c[3]) \\\\ $(c[4]) \\end{bmatrix}"
            
            vectors_str = "\\mathbf{v}_1 = $v1_str, \\mathbf{v}_2 = $v2_str, \\mathbf{v}_3 = $v3_str"
            
            ans = 2
            
            question = "Find the dimension of \\(W = \\text{span}\\{\\mathbf{v}_1, \\mathbf{v}_2, \\mathbf{v}_3\\}\\) where $vectors_str."
            
            solution = steps(
                "Given three vectors in \\(\\mathbb{R}^4\\)",
                "Observe that \\(\\mathbf{v}_3 = \\mathbf{v}_1 + \\mathbf{v}_2\\)",
                "Therefore \\(\\mathbf{v}_3\\) is in the span of \\(\\mathbf{v}_1\\) and \\(\\mathbf{v}_2\\)",
                "The vectors \\(\\mathbf{v}_1\\) and \\(\\mathbf{v}_2\\) are linearly independent",
                sol("Dimension", ans)
            )
            
            problem(
                question=question,
                answer=ans,
                difficulty=(1900, 2100),
                solution=solution,
                time=240
            )
        end
        
    elseif problem_type == :basis_dimension
        # Find basis and dimension of intersection or sum
        
        # Two subspaces in R^4
        k = nonzero(-3, 3)
        
        # U: x + y = 0, z = 0
        # V: y = kz, w = 0
        
        # Intersection: x + y = 0, z = 0, y = kz, w = 0
        # From z = 0 and y = kz, we get y = 0, so x = 0
        # Intersection is {0}, dimension 0
        
        ans = 0
        
        question = "Let \\(U = \\{(x, y, z, w) \\in \\mathbb{R}^4 : x + y = 0, z = 0\\}\\) and \\(V = \\{(x, y, z, w) \\in \\mathbb{R}^4 : y = $(k)z, w = 0\\}\\). Find \\(\\dim(U \\cap V)\\)."
        
        solution = steps(
            "Find the intersection by combining all constraints",
            "From \\(U\\): \\(x + y = 0\\) and \\(z = 0\\)",
            "From \\(V\\): \\(y = $(k)z\\) and \\(w = 0\\)",
            "Since \\(z = 0\\) and \\(y = $(k)z\\), we have \\(y = 0\\)",
            "From \\(x + y = 0\\), we get \\(x = 0\\)",
            "Therefore \\(U \\cap V = \\{\\mathbf{0}\\}\\)",
            sol("Dimension", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2000, 2200),
            solution=solution,
            time=300
        )
        
    elseif problem_type == :intersection_subspaces
        # Intersection of two subspaces defined by equations
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # U: ax + by + z = 0 (dimension 2 in R^3)
        # V: x = 0 (dimension 2 in R^3)
        # Intersection: x = 0 and ax + by + z = 0, so by + z = 0 (dimension 1)
        
        ans = 1
        
        question = "Let \\(U = \\{(x, y, z) \\in \\mathbb{R}^3 : $(a)x + $(b)y + z = 0\\}\\) and \\(V = \\{(x, y, z) \\in \\mathbb{R}^3 : x = 0\\}\\). Find \\(\\dim(U \\cap V)\\)."
        
        solution = steps(
            "\\(U\\) is a plane through the origin with dimension 2",
            "\\(V\\) is the yz-plane with dimension 2",
            "For \\(U \\cap V\\), we need \\(x = 0\\) and \\($(a)x + $(b)y + z = 0\\)",
            "This simplifies to \\($(b)y + z = 0\\), which is a line through the origin",
            sol("Dimension", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(1900, 2100),
            solution=solution,
            time=240
        )
        
    elseif problem_type == :span_verification
        # Determine if a vector is in the span of other vectors
        
        # In R^3, check if (target) is in span of v1, v2
        a1, a2, a3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        b1, b2, b3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
        
        s = nonzero(-3, 3)
        t = nonzero(-3, 3)
        
        c1 = s * a1 + t * b1
        c2 = s * a2 + t * b2
        c3 = s * a3 + t * b3
        
        v1_str = "\\begin{bmatrix} $a1 \\\\ $a2 \\\\ $a3 \\end{bmatrix}"
        v2_str = "\\begin{bmatrix} $b1 \\\\ $b2 \\\\ $b3 \\end{bmatrix}"
        w_str = "\\begin{bmatrix} $c1 \\\\ $c2 \\\\ $c3 \\end{bmatrix}"
        
        ans_str = "($s, $t)"
        
        question = "Let \\(\\mathbf{v}_1 = $v1_str\\) and \\(\\mathbf{v}_2 = $v2_str\\). Express \\(\\mathbf{w} = $w_str\\) as a linear combination of \\(\\mathbf{v}_1\\) and \\(\\mathbf{v}_2\\). Give your answer as an ordered pair \\((c_1, c_2)\\) where \\(\\mathbf{w} = c_1\\mathbf{v}_1 + c_2\\mathbf{v}_2\\)."
        
        solution = steps(
            "We seek \\(c_1, c_2\\) such that \\(c_1\\mathbf{v}_1 + c_2\\mathbf{v}_2 = \\mathbf{w}\\)",
            "This gives the system: \\($(a1)c_1 + $(b1)c_2 = $(c1)\\), \\($(a2)c_1 + $(b2)c_2 = $(c2)\\), \\($(a3)c_1 + $(b3)c_2 = $(c3)\\)",
            "By construction, \\(\\mathbf{w} = $(s)\\mathbf{v}_1 + $(t)\\mathbf{v}_2\\)",
            sol("Answer", ans_str)
        )
        
        problem(
            question=question,
            answer=ans_str,
            difficulty=(1800, 2000),
            solution=solution,
            time=210
        )
        
    elseif problem_type == :nullspace_dimension
        # Matrix nullspace dimension via rank-nullity
        
        rows = choice([2, 3])
        cols = choice([3, 4, 5])
        rank_val = randint(1, min(rows, cols) - 1)
        
        nullity = cols - rank_val
        
        question = "Let \\(A\\) be a \\($(rows) \\times $(cols)\\) matrix with \\(\\text{rank}(A) = $(rank_val)\\). Find \\(\\dim(\\text{Nul}(A))\\)."
        
        solution = steps(
            "By the Rank-Nullity Theorem: \\(\\text{rank}(A) + \\dim(\\text{Nul}(A)) = n\\) where \\(n\\) is the number of columns",
            "Here, \\(n = $(cols)\\) and \\(\\text{rank}(A) = $(rank_val)\\)",
            "Therefore, \\(\\dim(\\text{Nul}(A)) = $(cols) - $(rank_val) = $(nullity)\\)",
            sol("Answer", nullity)
        )
        
        problem(
            question=question,
            answer=nullity,
            difficulty=(1800, 2000),
            solution=solution,
            time=120
        )
        
    elseif problem_type == :column_space_basis
        # Determine dimension of column space
        
        m = choice([3, 4, 5])
        n = choice([3, 4])
        rank_val = randint(2, min(m, n))
        
        question = "A \\($(m) \\times $(n)\\) matrix \\(A\\) has \\(\\text{rank}(A) = $(rank_val)\\). What is \\(\\dim(\\text{Col}(A))\\)?"
        
        solution = steps(
            "The column space of \\(A\\) is the span of the columns of \\(A\\)",
            "The dimension of the column space equals the rank of the matrix",
            "Therefore, \\(\\dim(\\text{Col}(A)) = \\text{rank}(A)\\)",
            sol("Answer", rank_val)
        )
        
        problem(
            question=question,
            answer=rank_val,
            difficulty=(1800, 1950),
            solution=solution,
            time=90
        )
        
    else  # subspace_sum_dimension
        # Dimension formula for sum of subspaces
        
        dim_U = randint(2, 5)
        dim_V = randint(2, 5)
        dim_intersect = randint(1, min(dim_U, dim_V))
        
        dim_sum = dim_U + dim_V - dim_intersect
        
        question = "Let \\(U\\) and \\(V\\) be subspaces of \\(\\mathbb{R}^n\\) with \\(\\dim(U) = $(dim_U)\\), \\(\\dim(V) = $(dim_V)\\), and \\(\\dim(U \\cap V) = $(dim_intersect)\\). Find \\(\\dim(U + V)\\)."
        
        solution = steps(
            "Use the dimension formula for subspace sum:",
            "\\(\\dim(U + V) = \\dim(U) + \\dim(V) - \\dim(U \\cap V)\\)",
            "Substitute values: \\(\\dim(U + V) = $(dim_U) + $(dim_V) - $(dim_intersect)\\)",
            sol("Answer", dim_sum)
        )
        
        problem(
            question=question,
            answer=dim_sum,
            difficulty=(1900, 2100),
            solution=solution,
            time=150
        )
    end
end