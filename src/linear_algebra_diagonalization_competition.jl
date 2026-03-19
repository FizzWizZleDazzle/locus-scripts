# linear_algebra - diagonalization (competition)
# Generated: 2026-03-08T21:14:27.598192

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/diagonalization")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Diagonalization with repeated eigenvalues and defective matrix
        λ = randint(-8, 8)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # Construct a 3×3 matrix with eigenvalue λ of algebraic multiplicity 3
        # but geometric multiplicity 2 (defective)
        # Jordan form: [λ 1 0; 0 λ 0; 0 0 λ]
        
        # Random invertible matrix P
        p11, p12, p13 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        p21, p22, p23 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        p31, p32, p33 = nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)
        
        # Ensure P is invertible by construction
        P = [[p11, p21, p31], [p12, p22, p32], [p13, p23, p33]]
        
        # Create Jordan block
        J = [[λ, 0, 0], [1, λ, 0], [0, 0, λ]]
        
        mat_str = "\\begin{bmatrix} $(J[1][1]) & $(J[1][2]) & $(J[1][3]) \\\\ $(J[2][1]) & $(J[2][2]) & $(J[2][3]) \\\\ $(J[3][1]) & $(J[3][2]) & $(J[3][3]) \\end{bmatrix}"
        
        problem(
            question="Let A = $(mat_str). Determine whether A is diagonalizable over ℂ. If not, find the Jordan canonical form and explain the obstruction to diagonalization. Compute the dimension of each eigenspace.",
            answer="Not diagonalizable; geometric multiplicity 2 < algebraic multiplicity 3",
            difficulty=(3500, 4000),
            answer_type="text",
            solution=steps(
                "Characteristic polynomial: det(A - λI) = -(λ - $(λ))³",
                "Eigenvalue λ = $(λ) has algebraic multiplicity 3",
                "Compute (A - $(λ)I): The rank is 1, so nullity = 2",
                "Geometric multiplicity = 2 < 3 = algebraic multiplicity",
                "Therefore A is defective and NOT diagonalizable",
                "Jordan canonical form: $(mat_str)",
                "The obstruction: insufficient eigenvectors to form a basis",
            ),
            time=300,
        )
        
    elseif problem_type == 2
        # Simultaneous diagonalization problem
        λ1, λ2, λ3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        μ1, μ2, μ3 = randint(-6, 6), randint(-6, 6), randint(-6, 6)
        
        # Two diagonal matrices in same basis
        D1 = [[λ1, 0, 0], [0, λ2, 0], [0, 0, λ3]]
        D2 = [[μ1, 0, 0], [0, μ2, 0], [0, 0, μ3]]
        
        d1_str = "\\text{diag}($(λ1), $(λ2), $(λ3))"
        d2_str = "\\text{diag}($(μ1), $(μ2), $(μ3))"
        
        problem(
            question="Let A and B be two 3×3 matrices over ℂ. Prove that if A and B are simultaneously diagonalizable, then AB = BA. Conversely, if A and B commute and both are diagonalizable with distinct eigenvalues, prove they are simultaneously diagonalizable. Apply this to verify that D₁ = $(d1_str) and D₂ = $(d2_str) are simultaneously diagonalizable.",
            answer="They commute and share eigenbasis",
            difficulty=(3800, 4500),
            answer_type="text",
            solution=steps(
                "Forward direction: If A = PD₁P⁻¹ and B = PD₂P⁻¹ for same P",
                "Then AB = PD₁P⁻¹PD₂P⁻¹ = PD₁D₂P⁻¹ = PD₂D₁P⁻¹ = BA",
                "Reverse: If AB = BA and both diagonalizable with distinct eigenvalues",
                "Then eigenspaces of A are B-invariant",
                "Since eigenvalues distinct, eigenspaces are 1-dimensional",
                "Common eigenvectors form a basis that diagonalizes both",
                "For given matrices: D₁D₂ = D₂D₁ (diagonal matrices commute)",
                "They share the standard basis as eigenbasis",
            ),
            time=360,
        )
        
    elseif problem_type == 3
        # Minimal polynomial and diagonalizability
        λ1 = randint(-7, 7)
        λ2 = randint(-7, 7)
        while λ2 == λ1
            λ2 = randint(-7, 7)
        end
        
        # Construct matrix with these eigenvalues
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        problem(
            question="Let A be a 4×4 matrix over ℂ with characteristic polynomial p(λ) = (λ - $(λ1))³(λ - $(λ2)). Prove that A is diagonalizable if and only if the minimal polynomial m(λ) divides (λ - $(λ1))(λ - $(λ2)). What are the possible Jordan canonical forms if A is NOT diagonalizable? Determine the maximum possible dimension of ker(A - $(λ1)I) in the non-diagonalizable case.",
            answer="m(λ) = (λ - $(λ1))(λ - $(λ2)) for diagonalizable; max dim ker = 2",
            difficulty=(3600, 4200),
            answer_type="text",
            solution=steps(
                "Diagonalizable ⟺ minimal polynomial has no repeated roots",
                "If diagonalizable: m(λ) = (λ - $(λ1))(λ - $(λ2))",
                "This requires geometric multiplicity = algebraic multiplicity for each eigenvalue",
                "Non-diagonalizable cases: $(λ1) has geom. mult. < 3",
                "Possible Jordan forms: one 2×2 block + one 1×1 for $(λ1), or one 3×3 block",
                "If 2×2 block for $(λ1): dim ker(A - $(λ1)I) = 2",
                "If 3×3 block: dim ker(A - $(λ1)I) = 1",
                "Maximum dimension in non-diagonalizable case: 2",
            ),
            time=300,
        )
        
    else
        # Power of matrix via diagonalization - computational olympiad problem
        λ1 = choice([-1, 1, 2, -2])
        λ2 = choice([-1, 1, 2, -2])
        while λ2 == λ1
            λ2 = choice([-1, 1, 2, -2])
        end
        
        n = randint(50, 150)
        
        # Create a nice 2×2 matrix with eigenvalues λ1, λ2
        # A = [[a, b], [c, d]] with trace = λ1 + λ2, det = λ1*λ2
        trace_val = λ1 + λ2
        det_val = λ1 * λ2
        
        a = randint(-3, 3)
        d = trace_val - a
        b = nonzero(-5, 5)
        c = (det_val - a*d) // b
        
        mat_str = "\\begin{bmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{bmatrix}"
        
        # Compute A^n using diagonalization
        # Need eigenvectors
        v1_str = "[1, ($(λ1) - $(a))/$(b)]"
        v2_str = "[1, ($(λ2) - $(a))/$(b)]"
        
        problem(
            question="Let A = $(mat_str). Use diagonalization to compute A^$(n). Express your answer as a 2×2 matrix. (Hint: First verify the eigenvalues are $(λ1) and $(λ2), then find eigenvectors and construct P such that A = PDP⁻¹.)",
            answer="PD^$(n)P^(-1)",
            difficulty=(3700, 4300),
            answer_type="text",
            solution=steps(
                "Characteristic polynomial: det(A - λI) = λ² - $(trace_val)λ + $(det_val) = (λ - $(λ1))(λ - $(λ2))",
                "Eigenvalues: λ₁ = $(λ1), λ₂ = $(λ2)",
                "Eigenvector for λ₁: solve (A - $(λ1)I)v = 0",
                "Eigenvector for λ₂: solve (A - $(λ2)I)v = 0",
                "Construct P = [v₁ | v₂] and D = diag($(λ1), $(λ2))",
                "Then A = PDP⁻¹, so A^$(n) = PD^$(n)P⁻¹",
                "D^$(n) = diag($(λ1)^$(n), $(λ2)^$(n))",
                "Compute P⁻¹ and multiply to get final answer",
            ),
            time=360,
        )
    end
end