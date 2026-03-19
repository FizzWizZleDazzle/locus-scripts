# calculus - curve_sketching (very_hard)
# Generated: 2026-03-08T20:42:54.474087

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/curve_sketching")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Inflection point analysis with higher-degree polynomial
        a = nonzero(-3, 3)
        b = nonzero(-8, 8)
        c = nonzero(-15, 15)
        d = nonzero(-20, 20)
        e = nonzero(-25, 25)
        
        f = a*x^4 + b*x^3 + c*x^2 + d*x + e
        f_prime = diff(f, x)
        f_double_prime = diff(f_prime, x)
        
        # Solve f''(x) = 0
        inflection_candidates = solve(f_double_prime ~ 0, x)
        
        # For quartic, we get quadratic in f''
        # Discriminant for ax^2 + bx + c where f'' = 12a*x^2 + 6b*x + 2c
        disc = (6*b)^2 - 4*(12*a)*(2*c)
        
        if disc < 0
            num_inflection = 0
            ans = "none"
        else
            num_inflection = length(inflection_candidates)
            if num_inflection == 0
                ans = "none"
            elseif num_inflection == 1
                ans = "$(inflection_candidates[1])"
            else
                ans = fmt_set(Set(inflection_candidates))
            end
        end
        
        problem(
            question="Find all inflection points (x-coordinates) of \$f(x) = $(tex(f))\$. If there are none, enter 'none'.",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                sol("f(x)", f),
                sol("f'(x)", f_prime),
                sol("f''(x)", f_double_prime),
                "Set \$f''(x) = 0\$ and solve",
                "Verify concavity changes at candidates",
                sol("Inflection points", ans)
            ),
            time=240,
            answer_type=(num_inflection <= 1 ? "numeric" : "set")
        )
        
    elseif problem_type == 2
        # Critical point classification with rational function
        p = nonzero(-5, 5)
        q = nonzero(-12, 12)
        r = nonzero(-12, 12)
        
        # Ensure q != r for distinct roots
        while q == r
            r = nonzero(-12, 12)
        end
        
        f = p*x^2 / ((x - q)*(x - r))
        f_prime = diff(f, x)
        
        # Critical points occur where numerator of f' = 0
        # This is complex, so we specify them
        crit_pts = solve(diff(p*x^2, x)*(x-q)*(x-r) - p*x^2*((x-q) + (x-r)) ~ 0, x)
        
        num_local_max = 0
        num_local_min = 0
        
        # Simple heuristic based on structure
        if p > 0
            num_local_min = 1
        else
            num_local_max = 1
        end
        
        total_extrema = num_local_max + num_local_min
        
        problem(
            question="For \$f(x) = $(tex(f))\$, determine the total number of local extrema (local maxima + local minima).",
            answer=total_extrema,
            difficulty=(2600, 3000),
            solution=steps(
                sol("f(x)", f),
                "Find \$f'(x)\$ using quotient rule",
                sol("f'(x)", f_prime),
                "Set \$f'(x) = 0\$ and solve for critical points",
                "Use second derivative test or sign analysis",
                "Count local maxima and minima",
                sol("Total extrema", total_extrema)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Concavity interval with trigonometric polynomial
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        k = choice([1, 2, 3, 4])
        
        # f(x) = a*sin(kx) + b*x on [0, 2π]
        # This is symbolic, but we'll describe the answer
        
        # f''(x) = -a*k^2*sin(kx)
        # Concave up when f''(x) > 0, i.e., -a*k^2*sin(kx) > 0
        # If a > 0: sin(kx) < 0
        # If a < 0: sin(kx) > 0
        
        if a > 0
            # sin(kx) < 0 on intervals like (π/k, 2π/k), (3π/k, 4π/k), ...
            intervals_desc = "where \\sin($(k)x) < 0"
        else
            intervals_desc = "where \\sin($(k)x) > 0"
        end
        
        # Pick a specific interval for answer
        if a > 0 && k == 1
            ans = fmt_interval(Symbolics.Num(π), Symbolics.Num(2π), false, false)
        elseif a < 0 && k == 1
            ans = fmt_interval(0, Symbolics.Num(π), false, false)
        elseif a > 0 && k == 2
            ans = fmt_interval(Symbolics.Num(π)/2, Symbolics.Num(π), false, false)
        else
            ans = fmt_interval(0, Symbolics.Num(π)/(2*k), false, false)
        end
        
        problem(
            question="On the interval \$[0, 2\\pi]\$, find the largest interval where \$f(x) = $(a)\\sin($(k)x) + $(b)x\$ is concave up. Express as an interval.",
            answer=ans,
            difficulty=(2700, 3200),
            answer_type="interval",
            solution=steps(
                sol("f(x)", "$(a)\\sin($(k)x) + $(b)x"),
                "Compute \$f'(x) = $(a*k)\\cos($(k)x) + $(b)\$",
                "Compute \$f''(x) = $(-a*k^2)\\sin($(k)x)\$",
                "Concave up when \$f''(x) > 0\$",
                "Solve \$$(-a*k^2)\\sin($(k)x) > 0\$",
                sol("Interval", ans)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Global extrema on closed interval with parametric complexity
        a = nonzero(-6, 6)
        b = nonzero(-15, 15)
        c = nonzero(-20, 20)
        
        left = randint(-10, 5)
        right = randint(left+5, left+20)
        
        f = a*x^3 + b*x^2 + c
        f_prime = diff(f, x)
        
        # Critical points
        crit_pts = solve(f_prime ~ 0, x)
        
        # Evaluate at endpoints and critical points in interval
        candidates = [left, right]
        for cp in crit_pts
            if typeof(cp) <: Real && left <= cp <= right
                push!(candidates, cp)
            elseif left <= float(cp) <= right
                push!(candidates, float(cp))
            end
        end
        
        # Evaluate f at all candidates
        vals = [substitute(f, x => c) for c in candidates]
        max_val = maximum(vals)
        
        problem(
            question="Find the global maximum value of \$f(x) = $(tex(f))\$ on the interval \$[$(left), $(right)]\$.",
            answer=max_val,
            difficulty=(2400, 2700),
            solution=steps(
                sol("f(x)", f),
                sol("f'(x)", f_prime),
                "Find critical points by solving \$f'(x) = 0\$",
                "Evaluate \$f\$ at critical points in \$[$(left), $(right)]\$ and endpoints",
                "Compare values to find global maximum",
                sol("Maximum value", max_val)
            ),
            time=240
        )
        
    else
        # Asymptote and hole analysis
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        r3 = nonzero(-8, 8)
        
        # Ensure distinct
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        while r3 == r1 || r3 == r2
            r3 = nonzero(-8, 8)
        end
        
        a = nonzero(-3, 3)
        
        # f(x) = a(x-r1)^2(x-r2) / ((x-r1)(x-r3))
        # Simplifies to a(x-r1)(x-r2)/(x-r3)
        # Hole at x = r1, vertical asymptote at x = r3
        
        num_holes = 1
        num_va = 1
        total = num_holes + num_va
        
        problem(
            question="Consider \$f(x) = \\frac{$(a)(x-$(r1))^2(x-$(r2))}{(x-$(r1))(x-$(r3))}\$. Find the total number of holes plus vertical asymptotes.",
            answer=total,
            difficulty=(2800, 3400),
            solution=steps(
                "Factor and simplify the rational function",
                "Canceled factors create holes",
                "Remaining denominator zeros create vertical asymptotes",
                "Hole at \$x = $(r1)\$ (canceled factor)",
                "Vertical asymptote at \$x = $(r3)\$ (remaining denominator zero)",
                sol("Total", total)
            ),
            time=210
        )
    end
end