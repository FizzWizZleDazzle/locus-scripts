# algebra2 - geometric_sequences (easy)
# Generated: 2026-03-08T20:22:27.770964

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("algebra2/geometric_sequences")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Find the nth term given a1 and r
        a1 = nonzero(-15, 15)
        r = choice([2, 3, 4, 5, -2, -3, 1//2, 1//3, 1//4])
        n = randint(4, 8)
        ans = a1 * r^(n-1)
        
        problem(
            question="Find the $(n)th term of the geometric sequence with first term \\(a_1 = $(a1)\\) and common ratio \\(r = $(r)\\).",
            answer=ans,
            difficulty=(700, 900),
            solution=steps(
                "Use the formula \\(a_n = a_1 \\cdot r^{n-1}\\)",
                sol("Substitute", "a_{$(n)} = $(a1) \\cdot ($(r))^{$(n-1)}"),
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Find the common ratio given two terms
        a1 = nonzero(-12, 12)
        r = choice([2, 3, 4, -2, -3, 1//2, 1//3])
        n = randint(3, 6)
        an = a1 * r^(n-1)
        
        problem(
            question="A geometric sequence has \\(a_1 = $(a1)\\) and \\(a_{$(n)} = $(an)\\). Find the common ratio \\(r\\).",
            answer=r,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", "a_{$(n)} = a_1 \\cdot r^{$(n-1)}"),
                sol("Substitute", "$(an) = $(a1) \\cdot r^{$(n-1)}"),
                "Solve for \\(r\\): \\(r^{$(n-1)} = $(an//a1)\\)",
                sol("Answer", r)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # Find a specific term given a_m and a_k
        r = choice([2, 3, -2, 1//2, 1//3])
        m = randint(2, 4)
        k = randint(m+2, m+5)
        a_m = nonzero(-20, 20)
        a_k = a_m * r^(k-m)
        target = randint(k+1, k+3)
        ans = a_k * r^(target-k)
        
        problem(
            question="In a geometric sequence, \\(a_{$(m)} = $(a_m)\\) and \\(a_{$(k)} = $(a_k)\\). Find \\(a_{$(target)}\\).",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Find the common ratio: \\(r^{$(k-m)} = \\frac{$(a_k)}{$(a_m)}\\)",
                sol("Common ratio", r),
                sol("Calculate", "a_{$(target)} = a_{$(k)} \\cdot r^{$(target-k)} = $(a_k) \\cdot ($(r))^{$(target-k)}"),
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # Sum of first n terms
        a1 = nonzero(-10, 10)
        r = choice([2, 3, 1//2, 1//3, -1//2])
        n = randint(4, 7)
        if r == 1
            ans = n * a1
        else
            ans = a1 * (1 - r^n) // (1 - r)
        end
        
        problem(
            question="Find the sum of the first $(n) terms of the geometric sequence with \\(a_1 = $(a1)\\) and common ratio \\(r = $(r)\\).",
            answer=ans,
            difficulty=(1000, 1200),
            solution=steps(
                sol("Formula", "S_n = a_1 \\cdot \\frac{1-r^n}{1-r}"),
                sol("Substitute", "S_{$(n)} = $(a1) \\cdot \\frac{1-($(r))^{$(n)}}{1-($(r))}"),
                "Simplify the expression",
                sol("Answer", ans)
            ),
            time=120
        )
        
    else
        # Find first term given r and a_n
        r = choice([2, 3, 4, -2, 1//2, 1//3])
        n = randint(4, 7)
        ans = nonzero(-15, 15)
        a_n = ans * r^(n-1)
        
        problem(
            question="A geometric sequence has common ratio \\(r = $(r)\\) and \\(a_{$(n)} = $(a_n)\\). Find the first term \\(a_1\\).",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Formula", "a_{$(n)} = a_1 \\cdot r^{$(n-1)}"),
                sol("Substitute", "$(a_n) = a_1 \\cdot ($(r))^{$(n-1)}"),
                "Solve for \\(a_1\\)",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end