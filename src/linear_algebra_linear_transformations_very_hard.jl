# linear_algebra - linear_transformations (very_hard)
# Generated: 2026-03-08T21:15:35.346147

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/linear_transformations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Competition: Eigenspace intersection problem
        # T: R^3 -> R^3, find dim of intersection of eigenspaces
        λ1 = randint(2, 7)
        λ2 = randint(-6, -2)
        
        # Create transformation matrix with known eigenvalues
        # Using diagonal blocks for controlled eigenspaces
        a11 = randint(-3, 3)
        a12 = randint(-2, 2)
        a21 = nonzero(-3, 3)
        
        # Eigenspace for λ1 has dimension 2 (first two coords)
        # Eigenspace for λ2 has dimension 1 (last coord)
        # Their intersection is {0}
        
        question = "Let T: \\mathbb{R}^3 \\to \\mathbb{R}^3 be a linear transformation with eigenvalues λ₁ = $λ1 (algebraic multiplicity 2) and λ₂ = $λ2 (algebraic multiplicity 1). If the eigenspace E_{λ₁} has geometric multiplicity 2 and E_{λ₂} has geometric multiplicity 1, what is the dimension of E_{λ₁} ∩ E_{λ₂}?"
        
        answer = 0
        difficulty = (2600, 2900)
        
        solution = steps(
            "Eigenspaces for distinct eigenvalues are linearly independent",
            "If v ∈ E_{λ₁} ∩ E_{λ₂}, then Tv = λ₁v and Tv = λ₂v",
            "This implies λ₁v = λ₂v, so (λ₁ - λ₂)v = 0",
            "Since λ₁ ≠ λ₂, we have v = 0",
            sol("Answer: dim(E_{λ₁} ∩ E_{λ₂})", 0)
        )
        
    elseif problem_type == 2
        # Olympiad: Nilpotent transformation composition
        n = randint(4, 6)
        k = randint(2, n-1)
        
        question = "Let T: \\mathbb{R}^$n \\to \\mathbb{R}^$n be a linear transformation such that T^$k = 0 but T^$(k-1) ≠ 0. What is the maximum possible rank of T^$(k-1)?"
        
        # Answer: rank(T^(k-1)) ≤ n - (k-1)
        # Maximum is achieved when the Jordan blocks are optimally arranged
        answer = n - k + 1
        difficulty = (3200, 3500)
        
        solution = steps(
            "Since T^$k = 0, T is nilpotent with index at most $k",
            "The condition T^$(k-1) ≠ 0 means the index is exactly $k",
            "For nilpotent T with index k, rank(T^$(k-1)) ≤ dim(ker(T^$(k-1))ᶜ)",
            "By rank-nullity and nilpotency structure: rank(T^$(k-1)) ≤ $n - $(k-1) = $(n-k+1)",
            "This maximum is achieved with appropriate Jordan block structure",
            sol("Answer", answer)
        )
        
    elseif problem_type == 3
        # Competition: Trace and determinant constraint
        n = randint(3, 5)
        tr_val = randint(5, 15)
        
        question = "How many linear transformations T: \\mathbb{R}^$n \\to \\mathbb{R}^$n satisfy T² = $tr_val·I, where I is the identity transformation? (Count distinct transformations up to similarity.)"
        
        # T² = cI means T has eigenvalues ±√c
        # Number of distinct Jordan forms depends on multiplicity distributions
        sqrt_val = isqrt(tr_val)
        
        if sqrt_val^2 == tr_val
            # Perfect square: eigenvalues ±√tr_val
            # Count partitions of n into parts of size allowing ±√tr_val
            # For diagonalizable: number of ways to split n = a + b where a+b=n
            answer = n + 1  # Simplified: diagonal forms only
            difficulty = (2800, 3200)
        else
            answer = 0
            difficulty = (2600, 2900)
        end
        
        solution = steps(
            "T² = $tr_val·I implies T² - $tr_val·I = 0",
            "The minimal polynomial divides x² - $tr_val",
            sqrt_val^2 == tr_val ? "Since $tr_val = $(sqrt_val)², eigenvalues are ±$(sqrt_val)" : "Since $tr_val is not a perfect square, no real eigenvalues exist",
            sqrt_val^2 == tr_val ? "Diagonalizable T correspond to distributions of $n total eigenvalues" : "No such transformations exist over ℝ",
            sqrt_val^2 == tr_val ? "Counting similarity classes: $(n+1) diagonal forms" : "",
            sol("Answer", answer)
        )
        
    elseif problem_type == 4
        # Olympiad: Invariant subspace lattice
        dim_V = randint(4, 6)
        dim_W = randint(2, dim_V - 2)
        
        question = "Let T: \\mathbb{R}^$dim_V \\to \\mathbb{R}^$dim_V be a linear transformation such that every subspace of dimension $dim_W is T-invariant. Prove that T must be a scalar multiple of the identity, and find the minimum number of distinct eigenvalues T can have."
        
        answer = 1
        difficulty = (3400, 3700)
        
        solution = steps(
            "If every $dim_W-dimensional subspace is T-invariant, consider any two such subspaces U and W with U ≠ W",
            "Their intersection has dimension at least $dim_W + $dim_W - $dim_V = $(2*dim_W - dim_V)",
            "For generic position, U ∩ W can have varying dimensions",
            "The only linear transformation preserving ALL subspaces of a given dimension is scalar multiplication",
            "By Schur's lemma generalization: T = λI for some scalar λ",
            sol("Minimum distinct eigenvalues", 1)
        )
        
    else  # problem_type == 5
        # Competition: Rank inequality chain
        n = randint(4, 7)
        k = randint(2, n-2)
        
        question = "Let S, T: \\mathbb{R}^$n \\to \\mathbb{R}^$n be linear transformations with rank(S) = $k and rank(T) = $(k+1). What is the minimum possible value of rank(ST) + rank(TS)?"
        
        # Using Sylvester's rank inequality
        # rank(AB) ≥ rank(A) + rank(B) - n
        min_rank_ST = max(0, k + (k+1) - n)
        min_rank_TS = max(0, (k+1) + k - n)
        answer = min_rank_ST + min_rank_TS
        
        difficulty = (2700, 3100)
        
        solution = steps(
            "Apply Sylvester's rank inequality: rank(AB) ≥ rank(A) + rank(B) - $n",
            sol("For ST", "rank(ST) ≥ $k + $(k+1) - $n = $(k+k+1-n)"),
            sol("For TS", "rank(TS) ≥ $(k+1) + $k - $n = $(k+k+1-n)"),
            "The minimum is achieved when both inequalities are tight",
            "This occurs when ker(S) and ker(T) are positioned appropriately",
            sol("Minimum rank(ST) + rank(TS)", max(0, answer))
        )
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution,
        time=240,
        calculator="none"
    )
end