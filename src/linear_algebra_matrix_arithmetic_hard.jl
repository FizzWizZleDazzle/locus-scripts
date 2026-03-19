# linear_algebra - matrix_arithmetic (hard)
# Generated: 2026-03-08T21:08:03.973274

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/matrix_arithmetic")
    
    problem_type = choice([:determinant_2x2, :determinant_3x3, :inverse_2x2, :matrix_power, :trace_computation, :eigenvalue_sum])
    
    if problem_type == :determinant_2x2
        a, b = randint(-15, 15), randint(-15, 15)
        c, d = randint(-15, 15), randint(-15, 15)
        det_val = a*d - b*c
        while abs(det_val) < 5 || abs(det_val) > 200
            a, b = randint(-15, 15), randint(-15, 15)
            c, d = randint(-15, 15), randint(-15, 15)
            det_val = a*d - b*c
        end
        
        matrix_str = "\\begin{pmatrix} $a & $b \\\\ $c & $d \\end{pmatrix}"
        
        problem(
            question="Compute the determinant of the matrix \$A = $matrix_str\$",
            answer=det_val,
            difficulty=(1800, 2000),
            solution=steps(
                "Given matrix: \$A = $matrix_str\$",
                "For a 2×2 matrix, \$\\det(A) = ad - bc\$",
                sol("Calculation", "\\det(A) = ($a)($d) - ($b)($c) = $(a*d) - $(b*c) = $det_val"),
            ),
            time=90,
        )
        
    elseif problem_type == :determinant_3x3
        a11, a12, a13 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        a21, a22, a23 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        a31, a32, a33 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
        
        minor1 = a22*a33 - a23*a32
        minor2 = a21*a33 - a23*a31
        minor3 = a21*a32 - a22*a31
        det_val = a11*minor1 - a12*minor2 + a13*minor3
        
        while abs(det_val) < 10 || abs(det_val) > 300
            a11, a12, a13 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
            a21, a22, a23 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
            a31, a32, a33 = randint(-8, 8), randint(-8, 8), randint(-8, 8)
            minor1 = a22*a33 - a23*a32
            minor2 = a21*a33 - a23*a31
            minor3 = a21*a32 - a22*a31
            det_val = a11*minor1 - a12*minor2 + a13*minor3
        end
        
        matrix_str = "\\begin{pmatrix} $a11 & $a12 & $a13 \\\\ $a21 & $a22 & $a23 \\\\ $a31 & $a32 & $a33 \\end{pmatrix}"
        
        problem(
            question="Compute the determinant of the matrix \$A = $matrix_str\$",
            answer=det_val,
            difficulty=(2000, 2200),
            solution=steps(
                "Given matrix: \$A = $matrix_str\$",
                "Expand along the first row using cofactor expansion:",
                sol("\\det(A) = $a11 \\cdot ($minor1) - $a12 \\cdot ($minor2) + $a13 \\cdot ($minor3)"),
                sol("\\det(A) = $(a11*minor1) - $(a12*minor2) + $(a13*minor3) = $det_val"),
            ),
            time=180,
        )
        
    elseif problem_type == :inverse_2x2
        a, b = randint(-10, 10), randint(-10, 10)
        c, d = randint(-10, 10), randint(-10, 10)
        det_val = a*d - b*c
        
        while det_val == 0 || abs(det_val) > 20 || abs(det_val) < 2
            a, b = randint(-10, 10), randint(-10, 10)
            c, d = randint(-10, 10), randint(-10, 10)
            det_val = a*d - b*c
        end
        
        inv_11 = d // det_val
        inv_12 = -b // det_val
        inv_21 = -c // det_val
        inv_22 = a // det_val
        
        matrix_str = "\\begin{pmatrix} $a & $b \\\\ $c & $d \\end{pmatrix}"
        inv_str = "\\begin{pmatrix} $(inv_11) & $(inv_12) \\\\ $(inv_21) & $(inv_22) \\end{pmatrix}"
        
        problem(
            question="Find the inverse of the matrix \$A = $matrix_str\$. Express entries as fractions.",
            answer=inv_str,
            difficulty=(1900, 2100),
            answer_type="matrix",
            solution=steps(
                "Given matrix: \$A = $matrix_str\$",
                sol("\\det(A)", "$det_val"),
                "For a 2×2 matrix, \$A^{-1} = \\frac{1}{\\det(A)} \\begin{pmatrix} d & -b \\\\ -c & a \\end{pmatrix}\$",
                sol("A^{-1}", inv_str),
            ),
            time=150,
        )
        
    elseif problem_type == :matrix_power
        a = randint(-5, 5)
        d = randint(-5, 5)
        while abs(a) < 2 || abs(d) < 2 || a == d
            a = randint(-5, 5)
            d = randint(-5, 5)
        end
        
        n = randint(4, 7)
        a_n = a^n
        d_n = d^n
        
        matrix_str = "\\begin{pmatrix} $a & 0 \\\\ 0 & $d \\end{pmatrix}"
        result_str = "\\begin{pmatrix} $a_n & 0 \\\\ 0 & $d_n \\end{pmatrix}"
        
        problem(
            question="Compute \$A^{$n}\$ where \$A = $matrix_str\$",
            answer=result_str,
            difficulty=(1800, 2000),
            answer_type="matrix",
            solution=steps(
                "Given matrix: \$A = $matrix_str\$ (diagonal matrix)",
                "For a diagonal matrix \$D\$, \$D^n\$ is obtained by raising each diagonal entry to the \$n\$-th power",
                sol("A^{$n}", result_str),
            ),
            time=120,
        )
        
    elseif problem_type == :trace_computation
        a, b = randint(-12, 12), randint(-12, 12)
        c, d = randint(-12, 12), randint(-12, 12)
        e, f = randint(-12, 12), randint(-12, 12)
        g, h = randint(-12, 12), randint(-12, 12)
        
        trace_A = a + d
        trace_B = e + h
        result = 3*trace_A - 2*trace_B
        
        matrix_A = "\\begin{pmatrix} $a & $b \\\\ $c & $d \\end{pmatrix}"
        matrix_B = "\\begin{pmatrix} $e & $f \\\\ $g & $h \\end{pmatrix}"
        
        problem(
            question="Let \$A = $matrix_A\$ and \$B = $matrix_B\$. Compute \$\\text{tr}(3A - 2B)\$, where \$\\text{tr}\$ denotes the trace.",
            answer=result,
            difficulty=(1900, 2100),
            solution=steps(
                "Recall: \$\\text{tr}(cA + dB) = c\\cdot\\text{tr}(A) + d\\cdot\\text{tr}(B)\$ (trace is linear)",
                sol("\\text{tr}(A)", "$trace_A"),
                sol("\\text{tr}(B)", "$trace_B"),
                sol("\\text{tr}(3A - 2B)", "3($trace_A) - 2($trace_B) = $(3*trace_A) - $(2*trace_B) = $result"),
            ),
            time=120,
        )
        
    else  # eigenvalue_sum
        a = randint(-10, 10)
        d = randint(-10, 10)
        b = randint(-8, 8)
        c = randint(-8, 8)
        
        while abs(b*c) > 50
            b = randint(-8, 8)
            c = randint(-8, 8)
        end
        
        trace_val = a + d
        det_val = a*d - b*c
        
        discriminant = trace_val^2 - 4*det_val
        
        while discriminant < 0
            a = randint(-10, 10)
            d = randint(-10, 10)
            b = randint(-8, 8)
            c = randint(-8, 8)
            trace_val = a + d
            det_val = a*d - b*c
            discriminant = trace_val^2 - 4*det_val
        end
        
        matrix_str = "\\begin{pmatrix} $a & $b \\\\ $c & $d \\end{pmatrix}"
        
        problem(
            question="Find the sum of the eigenvalues of the matrix \$A = $matrix_str\$",
            answer=trace_val,
            difficulty=(2100, 2300),
            solution=steps(
                "Given matrix: \$A = $matrix_str\$",
                "By a fundamental theorem in linear algebra, the sum of eigenvalues equals the trace of the matrix",
                sol("\\text{tr}(A)", "$a + $d = $trace_val"),
                "Therefore, the sum of eigenvalues is \$\\boxed{$trace_val}\$",
            ),
            time=120,
        )
    end
end