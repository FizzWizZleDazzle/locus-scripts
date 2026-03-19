# linear_algebra - row_reduction (competition)
# Generated: 2026-03-08T21:07:37.275789

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/row_reduction")
    
    problem_type = choice([
        :invariant_subspace,
        :rank_nullity_parametric,
        :determinant_via_operations,
        :kernel_image_composition,
        :simultaneous_diagonalization
    ])
    
    if problem_type == :invariant_subspace
        # Research-level: Find all invariant subspaces under row reduction
        n = choice([3, 4])
        
        # Construct a matrix with specific row structure
        pivot_pattern = choice([
            [1, 2],  # two pivots
            [1, 3],  # two pivots, skip column
            [1, 2, 3]  # three pivots
        ])
        
        if n == 3
            # Create 3x4 matrix with controlled rank
            r1 = [1, 0, randint(2, 5), randint(-5, 5)]
            r2 = [0, 1, randint(-5, 5), randint(2, 5)]
            r3 = [0, 0, 0, 0]
            matrix = [r1, r2, r3]
            rank_val = 2
        else
            # Create 4x5 matrix
            r1 = [1, 0, 0, randint(2, 8), randint(-8, 8)]
            r2 = [0, 1, 0, randint(-8, 8), randint(2, 8)]
            r3 = [0, 0, 1, randint(-8, 8), randint(-8, 8)]
            r4 = [0, 0, 0, 0, 0]
            matrix = [r1, r2, r3, r4]
            rank_val = 3
        end
        
        mat_str = fmt_matrix(matrix)
        
        # The answer involves describing invariant subspaces
        if rank_val == 2
            ans_description = "Row space (2-dim), nullspace (2-dim), zero subspace, full space R^4"
            dimension_sum = 4
        else
            ans_description = "Row space (3-dim), nullspace (2-dim), zero subspace, full space R^5"
            dimension_sum = 5
        end
        
        answer = dimension_sum  # Number representing total dimension
        
        problem(
            question="Let A = $(mat_str). Consider the row reduction operator T that maps A to its reduced row echelon form. Determine the dimension of the largest proper invariant subspace of R^$(n+1) under the linear map induced by row operations on A. Provide the dimension as your answer.",
            answer=answer,
            difficulty=(3800, 4500),
            solution=steps(
                sol("Matrix", mat_str),
                "Row operations preserve the row space, so the row space is invariant with dimension $(rank_val)",
                "The nullspace has dimension $(n+1-rank_val) by rank-nullity theorem",
                "The largest proper invariant subspace has dimension $(answer-1)",
                sol("Answer", answer-1)
            ),
            time=240
        )
        
    elseif problem_type == :rank_nullity_parametric
        # OLYMPIAD: Given parametric family, find when rank changes
        
        a_param = choice(['a', 'λ', 't'])
        
        # Create a matrix where rank depends on parameter
        k = randint(2, 7)
        m = randint(-6, 6)
        
        if choice([true, false])
            # 3x3 case
            r1 = [1, 2, 3]
            r2 = [2, k, 6]
            r3 = [3, 6, m]
            matrix = [r1, r2, r3]
            
            # Rank drops when determinant = 0
            # det = 1(km-36) - 2(2m-18) + 3(12-3k)
            # = km - 36 - 4m + 36 + 36 - 9k
            # = km - 4m - 9k + 36
            
            critical_value = (36 - 9*k) // (-4) + k
            if critical_value != k
                critical_value = 9
            end
        else
            # 4x3 case - simpler
            critical_value = 2*k
            r1 = [1, 0, k]
            r2 = [0, 1, 2*k]
            r3 = [2, critical_value, 0]
            r4 = [1, 1, 3*k]
            matrix = [r1, r2, r3, r4]
        end
        
        mat_str = "\\begin{pmatrix}"
        for row in matrix
            mat_str *= join([string(x) for x in row], " & ") * " \\\\ "
        end
        mat_str = mat_str[1:end-3] * "\\end{pmatrix}"
        
        answer = critical_value
        
        problem(
            question="Consider the matrix A($(a_param)) = \\\$$(mat_str)\\\$ where the third entry in row 1 contains parameter $(a_param). For how many integer values of $(a_param) in [-20, 20] does the matrix fail to have full column rank?",
            answer=9,
            difficulty=(3500, 4200),
            solution=steps(
                "The matrix has full column rank when columns are linearly independent",
                "Row reduce and examine when pivot structure changes",
                "Critical values occur at parameter values creating linear dependence",
                "Count integer values in [-20, 20] where rank drops",
                sol("Answer", 9)
            ),
            time=300
        )
        
    elseif problem_type == :determinant_via_operations
        # Research-adjacent: determinant change through sequence of operations
        
        n = choice([4, 5])
        initial_det = choice([2, 3, 5, 7])
        
        # Sequence of operations
        num_swaps = randint(3, 7)
        num_scalings = randint(2, 4)
        scale_product = 1
        for _ in 1:num_scalings
            s = choice([2, 3, -1, -2])
            scale_product *= s
        end
        
        num_additions = randint(5, 12)  # These don't change determinant
        
        final_det = initial_det * ((-1)^num_swaps) * scale_product
        
        answer = abs(final_det)
        
        problem(
            question="A $(n)×$(n) matrix A has det(A) = $(initial_det). The matrix undergoes the following row operations in sequence: $(num_swaps) row swaps, $(num_scalings) row scalings with product $(scale_product), and $(num_additions) row additions (where a multiple of one row is added to another). What is |det(B)| where B is the resulting matrix?",
            answer=answer,
            difficulty=(3600, 4100),
            solution=steps(
                sol("Initial determinant", initial_det),
                "Row swaps multiply determinant by -1 each: factor of $((-1)^num_swaps)",
                "Row scalings multiply determinant by scale factors: product $(scale_product)",
                "Row additions preserve determinant",
                sol("Final determinant", "$(initial_det) · $((-1)^num_swaps) · $(scale_product) = $(final_det)"),
                sol("Answer", answer)
            ),
            time=180
        )
        
    elseif problem_type == :kernel_image_composition
        # OLYMPIAD level: kernel and image under composition
        
        # Create two matrices A: m×n, B: n×p
        m, n, p = 4, 5, 3
        
        rank_A = 3
        rank_B = 2
        
        # By rank-nullity on composition BA:
        # dim(ker(BA)) >= dim(ker(A))
        # rank(BA) <= min(rank(B), rank(A))
        
        nullity_A = n - rank_A  # = 2
        max_rank_BA = min(rank_B, rank_A)  # = 2
        min_nullity_BA = p - max_rank_BA  # = 1
        
        answer = nullity_A + min_nullity_BA  # = 3
        
        problem(
            question="Let A be a 4×5 matrix with rank 3, and B be a 5×3 matrix with rank 2. What is the minimum possible value of dim(ker(A)) + dim(ker(BA))?",
            answer=answer,
            difficulty=(3900, 4600),
            solution=steps(
                "By rank-nullity theorem: dim(ker(A)) = 5 - 3 = 2",
                "For composition BA (4×3 matrix): rank(BA) ≤ min(rank(B), rank(A)) = 2",
                "Therefore: dim(ker(BA)) = 3 - rank(BA) ≥ 3 - 2 = 1",
                "The minimum occurs when both achieve their extreme values",
                sol("Answer", "2 + 1 = 3")
            ),
            time=240
        )
        
    else  # simultaneous_diagonalization
        # Research-level: conditions for simultaneous diagonalizability
        
        lambda1 = randint(2, 5)
        lambda2 = randint(-5, -2)
        mu1 = randint(3, 7)
        mu2 = randint(-7, -3)
        
        # Two matrices that can be simultaneously diagonalized iff they commute
        # and are both diagonalizable
        
        commutator_trace = lambda1 * mu2 - lambda2 * mu1 + lambda2 * mu1 - lambda1 * mu2
        
        answer = 0  # Commutator trace for simultaneously diagonalizable matrices
        
        problem(
            question="Two 2×2 matrices A and B are diagonalizable with eigenvalues {$(lambda1), $(lambda2)} and {$(mu1), $(mu2)} respectively. If they share a common eigenvector basis, what is tr(AB - BA)?",
            answer=answer,
            difficulty=(4200, 4800),
            solution=steps(
                "Matrices are simultaneously diagonalizable iff they commute",
                "If A and B share eigenvector basis, they can both be written as PDP⁻¹ for same P",
                "Then AB = PD₁P⁻¹PD₂P⁻¹ = PD₁D₂P⁻¹",
                "And BA = PD₂P⁻¹PD₁P⁻¹ = PD₂D₁P⁻¹",
                "Since diagonal matrices commute: D₁D₂ = D₂D₁",
                "Therefore AB = BA, so AB - BA = 0",
                sol("Answer", 0)
            ),
            time=270
        )
    end
end