# linear_algebra - subspaces (very_hard)
# Generated: 2026-03-08T21:11:42.457964

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/subspaces")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Dimension of intersection of two subspaces (2500-3000)
        dim_U = rand(2:4)
        dim_V = rand(2:4)
        n = max(dim_U, dim_V) + rand(1:3)
        
        # By dimension formula: dim(U + V) = dim(U) + dim(V) - dim(U ∩ V)
        # We need dim(U + V) ≤ n
        max_sum_dim = n
        min_intersection = max(0, dim_U + dim_V - max_sum_dim)
        max_intersection = min(dim_U, dim_V)
        
        if min_intersection <= max_intersection
            dim_intersection = rand(min_intersection:max_intersection)
        else
            dim_intersection = min_intersection
        end
        
        dim_sum = dim_U + dim_V - dim_intersection
        
        question = "Let \\(U\\) and \\(V\\) be subspaces of \\(\\mathbb{R}^{$n}\\) with \\(\\dim(U) = $dim_U\\) and \\(\\dim(V) = $dim_V\\). If \\(\\dim(U + V) = $dim_sum\\), find \\(\\dim(U \\cap V)\\)."
        
        answer = dim_intersection
        
        solution = steps(
            "Use the dimension formula for subspaces: \\(\\dim(U + V) = \\dim(U) + \\dim(V) - \\dim(U \\cap V)\\)",
            "Substitute known values: \\($dim_sum = $dim_U + $dim_V - \\dim(U \\cap V)\\)",
            "Solve: \\(\\dim(U \\cap V) = $dim_U + $dim_V - $dim_sum = $dim_intersection\\)",
            sol("Answer", dim_intersection)
        )
        
        difficulty = (2500, 2800)
        time = 180
        
    elseif problem_type == 2
        # Characterizing a subspace via orthogonal complement (2800-3200)
        n = rand(4:6)
        k = rand(2:n-1)
        
        # Generate k random vectors in R^n
        vectors = []
        for i in 1:k
            v = [nonzero(-5, 5) for _ in 1:n]
            push!(vectors, v)
        end
        
        answer = n - k
        
        vec_str = join(["\\begin{pmatrix}" * join(v, "\\\\") * "\\end{pmatrix}" for v in vectors], ", ")
        
        question = "Let \\(V\\) be the subspace of \\(\\mathbb{R}^{$n}\\) spanned by the vectors " * vec_str * ". Assume these vectors are linearly independent. What is \\(\\dim(V^\\perp)\\), the dimension of the orthogonal complement of \\(V\\)?"
        
        solution = steps(
            "Given that \\(V\\) is spanned by $k linearly independent vectors in \\(\\mathbb{R}^{$n}\\)",
            "Therefore \\(\\dim(V) = $k\\)",
            "For any subspace \\(V \\subseteq \\mathbb{R}^{$n}\\), we have \\(\\dim(V) + \\dim(V^\\perp) = $n\\)",
            "Thus \\(\\dim(V^\\perp) = $n - $k = $answer\\)",
            sol("Answer", answer)
        )
        
        difficulty = (2800, 3200)
        time = 240
        
    elseif problem_type == 3
        # Minimal spanning set for sum of subspaces (3000-3400)
        n = rand(5:7)
        dim_U = rand(2:n-2)
        dim_V = rand(2:n-2)
        
        # Ensure dim(U ∩ V) is well-defined
        dim_intersection = rand(max(0, dim_U + dim_V - n):min(dim_U, dim_V))
        dim_sum = dim_U + dim_V - dim_intersection
        
        basis_U_only = dim_U - dim_intersection
        basis_V_only = dim_V - dim_intersection
        
        answer = dim_sum
        
        question = "Let \\(U\\) and \\(V\\) be subspaces of \\(\\mathbb{R}^{$n}\\) with \\(\\dim(U) = $dim_U\\), \\(\\dim(V) = $dim_V\\), and \\(\\dim(U \\cap V) = $dim_intersection\\). What is the minimum number of vectors needed to span \\(U + V\\)?"
        
        solution = steps(
            "The minimum number of vectors to span a subspace equals its dimension",
            "Use the dimension formula: \\(\\dim(U + V) = \\dim(U) + \\dim(V) - \\dim(U \\cap V)\\)",
            "Calculate: \\(\\dim(U + V) = $dim_U + $dim_V - $dim_intersection = $dim_sum\\)",
            "Therefore, we need exactly $answer vectors",
            sol("Answer", answer)
        )
        
        difficulty = (3000, 3400)
        time = 270
        
    else
        # Subspace defined by linear constraints - find dimension (2600-3100)
        n = rand(5:8)
        num_constraints = rand(2:min(4, n-1))
        
        # Generate random constraint equations (assuming they're linearly independent)
        constraints = []
        for i in 1:num_constraints
            coeffs = [randint(-4, 4) for _ in 1:n]
            push!(constraints, coeffs)
        end
        
        answer = n - num_constraints
        
        var_names = ["x_$i" for i in 1:n]
        constraint_strs = []
        for c in constraints
            terms = []
            for (i, coef) in enumerate(c)
                if coef != 0
                    if coef == 1
                        push!(terms, var_names[i])
                    elseif coef == -1
                        push!(terms, "-" * var_names[i])
                    else
                        push!(terms, string(coef) * var_names[i])
                    end
                end
            end
            if !isempty(terms)
                push!(constraint_strs, join(terms, " + ") * " = 0")
            end
        end
        
        question = "Let \\(W\\) be the subspace of \\(\\mathbb{R}^{$n}\\) consisting of all vectors \\(($(join(var_names, ", ")))\\) satisfying the following $num_constraints linearly independent equations:\n" * join(["\\[" * s * "\\]" for s in constraint_strs], "\n") * "\nWhat is \\(\\dim(W)\\)?"
        
        solution = steps(
            "The subspace \\(W\\) is the null space (kernel) of the coefficient matrix",
            "We have $num_constraints linearly independent constraint equations in \\(\\mathbb{R}^{$n}\\)",
            "By the rank-nullity theorem: \\(\\dim(W) = n - \\text{rank}(A)\\) where \\(A\\) is the coefficient matrix",
            "Since the constraints are linearly independent, \\(\\text{rank}(A) = $num_constraints\\)",
            "Therefore \\(\\dim(W) = $n - $num_constraints = $answer\\)",
            sol("Answer", answer)
        )
        
        difficulty = (2600, 3100)
        time = 240
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution,
        time=time
    )
end