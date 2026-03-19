# precalculus - domain_and_range (hard)
# Generated: 2026-03-08T20:23:48.540079

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/domain_and_range")
    
    prob_type = rand(1:6)
    
    if prob_type == 1
        # Rational function with multiple restrictions
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        while r2 == r1
            r2 = randint(-8, 8)
        end
        if r1 > r2
            r1, r2 = r2, r1
        end
        
        denom = expand((x - r1) * (x - r2))
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        num = a*x + b
        
        func = num / denom
        
        domain_parts = []
        if r1 == r2 - 1
            push!(domain_parts, fmt_interval(-Inf, r1, true, false))
            push!(domain_parts, fmt_interval(r1, r2, false, false))
            push!(domain_parts, fmt_interval(r2, Inf, false, true))
        else
            push!(domain_parts, fmt_interval(-Inf, r1, true, false))
            push!(domain_parts, fmt_interval(r1, r2, false, false))
            push!(domain_parts, fmt_interval(r2, Inf, false, true))
        end
        
        answer = join(domain_parts, " ∪ ")
        
        problem(
            question="Find the domain of \$f(x) = $(tex(func))\$",
            answer=answer,
            difficulty=(1800, 2000),
            answer_type="interval_union",
            solution=steps(
                sol("Given", func),
                "The denominator cannot equal zero: \$$(tex(denom)) \\neq 0\$",
                "This gives us \$x \\neq $(r1)\$ and \$x \\neq $(r2)\$",
                "Domain: \$$(answer)\$"
            ),
            time=120
        )
        
    elseif prob_type == 2
        # Square root with quadratic inside
        r1 = randint(-10, 10)
        r2 = randint(-10, 10)
        while r2 == r1
            r2 = randint(-10, 10)
        end
        if r1 > r2
            r1, r2 = r2, r1
        end
        
        a = rand([1, -1]) * rand(1:3)
        inner = expand(a * (x - r1) * (x - r2))
        
        if a > 0
            answer = fmt_interval(-Inf, r1, true, true) * " ∪ " * fmt_interval(r2, Inf, true, true)
            inequality_str = "\\geq"
        else
            answer = fmt_interval(r1, r2, true, true)
            inequality_str = "\\leq"
        end
        
        problem(
            question="Find the domain of \$g(x) = \\sqrt{$(tex(inner))}\$",
            answer=answer,
            answer_type="interval_union",
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given", "g(x) = \\sqrt{$(tex(inner))}"),
                "Require \$$(tex(inner)) \\geq 0\$",
                "Factor: \$$(a)$(tex((x - r1)*(x - r2))) $(inequality_str) 0\$",
                "Analyze sign: roots at \$x = $(r1), $(r2)\$",
                "Domain: \$$(answer)\$"
            ),
            time=180
        )
        
    elseif prob_type == 3
        # Composition with restricted range becoming domain
        a = nonzero(-5, 5)
        h = randint(-8, 8)
        k = randint(-15, 15)
        
        vertex_form = a*(x - h)^2 + k
        expanded = expand(vertex_form)
        
        if a > 0
            range_ans = fmt_interval(k, Inf, true, true)
            extremum = "minimum"
        else
            range_ans = fmt_interval(-Inf, k, true, true)
            extremum = "maximum"
        end
        
        problem(
            question="Find the range of \$h(x) = $(tex(expanded))\$",
            answer=range_ans,
            answer_type="interval",
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", expanded),
                "Complete the square: \$h(x) = $(tex(vertex_form))\$",
                "Vertex at \$($(h), $(k))\$ with $(extremum) value \$$(k)\$",
                "Since \$a = $(a)\$ is $(a > 0 ? "positive" : "negative"), parabola opens $(a > 0 ? "upward" : "downward")",
                "Range: \$$(range_ans)\$"
            ),
            time=150
        )
        
    elseif prob_type == 4
        # Piecewise function range
        m1 = nonzero(-4, 4)
        b1 = randint(-10, 10)
        
        m2 = nonzero(-4, 4)
        b2 = randint(-10, 10)
        
        split = randint(-5, 5)
        
        left_val = m1 * split + b1
        right_val = m2 * split + b2
        
        y_at_neg_inf = m1 < 0 ? Inf : -Inf
        y_at_pos_inf = m2 > 0 ? Inf : -Inf
        
        y_min = min(left_val, right_val, y_at_neg_inf == Inf ? 1000 : -1000, y_at_pos_inf == Inf ? 1000 : -1000)
        y_max = max(left_val, right_val, y_at_neg_inf == -Inf ? -1000 : 1000, y_at_pos_inf == -Inf ? -1000 : 1000)
        
        all_vals = [left_val, right_val]
        if m1 > 0
            y_left_extreme = -Inf
        else
            y_left_extreme = Inf
        end
        if m2 > 0
            y_right_extreme = Inf
        else
            y_right_extreme = -Inf
        end
        
        range_lower = min(left_val, right_val)
        range_upper = max(left_val, right_val)
        
        if y_left_extreme == -Inf || y_right_extreme == -Inf
            range_lower = -Inf
        end
        if y_left_extreme == Inf || y_right_extreme == Inf
            range_upper = Inf
        end
        
        answer = fmt_interval(range_lower, range_upper, true, true)
        
        piece1_str = "$(m1)x + $(b1)"
        piece2_str = "$(m2)x + $(b2)"
        
        problem(
            question="Find the range of \$f(x) = \\begin{cases} $(piece1_str) & x < $(split) \\\\ $(piece2_str) & x \\geq $(split) \\end{cases}\$",
            answer=answer,
            answer_type="interval",
            difficulty=(2000, 2200),
            solution=steps(
                "Analyze each piece separately",
                "Left piece: \$y = $(piece1_str)\$ for \$x < $(split)\$ gives \$y < $(left_val)\$",
                "Right piece: \$y = $(piece2_str)\$ for \$x \\geq $(split)\$ gives \$y \\geq $(right_val)\$",
                "Combine both pieces and limits",
                "Range: \$$(answer)\$"
            ),
            time=180
        )
        
    elseif prob_type == 5
        # Radical with linear inside, then rational
        m = rand([2, 3, 4])
        b = randint(-15, 15)
        inner = m*x + b
        root_val = -b // m
        
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        while d == c
            d = nonzero(-8, 8)
        end
        
        denom_expr = c*x + d
        hole = -d // c
        
        if root_val < hole
            answer = fmt_interval(root_val, hole, true, false) * " ∪ " * fmt_interval(hole, Inf, false, true)
        elseif root_val > hole
            answer = fmt_interval(hole, root_val, false, false) * " ∪ " * fmt_interval(root_val, Inf, true, true)
        else
            answer = fmt_interval(root_val, Inf, false, true)
        end
        
        problem(
            question="Find the domain of \$p(x) = \\frac{\\sqrt{$(tex(inner))}}{$(tex(denom_expr))}\$",
            answer=answer,
            answer_type="interval_union",
            difficulty=(2100, 2300),
            solution=steps(
                "Require two conditions:",
                "1) Square root: \$$(tex(inner)) \\geq 0 \\Rightarrow x \\geq $(root_val)\$",
                "2) Denominator: \$$(tex(denom_expr)) \\neq 0 \\Rightarrow x \\neq $(hole)\$",
                "Combine restrictions",
                "Domain: \$$(answer)\$"
            ),
            time=180
        )
        
    else
        # Absolute value rational with range question
        a = nonzero(-5, 5)
        r = randint(-8, 8)
        denom = x - r
        num = a
        
        # Range of |a/(x-r)| is [0, ∞)
        answer = fmt_interval(0, Inf, true, true)
        
        problem(
            question="Find the range of \$q(x) = \\left|\\frac{$(a)}{$(tex(denom))}\\right|\$",
            answer=answer,
            answer_type="interval",
            difficulty=(2200, 2400),
            solution=steps(
                sol("Given", "q(x) = \\left|\\frac{$(a)}{$(tex(denom))}\\right|"),
                "As \$x \\to $(r)\$, \$|q(x)| \\to \\infty\$",
                "As \$x \\to \\pm\\infty\$, \$q(x) \\to 0\$",
                "Since absolute value, \$q(x) > 0\$ for all \$x \\neq $(r)\$",
                "Range: \$$(answer)\$"
            ),
            time=150
        )
    end
end