# linear_algebra - determinants (very_easy)
# Generated: 2026-03-08T21:09:09.106732

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/determinants")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # 2x2 determinant - basic recognition (200-400)
        a = randint(-5, 5)
        b = randint(-5, 5)
        c = randint(-5, 5)
        d = randint(-5, 5)
        
        det_val = a*d - b*c
        
        problem(
            question="Calculate the determinant of the matrix \$\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}\$",
            answer=det_val,
            difficulty=(200, 400),
            solution=steps(
                "Given matrix: \$\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}\$",
                "For a 2×2 matrix, det = ad - bc",
                sol("Answer", det_val)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # 2x2 determinant with zero entries (300-500)
        positions = rand(1:4)
        if positions == 1
            a, b, c, d = 0, randint(-8, 8), randint(-8, 8), randint(-8, 8)
        elseif positions == 2
            a, b, c, d = randint(-8, 8), 0, randint(-8, 8), randint(-8, 8)
        elseif positions == 3
            a, b, c, d = randint(-8, 8), randint(-8, 8), 0, randint(-8, 8)
        else
            a, b, c, d = randint(-8, 8), randint(-8, 8), randint(-8, 8), 0
        end
        
        det_val = a*d - b*c
        
        problem(
            question="Find the determinant: \$\\det\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}\$",
            answer=det_val,
            difficulty=(300, 500),
            solution=steps(
                "Matrix: \$\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}\$",
                "Use formula: det = ($a)($d) - ($b)($c)",
                sol("Answer", det_val)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Simple 3x3 determinant with lots of zeros (400-600)
        # Upper triangular or diagonal-ish
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        
        det_val = a * b * c
        
        problem(
            question="Calculate \$\\det\\begin{bmatrix} $a & $(randint(-5,5)) & $(randint(-5,5)) \\\\ 0 & $b & $(randint(-5,5)) \\\\ 0 & 0 & $c \\end{bmatrix}\$",
            answer=det_val,
            difficulty=(400, 600),
            solution=steps(
                "This is an upper triangular matrix",
                "For triangular matrices, det = product of diagonal entries",
                sol("Answer", det_val)
            ),
            time=75
        )
        
    else
        # Determine if matrix is singular (det = 0) (500-700)
        r1 = randint(-5, 5)
        r2 = randint(-5, 5)
        k = choice([2, 3, 4, 5])
        
        # Make second row a multiple of first row
        a = r1
        b = r2
        c = k * r1
        d = k * r2
        
        problem(
            question="Is the matrix \$\\begin{bmatrix} $a & $b \\\\ $c & $d \\end{bmatrix}\$ singular (determinant equals zero)? Answer YES or NO.",
            answer="YES",
            difficulty=(500, 700),
            answer_type="text",
            solution=steps(
                "Calculate determinant: ($a)($d) - ($b)($c) = $(a*d) - $(b*c) = $(a*d - b*c)",
                "Notice that row 2 is $k times row 1",
                "Since det = 0, the matrix is singular. Answer: YES"
            ),
            time=90
        )
    end
end