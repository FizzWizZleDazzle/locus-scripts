# algebra1 - linear_inequalities (very_hard)
# Generated: 2026-03-08T19:54:38.708572

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/linear_inequalities")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition: System of inequalities with absolute values and parameters
        # ELO 2500-2800
        a = nonzero(-5, 5)
        b = randint(10, 30)
        c = nonzero(2, 8)
        k = randint(5, 15)
        
        # Find all integer x such that |ax + b| < c*k and x^2 < b^2
        bound1 = (-c*k - b) / a
        bound2 = (c*k - b) / a
        lower_abs = min(bound1, bound2)
        upper_abs = max(bound1, bound2)
        
        lower_sq = -abs(b)
        upper_sq = abs(b)
        
        final_lower = max(lower_abs, lower_sq)
        final_upper = min(upper_abs, upper_sq)
        
        # Count integers in the intersection
        int_lower = ceil(Int, final_lower)
        int_upper = floor(Int, final_upper)
        count = max(0, int_upper - int_lower + 1)
        
        problem(
            question="How many integers \\(x\\) satisfy both \\(|$(a)x + $(b)| < $(c*k)\\) and \\(x^2 < $(b^2)\\)?",
            answer=count,
            difficulty=(2500, 2800),
            solution=steps(
                "Solve \\(|$(a)x + $(b)| < $(c*k)\\): \$$(tex(a))x + $(b) \\in (-$(c*k), $(c*k))\$",
                "This gives \$x \\in ($(round(lower_abs, digits=2)), $(round(upper_abs, digits=2)))\$",
                "Solve \\(x^2 < $(b^2)\\): \$x \\in (-$(abs(b)), $(abs(b)))\$",
                "Intersection: \$x \\in ($(round(final_lower, digits=2)), $(round(final_upper, digits=2)))\$",
                sol("Integer count", count)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad: Inequality with nested absolute values
        # ELO 3000-3300
        a = nonzero(2, 6)
        b = randint(8, 20)
        c = nonzero(3, 7)
        d = randint(5, 15)
        
        # ||ax - b| - c| <= d
        # Inner: |ax - b| in [c - d, c + d] (considering c - d could be negative)
        if c - d >= 0
            # |ax - b| in [c-d, c+d]
            # ax - b in [-(c+d), -(c-d)] U [c-d, c+d]
            left1 = (-(c+d) + b) / a
            right1 = (-(c-d) + b) / a
            left2 = (c-d + b) / a
            right2 = (c+d + b) / a
            
            if a > 0
                interval1_l = left1
                interval1_r = right1
                interval2_l = left2
                interval2_r = right2
            else
                interval1_l = right1
                interval1_r = left1
                interval2_l = right2
                interval2_r = left2
            end
            
            ans = fmt_interval(interval1_l, interval1_r, true, true) + " \\cup " + fmt_interval(interval2_l, interval2_r, true, true)
        else
            # |ax - b| <= c + d
            bound1 = (-(c+d) + b) / a
            bound2 = (c+d + b) / a
            lower = min(bound1, bound2)
            upper = max(bound1, bound2)
            ans = fmt_interval(lower, upper, true, true)
        end
        
        problem(
            question="Solve the inequality \\(||$(a)x - $(b)| - $(c)| \\leq $(d)\\)",
            answer=ans,
            difficulty=(3000, 3300),
            answer_type="interval",
            solution=steps(
                sol("Given", "||$(a)x - $(b)| - $(c)| \\leq $(d)"),
                "Remove outer absolute value: \$|$(a)x - $(b)| - $(c) \\in [-$(d), $(d)]\$",
                "So \$|$(a)x - $(b)| \\in [$(max(0, c-d)), $(c+d)]\$",
                "Solve each case and find union of intervals",
                "Final answer: \$" * ans * "\$"
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Competition: Parametric inequality optimization
        # ELO 2600-3000
        a = nonzero(2, 5)
        b = randint(3, 10)
        c = randint(10, 30)
        
        # Find largest integer k such that ax + b > k has at least c integer solutions in [0, 100]
        # ax + b > k means x > (k - b)/a
        # For at least c integers in [0, 100], we need (k - b)/a <= 100 - c + 1
        # So k <= a*(101 - c) + b
        
        max_k = floor(Int, a * (101 - c) + b)
        
        problem(
            question="Find the largest integer \\(k\\) such that the inequality \\($(a)x + $(b) > k\\) has at least $(c) integer solutions in the interval \\([0, 100]\\).",
            answer=max_k,
            difficulty=(2600, 3000),
            solution=steps(
                "Rewrite: \$x > \\frac{k - $(b)}{$(a)}\$",
                "For at least $(c) integers in [0, 100], need \$\\frac{k - $(b)}{$(a)} \\leq $(101 - c)\$",
                "So \$k \\leq $(a) \\cdot $(101 - c) + $(b) = $(a * (101 - c) + b)\$",
                sol("Maximum k", max_k)
            ),
            time=270
        )
        
    else
        # Olympiad: Diophantine-style inequality
        # ELO 3200-3500
        a = choice([2, 3, 5])
        b = choice([3, 4, 5, 7])
        c = randint(20, 50)
        
        # Find number of ordered pairs (x, y) of positive integers such that ax + by < c
        count = 0
        pairs = []
        for xi in 1:c÷a
            for yi in 1:c÷b
                if a*xi + b*yi < c
                    count += 1
                    if length(pairs) < 5
                        push!(pairs, (xi, yi))
                    end
                end
            end
        end
        
        problem(
            question="How many ordered pairs \\((x, y)\\) of positive integers satisfy \\($(a)x + $(b)y < $(c)\\)?",
            answer=count,
            difficulty=(3200, 3500),
            solution=steps(
                "For each positive integer \\(x\\), find how many positive \\(y\\) work",
                "Need \$y < \\frac{$(c) - $(a)x}{$(b)}\$",
                "For \\(x = 1, 2, \\ldots, $(floor(Int, (c-1)/a))\\), count valid \\(y\\) values",
                "Sum over all valid \\(x\\): total = $(count)",
                sol("Answer", count)
            ),
            time=300
        )
    end
end