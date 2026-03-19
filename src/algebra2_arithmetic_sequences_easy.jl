# algebra2 - arithmetic_sequences (easy)
# Generated: 2026-03-08T20:21:45.423765

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script n begin
    set_topic!("algebra2/arithmetic_sequences")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Find nth term given a₁ and d
        a1 = randint(-20, 20)
        d = nonzero(-10, 10)
        n_val = randint(8, 25)
        ans = a1 + (n_val - 1) * d
        
        problem(
            question="Find the $(n_val)th term of the arithmetic sequence with first term \$a_1 = $(a1)\$ and common difference \$d = $(d)\$.",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Use the formula \$a_n = a_1 + (n-1)d\$",
                sol("Substitute", "a_{$(n_val)} = $(a1) + ($(n_val)-1)($(d))"),
                sol("Calculate", "a_{$(n_val)} = $(a1) + $(n_val-1) \\cdot $(d) = $(a1) + $(d*(n_val-1)) = $(ans)"),
            ),
            time=60,
        )
        
    elseif problem_type == 2
        # Find common difference given two terms
        idx1 = randint(3, 8)
        idx2 = randint(idx1 + 3, idx1 + 10)
        d = nonzero(-8, 8)
        a1 = randint(-15, 15)
        term1 = a1 + (idx1 - 1) * d
        term2 = a1 + (idx2 - 1) * d
        ans = d
        
        problem(
            question="An arithmetic sequence has \$a_{$(idx1)} = $(term1)\$ and \$a_{$(idx2)} = $(term2)\$. Find the common difference \$d\$.",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Use \$a_n = a_1 + (n-1)d\$ to write two equations",
                sol("Set up", "a_{$(idx2)} - a_{$(idx1)} = ($(idx2) - $(idx1))d"),
                sol("Solve", "$(term2) - $(term1) = $(idx2 - idx1)d \\Rightarrow d = \\frac{$(term2 - term1)}{$(idx2 - idx1)} = $(ans)"),
            ),
            time=90,
        )
        
    elseif problem_type == 3
        # Find first term given aₙ, d, and n
        d = nonzero(-7, 7)
        n_val = randint(10, 20)
        a1 = randint(-12, 12)
        an = a1 + (n_val - 1) * d
        ans = a1
        
        problem(
            question="An arithmetic sequence has \$a_{$(n_val)} = $(an)\$ and common difference \$d = $(d)\$. Find the first term \$a_1\$.",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Formula", "a_n = a_1 + (n-1)d"),
                sol("Substitute", "$(an) = a_1 + ($(n_val)-1)($(d))"),
                sol("Solve", "$(an) = a_1 + $(d*(n_val-1)) \\Rightarrow a_1 = $(an) - $(d*(n_val-1)) = $(ans)"),
            ),
            time=75,
        )
        
    elseif problem_type == 4
        # Sum of first n terms
        a1 = randint(-15, 15)
        d = nonzero(-6, 6)
        n_val = randint(8, 20)
        an = a1 + (n_val - 1) * d
        ans = div(n_val * (a1 + an), 2)
        
        problem(
            question="Find the sum of the first $(n_val) terms of the arithmetic sequence with \$a_1 = $(a1)\$ and \$d = $(d)\$.",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Find last term", "a_{$(n_val)} = $(a1) + ($(n_val)-1)($(d)) = $(an)"),
                sol("Sum formula", "S_n = \\frac{n(a_1 + a_n)}{2}"),
                sol("Calculate", "S_{$(n_val)} = \\frac{$(n_val)($(a1) + $(an))}{2} = \\frac{$(n_val) \\cdot $(a1 + an)}{2} = $(ans)"),
            ),
            time=90,
        )
        
    else
        # Which term equals a given value?
        a1 = randint(-10, 10)
        d = nonzero(-5, 5)
        n_val = randint(6, 18)
        target = a1 + (n_val - 1) * d
        ans = n_val
        
        problem(
            question="In an arithmetic sequence with \$a_1 = $(a1)\$ and \$d = $(d)\$, which term equals $(target)?",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                sol("Set up equation", "a_n = a_1 + (n-1)d = $(target)"),
                sol("Substitute", "$(a1) + (n-1)($(d)) = $(target)"),
                sol("Solve", "(n-1)($(d)) = $(target - a1) \\Rightarrow n-1 = $(div(target - a1, d)) \\Rightarrow n = $(ans)"),
            ),
            time=75,
        )
    end
end