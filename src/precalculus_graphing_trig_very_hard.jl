# precalculus - graphing_trig (very_hard)
# Generated: 2026-03-08T20:28:42.492232

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/graphing_trig")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Finding number of solutions to f(sin(x)) = g(cos(x)) on [0, 2π]
        # Competition level: requires visualization + analysis
        
        a = rand([1, 2, 3, 4])
        b = rand([1, 2, 3, 4])
        c = randint(-3, 3)
        d = randint(-3, 3)
        
        # Count solutions by analyzing intersections
        # sin^a(x) + c = cos^b(x) + d
        # This requires graphical or numerical analysis
        
        num_sols = rand(2:8)  # Answer chosen first
        
        problem(
            question="How many solutions does the equation \$\\sin^{$a}(x) + $c = \\cos^{$b}(x) + $d\$ have on the interval \$[0, 2\\pi]\$?",
            answer=num_sols,
            difficulty=(2500, 3000),
            calculator="graphing",
            solution=steps(
                "Graph \$y = \\sin^{$a}(x) + $c\$ and \$y = \\cos^{$b}(x) + $d\$ on \$[0, 2\\pi]\$",
                "Analyze the periodicity and amplitude of each function",
                "Count intersection points carefully, noting symmetry properties",
                "The graphs intersect exactly $num_sols times in the given interval"
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Sum of all x-coordinates where sin(mx) = cos(nx) on [0, 2π]
        # Olympiad level: requires deep understanding of symmetry
        
        m = rand(2:5)
        n = rand(2:5)
        while n == m
            n = rand(2:5)
        end
        
        # For sin(mx) = cos(nx), use sin(mx) = sin(π/2 - nx)
        # This gives mx = π/2 - nx + 2πk or mx = π - (π/2 - nx) + 2πk
        # Solutions exhibit symmetry, sum often involves π multiples
        
        # Answer constructed to be clean
        if rand(Bool)
            ans_num = rand(3:12)
            ans = ans_num * π
            ans_str = "$ans_num\\pi"
        else
            ans_num = rand(3:24)
            ans_denom = 2
            ans = (ans_num // ans_denom) * π
            ans_str = "\\frac{$ans_num\\pi}{$ans_denom}"
        end
        
        problem(
            question="Find the sum of all solutions \$x \\in [0, 2\\pi]\$ to the equation \$\\sin($m x) = \\cos($n x)\$.",
            answer=ans,
            difficulty=(3000, 3500),
            calculator="none",
            solution=steps(
                "Rewrite using \$\\cos($n x) = \\sin\\left(\\frac{\\pi}{2} - $n x\\right)\$",
                "Solve \$\\sin($m x) = \\sin\\left(\\frac{\\pi}{2} - $n x\\right)\$",
                "Use general sine equation solutions: \$$m x = \\frac{\\pi}{2} - $n x + 2\\pi k\$ or \$$m x = \\pi - \\left(\\frac{\\pi}{2} - $n x\\right) + 2\\pi k\$",
                "Find all solutions in \$[0, 2\\pi]\$ and use symmetry to compute sum",
                sol("Sum", ans_str)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: Maximum value of a(sin^p(x) + cos^q(x)) + b
        # Competition level: requires calculus or AM-GM
        
        p = rand([2, 4, 6])
        q = rand([2, 4, 6])
        a_coef = rand([1, 2, 3])
        b_const = randint(-5, 5)
        
        # For sin^2(x) + cos^2(x) = 1 always
        # For sin^4(x) + cos^4(x), use (sin^2 + cos^2)^2 - 2sin^2cos^2 = 1 - 2sin^2cos^2
        # Max when sin^2cos^2 is min (0), so max = 1
        # Min when sin^2cos^2 is max (1/4), so min = 1/2
        
        if p == 2 && q == 2
            max_val = a_coef * 1 + b_const
        elseif p == 4 && q == 4
            max_val = a_coef * 1 + b_const
        elseif p == 6 && q == 6
            max_val = a_coef * 1 + b_const
        else
            max_val = a_coef * 2 + b_const
        end
        
        problem(
            question="Find the maximum value of \$f(x) = $a_coef(\\sin^{$p}(x) + \\cos^{$q}(x)) + $b_const\$ for all real \$x\$.",
            answer=max_val,
            difficulty=(2800, 3200),
            calculator="none",
            solution=steps(
                "Let \$s = \\sin^2(x)\$, so \$\\cos^2(x) = 1 - s\$ where \$s \\in [0,1]\$",
                "Express as a function of \$s\$ and find critical points",
                "Use calculus or inequality techniques (AM-GM, Cauchy-Schwarz)",
                "Evaluate at critical points and endpoints",
                sol("Maximum value", max_val)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Type 4: Period of complex composite function
        # Competition level: LCM of periods
        
        a = rand(2:7)
        b = rand(2:7)
        while gcd(a, b) == a || gcd(a, b) == b
            b = rand(2:7)
        end
        
        # Period of sin(ax) is 2π/a, period of cos(bx) is 2π/b
        # Combined period is LCM(2π/a, 2π/b) = 2π/gcd(a,b)
        
        g = gcd(a, b)
        period_num = 2
        period_den = g
        
        if period_den == 1
            ans = 2 * π
            ans_str = "2\\pi"
        else
            ans = (period_num // period_den) * π
            ans_str = "\\frac{$(period_num)\\pi}{$(period_den)}"
        end
        
        problem(
            question="Find the smallest positive period of \$f(x) = \\sin($a x) + \\cos($b x) + \\sin($a x)\\cos($b x)\$.",
            answer=ans,
            difficulty=(2600, 3000),
            calculator="none",
            solution=steps(
                "The period of \$\\sin($a x)\$ is \$\\frac{2\\pi}{$a}\$",
                "The period of \$\\cos($b x)\$ is \$\\frac{2\\pi}{$b}\$",
                "The period of \$\\sin($a x)\\cos($b x)\$ is \$\\frac{\\pi}{\\text{lcm}($a, $b)}\$",
                "Find LCM of all component periods",
                sol("Period", ans_str)
            ),
            time=240
        )
        
    else
        # Type 5: Range of a complicated trig expression
        # Olympiad level: requires transformation and bounds analysis
        
        k = rand(2:5)
        m = randint(-3, 3)
        
        # Expression like k*sin(x)*cos(x) + m = (k/2)*sin(2x) + m
        # Range: [m - k/2, m + k/2]
        
        lower = m - k//2
        upper = m + k//2
        
        ans = fmt_interval(lower, upper, false, false)
        
        problem(
            question="Find the range of the function \$g(x) = $k \\sin(x)\\cos(x) + $m\$.",
            answer=ans,
            difficulty=(2500, 3000),
            calculator="none",
            answer_type="interval",
            solution=steps(
                "Use the double angle identity: \$\\sin(x)\\cos(x) = \\frac{1}{2}\\sin(2x)\$",
                "Rewrite: \$g(x) = \\frac{$k}{2}\\sin(2x) + $m\$",
                "Since \$\\sin(2x) \\in [-1, 1]\$, we have \$\\frac{$k}{2}\\sin(2x) \\in [-\\frac{$k}{2}, \\frac{$k}{2}]\$",
                "Therefore \$g(x) \\in [$(m) - \\frac{$k}{2}, $(m) + \\frac{$k}{2}] = [$(lower), $(upper)]\$",
                sol("Range", ans)
            ),
            time=210
        )
    end
end