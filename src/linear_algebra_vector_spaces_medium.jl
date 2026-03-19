# linear_algebra - vector_spaces (medium)
# Generated: 2026-03-08T21:10:29.591772

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/vector_spaces")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Linear independence check (1200-1400)
        a1, a2, a3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        b1, b2, b3 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        
        # Make third vector a linear combination of first two
        k1, k2 = nonzero(-3, 3), nonzero(-3, 3)
        c1 = k1 * a1 + k2 * b1
        c2 = k1 * a2 + k2 * b2
        c3 = k1 * a3 + k2 * b3
        
        v1 = "\\begin{bmatrix} $a1 \\\\ $a2 \\\\ $a3 \\end{bmatrix}"
        v2 = "\\begin{bmatrix} $b1 \\\\ $b2 \\\\ $b3 \\end{bmatrix}"
        v3 = "\\begin{bmatrix} $c1 \\\\ $c2 \\\\ $c3 \\end{bmatrix}"
        
        problem(
            question="Determine whether the vectors \$\\mathbf{v}_1 = $v1\$, \$\\mathbf{v}_2 = $v2\$, and \$\\mathbf{v}_3 = $v3\$ are linearly independent or linearly dependent.",
            answer="linearly dependent",
            difficulty=(1200, 1400),
            answer_type="choice",
            solution=steps(
                "Set up equation \$c_1\\mathbf{v}_1 + c_2\\mathbf{v}_2 + c_3\\mathbf{v}_3 = \\mathbf{0}\$",
                "Notice that \$\\mathbf{v}_3 = $(k1)\\mathbf{v}_1 + $(k2)\\mathbf{v}_2\$",
                "Since a nontrivial linear combination equals zero, the vectors are linearly dependent."
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Basis verification (1300-1500)
        # Generate 2 vectors in R^2 that form a basis
        a1, a2 = nonzero(-7, 7), nonzero(-7, 7)
        b1, b2 = nonzero(-7, 7), nonzero(-7, 7)
        
        # Ensure they're linearly independent (det != 0)
        while a1 * b2 - a2 * b1 == 0
            b1, b2 = nonzero(-7, 7), nonzero(-7, 7)
        end
        
        v1 = "\\begin{bmatrix} $a1 \\\\ $a2 \\end{bmatrix}"
        v2 = "\\begin{bmatrix} $b1 \\\\ $b2 \\end{bmatrix}"
        
        problem(
            question="Verify that \$\\mathbf{v}_1 = $v1\$ and \$\\mathbf{v}_2 = $v2\$ form a basis for \$\\mathbb{R}^2\$. Is this a valid basis? Answer 'yes' or 'no'.",
            answer="yes",
            difficulty=(1300, 1500),
            answer_type="choice",
            solution=steps(
                "Check linear independence by computing determinant",
                sol("det", a1 * b2 - a2 * b1),
                "Since det ≠ 0, vectors are linearly independent. Two linearly independent vectors in \$\\mathbb{R}^2\$ form a basis."
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Span verification (1200-1400)
        a1, a2 = nonzero(-6, 6), nonzero(-6, 6)
        k = nonzero(-4, 4)
        b1, b2 = k * a1, k * a2
        
        v1 = "\\begin{bmatrix} $a1 \\\\ $a2 \\end{bmatrix}"
        v2 = "\\begin{bmatrix} $b1 \\\\ $b2 \\end{bmatrix}"
        
        problem(
            question="Do the vectors \$\\mathbf{v}_1 = $v1\$ and \$\\mathbf{v}_2 = $v2\$ span \$\\mathbb{R}^2\$? Answer 'yes' or 'no'.",
            answer="no",
            difficulty=(1200, 1400),
            answer_type="choice",
            solution=steps(
                "Check if vectors are linearly independent",
                "Notice \$\\mathbf{v}_2 = $(k)\\mathbf{v}_1\$, so vectors are linearly dependent",
                "Two linearly dependent vectors cannot span \$\\mathbb{R}^2\$. Answer: no"
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Dimension of subspace (1400-1600)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        problem(
            question="Find the dimension of the subspace \$W\$ of \$\\mathbb{R}^3\$ defined by \$W = \\{(x, y, z) : $(a)x + $(b)y + $(c)z = 0\\}\$.",
            answer=2,
            difficulty=(1400, 1600),
            solution=steps(
                "The equation \$$(a)x + $(b)y + $(c)z = 0\$ represents a plane through the origin",
                "This gives 1 constraint on 3 variables, leaving 2 free parameters",
                sol("Dimension", 2)
            ),
            time=100
        )
        
    elseif problem_type == 5
        # Coordinate vector relative to basis (1500-1700)
        # Basis vectors for R^2
        a1, a2 = nonzero(-5, 5), nonzero(-5, 5)
        b1, b2 = nonzero(-5, 5), nonzero(-5, 5)
        
        while a1 * b2 - a2 * b1 == 0
            b1, b2 = nonzero(-5, 5), nonzero(-5, 5)
        end
        
        # Target vector as combination
        c1, c2 = randint(-4, 4), randint(-4, 4)
        v1 = c1 * a1 + c2 * b1
        v2 = c1 * a2 + c2 * b2
        
        basis_v1 = "\\begin{bmatrix} $a1 \\\\ $a2 \\end{bmatrix}"
        basis_v2 = "\\begin{bmatrix} $b1 \\\\ $b2 \\end{bmatrix}"
        target_v = "\\begin{bmatrix} $v1 \\\\ $v2 \\end{bmatrix}"
        
        problem(
            question="Let \$\\mathcal{B} = \\{\\mathbf{b}_1, \\mathbf{b}_2\\}\$ where \$\\mathbf{b}_1 = $basis_v1\$ and \$\\mathbf{b}_2 = $basis_v2\$. Find the coordinate vector \$[\\mathbf{v}]_{\\mathcal{B}}\$ where \$\\mathbf{v} = $target_v\$. Enter your answer as an ordered pair (c₁, c₂).",
            answer=fmt_tuple((c1, c2)),
            difficulty=(1500, 1700),
            answer_type="tuple",
            solution=steps(
                "Solve \$\\mathbf{v} = c_1\\mathbf{b}_1 + c_2\\mathbf{b}_2\$",
                "This gives: \$$(v1) = $(a1)c_1 + $(b1)c_2\$ and \$$(v2) = $(a2)c_1 + $(b2)c_2\$",
                sol("[\\mathbf{v}]_{\\mathcal{B}}", fmt_tuple((c1, c2)))
            ),
            time=150
        )
        
    else
        # Nullspace dimension (1400-1700)
        # Create a matrix with known nullspace dimension
        rank_choice = rand(1:2)
        
        if rank_choice == 1
            # Rank 2 matrix in R^3 (nullspace dim = 1)
            a1, a2, a3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
            b1, b2, b3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
            
            # Ensure rows are independent
            while a1 * b2 == a2 * b1
                b1, b2 = nonzero(-5, 5), nonzero(-5, 5)
            end
            
            mat = "\\begin{bmatrix} $a1 & $a2 & $a3 \\\\ $b1 & $b2 & $b3 \\end{bmatrix}"
            ans = 1
        else
            # Rank 1 matrix in R^3 (nullspace dim = 2)
            a1, a2, a3 = nonzero(-5, 5), nonzero(-5, 5), nonzero(-5, 5)
            
            mat = "\\begin{bmatrix} $a1 & $a2 & $a3 \\end{bmatrix}"
            ans = 2
        end
        
        problem(
            question="Find the dimension of the nullspace of the matrix \$A = $mat\$.",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                "Use the rank-nullity theorem: \$\\dim(\\text{null}(A)) + \\text{rank}(A) = n\$",
                "The matrix has $(rank_choice == 1 ? "2 rows, rank = 2" : "1 row, rank = 1"), and \$n = 3\$ columns",
                sol("\\dim(\\text{null}(A))", ans)
            ),
            time=120
        )
    end
end