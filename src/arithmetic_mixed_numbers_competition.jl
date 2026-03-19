# arithmetic - mixed_numbers (competition)
# Generated: 2026-03-08T19:49:33.954155

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/mixed_numbers")
    
    # OLYMPIAD to RESEARCH-ADJACENT level (3500-5000 ELO)
    # Theme: Deep properties of mixed number representations and Diophantine constraints
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Find all mixed numbers a b/c where specific algebraic condition holds
        # Example: Find all a b/c where (a + b/c)^2 = a^2 + b^2/c^2 + k for some constraint
        
        # Construct: Need a + b/c such that cross terms satisfy special property
        # (a + b/c)^2 = a^2 + 2ab/c + b^2/c^2
        # For this to equal a^2 + b^2/c^2 + k, we need 2ab/c = k
        
        k = randint(5, 20)
        # So 2ab = kc, where 0 < b < c, gcd(b,c) = 1
        
        # Find valid solutions
        solutions = []
        for a in 1:20
            for c in 2:30
                b = (k * c) ÷ (2 * a)
                if b > 0 && b < c && 2 * a * b == k * c && gcd(b, c) == 1
                    push!(solutions, (a, b, c))
                end
            end
        end
        
        if length(solutions) >= 2
            sol_set = unique(solutions[1:min(5, length(solutions))])
            ans_str = join(["$(a)\\frac{$(b)}{$(c)}" for (a, b, c) in sol_set], ", ")
            
            question = "Find all mixed numbers \\(a\\frac{b}{c}\\) in lowest terms with \\(a \\leq 20\\), \\(c \\leq 30\\) such that \\(\\left(a + \\frac{b}{c}\\right)^2 = a^2 + \\frac{b^2}{c^2} + $(k)\\). List all solutions."
            
            problem(
                question=question,
                answer=ans_str,
                difficulty=(3500, 4000),
                solution=steps(
                    "Expand \\(\\left(a + \\frac{b}{c}\\right)^2 = a^2 + 2a\\frac{b}{c} + \\frac{b^2}{c^2}\\)",
                    "For equality with \\(a^2 + \\frac{b^2}{c^2} + $(k)\\), we need \\(2a\\frac{b}{c} = $(k)\\)",
                    "This gives \\(2ab = $(k)c\\), where \\(\\gcd(b,c) = 1\\) and \\(0 < b < c\\)",
                    "Systematically check divisibility conditions and coprimality constraints",
                    "Solutions: \\($(ans_str)\\)"
                ),
                time=480,
                answer_type="text"
            )
        else
            # Fallback to Type 2
            problem_type = 2
        end
    end
    
    if problem_type == 2
        # Type 2: Egyptian fraction representation with mixed numbers
        # Find ways to express N as sum of distinct unit fractions plus whole part
        
        n = randint(3, 8)
        target = n + 1//2  # e.g., 3.5 = 3 + 1/2
        
        # Create a challenging constraint: express as a + 1/b + 1/c + 1/d where b < c < d
        # and they form an arithmetic or geometric constraint
        
        # Let's use: N + 1/2 = N + 1/b + 1/c where 1/b + 1/c = 1/2
        # So bc = 2(b + c), giving (b-2)(c-2) = 4
        # Solutions: (b,c) = (3,6), (4,4), (6,3) -> use (3,6)
        
        b, c = 3, 6
        
        question = "Prove that \\($(n)\\frac{1}{2}\\) can be uniquely expressed as \\($(n) + \\frac{1}{b} + \\frac{1}{c}\\) where \\(b, c\\) are distinct positive integers with \\(b < c \\leq 10\\). Find \\(b\\) and \\(c\\)."
        
        ans_str = "b = 3, c = 6"
        
        problem(
            question=question,
            answer=ans_str,
            difficulty=(3700, 4200),
            solution=steps(
                "We need \\(\\frac{1}{b} + \\frac{1}{c} = \\frac{1}{2}\\) with \\(2 < b < c \\leq 10\\)",
                "Rewrite: \\(\\frac{b+c}{bc} = \\frac{1}{2}\\), so \\(2(b+c) = bc\\)",
                "Rearrange: \\(bc - 2b - 2c = 0\\), thus \\((b-2)(c-2) = 4\\)",
                "Factor 4: \\((1,4)\\) gives \\((b,c) = (3,6)\\); \\((2,2)\\) gives \\(b=c=4\\) (not distinct)",
                "Unique solution with \\(b < c\\): \\(b = 3, c = 6\\)"
            ),
            time=420,
            answer_type="text"
        )
    elseif problem_type == 3
        # Type 3: Nested mixed number functional equation
        # Find x such that f(x) = x where f involves mixed number operations
        
        # Example: x = a + 1/(b + 1/x) in mixed form, solve for specific constraints
        
        p = randint(3, 12)
        q = randint(2, 8)
        
        # Construct: x = p + 1/(q + 1/x)
        # Then x - p = 1/(q + 1/x)
        # So (x - p)(q + 1/x) = 1
        # qx - pq + 1 - p/x = 1
        # qx - pq - p/x = 0
        # qx^2 - pqx - p = 0
        
        # Solutions: x = (pq ± sqrt(p^2q^2 + 4pq))/(2q)
        # For nice answer, choose p, q so discriminant is perfect square
        
        # Let p = 2, q = 3: disc = 36 + 24 = 60 (not perfect)
        # Let p = 1, q = 2: disc = 4 + 8 = 12 (not perfect)
        # Let p = 2, q = 2: disc = 16 + 16 = 32 (not perfect)
        
        # Use different form: x = a + b/(c + d/x) with specific values
        a = randint(2, 5)
        b = randint(1, 3)
        c = randint(2, 4)
        
        question = "Find all positive real solutions \\(x\\) to the equation \\(x = $(a) + \\frac{$(b)}{$(c) + \\frac{1}{x}}\\). Express your answer as a mixed number in simplest form."
        
        # Solve: x - a = b/(c + 1/x)
        # (x - a)(c + 1/x) = b
        # cx - ac + 1 - a/x = b
        # cx^2 - acx + x - ax = bx
        # cx^2 - (ac + a + b)x + 1 = 0
        
        A = c
        B = -(a*c + a + b)
        C = 1
        
        disc = B^2 - 4*A*C
        if disc >= 0
            x_plus = (-B + sqrt(disc))/(2*A)
            x_floor = floor(Int, x_plus)
            x_frac = x_plus - x_floor
            
            ans_str = string(x_plus)
        else
            ans_str = "No real solution"
        end
        
        problem(
            question=question,
            answer=ans_str,
            difficulty=(3800, 4300),
            solution=steps(
                "Rewrite: \\(x - $(a) = \\frac{$(b)}{$(c) + \\frac{1}{x}}\\)",
                "Multiply both sides by \\($(c) + \\frac{1}{x}\\): \\((x - $(a))\\left($(c) + \\frac{1}{x}\\right) = $(b)\\)",
                "Expand and multiply by \\(x\\): \\($(c)x^2 - $(a*c + a + b)x + 1 = 0\\)",
                "Apply quadratic formula with discriminant \\(\\Delta = $(disc)\\)",
                "Positive solution: \\(x = $(ans_str)\\)"
            ),
            time=540,
            answer_type="text"
        )
    else
        # Type 4: Optimization with mixed number constraints
        # Maximize/minimize expression involving mixed numbers under Diophantine constraints
        
        k = randint(15, 40)
        
        question = "Find positive integers \\(a, b, c\\) with \\(\\gcd(b, c) = 1\\), \\(0 < b < c \\leq 20\\), and \\(a \\leq 10\\) such that \\(a\\frac{b}{c}\\) is as close as possible to \\(\\sqrt{$(k)}\\). What is this optimal mixed number?"
        
        target = sqrt(k)
        best_diff = Inf
        best_a, best_b, best_c = 1, 1, 2
        
        for a in 1:10
            for c in 2:20
                for b in 1:(c-1)
                    if gcd(b, c) == 1
                        val = a + b/c
                        diff = abs(val - target)
                        if diff < best_diff
                            best_diff = diff
                            best_a, best_b, best_c = a, b, c
                        end
                    end
                end
            end
        end
        
        ans_str = "$(best_a)\\frac{$(best_b)}{$(best_c)}"
        
        problem(
            question=question,
            answer=ans_str,
            difficulty=(4000, 4500),
            solution=steps(
                "Target value: \\(\\sqrt{$(k)} \\approx $(round(target, digits=5))\\)",
                "Search space: \\(a \\in [1,10]\\), \\(c \\in [2,20]\\), \\(b \\in [1,c-1]\\) with \\(\\gcd(b,c)=1\\)",
                "Systematically compute \\(a + \\frac{b}{c}\\) for all valid combinations",
                "Track minimum \\(|a + \\frac{b}{c} - \\sqrt{$(k)}|\\)",
                "Optimal: \\($(ans_str) = $(round(best_a + best_b/best_c, digits=5))\\) with error \\($(round(best_diff, digits=6))\\)"
            ),
            time=600,
            answer_type="text"
        )
    end
end