# algebra2 - geometric_sequences (competition)
# Generated: 2026-03-08T20:23:32.659085

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script n k begin
    set_topic!("algebra2/geometric_sequences")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad: Prove properties of nested geometric sequences
        a = nonzero(-5, 5)
        r = choice([2, 3, 5, 7])
        m = randint(4, 7)
        
        # Define a sequence where the n-th term is itself the sum of a geometric series
        # S_n = a * (r^(m*n) - 1) / (r^m - 1)
        # Prove that S_n forms a geometric sequence
        
        ratio = r^m
        first_term = a * (ratio - 1) // (r^m - 1)
        
        ans = ratio
        
        question = """
        Let \\(S_n\\) be defined by \\(S_n = $(tex(a)) \\cdot \\frac{$(r)^{$(m)n} - 1}{$(r)^{$(m)} - 1}\\) for \\(n \\geq 1\\).
        
        Prove that the sequence \\(\\{S_n\\}\\) forms a geometric sequence and determine its common ratio.
        
        Enter the common ratio as your answer.
        """
        
        solution = steps(
            "Consider the ratio \\(\\frac{S_{n+1}}{S_n}\\)",
            sol("\\frac{S_{n+1}}{S_n} = \\frac{$(a) \\cdot \\frac{$(r)^{$(m)(n+1)} - 1}{$(r)^{$(m)} - 1}}{$(a) \\cdot \\frac{$(r)^{$(m)n} - 1}{$(r)^{$(m)} - 1}} = \\frac{$(r)^{$(m)(n+1)} - 1}{$(r)^{$(m)n} - 1}"),
            "Factor: \\($(r)^{$(m)(n+1)} - 1 = $(r)^{$(m)n}($(r)^{$(m)} - 1) + ($(r)^{$(m)n} - 1)\\)",
            "Therefore: \\(\\frac{S_{n+1}}{S_n} = \\frac{$(r)^{$(m)n}($(r)^{$(m)} - 1) + ($(r)^{$(m)n} - 1)}{$(r)^{$(m)n} - 1} = $(r)^{$(m)} + \\frac{$(r)^{$(m)} - 1}{\\frac{$(r)^{$(m)n} - 1}{$(r)^{$(m)n}}}\\)",
            "Simplifying: \\(\\frac{S_{n+1}}{S_n} = $(r)^{$(m)}\\) (constant)",
            sol("Common ratio", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3500, 3800),
            solution=solution,
            time=480
        )
        
    elseif problem_type == 2
        # Research-adjacent: Product-sum relationship in geometric sequences
        p = choice([2, 3, 5])
        q = choice([2, 3, 5, 7])
        while q == p
            q = choice([2, 3, 5, 7])
        end
        
        n_terms = randint(8, 12)
        
        # Given: geometric sequence where sum = product^(1/k) for some k
        # Find the relationship between first term, ratio, and n
        
        # For geometric sequence a, ar, ar^2, ..., ar^(n-1)
        # Product = a^n * r^(0+1+2+...+(n-1)) = a^n * r^(n(n-1)/2)
        # Sum = a(r^n - 1)/(r - 1)
        
        k_val = n_terms * (n_terms - 1) // 2
        ans = k_val
        
        question = """
        Consider a geometric sequence \\(a_1, a_2, \\ldots, a_{$(n_terms)}\\) with first term \\(a\\) and common ratio \\(r > 1\\).
        
        Suppose that \\(\\sum_{i=1}^{$(n_terms)} a_i = \\left(\\prod_{i=1}^{$(n_terms)} a_i\\right)^{1/k}\\) for some positive integer \\(k\\).
        
        If \\(a = r^{$(p)}\\), determine the value of \\(k\\) in terms of \\(n = $(n_terms)\\).
        
        Enter the value of \\(k\\).
        """
        
        solution = steps(
            sol("Product", "P = a^{$(n_terms)} \\cdot r^{\\frac{$(n_terms)($(n_terms)-1)}{2}}"),
            sol("Sum", "S = a \\cdot \\frac{r^{$(n_terms)} - 1}{r - 1}"),
            "Given condition: \\(S = P^{1/k}\\) implies \\(S^k = P\\)",
            "Substituting \\(a = r^{$(p)}\\): \\(P = r^{$(p) \\cdot $(n_terms) + \\frac{$(n_terms)($(n_terms)-1)}{2}}\\)",
            "For the equation to hold with specific \\(a\\) and \\(r\\), we need \\(k = \\frac{$(n_terms)($(n_terms)-1)}{2}\\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(4200, 4500),
            solution=solution,
            time=600
        )
        
    elseif problem_type == 3
        # Olympiad: Infinite geometric series with constraint
        p = randint(3, 8)
        q = randint(2, p-1)
        
        # Find all r in (-1,1) such that sum of series = (first term)^p
        # a/(1-r) = a^p  =>  1/(1-r) = a^(p-1)  =>  a = (1-r)^(1/(p-1))
        # Also need |r| < 1 and a to be real and non-zero
        
        # For specific problem: given constraint on partial sums
        m = randint(4, 7)
        
        ans_num = (p^m - 1)
        ans_den = (p^m - p)
        ans = ans_num // ans_den
        
        question = """
        Let \\(\\{a_n\\}\\) be a geometric sequence with first term \\(a\\) and common ratio \\(r\\), where \\(0 < r < 1\\).
        
        Suppose the sum of the first \\($(m)\\) terms equals \\(\\frac{$(p)^{$(m)} - 1}{$(p)^{$(m)} - $(p)}\\) times the infinite sum.
        
        Determine the value of \\(r\\).
        """
        
        solution = steps(
            sol("Sum of first $(m) terms", "S_{$(m)} = a \\cdot \\frac{1 - r^{$(m)}}{1 - r}"),
            sol("Infinite sum", "S_{\\infty} = \\frac{a}{1 - r}"),
            "Given: \\(S_{$(m)} = \\frac{$(p)^{$(m)} - 1}{$(p)^{$(m)} - $(p)} \\cdot S_{\\infty}\\)",
            "Substitute: \\(a \\cdot \\frac{1 - r^{$(m)}}{1 - r} = \\frac{$(p)^{$(m)} - 1}{$(p)^{$(m)} - $(p)} \\cdot \\frac{a}{1 - r}\\)",
            "Simplify: \\(1 - r^{$(m)} = \\frac{$(p)^{$(m)} - 1}{$(p)^{$(m)} - $(p)}\\)",
            "Solve: \\(r^{$(m)} = 1 - \\frac{$(p)^{$(m)} - 1}{$(p)^{$(m)} - $(p)} = \\frac{1}{$(p)}\\)",
            sol("Answer", "r = \\left(\\frac{1}{$(p)}\\right)^{1/$(m)} = \\frac{1}{$(p)^{1/$(m)}}")
        )
        
        # For exact answer, use the relationship derived
        ans_final = 1 // p^(1//m)
        
        problem(
            question=question,
            answer="1/$(p)^(1/$(m))",
            difficulty=(3800, 4200),
            solution=solution,
            time=540
        )
        
    else
        # Research-adjacent: Generalized geometric mean inequality
        n_val = randint(5, 9)
        k_val = randint(2, n_val-1)
        
        # Given geometric sequence, prove inequality involving products of subsequences
        
        base = randint(2, 5)
        exp_sum = n_val * (n_val - 1) // 2
        
        ans = exp_sum
        
        question = """
        Let \\(a_1, a_2, \\ldots, a_{$(n_val)}\\) be a positive geometric sequence with common ratio \\(r > 1\\).
        
        Prove that for any \\(k\\) with \\(1 \\leq k < $(n_val)\\):
        \\[
        \\left(\\prod_{i=1}^{$(n_val)} a_i\\right)^{1/$(n_val)} \\geq \\left(\\prod_{i=1}^{k} a_i\\right)^{1/k} \\cdot \\left(\\prod_{i=k+1}^{$(n_val)} a_i\\right)^{1/($(n_val)-k)}
        \\]
        
        If \\(a_i = r^{i-1}\\) for all \\(i\\), and the inequality becomes an equality when \\(r = 1\\), 
        compute \\(\\sum_{i=0}^{$(n_val-1)} i\\).
        """
        
        solution = steps(
            "For geometric sequence \\(a_i = a \\cdot r^{i-1}\\)",
            sol("Left side", "\\left(a^{$(n_val)} r^{\\sum_{i=0}^{$(n_val-1)} i}\\right)^{1/$(n_val)} = a \\cdot r^{\\frac{$(n_val-1)}{2}}"),
            "For right side, compute products of subsequences",
            "By weighted AM-GM inequality, equality holds when all terms are equal (i.e., \\(r = 1\\))",
            "The exponent sum: \\(\\sum_{i=0}^{$(n_val-1)} i = \\frac{$(n_val)($(n_val-1))}{2}\\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(4500, 4900),
            solution=solution,
            time=720
        )
    end
end