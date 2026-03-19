# linear_algebra - linear_transformations (medium)
# Generated: 2026-03-08T21:15:15.773527

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("linear_algebra/linear_transformations")
    
    problem_type = choice([
        :matrix_application,
        :kernel_dimension,
        :range_dimension,
        :transformation_composition,
        :eigenspace,
        :inverse_exists,
        :nullity_rank,
        :transformation_matrix
    ])
    
    if problem_type == :matrix_application
        # Apply a linear transformation given by a matrix to a vector
        a11, a12 = randint(-8, 8), randint(-8, 8)
        a21, a22 = randint(-8, 8), randint(-8, 8)
        v1, v2 = randint(-10, 10), randint(-10, 10)
        
        result1 = a11 * v1 + a12 * v2
        result2 = a21 * v1 + a22 * v2
        
        matrix_str = "\\begin{bmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{bmatrix}"
        vector_str = "\\begin{bmatrix} $(v1) \\\\ $(v2) \\end{bmatrix}"
        answer_str = "\\begin{bmatrix} $(result1) \\\\ $(result2) \\end{bmatrix}"
        
        problem(
            question = "Let \$T: \\mathbb{R}^2 \\to \\mathbb{R}^2\$ be the linear transformation defined by the matrix \$A = $(matrix_str)\$. Find \$T(\\mathbf{v})\$ where \$\\mathbf{v} = $(vector_str)\$.",
            answer = answer_str,
            difficulty = (1200, 1400),
            answer_type = "vector",
            solution = steps(
                "Given: \$A = $(matrix_str)\$ and \$\\mathbf{v} = $(vector_str)\$",
                "Compute \$T(\\mathbf{v}) = A\\mathbf{v}\$",
                "First component: \$($(a11))($(v1)) + ($(a12))($(v2)) = $(result1)\$",
                "Second component: \$($(a21))($(v1)) + ($(a22))($(v2)) = $(result2)\$",
                sol("Answer", answer_str)
            ),
            time = 120
        )
        
    elseif problem_type == :kernel_dimension
        # Find dimension of kernel for a matrix
        rank_val = choice([0, 1])
        n = 3
        dim_kernel = n - rank_val
        
        if rank_val == 0
            matrix_str = "\\begin{bmatrix} 0 & 0 & 0 \\\\ 0 & 0 & 0 \\end{bmatrix}"
        else  # rank 1
            a = nonzero(-5, 5)
            b = nonzero(-5, 5)
            c = nonzero(-5, 5)
            matrix_str = "\\begin{bmatrix} $(a) & $(b) & $(c) \\\\ $(2*a) & $(2*b) & $(2*c) \\end{bmatrix}"
        end
        
        problem(
            question = "Find the dimension of the kernel (null space) of the linear transformation \$T: \\mathbb{R}^3 \\to \\mathbb{R}^2\$ represented by the matrix \$A = $(matrix_str)\$.",
            answer = dim_kernel,
            difficulty = (1400, 1600),
            solution = steps(
                "Given matrix: \$A = $(matrix_str)\$",
                "The rank-nullity theorem states: \$\\dim(\\text{ker}(T)) + \\dim(\\text{range}(T)) = \\dim(\\text{domain})\$",
                "The domain is \$\\mathbb{R}^3\$, so \$\\dim(\\text{domain}) = 3\$",
                "The rank of \$A\$ is $(rank_val) (number of linearly independent rows)",
                "Therefore: \$\\dim(\\text{ker}(T)) = 3 - $(rank_val) = $(dim_kernel)\$",
                sol("Answer", dim_kernel)
            ),
            time = 180
        )
        
    elseif problem_type == :range_dimension
        # Find dimension of range
        m = choice([2, 3])
        n = choice([3, 4])
        rank_val = randint(1, min(m, n))
        
        problem(
            question = "A linear transformation \$T: \\mathbb{R}^$(n) \\to \\mathbb{R}^$(m)\$ has a matrix representation with rank $(rank_val). What is the dimension of the range of \$T\$?",
            answer = rank_val,
            difficulty = (1200, 1400),
            solution = steps(
                "The range of a linear transformation \$T\$ is the column space of its matrix representation",
                "The dimension of the column space equals the rank of the matrix",
                "Given: rank\$(A) = $(rank_val)\$",
                sol("Answer", "\$\\dim(\\text{range}(T)) = $(rank_val)\$")
            ),
            time = 90
        )
        
    elseif problem_type == :transformation_composition
        # Composition of two linear transformations represented by matrices
        a = randint(-4, 4)
        b = randint(-4, 4)
        c = randint(-4, 4)
        d = randint(-4, 4)
        
        e = randint(-4, 4)
        f = randint(-4, 4)
        g = randint(-4, 4)
        h = randint(-4, 4)
        
        # Compute (S ∘ T) which is BA
        r11 = e * a + f * c
        r12 = e * b + f * d
        r21 = g * a + h * c
        r22 = g * b + h * d
        
        matrix_T = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
        matrix_S = "\\begin{bmatrix} $(e) & $(f) \\\\ $(g) & $(h) \\end{bmatrix}"
        answer_str = "\\begin{bmatrix} $(r11) & $(r12) \\\\ $(r21) & $(r22) \\end{bmatrix}"
        
        problem(
            question = "Let \$T: \\mathbb{R}^2 \\to \\mathbb{R}^2\$ be defined by the matrix \$A = $(matrix_T)\$ and \$S: \\mathbb{R}^2 \\to \\mathbb{R}^2\$ be defined by the matrix \$B = $(matrix_S)\$. Find the matrix representing the composition \$S \\circ T\$.",
            answer = answer_str,
            difficulty = (1400, 1700),
            answer_type = "matrix",
            solution = steps(
                "The composition \$S \\circ T\$ is represented by the matrix product \$BA\$",
                "Compute \$BA = $(matrix_S) $(matrix_T)\$",
                "Entry (1,1): \$($(e))($(a)) + ($(f))($(c)) = $(r11)\$",
                "Entry (1,2): \$($(e))($(b)) + ($(f))($(d)) = $(r12)\$",
                "Entry (2,1): \$($(g))($(a)) + ($(h))($(c)) = $(r21)\$",
                "Entry (2,2): \$($(g))($(b)) + ($(h))($(d)) = $(r22)\$",
                sol("Answer", answer_str)
            ),
            time = 180
        )
        
    elseif problem_type == :eigenspace
        # Find dimension of eigenspace for a diagonal or triangular matrix
        lambda = randint(-6, 6)
        multiplicity = choice([1, 2])
        
        if multiplicity == 1
            other1 = nonzero(-6, 6)
            other2 = nonzero(-6, 6)
            while other1 == lambda || other2 == lambda
                other1 = nonzero(-6, 6)
                other2 = nonzero(-6, 6)
            end
            matrix_str = "\\begin{bmatrix} $(lambda) & 0 & 0 \\\\ 0 & $(other1) & 0 \\\\ 0 & 0 & $(other2) \\end{bmatrix}"
            dim_eigenspace = 1
        else
            other = nonzero(-6, 6)
            while other == lambda
                other = nonzero(-6, 6)
            end
            matrix_str = "\\begin{bmatrix} $(lambda) & 0 & 0 \\\\ 0 & $(lambda) & 0 \\\\ 0 & 0 & $(other) \\end{bmatrix}"
            dim_eigenspace = 2
        end
        
        problem(
            question = "Find the dimension of the eigenspace corresponding to eigenvalue \$\\lambda = $(lambda)\$ for the matrix \$A = $(matrix_str)\$.",
            answer = dim_eigenspace,
            difficulty = (1500, 1700),
            solution = steps(
                "The eigenspace for \$\\lambda = $(lambda)\$ is the null space of \$A - $(lambda)I\$",
                "Since \$A\$ is diagonal, the eigenspace dimension equals the multiplicity of \$\\lambda\$ on the diagonal",
                "Count occurrences of \$\\lambda = $(lambda)\$ on the diagonal: $(dim_eigenspace)",
                sol("Answer", dim_eigenspace)
            ),
            time = 150
        )
        
    elseif problem_type == :inverse_exists
        # Determine if transformation is invertible
        det_val = nonzero(-12, 12)
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        
        # Construct matrix with specific determinant
        # For 2x2: det = ad - bc, so d = (det + bc)/a if a ≠ 0
        if a != 0
            d = (det_val + b * c) / a
            if d == round(d)
                d = Int(d)
                matrix_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
                is_invertible = "yes"
            else
                # Fallback to simple diagonal
                matrix_str = "\\begin{bmatrix} $(det_val) & 0 \\\\ 0 & 1 \\end{bmatrix}"
                is_invertible = "yes"
            end
        else
            matrix_str = "\\begin{bmatrix} $(det_val) & 0 \\\\ 0 & 1 \\end{bmatrix}"
            is_invertible = "yes"
        end
        
        problem(
            question = "Is the linear transformation \$T: \\mathbb{R}^2 \\to \\mathbb{R}^2\$ defined by the matrix \$A = $(matrix_str)\$ invertible? Answer 'yes' or 'no'.",
            answer = is_invertible,
            difficulty = (1300, 1500),
            solution = steps(
                "A linear transformation is invertible if and only if its matrix is invertible",
                "A matrix is invertible if and only if its determinant is nonzero",
                "For the given matrix \$A = $(matrix_str)\$, compute \$\\det(A)\$",
                "Since \$\\det(A) \\neq 0\$, the matrix is invertible",
                sol("Answer", is_invertible)
            ),
            time = 120
        )
        
    elseif problem_type == :nullity_rank
        # Given rank, find nullity using rank-nullity theorem
        n = randint(4, 7)
        m = randint(2, n-1)
        rank_val = randint(1, min(m, n-1))
        nullity = n - rank_val
        
        problem(
            question = "A linear transformation \$T: \\mathbb{R}^$(n) \\to \\mathbb{R}^$(m)\$ has rank $(rank_val). What is the nullity of \$T\$?",
            answer = nullity,
            difficulty = (1200, 1400),
            solution = steps(
                "The rank-nullity theorem states: \$\\text{rank}(T) + \\text{nullity}(T) = \\dim(\\text{domain})\$",
                "Given: \$\\text{rank}(T) = $(rank_val)\$ and domain is \$\\mathbb{R}^$(n)\$",
                "So: \$\\text{nullity}(T) = $(n) - $(rank_val) = $(nullity)\$",
                sol("Answer", nullity)
            ),
            time = 90
        )
        
    else  # :transformation_matrix
        # Find matrix of a simple geometric transformation
        transformation_type = choice([:reflection_x, :reflection_y, :rotation_90, :projection_x])
        
        if transformation_type == :reflection_x
            matrix_str = "\\begin{bmatrix} 1 & 0 \\\\ 0 & -1 \\end{bmatrix}"
            description = "reflection across the x-axis"
        elseif transformation_type == :reflection_y
            matrix_str = "\\begin{bmatrix} -1 & 0 \\\\ 0 & 1 \\end{bmatrix}"
            description = "reflection across the y-axis"
        elseif transformation_type == :rotation_90
            matrix_str = "\\begin{bmatrix} 0 & -1 \\\\ 1 & 0 \\end{bmatrix}"
            description = "counterclockwise rotation by 90 degrees"
        else  # projection_x
            matrix_str = "\\begin{bmatrix} 1 & 0 \\\\ 0 & 0 \\end{bmatrix}"
            description = "projection onto the x-axis"
        end
        
        problem(
            question = "Find the matrix representation of the linear transformation \$T: \\mathbb{R}^2 \\to \\mathbb{R}^2\$ that represents $(description).",
            answer = matrix_str,
            difficulty = (1300, 1600),
            answer_type = "matrix",
            solution = steps(
                "To find the matrix, determine where the standard basis vectors map",
                "Apply the transformation to \$\\mathbf{e}_1 = \\begin{bmatrix} 1 \\\\ 0 \\end{bmatrix}\$ and \$\\mathbf{e}_2 = \\begin{bmatrix} 0 \\\\ 1 \\end{bmatrix}\$",
                "The columns of the matrix are \$T(\\mathbf{e}_1)\$ and \$T(\\mathbf{e}_2)\$",
                sol("Answer", matrix_str)
            ),
            time = 150
        )
    end
end