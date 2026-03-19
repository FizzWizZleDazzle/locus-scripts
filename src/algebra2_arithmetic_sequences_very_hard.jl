# algebra2 - arithmetic_sequences (very_hard)
# Generated: 2026-03-08T20:22:31.906981

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x n begin
    set_topic!("algebra2/arithmetic_sequences")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # COMPETITION: Find term in arithmetic sequence with constraints
        a1 = randint(-30, 30)
        d = nonzero(-8, 8)
        
        # Give two non-consecutive terms and ask for another
        n1 = randint(5, 15)
        n2 = randint(n1 + 5, n1 + 20)
        n_target = randint(30, 100)
        
        term_n1 = a1 + (n1 - 1) * d
        term_n2 = a1 + (n2 - 1) * d
        term_target = a1 + (n_target - 1) * d
        
        problem(
            question="In an arithmetic sequence, the $(n1)th term is $(term_n1) and the $(n2)th term is $(term_n2). Find the $(n_target)th term.",
            answer=term_target,
            difficulty=(2500, 2800),
            solution=steps(
                "Given: a_{$(n1)} = $(term_n1), a_{$(n2)} = $(term_n2)",
                "The difference between terms: $(term_n2) - $(term_n1) = $(term_n2 - term_n1) over $(n2 - n1) steps",
                sol("Common difference", d),
                "Find first term: a_1 = a_{$(n1)} - $(n1-1)d = $(term_n1) - $(n1-1)($(d)) = $(a1)",
                "Apply formula: a_{$(n_target)} = a_1 + $(n_target-1)d = $(a1) + $(n_target-1)($(d))",
                sol("Answer", term_target)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # COMPETITION-OLYMPIAD: Sum with alternating or special constraints
        a1 = randint(-20, 20)
        d = nonzero(-6, 6)
        
        # Find n such that sum equals a specific value
        target_sum = randint(500, 2000)
        
        # S_n = n/2 * (2a1 + (n-1)d) = target_sum
        # n * (2a1 + (n-1)d) = 2*target_sum
        # n * (2a1 - d) + n^2 * d = 2*target_sum
        # d*n^2 + (2a1 - d)*n - 2*target_sum = 0
        
        A = d
        B = 2*a1 - d
        C = -2*target_sum
        
        discriminant = B^2 - 4*A*C
        
        if discriminant >= 0 && A != 0
            n_val = Int(floor((-B + sqrt(discriminant)) / (2*A)))
            if n_val > 0
                actual_sum = div(n_val * (2*a1 + (n_val - 1) * d), 2)
                
                problem(
                    question="An arithmetic sequence has first term $(a1) and common difference $(d). Find the smallest positive integer n such that the sum of the first n terms is at least $(target_sum).",
                    answer=n_val,
                    difficulty=(2800, 3200),
                    solution=steps(
                        "Given: a_1 = $(a1), d = $(d)",
                        "Sum formula: S_n = \\frac{n}{2}(2a_1 + (n-1)d) = \\frac{n}{2}($(2*a1) + $(d)(n-1))",
                        "Set S_n \\geq $(target_sum): \\frac{n}{2}($(2*a1) + $(d)n - $(d)) \\geq $(target_sum)",
                        "Simplify: $(d)n^2 + $(2*a1 - d)n - $(2*target_sum) \\geq 0",
                        "Using quadratic formula: n \\geq \\frac{-$(B) + \\sqrt{$(B^2) + $(4*A*abs(C))}}{$(2*A)}",
                        "Calculate: n \\geq $((-B + sqrt(discriminant)) / (2*A))",
                        sol("Answer", n_val)
                    ),
                    time=240
                )
            else
                # Fallback to simpler problem
                n_val = randint(20, 50)
                sum_val = div(n_val * (2*a1 + (n_val - 1) * d), 2)
                
                problem(
                    question="Find the sum of the first $(n_val) terms of the arithmetic sequence with first term $(a1) and common difference $(d).",
                    answer=sum_val,
                    difficulty=(2600, 2900),
                    solution=steps(
                        "Given: a_1 = $(a1), d = $(d), n = $(n_val)",
                        "Sum formula: S_n = \\frac{n}{2}(2a_1 + (n-1)d)",
                        "Substitute: S_{$(n_val)} = \\frac{$(n_val)}{2}(2($(a1)) + $(n_val-1)($(d)))",
                        "Calculate: S_{$(n_val)} = \\frac{$(n_val)}{2}($(2*a1) + $(d*(n_val-1)))",
                        sol("Answer", sum_val)
                    ),
                    time=180
                )
            end
        else
            # Fallback
            n_val = randint(25, 60)
            sum_val = div(n_val * (2*a1 + (n_val - 1) * d), 2)
            
            problem(
                question="Find the sum of the first $(n_val) terms of the arithmetic sequence with first term $(a1) and common difference $(d).",
                answer=sum_val,
                difficulty=(2600, 2900),
                solution=steps(
                    "Given: a_1 = $(a1), d = $(d), n = $(n_val)",
                    "Sum formula: S_n = \\frac{n}{2}(2a_1 + (n-1)d)",
                    "Substitute: S_{$(n_val)} = \\frac{$(n_val)}{2}(2($(a1)) + $(n_val-1)($(d)))",
                    sol("Answer", sum_val)
                ),
                time=180
            )
        end
        
    elseif problem_type == 3
        # OLYMPIAD: Three terms form arithmetic sequence, solve for parameter
        k = nonzero(-5, 5)
        offset1 = randint(-15, 15)
        offset2 = randint(-15, 15)
        
        # Terms: k*x + offset1, 3*k*x, k*x + offset2
        # For arithmetic: 2*(middle) = first + last
        # 6kx = (kx + offset1) + (kx + offset2)
        # 6kx = 2kx + offset1 + offset2
        # 4kx = offset1 + offset2
        # x = (offset1 + offset2) / (4k)
        
        if 4*k != 0 && (offset1 + offset2) % (4*k) == 0
            x_val = div(offset1 + offset2, 4*k)
            
            problem(
                question="The three numbers \$$(k)x + $(offset1)\$, \$$(3*k)x\$, and \$$(k)x + $(offset2)\$ form an arithmetic sequence in that order. Find the value of x.",
                answer=x_val,
                difficulty=(3000, 3400),
                solution=steps(
                    "Given terms in arithmetic sequence: $(k)x + $(offset1), $(3*k)x, $(k)x + $(offset2)",
                    "Arithmetic sequence property: 2 \\cdot (\\text{middle}) = (\\text{first}) + (\\text{last})",
                    "Set up equation: 2($(3*k)x) = ($(k)x + $(offset1)) + ($(k)x + $(offset2))",
                    "Simplify: $(6*k)x = $(2*k)x + $(offset1 + offset2)",
                    "Solve: $(4*k)x = $(offset1 + offset2)",
                    sol("Answer", x_val)
                ),
                time=200
            )
        else
            # Fallback to ratio problem
            a1 = randint(10, 50)
            d = nonzero(-8, 8)
            n1 = randint(3, 8)
            n2 = randint(n1 + 3, n1 + 10)
            
            term1 = a1 + (n1 - 1) * d
            term2 = a1 + (n2 - 1) * d
            
            if term2 != 0 && gcd(term1, term2) > 1
                g = gcd(abs(term1), abs(term2))
                ratio_num = div(term1, g)
                ratio_den = div(term2, g)
                
                problem(
                    question="In an arithmetic sequence with first term $(a1) and common difference $(d), find the ratio of the $(n1)th term to the $(n2)th term in simplest form. Express as a fraction.",
                    answer=term1 // term2,
                    difficulty=(2700, 3100),
                    solution=steps(
                        "Given: a_1 = $(a1), d = $(d)",
                        "Find a_{$(n1)} = $(a1) + $(n1-1)($(d)) = $(term1)",
                        "Find a_{$(n2)} = $(a1) + $(n2-1)($(d)) = $(term2)",
                        "Ratio: \\frac{$(term1)}{$(term2)} = \\frac{$(ratio_num)}{$(ratio_den)}",
                        sol("Answer", term1 // term2)
                    ),
                    time=180
                )
            else
                problem(
                    question="In an arithmetic sequence with first term $(a1) and common difference $(d), find the $(n1)th term.",
                    answer=term1,
                    difficulty=(2600, 2900),
                    solution=steps(
                        "Given: a_1 = $(a1), d = $(d), n = $(n1)",
                        "Formula: a_n = a_1 + (n-1)d",
                        "Substitute: a_{$(n1)} = $(a1) + $(n1-1)($(d))",
                        sol("Answer", term1)
                    ),
                    time=120
                )
            end
        end
        
    else
        # OLYMPIAD: Maximum/minimum value problem
        a1 = randint(-50, -10)
        d = randint(3, 12)
        
        # Find n where term becomes positive
        # a_n = a1 + (n-1)d > 0
        # (n-1)d > -a1
        # n > 1 - a1/d
        
        n_positive = Int(ceil(1 - a1/d))
        
        # Sum is maximized when we stop before turning positive
        n_max = n_positive - 1
        
        if n_max > 0
            max_sum = div(n_max * (2*a1 + (n_max - 1) * d), 2)
            
            problem(
                question="An arithmetic sequence has first term $(a1) and common difference $(d). All terms are negative until a certain point. Find the minimum value of the sum S_n = a_1 + a_2 + \\cdots + a_n over all positive integers n.",
                answer=max_sum,
                difficulty=(3200, 3600),
                solution=steps(
                    "Given: a_1 = $(a1), d = $(d)",
                    "Find when terms become non-negative: a_n = $(a1) + (n-1)($(d)) \\geq 0",
                    "Solve: n \\geq 1 - \\frac{$(a1)}{$(d)} = $(1 - a1/d)",
                    "First non-negative term is a_{$(n_positive)}",
                    "Minimum sum occurs at n = $(n_max) (before terms become positive)",
                    "S_{$(n_max)} = \\frac{$(n_max)}{2}(2($(a1)) + $(n_max-1)($(d)))",
                    sol("Answer", max_sum)
                ),
                time=280
            )
        else
            # Fallback
            n_val = randint(15, 40)
            sum_val = div(n_val * (2*a1 + (n_val - 1) * d), 2)
            
            problem(
                question="Find the sum of the first $(n_val) terms of an arithmetic sequence with first term $(a1) and common difference $(d).",
                answer=sum_val,
                difficulty=(2600, 2900),
                solution=steps(
                    "Given: a_1 = $(a1), d = $(d), n = $(n_val)",
                    "Sum formula: S_n = \\frac{n}{2}(2a_1 + (n-1)d)",
                    "Substitute: S_{$(n_val)} = \\frac{$(n_val)}{2}($(2*a1) + $(d*(n_val-1)))",
                    sol("Answer", sum_val)
                ),
                time=180
            )
        end
    end
end