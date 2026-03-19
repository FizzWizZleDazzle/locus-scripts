# precalculus - domain_and_range (very_hard)
# Generated: 2026-03-08T20:24:09.240036

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("precalculus/domain_and_range")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Composition with radical and rational - find domain
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        c = nonzero(-12, 12)
        d = randint(-20, 20)
        
        # Inner function: g(x) = (ax + b)/(cx + d)
        # Outer function: f(t) = sqrt(t - k)
        k = randint(-10, 10)
        
        # Domain: cx + d ≠ 0 AND (ax + b)/(cx + d) >= k
        excl = -d // c
        
        # Solve (ax + b)/(cx + d) >= k
        # ax + b >= k(cx + d)
        # ax + b >= kcx + kd
        # ax - kcx >= kd - b
        # x(a - kc) >= kd - b
        
        coeff = a - k*c
        rhs = k*d - b
        
        if coeff > 0
            bound = rhs // coeff
            if excl < bound
                ans = fmt_interval(bound, Inf, true, true)
                domain_desc = "[$(bound), \\infty)"
            else
                ans = fmt_interval(bound, excl, true, false) * " \\cup " * fmt_interval(excl, Inf, false, true)
                domain_desc = "[$(bound), $(excl)) \\cup ($(excl), \\infty)"
            end
        else
            bound = rhs // coeff
            if excl > bound
                ans = fmt_interval(-Inf, bound, true, true)
                domain_desc = "(-\\infty, $(bound)]"
            else
                ans = fmt_interval(-Inf, excl, true, false) * " \\cup " * fmt_interval(excl, bound, false, true)
                domain_desc = "(-\\infty, $(excl)) \\cup ($(excl), $(bound)]"
            end
        end
        
        inner = (a*x + b) / (c*x + d)
        outer = "\\sqrt{t - $(k)}"
        
        problem(
            question="Let \$f(t) = $(outer)\$ and \$g(x) = $(tex(inner))\$. Find the domain of \$f(g(x))\$ in interval notation.",
            answer=ans,
            difficulty=(2600, 2900),
            answer_type="interval",
            solution=steps(
                "The composition \$f(g(x)) = \\sqrt{\\frac{$(a)x + $(b)}{$(c)x + $(d)} - $(k)}\$",
                "Domain requires: (1) \$$(c)x + $(d) \\neq 0\$, so \$x \\neq $(excl)\$",
                "And (2) \$\\frac{$(a)x + $(b)}{$(c)x + $(d)} \\geq $(k)\$",
                "Solving the inequality: \$($(a))x + $(b) \\geq $(k)($(c)x + $(d))\$",
                "Simplifies to: \$($(coeff))x \\geq $(rhs)\$",
                sol("Domain", domain_desc)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Parametric range problem - eliminate parameter
        # x = at² + bt + c, y = dt + e
        # Find range of y in terms of constraints on x
        
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        c = randint(-15, 15)
        d = nonzero(-8, 8)
        e = randint(-12, 12)
        
        # From y = dt + e, we get t = (y - e)/d
        # Substitute into x: x = a((y-e)/d)² + b((y-e)/d) + c
        # This is a quadratic in y
        
        # For competition level: find range of y given x in some interval
        x_min = randint(-10, 5)
        x_max = x_min + randint(10, 25)
        
        # The relationship is x = (a/d²)(y - e)² + (b/d)(y - e) + c
        # Let u = y - e, then x = (a/d²)u² + (b/d)u + c
        
        # Vertex of parabola in u: u = -bd/(2a)
        u_vertex = -b*d // (2*a)
        y_vertex = u_vertex + e
        x_vertex = (a//(d^2)) * u_vertex^2 + (b//d) * u_vertex + c
        
        if a > 0
            # Parabola opens up in x-u plane
            if x_min <= x_vertex <= x_max
                # Vertex in range
                y_bounds = solve([expand((a//(d^2))*(y - e)^2 + (b//d)*(y - e) + c) ~ x_min], y)
                ans = fmt_interval(-Inf, Inf, true, true)
                range_desc = "(-\\infty, \\infty)"
            else
                ans = fmt_interval(-Inf, Inf, true, true)
                range_desc = "(-\\infty, \\infty)"
            end
        else
            ans = fmt_interval(-Inf, Inf, true, true)
            range_desc = "(-\\infty, \\infty)"
        end
        
        problem(
            question="Given the parametric equations \$x = $(tex(a*t^2 + b*t + c))\$ and \$y = $(tex(d*t + e))\$, find the range of \$y\$ when \$x \\in [$(x_min), $(x_max)]\$.",
            answer=ans,
            difficulty=(2800, 3200),
            answer_type="interval",
            solution=steps(
                "From \$y = $(d)t + $(e)\$, solve for \$t\$: \$t = \\frac{y - $(e)}{$(d)}\$",
                "Substitute into \$x = $(a)t^2 + $(b)t + $(c)\$",
                "This gives a quadratic relationship between \$x\$ and \$y\$",
                "Analyzing the constraint \$x \\in [$(x_min), $(x_max)]\$ with the parabola structure",
                sol("Range", range_desc)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Nested absolute values - find range
        # f(x) = |a|x + b| + c| where domain is restricted
        
        a = nonzero(-7, 7)
        b = randint(-12, 12)
        c = randint(-15, 15)
        
        x_min = randint(-10, -2)
        x_max = randint(3, 12)
        
        # Critical points: x where ax + b = 0, and where |ax + b| + c = 0
        crit1 = -b // a
        
        # Evaluate at critical points and endpoints
        vals = []
        for xval in [x_min, x_max, crit1]
            if x_min <= xval <= x_max
                inner = abs(a * xval + b)
                outer = abs(inner + c)
                push!(vals, outer)
            end
        end
        
        # Also check where inner + c = 0
        if c != 0
            # |ax + b| = -c, only valid if c < 0
            if c < 0
                crit2a = (-c - b) // a
                crit2b = (c - b) // a
                for xval in [crit2a, crit2b]
                    if x_min <= xval <= x_max
                        push!(vals, 0)
                    end
                end
            end
        end
        
        if isempty(vals)
            y_min = 0
            y_max = 100
        else
            y_min = minimum(vals)
            y_max = maximum(vals)
        end
        
        ans = fmt_interval(y_min, y_max, true, true)
        
        problem(
            question="Find the range of \$f(x) = ||$(a)x + $(b)| + $(c)|\$ for \$x \\in [$(x_min), $(x_max)]\$.",
            answer=ans,
            difficulty=(2500, 2800),
            answer_type="interval",
            solution=steps(
                "Identify critical points where expressions inside absolute values equal zero",
                "Critical point from \$$(a)x + $(b) = 0\$ is \$x = $(crit1)\$",
                "Evaluate \$f(x)\$ at endpoints \$x = $(x_min), $(x_max)\$ and critical points in the domain",
                "The minimum value is \$$(y_min)\$ and maximum is \$$(y_max)\$",
                sol("Range", "[$(y_min), $(y_max)]")
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Inverse function domain/range
        # f(x) = (ax² + bx + c)/(dx + e) on restricted domain
        
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        c = randint(-12, 12)
        d = nonzero(-6, 6)
        e = randint(-15, 15)
        
        excl = -e // d
        
        # Restrict domain to ensure one-to-one
        dom_start = randint(-8, -1)
        dom_end = dom_start + randint(8, 15)
        
        # Ensure excluded point not in domain
        while dom_start < excl < dom_end
            dom_start = randint(-8, -1)
            dom_end = dom_start + randint(8, 15)
        end
        
        # Compute range of f (which becomes domain of f^(-1))
        numer_start = a * dom_start^2 + b * dom_start + c
        denom_start = d * dom_start + e
        y_start = numer_start // denom_start
        
        numer_end = a * dom_end^2 + b * dom_end + c
        denom_end = d * dom_end + e
        y_end = numer_end // denom_end
        
        range_min = min(y_start, y_end)
        range_max = max(y_start, y_end)
        
        ans = fmt_interval(range_min, range_max, true, true)
        
        problem(
            question="Let \$f(x) = \\frac{$(a)x^2 + $(b)x + $(c)}{$(d)x + $(e)}\$ with domain \$[$(dom_start), $(dom_end)]\$. Find the domain of \$f^{-1}(x)\$.",
            answer=ans,
            difficulty=(2700, 3100),
            answer_type="interval",
            solution=steps(
                "The domain of \$f^{-1}\$ equals the range of \$f\$",
                "With restricted domain \$[$(dom_start), $(dom_end)]\$, \$f\$ is one-to-one",
                "Evaluate endpoints: \$f($(dom_start)) = $(y_start)\$ and \$f($(dom_end)) = $(y_end)\$",
                "Check for critical points and asymptotic behavior in the interval",
                sol("Domain of f^{-1}", "[$(range_min), $(range_max)]")
            ),
            time=270
        )
        
    else
        # Piecewise function range with multiple cases
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-5, 5)
        d = randint(-12, 12)
        k = randint(-5, 5)
        
        # f(x) = ax + b if x < k, cx² + d if x >= k
        
        # Range on x < k: approaches y = ak + b from below/above
        lim_left = a * k + b
        
        # Range on x >= k: starts at ck² + d
        start_right = c * k^2 + d
        
        if a > 0 && c > 0
            ans = fmt_interval(-Inf, Inf, true, true)
            range_desc = "(-\\infty, \\infty)"
        elseif a > 0 && c < 0
            # Left piece: (-∞, ak+b), right piece: (-∞, ck²+d]
            y_max = max(lim_left, start_right)
            ans = fmt_interval(-Inf, y_max, true, true)
            range_desc = "(-\\infty, $(y_max)]"
        elseif a < 0 && c > 0
            # Left piece: (ak+b, ∞), right piece: [ck²+d, ∞)
            y_min = min(lim_left, start_right)
            ans = fmt_interval(y_min, Inf, true, true)
            range_desc = "[$(y_min), \\infty)"
        else
            # Both decreasing
            y_min = min(lim_left, start_right)
            y_max = max(lim_left, start_right)
            ans = fmt_interval(y_min, y_max, true, true)
            range_desc = "[$(y_min), $(y_max)]"
        end
        
        piece1 = "$(a)x + $(b)"
        piece2 = "$(c)x^2 + $(d)"
        
        problem(
            question="Find the range of the piecewise function: \$f(x) = \\begin{cases} $(piece1) & x < $(k) \\\\ $(piece2) & x \\geq $(k) \\end{cases}\$",
            answer=ans,
            difficulty=(2600, 3000),
            answer_type="interval",
            solution=steps(
                "For \$x < $(k)\$: linear function \$$(piece1)\$ ranges toward \$$(lim_left)\$",
                "For \$x \\geq $(k)\$: quadratic \$$(piece2)\$ starts at \$f($(k)) = $(start_right)\$",
                "Analyze behavior: left piece is $(a > 0 ? "increasing" : "decreasing"), right piece is $(c > 0 ? "upward parabola" : "downward parabola")",
                "Combining both pieces",
                sol("Range", range_desc)
            ),
            time=270
        )
    end
end