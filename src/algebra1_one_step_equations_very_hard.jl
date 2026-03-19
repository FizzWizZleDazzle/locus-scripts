# algebra1 - one_step_equations (very_hard)
# Generated: 2026-03-08T19:52:47.992866

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/one_step_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition: Diophantine-flavored one-step with constraints
        # Find all integer solutions to ax ≡ b (mod m) where |x| ≤ N
        a = nonzero(3, 15)
        m = randint(17, 37)
        # Ensure gcd(a, m) = 1 for unique solution mod m
        while gcd(a, m) != 1
            a = nonzero(3, 15)
        end
        b = randint(1, m-1)
        N = randint(50, 150)
        
        # Solve ax ≡ b (mod m)
        # Find modular inverse of a mod m
        inv_a = invmod(a, m)
        x0 = mod(inv_a * b, m)
        
        # Find all solutions |x| ≤ N
        solutions = Set{Int}()
        k = -div(N + x0, m) - 1
        while true
            x_sol = x0 + k * m
            if abs(x_sol) <= N
                push!(solutions, x_sol)
                k += 1
            elseif x_sol > N
                break
            else
                k += 1
            end
        end
        
        problem(
            question="Find all integers \\(x\\) with \\(|x| \\leq $N\\) such that \\[$a x \\equiv $b \\pmod{$m}\\]",
            answer=fmt_set(solutions),
            difficulty=(2500, 2800),
            answer_type="set",
            solution=steps(
                "Given: \\($a x \\equiv $b \\pmod{$m}\\) with \\(|x| \\leq $N\\)",
                "Since \\(\\gcd($a, $m) = 1\\), we find \\($a^{-1} \\equiv $inv_a \\pmod{$m}\\)",
                "Base solution: \\(x_0 \\equiv $inv_a \\cdot $b \\equiv $x0 \\pmod{$m}\\)",
                "General solution: \\(x = $x0 + $m k\\) for integer \\(k\\)",
                "Find \\(k\\) such that \\(|$x0 + $m k| \\leq $N\\)",
                sol("Solutions", fmt_set(solutions))
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad: Functional equation one-step
        # Find all functions f: ℤ → ℤ such that f(x+a) = f(x) + b for all x
        a = nonzero(2, 8)
        b = nonzero(-12, 12)
        c = randint(-20, 20)
        
        # General solution: f(x) = (b/a)x + g(x mod a) where g is arbitrary on {0,1,...,a-1}
        # But since f: ℤ → ℤ, we need b divisible by a for linear solutions
        needs_linear = (b % a == 0)
        
        if needs_linear
            slope = div(b, a)
            problem(
                question="Let \\(f: \\mathbb{Z} \\to \\mathbb{Z}\\) satisfy \\(f(x + $a) = f(x) + $b\\) for all integers \\(x\\). Additionally, suppose \\(f\\) is linear (of the form \\(f(x) = mx + c\\) for constants \\(m, c\\)). Given \\(f(0) = $c\\), find \\(f($(10*a))\\).",
                answer=slope * 10 * a + c,
                difficulty=(2800, 3200),
                solution=steps(
                    "From \\(f(x+$a) = f(x) + $b\\), substitute \\(f(x) = mx + c\\)",
                    "Then \\(m(x+$a) + c = mx + c + $b\\), giving \\($(a)m = $b\\)",
                    "Thus \\(m = $slope\\) and \\(f(x) = $(slope)x + c\\)",
                    "With \\(f(0) = $c\\), we have \\(f(x) = $(slope)x + $c\\)",
                    sol("Answer", "f($(10*a)) = $(slope * 10 * a + c)")
                ),
                time=300
            )
        else
            # Non-linear case: use periodicity
            problem(
                question="Let \\(f: \\mathbb{Z} \\to \\mathbb{Z}\\) satisfy \\(f(x + $a) = f(x) + $b\\) for all integers \\(x\\). Given \\(f(0) = $c\\), find \\(f($((10*a)))\\).",
                answer=10*b + c,
                difficulty=(3000, 3400),
                solution=steps(
                    "Apply the functional equation repeatedly:",
                    "\\(f($a) = f(0) + $b = $c + $b = $(c+b)\\)",
                    "\\(f(2 \\cdot $a) = f($a) + $b = $(c+b) + $b = $(c+2*b)\\)",
                    "By induction: \\(f(n \\cdot $a) = f(0) + n \\cdot $b = $c + $(b)n\\)",
                    sol("Answer", "f($(10*a)) = $c + 10 \\cdot $b = $(10*b + c)")
                ),
                time=280
            )
        end
        
    elseif problem_type == 3
        # Competition: Matrix equation (one-step in matrix space)
        # Solve AX = B for 2×2 matrix X
        a11, a12 = nonzero(-4, 4), nonzero(-4, 4)
        a21, a22 = nonzero(-4, 4), nonzero(-4, 4)
        det_a = a11*a22 - a12*a21
        while det_a == 0
            a22 = nonzero(-4, 4)
            det_a = a11*a22 - a12*a21
        end
        
        x11, x12 = randint(-6, 6), randint(-6, 6)
        x21, x22 = randint(-6, 6), randint(-6, 6)
        
        b11 = a11*x11 + a12*x21
        b12 = a11*x12 + a12*x22
        b21 = a21*x11 + a22*x21
        b22 = a21*x12 + a22*x22
        
        inv_det = 1//det_a
        ainv11 = a22 * inv_det
        ainv12 = -a12 * inv_det
        ainv21 = -a21 * inv_det
        ainv22 = a11 * inv_det
        
        problem(
            question="Solve for the matrix \\(X\\): \\[\\begin{pmatrix} $a11 & $a12 \\\\ $a21 & $a22 \\end{pmatrix} X = \\begin{pmatrix} $b11 & $b12 \\\\ $b21 & $b22 \\end{pmatrix}\\]",
            answer=fmt_matrix([[x11, x12], [x21, x22]]),
            difficulty=(2400, 2700),
            answer_type="matrix",
            solution=steps(
                "Compute \\(\\det(A) = $a11 \\cdot $a22 - $a12 \\cdot $a21 = $det_a\\)",
                "Find \\(A^{-1} = \\frac{1}{$det_a}\\begin{pmatrix} $a22 & $(-a12) \\\\ $(-a21) & $a11 \\end{pmatrix}\\)",
                "Then \\(X = A^{-1}B\\)",
                "Computing the product:",
                sol("Answer", fmt_matrix([[x11, x12], [x21, x22]]))
            ),
            time=270
        )
        
    else
        # Olympiad: Nested radical equation (one algebraic step after setup)
        # Solve √(a + √(b + √(c + x))) = d where answer is engineered
        ans = randint(5, 50)
        d = randint(3, 7)
        inner = d^2
        c_plus_ans = inner - randint(1, 8)
        c = c_plus_ans - ans
        
        b_val = (inner)^2 - randint(2, 15)
        b = b_val - c_plus_ans
        
        a = (inner)^2 - b_val
        
        # Verify: a + √(b + √(c + ans)) should equal d^2
        
        problem(
            question="Solve for \\(x\\): \\[\\sqrt{$a + \\sqrt{$b + \\sqrt{$c + x}}} = $d\\]",
            answer=ans,
            difficulty=(3200, 3600),
            solution=steps(
                "Square both sides: \\($a + \\sqrt{$b + \\sqrt{$c + x}} = $(d^2)\\)",
                "Isolate inner radical: \\(\\sqrt{$b + \\sqrt{$c + x}} = $(d^2 - a)\\)",
                "Square again: \\($b + \\sqrt{$c + x} = $((d^2-a)^2)\\)",
                "Isolate: \\(\\sqrt{$c + x} = $((d^2-a)^2 - b)\\)",
                "Square once more: \\($c + x = $(((d^2-a)^2 - b)^2)\\)",
                sol("Answer", "x = $(ans)")
            ),
            time=300
        )
    end
end