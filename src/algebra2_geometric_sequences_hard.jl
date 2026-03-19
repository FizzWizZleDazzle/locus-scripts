# algebra2 - geometric_sequences (hard)
# Generated: 2026-03-08T20:22:53.079297

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("algebra2/geometric_sequences")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Find nth term given first term and ratio (1800-2000)
        a1 = nonzero(-15, 15)
        r = choice([-3, -2, 2, 3, 4, 5])
        n_val = randint(6, 10)
        an = a1 * r^(n_val - 1)
        
        problem(
            question="In a geometric sequence, the first term is \$a_1 = $(a1)\$ and the common ratio is \$r = $(r)\$. Find the $(n_val)th term.",
            answer=an,
            difficulty=(1800, 1950),
            solution=steps(
                "Use the formula \$a_n = a_1 \\cdot r^{n-1}\$",
                sol("Substitution", "a_{$(n_val)} = $(a1) \\cdot $(r)^{$(n_val-1)}"),
                sol("Answer", an)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Find common ratio given two terms (1900-2100)
        pos1 = randint(2, 5)
        pos2 = pos1 + randint(2, 4)
        r_base = choice([2, 3, -2])
        a_pos1 = nonzero(-20, 20)
        a_pos2 = a_pos1 * r_base^(pos2 - pos1)
        
        problem(
            question="In a geometric sequence, \$a_{$(pos1)} = $(a_pos1)\$ and \$a_{$(pos2)} = $(a_pos2)\$. Find the common ratio \$r\$.",
            answer=r_base,
            difficulty=(1900, 2100),
            solution=steps(
                "Use \$a_{$(pos2)} = a_{$(pos1)} \\cdot r^{$(pos2 - pos1)}\$",
                sol("Setup", "$(a_pos2) = $(a_pos1) \\cdot r^{$(pos2 - pos1)}"),
                sol("Solve", "r^{$(pos2 - pos1)} = $(a_pos2 // a_pos1)"),
                sol("Answer", r_base)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Sum of finite geometric series (2000-2200)
        a1 = nonzero(-12, 12)
        r = choice([2, 3, 4, -2])
        n_terms = randint(5, 8)
        
        if r != 1
            sum_val = a1 * (1 - r^n_terms) // (1 - r)
        else
            sum_val = a1 * n_terms
        end
        
        problem(
            question="Find the sum of the first $(n_terms) terms of the geometric sequence with first term \$a_1 = $(a1)\$ and common ratio \$r = $(r)\$.",
            answer=sum_val,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Formula", "S_n = a_1 \\cdot \\frac{1 - r^n}{1 - r}"),
                sol("Substitution", "S_{$(n_terms)} = $(a1) \\cdot \\frac{1 - $(r)^{$(n_terms)}}{1 - $(r)}"),
                "Compute \$$(r)^{$(n_terms)} = $(r^n_terms)\$",
                sol("Answer", sum_val)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Find first term given nth term and ratio (1850-2050)
        r = choice([2, 3, -2, 4])
        n_val = randint(5, 8)
        an = nonzero(-50, 50) * r^(n_val - 1)
        a1 = an // r^(n_val - 1)
        
        problem(
            question="In a geometric sequence with common ratio \$r = $(r)\$, the $(n_val)th term is \$a_{$(n_val)} = $(an)\$. Find the first term \$a_1\$.",
            answer=a1,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Formula", "a_n = a_1 \\cdot r^{n-1}"),
                sol("Substitution", "$(an) = a_1 \\cdot $(r)^{$(n_val - 1)}"),
                "Solve for \$a_1\$: \$a_1 = \\frac{$(an)}{$(r^(n_val - 1))}\$",
                sol("Answer", a1)
            ),
            time=120
        )
        
    else
        # Infinite geometric series sum (2100-2400)
        r_num = choice([1, -1, 1, 2, -2])
        r_den = choice([2, 3, 4, 5])
        while abs(r_num) >= abs(r_den)
            r_num = choice([1, -1, 1, 2, -2])
            r_den = choice([2, 3, 4, 5])
        end
        
        r_frac = r_num // r_den
        a1 = nonzero(-20, 20)
        sum_inf = a1 // (1 - r_frac)
        
        problem(
            question="Find the sum of the infinite geometric series with first term \$a_1 = $(a1)\$ and common ratio \$r = $(r_num)/$(r_den)\$.",
            answer=sum_inf,
            difficulty=(2100, 2400),
            solution=steps(
                "Check convergence: \$|r| = $(abs(r_num))/$(r_den) < 1\$ ✓",
                sol("Formula", "S = \\frac{a_1}{1 - r}"),
                sol("Substitution", "S = \\frac{$(a1)}{1 - $(r_num)/$(r_den)}"),
                sol("Simplify", "S = \\frac{$(a1)}{$(1 - r_frac)}"),
                sol("Answer", sum_inf)
            ),
            time=180
        )
    end
end