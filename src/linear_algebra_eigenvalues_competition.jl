# linear_algebra - eigenvalues (competition)
# Generated: 2026-03-08T21:13:47.585050

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/eigenvalues")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Eigenvalue problem with functional equations
        λ = randint(2, 5)
        k = randint(2, 4)
        n = randint(3, 6)
        
        trace_val = λ^k * n + randint(-3, 3)
        det_val = λ^(k*n) * rand([1, -1])
        
        question = "Let \\(A\\) be an \\($n \\times $n\\) matrix with eigenvalues \\(\\lambda_1, \\lambda_2, \\ldots, \\lambda_n\\). " *
                   "Suppose \\(\\text{tr}(A^$k) = $trace_val\\) and \\(\\det(A^$k) = $det_val\\). " *
                   "If all eigenvalues of \\(A\\) are equal, find the common eigenvalue \\(\\lambda\\)."
        
        answer = λ * rand([1, -1])
        if det_val < 0 && n % 2 == 0
            answer = -λ
        elseif det_val > 0
            answer = λ
        end
        
        solution = steps(
            "Since all eigenvalues are equal to \\(\\lambda\\), we have \\(\\lambda_i = \\lambda\\) for all \\(i\\).",
            sol("Trace condition", "\\text{tr}(A^$k) = \\sum_{i=1}^{$n} \\lambda_i^$k = $n \\lambda^$k = $trace_val"),
            sol("Determinant condition", "\\det(A^$k) = \\prod_{i=1}^{$n} \\lambda_i^$k = \\lambda^{$(k*n)} = $det_val"),
            "From trace: \\(\\lambda^$k = $(trace_val // n)\\), so \\(\\lambda = $(answer)\\)",
            "Verify with determinant: \\($(answer)^{$(k*n)} = $det_val\\) ✓",
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 3800),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 2
        # Characteristic polynomial reconstruction
        n = rand(3:5)
        eigenvals = [randint(-8, 8) for _ in 1:n]
        
        sum_eigs = sum(eigenvals)
        prod_eigs = prod(eigenvals)
        sum_squares = sum(λ^2 for λ in eigenvals)
        
        p = randint(2, 4)
        target_trace = sum(λ^p for λ in eigenvals)
        
        question = "A \\($n \\times $n\\) matrix \\(A\\) has trace \\($sum_eigs\\) and determinant \\($prod_eigs\\). " *
                   "Additionally, \\(\\text{tr}(A^2) = $sum_squares\\). " *
                   "If the eigenvalues are all integers, compute \\(\\text{tr}(A^$p)\\)."
        
        answer = target_trace
        
        solution = steps(
            "Let eigenvalues be \\(\\lambda_1, \\ldots, \\lambda_$n\\).",
            sol("Given", "\\sum \\lambda_i = $sum_eigs, \\quad \\prod \\lambda_i = $prod_eigs, \\quad \\sum \\lambda_i^2 = $sum_squares"),
            "Use Newton's identities and constraints to determine eigenvalues: \\($(join(eigenvals, ", "))\\)",
            "Verify: sum = $(sum(eigenvals)), product = $(prod(eigenvals)), sum of squares = $(sum(λ^2 for λ in eigenvals))",
            sol("Compute", "\\text{tr}(A^$p) = \\sum_{i=1}^{$n} \\lambda_i^$p = $(join(["$λ^$p" for λ in eigenvals], " + ")) = $answer"),
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3700, 4100),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 3
        # Spectral radius and matrix powers
        λ_max = randint(3, 7)
        other_eigs = [randint(-λ_max+1, λ_max-1) for _ in 1:rand(2:3)]
        n = length(other_eigs) + 1
        k = randint(8, 15)
        
        ratio = λ_max^k / sum(abs(λ)^k for λ in [λ_max; other_eigs])
        threshold = round(ratio, digits=3)
        
        question = "Let \\(A\\) be a \\($n \\times $n\\) diagonalizable matrix with spectral radius \\(\\rho(A) = $λ_max\\). " *
                   "The eigenvalues are \\($λ_max\\) and $(join(other_eigs, ", ")). " *
                   "For large \\(k\\), the ratio \\(\\frac{\\|A^k\\|}{\\rho(A)^k}\\) approaches a limiting value. " *
                   "Compute \\(\\lim_{k \\to \\infty} \\frac{\\text{tr}(|A^k|)}{$λ_max^k}\\) where \\(|A^k|\\) denotes entry-wise absolute value."
        
        answer = n
        
        solution = steps(
            "For diagonalizable \\(A\\) with eigenvalues \\(\\lambda_1, \\ldots, \\lambda_$n\\), we have \\(\\text{tr}(A^k) = \\sum \\lambda_i^k\\).",
            sol("Dominant term", "As \\(k \\to \\infty\\), the term \\($λ_max^k\\) dominates all others since \\(|$λ_max| > |\\lambda_i|\\) for \\(i \\neq 1\\)"),
            "In the eigenbasis representation, \\(A^k\\) has largest entries proportional to \\($λ_max^k\\)",
            "The trace of absolute values counts contributions from all eigenvalue directions",
            sol("Limit", "\\lim_{k \\to \\infty} \\frac{\\text{tr}(|A^k|)}{$λ_max^k} = $n (number of dimensions)"),
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3900, 4300),
            solution=solution,
            time=270
        )
        
    elseif problem_type == 4
        # Commutator and simultaneous diagonalization
        a = randint(2, 6)
        b = randint(2, 6)
        c = randint(1, 5)
        
        λ1 = a + b
        λ2 = a - b
        
        question = "Matrices \\(A\\) and \\(B\\) satisfy \\([A, B] = 0\\) (they commute). " *
                   "Matrix \\(A\\) has eigenvalues \\($a\\) and \\($(-a)\\), while \\(B\\) has eigenvalues \\($b\\) and \\($(-b)\\). " *
                   "Both are \\(2 \\times 2\\) matrices. What are the possible eigenvalues of \\(A + B\\)? " *
                   "Enter your answer as a set of integers."
        
        possible = Set([a+b, a-b, -a+b, -a-b])
        answer = fmt_set(possible)
        
        solution = steps(
            "Since \\([A,B] = 0\\), matrices \\(A\\) and \\(B\\) are simultaneously diagonalizable.",
            "They share a common eigenbasis. In this basis, eigenvalues add component-wise.",
            sol("Possible pairs", "(\\lambda_A, \\lambda_B) \\in \\{($a,$b), ($a,$(-b)), ($(-a),$b), ($(-a),$(-b))\\}"),
            sol("Eigenvalues of \\(A+B\\)", "\\{$(a+b), $(a-b), $(-a+b), $(-a-b)\\}"),
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3600, 4000),
            answer_type="set",
            solution=solution,
            time=240
        )
        
    else
        # Perron-Frobenius and non-negative matrices
        n = rand(3:4)
        entries = [randint(1, 5) for _ in 1:n, _ in 1:n]
        
        row_sums = [sum(entries[i,:]) for i in 1:n]
        max_row_sum = maximum(row_sums)
        col_sums = [sum(entries[:,j]) for j in 1:n]
        max_col_sum = maximum(col_sums)
        
        bound = min(max_row_sum, max_col_sum)
        
        question = "A \\($n \\times $n\\) non-negative matrix \\(A\\) has row sums \\($(join(row_sums, ", "))\\) " *
                   "and column sums \\($(join(col_sums, ", "))\\). " *
                   "By the Perron-Frobenius theorem, the spectral radius \\(\\rho(A)\\) satisfies certain bounds. " *
                   "What is the tightest upper bound on \\(\\rho(A)\\) given by \\(\\min(\\max_i \\sum_j a_{ij}, \\max_j \\sum_i a_{ij})\\)?"
        
        answer = bound
        
        solution = steps(
            sol("Row sums", "\\max_i \\sum_j a_{ij} = $max_row_sum"),
            sol("Column sums", "\\max_j \\sum_i a_{ij} = $max_col_sum"),
            "By Perron-Frobenius: \\(\\min_i \\sum_j a_{ij} \\leq \\rho(A) \\leq \\max_i \\sum_j a_{ij}\\)",
            "Similarly for column sums: \\(\\rho(A) \\leq \\max_j \\sum_i a_{ij}\\)",
            sol("Tightest bound", "\\rho(A) \\leq \\min($max_row_sum, $max_col_sum) = $bound"),
            sol("Answer", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4200),
            solution=solution,
            time=210
        )
    end
end