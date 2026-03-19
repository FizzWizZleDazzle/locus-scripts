# linear_algebra - subspaces (competition)
# Generated: 2026-03-08T21:12:10.747168

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z w begin
    set_topic!("linear_algebra/subspaces")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Subspace intersection dimension problem
        n = randint(8, 15)
        dim_V = randint(4, n-2)
        dim_W = randint(4, n-2)
        
        # Use dimension formula: dim(V + W) = dim(V) + dim(W) - dim(V ∩ W)
        # Constraint: dim(V + W) ≤ n
        max_sum = min(n, dim_V + dim_W)
        dim_sum = randint(max(dim_V, dim_W), max_sum)
        dim_intersection = dim_V + dim_W - dim_sum
        
        question = "Let V and W be subspaces of ℝ^$(n) with dim(V) = $(dim_V) and dim(W) = $(dim_W). If dim(V + W) = $(dim_sum), find the minimum possible value of dim(V ∩ W). Prove that this minimum is achievable."
        
        answer = dim_intersection
        
        solution = steps(
            "Use the dimension formula for subspaces: dim(V + W) = dim(V) + dim(W) - dim(V ∩ W)",
            sol("Substitution", "$(dim_sum) = $(dim_V) + $(dim_W) - dim(V ∩ W)"),
            sol("Solving", "dim(V ∩ W) = $(dim_V) + $(dim_W) - $(dim_sum) = $(dim_intersection)"),
            "This is achievable: take V and W in general position with specified dimensions such that their sum has dimension $(dim_sum).",
            sol("Answer", dim_intersection)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 4000),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 2
        # Complementary subspace construction
        n = randint(10, 20)
        k = randint(3, n-3)
        
        # Generate a random property condition
        condition_type = choice(1:3)
        
        if condition_type == 1
            condition = "all vectors v with v₁ + v₂ + ... + v_$(k) = 0"
            complement_dim = n - (k - 1)
        elseif condition_type == 2
            condition = "all vectors v with v₁ = v₂ = ... = v_$(k) = 0"
            complement_dim = n - k
        else
            condition = "all vectors of the form (a₁, a₂, ..., a_$(k), 0, 0, ..., 0)"
            complement_dim = n - k
        end
        
        question = "Let V be the subspace of ℝ^$(n) consisting of $(condition). Find dim(V) and prove that V has a complementary subspace W (i.e., V ∩ W = {0} and V + W = ℝ^$(n))."
        
        if condition_type == 1
            answer = k - 1
        else
            answer = k
        end
        
        if condition_type == 1
            solution = steps(
                "The constraint v₁ + v₂ + ... + v_$(k) = 0 is one linear equation",
                "The solution space has dimension $(n) - 1 = $(k-1) when the constraint involves the first $(k) coordinates",
                sol("dim(V)", k-1),
                "For complementary subspace: Take W = span{e_$(k+1), e_$(k+2), ..., e_$(n), (1,1,...,1,0,...,0)} where the vector (1,1,...,1) has $(k) ones",
                "Then V ∩ W = {0} and V + W = ℝ^$(n)",
                sol("Answer", k-1)
            )
        elseif condition_type == 2
            solution = steps(
                "V consists of vectors with first $(k) coordinates zero",
                sol("V = span{e_$(k+1), e_$(k+2), ..., e_$(n)}", ""),
                sol("dim(V)", n-k),
                "Take W = span{e₁, e₂, ..., e_$(k)} as complementary subspace",
                "Then V ∩ W = {0} and V + W = ℝ^$(n)",
                sol("Answer", n-k)
            )
        else
            solution = steps(
                "V consists of vectors with last $(n-k) coordinates zero",
                sol("V = span{e₁, e₂, ..., e_$(k)}", ""),
                sol("dim(V)", k),
                "Take W = span{e_$(k+1), e_$(k+2), ..., e_$(n)} as complementary subspace",
                "Then V ∩ W = {0} and V + W = ℝ^$(n)",
                sol("Answer", k)
            )
        end
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4300),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 3
        # Lattice of subspaces counting problem
        n = randint(4, 7)
        k = randint(2, n-1)
        
        # Number of k-dimensional subspaces in F_q^n is Gaussian binomial coefficient
        # For olympiad level, we ask about specific small cases with F_2
        q = 2
        
        question = "In the vector space 𝔽₂^$(n) (the $(n)-dimensional vector space over the field with 2 elements), prove that every $(k)-dimensional subspace contains exactly 2^$(k) - 1 nonzero vectors. Then determine how many distinct $(k)-dimensional subspaces exist in 𝔽₂^$(n)."
        
        # Gaussian binomial coefficient [n choose k]_q for q=2
        # [n k]_2 = product (2^(n-i+1) - 1)/(2^i - 1) for i=1 to k
        numerator = 1
        denominator = 1
        for i in 1:k
            numerator *= (2^(n-i+1) - 1)
            denominator *= (2^i - 1)
        end
        answer = div(numerator, denominator)
        
        solution = steps(
            "A $(k)-dimensional subspace over 𝔽₂ has basis with $(k) vectors",
            "Total vectors: 2^$(k), including the zero vector",
            sol("Nonzero vectors per subspace", 2^k - 1),
            "For counting subspaces: Use Gaussian binomial coefficient [$(n) choose $(k)]₂",
            "Formula: ∏ᵢ₌₁^$(k) (2^($(n)-i+1) - 1)/(2^i - 1)",
            sol("Calculation", "$(numerator)/$(denominator) = $(answer)"),
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4000, 4500),
            solution=solution,
            time=360
        )
        
    elseif problem_type == 4
        # Invariant subspace problem
        n = randint(5, 10)
        k = randint(2, n-2)
        
        question = "Let T: ℝ^$(n) → ℝ^$(n) be a linear transformation with $(k) distinct real eigenvalues λ₁, λ₂, ..., λ_$(k). Let V be a T-invariant subspace of dimension $(k). Prove that if V contains an eigenvector for each eigenvalue λᵢ, then V is the direct sum of the corresponding eigenspaces. What is the maximum possible dimension of the intersection of V with the orthogonal complement of any single eigenspace?"
        
        answer = k - 1
        
        solution = steps(
            "Since V is T-invariant and contains eigenvector vᵢ for each λᵢ",
            "The eigenspaces Eᵢ = {v : Tv = λᵢv} have dim(Eᵢ) ≥ 1",
            "Eigenvectors for distinct eigenvalues are linearly independent",
            "Therefore V = E₁ ⊕ E₂ ⊕ ... ⊕ E_$(k) with dim(V) = $(k)",
            "Each Eᵢ has dimension 1 in this case",
            "The orthogonal complement of Eᵢ intersects V in the span of the other $(k-1) eigenspaces",
            sol("Maximum dimension of intersection", k-1),
            sol("Answer", k-1)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4200, 4700),
            solution=solution,
            time=300
        )
        
    else
        # Subspace lattice isomorphism
        p = choice([2, 3, 5])
        n = randint(3, 5)
        
        question = "Let V = 𝔽_$(p)^$(n) be the $(n)-dimensional vector space over the field 𝔽_$(p). Prove that the lattice of subspaces of V (ordered by inclusion) is self-dual. Specifically, if L(V) denotes this lattice, prove that L(V) ≅ L(V)* where L(V)* is the dual lattice. What is the key bijection establishing this isomorphism?"
        
        answer_text = "The annihilator map: W ↦ W⊥"
        
        solution = steps(
            "Define annihilator: W⊥ = {φ ∈ V* : φ(w) = 0 for all w ∈ W}",
            "Key property: dim(W) + dim(W⊥) = $(n) for any subspace W",
            "The map W ↦ W⊥ reverses inclusions: W₁ ⊆ W₂ implies W₂⊥ ⊆ W₁⊥",
            "This map is bijective since (W⊥)⊥ = W under the identification V ≅ V**",
            sol("Therefore", "L(V) ≅ L(V)* via W ↦ W⊥"),
            "The isomorphism is an order-reversing bijection",
            sol("Answer", "Annihilator map W ↦ W⊥")
        )
        
        problem(
            question=question,
            answer=answer_text,
            answer_type="text",
            difficulty=(4400, 4900),
            solution=solution,
            time=360
        )
    end
end