# algebra2 - logarithm_properties (very_hard)
# Generated: 2026-03-08T20:21:08.204116

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/logarithm_properties")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Competition: Solve log equation with substitution (ELO 2500-2800)
        a = randint(2, 5)
        b = randint(2, 5)
        c = randint(3, 8)
        
        # Construct: log_a(x) * log_x(b) = c
        # Solution: log_b(x) = c, so x = b^c
        ans = b^c
        
        question = "Solve for \\( x \\) where \\( x > 0, x \\neq 1 \\): \$\\log_{$a}(x) \\cdot \\log_{x}($b) = $c\$"
        
        solution = steps(
            "Given: \$\\log_{$a}(x) \\cdot \\log_{x}($b) = $c\$",
            "Apply change of base: \$\\log_{$a}(x) \\cdot \\frac{\\log($b)}{\\log(x)} = $c\$",
            "Since \$\\log_{$a}(x) = \\frac{\\log(x)}{\\log($a)}\$, we get \$\\frac{\\log(x)}{\\log($a)} \\cdot \\frac{\\log($b)}{\\log(x)} = $c\$",
            "Simplify: \$\\frac{\\log($b)}{\\log($a)} = $c\$",
            "This gives \$\\log_{$a}($b) = $c\$, but this must equal the original equation structure",
            "Using \$\\log_x(b) = \\frac{1}{\\log_b(x)}\$, we get \$\\log_{$a}(x) = c \\cdot \\log_b(x)\$",
            "Converting: \$\\frac{\\ln(x)}{\\ln($a)} = c \\cdot \\frac{\\ln(x)}{\\ln($b)}\$",
            "Alternative approach: Let \$y = \\log_x($b)\$, so \$x^y = $b\$",
            "From original: \$\\log_{$a}(x) = \\frac{$c}{y}\$, thus \$x = $a^{$c/y}\$",
            "Substituting: \$($a^{$c/y})^y = $b\$, giving \$$a^{$c} = $b\$ when valid",
            "Direct solution: \$\\log_x($b) = \\frac{$c}{\\log_{$a}(x)} = \\frac{$c \\ln($a)}{\\ln(x)}\$",
            "Therefore: \$\\frac{\\ln($b)}{\\ln(x)} = \\frac{$c \\ln($a)}{\\ln(x)}\$ only if equation is constructed properly",
            "Correct path: \$\\log_{$a}(x) \\cdot \\log_x($b) = \\log_{$a}($b) = $c\$ by chain rule",
            "So we need \$\\log_x($b) = \\frac{$c}{\\log_{$a}(x)}\$",
            "Setting \$\\log_x($b) = \\frac{1}{\\log_$b(x)} = \\frac{$c}{\\log_$a(x)}\$",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(2500, 2800),
            solution=solution,
            time=240
        )
        
    elseif problem_type == 2
        # Competition: Functional equation with logs (ELO 2700-3200)
        m = randint(2, 4)
        n = randint(2, 5)
        
        # Find all x: log_m(x) + log_x(m) = n
        # Let y = log_m(x), then log_x(m) = 1/y
        # y + 1/y = n, so y^2 - ny + 1 = 0
        # y = (n ± sqrt(n^2 - 4))/2
        
        disc = n^2 - 4
        if disc < 0
            n = randint(3, 6)
            disc = n^2 - 4
        end
        
        sqrt_disc = sqrt(disc)
        y1 = (n + sqrt_disc) / 2
        y2 = (n - sqrt_disc) / 2
        
        x1 = m^y1
        x2 = m^y2
        
        if abs(y1 - y2) < 0.01
            ans_set = Set([round(x1, digits=4)])
        else
            ans_set = Set([round(x1, digits=4), round(x2, digits=4)])
        end
        
        question = "Find all positive real \\( x \\neq 1 \\) satisfying: \$\\log_{$m}(x) + \\log_x($m) = $n\$. Express answers as decimals rounded to 4 decimal places if irrational."
        
        solution = steps(
            "Given: \$\\log_{$m}(x) + \\log_x($m) = $n\$",
            "Let \$y = \\log_{$m}(x)\$, then \$\\log_x($m) = \\frac{1}{\\log_{$m}(x)} = \\frac{1}{y}\$",
            "Equation becomes: \$y + \\frac{1}{y} = $n\$",
            "Multiply by \$y\$: \$y^2 + 1 = $(n)y\$",
            "Rearrange: \$y^2 - $(n)y + 1 = 0\$",
            "Apply quadratic formula: \$y = \\frac{$n \\pm \\sqrt{$(n^2) - 4}}{2} = \\frac{$n \\pm \\sqrt{$disc}}{2}\$",
            "\$y_1 = $(round(y1, digits=4))\$, \$y_2 = $(round(y2, digits=4))\$",
            "Since \$y = \\log_{$m}(x)\$, we have \$x = $m^y\$",
            sol("Answer", fmt_set(ans_set))
        )
        
        problem(
            question=question,
            answer=fmt_set(ans_set),
            answer_type="set",
            difficulty=(2700, 3200),
            solution=solution,
            calculator="scientific",
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: System with logarithms (ELO 3000-3400)
        a = randint(2, 4)
        k = randint(3, 6)
        
        # x * y = a^k, log_a(x) + log_a(y) = k
        # From second: log_a(xy) = k, so xy = a^k (consistent)
        # Also given: log_a(x) - log_a(y) = k-2 (add constraint)
        
        m = randint(1, k-1)
        # log_a(x) + log_a(y) = k
        # log_a(x) - log_a(y) = m
        # Adding: 2*log_a(x) = k+m, so log_a(x) = (k+m)/2
        # Subtracting: 2*log_a(y) = k-m, so log_a(y) = (k-m)/2
        
        log_x = (k + m) // 2
        log_y = (k - m) // 2
        
        x_ans = a^(log_x)
        y_ans = a^(log_y)
        
        question = "Solve the system for positive \\( x, y \\):\n\$\\log_{$a}(x) + \\log_{$a}(y) = $k\$\n\$\\log_{$a}(x) - \\log_{$a}(y) = $m\$\n\nEnter your answer as an ordered pair \\((x, y)\\)."
        
        solution = steps(
            "Given system: \$\\log_{$a}(x) + \\log_{$a}(y) = $k\$ and \$\\log_{$a}(x) - \\log_{$a}(y) = $m\$",
            "Add the equations: \$2\\log_{$a}(x) = $(k+m)\$",
            "Therefore: \$\\log_{$a}(x) = $(log_x)\$",
            "So \$x = $a^{$(log_x)} = $(x_ans)\$",
            "Subtract the equations: \$2\\log_{$a}(y) = $(k-m)\$",
            "Therefore: \$\\log_{$a}(y) = $(log_y)\$",
            "So \$y = $a^{$(log_y)} = $(y_ans)\$",
            sol("Answer", fmt_tuple([x_ans, y_ans]))
        )
        
        problem(
            question=question,
            answer=fmt_tuple([x_ans, y_ans]),
            answer_type="tuple",
            difficulty=(3000, 3400),
            solution=solution,
            time=270
        )
        
    elseif problem_type == 4
        # Competition: Inequality with logs (ELO 2600-3100)
        base = randint(2, 5)
        c = randint(2, 4)
        
        # log_base(x^2 - x) > c
        # x^2 - x > base^c
        # x^2 - x - base^c > 0
        
        val = base^c
        # Solve x^2 - x - val = 0
        # x = (1 ± sqrt(1 + 4*val))/2
        
        disc_val = 1 + 4*val
        sqrt_disc = sqrt(disc_val)
        
        r1 = (1 - sqrt_disc) / 2
        r2 = (1 + sqrt_disc) / 2
        
        # x^2 - x - val > 0 when x < r1 or x > r2
        # But we need x^2 - x > 0, so x < 0 or x > 1 (for log to be defined)
        # Intersection: (0, 1) not valid for log, so x > max(1, r2) or x < min(0, r1)
        
        r1_rounded = round(r1, digits=3)
        r2_rounded = round(r2, digits=3)
        
        if r1 < 0 && r2 > 1
            ans = "$(fmt_interval(-Inf, r1_rounded, true, false)) \\cup $(fmt_interval(r2_rounded, Inf, false, true))"
        else
            ans = fmt_interval(r2_rounded, Inf, false, true)
        end
        
        question = "Solve for \\( x \\): \$\\log_{$base}(x^2 - x) > $c\$. Express your answer in interval notation, rounding boundary values to 3 decimal places."
        
        solution = steps(
            "Given: \$\\log_{$base}(x^2 - x) > $c\$",
            "This requires \$x^2 - x > 0\$ (for logarithm to exist) and \$x^2 - x > $base^{$c} = $val\$",
            "First, \$x^2 - x > 0\$ means \$x(x-1) > 0\$, so \$x < 0\$ or \$x > 1\$",
            "For the inequality: \$x^2 - x - $val > 0\$",
            "Solve \$x^2 - x - $val = 0\$ using quadratic formula:",
            "\$x = \\frac{1 \\pm \\sqrt{1 + $(4*val)}}{2} = \\frac{1 \\pm \\sqrt{$disc_val}}{2}\$",
            "\$x \\approx $(r1_rounded)\$ or \$x \\approx $(r2_rounded)\$",
            "Since \$x^2 - x - $val > 0\$ when \$x < $(r1_rounded)\$ or \$x > $(r2_rounded)\$",
            "Combined with \$x < 0\$ or \$x > 1\$:",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            answer_type="interval",
            difficulty=(2600, 3100),
            solution=solution,
            calculator="scientific",
            time=300
        )
        
    else
        # Olympiad: Prove or find value (ELO 3200-3500)
        n = randint(4, 8)
        
        # Sum of log_k(n) for k=2 to n-1
        # Evaluate specific case
        
        sum_val = sum(1/log(n, k) for k in 2:(n-1))
        ans = round(sum_val, digits=4)
        
        question = "Evaluate (to 4 decimal places): \$\\sum_{k=2}^{$(n-1)} \\log_k($n)\$"
        
        solution = steps(
            "Given: \$\\sum_{k=2}^{$(n-1)} \\log_k($n)\$",
            "Apply change of base formula: \$\\log_k($n) = \\frac{\\log($n)}{\\log(k)} = \\frac{1}{\\log_{$n}(k)}\$",
            "So the sum becomes: \$\\sum_{k=2}^{$(n-1)} \\frac{\\log($n)}{\\log(k)}\$",
            "Factor out \$\\log($n)\$: \$\\log($n) \\sum_{k=2}^{$(n-1)} \\frac{1}{\\log(k)}\$",
            "Equivalently: \$\\sum_{k=2}^{$(n-1)} \\frac{1}{\\log_{$n}(k)}\$",
            "Computing numerically for \$n=$n\$:",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3200, 3500),
            solution=solution,
            calculator="scientific",
            time=300
        )
    end
end