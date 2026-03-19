# algebra2 - logarithmic_equations (competition)
# Generated: 2026-03-08T20:21:52.035108

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/logarithmic_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Nested logarithmic equation with change of base
        # Target ELO: 3500-4000
        base1 = choice([2, 3, 5, 7])
        base2 = choice(filter(b -> b != base1, [2, 3, 5, 7, 11]))
        
        # Find k such that log_{base1}(log_{base2}(base1^k)) = integer
        exponent = randint(3, 8)
        inner_val = base2^exponent
        outer_arg = base1^(inner_val)
        
        ans = inner_val
        
        question = "Solve for \\(x\\): \\[\\log_{$base1}\\left(\\log_{$base2}\\left($base1^x\\right)\\right) = $exponent\\]"
        
        solution = steps(
            "Let \\(u = \\log_{$base2}($base1^x)\\)",
            "Then \\(\\log_{$base1}(u) = $exponent\\), so \\(u = $base1^{$exponent} = $(base1^exponent)\\)",
            "Now solve \\(\\log_{$base2}($base1^x) = $(base1^exponent)\\)",
            "This gives \\($base2^{$(base1^exponent)} = $base1^x\\)",
            "Taking \\(\\log_{$base1}\\) of both sides: \\(x\\log_{$base1}($base2) = $(base1^exponent)\\log_{$base1}($base2)\\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3500, 3900),
            solution=solution,
            time=300
        )
        
    elseif problem_type == 2
        # Functional equation with logarithms
        # Target ELO: 3800-4300
        a = nonzero(2, 7)
        b = randint(2, 5)
        
        # Design so that f(x) = log_a(x) + b satisfies a functional equation
        # f(a^n) + f(a^m) = log_a(a^n) + b + log_a(a^m) + b = n + m + 2b
        
        n = randint(3, 8)
        m = randint(3, 8)
        
        ans = n + m + 2*b
        
        question = "Let \\(f(x) = \\log_{$a}(x) + $b\\). Find \\(f($a^{$n}) + f($a^{$m})\\)."
        
        solution = steps(
            sol("Given", "f(x) = \\log_{$a}(x) + $b"),
            "Compute \\(f($a^{$n}) = \\log_{$a}($a^{$n}) + $b = $n + $b\\)",
            "Compute \\(f($a^{$m}) = \\log_{$a}($a^{$m}) + $b = $m + $b\\)",
            "Therefore \\(f($a^{$n}) + f($a^{$m}) = ($n + $b) + ($m + $b) = $(n + m + 2*b)\\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3800, 4300),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 3
        # Exponential-logarithmic Diophantine-style equation
        # Target ELO: 4000-4600
        base = choice([2, 3, 5])
        
        # Solve x^(log_base(x)) = base^k for positive integer x
        k = randint(6, 20)
        
        # If x = base^m, then (base^m)^(log_base(base^m)) = base^(m*m) = base^k
        # So m^2 = k, meaning k must be a perfect square
        k = choice([9, 16, 25, 36, 49, 64])
        m = Int(sqrt(k))
        
        ans = base^m
        
        question = "Find the positive integer \\(x\\) such that \\[x^{\\log_{$base}(x)} = $base^{$k}\\]"
        
        solution = steps(
            "Let \\(x = $base^m\\) for some positive integer \\(m\\)",
            "Then \\(\\log_{$base}(x) = \\log_{$base}($base^m) = m\\)",
            "The equation becomes \\(($base^m)^m = $base^{$k}\\)",
            "Simplifying: \\($base^{m^2} = $base^{$k}\\)",
            "Therefore \\(m^2 = $k\\), so \\(m = $(m)\\)",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(4000, 4600),
            solution=solution,
            time=360
        )
        
    elseif problem_type == 4
        # System of logarithmic equations with substitution
        # Target ELO: 3700-4200
        
        # Design: log_a(x) + log_a(y) = p, log_a(x) - log_a(y) = q
        # Then log_a(x) = (p+q)/2, log_a(y) = (p-q)/2
        
        a = choice([2, 3, 5])
        p = randint(4, 10)
        q = randint(2, p-2)
        
        if (p + q) % 2 == 0 && (p - q) % 2 == 0
            logx_val = (p + q) ÷ 2
            logy_val = (p - q) ÷ 2
            
            x_ans = a^logx_val
            y_ans = a^logy_val
            
            ans = x_ans + y_ans
            
            question = "Given the system of equations:\\[\\log_{$a}(x) + \\log_{$a}(y) = $p\\]\\[\\log_{$a}(x) - \\log_{$a}(y) = $q\\]Find \\(x + y\\) where \\(x, y > 0\\)."
            
            solution = steps(
                "Add the two equations: \\(2\\log_{$a}(x) = $(p + q)\\), so \\(\\log_{$a}(x) = $(logx_val)\\)",
                "Therefore \\(x = $a^{$(logx_val)} = $(x_ans)\\)",
                "Subtract the equations: \\(2\\log_{$a}(y) = $(p - q)\\), so \\(\\log_{$a}(y) = $(logy_val)\\)",
                "Therefore \\(y = $a^{$(logy_val)} = $(y_ans)\\)",
                sol("Answer", ans)
            )
            
            problem(
                question=question,
                answer=ans,
                difficulty=(3700, 4200),
                solution=solution,
                time=300
            )
        else
            # Fallback to simpler version
            p = 6
            q = 4
            logx_val = 5
            logy_val = 1
            x_ans = a^5
            y_ans = a
            ans = x_ans + y_ans
            
            question = "Given the system:\\[\\log_{$a}(x) + \\log_{$a}(y) = 6\\]\\[\\log_{$a}(x) - \\log_{$a}(y) = 4\\]Find \\(x + y\\)."
            
            solution = steps(
                "Add: \\(2\\log_{$a}(x) = 10\\), so \\(x = $a^5 = $(x_ans)\\)",
                "Subtract: \\(2\\log_{$a}(y) = 2\\), so \\(y = $a^1 = $(y_ans)\\)",
                sol("Answer", ans)
            )
            
            problem(
                question=question,
                answer=ans,
                difficulty=(3700, 4200),
                solution=solution,
                time=300
            )
        end
        
    else  # problem_type == 5
        # Logarithmic inequality with multiple cases
        # Target ELO: 4200-4800
        
        base = choice([2, 3, 4, 5])
        k = randint(2, 6)
        
        # Solve log_base(x^2 - ax + b) > k
        # Choose a, b so that x^2 - ax + b has nice factorization
        r1 = randint(1, 8)
        r2 = randint(r1 + 4, r1 + 12)
        a_coef = r1 + r2
        b_coef = r1 * r2
        
        threshold = base^k
        
        # x^2 - ax + b = (x - r1)(x - r2)
        # Need (x - r1)(x - r2) > base^k
        # This is satisfied when x < r1 - sqrt(r1^2 - b + threshold) or x > r2 + ...
        # For simplicity, we'll compute exact bounds
        
        # (x - r1)(x - r2) > threshold
        # x^2 - (r1+r2)x + r1*r2 - threshold > 0
        
        discriminant = (r1 + r2)^2 - 4*(r1*r2 - threshold)
        
        if discriminant > 0
            sqrt_disc = sqrt(discriminant)
            x1 = ((r1 + r2) - sqrt_disc) / 2
            x2 = ((r1 + r2) + sqrt_disc) / 2
            
            # Also need x^2 - ax + b > 0 for log to be defined
            # (x-r1)(x-r2) > 0 means x < r1 or x > r2
            
            ans = "(-\\infty, $(r1)) \\cup ($(r2), \\infty)"
            
            question = "Solve the inequality:\\[\\log_{$base}(x^2 - $(a_coef)x + $(b_coef)) > $k\\]Give your answer in interval notation."
            
            solution = steps(
                "The inequality requires \\(x^2 - $(a_coef)x + $(b_coef) > $base^{$k} = $threshold\\)",
                "Also need \\(x^2 - $(a_coef)x + $(b_coef) > 0\\) for the logarithm to be defined",
                "Factor: \\((x - $(r1))(x - $(r2)) > 0\\) gives \\(x < $(r1)\\) or \\(x > $(r2)\\)",
                "Combining both conditions yields the solution",
                sol("Answer", ans)
            )
            
            problem(
                question=question,
                answer=ans,
                difficulty=(4200, 4800),
                answer_type="interval",
                solution=solution,
                time=360
            )
        else
            # Simpler fallback
            ans = fmt_interval(5, Inf, false, true)
            
            question = "Solve \\(\\log_2(x - 3) > 1\\)"
            
            solution = steps(
                "Exponential form: \\(x - 3 > 2^1 = 2\\)",
                "Therefore \\(x > 5\\)",
                sol("Answer", ans)
            )
            
            problem(
                question=question,
                answer=ans,
                difficulty=(3500, 3800),
                answer_type="interval",
                solution=solution,
                time=180
            )
        end
    end
end