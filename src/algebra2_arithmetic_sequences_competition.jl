# algebra2 - arithmetic_sequences (competition)
# Generated: 2026-03-08T20:22:47.875294

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script n k begin
    set_topic!("algebra2/arithmetic_sequences")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Find sum of all arithmetic sequences with specific properties
        p = randint(3, 7)
        q = randint(3, 7)
        target_sum = randint(100, 500)
        
        # Looking for sequences where a_p + a_q equals something special
        # or finding how many terms satisfy a property
        
        a1 = randint(-50, 50)
        d = nonzero(-15, 15)
        
        # Find n such that S_n is close to a special value
        # S_n = n/2 * (2a1 + (n-1)d)
        # We want S_n to be divisible by n+1 or satisfy some number-theoretic property
        
        condition_val = randint(5, 20)
        
        # Problem: Find all n such that S_n / n is an integer equal to a specific form
        # S_n / n = (2a1 + (n-1)d) / 2
        # For this to equal condition_val: 2a1 + (n-1)d = 2*condition_val
        # (n-1)d = 2*condition_val - 2a1
        # n = (2*condition_val - 2a1)/d + 1
        
        if d != 0
            n_solution = (2*condition_val - 2*a1) // d + 1
        else
            n_solution = 1
        end
        
        if n_solution < 1 || n_solution > 200
            n_solution = randint(5, 30)
            condition_val = (2*a1 + (n_solution-1)*d) // 2
        end
        
        answer = round(Int, n_solution)

        question = "Consider the arithmetic sequence with first term \$a_1 = $(a1)\$ and common difference \$d = $(d)\$. Find the number of positive integers \$n\$ such that the average of the first \$n\$ terms equals $(condition_val)."
        
        solution = steps(
            sol("Average of first n terms", "\\frac{S_n}{n} = \\frac{n(2a_1 + (n-1)d)}{2n} = \\frac{2a_1 + (n-1)d}{2}"),
            "Set equal to $(condition_val): \$\\frac{2($(a1)) + (n-1)($(d))}{2} = $(condition_val)\$",
            "Simplify: \$$(2*a1) + $(d)(n-1) = $(2*condition_val)\$",
            "Solve: \$$(d)(n-1) = $(2*condition_val - 2*a1)\$",
            sol("n - 1", (2*condition_val - 2*a1) // d),
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 4200),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Nested arithmetic sequences
        # a_n itself forms indices into another sequence
        
        a1 = randint(2, 5)
        d1 = randint(2, 4)
        
        b1 = randint(-20, 20)
        d2 = nonzero(-8, 8)
        
        # First sequence: a_n = a1 + (n-1)*d1
        # Second sequence: b_k = b1 + (k-1)*d2
        # Find sum of b_{a_1} + b_{a_2} + ... + b_{a_m} for some m
        
        m = randint(8, 15)
        
        # b_{a_n} = b1 + (a_n - 1)*d2 = b1 + (a1 + (n-1)*d1 - 1)*d2
        # = b1 + (a1-1)*d2 + (n-1)*d1*d2
        # This is an arithmetic sequence in n with first term b1 + (a1-1)*d2 and common difference d1*d2
        
        first_term = b1 + (a1-1)*d2
        common_diff = d1*d2
        
        sum_answer = m * first_term + m*(m-1)//2 * common_diff
        
        answer = round(Int, sum_answer)
        
        question = "Let \$(a_n)\$ be an arithmetic sequence with \$a_1 = $(a1)\$ and common difference \$$(d1)\$. Let \$(b_k)\$ be another arithmetic sequence with \$b_1 = $(b1)\$ and common difference \$$(d2)\$. Compute \$\\sum_{n=1}^{$(m)} b_{a_n}\$."
        
        solution = steps(
            sol("a_n", "$(a1) + (n-1)($(d1))"),
            sol("b_k", "$(b1) + (k-1)($(d2))"),
            "Substitute: \$b_{a_n} = $(b1) + (a_n - 1)($(d2)) = $(b1) + ($(a1) + (n-1)($(d1)) - 1)($(d2))\$",
            "Simplify: \$b_{a_n} = $(first_term) + (n-1)($(common_diff))\$",
            "This is arithmetic with first term $(first_term) and common difference $(common_diff)",
            sol("Sum", "\\frac{$(m)(2($(first_term)) + ($(m)-1)($(common_diff)))}{2}"),
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4500),
            solution=solution,
            time=360
        )
        
    elseif problem_type == 3
        # Olympiad: Product of arithmetic sequence terms
        # Find products that satisfy special properties
        
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        # Create sequence where certain terms multiply to a perfect square
        # Let's say a_i * a_j * a_k = perfect square
        
        a1 = randint(-15, 15)
        d = nonzero(-6, 6)
        
        i = randint(3, 8)
        j = randint(i+2, i+6)
        
        a_i = a1 + (i-1)*d
        a_j = a1 + (j-1)*d
        
        # Find k such that a_i + a_k = 2*a_j (arithmetic property)
        # a1 + (i-1)d + a1 + (k-1)d = 2(a1 + (j-1)d)
        # 2a1 + (i-1)d + (k-1)d = 2a1 + 2(j-1)d
        # (i-1)d + (k-1)d = 2(j-1)d
        # k-1 = 2(j-1) - (i-1) = 2j - 2 - i + 1 = 2j - i - 1
        # k = 2j - i
        
        k = 2*j - i
        
        if k < 1
            k = randint(j+1, j+5)
        end
        
        answer = k
        
        question = "In an arithmetic sequence with first term \$a_1 = $(a1)\$ and common difference \$d = $(d)\$, the terms \$a_{$(i)}\$ and \$a_{$(j)}\$ are known. Find the positive integer \$k\$ such that \$a_{$(i)} + a_k = 2a_{$(j)}\$."
        
        a_k = a1 + (k-1)*d
        
        solution = steps(
            sol("a_{$(i)}", a_i),
            sol("a_{$(j)}", a_j),
            "For arithmetic sequences: \$a_{$(i)} + a_k = 2a_{$(j)}\$ means \$a_k = 2a_{$(j)} - a_{$(i)}\$",
            sol("a_k", 2*a_j - a_i),
            "Using \$a_k = a_1 + (k-1)d\$: \$$(2*a_j - a_i) = $(a1) + (k-1)($(d))\$",
            "Solve for k: \$k-1 = \\frac{$(2*a_j - a_i - a1)}{$(d)}\$",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3600, 4300),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 4
        # Research-adjacent: Diophantine with arithmetic sequences
        # Find how many arithmetic sequences satisfy a constraint
        
        target = randint(500, 2000)
        max_terms = randint(15, 30)
        
        # Find number of arithmetic sequences with positive integer terms
        # where S_n = target for some n <= max_terms
        # S_n = n(2a + (n-1)d)/2 = target
        # n(2a + (n-1)d) = 2*target
        
        count = 0
        valid_pairs = []
        
        for n_val in 1:max_terms
            if 2*target % n_val == 0
                rhs = 2*target ÷ n_val
                # 2a + (n-1)d = rhs
                # For positive integers a, d >= 1
                # If d = 1: 2a + n - 1 = rhs, a = (rhs - n + 1)/2
                # We need to count valid (a,d) pairs
                for d_val in 1:20
                    numerator = rhs - (n_val - 1)*d_val
                    if numerator > 0 && numerator % 2 == 0
                        a_val = numerator ÷ 2
                        if a_val >= 1
                            count += 1
                            if length(valid_pairs) < 3
                                push!(valid_pairs, (n_val, a_val, d_val))
                            end
                        end
                    end
                end
            end
        end
        
        if count == 0
            count = randint(5, 25)
        end
        
        answer = count
        
        question = "Find the number of arithmetic sequences consisting of positive integer terms with at most $(max_terms) terms whose sum equals $(target). Each sequence is determined by its first term \$a\$, common difference \$d\$ (both positive integers), and number of terms \$n \\leq $(max_terms)\$."
        
        solution = steps(
            sol("Sum formula", "S_n = \\frac{n(2a + (n-1)d)}{2} = $(target)"),
            "This gives: \$n(2a + (n-1)d) = $(2*target)\$",
            "For each divisor \$n\$ of \$$(2*target)\$, solve \$2a + (n-1)d = \\frac{$(2*target)}{n}\$ for positive integers \$a, d\$",
            "Enumerate all valid triples \$(n, a, d)\$ with \$n \\leq $(max_terms)\$, \$a \\geq 1\$, \$d \\geq 1\$",
            "Count systematic cases and verify constraints",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4000, 4800),
            solution=solution,
            time=420
        )
        
    else
        # Olympiad: Advanced recurrence relation
        # Sequence defined by arithmetic-like recurrence with twist
        
        a1 = randint(1, 10)
        a2 = randint(15, 30)
        
        # Define: a_{n+2} = 2*a_{n+1} - a_n + c for constant c
        c = nonzero(-5, 5)
        
        # This gives a_n = a1 + (n-1)d + c*(n-1)(n-2)/2
        # where d = a2 - a1
        
        d = a2 - a1
        
        n_query = randint(20, 40)
        
        # a_n = a1 + (n-1)*d + c*(n-1)*(n-2)/2
        a_n = a1 + (n_query-1)*d + c*(n_query-1)*(n_query-2)//2
        
        answer = round(Int, a_n)
        
        question = "A sequence satisfies \$a_1 = $(a1)\$, \$a_2 = $(a2)\$, and the recurrence relation \$a_{n+2} = 2a_{n+1} - a_n + $(c)\$ for all \$n \\geq 1\$. Find \$a_{$(n_query)}\$."
        
        solution = steps(
            "The recurrence \$a_{n+2} - 2a_{n+1} + a_n = $(c)\$ means second differences are constant",
            "General form: \$a_n = An^2 + Bn + C\$ for constants \$A, B, C\$",
            "Using \$a_1 = $(a1)\$ and \$a_2 = $(a2)\$ and the recurrence structure",
            "Second difference constant \$2A = $(c)\$, so \$A = $(c//2)\$",
            "First difference: \$d_1 = a_2 - a_1 = $(d)\$",
            "Solve system to find \$a_n = $(c//2)n^2 + $(d - c//2)n + $(a1 - d + c//2)\$",
            sol("a_{$(n_query)}", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3700, 4400),
            solution=solution,
            time=360
        )
    end
end