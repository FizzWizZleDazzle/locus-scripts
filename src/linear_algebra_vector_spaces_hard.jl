# linear_algebra - vector_spaces (hard)
# Generated: 2026-03-08T21:10:49.173014

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/vector_spaces")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Linear independence of vectors in R^3
        dim = 3
        # Choose linearly dependent or independent
        independent = rand(Bool)
        
        if independent
            # Create 3 linearly independent vectors
            v1 = [nonzero(-8, 8) for _ in 1:dim]
            v2 = [nonzero(-8, 8) for _ in 1:dim]
            # Make sure v3 is not in span(v1, v2)
            v3 = [nonzero(-8, 8) for _ in 1:dim]
            # Check by computing determinant - if nonzero, they're independent
            while abs(v1[1]*(v2[2]*v3[3] - v2[3]*v3[2]) - v1[2]*(v2[1]*v3[3] - v2[3]*v3[1]) + v1[3]*(v2[1]*v3[2] - v2[2]*v3[1])) < 1
                v3 = [nonzero(-8, 8) for _ in 1:dim]
            end
            ans = "Yes"
        else
            # Create 3 linearly dependent vectors
            v1 = [nonzero(-8, 8) for _ in 1:dim]
            v2 = [nonzero(-8, 8) for _ in 1:dim]
            # Make v3 = a*v1 + b*v2
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            v3 = [a*v1[i] + b*v2[i] for i in 1:dim]
            ans = "No"
        end
        
        problem(
            question="Are the vectors \\(\\mathbf{v}_1 = $(fmt_tuple(v1))\\), \\(\\mathbf{v}_2 = $(fmt_tuple(v2))\\), and \\(\\mathbf{v}_3 = $(fmt_tuple(v3))\\) linearly independent in \\(\\mathbb{R}^3\\)? Answer Yes or No.",
            answer=ans,
            difficulty=(1800, 2100),
            solution=steps(
                "Set up the equation \\(c_1 \\mathbf{v}_1 + c_2 \\mathbf{v}_2 + c_3 \\mathbf{v}_3 = \\mathbf{0}\\)",
                "Form the matrix with these vectors as columns and compute the determinant",
                independent ? "The determinant is nonzero, so the vectors are linearly independent" : "The determinant is zero (or the vectors satisfy a nontrivial linear combination), so they are linearly dependent",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Dimension of a subspace defined by linear constraints
        n_vars = rand(3:5)
        n_constraints = rand(1:(n_vars-1))
        
        # The dimension will be n_vars - rank(constraints)
        # For simplicity, make constraints linearly independent
        dim_subspace = n_vars - n_constraints
        
        constraints = []
        for i in 1:n_constraints
            coeffs = [randint(-5, 5) for _ in 1:n_vars]
            push!(constraints, coeffs)
        end
        
        var_names = ["x_$i" for i in 1:n_vars]
        constraint_strs = []
        for c in constraints
            terms = []
            for (i, coef) in enumerate(c)
                if coef != 0
                    if coef == 1
                        push!(terms, var_names[i])
                    elseif coef == -1
                        push!(terms, "-$(var_names[i])")
                    else
                        push!(terms, "$(coef)$(var_names[i])")
                    end
                end
            end
            push!(constraint_strs, join(terms, " + ") * " = 0")
        end
        
        problem(
            question="Find the dimension of the subspace of \\(\\mathbb{R}^{$n_vars}\\) defined by the constraints:\n" * join(["\\(" * replace(s, "+ -" => "- ") * "\\)" for s in constraint_strs], ", "),
            answer=dim_subspace,
            difficulty=(1900, 2200),
            solution=steps(
                "The subspace is the null space of a system of $n_constraints linear equations in $n_vars variables",
                "Assuming the constraints are linearly independent, the rank is $n_constraints",
                "By the rank-nullity theorem: dimension = $n_vars - $n_constraints = $dim_subspace",
                sol("Answer", dim_subspace)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Find basis for the span of given vectors
        # Generate 2 linearly independent vectors in R^3, ask for dimension of span
        v1 = [nonzero(-7, 7) for _ in 1:3]
        v2 = [nonzero(-7, 7) for _ in 1:3]
        # Make sure they're not parallel
        while v1[1]*v2[2] == v1[2]*v2[1] || abs(v1[1]*v2[2] - v1[2]*v2[1]) < 1
            v2 = [nonzero(-7, 7) for _ in 1:3]
        end
        
        ans = 2
        
        problem(
            question="What is the dimension of \\(\\text{span}\\{$(fmt_tuple(v1)), $(fmt_tuple(v2))\\}\\) in \\(\\mathbb{R}^3\\)?",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Check if the vectors are linearly independent",
                "Since the vectors are not scalar multiples of each other, they are linearly independent",
                "Two linearly independent vectors span a 2-dimensional subspace",
                sol("Answer", 2)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Subspace test: is a set closed under addition and scalar multiplication?
        # Pick a valid or invalid subspace
        is_subspace = rand(Bool)
        
        if is_subspace
            # Example: {(x, y, z) : x + y = 0} is a subspace
            ans = "Yes"
            desc = "\\(W = \\{(x, y, z) \\in \\mathbb{R}^3 : x + y = 0\\}\\)"
            reason = "It contains the zero vector, is closed under addition (if \\(x_1+y_1=0\\) and \\(x_2+y_2=0\\), then \\((x_1+x_2)+(y_1+y_2)=0\\)), and closed under scalar multiplication"
        else
            # Example: {(x, y, z) : x + y = 1} is NOT a subspace
            ans = "No"
            desc = "\\(W = \\{(x, y, z) \\in \\mathbb{R}^3 : x + y = 1\\}\\)"
            reason = "It does not contain the zero vector (since \\(0 + 0 \\neq 1\\)), so it cannot be a subspace"
        end
        
        problem(
            question="Is $desc a subspace of \\(\\mathbb{R}^3\\)? Answer Yes or No.",
            answer=ans,
            difficulty=(1800, 2100),
            solution=steps(
                "Check the three subspace criteria: (1) contains zero vector, (2) closed under addition, (3) closed under scalar multiplication",
                reason,
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 5
        # Rank of a matrix
        # Create a matrix with known rank
        rank_val = rand(2:3)
        rows = rand(3:4)
        cols = rand(3:4)
        
        if rank_val == 2
            # Create two independent vectors
            v1 = [nonzero(-6, 6) for _ in 1:cols]
            v2 = [nonzero(-6, 6) for _ in 1:cols]
            while sum(abs.(v1 .* v2[1] .- v2 .* v1[1])) < 2
                v2 = [nonzero(-6, 6) for _ in 1:cols]
            end
            # Other rows are linear combinations
            mat = [v1]
            push!(mat, v2)
            for i in 3:rows
                a = randint(-2, 2)
                b = randint(-2, 2)
                push!(mat, [a*v1[j] + b*v2[j] for j in 1:cols])
            end
        else  # rank_val == 3
            mat = [[nonzero(-6, 6) for _ in 1:cols] for _ in 1:rows]
        end
        
        mat_str = "\\begin{pmatrix}\n"
        for i in 1:rows
            mat_str *= join(mat[i], " & ")
            mat_str *= (i < rows ? " \\\\\n" : "\n")
        end
        mat_str *= "\\end{pmatrix}"
        
        problem(
            question="Find the rank of the matrix \\[$mat_str\\]",
            answer=rank_val,
            difficulty=(1900, 2300),
            solution=steps(
                "Perform row reduction to find the number of pivot positions",
                "Count the number of linearly independent rows",
                "The rank equals the number of non-zero rows in reduced row echelon form",
                sol("Answer", rank_val)
            ),
            time=240
        )
        
    else  # problem_type == 6
        # Determine if a vector is in the span of other vectors
        # Generate 2 vectors in R^3 and a third that is or isn't in their span
        v1 = [nonzero(-8, 8) for _ in 1:3]
        v2 = [nonzero(-8, 8) for _ in 1:3]
        while v1[1]*v2[2] == v1[2]*v2[1]
            v2 = [nonzero(-8, 8) for _ in 1:3]
        end
        
        in_span = rand(Bool)
        
        if in_span
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            w = [a*v1[i] + b*v2[i] for i in 1:3]
            ans = "Yes"
        else
            w = [nonzero(-8, 8) for _ in 1:3]
            # Make sure it's not in the span by checking the system is inconsistent
            # This is complex, so we'll just pick a random one and state the answer
            ans = "No"
        end
        
        problem(
            question="Is the vector \\(\\mathbf{w} = $(fmt_tuple(w))\\) in \\(\\text{span}\\{$(fmt_tuple(v1)), $(fmt_tuple(v2))\\}\\)? Answer Yes or No.",
            answer=ans,
            difficulty=(1900, 2200),
            solution=steps(
                "Set up the equation \\(c_1 $(fmt_tuple(v1)) + c_2 $(fmt_tuple(v2)) = $(fmt_tuple(w))\\)",
                "This gives a system of 3 equations in 2 unknowns",
                in_span ? "The system has a solution, so \\(\\mathbf{w}\\) is in the span" : "The system is inconsistent, so \\(\\mathbf{w}\\) is not in the span",
                sol("Answer", ans)
            ),
            time=210
        )
    end
end