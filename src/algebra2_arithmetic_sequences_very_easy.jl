# algebra2 - arithmetic_sequences (very_easy)
# Generated: 2026-03-08T20:21:41.796143

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("algebra2/arithmetic_sequences")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple term identification (ELO 200-400)
        a1 = randint(-20, 20)
        d = nonzero(-10, 10)
        n = randint(2, 6)
        sequence = [a1 + (i-1)*d for i in 1:5]
        
        problem(
            question="What is the $(n)th term of the arithmetic sequence: $(join(sequence, ", "))...?",
            answer=sequence[n],
            difficulty=(200, 400),
            solution=steps(
                "The sequence is: $(join(sequence, ", "))...",
                "Count to the $(n)th position",
                sol("Answer", sequence[n])
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Find common difference (ELO 300-500)
        a1 = randint(-25, 25)
        d = nonzero(-12, 12)
        sequence = [a1 + (i-1)*d for i in 1:4]
        
        problem(
            question="Find the common difference of the arithmetic sequence: $(join(sequence, ", "))...",
            answer=d,
            difficulty=(300, 500),
            solution=steps(
                "The sequence is: $(join(sequence, ", "))...",
                "Subtract consecutive terms: $(sequence[2]) - $(sequence[1]) = $(d)",
                sol("Common difference", d)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Find next term (ELO 400-600)
        a1 = randint(-30, 30)
        d = nonzero(-15, 15)
        n_terms = rand(3:5)
        sequence = [a1 + (i-1)*d for i in 1:n_terms]
        next_term = a1 + n_terms*d
        
        problem(
            question="Find the next term in the arithmetic sequence: $(join(sequence, ", "))...",
            answer=next_term,
            difficulty=(400, 600),
            solution=steps(
                "The sequence is: $(join(sequence, ", "))...",
                "Find common difference: d = $(sequence[2]) - $(sequence[1]) = $(d)",
                "Add d to last term: $(sequence[end]) + $(d) = $(next_term)",
                sol("Answer", next_term)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Find a specific term using formula (ELO 500-700)
        a1 = randint(-20, 20)
        d = nonzero(-8, 8)
        n = randint(6, 12)
        an = a1 + (n-1)*d
        
        problem(
            question="An arithmetic sequence has first term a₁ = $(a1) and common difference d = $(d). Find the $(n)th term.",
            answer=an,
            difficulty=(500, 700),
            solution=steps(
                "Use the formula: aₙ = a₁ + (n-1)d",
                "Substitute: a$(n) = $(a1) + ($(n)-1)($(d))",
                "Calculate: a$(n) = $(a1) + $(n-1) × $(d) = $(a1) + $(((n-1)*d))",
                sol("Answer", an)
            ),
            time=90
        )
        
    elseif problem_type == 5
        # Given two terms, find first term (ELO 600-700)
        a1 = randint(-25, 25)
        d = nonzero(-10, 10)
        n1 = randint(3, 6)
        n2 = n1 + randint(2, 4)
        term1 = a1 + (n1-1)*d
        term2 = a1 + (n2-1)*d
        
        problem(
            question="In an arithmetic sequence, the $(n1)th term is $(term1) and the $(n2)th term is $(term2). Find the first term a₁.",
            answer=a1,
            difficulty=(600, 700),
            solution=steps(
                "Find common difference: d = (a$(n2) - a$(n1))/($(n2) - $(n1)) = ($(term2) - $(term1))/$(n2-n1) = $(d)",
                "Use a$(n1) = a₁ + ($(n1)-1)d",
                "Solve: $(term1) = a₁ + $(n1-1) × $(d)",
                "Therefore: a₁ = $(term1) - $((n1-1)*d) = $(a1)",
                sol("Answer", a1)
            ),
            time=120
        )
        
    else
        # Find which term equals a value (ELO 650-700)
        a1 = randint(-15, 15)
        d = nonzero(-8, 8)
        n = randint(5, 15)
        target = a1 + (n-1)*d
        
        problem(
            question="An arithmetic sequence has first term a₁ = $(a1) and common difference d = $(d). Which term equals $(target)?",
            answer=n,
            difficulty=(650, 700),
            solution=steps(
                "Use the formula: aₙ = a₁ + (n-1)d",
                "Set up equation: $(target) = $(a1) + (n-1)($(d))",
                "Solve: $(target - a1) = (n-1)($(d))",
                "(n-1) = $((target - a1) ÷ d), so n = $(n)",
                sol("Answer", n)
            ),
            time=120
        )
    end
end