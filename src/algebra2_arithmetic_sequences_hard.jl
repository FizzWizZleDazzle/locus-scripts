# algebra2 - arithmetic_sequences (hard)
# Generated: 2026-03-08T20:22:08.368030

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("algebra2/arithmetic_sequences")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Find nth term given a_1 and d
        a1 = randint(-30, 30)
        d = nonzero(-15, 15)
        n_val = randint(15, 40)
        an = a1 + (n_val - 1) * d
        
        problem(
            question="An arithmetic sequence has first term \$a_1 = $(a1)\$ and common difference \$d = $(d)\$. Find \$a_{$(n_val)}\$.",
            answer=an,
            difficulty=(1800, 2000),
            solution=steps(
                "Use the formula \$a_n = a_1 + (n-1)d\$",
                sol("Substitute", "a_{$(n_val)} = $(a1) + ($(n_val)-1)($(d))"),
                sol("Simplify", "a_{$(n_val)} = $(a1) + $(n_val-1) \\cdot $(d) = $(a1) + $(d*(n_val-1))"),
                sol("Answer", an)
            ),
            time=90
        )
    elseif problem_type == 2
        # Find sum of first n terms
        a1 = randint(-25, 25)
        d = nonzero(-12, 12)
        n_val = randint(20, 50)
        an = a1 + (n_val - 1) * d
        sum_n = (n_val * (a1 + an)) // 2
        
        problem(
            question="Find the sum of the first $(n_val) terms of the arithmetic sequence with first term \$a_1 = $(a1)\$ and common difference \$d = $(d)\$.",
            answer=sum_n,
            difficulty=(1900, 2100),
            solution=steps(
                "First find \$a_{$(n_val)}\$ using \$a_n = a_1 + (n-1)d\$",
                sol("Last term", "a_{$(n_val)} = $(a1) + $(n_val-1) \\cdot $(d) = $(an)"),
                "Use sum formula \$S_n = \\frac{n(a_1 + a_n)}{2}\$",
                sol("Substitute", "S_{$(n_val)} = \\frac{$(n_val)($(a1) + $(an))}{2}"),
                sol("Answer", sum_n)
            ),
            time=120
        )
    elseif problem_type == 3
        # Find common difference given two terms
        k = randint(5, 15)
        m = k + randint(10, 25)
        d = nonzero(-18, 18)
        ak = randint(-40, 40)
        am = ak + (m - k) * d
        
        problem(
            question="In an arithmetic sequence, \$a_{$(k)} = $(ak)\$ and \$a_{$(m)} = $(am)\$. Find the common difference \$d\$.",
            answer=d,
            difficulty=(2000, 2200),
            solution=steps(
                "Use \$a_m - a_k = (m - k)d\$",
                sol("Substitute", "$(am) - $(ak) = ($(m) - $(k))d"),
                sol("Simplify", "$(am - ak) = $(m - k) \\cdot d"),
                sol("Solve", "d = \\frac{$(am - ak)}{$(m - k)} = $(d)")
            ),
            time=150
        )
    elseif problem_type == 4
        # Find which term equals a given value
        a1 = randint(-20, 20)
        d = nonzero(-10, 10)
        n_val = randint(15, 35)
        target = a1 + (n_val - 1) * d
        
        problem(
            question="An arithmetic sequence has \$a_1 = $(a1)\$ and common difference \$d = $(d)\$. Which term of the sequence equals $(target)?",
            answer=n_val,
            difficulty=(2000, 2200),
            solution=steps(
                "Set up equation \$a_n = a_1 + (n-1)d = $(target)\$",
                sol("Substitute", "$(a1) + (n-1)($(d)) = $(target)"),
                sol("Solve", "(n-1)($(d)) = $(target - a1)"),
                sol("Continue", "n - 1 = $(div(target - a1, d))"),
                sol("Answer", "n = $(n_val)")
            ),
            time=180
        )
    else
        # Find a_1 given a_n and sum
        d = nonzero(-8, 8)
        n_val = randint(20, 40)
        a1 = randint(-30, 30)
        an = a1 + (n_val - 1) * d
        sum_n = (n_val * (a1 + an)) // 2
        
        problem(
            question="An arithmetic sequence has \$a_{$(n_val)} = $(an)\$ and the sum of the first $(n_val) terms is \$S_{$(n_val)} = $(sum_n)\$. Find the first term \$a_1\$ and common difference \$d\$.",
            answer=fmt_tuple([a1, d]),
            answer_type="tuple",
            difficulty=(2200, 2400),
            solution=steps(
                "Use \$S_n = \\frac{n(a_1 + a_n)}{2}\$ to find \$a_1\$",
                sol("Substitute", "$(sum_n) = \\frac{$(n_val)(a_1 + $(an))}{2}"),
                sol("Solve for a_1", "$(2*sum_n) = $(n_val) \\cdot a_1 + $(n_val * an)"),
                sol("Continue", "a_1 = \\frac{$(2*sum_n) - $(n_val * an)}{$(n_val)} = $(a1)"),
                "Now use \$a_n = a_1 + (n-1)d\$ to find \$d\$",
                sol("Substitute", "$(an) = $(a1) + ($(n_val)-1)d"),
                sol("Solve for d", "d = \\frac{$(an - a1)}{$(n_val - 1)} = $(d)"),
                sol("Answer", fmt_tuple([a1, d]))
            ),
            time=240
        )
    end
end