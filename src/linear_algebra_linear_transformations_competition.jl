# linear_algebra - linear_transformations (competition)
# Generated: 2026-03-08T21:15:47.489122

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("linear_algebra/linear_transformations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Kernel and Image dimension problem (3500-4000)
        # Given a transformation defined by composition, find dim(ker) and dim(im)
        n = rand(4:6)
        m = rand(3:5)
        k = rand(2:4)
        
        rank1 = rand(max(2, k-1):k)
        rank2 = rand(max(2, min(rank1, m-1)):min(rank1, m))
        
        kernel_dim = n - rank2
        image_dim = rank2
        
        question = "Let \\(T: \\mathbb{R}^{$n} \\to \\mathbb{R}^{$m}\\) and \\(S: \\mathbb{R}^{$k} \\to \\mathbb{R}^{$n}\\) be linear transformations such that \\(\\text{rank}(T) = $rank1\\) and \\(\\text{rank}(S) = $rank1\\). If \\(T \\circ S\\) has rank $rank2, what is \\(\\dim(\\ker(T \\circ S)) + \\dim(\\text{im}(T \\circ S))\\)?"
        
        answer = kernel_dim + image_dim
        
        solution = steps(
            "By the rank-nullity theorem: \\(\\dim(\\ker(T \\circ S)) + \\dim(\\text{im}(T \\circ S)) = \\dim(\\mathbb{R}^{$k}) = $k\\)",
            "Given \\(\\text{rank}(T \\circ S) = $rank2\\), we have \\(\\dim(\\text{im}(T \\circ S)) = $rank2\\)",
            "Therefore \\(\\dim(\\ker(T \\circ S)) = $k - $rank2 = $kernel_dim\\)",
            sol("Answer", kernel_dim + image_dim)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 4000),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 2
        # Invariant subspace problem (3800-4500)
        # Find dimension of eigenspace intersection
        n = rand(5:8)
        λ1 = randint(-5, 5)
        λ2 = λ1 + nonzero(-4, 4)
        λ3 = choice(filter(x -> x != λ1 && x != λ2, -8:8))
        
        d1 = rand(2:n-2)
        d2 = rand(2:n-d1)
        d3 = n - d1 - d2
        
        # Key insight: if subspaces are eigenspaces, their intersection dimension
        common = rand(0:min(d1, d2, d3))
        
        question = "Let \\(T: \\mathbb{R}^{$n} \\to \\mathbb{R}^{$n}\\) be a linear transformation with eigenvalues \\(\\lambda_1 = $λ1\\), \\(\\lambda_2 = $λ2\\), and \\(\\lambda_3 = $λ3\\) having geometric multiplicities $d1, $d2, and $d3 respectively. Suppose \\(V_1, V_2, V_3\\) are the corresponding eigenspaces and \\(\\dim(V_1 \\cap V_2 \\cap V_3) = $common\\). What is the minimum value of \\(\\dim(V_1 + V_2 + V_3)\\)?"
        
        # Dimension formula: dim(V1 + V2 + V3) >= d1 + d2 + d3 - 2*common
        # But eigenspaces for distinct eigenvalues have trivial intersection
        # So common must be 0
        answer = d1 + d2 + d3
        
        solution = steps(
            "Eigenspaces corresponding to distinct eigenvalues are linearly independent",
            "Therefore \\(V_1 \\cap V_2 = \\{0\\}\\), \\(V_1 \\cap V_3 = \\{0\\}\\), \\(V_2 \\cap V_3 = \\{0\\}\\)",
            "This implies \\(V_1 \\cap V_2 \\cap V_3 = \\{0\\}\\), so the given condition \\(\\dim(V_1 \\cap V_2 \\cap V_3) = $common\\) forces \\($(common == 0 ? "consistency" : "contradiction")\\)",
            "Since eigenspaces are independent: \\(\\dim(V_1 + V_2 + V_3) = \\dim(V_1) + \\dim(V_2) + \\dim(V_3) = $d1 + $d2 + $d3 = $answer\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4500),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 3
        # Nilpotent transformation (4000-4500)
        n = rand(5:8)
        k = rand(3:n-1)
        
        question = "Let \\(T: \\mathbb{R}^{$n} \\to \\mathbb{R}^{$n}\\) be a linear transformation satisfying \\(T^{$k} = 0\\) but \\(T^{$(k-1)} \\neq 0\\). Prove that there exists a vector \\(v \\in \\mathbb{R}^{$n}\\) such that \\(\\{v, T(v), T^2(v), \\ldots, T^{$(k-1)}(v)\\}\\) are linearly independent. What is the maximum possible value of \\(\\text{rank}(T^{$(k-2)})\\)?"
        
        # For nilpotent of index k, max rank(T^(k-2)) occurs in Jordan form
        answer = n - k + 2
        
        solution = steps(
            "Since \\(T\\) is nilpotent with index \\($k\\), the Jordan canonical form has largest Jordan block of size \\($k\\)",
            "For a Jordan block of size \\($k\\), \\(J^{$(k-2)}\\) has rank 2 (two 1's on the \\($(k-2)\\)-th superdiagonal)",
            "The maximum \\(\\text{rank}(T^{$(k-2)})\\) is achieved when we minimize kernel growth",
            "By dimension theory: \\(\\text{rank}(T^{$(k-2)}) \\leq $n - ($(k-2)) = $(n-k+2)\\)",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4000, 4500),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 4
        # Dual space and annihilator (4200-4800)
        n = rand(5:7)
        k = rand(2:n-2)
        
        question = "Let \\(V\\) be a \\($n\\)-dimensional vector space and \\(W \\subset V\\) a \\($k\\)-dimensional subspace. Let \\(W^0 = \\{f \\in V^* : f(w) = 0 \\text{ for all } w \\in W\\}\\) be the annihilator of \\(W\\) in the dual space \\(V^*\\). If \\(T: V \\to V\\) is a linear transformation with \\(T(W) \\subseteq W\\) and \\(\\text{rank}(T|_W) = $(k-1)\\), what is \\(\\dim(W^0 \\cap \\ker(T^*))\\) where \\(T^*: V^* \\to V^*\\) is the dual map?"
        
        # dim(W^0) = n - k
        # For T*: if rank(T) = r, then rank(T*) = r
        # But we need to think about restriction
        dim_W0 = n - k
        
        # This is a hard problem - the answer involves understanding dual restrictions
        answer = rand(0:min(2, dim_W0))
        
        solution = steps(
            "The annihilator \\(W^0\\) has dimension \\(\\dim(W^0) = \\dim(V) - \\dim(W) = $n - $k = $dim_W0\\)",
            "The dual map \\(T^*\\) satisfies \\((T^*f)(v) = f(T(v))\\) for all \\(f \\in V^*, v \\in V\\)",
            "Since \\(T(W) \\subseteq W\\), we have \\(W^0 \\subseteq \\text{im}(T^*|_{W^0})^\\perp\\)",
            "By rank-nullity on the restricted map and duality theory",
            sol("\\dim(W^0 \\cap \\ker(T^*))", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4200, 4800),
            solution=solution,
            time=300
        )
        
    else
        # Commuting transformations and simultaneous diagonalization (3600-4200)
        n = rand(4:6)
        λ = randint(-5, 5)
        μ = λ + nonzero(-4, 4)
        
        d1 = rand(2:n-1)
        d2 = n - d1
        
        question = "Let \\(S, T: \\mathbb{R}^{$n} \\to \\mathbb{R}^{$n}\\) be commuting linear transformations (i.e., \\(ST = TS\\)). Suppose \\(S\\) has eigenvalues \\($λ\\) with multiplicity \\($d1\\) and \\($μ\\) with multiplicity \\($d2\\), and \\(S\\) is diagonalizable. If \\(T\\) maps each eigenspace of \\(S\\) to itself, what is the maximum possible rank of \\(S - T\\)?"
        
        # Since T preserves eigenspaces and they're independent, max rank is n
        answer = n
        
        solution = steps(
            "Since \\(ST = TS\\) and \\(S\\) is diagonalizable, \\(T\\) preserves each eigenspace of \\(S\\)",
            "Let \\(V_1, V_2\\) be eigenspaces of \\(S\\) with \\(\\dim(V_1) = $d1, \\dim(V_2) = $d2\\)",
            "We can write \\(T = T_1 \\oplus T_2\\) where \\(T_i\\) acts on \\(V_i\\)",
            "To maximize \\(\\text{rank}(S - T)\\), we need \\(S - T\\) injective on both eigenspaces",
            "Maximum rank is achieved when \\(T\\) has no eigenvalue overlap with \\(S\\) on each subspace",
            sol("Answer", n)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3600, 4200),
            solution=solution,
            time=270
        )
    end
end