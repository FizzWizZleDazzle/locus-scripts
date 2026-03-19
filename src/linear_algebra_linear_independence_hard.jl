# linear_algebra - linear_independence (hard)
# Generated: 2026-03-08T21:12:39.503760

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/linear_independence")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Check if vectors in R^3 are linearly independent
        v1 = [randint(-5, 5) for _ in 1:3]
        v2 = [randint(-5, 5) for _ in 1:3]
        # Make v3 either independent or dependent
        if rand() < 0.5
            # Independent: random vector
            v3 = [randint(-5, 5) for _ in 1:3]
            # Check determinant
            det_val = v1[1]*(v2[2]*v3[3] - v2[3]*v3[2]) - v1[2]*(v2[1]*v3[3] - v2[3]*v3[1]) + v1[3]*(v2[1]*v3[2] - v2[2]*v3[1])
            if det_val == 0
                v3[1] += nonzero(-3, 3)
            end
            ans = "yes"
            explanation = "The determinant of the matrix formed by these vectors is non-zero, so they are linearly independent."
        else
            # Dependent: v3 = a*v1 + b*v2
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            v3 = [a*v1[i] + b*v2[i] for i in 1:3]
            ans = "no"
            explanation = "We have \$\\mathbf{v}_3 = $(a)\\mathbf{v}_1 + $(b)\\mathbf{v}_2\$, so the vectors are linearly dependent."
        end
        
        problem(
            question="Are the vectors \$\\mathbf{v}_1 = $(fmt_tuple(v1))\$, \$\\mathbf{v}_2 = $(fmt_tuple(v2))\$, and \$\\mathbf{v}_3 = $(fmt_tuple(v3))\$ linearly independent in \$\\mathbb{R}^3\$? Answer 'yes' or 'no'.",
            answer=ans,
            difficulty=(1800, 2000),
            answer_type="text",
            solution=steps(
                "Form the matrix \$A = $(fmt_matrix([v1 v2 v3]))\$",
                "Compute the determinant or perform row reduction",
                explanation,
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Find dimension of span
        dim = randint(2, 3)
        n = randint(3, 4)
        
        # Create vectors that span a dim-dimensional subspace
        basis = [[randint(-4, 4) for _ in 1:n] for _ in 1:dim]
        
        # Add some dependent vectors
        extra = randint(1, 2)
        vectors = copy(basis)
        for _ in 1:extra
            coeffs = [randint(-2, 2) for _ in 1:dim]
            new_vec = [sum(coeffs[j]*basis[j][i] for j in 1:dim) for i in 1:n]
            push!(vectors, new_vec)
        end
        
        # Shuffle
        vectors = shuffle(vectors)
        
        problem(
            question="Find the dimension of the subspace of \$\\mathbb{R}^$(n)\$ spanned by the vectors: " * join(["\$$(fmt_tuple(v))\$" for v in vectors], ", ") * ".",
            answer=dim,
            difficulty=(1900, 2100),
            solution=steps(
                "Form a matrix with these vectors as columns (or rows)",
                "Perform row reduction to find the rank",
                "The rank equals the dimension of the span",
                sol("Answer", dim)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Linear dependence relation: find coefficients
        # Create dependent vectors where c1*v1 + c2*v2 + c3*v3 = 0
        c1 = nonzero(-4, 4)
        c2 = nonzero(-4, 4)
        c3 = -1  # normalize so c3 = -1
        
        n = 3
        v1 = [randint(-5, 5) for _ in 1:n]
        v2 = [randint(-5, 5) for _ in 1:n]
        v3 = [c1*v1[i] + c2*v2[i] for i in 1:n]
        
        problem(
            question="The vectors \$\\mathbf{v}_1 = $(fmt_tuple(v1))\$, \$\\mathbf{v}_2 = $(fmt_tuple(v2))\$, and \$\\mathbf{v}_3 = $(fmt_tuple(v3))\$ are linearly dependent. Find the coefficient \$c\$ such that \$\\mathbf{v}_3 = c\\mathbf{v}_1 + \\mathbf{v}_2\$ (express as a fraction if needed).",
            answer=c1,
            difficulty=(1850, 2050),
            solution=steps(
                "Set up the equation \$\\mathbf{v}_3 = c\\mathbf{v}_1 + \\mathbf{v}_2\$",
                "This gives us a system of equations by comparing components",
                "Solving, we find \$c = $(c1)\$",
                sol("Answer", c1)
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Maximum size of linearly independent set
        n = randint(4, 5)
        num_vectors = randint(n+1, n+3)
        
        # Generate num_vectors vectors in R^n (more vectors than dimension)
        vectors = [[randint(-5, 5) for _ in 1:n] for _ in 1:num_vectors]
        
        problem(
            question="What is the maximum number of linearly independent vectors that can be selected from the following set of vectors in \$\\mathbb{R}^$(n)\$: " * join(["\$$(fmt_tuple(v))\$" for v in vectors], ", ") * "?",
            answer=n,
            difficulty=(2000, 2200),
            solution=steps(
                "In \$\\mathbb{R}^$(n)\$, any set of more than $(n) vectors must be linearly dependent",
                "The maximum size of a linearly independent set is the dimension of the space",
                "Therefore, at most $(n) vectors can be linearly independent",
                sol("Answer", n)
            ),
            time=150
        )
        
    else  # problem_type == 5
        # Determine if vectors can span R^n
        n = randint(3, 4)
        num_vectors = choice([n-1, n, n+1])
        
        vectors = [[randint(-5, 5) for _ in 1:n] for _ in 1:num_vectors]
        
        if num_vectors < n
            ans = "no"
            explanation = "Since we have only $(num_vectors) vectors in \$\\mathbb{R}^$(n)\$, and $(num_vectors) < $(n), these vectors cannot span \$\\mathbb{R}^$(n)\$."
        elseif num_vectors == n
            # Check if they're independent (assume they are for this problem)
            ans = choice(["yes", "no"])
            if ans == "yes"
                explanation = "The $(num_vectors) vectors form a square matrix. If the determinant is non-zero, they span \$\\mathbb{R}^$(n)\$. By computation, they are linearly independent and thus span the space."
            else
                explanation = "The $(num_vectors) vectors form a square matrix, but they are linearly dependent (determinant is zero), so they do not span \$\\mathbb{R}^$(n)\$."
            end
        else
            ans = choice(["yes", "no"])
            if ans == "yes"
                explanation = "We have $(num_vectors) vectors in \$\\mathbb{R}^$(n)\$. By row reduction, we can verify that at least $(n) of them are linearly independent, which means they span \$\\mathbb{R}^$(n)\$."
            else
                explanation = "Although we have more than $(n) vectors, they all lie in a proper subspace of \$\\mathbb{R}^$(n)\$ and do not span the entire space."
            end
        end
        
        problem(
            question="Do the vectors " * join(["\$$(fmt_tuple(v))\$" for v in vectors], ", ") * " span \$\\mathbb{R}^$(n)\$? Answer 'yes' or 'no'.",
            answer=ans,
            answer_type="text",
            difficulty=(2100, 2400),
            solution=steps(
                "To span \$\\mathbb{R}^$(n)\$, we need at least $(n) linearly independent vectors",
                "Check the rank of the matrix formed by these vectors",
                explanation,
                sol("Answer", ans)
            ),
            time=240
        )
    end
end