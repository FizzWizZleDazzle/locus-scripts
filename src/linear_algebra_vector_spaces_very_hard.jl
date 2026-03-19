# linear_algebra - vector_spaces (very_hard)
# Generated: 2026-03-08T21:10:56.142276

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/vector_spaces")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Dimension and basis of polynomial space with constraints
        max_degree = rand(3:6)
        constraint_type = choice(["even", "odd", "divisible", "coefficient_zero"])
        
        if constraint_type == "even"
            condition = "even powers only"
            dimension = max_degree ÷ 2 + 1
            basis_desc = "\\{1, x^2, x^4, \\ldots, x^{$(2*(dimension-1))}\\}"
        elseif constraint_type == "odd"
            condition = "odd powers only"
            dimension = (max_degree + 1) ÷ 2
            basis_desc = "\\{x, x^3, x^5, \\ldots, x^{$(2*dimension-1)}\\}"
        elseif constraint_type == "divisible"
            k = rand(2:3)
            condition = "powers divisible by $k"
            dimension = max_degree ÷ k + 1
            basis_desc = "\\{1, x^{$k}, x^{$(2k)}, \\ldots, x^{$(k*(dimension-1))}\\}"
        else
            coeff_pos = rand(1:max_degree-1)
            condition = "coefficient of x^{$coeff_pos} equals zero"
            dimension = max_degree + 1 - 1
            basis_elems = ["1"]
            for i in 1:max_degree
                if i != coeff_pos
                    push!(basis_elems, "x^{$i}")
                end
            end
            basis_desc = "\\{" * join(basis_elems, ", ") * "\\}"
        end
        
        problem(
            question = "Let V be the vector space of all polynomials of degree at most $max_degree with real coefficients satisfying the condition: $condition. Find the dimension of V.",
            answer = dimension,
            difficulty = (2500, 3000),
            solution = steps(
                "The subspace V consists of polynomials p(x) = a_0 + a_1 x + \\cdots + a_{$max_degree} x^{$max_degree} with the given constraint",
                "Count the number of free coefficients after applying the constraint",
                "A basis for V is: $basis_desc",
                sol("Dimension", dimension)
            ),
            time = 240
        )
        
    elseif problem_type == 2
        # Linear independence in matrix space with trace and symmetry conditions
        n = rand(2:3)
        
        # Generate random symmetric matrices that are linearly independent
        num_matrices = rand(3:5)
        
        question_text = "Consider the following matrices in M_{$n×$n}(\\mathbb{R}):\n\n"
        for i in 1:num_matrices
            mat_entries = []
            for row in 1:n
                row_entries = []
                for col in 1:n
                    if row <= col
                        entry = randint(-3, 3)
                        push!(row_entries, entry)
                    else
                        push!(row_entries, mat_entries[col][row])
                    end
                end
                push!(mat_entries, row_entries)
            end
            
            mat_str = "\\begin{pmatrix}"
            for row in 1:n
                mat_str *= join(mat_entries[row], " & ")
                if row < n
                    mat_str *= " \\\\ "
                end
            end
            mat_str *= "\\end{pmatrix}"
            question_text *= "A_$i = $mat_str" * (i < num_matrices ? ",\\quad " : "")
        end
        
        question_text *= "\n\nLet W be the subspace of M_{$n×$n}(\\mathbb{R}) consisting of all symmetric matrices with trace zero. What is the dimension of W?"
        
        # Dimension = n(n+1)/2 - 1 (symmetric gives n(n+1)/2, trace=0 removes 1 degree of freedom)
        dim_answer = n*(n+1)÷2 - 1
        
        problem(
            question = question_text,
            answer = dim_answer,
            difficulty = (2700, 3200),
            solution = steps(
                "A symmetric n×n matrix has n(n+1)/2 independent entries (diagonal + upper triangular)",
                "For n=$n, this gives $(n*(n+1)÷2) degrees of freedom",
                "The trace condition tr(A) = 0 imposes one linear constraint on the diagonal elements",
                "Therefore dimension = $(n*(n+1)÷2) - 1",
                sol("dim(W)", dim_answer)
            ),
            time = 300
        )
        
    elseif problem_type == 3
        # Intersection of subspaces defined by linear functionals
        dim = rand(4:6)
        num_functionals = rand(2:3)
        
        # Generate linearly independent functionals
        coeffs_list = []
        for i in 1:num_functionals
            coeffs = [randint(-2, 2) for _ in 1:dim]
            while sum(abs.(coeffs)) == 0 || any([dot(coeffs, c) == 0 && coeffs != c for c in coeffs_list])
                coeffs = [randint(-2, 2) for _ in 1:dim]
            end
            push!(coeffs_list, coeffs)
        end
        
        vars = ["x_$i" for i in 1:dim]
        equations = []
        for (idx, coeffs) in enumerate(coeffs_list)
            terms = []
            for (i, c) in enumerate(coeffs)
                if c != 0
                    if c == 1
                        push!(terms, vars[i])
                    elseif c == -1
                        push!(terms, "-" * vars[i])
                    else
                        push!(terms, "$(c)$(vars[i])")
                    end
                end
            end
            push!(equations, join(terms, " + ") * " = 0")
        end
        
        question_text = "Let V = \\mathbb{R}^{$dim} and let W be the subspace defined by the intersection of the kernels of the following linear functionals:\n\n"
        for (i, eq) in enumerate(equations)
            question_text *= eq * (i < length(equations) ? ",\\quad " : "")
        end
        question_text *= "\n\nFind dim(W)."
        
        dim_answer = dim - num_functionals
        
        problem(
            question = question_text,
            answer = dim_answer,
            difficulty = (2600, 3100),
            solution = steps(
                "W is the intersection of $num_functionals kernels of linearly independent functionals",
                "Each functional has kernel of dimension $(dim-1) in \\mathbb{R}^{$dim}",
                "The intersection has codimension equal to the number of independent constraints",
                "By the rank-nullity theorem applied to the system: dim(W) = $dim - $num_functionals",
                sol("dim(W)", dim_answer)
            ),
            time = 270
        )
        
    elseif problem_type == 4
        # Direct sum decomposition
        n = rand(3:5)
        
        # Create two complementary subspaces
        k = rand(1:n-1)
        
        condition1 = "x_$(k+1) = x_$(k+2) = \\cdots = x_$n = 0"
        condition2 = "x_1 = x_2 = \\cdots = x_$k = 0"
        
        question_text = "Let V = \\mathbb{R}^{$n}. Define subspaces:\n\n"
        question_text *= "U = \\{(x_1, \\ldots, x_$n) \\in V : $condition1\\}\n\n"
        question_text *= "W = \\{(x_1, \\ldots, x_$n) \\in V : $condition2\\}\n\n"
        question_text *= "Prove that V = U \\oplus W and find dim(U) + dim(W)."
        
        answer_val = n
        
        problem(
            question = question_text,
            answer = answer_val,
            difficulty = (2400, 2900),
            solution = steps(
                "U consists of vectors with first $k components free: dim(U) = $k",
                "W consists of vectors with last $(n-k) components free: dim(W) = $(n-k)",
                "U ∩ W = {0} since any vector in both must have all components zero",
                "Every v ∈ V can be uniquely written as u + w where u ∈ U and w ∈ W",
                "Therefore V = U ⊕ W and dim(U) + dim(W) = $k + $(n-k)",
                sol("Answer", answer_val)
            ),
            time = 300
        )
        
    else
        # Quotient space dimension
        n = rand(4:7)
        codim = rand(2:n-1)
        
        num_constraints = codim
        
        equations = []
        for i in 1:num_constraints
            coeffs = [randint(-2, 2) for _ in 1:n]
            while sum(abs.(coeffs)) <= 1
                coeffs = [randint(-2, 2) for _ in 1:n]
            end
            
            terms = []
            for (j, c) in enumerate(coeffs)
                if c != 0
                    var = "x_$j"
                    if c == 1
                        push!(terms, var)
                    elseif c == -1
                        push!(terms, "-" * var)
                    else
                        push!(terms, "$(c)$var")
                    end
                end
            end
            push!(equations, join(terms, " + ") * " = 0")
        end
        
        question_text = "Let V = \\mathbb{R}^{$n} and let W be the subspace of V defined by:\n\n"
        for eq in equations
            question_text *= eq * "\n\n"
        end
        question_text *= "Assuming these equations are linearly independent, find dim(V/W)."
        
        answer_val = codim
        
        problem(
            question = question_text,
            answer = answer_val,
            difficulty = (2800, 3400),
            solution = steps(
                "The quotient space V/W has dimension equal to the codimension of W in V",
                "W is defined by $num_constraints linearly independent equations",
                "By rank-nullity: dim(W) = $n - $num_constraints = $(n - codim)",
                "Therefore: codim(W) = dim(V) - dim(W) = $n - $(n - codim)",
                sol("dim(V/W)", answer_val)
            ),
            time = 300
        )
    end
end