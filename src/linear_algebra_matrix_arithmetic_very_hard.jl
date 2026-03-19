# linear_algebra - matrix_arithmetic (very_hard)
# Generated: 2026-03-08T21:08:30.014540

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_arithmetic")
    
    # Competition to Olympiad level: 2500-3500 ELO
    # These problems involve sophisticated matrix manipulations, eigenvalue-like properties,
    # pattern recognition, and deep structural insights
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Nilpotent matrix power problem
        # Pick a nilpotent index
        k = rand(3:5)
        n = rand(3:4)
        
        # Construct a nilpotent matrix (strictly upper triangular)
        A = zeros(Int, n, n)
        for i in 1:n
            for j in i+1:n
                A[i,j] = randint(-3, 3)
            end
        end
        
        # Ensure it's actually nilpotent at index k by construction
        # For strictly upper triangular n×n matrix, A^n = 0
        nilpotent_index = n
        
        # Find the smallest m such that A^m + A^(m+1) + ... + A^(m+k-1) = 0
        # Since A^n = 0, any sum starting at m >= n will be 0
        answer = n
        
        A_str = fmt_matrix(A)
        
        problem(
            question="Let \$A = $A_str\$. Find the smallest positive integer \$m\$ such that \$A^m + A^{m+1} + A^{m+2} + \\cdots + A^{m+$(k-1)} = O\$ (the zero matrix).",
            answer=answer,
            difficulty=(2600, 3000),
            solution=steps(
                "Observe that \$A\$ is strictly upper triangular",
                "For an \$n \\times n\$ strictly upper triangular matrix, \$A^n = O\$",
                sol("Therefore, \$A^{$(n)} = O\$, and all higher powers are zero"),
                "Any sum \$A^m + A^{m+1} + \\cdots + A^{m+$(k-1)} = O\$ when \$m \\geq $(n)\$",
                sol("Smallest such \$m\$", answer)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Matrix commutator with specific structure
        # Find all 2×2 matrices that commute with a given matrix
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        # Matrix of form [a, b; 0, a] (Jordan block)
        A = [[a, b], [0, a]]
        
        # Matrices that commute: [x, y; 0, x] for any x, y
        # So the answer involves 2 free parameters
        
        A_str = fmt_matrix(A)
        
        problem(
            question="Let \$A = $A_str\$. Find all \$2 \\times 2\$ matrices \$B\$ such that \$AB = BA\$. Express your answer in terms of the number of free parameters required to describe all such matrices.",
            answer=2,
            difficulty=(2700, 3100),
            solution=steps(
                sol("Given", "A = $A_str"),
                "Let \$B = \\begin{pmatrix} x & y \\\\ z & w \\end{pmatrix}\$",
                "Compute \$AB\$: \$\\begin{pmatrix} $(a)x & $(a)y + $(b)z \\\\ 0 & $(a)w \\end{pmatrix}\$",
                "Compute \$BA\$: \$\\begin{pmatrix} $(a)x + $(b)z & $(b)x \\\\ $(a)z & $(b)z + $(a)w \\end{pmatrix}\$",
                "Equating entries: \$$(b)z = 0\$, so \$z = 0\$; and \$$(a)y = $(b)x\$, and \$x = w\$",
                "Therefore \$B = \\begin{pmatrix} x & y \\\\ 0 & x \\end{pmatrix}\$ with \$x, y\$ free",
                sol("Number of free parameters", 2)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Trace and determinant constraint problem
        # Find number of 2×2 integer matrices with specific trace and determinant
        
        tr = rand(2:6)
        det_val = rand(1:5)
        
        # For [[a,b],[c,d]]: trace = a+d = tr, det = ad-bc = det_val
        # So d = tr-a, and a(tr-a) - bc = det_val
        # This gives bc = a*tr - a^2 - det_val
        
        # Count integer solutions
        count = 0
        solutions = []
        for a in -20:20
            for b in -20:20
                for c in -20:20
                    d = tr - a
                    if a*d - b*c == det_val
                        count += 1
                        if count <= 3
                            push!(solutions, [[a,b],[c,d]])
                        end
                    end
                end
            end
        end
        
        # Actually, this gives too many. Let's make it finite by restricting entries
        count = 0
        for a in -5:5
            for b in -5:5
                for c in -5:5
                    d = tr - a
                    if abs(d) <= 5 && a*d - b*c == det_val
                        count += 1
                    end
                end
            end
        end
        
        problem(
            question="How many \$2 \\times 2\$ matrices with integer entries in \$\\{-5, -4, \\ldots, 4, 5\\}\$ have trace equal to \$$(tr)\$ and determinant equal to \$$(det_val)\$?",
            answer=count,
            difficulty=(2800, 3200),
            solution=steps(
                "For matrix \$\\begin{pmatrix} a & b \\\\ c & d \\end{pmatrix}\$, we need \$a + d = $(tr)\$ and \$ad - bc = $(det_val)\$",
                "From trace: \$d = $(tr) - a\$",
                "Substituting into determinant: \$a($(tr) - a) - bc = $(det_val)\$",
                "This gives \$bc = $(tr)a - a^2 - $(det_val)\$",
                "Systematically enumerate all valid \$a, b, c\$ in \$\\{-5, \\ldots, 5\\}\$ satisfying these constraints",
                sol("Total count", count)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Matrix power with pattern recognition
        # Compute A^n for specific structured matrix
        
        # Use matrix [[1, 1], [0, 1]] which has A^n = [[1, n], [0, 1]]
        n_val = rand(15:30)
        
        A = [[1, 1], [0, 1]]
        A_str = fmt_matrix(A)
        
        # Answer: upper-right entry is n_val
        answer = n_val
        
        problem(
            question="Let \$A = $A_str\$. Find the entry in the first row, second column of \$A^{$(n_val)}\$.",
            answer=answer,
            difficulty=(2500, 2900),
            solution=steps(
                sol("Given", "A = $A_str"),
                "Compute small powers: \$A^2 = \\begin{pmatrix} 1 & 2 \\\\ 0 & 1 \\end{pmatrix}\$, \$A^3 = \\begin{pmatrix} 1 & 3 \\\\ 0 & 1 \\end{pmatrix}\$",
                "Pattern recognition: \$A^k = \\begin{pmatrix} 1 & k \\\\ 0 & 1 \\end{pmatrix}\$",
                "Proof by induction: \$A^{k+1} = A^k \\cdot A = \\begin{pmatrix} 1 & k \\\\ 0 & 1 \\end{pmatrix} \\begin{pmatrix} 1 & 1 \\\\ 0 & 1 \\end{pmatrix} = \\begin{pmatrix} 1 & k+1 \\\\ 0 & 1 \\end{pmatrix}\$",
                sol("Therefore, the (1,2)-entry of \$A^{$(n_val)}\$ is", answer)
            ),
            time=210
        )
        
    else
        # Rank and nullity problem with parametric matrix
        # Find parameter values for specific rank
        
        k = nonzero(-6, 6)
        target_rank = rand(1:2)
        
        # Matrix [[k, 2k], [3, 6]] has rank 1 when k ≠ 0, rank 0 when both rows zero (impossible here)
        # To have rank 2, need k/2k ≠ 3/6, i.e., 1/2 ≠ 1/2 (always false), so rank is always 1
        
        # Better: [[k, k^2], [1, k]] has rank 1 when k^2 = k, i.e., k = 0 or 1
        # Otherwise rank 2
        
        # Actually use: [[k, 2], [k^2, 2k]]
        # Rank 1 when rows proportional: k^2/k = 2k/2, i.e., k = k, always true? No.
        # k^2 * 2 = k * 2k gives 2k^2 = 2k^2, always true
        # Let me use [[1, k], [k, k^2]]
        # Determinant = k^2 - k^2 = 0 always, so rank is always < 2
        
        # Use [[2, k], [k, k+1]]
        # det = 2(k+1) - k^2 = 2k + 2 - k^2 = -k^2 + 2k + 2
        # Rank 2 when det ≠ 0: k^2 - 2k - 2 ≠ 0
        # Rank 1 when det = 0: k^2 = 2k + 2, k^2 - 2k - 2 = 0
        # k = (2 ± √(4 + 8))/2 = (2 ± √12)/2 = 1 ± √3
        
        val1 = 1 + sqrt(3)
        val2 = 1 - sqrt(3)
        
        if target_rank == 1
            answer = "1 ± √3"
            answer_numeric = Set([round(val1, digits=3), round(val2, digits=3)])
        else
            answer = "all k ≠ 1 ± √3"
            answer_numeric = "infinitely many"
        end
        
        A_param = "\\begin{pmatrix} 2 & k \\\\ k & k+1 \\end{pmatrix}"
        
        problem(
            question="For what values of \$k\$ does the matrix \$A = $(A_param)\$ have rank exactly \$$(target_rank)\$? If there are finitely many values, give them in exact form.",
            answer=(target_rank == 1 ? "k = 1 + √3 or k = 1 - √3" : "all k except 1 ± √3"),
            difficulty=(2900, 3400),
            answer_type="text",
            solution=steps(
                sol("Given", "A = $(A_param)"),
                "Compute determinant: \$\\det(A) = 2(k+1) - k^2 = -k^2 + 2k + 2\$",
                (target_rank == 1 ? "Rank 1 requires \$\\det(A) = 0\$: \$k^2 - 2k - 2 = 0\$" : "Rank 2 requires \$\\det(A) \\neq 0\$: \$k^2 - 2k - 2 \\neq 0\$"),
                (target_rank == 1 ? "Solving: \$k = \\frac{2 \\pm \\sqrt{4 + 8}}{2} = 1 \\pm \\sqrt{3}\$" : "So \$k \\neq 1 \\pm \\sqrt{3}\$"),
                sol("Answer", (target_rank == 1 ? "\$k = 1 + \\sqrt{3}\$ or \$k = 1 - \\sqrt{3}\$" : "All \$k \\neq 1 \\pm \\sqrt{3}\$"))
            ),
            time=280
        )
    end
end