# linear_algebra - diagonalization (easy)
# Generated: 2026-03-08T21:13:47.025796

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/diagonalization")
    
    prob_type = choice([:eigenvalue_2x2, :eigenvector_2x2, :diagonal_verify, :diagonal_matrix_power])
    
    if prob_type == :eigenvalue_2x2
        # Generate 2x2 matrix with integer eigenvalues
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        
        # Random invertible change of basis matrix
        p11, p12 = nonzero(-3, 3), nonzero(-3, 3)
        p21, p22 = nonzero(-3, 3), nonzero(-3, 3)
        
        # Ensure invertible (determinant nonzero)
        while p11*p22 - p12*p21 == 0
            p22 = nonzero(-3, 3)
        end
        
        # A = P D P^(-1), but we'll just construct directly
        a11 = λ1
        a22 = λ2
        a12 = randint(-5, 5)
        a21 = 0
        
        A = [[a11, a12], [a21, a22]]
        
        problem(
            question="Find the eigenvalues of the matrix \$A = $(fmt_matrix(A))\$. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(700, 900),
            answer_type="set",
            solution=steps(
                "Given matrix: \$A = $(fmt_matrix(A))\$",
                "For upper triangular matrix, eigenvalues are diagonal entries",
                sol("Eigenvalues", fmt_set(Set([λ1, λ2])))
            ),
            time=90
        )
        
    elseif prob_type == :eigenvector_2x2
        # Simple diagonal matrix with eigenvalue
        λ = nonzero(-7, 7)
        other_λ = nonzero(-7, 7)
        while other_λ == λ
            other_λ = nonzero(-7, 7)
        end
        
        A = [[λ, 0], [0, other_λ]]
        
        # Eigenvector for λ is [1, 0]
        v1 = 1
        v2 = 0
        
        problem(
            question="Find an eigenvector corresponding to eigenvalue \$\\lambda = $(λ)\$ for the matrix \$A = $(fmt_matrix(A))\$. Enter as a column vector.",
            answer=fmt_matrix([[v1], [v2]]),
            difficulty=(800, 1000),
            answer_type="matrix",
            solution=steps(
                "Given: \$A = $(fmt_matrix(A))\$, eigenvalue \$\\lambda = $(λ)\$",
                "Solve \$(A - \\lambda I)\\mathbf{v} = \\mathbf{0}\$",
                "\$A - $(λ)I = $(fmt_matrix([[0, 0], [0, other_λ - λ]]))\$",
                "First row gives \$0 = 0\$ (always true), second row gives \$$(other_λ - λ)v_2 = 0\$",
                "So \$v_2 = 0\$ and \$v_1\$ is free. Choose \$v_1 = 1\$",
                sol("Eigenvector", fmt_matrix([[v1], [v2]]))
            ),
            time=120
        )
        
    elseif prob_type == :diagonal_verify
        # Give a matrix and diagonal form, verify one eigenvalue
        λ1 = nonzero(-6, 6)
        λ2 = nonzero(-6, 6)
        
        # Upper triangular for simplicity
        a11 = λ1
        a22 = λ2
        a12 = nonzero(-4, 4)
        
        A = [[a11, a12], [0, a22]]
        
        problem(
            question="The matrix \$A = $(fmt_matrix(A))\$ has eigenvalues on its diagonal (it's upper triangular). What is the sum of all eigenvalues?",
            answer=λ1 + λ2,
            difficulty=(700, 900),
            solution=steps(
                "Given matrix: \$A = $(fmt_matrix(A))\$",
                "For triangular matrices, eigenvalues are the diagonal entries",
                "Eigenvalues: \$$(λ1), $(λ2)\$",
                sol("Sum", λ1 + λ2)
            ),
            time=60
        )
        
    else  # diagonal_matrix_power
        # Diagonal matrix raised to a power
        d1 = choice([-2, -1, 2, 3])
        d2 = choice([-2, -1, 2, 3])
        n = randint(2, 4)
        
        D = [[d1, 0], [0, d2]]
        
        Dn = [[d1^n, 0], [0, d2^n]]
        
        problem(
            question="If \$D = $(fmt_matrix(D))\$, compute \$D^{$(n)}\$.",
            answer=fmt_matrix(Dn),
            difficulty=(900, 1100),
            answer_type="matrix",
            solution=steps(
                "Given: \$D = $(fmt_matrix(D))\$",
                "For diagonal matrices, \$D^n\$ means raising each diagonal entry to the \$n\$-th power",
                "\$D^{$(n)} = $(fmt_matrix([[d1^n, 0], [0, d2^n]]))\$",
                sol("Answer", fmt_matrix(Dn))
            ),
            time=90
        )
    end
end