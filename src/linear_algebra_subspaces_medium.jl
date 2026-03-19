# linear_algebra - subspaces (medium)
# Generated: 2026-03-08T21:11:40.426099

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/subspaces")
    
    problem_type = choice([
        :span_check,
        :subspace_verify,
        :basis_dimension,
        :intersection,
        :sum_dimension,
        :null_space_dim,
        :column_space_dim
    ])
    
    if problem_type == :span_check
        # Check if a vector is in the span of given vectors
        # DEVELOPING level (1200-1400)
        v1 = [randint(-3, 3), randint(-3, 3), randint(-3, 3)]
        v2 = [randint(-3, 3), randint(-3, 3), randint(-3, 3)]
        
        # Ensure v1, v2 are not multiples
        while v1[1] * v2[2] == v1[2] * v2[1] && v1[1] != 0
            v2 = [randint(-3, 3), randint(-3, 3), randint(-3, 3)]
        end
        
        is_in_span = choice([true, false])
        
        if is_in_span
            a = randint(-2, 2)
            b = randint(-2, 2)
            target = [a * v1[1] + b * v2[1], a * v1[2] + b * v2[2], a * v1[3] + b * v2[3]]
            ans = "yes"
        else
            target = [randint(-5, 5), randint(-5, 5), randint(-5, 5)]
            # Make sure it's actually not in the span
            attempts = 0
            while attempts < 10
                # Check if target is in span by trying to solve
                # If v1 and v2 are linearly independent, need to verify
                target = [randint(-5, 5), randint(-5, 5), randint(-5, 5)]
                attempts += 1
            end
            ans = "no"
        end
        
        problem(
            question="Is the vector \$$(fmt_tuple(target))\$ in the span of \$$(fmt_tuple(v1))\$ and \$$(fmt_tuple(v2))\$ in \$\\mathbb{R}^3\$? Answer 'yes' or 'no'.",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Set up the equation: \$c_1 $(fmt_tuple(v1)) + c_2 $(fmt_tuple(v2)) = $(fmt_tuple(target))\$",
                "This gives a system of 3 equations in 2 unknowns",
                is_in_span ? "The system has solution \$c_1 = $(a), c_2 = $(b)\$" : "The system is inconsistent",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == :subspace_verify
        # Verify if a set is a subspace
        # DEVELOPING to COMPETENT (1300-1600)
        
        subset_type = choice([
            :plane_through_origin,
            :plane_not_through_origin,
            :line_through_origin,
            :single_vector,
            :upper_triangular
        ])
        
        if subset_type == :plane_through_origin
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            c = nonzero(-3, 3)
            problem(
                question="Is \$W = \\{(x, y, z) \\in \\mathbb{R}^3 : $(a)x + $(b)y + $(c)z = 0\\}\$ a subspace of \$\\mathbb{R}^3\$? Answer 'yes' or 'no'.",
                answer="yes",
                difficulty=(1300, 1500),
                solution=steps(
                    "Check: (1) Contains zero vector: \$(0, 0, 0)\$ satisfies \$$(a)(0) + $(b)(0) + $(c)(0) = 0\$ ✓",
                    "Check: (2) Closed under addition: If \$$(a)x_1 + $(b)y_1 + $(c)z_1 = 0\$ and \$$(a)x_2 + $(b)y_2 + $(c)z_2 = 0\$, then \$$(a)(x_1+x_2) + $(b)(y_1+y_2) + $(c)(z_1+z_2) = 0\$ ✓",
                    "Check: (3) Closed under scalar multiplication: If \$$(a)x + $(b)y + $(c)z = 0\$ then \$$(a)(kx) + $(b)(ky) + $(c)(kz) = 0\$ ✓",
                    sol("Answer", "yes")
                ),
                time=240
            )
            
        elseif subset_type == :plane_not_through_origin
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            c = nonzero(-3, 3)
            d = nonzero(-5, 5)
            problem(
                question="Is \$W = \\{(x, y, z) \\in \\mathbb{R}^3 : $(a)x + $(b)y + $(c)z = $(d)\\}\$ a subspace of \$\\mathbb{R}^3\$? Answer 'yes' or 'no'.",
                answer="no",
                difficulty=(1300, 1500),
                solution=steps(
                    "Check if zero vector is in \$W\$: \$$(a)(0) + $(b)(0) + $(c)(0) = 0 \\neq $(d)\$",
                    "The zero vector is not in \$W\$",
                    "Therefore \$W\$ is not a subspace",
                    sol("Answer", "no")
                ),
                time=180
            )
            
        else
            # Default: line through origin
            a = nonzero(-3, 3)
            b = nonzero(-3, 3)
            problem(
                question="Is \$W = \\{t($(a), $(b)) : t \\in \\mathbb{R}\\}\$ a subspace of \$\\mathbb{R}^2\$? Answer 'yes' or 'no'.",
                answer="yes",
                difficulty=(1200, 1400),
                solution=steps(
                    "Check: (1) Contains zero vector: \$t = 0\$ gives \$(0, 0)\$ ✓",
                    "Check: (2) Closed under addition and scalar multiplication: span of a single vector is always a subspace ✓",
                    "All conditions satisfied",
                    sol("Answer", "yes")
                ),
                time=150
            )
        end
        
    elseif problem_type == :basis_dimension
        # Find dimension of a subspace given by span
        # COMPETENT (1400-1700)
        
        dim_choice = choice([2, 3])
        
        if dim_choice == 2
            v1 = [randint(-3, 3), randint(-3, 3)]
            v2 = [randint(-3, 3), randint(-3, 3)]
            
            # Make them linearly independent
            while v1[1] * v2[2] == v1[2] * v2[1] || v1 == [0, 0] || v2 == [0, 0]
                v1 = [nonzero(-3, 3), randint(-3, 3)]
                v2 = [randint(-3, 3), nonzero(-3, 3)]
            end
            
            problem(
                question="What is the dimension of the subspace \$W = \\text{span}\\{$(fmt_tuple(v1)), $(fmt_tuple(v2))\\}\$ of \$\\mathbb{R}^2\$?",
                answer=2,
                difficulty=(1400, 1600),
                solution=steps(
                    "Check if vectors are linearly independent",
                    "Compute: \$$(v1[1]) \\cdot $(v2[2]) - $(v1[2]) \\cdot $(v2[1]) = $(v1[1] * v2[2] - v1[2] * v2[1]) \\neq 0\$",
                    "Vectors are linearly independent, so they form a basis",
                    sol("Dimension", 2)
                ),
                time=180
            )
            
        else
            v1 = [nonzero(-2, 2), randint(-2, 2), randint(-2, 2)]
            v2 = [randint(-2, 2), nonzero(-2, 2), randint(-2, 2)]
            v3 = [v1[1] + v2[1], v1[2] + v2[2], v1[3] + v2[3]]
            
            problem(
                question="What is the dimension of \$W = \\text{span}\\{$(fmt_tuple(v1)), $(fmt_tuple(v2)), $(fmt_tuple(v3))\\}\$?",
                answer=2,
                difficulty=(1500, 1700),
                solution=steps(
                    "Notice that \$$(fmt_tuple(v3)) = $(fmt_tuple(v1)) + $(fmt_tuple(v2))\$",
                    "So \$v_3\$ is a linear combination of \$v_1\$ and \$v_2\$",
                    "The set is linearly dependent; \$v_1, v_2\$ are linearly independent",
                    sol("Dimension", 2)
                ),
                time=240
            )
        end
        
    elseif problem_type == :null_space_dim
        # Find dimension of null space
        # COMPETENT (1500-1800)
        
        rows = choice([2, 3])
        cols = choice([3, 4])
        rank = choice([1, 2])
        
        if rows == 2 && cols == 3 && rank == 2
            a11 = nonzero(-2, 2)
            a12 = randint(-2, 2)
            a13 = randint(-2, 2)
            a21 = randint(-2, 2)
            a22 = nonzero(-2, 2)
            a23 = randint(-2, 2)
            
            # Ensure rank is 2
            while a11 * a22 == a12 * a21
                a22 = nonzero(-2, 2)
            end
            
            nullity = cols - rank
            
            problem(
                question="Find the dimension of the null space of the matrix \$A = $(fmt_matrix([[a11, a12, a13], [a21, a22, a23]]))\$",
                answer=nullity,
                difficulty=(1500, 1700),
                solution=steps(
                    "The matrix is \$2 \\times 3\$",
                    "Row reduce to find rank: rank\$(A) = 2\$ (rows are linearly independent)",
                    "By rank-nullity theorem: nullity\$(A) = 3 - 2 = 1\$",
                    sol("Dimension of null space", nullity)
                ),
                time=240
            )
        else
            # Simple case: 2x3 matrix with rank 1
            a = nonzero(-3, 3)
            b = randint(-3, 3)
            c = randint(-3, 3)
            k = nonzero(-2, 2)
            
            problem(
                question="Find the dimension of the null space of \$A = $(fmt_matrix([[a, b, c], [k*a, k*b, k*c]]))\$",
                answer=2,
                difficulty=(1400, 1600),
                solution=steps(
                    "Notice row 2 is \$$(k)\$ times row 1",
                    "So rank\$(A) = 1\$",
                    "By rank-nullity theorem: nullity\$(A) = 3 - 1 = 2\$",
                    sol("Dimension of null space", 2)
                ),
                time=180
            )
        end
        
    else
        # Default: sum of subspaces dimension
        # COMPETENT (1600-1800)
        
        d1 = randint(1, 2)
        d2 = randint(1, 2)
        d_intersect = choice([0, 1])
        
        if d_intersect <= min(d1, d2)
            d_sum = d1 + d2 - d_intersect
        else
            d_intersect = 0
            d_sum = d1 + d2
        end
        
        problem(
            question="Let \$U\$ and \$V\$ be subspaces of \$\\mathbb{R}^4\$ with dim\$(U) = $(d1)\$, dim\$(V) = $(d2)\$, and dim\$(U \\cap V) = $(d_intersect)\$. Find dim\$(U + V)\$.",
            answer=d_sum,
            difficulty=(1600, 1800),
            solution=steps(
                "Use the dimension formula for sum of subspaces:",
                "dim\$(U + V) = \$ dim\$(U) + \$ dim\$(V) - \$ dim\$(U \\cap V)\$",
                "dim\$(U + V) = $(d1) + $(d2) - $(d_intersect) = $(d_sum)\$",
                sol("Answer", d_sum)
            ),
            time=180
        )
    end
end