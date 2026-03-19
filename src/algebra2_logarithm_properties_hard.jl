# algebra2 - logarithm_properties (hard)
# Generated: 2026-03-08T20:20:34.184957

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/logarithm_properties")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Solve log equation with exponential form (1800-2100)
        base = choice([2, 3, 5, 7])
        exponent = randint(2, 5)
        result = base^exponent
        
        # Add some algebraic complexity
        a = nonzero(-3, 3)
        b = randint(-10, 10)
        ans = (result - b) // a
        
        lhs_expr = a * x + b
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$base}($tex(lhs_expr)) = $exponent\\)",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", "\\log_{$base}($tex(lhs_expr)) = $exponent"),
                "Convert to exponential form: \\($tex(lhs_expr) = $base^{$exponent} = $result\\)",
                sol("Solve", "$tex(a*x) = $(result - b)"),
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Logarithm properties - expand/condense (1900-2200)
        p = nonzero(2, 5)
        q = nonzero(2, 5)
        r = nonzero(2, 5)
        
        base = choice([2, 3, 5, 10])
        
        # Create expression log_b(x^p * y^q / z^r)
        expanded = "$p\\log_{$base}(x) + $q\\log_{$base}(y) - $r\\log_{$base}(z)"
        
        problem(
            question="Write as a single logarithm: \\($expanded\\)",
            answer="\\log_{$base}\\left(\\frac{x^{$p} y^{$q}}{z^{$r}}\\right)",
            difficulty=(1900, 2100),
            grading_mode="symbolic",
            solution=steps(
                sol("Given", expanded),
                "Apply power rule: \\(\\log_b(M^k) = k\\log_b(M)\\)",
                "Apply product rule: \\(\\log_b(M) + \\log_b(N) = \\log_b(MN)\\)",
                "Apply quotient rule: \\(\\log_b(M) - \\log_b(N) = \\log_b(M/N)\\)",
                sol("Answer", "\\log_{$base}\\left(\\frac{x^{$p} y^{$q}}{z^{$r}}\\right)")
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Change of base with algebraic manipulation (2000-2300)
        base1 = choice([2, 3, 5, 7])
        base2 = choice([2, 3, 5, 7])
        while base2 == base1
            base2 = choice([2, 3, 5, 7])
        end
        
        val = randint(2, 4)
        k = nonzero(2, 5)
        
        # Solve k*log_base1(x) = log_base2(x)
        # Answer: x = base1^(log_base2(base1) / (k - log_base2(base1)))
        
        problem(
            question="Solve for \\(x\\): \\($k\\log_{$base1}(x) = \\log_{$base2}(x)\\) (express using logarithms)",
            answer="x = $base1^{\\frac{\\log_{$base2}($base1)}{$k - \\log_{$base2}($base1)}}",
            difficulty=(2100, 2300),
            grading_mode="symbolic",
            solution=steps(
                sol("Given", "$k\\log_{$base1}(x) = \\log_{$base2}(x)"),
                "Convert to natural log using change of base: \\(\\log_b(a) = \\frac{\\ln(a)}{\\ln(b)}\\)",
                sol("Rewrite", "$k\\frac{\\ln(x)}{\\ln($base1)} = \\frac{\\ln(x)}{\\ln($base2)}"),
                "Factor \\(\\ln(x)\\) and solve",
                sol("Answer", "x = $base1^{\\frac{\\log_{$base2}($base1)}{$k - \\log_{$base2}($base1)}}")
            ),
            time=240
        )
        
    elseif problem_type == 4
        # System with logarithmic equations (2000-2400)
        # log(x) + log(y) = a, log(x) - log(y) = b
        a_val = randint(2, 4)
        b_val = nonzero(1, 3)
        
        # Solution: log(x) = (a+b)/2, log(y) = (a-b)/2
        log_x = (a_val + b_val) // 2
        log_y = (a_val - b_val) // 2
        
        x_ans = 10^log_x
        y_ans = 10^log_y
        
        problem(
            question="Solve the system (base 10 logarithms):<br>\\(\\log(x) + \\log(y) = $a_val\\)<br>\\(\\log(x) - \\log(y) = $b_val\\)",
            answer=fmt_tuple((x_ans, y_ans)),
            difficulty=(2000, 2300),
            answer_type="tuple",
            solution=steps(
                "Add equations: \\(2\\log(x) = $(a_val + b_val)\\)",
                sol("First", "\\log(x) = $log_x \\Rightarrow x = 10^{$log_x} = $x_ans"),
                "Subtract equations: \\(2\\log(y) = $(a_val - b_val)\\)",
                sol("Second", "\\log(y) = $log_y \\Rightarrow y = 10^{$log_y} = $y_ans"),
                sol("Answer", fmt_tuple((x_ans, y_ans)))
            ),
            time=210
        )
        
    else
        # Inequality with logarithms (2100-2500)
        base = choice([2, 3, 5])
        a = nonzero(1, 4)
        b = randint(1, 8)
        c = randint(2, 5)
        
        # log_base(ax + b) > c
        # ax + b > base^c
        # x > (base^c - b) / a
        
        bound = (base^c - b) // a
        ans = fmt_interval(bound, Inf, false, true)
        
        problem(
            question="Solve the inequality: \\(\\log_{$base}($a x + $b) > $c\\)",
            answer=ans,
            difficulty=(2100, 2400),
            answer_type="interval",
            solution=steps(
                sol("Given", "\\log_{$base}($a x + $b) > $c"),
                "Note domain restriction: \\($a x + $b > 0\\)",
                "Convert to exponential: \\($a x + $b > $base^{$c} = $(base^c)\\)",
                sol("Solve", "$a x > $(base^c - b)"),
                sol("Answer", "x > $bound")
            ),
            time=180
        )
    end
end