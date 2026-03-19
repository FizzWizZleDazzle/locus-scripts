# algebra2 - geometric_sequences (medium)
# Generated: 2026-03-08T20:22:47.229390

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("algebra2/geometric_sequences")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Find nth term given a and r
        a = nonzero(-15, 15)
        r = choice([2, 3, 4, 5, -2, -3, 1//2, 1//3, 1//4])
        n_val = randint(5, 10)
        ans = a * r^(n_val - 1)
        
        problem(
            question="Find the $(n_val)th term of the geometric sequence with first term \$a = $(a)\$ and common ratio \$r = $(r)\$.",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Use the formula: \$a_n = a \\cdot r^{n-1}\$",
                sol("Substitute", "a_{$(n_val)} = $(a) \\cdot ($(r))^{$(n_val-1)}"),
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Find common ratio given two terms
        k = randint(2, 5)
        m = k + randint(2, 5)
        r = choice([2, 3, -2, 1//2, 1//3])
        a = nonzero(-10, 10)
        
        term_k = a * r^(k - 1)
        term_m = a * r^(m - 1)
        
        problem(
            question="A geometric sequence has \$a_{$(k)} = $(term_k)\$ and \$a_{$(m)} = $(term_m)\$. Find the common ratio \$r\$.",
            answer=r,
            difficulty=(1400, 1600),
            solution=steps(
                "Use: \$a_m = a_k \\cdot r^{m-k}\$",
                sol("Substitute", "$(term_m) = $(term_k) \\cdot r^{$(m-k)}"),
                "Solve for r: \$r^{$(m-k)} = $(term_m // term_k)\$",
                sol("Answer", r)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Sum of first n terms
        a = nonzero(-12, 12)
        r = choice([2, 3, 4, 1//2, 1//3, -2])
        n_val = randint(5, 8)
        
        if r != 1
            ans = a * (1 - r^n_val) // (1 - r)
        else
            ans = a * n_val
        end
        
        problem(
            question="Find the sum of the first $(n_val) terms of the geometric sequence with first term \$a = $(a)\$ and common ratio \$r = $(r)\$.",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                "Use the formula: \$S_n = a \\cdot \\frac{1 - r^n}{1 - r}\$",
                sol("Substitute", "S_{$(n_val)} = $(a) \\cdot \\frac{1 - ($(r))^{$(n_val)}}{1 - $(r)}"),
                sol("Simplify", "S_{$(n_val)} = $(a) \\cdot \\frac{$(1 - r^n_val)}{$(1 - r)}"),
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Find first term given nth term and r
        r = choice([2, 3, 4, 1//2, 1//3, -2])
        n_val = randint(4, 8)
        a = nonzero(-10, 10)
        term_n = a * r^(n_val - 1)
        
        problem(
            question="A geometric sequence has common ratio \$r = $(r)\$ and \$a_{$(n_val)} = $(term_n)\$. Find the first term \$a_1\$.",
            answer=a,
            difficulty=(1300, 1500),
            solution=steps(
                "Use: \$a_n = a_1 \\cdot r^{n-1}\$",
                sol("Substitute", "$(term_n) = a_1 \\cdot ($(r))^{$(n_val-1)}"),
                "Solve for \$a_1\$: \$a_1 = \\frac{$(term_n)}{$(r^(n_val-1))}\$",
                sol("Answer", a)
            ),
            time=120
        )
        
    elseif problem_type == 5
        # Infinite sum (|r| < 1)
        a = nonzero(-20, 20)
        r = choice([1//2, 1//3, 1//4, -1//2, -1//3, 2//5, -2//5])
        ans = a // (1 - r)
        
        problem(
            question="Find the sum of the infinite geometric series with first term \$a = $(a)\$ and common ratio \$r = $(r)\$.",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Since \$|r| < 1\$, the series converges.",
                "Use the formula: \$S = \\frac{a}{1 - r}\$",
                sol("Substitute", "S = \\frac{$(a)}{1 - $(r)}"),
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Find which term equals a given value
        a = nonzero(-8, 8)
        r = choice([2, 3, 4, -2])
        n_val = randint(4, 7)
        target = a * r^(n_val - 1)
        
        problem(
            question="In the geometric sequence with first term \$a = $(a)\$ and common ratio \$r = $(r)\$, which term equals $(target)?",
            answer=n_val,
            difficulty=(1400, 1600),
            solution=steps(
                "Use: \$a_n = a \\cdot r^{n-1}\$",
                sol("Set up equation", "$(target) = $(a) \\cdot ($(r))^{n-1}"),
                "Simplify: \$($(r))^{n-1} = $(target // a)\$",
                "Solve: \$n - 1 = $(n_val - 1)\$",
                sol("Answer", "n = $(n_val)")
            ),
            time=150
        )
    end
end