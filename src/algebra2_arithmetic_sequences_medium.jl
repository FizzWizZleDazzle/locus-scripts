# algebra2 - arithmetic_sequences (medium)
# Generated: 2026-03-08T20:22:05.515996

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("algebra2/arithmetic_sequences")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Find nth term given a₁ and d
        a1 = randint(-30, 30)
        d = nonzero(-15, 15)
        n_val = randint(8, 25)
        an = a1 + (n_val - 1) * d
        
        problem(
            question="An arithmetic sequence has first term \$a_1 = $(a1)\$ and common difference \$d = $(d)\$. Find the $(n_val)th term.",
            answer=an,
            difficulty=(1200, 1400),
            solution=steps(
                "Use the formula \$a_n = a_1 + (n-1)d\$",
                sol("Substitute", "a_{$(n_val)} = $(a1) + ($(n_val)-1)($(d))"),
                sol("Simplify", "a_{$(n_val)} = $(a1) + $(n_val-1) \\cdot $(d) = $(a1) + $(d*(n_val-1))"),
                sol("Answer", an)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Find common difference given two terms
        k1 = randint(3, 10)
        k2 = randint(k1 + 5, k1 + 15)
        d = nonzero(-12, 12)
        ak1 = randint(-40, 40)
        ak2 = ak1 + (k2 - k1) * d
        
        problem(
            question="In an arithmetic sequence, \$a_{$(k1)} = $(ak1)\$ and \$a_{$(k2)} = $(ak2)\$. Find the common difference \$d\$.",
            answer=d,
            difficulty=(1300, 1500),
            solution=steps(
                "Use the relationship \$a_{$(k2)} = a_{$(k1)} + ($(k2) - $(k1))d\$",
                sol("Substitute", "$(ak2) = $(ak1) + $(k2-k1)d"),
                sol("Solve for d", "$(ak2 - ak1) = $(k2-k1)d"),
                sol("Answer", "d = \\frac{$(ak2 - ak1)}{$(k2-k1)} = $(d)")
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Find first term given nth term and d
        d = nonzero(-10, 10)
        n_val = randint(6, 18)
        an = randint(-50, 50)
        a1 = an - (n_val - 1) * d
        
        problem(
            question="An arithmetic sequence has \$a_{$(n_val)} = $(an)\$ and common difference \$d = $(d)\$. Find the first term \$a_1\$.",
            answer=a1,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Formula", "a_n = a_1 + (n-1)d"),
                sol("Substitute", "$(an) = a_1 + ($(n_val)-1)($(d))"),
                sol("Simplify", "$(an) = a_1 + $((n_val-1)*d)"),
                sol("Solve", "a_1 = $(an) - $((n_val-1)*d) = $(a1)")
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Sum of first n terms
        a1 = randint(-25, 25)
        d = nonzero(-12, 12)
        n_val = randint(10, 30)
        an = a1 + (n_val - 1) * d
        Sn = div(n_val * (a1 + an), 2)
        
        problem(
            question="Find the sum of the first $(n_val) terms of the arithmetic sequence with \$a_1 = $(a1)\$ and \$d = $(d)\$.",
            answer=Sn,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Find last term", "a_{$(n_val)} = $(a1) + ($(n_val)-1)($(d)) = $(an)"),
                sol("Use sum formula", "S_n = \\frac{n(a_1 + a_n)}{2}"),
                sol("Substitute", "S_{$(n_val)} = \\frac{$(n_val)($(a1) + $(an))}{2} = \\frac{$(n_val) \\cdot $(a1 + an)}{2}"),
                sol("Answer", Sn)
            ),
            time=150
        )
        
    elseif problem_type == 5
        # Find which term equals a value
        a1 = randint(-20, 20)
        d = nonzero(-8, 8)
        n_val = randint(8, 25)
        target = a1 + (n_val - 1) * d
        
        problem(
            question="In an arithmetic sequence with \$a_1 = $(a1)\$ and \$d = $(d)\$, which term equals $(target)?",
            answer=n_val,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Use formula", "a_n = a_1 + (n-1)d"),
                sol("Substitute", "$(target) = $(a1) + (n-1)($(d))"),
                sol("Solve", "$(target - a1) = (n-1)($(d))"),
                sol("Therefore", "n-1 = $(n_val-1), \\text{ so } n = $(n_val)")
            ),
            time=150
        )
        
    else
        # Given three consecutive terms, find the middle one
        d = nonzero(-10, 10)
        a_mid = randint(-30, 30)
        a_prev = a_mid - d
        a_next = a_mid + d
        
        problem(
            question="Three consecutive terms of an arithmetic sequence are \$$(a_prev)\$, \$x\$, and \$$(a_next)\$. Find \$x\$.",
            answer=a_mid,
            difficulty=(1500, 1700),
            solution=steps(
                "In an arithmetic sequence, consecutive terms differ by the common difference \$d\$",
                sol("Set up", "x - $(a_prev) = $(a_next) - x"),
                sol("Solve", "2x = $(a_prev) + $(a_next) = $(a_prev + a_next)"),
                sol("Answer", "x = $(a_mid)")
            ),
            time=120
        )
    end
end