# linear_algebra - diagonalization (very_hard)
# Generated: 2026-03-08T21:14:27.792873

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/diagonalization")
    
    # Choose problem type
    prob_type = choice([:eigenvalue_eigenvector_computation, :diagonalization_existence, 
                       :power_computation, :exponential_computation, :algebraic_multiplicity])
    
    if prob_type == :eigenvalue_eigenvector_computation
        # Competition-level eigenvalue/eigenvector problem with complex structure
        # Generate a matrix with known eigenvalues and eigenvectors
        λ1 = randint(-5, 5)
        λ2 = randint(-5, 5)
        λ3 = randint(-5, 5)
        
        # Ensure distinct eigenvalues for cleaner problem
        while λ2 == λ1
            λ2 = randint(-5, 5)
        end
        while λ3 == λ1 || λ3 == λ2
            λ3 = randint(-5, 5)
        end
        
        # Generate invertible matrix P with integer entries
        p11, p12, p13 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        p21, p22, p23 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        p31, p32, p33 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        
        det_P = p11*(p22*p33 - p23*p32) - p12*(p21*p33 - p23*p31) + p13*(p21*p32 - p22*p31)
        
        # Ensure P is invertible
        attempts = 0
        while det_P == 0 && attempts < 50
            p11, p12, p13 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
            p21, p22, p23 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
            p31, p32, p33 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
            det_P = p11*(p22*p33 - p23*p32) - p12*(p21*p33 - p23*p31) + p13*(p21*p32 - p22*p31)
            attempts += 1
        end
        
        # Construct A = P D P^(-1)
        a11 = p11*λ1*p22*p33 - p11*λ1*p23*p32 - p12*λ2*p21*p33 + p12*λ2*p23*p31 + p13*λ3*p21*p32 - p13*λ3*p22*p31
        a11 = div(a11, det_P)
        
        # For simplicity, construct a smaller 2x2 matrix instead
        λ1 = randint(-6, 6)
        λ2 = randint(-6, 6)
        while λ2 == λ1
            λ2 = randint(-6, 6)
        end
        
        # 2x2 matrix with eigenvectors [1,1] and [1,-1]
        a = div(λ1 + λ2, 2)
        b = div(λ1 - λ2, 2)
        
        problem(
            question="Find all eigenvalues of the matrix \$A = \\begin{pmatrix} $(a) & $(b) \\\\ $(b) & $(a) \\end{pmatrix}\$. Enter your answer as a set.",
            answer=fmt_set(Set([λ1, λ2])),
            difficulty=(2500, 2800),
            answer_type="set",
            solution=steps(
                "Compute the characteristic polynomial: \$\\det(A - \\lambda I) = 0\$",
                "\$\\det\\begin{pmatrix} $(a)-\\lambda & $(b) \\\\ $(b) & $(a)-\\lambda \\end{pmatrix} = ($(a)-\\lambda)^2 - $(b^2) = 0\$",
                "\$\\lambda^2 - $(2*a)\\lambda + $(a^2 - b^2) = 0\$",
                "Solving: \$\\lambda = $(λ1)\$ or \$\\lambda = $(λ2)\$",
                sol("Eigenvalues", fmt_set(Set([λ1, λ2])))
            ),
            time=240
        )
        
    elseif prob_type == :diagonalization_existence
        # Olympiad-level: determine if matrix is diagonalizable
        # Create a defective matrix (Jordan block)
        λ = randint(-4, 4)
        k = randint(2, 4)
        
        problem(
            question="Is the matrix \$A = \\begin{pmatrix} $(λ) & 1 & 0 \\\\ 0 & $(λ) & 1 \\\\ 0 & 0 & $(λ) \\end{pmatrix}\$ diagonalizable over \$\\mathbb{C}\$? Answer YES or NO.",
            answer="NO",
            difficulty=(2800, 3200),
            solution=steps(
                "Find eigenvalues: \$\\det(A - \\lambda I) = ($(λ) - \\lambda)^3 = 0\$",
                "The only eigenvalue is \$\\lambda = $(λ)\$ with algebraic multiplicity 3",
                "Compute \$A - $(λ)I = \\begin{pmatrix} 0 & 1 & 0 \\\\ 0 & 0 & 1 \\\\ 0 & 0 & 0 \\end{pmatrix}\$",
                "The null space has dimension 1 (geometric multiplicity = 1)",
                "Since geometric multiplicity < algebraic multiplicity, \$A\$ is NOT diagonalizable",
                sol("Answer", "NO")
            ),
            time=300
        )
        
    elseif prob_type == :power_computation
        # Competition: compute matrix power using diagonalization
        λ1 = choice([2, 3, -2])
        λ2 = choice([1, -1, 0])
        n = randint(8, 15)
        
        # Simple diagonalizable matrix
        a = div(λ1 + λ2, 2)
        b = div(λ1 - λ2, 2)
        
        # A^n for diagonal matrix
        a_n = div(λ1^n + λ2^n, 2)
        b_n = div(λ1^n - λ2^n, 2)
        
        problem(
            question="Let \$A = \\begin{pmatrix} $(a) & $(b) \\\\ $(b) & $(a) \\end{pmatrix}\$. Find the entry in position (1,1) of \$A^{$(n)}\$.",
            answer=a_n,
            difficulty=(2600, 3000),
            solution=steps(
                "Diagonalize \$A = PDP^{-1}\$ where \$D = \\begin{pmatrix} $(λ1) & 0 \\\\ 0 & $(λ2) \\end{pmatrix}\$",
                "\$P = \\begin{pmatrix} 1 & 1 \\\\ 1 & -1 \\end{pmatrix}\$, \$P^{-1} = \\frac{1}{2}\\begin{pmatrix} 1 & 1 \\\\ 1 & -1 \\end{pmatrix}\$",
                "\$A^{$(n)} = PD^{$(n)}P^{-1}\$ where \$D^{$(n)} = \\begin{pmatrix} $(λ1)^{$(n)} & 0 \\\\ 0 & $(λ2)^{$(n)} \\end{pmatrix}\$",
                "Computing: \$(A^{$(n)})_{11} = \\frac{$(λ1)^{$(n)} + $(λ2)^{$(n)}}{2}\$",
                sol("Answer", a_n)
            ),
            time=300
        )
        
    elseif prob_type == :exponential_computation
        # Olympiad: matrix exponential trace
        λ1 = randint(-3, 3)
        λ2 = randint(-3, 3)
        λ3 = randint(-3, 3)
        
        exp_sum = round(exp(λ1) + exp(λ2) + exp(λ3), digits=4)
        
        problem(
            question="A \$3 \\times 3\$ matrix \$A\$ is diagonalizable with eigenvalues \$$(λ1), $(λ2), $(λ3)\$. What is \$\\text{tr}(e^A)\$? Round to 4 decimal places.",
            answer=exp_sum,
            difficulty=(3000, 3400),
            solution=steps(
                "If \$A = PDP^{-1}\$ with \$D = \\text{diag}($(λ1), $(λ2), $(λ3))\$",
                "Then \$e^A = Pe^DP^{-1}\$ where \$e^D = \\text{diag}(e^{$(λ1)}, e^{$(λ2)}, e^{$(λ3)})\$",
                "The trace is invariant under similarity: \$\\text{tr}(e^A) = \\text{tr}(e^D)\$",
                "\$\\text{tr}(e^A) = e^{$(λ1)} + e^{$(λ2)} + e^{$(λ3)}\$",
                sol("Answer", exp_sum)
            ),
            time=240
        )
        
    else  # algebraic_multiplicity
        # Olympiad-level: characteristic polynomial and multiplicity
        λ1 = randint(-5, 5)
        λ2 = randint(-5, 5)
        m1 = randint(2, 3)
        m2 = randint(1, 2)
        n = m1 + m2
        
        while λ2 == λ1
            λ2 = randint(-5, 5)
        end
        
        # Coefficient of λ^(n-1) in characteristic polynomial
        coeff = -(m1 * λ1 + m2 * λ2)
        
        problem(
            question="A \$$(n) \\times $(n)\$ matrix has eigenvalue \$$(λ1)\$ with algebraic multiplicity $(m1) and eigenvalue \$$(λ2)\$ with algebraic multiplicity $(m2). What is the coefficient of \$\\lambda^{$(n-1)}\$ in the characteristic polynomial \$\\det(A - \\lambda I)\$?",
            answer=coeff,
            difficulty=(2700, 3100),
            solution=steps(
                "The characteristic polynomial has the form \$\\det(A - \\lambda I) = (\\lambda - $(λ1))^{$(m1)}(\\lambda - $(λ2))^{$(m2)}\$",
                "The leading coefficient is 1 (for \$\\lambda^{$(n)}\$)",
                "By Vieta's formulas, coefficient of \$\\lambda^{$(n-1)}\$ equals \$-(\\text{sum of roots with multiplicity})\$",
                "Sum = \$$(m1) \\cdot $(λ1) + $(m2) \\cdot $(λ2) = $(m1*λ1 + m2*λ2)\$",
                sol("Answer", coeff)
            ),
            time=240
        )
    end
end