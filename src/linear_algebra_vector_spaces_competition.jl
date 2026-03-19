# linear_algebra - vector_spaces (competition)
# Generated: 2026-03-08T21:11:06.207430

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z w begin
    set_topic!("linear_algebra/vector_spaces")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Dimension of intersection of subspaces with complicated polynomial constraints
        n = rand(4:7)
        k1 = rand(2:n-1)
        k2 = rand(2:n-1)
        
        # Generate polynomial constraints
        coeffs1 = [nonzero(-3, 3) for _ in 1:k1]
        coeffs2 = [nonzero(-3, 3) for _ in 1:k2]
        
        # Compute dimension using inclusion-exclusion
        # For generic positions, dim(V ∩ W) = dim(V) + dim(W) - dim(V + W)
        # and dim(V + W) ≤ min(n, dim(V) + dim(W))
        
        overlap = rand(0:min(k1, k2)-1)
        dim_intersection = max(0, k1 + k2 - n + overlap)
        
        constraint_str1 = join(["$(coeffs1[i])x_$i" for i in 1:k1], " + ")
        constraint_str2 = join(["$(coeffs2[i])x_$i" for i in 1:k2], " + ")
        
        problem(
            question="Let V be the subspace of \\mathbb{R}^{$n} defined by the equation \$$(constraint_str1) = 0\$, and let W be the subspace defined by \$$(constraint_str2) = 0\$. Assume the defining equations are in general position. What is the dimension of V ∩ W?",
            answer=dim_intersection,
            difficulty=(3500, 3800),
            solution=steps(
                "V is defined by 1 independent linear equation in \\mathbb{R}^{$n}, so dim(V) = $(n-1)",
                "W is defined by 1 independent linear equation in \\mathbb{R}^{$n}, so dim(W) = $(n-1)",
                "For subspaces in general position: dim(V ∩ W) = dim(V) + dim(W) - dim(V + W)",
                "Since dim(V + W) ≤ n, we have dim(V ∩ W) ≥ dim(V) + dim(W) - n = $(n-1) + $(n-1) - $n = $(2n-2-n)",
                sol("Answer", dim_intersection)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Number of subspaces of given dimension in F_p^n
        p = choice([2, 3, 5])
        n = rand(3:5)
        k = rand(1:n-1)
        
        # Gaussian binomial coefficient [n choose k]_q where q = p
        # Number of k-dimensional subspaces in F_p^n
        function gaussian_binomial(n, k, q)
            if k > n || k < 0
                return 0
            end
            if k == 0 || k == n
                return 1
            end
            num = prod([(q^(n-i+1) - 1) for i in 1:k])
            den = prod([(q^i - 1) for i in 1:k])
            return div(num, den)
        end
        
        ans = gaussian_binomial(n, k, p)
        
        problem(
            question="How many $k-dimensional subspaces are there in \\mathbb{F}_$p^{$n}? (Express as an integer.)",
            answer=ans,
            difficulty=(3800, 4200),
            solution=steps(
                "The number of k-dimensional subspaces of \\mathbb{F}_q^n is the Gaussian binomial coefficient \\binom{n}{k}_q",
                "Formula: \\binom{n}{k}_q = \\frac{(q^n - 1)(q^{n-1} - 1)\\cdots(q^{n-k+1} - 1)}{(q^k - 1)(q^{k-1} - 1)\\cdots(q - 1)}",
                "With q = $p, n = $n, k = $k:",
                "Numerator: " * join(["($p^$(n-i+1) - 1)" for i in 1:k], " × "),
                "Denominator: " * join(["($p^$i - 1)" for i in 1:k], " × "),
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Lattice of subspaces - maximal chains
        n = rand(4:6)
        
        # Number of maximal chains in the lattice of subspaces of F_2^n
        # This equals n! times product of Gaussian binomials
        ans = factorial(n)
        
        problem(
            question="In the lattice of all subspaces of \\mathbb{F}_2^{$n}, how many maximal chains are there from {0} to \\mathbb{F}_2^{$n}? (A maximal chain has length $n.)",
            answer=ans,
            difficulty=(4000, 4400),
            solution=steps(
                "A maximal chain has the form {0} ⊂ V_1 ⊂ V_2 ⊂ ... ⊂ V_{$n} = \\mathbb{F}_2^{$n}",
                "where dim(V_i) = i for each i",
                "At each step i, we choose a (i)-dimensional subspace containing V_{i-1}",
                "This is equivalent to choosing a 1-dimensional subspace of the quotient V_i / V_{i-1}",
                "Over \\mathbb{F}_2, each quotient space has exactly 1 non-zero vector up to scaling",
                "The count simplifies to the number of ordered bases, which is $(n)!",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Complementary subspaces - counting
        n = rand(5:7)
        k = rand(2:n-2)
        
        # For a fixed k-dimensional subspace V in F_q^n,
        # number of (n-k)-dimensional complements W (V ∩ W = {0}, V + W = F_q^n)
        q = 2
        ans = prod([(q^(n-i+1) - q^(k-i+1)) ÷ (q^(n-k-i+1) - 1) for i in 1:n-k])
        
        problem(
            question="Let V be a fixed $k-dimensional subspace of \\mathbb{F}_2^{$n}. How many $(n-k)-dimensional subspaces W satisfy V ∩ W = {0} and V + W = \\mathbb{F}_2^{$n}? (Such W are called complements of V.)",
            answer=ans,
            difficulty=(4200, 4600),
            solution=steps(
                "W is a complement of V iff \\mathbb{F}_2^{$n} = V ⊕ W (internal direct sum)",
                "This is equivalent to: dim(W) = $(n-k), V ∩ W = {0}",
                "We need to count $(n-k)-dimensional subspaces avoiding V",
                "Using the formula for complements in finite fields:",
                "Number = \\prod_{i=1}^{$(n-k)} \\frac{2^{$(n)-i+1} - 2^{$(k)-i+1}}{2^{$(n-k)-i+1} - 1}",
                sol("Evaluating gives", ans)
            ),
            time=300
        )
        
    elseif problem_type == 5
        # Grassmannian: dimension as a variety
        n = rand(4:8)
        k = rand(2:n-2)
        
        # Dimension of Grassmannian Gr(k, n) as a variety
        ans = k * (n - k)
        
        problem(
            question="What is the dimension of the Grassmannian Gr($k, $n) as an algebraic variety? (The Grassmannian Gr(k, n) parametrizes all $k-dimensional subspaces of \\mathbb{C}^{$n}.)",
            answer=ans,
            difficulty=(3600, 4000),
            solution=steps(
                "The Grassmannian Gr(k, n) can be viewed as the quotient GL(n) / P",
                "where P is the stabilizer of a k-dimensional subspace",
                "Alternatively, use Plücker embedding: Gr(k, n) embeds in \\mathbb{P}^{\\binom{n}{k}-1}",
                "The dimension is computed from degrees of freedom:",
                "A k × n matrix has kn entries, but row operations (GL(k)) don't change the row space",
                "dim(Gr(k, n)) = kn - k² = k(n - k) = $k × $(n-k)",
                sol("Answer", ans)
            ),
            time=240
        )
        
    else
        # Annihilator dimension
        n = rand(5:8)
        k = rand(2:n-2)
        
        # For a k-dimensional subspace V of F^n, the annihilator V° in (F^n)* has dimension n-k
        ans = n - k
        
        problem(
            question="Let V be a $k-dimensional subspace of \\mathbb{R}^{$n}. The annihilator V^\\circ is defined as V^\\circ = {f ∈ (\\mathbb{R}^{$n})^* : f(v) = 0 for all v ∈ V}. What is the dimension of V^\\circ?",
            answer=ans,
            difficulty=(3500, 3900),
            solution=steps(
                "The annihilator V^\\circ is a subspace of the dual space (\\mathbb{R}^{$n})^*",
                "A linear functional f is in V^\\circ iff it vanishes on all of V",
                "By the rank-nullity theorem applied to the evaluation map (\\mathbb{R}^{$n})^* → V^*:",
                "dim(V^\\circ) + dim(V^*) = dim((\\mathbb{R}^{$n})^*)",
                "Since dim(V^*) = dim(V) = $k and dim((\\mathbb{R}^{$n})^*) = $n:",
                sol("dim(V^\\circ) = $n - $k", ans)
            ),
            time=240
        )
    end
end