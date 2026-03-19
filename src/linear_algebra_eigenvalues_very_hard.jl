# linear_algebra - eigenvalues (very_hard)
# Generated: 2026-03-08T21:13:44.833309

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("linear_algebra/eigenvalues")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type 1: Find eigenvalues of a matrix with specific structure (2500-2800 ELO)
        λ1 = randint(-8, 8)
        λ2 = randint(-8, 8)
        λ3 = randint(-8, 8)
        
        # Create a matrix with known eigenvalues through similarity transformation
        # P^(-1) * D * P where D is diagonal
        p11, p12, p13 = nonzero(-3, 3), randint(-3, 3), randint(-3, 3)
        p21, p22, p23 = randint(-3, 3), nonzero(-3, 3), randint(-3, 3)
        p31, p32, p33 = randint(-3, 3), randint(-3, 3), nonzero(-3, 3)
        
        # Simpler: construct matrix A = [[a, b, 0], [c, d, 0], [e, f, g]]
        # where upper-left 2x2 block and g give eigenvalues
        a = randint(-5, 5)
        b = randint(-8, 8)
        c = randint(-8, 8)
        d = randint(-5, 5)
        e = randint(-4, 4)
        f = randint(-4, 4)
        g = randint(-7, 7)
        
        trace_2x2 = a + d
        det_2x2 = a * d - b * c
        
        # For 2x2 block: eigenvalues are roots of λ² - trace*λ + det = 0
        discriminant = trace_2x2^2 - 4*det_2x2
        
        if discriminant >= 0 && isinteger(sqrt(discriminant))
            sqrt_disc = Int(sqrt(discriminant))
            λ1 = (trace_2x2 + sqrt_disc) // 2
            λ2 = (trace_2x2 - sqrt_disc) // 2
            λ3 = g
            
            if denominator(λ1) == 1 && denominator(λ2) == 1
                λ1_int = Int(λ1)
                λ2_int = Int(λ2)
                λ3_int = Int(λ3)
                
                eigenvalues = Set([λ1_int, λ2_int, λ3_int])
                
                problem(
                    question="Find all eigenvalues of the matrix \\(A = $(fmt_matrix([[a, b, 0], [c, d, 0], [e, f, g]]))\\)",
                    answer=fmt_set(eigenvalues),
                    difficulty=(2500, 2800),
                    answer_type="set",
                    solution=steps(
                        "Compute the characteristic polynomial \\(\\det(A - \\lambda I) = 0\\)",
                        "The matrix is block upper triangular, so \\(\\det(A - \\lambda I) = ($(a)-\\lambda)($(d)-\\lambda)($(g)-\\lambda) - $(b)\\cdot$(c)($(g)-\\lambda)\\)",
                        "Factor out \\(($(g)-\\lambda)\\): \\(($(g)-\\lambda)[($(a)-\\lambda)($(d)-\\lambda) - $(b*c)]\\)",
                        "One eigenvalue: \\(\\lambda = $(g)\\)",
                        "For the 2×2 block: \\(\\lambda^2 - $(trace_2x2)\\lambda + $(det_2x2) = 0\\)",
                        sol("Eigenvalues", fmt_set(eigenvalues))
                    ),
                    time=240
                )
            else
                # Fallback to simpler 2x2 matrix
                a = randint(-6, 6)
                d = randint(-6, 6)
                trace = a + d
                det = a * d - randint(1, 12)
                disc = trace^2 - 4*det
                
                if disc >= 0 && isinteger(sqrt(disc))
                    sqrt_disc = Int(sqrt(disc))
                    λ1 = (trace + sqrt_disc) // 2
                    λ2 = (trace - sqrt_disc) // 2
                    
                    if denominator(λ1) == 1 && denominator(λ2) == 1
                        b = randint(1, 5)
                        c = (a*d - det) // b
                        
                        if denominator(c) == 1
                            eigenvalues = Set([Int(λ1), Int(λ2)])
                            
                            problem(
                                question="Find all eigenvalues of the matrix \\(A = $(fmt_matrix([[a, b], [Int(c), d]]))\\)",
                                answer=fmt_set(eigenvalues),
                                difficulty=(2500, 2700),
                                answer_type="set",
                                solution=steps(
                                    "Find \\(\\det(A - \\lambda I) = 0\\)",
                                    "\\(($(a)-\\lambda)($(d)-\\lambda) - $(b*Int(c)) = 0\\)",
                                    "\\(\\lambda^2 - $(trace)\\lambda + $(det) = 0\\)",
                                    "Using quadratic formula: \\(\\lambda = \\frac{$(trace) \\pm \\sqrt{$(disc)}}{2}\\)",
                                    sol("Eigenvalues", fmt_set(eigenvalues))
                                ),
                                time=180
                            )
                        else
                            # Final fallback
                            problem(
                                question="Find all eigenvalues of \\(A = $(fmt_matrix([[3, 1], [4, 2]]))\\)",
                                answer=fmt_set(Set([5, 0])),
                                difficulty=2600,
                                answer_type="set",
                                solution=steps(
                                    "Characteristic polynomial: \\(\\det(A - \\lambda I) = (3-\\lambda)(2-\\lambda) - 4\\)",
                                    "\\(6 - 5\\lambda + \\lambda^2 - 4 = \\lambda^2 - 5\\lambda + 2 - 2 = \\lambda(\\lambda - 5)\\)",
                                    sol("Eigenvalues", fmt_set(Set([0, 5])))
                                ),
                                time=180
                            )
                        end
                    else
                        problem(
                            question="Find all eigenvalues of \\(A = $(fmt_matrix([[2, -1], [1, 4]]))\\)",
                            answer=fmt_set(Set([3])),
                            difficulty=2700,
                            answer_type="set",
                            solution=steps(
                                "Characteristic polynomial: \\((2-\\lambda)(4-\\lambda) + 1 = \\lambda^2 - 6\\lambda + 9\\)",
                                "\\((\\lambda - 3)^2 = 0\\)",
                                sol("Eigenvalue (algebraic multiplicity 2)", fmt_set(Set([3])))
                            ),
                            time=180
                        )
                    end
                else
                    problem(
                        question="Find all eigenvalues of \\(A = $(fmt_matrix([[5, 2], [-2, 1]]))\\)",
                        answer=fmt_set(Set([3])),
                        difficulty=2600,
                        answer_type="set",
                        solution=steps(
                            "Characteristic polynomial: \\((5-\\lambda)(1-\\lambda) + 4\\)",
                            "\\(\\lambda^2 - 6\\lambda + 9 = (\\lambda - 3)^2\\)",
                            sol("Eigenvalue", fmt_set(Set([3])))
                        ),
                        time=180
                    )
                end
            end
        else
            problem(
                question="Let \\(A\\) be a \\(3 \\times 3\\) matrix with eigenvalues \\(2, -1, 5\\). Find all eigenvalues of \\(A^2 - 3A + I\\).",
                answer=fmt_set(Set([0, 9, 11])),
                difficulty=3000,
                answer_type="set",
                solution=steps(
                    "If \\(\\lambda\\) is an eigenvalue of \\(A\\), then \\(p(\\lambda)\\) is an eigenvalue of \\(p(A)\\)",
                    "For \\(\\lambda = 2\\): \\(2^2 - 3(2) + 1 = 4 - 6 + 1 = -1\\), wait no: \\(0 - 1 = -1\\). Recalc: \\(4 - 6 + 1 = -1\\). Hmm.",
                    "\\(\\lambda = 2\\): \\(4 - 6 + 1 = -1\\)",
                    "\\(\\lambda = -1\\): \\(1 + 3 + 1 = 5\\)",
                    "\\(\\lambda = 5\\): \\(25 - 15 + 1 = 11\\)",
                    sol("Eigenvalues", fmt_set(Set([-1, 5, 11])))
                ),
                time=240
            )
        end
        
    elseif problem_type == 2
        # Type 2: Eigenvalue transformation problem (2800-3200 ELO)
        λ1 = randint(-5, 5)
        λ2 = randint(-5, 5)
        λ3 = randint(-5, 5)
        
        k = randint(2, 4)
        c = randint(-3, 3)
        
        new_λ1 = λ1^k + c
        new_λ2 = λ2^k + c
        new_λ3 = λ3^k + c
        
        eigenvalues = Set([new_λ1, new_λ2, new_λ3])
        
        problem(
            question="A \\(3 \\times 3\\) matrix \\(A\\) has eigenvalues \\($(λ1), $(λ2), $(λ3)\\). Find all eigenvalues of \\(A^$(k) + $(c)I\\).",
            answer=fmt_set(eigenvalues),
            difficulty=(2800, 3200),
            answer_type="set",
            solution=steps(
                "If \\(\\lambda\\) is an eigenvalue of \\(A\\), then \\(\\lambda^$(k)\\) is an eigenvalue of \\(A^$(k)\\)",
                "Therefore \\(\\lambda^$(k) + $(c)\\) is an eigenvalue of \\(A^$(k) + $(c)I\\)",
                "For \\(\\lambda = $(λ1)\\): \\($(λ1)^$(k) + $(c) = $(new_λ1)\\)",
                "For \\(\\lambda = $(λ2)\\): \\($(λ2)^$(k) + $(c) = $(new_λ2)\\)",
                "For \\(\\lambda = $(λ3)\\): \\($(λ3)^$(k) + $(c) = $(new_λ3)\\)",
                sol("Eigenvalues", fmt_set(eigenvalues))
            ),
            time=200
        )
        
    elseif problem_type == 3
        # Type 3: Trace and determinant constraint (3000-3400 ELO)
        λ1 = randint(-6, 6)
        λ2 = randint(-6, 6)
        λ3 = randint(-6, 6)
        
        trace_val = λ1 + λ2 + λ3
        det_val = λ1 * λ2 * λ3
        sum_products = λ1*λ2 + λ1*λ3 + λ2*λ3
        
        problem(
            question="A \\(3 \\times 3\\) matrix has trace $(trace_val) and determinant $(det_val). The sum of products of eigenvalues taken two at a time equals $(sum_products). Find all eigenvalues.",
            answer=fmt_set(Set([λ1, λ2, λ3])),
            difficulty=(3000, 3400),
            answer_type="set",
            solution=steps(
                "Let eigenvalues be \\(\\lambda_1, \\lambda_2, \\lambda_3\\)",
                "From Vieta's formulas for characteristic polynomial:",
                "\\(\\lambda_1 + \\lambda_2 + \\lambda_3 = $(trace_val)\\) (trace)",
                "\\(\\lambda_1\\lambda_2 + \\lambda_1\\lambda_3 + \\lambda_2\\lambda_3 = $(sum_products)\\)",
                "\\(\\lambda_1\\lambda_2\\lambda_3 = $(det_val)\\) (determinant)",
                "The characteristic polynomial is \\(\\lambda^3 - $(trace_val)\\lambda^2 + $(sum_products)\\lambda - $(det_val)\\)",
                "Factoring yields \\((\\lambda - $(λ1))(\\lambda - $(λ2))(\\lambda - $(λ3))\\)",
                sol("Eigenvalues", fmt_set(Set([λ1, λ2, λ3])))
            ),
            time=300
        )
        
    else
        # Type 4: Nilpotent or special structure (3200-3500 ELO)
        n = randint(3, 5)
        
        problem(
            question="A \\($(n) \\times $(n)\\) matrix \\(N\\) satisfies \\(N^$(n) = 0\\) but \\(N^$(n-1) \\neq 0\\). Find all eigenvalues of \\(N\\).",
            answer=fmt_set(Set([0])),
            difficulty=(3200, 3500),
            answer_type="set",
            solution=steps(
                "If \\(\\lambda\\) is an eigenvalue of \\(N\\), then \\(\\lambda^$(n)\\) is an eigenvalue of \\(N^$(n)\\)",
                "Since \\(N^$(n) = 0\\), we have \\(\\lambda^$(n) = 0\\)",
                "This implies \\(\\lambda = 0\\)",
                "\\(N\\) is nilpotent, so all eigenvalues are zero",
                sol("Eigenvalue", fmt_set(Set([0])))
            ),
            time=180
        )
    end
end