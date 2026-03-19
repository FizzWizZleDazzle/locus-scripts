# linear_algebra - subspaces (easy)
# Generated: 2026-03-08T21:11:24.736030

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/subspaces")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Determine if a vector is in a subspace (span check)
        # ELO: 700-900
        v1 = [randint(-3, 3), randint(-3, 3)]
        v2 = [randint(-3, 3), randint(-3, 3)]
        
        # Ensure v1 and v2 are not scalar multiples
        while v1[1] * v2[2] == v1[2] * v2[1] || v1 == [0, 0] || v2 == [0, 0]
            v1 = [randint(-3, 3), randint(-3, 3)]
            v2 = [randint(-3, 3), randint(-3, 3)]
        end
        
        # Create test vector that IS in the span
        a = randint(-2, 2)
        b = randint(-2, 2)
        test_vec = [a * v1[1] + b * v2[1], a * v1[2] + b * v2[2]]
        
        problem(
            question = "Is the vector \$$(fmt_matrix([test_vec]))\$ in the subspace spanned by \$$(fmt_matrix([v1]))\$ and \$$(fmt_matrix([v2]))\$?",
            answer = "Yes",
            difficulty = (700, 900),
            solution = steps(
                "We need to determine if \$$(fmt_matrix([test_vec])) = c_1$(fmt_matrix([v1])) + c_2$(fmt_matrix([v2]))\$ for some scalars \$c_1, c_2\$",
                "This gives the system: \$$(v1[1])c_1 + $(v2[1])c_2 = $(test_vec[1])\$ and \$$(v1[2])c_1 + $(v2[2])c_2 = $(test_vec[2])\$",
                "Solving: \$c_1 = $(a)\$, \$c_2 = $(b)\$",
                "Since we found values, the vector IS in the subspace"
            ),
            time = 90
        )
        
    elseif problem_type == 2
        # Check if set is closed under addition (subspace property)
        # ELO: 800-1000
        set_types = [
            ("all vectors of the form \\begin{pmatrix} a \\\\ 0 \\end{pmatrix}", "Yes", "closed under addition and scalar multiplication"),
            ("all vectors of the form \\begin{pmatrix} a \\\\ 1 \\end{pmatrix}", "No", "not closed under addition: \\begin{pmatrix} 0 \\\\ 1 \\end{pmatrix} + \\begin{pmatrix} 0 \\\\ 1 \\end{pmatrix} = \\begin{pmatrix} 0 \\\\ 2 \\end{pmatrix}"),
            ("all vectors of the form \\begin{pmatrix} a \\\\ a \\end{pmatrix}", "Yes", "closed under addition and scalar multiplication"),
            ("all vectors with positive components", "No", "not closed under scalar multiplication (multiply by -1)")
        ]
        
        chosen = choice(set_types)
        
        problem(
            question = "Is the set of $(chosen[1]) a subspace of \$\\mathbb{R}^2\$?",
            answer = chosen[2],
            difficulty = (800, 1000),
            solution = steps(
                "For a set to be a subspace, it must be closed under addition and scalar multiplication",
                "Check addition property",
                chosen[3]
            ),
            time = 120
        )
        
    elseif problem_type == 3
        # Find dimension of a subspace given by span
        # ELO: 900-1100
        case = rand(1:2)
        
        if case == 1
            # Two independent vectors in R^3
            v1 = [randint(-2, 2), randint(-2, 2), randint(-2, 2)]
            v2 = [randint(-2, 2), randint(-2, 2), randint(-2, 2)]
            
            while v1 == [0, 0, 0] || v2 == [0, 0, 0]
                v1 = [randint(-2, 2), randint(-2, 2), randint(-2, 2)]
                v2 = [randint(-2, 2), randint(-2, 2), randint(-2, 2)]
            end
            
            # Make sure not scalar multiples
            while length(v1) > 0 && length(v2) > 0 && v1[1] * v2[2] == v1[2] * v2[1] && v1[1] * v2[3] == v1[3] * v2[1]
                v2 = [randint(-2, 2), randint(-2, 2), randint(-2, 2)]
            end
            
            problem(
                question = "What is the dimension of the subspace of \$\\mathbb{R}^3\$ spanned by \$$(fmt_matrix([v1]))\$ and \$$(fmt_matrix([v2]))\$?",
                answer = 2,
                difficulty = (900, 1100),
                solution = steps(
                    "The dimension equals the number of linearly independent vectors",
                    "Check if \$$(fmt_matrix([v1]))\$ and \$$(fmt_matrix([v2]))\$ are linearly independent",
                    "These vectors are not scalar multiples of each other",
                    "Dimension = 2"
                ),
                time = 90
            )
        else
            # Three vectors where one is dependent
            v1 = [randint(-2, 2), randint(-2, 2)]
            v2 = [randint(-2, 2), randint(-2, 2)]
            
            while v1 == [0, 0] || v2 == [0, 0] || v1[1] * v2[2] == v1[2] * v2[1]
                v1 = [randint(-2, 2), randint(-2, 2)]
                v2 = [randint(-2, 2), randint(-2, 2)]
            end
            
            a = randint(-2, 2)
            b = randint(-2, 2)
            v3 = [a * v1[1] + b * v2[1], a * v1[2] + b * v2[2]]
            
            problem(
                question = "What is the dimension of the subspace of \$\\mathbb{R}^2\$ spanned by \$$(fmt_matrix([v1]))\$, \$$(fmt_matrix([v2]))\$, and \$$(fmt_matrix([v3]))\$?",
                answer = 2,
                difficulty = (900, 1100),
                solution = steps(
                    "The dimension equals the number of linearly independent vectors",
                    "Notice that \$$(fmt_matrix([v3])) = $(a)$(fmt_matrix([v1])) + $(b)$(fmt_matrix([v2]))\$",
                    "So \$$(fmt_matrix([v3]))\$ is a linear combination of the other two",
                    "Only 2 linearly independent vectors, so dimension = 2"
                ),
                time = 120
            )
        end
        
    elseif problem_type == 4
        # Verify zero vector is in subspace
        # ELO: 700-850
        v1 = [randint(-3, 3), randint(-3, 3)]
        v2 = [randint(-3, 3), randint(-3, 3)]
        
        while v1 == [0, 0] || v2 == [0, 0]
            v1 = [randint(-3, 3), randint(-3, 3)]
            v2 = [randint(-3, 3), randint(-3, 3)]
        end
        
        problem(
            question = "Is the zero vector in the subspace spanned by \$$(fmt_matrix([v1]))\$ and \$$(fmt_matrix([v2]))\$?",
            answer = "Yes",
            difficulty = (700, 850),
            solution = steps(
                "The zero vector can be written as \$0 \\cdot $(fmt_matrix([v1])) + 0 \\cdot $(fmt_matrix([v2]))\$",
                "This is a linear combination with coefficients \$c_1 = 0\$ and \$c_2 = 0\$",
                "Therefore, the zero vector IS in the subspace"
            ),
            time = 60
        )
        
    else
        # Check linear independence (simple 2-vector case)
        # ELO: 850-1100
        independent = rand(Bool)
        
        if independent
            v1 = [randint(-3, 3), randint(-3, 3)]
            v2 = [randint(-3, 3), randint(-3, 3)]
            
            while v1 == [0, 0] || v2 == [0, 0] || v1[1] * v2[2] == v1[2] * v2[1]
                v1 = [randint(-3, 3), randint(-3, 3)]
                v2 = [randint(-3, 3), randint(-3, 3)]
            end
            
            problem(
                question = "Are the vectors \$$(fmt_matrix([v1]))\$ and \$$(fmt_matrix([v2]))\$ linearly independent?",
                answer = "Yes",
                difficulty = (850, 1050),
                solution = steps(
                    "Vectors are linearly independent if neither is a scalar multiple of the other",
                    "Check if \$$(fmt_matrix([v2])) = k$(fmt_matrix([v1]))\$ for some scalar \$k\$",
                    "This would require \$$(v2[1]) = k($(v1[1]))\$ and \$$(v2[2]) = k($(v1[2]))\$",
                    "No such \$k\$ exists, so the vectors ARE linearly independent"
                ),
                time = 90
            )
        else
            v1 = [randint(-3, 3), randint(-3, 3)]
            k = nonzero(-3, 3)
            v2 = [k * v1[1], k * v1[2]]
            
            while v1 == [0, 0]
                v1 = [randint(-3, 3), randint(-3, 3)]
            end
            
            problem(
                question = "Are the vectors \$$(fmt_matrix([v1]))\$ and \$$(fmt_matrix([v2]))\$ linearly independent?",
                answer = "No",
                difficulty = (850, 1050),
                solution = steps(
                    "Vectors are linearly independent if neither is a scalar multiple of the other",
                    "Notice that \$$(fmt_matrix([v2])) = $(k)$(fmt_matrix([v1]))\$",
                    "Since one is a scalar multiple of the other, they ARE linearly dependent"
                ),
                time = 90
            )
        end
    end
end