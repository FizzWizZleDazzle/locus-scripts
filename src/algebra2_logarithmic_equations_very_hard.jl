# algebra2 - logarithmic_equations (very_hard)
# Generated: 2026-03-08T20:21:45.372018

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/logarithmic_equations")
    
    prob_type = rand(1:6)
    
    if prob_type == 1
        # Competition: Product-to-sum logarithm with change of base
        # ELO 2500-2800
        base = choice([2, 3, 5, 7])
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(3, 15)
        
        # Construct: log_base(a*x) + log_base(b*x) = c
        # Solution: log_base(ab*x^2) = c => ab*x^2 = base^c
        ans = sqrt(base^c // (a*b))
        
        problem(
            question="Solve for \\(x\\): \\[\\log_{$base}($a x) + \\log_{$base}($b x) = $c\\]",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                "Use logarithm product rule: \\(\\log_b(m) + \\log_b(n) = \\log_b(mn)\\)",
                sol("\\log_{$base}($(a*b) x^2) = $c"),
                "Convert to exponential form: \\($(a*b) x^2 = $base^{$c}\\)",
                "Solve: \\(x^2 = \\frac{$(base^c)}{$(a*b)}\\)",
                sol("x = \\sqrt{\\frac{$(base^c)}{$(a*b)}}", simplify(ans))
            ),
            time=240
        )
        
    elseif prob_type == 2
        # Competition: Exponential equation requiring logarithm substitution
        # ELO 2600-3000
        a = randint(2, 5)
        b = randint(2, 6)
        c = randint(3, 12)
        
        # Construct: a^(2x) - b*a^x - c = 0
        # Let u = a^x, then u^2 - b*u - c = 0
        discriminant = b^2 + 4*c
        u_sol = (b + sqrt(discriminant)) // 2
        ans = log(a, u_sol)
        
        problem(
            question="Solve for \\(x\\): \\[$a^{2x} - $b \\cdot $a^x - $c = 0\\]",
            answer=ans,
            difficulty=(2600, 3000),
            solution=steps(
                "Let \\(u = $a^x\\), then \\($a^{2x} = u^2\\)",
                sol("u^2 - $b u - $c = 0"),
                "Apply quadratic formula: \\(u = \\frac{$b \\pm \\sqrt{$(b^2) + $(4*c)}}{2}\\)",
                "Since \\(u = $a^x > 0\\), take positive root: \\(u = \\frac{$b + \\sqrt{$(discriminant)}}{2}\\)",
                "Then \\($a^x = $(u_sol)\\)",
                sol("x = \\log_{$a}($(u_sol))", ans)
            ),
            time=300
        )
        
    elseif prob_type == 3
        # Olympiad: System with logarithms and exponentials
        # ELO 3000-3400
        base1 = choice([2, 3, 5])
        base2 = choice([2, 3, 5, 7])
        while base2 == base1
            base2 = choice([2, 3, 5, 7])
        end
        
        m = randint(2, 6)
        n = randint(2, 6)
        
        # Construct: log_base1(x) + log_base2(y) = m, x*y = base1^n * base2^n
        # Solution involves change of base and substitution
        ans_x = base1^(m//2 + n//2)
        ans_y = base2^(n - m*log(base2, base1)//2)
        
        problem(
            question="Find \\(x\\) if \\(\\log_{$base1}(x) + \\log_{$base2}(y) = $m\\) and \\(xy = $(base1^n * base2^n)\\), where \\(x, y > 0\\).",
            answer=ans_x,
            difficulty=(3000, 3400),
            solution=steps(
                "Let \\(a = \\log_{$base1}(x)\\) and \\(b = \\log_{$base2}(y)\\)",
                "Then \\(x = $base1^a\\) and \\(y = $base2^b\\) with \\(a + b = $m\\)",
                "From \\(xy = $(base1^n * base2^n)\\): \\($base1^a \\cdot $base2^b = $base1^{$n} \\cdot $base2^{$n}\\)",
                "Taking \\(\\log_{$base1}\\) of both sides and using change of base formula",
                "Solve the system to obtain \\(a = $(m//2 + n//2)\\)",
                sol("x = $base1^{$(m//2 + n//2)}", ans_x)
            ),
            time=300
        )
        
    elseif prob_type == 4
        # Competition: Nested logarithm equation
        # ELO 2700-3100
        base = choice([2, 3, 5])
        k = randint(2, 5)
        m = randint(2, 8)
        
        # Construct: log_base(log_base(x)) = k, then solve for specific value
        # Solution: log_base(x) = base^k, so x = base^(base^k)
        inner = base^k
        ans = base^inner
        
        problem(
            question="Solve for \\(x\\): \\[\\log_{$base}\\left(\\log_{$base}(x)\\right) = $k\\]",
            answer=ans,
            difficulty=(2700, 3100),
            solution=steps(
                "Let \\(u = \\log_{$base}(x)\\)",
                sol("\\log_{$base}(u) = $k"),
                "Convert to exponential form: \\(u = $base^{$k} = $inner\\)",
                "So \\(\\log_{$base}(x) = $inner\\)",
                "Convert again: \\(x = $base^{$inner}\\)",
                sol("x = $base^{$inner}", ans)
            ),
            time=240
        )
        
    elseif prob_type == 5
        # Olympiad: Functional equation with logarithms
        # ELO 3200-3600
        a = randint(2, 5)
        b = randint(2, 6)
        c = randint(3, 9)
        
        # Construct: log(x) + log(x+a) = log(b*x + c)
        # Leads to quadratic: x^2 + a*x = b*x + c
        # x^2 + (a-b)*x - c = 0
        discriminant = (a-b)^2 + 4*c
        ans = (-(a-b) + sqrt(discriminant)) // 2
        
        problem(
            question="Solve for \\(x > 0\\): \\[\\log(x) + \\log(x+$a) = \\log($b x + $c)\\]",
            answer=ans,
            difficulty=(3200, 3600),
            solution=steps(
                "Use \\(\\log(m) + \\log(n) = \\log(mn)\\)",
                sol("\\log(x(x+$a)) = \\log($b x + $c)"),
                "Since logarithm is one-to-one: \\(x(x+$a) = $b x + $c\\)",
                sol("x^2 + $(a-b)x - $c = 0"),
                "Apply quadratic formula, taking positive root for \\(x > 0\\)",
                sol("x = \\frac{$(b-a) + \\sqrt{$(discriminant)}}{2}", ans)
            ),
            time=300
        )
        
    else
        # Olympiad: Logarithmic inequality with absolute values
        # ELO 3100-3500
        base = choice([2, 3, 5])
        k = randint(2, 6)
        shift = randint(1, 8)
        
        # Construct: |log_base(x - shift)| < k
        # Solution: -k < log_base(x - shift) < k
        # base^(-k) < x - shift < base^k
        left_bound = shift + base^(-k)
        right_bound = shift + base^k
        ans = fmt_interval(left_bound, right_bound, false, false)
        
        problem(
            question="Solve for \\(x\\): \\[\\left|\\log_{$base}(x - $shift)\\right| < $k\\]",
            answer=ans,
            answer_type="interval",
            difficulty=(3100, 3500),
            solution=steps(
                "Remove absolute value: \\(-$k < \\log_{$base}(x - $shift) < $k\\)",
                "Convert to exponential form: \\($base^{-$k} < x - $shift < $base^{$k}\\)",
                "Add $shift to all parts",
                "\\($(shift) + $base^{-$k} < x < $(shift) + $base^{$k}\\)",
                sol("x \\in ($(left_bound), $(right_bound))")
            ),
            time=270
        )
    end
end