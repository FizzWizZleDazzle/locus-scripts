# linear_algebra - linear_independence (competition)
# Generated: 2026-03-08T21:12:57.991186

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z w begin
    set_topic!("linear_algebra/linear_independence")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Olympiad: Linear independence in polynomial spaces with constraints
        n = randint(4, 6)
        deg_bound = randint(n-1, n+1)
        
        # Create polynomials with specific structure
        coeffs = []
        for i in 1:n
            c = [randint(-5, 5) for _ in 1:(deg_bound+1)]
            push!(coeffs, c)
        end
        
        # Make them linearly dependent with non-trivial relation
        scalar = nonzero(-3, 3)
        coeffs[end] = scalar .* coeffs[1] .+ coeffs[2]
        
        polys_tex = []
        for c in coeffs
            terms = []
            for (i, coef) in enumerate(c)
                if coef != 0
                    deg = i - 1
                    if deg == 0
                        push!(terms, string(coef))
                    elseif deg == 1
                        push!(terms, coef == 1 ? "x" : coef == -1 ? "-x" : "$(coef)x")
                    else
                        push!(terms, coef == 1 ? "x^{$deg}" : coef == -1 ? "-x^{$deg}" : "$(coef)x^{$deg}")
                    end
                end
            end
            push!(polys_tex, join(terms, " + "))
        end
        
        problem(
            question="Consider the set of polynomials S = \\{p_1(x), p_2(x), ..., p_{$n}(x)\\} in ℙ_{$deg_bound} where:\n" *
                    join(["p_{$i}(x) = $(polys_tex[i])" for i in 1:n], "\n") *
                    "\n\nDetermine the dimension of span(S) and prove whether S is linearly independent.",
            answer=n-1,
            difficulty=(3500, 4200),
            solution=steps(
                "Express each polynomial as a vector in ℙ_{$deg_bound} with basis {1, x, x², ..., x^{$deg_bound}}",
                "Form the coefficient matrix and row reduce to find rank",
                "Observe that p_{$n}(x) = $(scalar)p_1(x) + p_2(x), establishing linear dependence",
                sol("Dimension of span(S)", n-1),
                "The set is linearly dependent with dimension $(n-1)"
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Characterizing all linear dependencies
        dim = randint(4, 5)
        num_vecs = dim + randint(2, 3)
        
        # Build vectors with designed dependencies
        basis_vecs = []
        for i in 1:dim
            v = zeros(Int, dim)
            v[i] = nonzero(-4, 4)
            for j in 1:dim
                if j != i
                    v[j] = randint(-3, 3)
                end
            end
            push!(basis_vecs, v)
        end
        
        all_vecs = copy(basis_vecs)
        relations = []
        for i in 1:(num_vecs - dim)
            # Create dependent vector
            coeffs = [nonzero(-2, 2) for _ in 1:min(3, dim)]
            indices = sort(rand(1:dim, min(3, dim)))
            new_vec = zeros(Int, dim)
            for (c, idx) in zip(coeffs, indices)
                new_vec .+= c .* basis_vecs[idx]
            end
            push!(all_vecs, new_vec)
            push!(relations, (coeffs, indices))
        end
        
        vecs_tex = [fmt_matrix(reshape(v, :, 1)) for v in all_vecs]
        
        problem(
            question="Let V = ℝ^{$dim} and consider vectors:\n" *
                    join(["v_{$i} = $(vecs_tex[i])" for i in 1:num_vecs], ", ") *
                    "\n\nFind all non-trivial linear dependence relations among these vectors. " *
                    "Express your answer as the dimension of the null space of the matrix [v_1 | v_2 | ... | v_{$num_vecs}].",
            answer=num_vecs - dim,
            difficulty=(3800, 4500),
            solution=steps(
                "Form the matrix A with columns v_1, ..., v_{$num_vecs}",
                "The dimension of null(A) equals $num_vecs - rank(A)",
                "By construction, exactly $dim vectors are linearly independent",
                sol("rank(A)", dim),
                sol("dim(null(A))", num_vecs - dim),
                "This means there are $(num_vecs - dim) linearly independent relations"
            ),
            time=360
        )
        
    elseif problem_type == 3
        # Olympiad: Linear independence with parameter
        n = randint(4, 5)
        param_position = randint(2, n-1)
        
        # Create vectors parametrized by λ
        vecs = []
        for i in 1:n
            v = [randint(-4, 4) for _ in 1:n]
            if i == param_position
                v[param_position] = 0  # Will be λ
            end
            push!(vecs, v)
        end
        
        # Calculate critical value
        critical_val = randint(-8, 8)
        
        vecs_tex = []
        for (i, v) in enumerate(vecs)
            if i == param_position
                v_display = copy(v)
                v_display[param_position] = "λ"
                push!(vecs_tex, "\\begin{pmatrix}" * join([string(x) for x in v_display], " \\\\ ") * "\\end{pmatrix}")
            else
                push!(vecs_tex, fmt_matrix(reshape(v, :, 1)))
            end
        end
        
        problem(
            question="Consider vectors in ℝ^{$n} parametrized by λ ∈ ℝ:\n" *
                    join(["v_{$i} = $(vecs_tex[i])" for i in 1:n], ", ") *
                    "\n\nFor how many values of λ is the set {v_1, v_2, ..., v_{$n}} linearly dependent?",
            answer=1,
            difficulty=(3600, 4300),
            solution=steps(
                "Form the matrix A(λ) = [v_1 | v_2 | ... | v_{$n}]",
                "The set is linearly dependent if and only if det(A(λ)) = 0",
                "Expanding the determinant yields a polynomial in λ",
                "Since A(λ) is $(n)×$(n) with λ appearing in exactly one entry, det(A(λ)) is linear in λ",
                "A non-zero linear polynomial has exactly one root",
                sol("Answer", 1)
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Research-adjacent: Functional linear independence
        funcs = ["1", "x", "x^2", "e^x"]
        n = length(funcs)
        
        problem(
            question="Prove that the functions f_1(x) = 1, f_2(x) = x, f_3(x) = x², f_4(x) = e^x " *
                    "are linearly independent on any interval [a, b]. " *
                    "What is the dimension of their span in C[a,b]?",
            answer=4,
            difficulty=(4000, 4800),
            solution=steps(
                "Suppose c_1(1) + c_2(x) + c_3(x²) + c_4(e^x) = 0 for all x ∈ [a,b]",
                "Taking derivatives: c_2 + 2c_3x + c_4e^x = 0",
                "Second derivative: 2c_3 + c_4e^x = 0",
                "Third derivative: c_4e^x = 0",
                "Since e^x ≠ 0, we have c_4 = 0, then c_3 = 0, then c_2 = 0, then c_1 = 0",
                "All coefficients must be zero, proving linear independence",
                sol("Dimension of span", 4)
            ),
            time=360
        )
        
    else  # problem_type == 5
        # Olympiad: Maximal linearly independent subset
        n = randint(6, 8)
        dim = randint(4, 5)
        
        # Create n vectors in R^dim where exactly dim are independent
        basis = []
        for i in 1:dim
            v = [randint(-5, 5) for _ in 1:dim]
            v[i] = nonzero(-8, 8)
            push!(basis, v)
        end
        
        all_vecs = copy(basis)
        for i in 1:(n-dim)
            # Linear combination of basis vectors
            coeffs = [nonzero(-3, 3) for _ in 1:min(2, dim)]
            indices = sort(rand(1:dim, min(2, dim)))
            new_vec = zeros(Int, dim)
            for (c, idx) in zip(coeffs, indices)
                new_vec .+= c .* basis[idx]
            end
            push!(all_vecs, new_vec)
        end
        
        vecs_tex = [fmt_matrix(reshape(v, :, 1)) for v in all_vecs]
        
        problem(
            question="Given vectors v_1, ..., v_{$n} in ℝ^{$dim}:\n" *
                    join(["v_{$i} = $(vecs_tex[i])" for i in 1:n], ", ") *
                    "\n\nWhat is the maximum size of a linearly independent subset of {v_1, ..., v_{$n}}?",
            answer=dim,
            difficulty=(3400, 4100),
            solution=steps(
                "The maximum size is bounded by the dimension of the ambient space: $dim",
                "Form the matrix A = [v_1 | v_2 | ... | v_{$n}]",
                "The maximum number of linearly independent vectors equals rank(A)",
                "Since the vectors live in ℝ^{$dim}, rank(A) ≤ $dim",
                "By inspection or row reduction, we can verify rank(A) = $dim",
                sol("Maximum size", dim)
            ),
            time=300
        )
    end
end