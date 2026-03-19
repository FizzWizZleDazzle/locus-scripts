# linear_algebra - linear_independence (very_hard)
# Generated: 2026-03-08T21:12:45.367367

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/linear_independence")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition level: Determine linear independence of polynomial vectors
        n = rand(3:4)
        dim = n + 1
        
        # Create vectors as polynomials with specific structure
        degrees = shuffle(0:n)
        
        # Generate coefficient matrix that may or may not be independent
        is_independent = rand(Bool)
        
        if is_independent
            # Create linearly independent vectors
            coeffs = []
            for i in 1:n
                row = zeros(Int, dim)
                row[degrees[i]+1] = nonzero(-3, 3)
                for j in 1:dim
                    if j != degrees[i]+1 && rand() < 0.4
                        row[j] = randint(-2, 2)
                    end
                end
                push!(coeffs, row)
            end
        else
            # Create linearly dependent vectors
            coeffs = []
            for i in 1:n-1
                row = [nonzero(-3, 3) for _ in 1:dim]
                push!(coeffs, row)
            end
            # Make last vector a linear combination
            c1 = nonzero(-2, 2)
            c2 = nonzero(-2, 2)
            last_row = c1 * coeffs[1] + c2 * coeffs[2]
            push!(coeffs, last_row)
        end
        
        # Format vectors
        vector_strs = []
        for i in 1:n
            terms = []
            for (j, c) in enumerate(coeffs[i])
                if c != 0
                    deg = j - 1
                    if deg == 0
                        push!(terms, string(c))
                    elseif deg == 1
                        push!(terms, c == 1 ? "x" : c == -1 ? "-x" : "$(c)x")
                    else
                        push!(terms, c == 1 ? "x^{$deg}" : c == -1 ? "-x^{$deg}" : "$(c)x^{$deg}")
                    end
                end
            end
            push!(vector_strs, join(terms, " + "))
        end
        
        question_text = "Let \\(V\\) be the vector space of polynomials of degree at most $n. Determine whether the following set of vectors is linearly independent:\n\n" *
            "\\[S = \\{" * join(["p_$i(x) = " * vector_strs[i] for i in 1:n], ", ") * "\\}\\]"
        
        answer = is_independent ? "Yes" : "No"
        
        solution_steps = [
            "Express each polynomial as a coordinate vector in the standard basis \\(\\{1, x, x^2, \\ldots, x^{$n}\\}\\)",
            "Form the matrix with these coordinate vectors as columns",
        ]
        
        if is_independent
            push!(solution_steps, "Compute the determinant or row-reduce to show the matrix has full rank")
            push!(solution_steps, "The vectors are linearly independent")
        else
            push!(solution_steps, "Row-reduce or find a nontrivial linear combination equal to zero")
            push!(solution_steps, "The vectors are linearly dependent")
        end
        
        problem(
            question=question_text,
            answer=answer,
            difficulty=(2500, 2800),
            answer_type="choice",
            solution=steps(solution_steps...),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad level: Linear independence with parameter
        @variables t k
        
        # Create 3 vectors in R^3 with parameter k
        # Design so independence depends on k value
        critical_value = nonzero(-5, 5)
        
        v1 = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
        v2 = [nonzero(-3, 3), nonzero(-3, 3), nonzero(-3, 3)]
        # Make v3 dependent when k = critical_value
        c1 = nonzero(-2, 2)
        c2 = nonzero(-2, 2)
        v3_base = c1 * v1 + c2 * v2
        
        # Modify one component to include k
        idx = rand(1:3)
        v3 = copy(v3_base)
        v3[idx] = "k"
        
        # When k = critical_value + some offset, vectors are independent
        v3_val = v3_base[idx]
        
        question_text = "For what value(s) of \\(k\\) are the following vectors in \\(\\mathbb{R}^3\\) linearly dependent?\n\n" *
            "\\[\\mathbf{v}_1 = $(fmt_tuple(v1)), \\quad \\mathbf{v}_2 = $(fmt_tuple(v2)), \\quad \\mathbf{v}_3 = " *
            fmt_tuple([i == idx ? "k" : string(v3[i]) for i in 1:3]) * "\\]"
        
        answer = v3_val
        
        problem(
            question=question_text,
            answer=answer,
            difficulty=(2800, 3200),
            solution=steps(
                "Form the matrix \\([\\mathbf{v}_1 \\ \\mathbf{v}_2 \\ \\mathbf{v}_3]\\)",
                "Compute the determinant as a function of \\(k\\)",
                "Set the determinant equal to zero and solve for \\(k\\)",
                sol("Critical value", "k = $v3_val")
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Competition: Span and independence in function spaces
        func_type = rand([:trig, :exp])
        
        if func_type == :trig
            # Check independence of sin, cos combinations
            a = nonzero(-4, 4)
            b = nonzero(-4, 4)
            
            question_text = "Determine whether the functions \\(f_1(x) = \\sin(x)\\), \\(f_2(x) = \\cos(x)\\), and " *
                "\\(f_3(x) = \\sin(x + \\pi/4)\\) are linearly independent on \\(\\mathbb{R}\\)."
            
            answer = "No"
            
            problem(
                question=question_text,
                answer=answer,
                difficulty=(2600, 3000),
                answer_type="choice",
                solution=steps(
                    "Use the angle addition formula: \\(\\sin(x + \\pi/4) = \\frac{\\sqrt{2}}{2}\\sin(x) + \\frac{\\sqrt{2}}{2}\\cos(x)\\)",
                    "This shows \\(f_3 = \\frac{\\sqrt{2}}{2}f_1 + \\frac{\\sqrt{2}}{2}f_2\\)",
                    "Since we found a nontrivial linear combination equal to zero, the functions are dependent",
                    "Answer: No"
                ),
                time=240
            )
        else
            # Exponential functions
            question_text = "Prove or disprove: The functions \\(f_1(x) = e^x\\), \\(f_2(x) = e^{2x}\\), and " *
                "\\(f_3(x) = e^{3x}\\) are linearly independent on \\(\\mathbb{R}\\)."
            
            answer = "Yes"
            
            problem(
                question=question_text,
                answer=answer,
                difficulty=(2700, 3100),
                answer_type="choice",
                solution=steps(
                    "Assume \\(c_1 e^x + c_2 e^{2x} + c_3 e^{3x} = 0\\) for all \\(x\\)",
                    "Differentiate twice to get three equations",
                    "Form a Wronskian or solve the system to show \\(c_1 = c_2 = c_3 = 0\\)",
                    "The functions are linearly independent"
                ),
                time=270
            )
        end
        
    else
        # Olympiad: Maximum size of linearly independent subset
        n = rand(4:5)
        m = n + rand(1:2)
        
        # Create m vectors in R^n where rank is n
        rank_deficiency = rand(0:1)
        actual_rank = n - rank_deficiency
        
        question_text = "Given $m vectors in \\(\\mathbb{R}^{$n}\\), what is the maximum number of vectors " *
            "that can be linearly independent? Justify your answer using the dimension theorem."
        
        answer = n
        
        problem(
            question=question_text,
            answer=answer,
            difficulty=(2400, 2700),
            solution=steps(
                "The dimension of \\(\\mathbb{R}^{$n}\\) is $n",
                "By the dimension theorem, any linearly independent set in \\(\\mathbb{R}^{$n}\\) has at most $n vectors",
                "Since we have $m > $n vectors, at most $n can be linearly independent",
                sol("Maximum size", n)
            ),
            time=180
        )
    end
end