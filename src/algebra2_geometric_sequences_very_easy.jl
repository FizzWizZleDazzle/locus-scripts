# algebra2 - geometric_sequences (very_easy)
# Generated: 2026-03-08T20:22:24.947962

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("algebra2/geometric_sequences")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Find the next term (ELO 200-400)
        a = nonzero(-20, 20)
        r = choice([-3, -2, 2, 3, 4, 5])
        n = randint(3, 5)
        terms = [a * r^i for i in 0:(n-1)]
        next_term = a * r^n
        
        terms_str = join(terms, ", ")
        
        problem(
            question="What is the next term in the geometric sequence: $(terms_str), ___?",
            answer=next_term,
            difficulty=(200, 400),
            solution=steps(
                "Identify the pattern in the sequence",
                "Common ratio: r = $(terms[2]) ÷ $(terms[1]) = $(r)",
                sol("Next term", "$(terms[end]) × $(r) = $(next_term)")
            ),
            time=60
        )
    elseif problem_type == 2
        # Find the common ratio (ELO 300-500)
        a = nonzero(-15, 15)
        r = choice([-4, -3, -2, 2, 3, 4, 5])
        n = randint(3, 4)
        terms = [a * r^i for i in 0:(n-1)]
        
        terms_str = join(terms, ", ")
        
        problem(
            question="Find the common ratio of the geometric sequence: $(terms_str), ...",
            answer=r,
            difficulty=(300, 500),
            solution=steps(
                sol("Sequence", terms_str),
                "Common ratio is found by dividing consecutive terms",
                sol("r", "$(terms[2]) ÷ $(terms[1]) = $(r)")
            ),
            time=45
        )
    elseif problem_type == 3
        # Find a specific term using formula (ELO 500-700)
        a = nonzero(-12, 12)
        r = choice([-3, -2, 2, 3, 4])
        n = randint(5, 8)
        ans = a * r^(n-1)
        
        problem(
            question="In a geometric sequence, the first term is $(a) and the common ratio is $(r). Find the $(n)th term.",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Use the formula: \$a_n = a_1 \\cdot r^{n-1}\$",
                sol("Setup", "a_{$(n)} = $(a) \\cdot $(r)^{$(n-1)}"),
                sol("Answer", "a_{$(n)} = $(ans)")
            ),
            time=90
        )
    elseif problem_type == 4
        # Identify if sequence is geometric (ELO 400-600)
        is_geometric = choice([true, false])
        
        if is_geometric
            a = nonzero(-10, 10)
            r = choice([2, 3, 4, 5])
            terms = [a * r^i for i in 0:3]
            ans = "yes"
            explanation = "Each term is multiplied by $(r)"
        else
            a = nonzero(-10, 10)
            d = nonzero(-8, 8)
            terms = [a + d*i for i in 0:3]
            ans = "no"
            explanation = "The ratios between consecutive terms are not constant (this is an arithmetic sequence)"
        end
        
        terms_str = join(terms, ", ")
        
        problem(
            question="Is the sequence $(terms_str), ... a geometric sequence? Answer yes or no.",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "Check if the ratio between consecutive terms is constant",
                "Ratio 1: $(terms[2]) ÷ $(terms[1]) = $(terms[2]/terms[1])",
                "Ratio 2: $(terms[3]) ÷ $(terms[2]) = $(terms[3]/terms[2])",
                explanation
            ),
            time=75
        )
    else
        # Find first term given nth term and ratio (ELO 600-700)
        r = choice([2, 3, 4, -2, -3])
        n = randint(4, 6)
        ans = nonzero(-10, 10)
        a_n = ans * r^(n-1)
        
        problem(
            question="A geometric sequence has common ratio $(r) and the $(n)th term is $(a_n). Find the first term.",
            answer=ans,
            difficulty=(600, 700),
            solution=steps(
                "Use the formula: \$a_n = a_1 \\cdot r^{n-1}\$",
                sol("Substitute", "$(a_n) = a_1 \\cdot $(r)^{$(n-1)}"),
                "Solve for \$a_1\$: \$a_1 = $(a_n) \\div $(r^(n-1))\$",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end