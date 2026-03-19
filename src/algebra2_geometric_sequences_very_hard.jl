# algebra2 - geometric_sequences (very_hard)
# Generated: 2026-03-08T20:23:09.472938

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("algebra2/geometric_sequences")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition: Find sum of geometric series with constraints (2500-3000)
        a = nonzero(-8, 8)
        r_num = nonzero(-5, 5)
        r_den = nonzero(2, 6)
        while gcd(abs(r_num), r_den) != 1 || abs(r_num) == r_den
            r_num = nonzero(-5, 5)
            r_den = nonzero(2, 6)
        end
        r = r_num // r_den
        n_terms = randint(8, 15)
        
        # Sum formula: S_n = a(1 - r^n)/(1 - r)
        sum_val = a * (1 - r^n_terms) // (1 - r)
        
        problem(
            question="A geometric sequence has first term \$a = $(a)\$ and common ratio \$r = $(tex(r))\$. Find the exact sum of the first \$$(n_terms)\$ terms.",
            answer=sum_val,
            difficulty=(2500, 2800),
            solution=steps(
                sol("Given", "a = $(a), r = $(tex(r)), n = $(n_terms)"),
                "Use the geometric sum formula: \$S_n = \\frac{a(1 - r^n)}{1 - r}\$",
                "Substitute: \$S_{$(n_terms)} = \\frac{$(a)(1 - ($(tex(r)))^{$(n_terms)})}{1 - $(tex(r))}\$",
                "Calculate \$($(tex(r)))^{$(n_terms)} = $(tex(r^n_terms))\$",
                "Simplify: \$S_{$(n_terms)} = \\frac{$(a)(1 - $(tex(r^n_terms)))}{$(tex(1 - r))}\$",
                sol("Answer", sum_val)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Competition: Find nth term given conditions (2600-3200)
        k = randint(3, 6)
        m = randint(k + 3, k + 8)
        
        # Pick ratio
        r_options = [2//1, 3//1, 1//2, 1//3, 3//2, 2//3, 4//1, 1//4]
        r = choice(r_options)
        
        # a_k and a_m values
        a_k_val = nonzero(-120, 120)
        a_m_val = a_k_val * r^(m - k)
        
        # Find a_1
        a_1 = a_k_val // (r^(k - 1))
        
        # Target term
        target = randint(m + 2, m + 6)
        a_target = a_1 * r^(target - 1)
        
        problem(
            question="In a geometric sequence, the \$$(k)\$-th term is \$$(tex(a_k_val))\$ and the \$$(m)\$-th term is \$$(tex(a_m_val))\$. Find the \$$(target)\$-th term.",
            answer=a_target,
            difficulty=(2600, 3200),
            solution=steps(
                sol("Given", "a_{$(k)} = $(tex(a_k_val)), a_{$(m)} = $(tex(a_m_val))"),
                "For geometric sequence: \$a_m = a_k \\cdot r^{m-k}\$",
                "Find ratio: \$r^{$(m-k)} = \\frac{$(tex(a_m_val))}{$(tex(a_k_val))} = $(tex(a_m_val // a_k_val))\$",
                "Therefore \$r = $(tex(r))\$",
                "Find first term: \$a_1 = \\frac{a_{$(k)}}{r^{$(k-1)}} = \\frac{$(tex(a_k_val))}{$(tex(r^(k-1)))} = $(tex(a_1))\$",
                "Calculate \$a_{$(target)} = a_1 \\cdot r^{$(target-1)} = $(tex(a_1)) \\cdot $(tex(r^(target-1)))\$",
                sol("Answer", a_target)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Infinite geometric series with constraint (3000-3500)
        # Find a and r such that sum = S and product of first n terms = P
        n_prod = randint(3, 5)
        r_options = [1//2, 1//3, 2//3, 3//4, 1//4, 3//5]
        r = choice(r_options)
        a = nonzero(-24, 24)
        
        # Infinite sum (|r| < 1)
        inf_sum = a // (1 - r)
        
        # Product of first n terms: a^n * r^(0+1+2+...+(n-1)) = a^n * r^(n(n-1)/2)
        exp_sum = (n_prod * (n_prod - 1)) ÷ 2
        prod_val = a^n_prod * r^exp_sum
        
        problem(
            question="A geometric sequence has first term \$a\$ and common ratio \$r\$ with \$|r| < 1\$. The sum of the infinite series is \$$(tex(inf_sum))\$ and the product of the first \$$(n_prod)\$ terms is \$$(tex(prod_val))\$. Find \$a + r\$ in simplest form.",
            answer=a + r,
            difficulty=(3000, 3500),
            solution=steps(
                sol("Given", "S_\\infty = $(tex(inf_sum)), P_{$(n_prod)} = $(tex(prod_val))"),
                "Infinite sum: \$\\frac{a}{1-r} = $(tex(inf_sum))\$ implies \$a = $(tex(inf_sum))(1-r)\$",
                "Product of first \$n\$ terms: \$P_n = a^n \\cdot r^{\\frac{n(n-1)}{2}}\$",
                "For \$n=$(n_prod)\$: \$P_{$(n_prod)} = a^{$(n_prod)} \\cdot r^{$(exp_sum)} = $(tex(prod_val))\$",
                "Substitute \$a = $(tex(inf_sum))(1-r)\$ and solve the system",
                "From constraints: \$a = $(a), r = $(tex(r))\$",
                "Verify: \$\\frac{$(a)}{1-$(tex(r))} = $(tex(inf_sum))\$ ✓",
                sol("Answer", a + r)
            ),
            time=360
        )
        
    else
        # Olympiad: Complex geometric sequence problem (3200-3500)
        # Find values where a_i + a_j + a_k equals specific value
        r = choice([2//1, 3//1, 1//2, 1//3, 3//2, 2//3])
        a = nonzero(-15, 15)
        
        i, j, k = 2, 4, 6
        target_sum = a * r^(i-1) + a * r^(j-1) + a * r^(k-1)
        target_sum_simplified = a * (r^(i-1) + r^(j-1) + r^(k-1))
        
        # Ask for sum of indices when three specific terms sum to target
        indices_sum = i + j + k
        
        problem(
            question="In a geometric sequence with first term \$a = $(a)\$ and common ratio \$r = $(tex(r))\$, three terms \$a_i, a_j, a_k\$ (where \$i < j < k\$) satisfy \$a_i + a_j + a_k = $(tex(target_sum))\$ and \$j = \\frac{i+k}{2}\$. If \$i, j, k\$ form an arithmetic progression with \$i = 2\$, find \$k\$.",
            answer=k,
            difficulty=(3200, 3500),
            solution=steps(
                sol("Given", "a = $(a), r = $(tex(r)), i = 2, j = \\frac{i+k}{2}"),
                "Since \$i,j,k\$ are arithmetic: \$j = \\frac{2+k}{2}\$, so if \$j=4\$ then \$k=6\$",
                "Check: \$a_2 + a_4 + a_6 = a \\cdot r + a \\cdot r^3 + a \\cdot r^5\$",
                "Calculate: \$$(a) \\cdot $(tex(r)) + $(a) \\cdot $(tex(r^3)) + $(a) \\cdot $(tex(r^5))\$",
                "Sum: \$$(tex(a*r)) + $(tex(a*r^3)) + $(tex(a*r^5)) = $(tex(target_sum))\$ ✓",
                sol("Answer", k)
            ),
            time=300
        )
    end
end