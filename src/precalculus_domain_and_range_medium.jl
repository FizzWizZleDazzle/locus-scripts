# precalculus - domain_and_range (medium)
# Generated: 2026-03-08T20:23:48.444338

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("precalculus/domain_and_range")
    
    problem_type = choice([
        :rational_domain,
        :sqrt_domain,
        :combined_domain,
        :quadratic_range,
        :rational_range,
        :absolute_value_range,
        :piecewise_domain,
        :composition_domain
    ])
    
    if problem_type == :rational_domain
        # Domain of rational function: exclude zeros of denominator
        num_roots = choice([1, 2])
        if num_roots == 1
            r = nonzero(-15, 15)
            denom = expand((x - r))
            numer_offset = randint(-10, 10)
            numer = x + numer_offset
            expr = numer / denom
            excluded = Set([r])
            ans = "(-\\infty, $(r)) \\cup ($(r), \\infty)"
            
            prob = problem(
                question="Find the domain of \$f(x) = $(tex(expr))\$",
                answer=ans,
                difficulty=(1200, 1400),
                answer_type="interval_union",
                solution=steps(
                    sol("Given", expr),
                    "The denominator cannot equal zero",
                    sol("Set denominator \\neq 0", denom ~ 0),
                    "Solve: \$x \\neq $(r)\$",
                    "Domain: \$(-\\infty, $(r)) \\cup ($(r), \\infty)\$"
                ),
                time=90
            )
        else
            r1 = nonzero(-12, 12)
            r2 = nonzero(-12, 12)
            while r2 == r1
                r2 = nonzero(-12, 12)
            end
            if r1 > r2
                r1, r2 = r2, r1
            end
            denom = expand((x - r1) * (x - r2))
            numer = rand_linear(x).expr
            expr = numer / denom
            excluded = Set([r1, r2])
            ans = "(-\\infty, $(r1)) \\cup ($(r1), $(r2)) \\cup ($(r2), \\infty)"
            
            prob = problem(
                question="Find the domain of \$f(x) = $(tex(expr))\$",
                answer=ans,
                difficulty=(1300, 1500),
                answer_type="interval_union",
                solution=steps(
                    sol("Given", expr),
                    "Set denominator ≠ 0",
                    sol("Factor denominator", (x - r1) * (x - r2) ~ 0),
                    "Excluded values: \$x \\neq $(r1), $(r2)\$",
                    "Domain: \$(-\\infty, $(r1)) \\cup ($(r1), $(r2)) \\cup ($(r2), \\infty)\$"
                ),
                time=120
            )
        end
        
    elseif problem_type == :sqrt_domain
        # Domain of sqrt function: argument >= 0
        a = nonzero(-8, 8)
        b = randint(-20, 20)
        inside = a*x + b
        bound = -b // a
        
        if a > 0
            ans = fmt_interval(bound, Inf, true, true)
        else
            ans = fmt_interval(-Inf, bound, true, true)
        end
        
        prob = problem(
            question="Find the domain of \$f(x) = \\sqrt{$(tex(inside))}\$",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="interval",
            solution=steps(
                sol("Given", "\\sqrt{$(tex(inside))}"),
                "The radicand must be non-negative",
                sol("Set", inside ~ 0),
                "Solve: \$x $(a > 0 ? "\\geq" : "\\leq") $(bound)\$",
                "Domain: $(ans)"
            ),
            time=90
        )
        
    elseif problem_type == :combined_domain
        # Domain of sqrt of rational
        r = nonzero(-10, 10)
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        numer = a*x + b
        denom = x - r
        inside = numer / denom
        
        # Need numer/denom >= 0 and denom != 0
        bound = -b // a
        
        if (a > 0 && r < bound) || (a < 0 && r > bound)
            if a > 0
                ans = "(-\\infty, $(r)) \\cup [$(bound), \\infty)"
            else
                ans = "(-\\infty, $(bound)] \\cup ($(r), \\infty)"
            end
        else
            if a > 0
                ans = "[$(bound), \\infty)"
            else
                ans = "(-\\infty, $(bound)]"
            end
        end
        
        prob = problem(
            question="Find the domain of \$f(x) = \\sqrt{$(tex(inside))}\$",
            answer=ans,
            difficulty=(1500, 1700),
            answer_type="interval_union",
            solution=steps(
                sol("Given", "\\sqrt{$(tex(inside))}"),
                "Need \$$(tex(numer))/$(tex(denom)) \\geq 0\$ and \$x \\neq $(r)\$",
                "Find critical points: \$x = $(r), x = $(bound)\$",
                "Test intervals using sign analysis",
                "Domain: $(ans)"
            ),
            time=180
        )
        
    elseif problem_type == :quadratic_range
        # Range of quadratic (parabola)
        q = rand_quadratic(x; a=(-5, 5), b=(-12, 12), c=(-20, 20))
        while q.a == 0
            q = rand_quadratic(x; a=(-5, 5), b=(-12, 12), c=(-20, 20))
        end
        
        # Vertex form: vertex x = -b/(2a)
        h = -q.b // (2 * q.a)
        k = substitute(q.expr, x => h)
        k_val = Float64(k)
        
        if q.a > 0
            ans = fmt_interval(k, Inf, true, true)
            direction = "upward"
        else
            ans = fmt_interval(-Inf, k, true, true)
            direction = "downward"
        end
        
        prob = problem(
            question="Find the range of \$f(x) = $(tex(q.expr))\$",
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="interval",
            solution=steps(
                sol("Given", q.expr),
                "This is a parabola opening $(direction)",
                "Find vertex: \$h = -\\frac{b}{2a} = $(h)\$",
                "Vertex value: \$k = f($(h)) = $(k)\$",
                "Range: $(ans)"
            ),
            time=120
        )
        
    elseif problem_type == :rational_range
        # Range of simple rational function
        a = nonzero(-10, 10)
        b = nonzero(-15, 15)
        r = nonzero(-12, 12)
        c = randint(-20, 20)
        
        # f(x) = a/(x - r) + b has horizontal asymptote y = b, excluded value
        expr = a/(x - r) + b
        
        ans = "(-\\infty, $(b)) \\cup ($(b), \\infty)"
        
        prob = problem(
            question="Find the range of \$f(x) = $(tex(expr))\$",
            answer=ans,
            difficulty=(1400, 1600),
            answer_type="interval_union",
            solution=steps(
                sol("Given", expr),
                "Horizontal asymptote: \$y = $(b)\$",
                "Solve \$y = $(tex(expr))\$ for \$x\$",
                "The value \$y = $(b)\$ is never attained",
                "Range: $(ans)"
            ),
            time=150
        )
        
    elseif problem_type == :absolute_value_range
        # Range of |linear| + constant or -|linear| + constant
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        c = randint(-10, 10)
        inside = a*x + b
        
        # Vertex at x = -b/a, vertex value = c
        if choice([true, false])
            # f(x) = |ax + b| + c, range [c, ∞)
            expr = abs(inside) + c
            ans = fmt_interval(c, Inf, true, true)
            opens = "upward"
        else
            # f(x) = -|ax + b| + c, range (-∞, c]
            expr = -abs(inside) + c
            ans = fmt_interval(-Inf, c, true, true)
            opens = "downward"
        end
        
        prob = problem(
            question="Find the range of \$f(x) = $(tex(expr))\$",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="interval",
            solution=steps(
                sol("Given", expr),
                "Absolute value function opening $(opens)",
                "Minimum/maximum value occurs at vertex",
                "Vertex value: \$$(c)\$",
                "Range: $(ans)"
            ),
            time=90
        )
        
    elseif problem_type == :piecewise_domain
        # Domain of piecewise with restricted pieces
        a1 = nonzero(-8, 8)
        b1 = randint(-15, 15)
        r = randint(-10, 10)
        a2 = nonzero(-6, 6)
        b2 = randint(-12, 12)
        
        expr1 = a1*x + b1
        expr2 = a2*x + b2
        
        ans = fmt_interval(-Inf, Inf, true, true)
        
        prob = problem(
            question="Find the domain of the piecewise function: \$f(x) = \\begin{cases} $(tex(expr1)) & x < $(r) \\\\ $(tex(expr2)) & x \\geq $(r) \\end{cases}\$",
            answer=ans,
            difficulty=(1200, 1300),
            answer_type="interval",
            solution=steps(
                "Given: piecewise function",
                "First piece defined for \$x < $(r)\$",
                "Second piece defined for \$x \\geq $(r)\$",
                "Union covers all real numbers",
                "Domain: \$(-\\infty, \\infty)\$"
            ),
            time=90
        )
        
    else  # composition_domain
        # Domain of composition f(g(x)) where g has restricted domain
        r = nonzero(-10, 10)
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        
        # g(x) = sqrt(x - r), domain [r, ∞)
        # f(x) = ax + b, domain all reals
        # f(g(x)) = a*sqrt(x - r) + b, domain [r, ∞)
        
        inner = x - r
        composition = "$(a)\\sqrt{$(tex(inner))} + $(b)"
        
        ans = fmt_interval(r, Inf, true, true)
        
        prob = problem(
            question="Find the domain of \$(f \\circ g)(x)\$ where \$g(x) = \\sqrt{$(tex(inner))}\$ and \$f(x) = $(tex(a*x + b))\$",
            answer=ans,
            difficulty=(1400, 1600),
            answer_type="interval",
            solution=steps(
                "For composition \$f(g(x))\$, domain is restricted by \$g(x)\$",
                sol("Domain of g(x)", "x \\geq $(r)"),
                "Since \$f(x)\$ is defined for all reals, no further restrictions",
                "Output of \$g\$ must be in domain of \$f\$ (always satisfied)",
                "Domain: $(ans)"
            ),
            time=120
        )
    end
    
    prob
end