# arithmetic - subtraction (very_hard)
# Generated: 2026-03-08T19:46:21.895952

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/subtraction")
    
    # Competition to Olympiad level (2500-3500 ELO) subtraction problems
    # These require deep insights about number theory, combinatorics, or creative approaches
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Subtraction in modular arithmetic with large numbers
        p = choice([97, 101, 103, 107, 109, 113, 127, 131, 137, 139])
        a = randint(10^8, 10^9)
        b = randint(10^8, 10^9)
        ans = mod(a - b, p)
        
        problem(
            question="Find the remainder when \\($(a) - $(b)\\) is divided by \\($(p)\\).",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                "Compute \\(a \\equiv $(mod(a, p)) \\pmod{$(p)}\\)",
                "Compute \\(b \\equiv $(mod(b, p)) \\pmod{$(p)}\\)",
                sol("Difference", "$(mod(a, p)) - $(mod(b, p)) \\equiv $(ans) \\pmod{$(p)}")
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Digit sum subtraction problem
        n = randint(10^6, 10^7)
        digit_sum_n = sum(parse(Int, string(d)) for d in string(n))
        diff = n - digit_sum_n
        ans = mod(diff, 9)
        
        problem(
            question="Let \\(n = $(n)\\) and let \\(S(n)\\) denote the sum of the digits of \\(n\\). Find the remainder when \\(n - S(n)\\) is divided by 9.",
            answer=ans,
            difficulty=(2600, 2900),
            solution=steps(
                "Note that \\(n \\equiv S(n) \\pmod{9}\\) for any positive integer \\(n\\)",
                "Therefore \\(n - S(n) \\equiv 0 \\pmod{9}\\)",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Combinatorial subtraction: number of sequences
        n = randint(15, 25)
        k = randint(8, min(12, n-3))
        total = comb(n, k)
        consecutive = n - k + 1
        ans = total - consecutive
        
        problem(
            question="How many ways can we choose \\($(k)\\) distinct integers from \\(\\{1, 2, \\ldots, $(n)\\}\\) such that no two chosen integers are consecutive?",
            answer=ans,
            difficulty=(2700, 3100),
            solution=steps(
                "Total ways to choose $(k) from $(n): \\(\\binom{$(n)}{$(k)} = $(total)\\)",
                "Transform: Choose $(k) from $(n-k+1) positions with gaps: \\(\\binom{$(n-k+1)}{$(k)} = $(comb(n-k+1, k))\\)",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Base conversion subtraction puzzle
        b = choice([7, 8, 9, 11, 12, 13])
        d1 = randint(2, b-1)
        d2 = randint(1, b-1)
        d3 = randint(1, b-1)
        d4 = randint(1, b-1)
        num1 = d1 * b^2 + d2 * b + d3
        num2 = d4 * b + d2
        ans = num1 - num2
        
        problem(
            question="In base \\($(b)\\), compute \\(($(d1)$(d2)$(d3))_{$(b)} - ($(d4)$(d2))_{$(b)}\\) and express your answer in base 10.",
            answer=ans,
            difficulty=(2600, 3000),
            solution=steps(
                sol("First number", "$(d1) \\cdot $(b)^2 + $(d2) \\cdot $(b) + $(d3) = $(num1)"),
                sol("Second number", "$(d4) \\cdot $(b) + $(d2) = $(num2)"),
                sol("Difference", "$(num1) - $(num2) = $(ans)")
            ),
            time=240
        )
        
    else
        # Polynomial evaluation subtraction with number theory
        n = randint(20, 40)
        m = randint(15, 30)
        p = choice([7, 11, 13, 17, 19, 23])
        val_n = mod(n^3 - 2*n^2 + 3*n - 5, p)
        val_m = mod(m^3 - 2*m^2 + 3*m - 5, p)
        ans = mod(val_n - val_m, p)
        
        problem(
            question="Let \\(P(x) = x^3 - 2x^2 + 3x - 5\\). Find the remainder when \\(P($(n)) - P($(m))\\) is divided by \\($(p)\\).",
            answer=ans,
            difficulty=(2800, 3200),
            solution=steps(
                sol("P($(n))", "$(n)^3 - 2($(n))^2 + 3($(n)) - 5 \\equiv $(val_n) \\pmod{$(p)}"),
                sol("P($(m))", "$(m)^3 - 2($(m))^2 + 3($(m)) - 5 \\equiv $(val_m) \\pmod{$(p)}"),
                sol("Difference", "$(val_n) - $(val_m) \\equiv $(ans) \\pmod{$(p)}")
            ),
            time=270
        )
    end
end