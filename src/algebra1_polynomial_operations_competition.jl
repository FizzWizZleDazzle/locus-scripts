# algebra1 - polynomial_operations (competition)
# Generated: 2026-03-08T19:59:41.987671

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/polynomial_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Find polynomial P(x) such that P(P(x)) has specific properties
        # Difficulty: 3000-3500
        a = nonzero(-3, 3)
        b = nonzero(-5, 5)
        c = nonzero(-8, 8)
        
        # We want P(x) = ax + b such that P(P(x)) = a²x + ab + b
        # Given that P(P(x)) - x = k has exactly one solution
        # This means a²x + ab + b - x = k
        # (a² - 1)x + (ab + b) = k
        # For exactly one solution, need a² = 1, so a = ±1
        a = rand([1, -1]) * rand(2:4)
        
        pp_expr = expand(a*(a*x + b) + b)
        condition_val = randint(-15, 15)
        
        # Number of real solutions to P(P(x)) = condition_val
        sols = solve(pp_expr ~ condition_val, x)
        
        question = "Let P(x) = $(tex(a*x + b)). Find all real solutions to P(P(x)) = $(condition_val). Enter your answer as a set."
        
        answer_set = Set([substitute(s, Dict()) for s in sols])
        ans = fmt_set(answer_set)
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3000, 3500),
            answer_type="set",
            solution=steps(
                sol("Given P(x)", a*x + b),
                sol("Compute P(P(x))", pp_expr),
                sol("Solve", pp_expr ~ condition_val),
                "Solution set: $(ans)"
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad: Polynomial divisibility and remainder theorem with composition
        # Difficulty: 3500-4000
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        r3 = nonzero(-8, 8)
        while r3 == r1 || r3 == r2
            r3 = nonzero(-8, 8)
        end
        
        # P(x) with known roots
        lead = nonzero(-2, 2)
        p_expr = expand(lead * (x - r1) * (x - r2) * (x - r3))
        
        # Find P(x²) at a specific value
        eval_point = nonzero(2, 5)
        p_x2 = substitute(p_expr, x => x^2)
        result = substitute(p_x2, x => eval_point)
        
        question = "Let P(x) = $(tex(p_expr)). Compute P($(eval_point)²)."
        
        problem(
            question=question,
            answer=result,
            difficulty=(3200, 3600),
            solution=steps(
                sol("Given P(x)", p_expr),
                "We need P($(eval_point^2))",
                sol("Substitute x = $(eval_point^2)", substitute(p_expr, x => eval_point^2)),
                sol("Answer", result)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Research-adjacent: Symmetric polynomial identity
        # Difficulty: 4000-4500
        @variables a b c
        
        # Coefficients for a cubic
        p = nonzero(-4, 4)
        q = nonzero(-6, 6)
        r = nonzero(-8, 8)
        
        # If x³ + px² + qx + r = 0 has roots α, β, γ
        # By Vieta: α+β+γ = -p, αβ+βγ+γα = q, αβγ = -r
        # Find α² + β² + γ²
        
        sum_roots = -p
        sum_pairs = q
        product = -r
        
        # α² + β² + γ² = (α+β+γ)² - 2(αβ+βγ+γα)
        ans = sum_roots^2 - 2*sum_pairs
        
        question = "The polynomial \$x^3 + $(p)x^2 + $(q)x + $(r)\$ has roots α, β, and γ. Find the value of α² + β² + γ²."
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3800, 4200),
            solution=steps(
                "By Vieta's formulas: α + β + γ = $(sum_roots), αβ + βγ + γα = $(sum_pairs)",
                "Use identity: α² + β² + γ² = (α + β + γ)² - 2(αβ + βγ + γα)",
                sol("Compute", "($(sum_roots))² - 2($(sum_pairs))"),
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Olympiad: Polynomial inequality with constraints
        # Difficulty: 3600-4000
        n = rand(3:5)
        coeffs = [nonzero(-3, 3) for _ in 1:n]
        lead = nonzero(1, 3)
        
        # Build polynomial with specific degree
        poly = lead * x^n
        for i in 1:length(coeffs)
            poly += coeffs[i] * x^(n-i)
        end
        
        # Find where derivative equals zero
        dpoly = diff(poly, x)
        
        # For a nice answer, evaluate at integer
        eval_pt = nonzero(-5, 5)
        derivative_value = substitute(dpoly, x => eval_pt)
        
        question = "Let P(x) = $(tex(poly)). Compute P'($(eval_pt))."
        
        problem(
            question=question,
            answer=derivative_value,
            difficulty=(3400, 3800),
            solution=steps(
                sol("Given P(x)", poly),
                sol("Differentiate P'(x)", dpoly),
                sol("Evaluate at x = $(eval_pt)", substitute(dpoly, x => eval_pt)),
                sol("Answer", derivative_value)
            ),
            time=200
        )
        
    else
        # Research-adjacent: System involving polynomial composition
        # Difficulty: 4200-4800
        a1 = nonzero(-3, 3)
        b1 = nonzero(-7, 7)
        a2 = nonzero(-3, 3)
        b2 = nonzero(-7, 7)
        
        # P(x) = a1*x² + b1, Q(x) = a2*x² + b2
        # Find value k such that P(Q(x)) - Q(P(x)) = k for all x
        
        p_expr = a1*x^2 + b1
        q_expr = a2*x^2 + b2
        
        p_of_q = substitute(p_expr, x => q_expr)
        q_of_p = substitute(q_expr, x => p_expr)
        
        diff_expr = expand(p_of_q - q_of_p)
        
        # Extract constant term (coefficient of x^0)
        # For this to be constant for all x, all non-constant terms must vanish
        constant_term = substitute(diff_expr, x => 0)
        
        question = "Let P(x) = $(tex(p_expr)) and Q(x) = $(tex(q_expr)). Compute the constant value of P(Q(x)) - Q(P(x)) evaluated at x = 0."
        
        problem(
            question=question,
            answer=constant_term,
            difficulty=(4000, 4500),
            solution=steps(
                sol("P(x)", p_expr),
                sol("Q(x)", q_expr),
                sol("P(Q(x))", p_of_q),
                sol("Q(P(x))", q_of_p),
                sol("P(Q(x)) - Q(P(x))", diff_expr),
                sol("Evaluate at x = 0", constant_term)
            ),
            time=280
        )
    end
end