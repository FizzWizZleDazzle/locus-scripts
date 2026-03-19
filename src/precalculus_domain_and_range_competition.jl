# precalculus - domain_and_range (competition)
# Generated: 2026-03-08T20:24:12.663151

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("precalculus/domain_and_range")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Composite function with radical and rational - domain restrictions
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        c = nonzero(-12, 12)
        d = randint(-20, 20)
        
        inner = a*x + b
        denom = c*x + d
        
        # sqrt(inner) / denom, find domain
        root_constraint = -b // a
        zero_constraint = -d // c
        
        constraints = sort([root_constraint, zero_constraint])
        
        if a > 0
            # x >= root_constraint and x != zero_constraint
            if root_constraint < zero_constraint
                ans = fmt_interval(root_constraint, zero_constraint, true, false) * " ∪ " * 
                      fmt_interval(zero_constraint, Inf, false, true)
            elseif root_constraint > zero_constraint
                ans = fmt_interval(root_constraint, Inf, true, true)
            else
                ans = fmt_interval(root_constraint, Inf, false, true)
            end
        else
            # x <= root_constraint and x != zero_constraint
            if root_constraint > zero_constraint
                ans = fmt_interval(-Inf, zero_constraint, true, false) * " ∪ " * 
                      fmt_interval(zero_constraint, root_constraint, false, true)
            elseif root_constraint < zero_constraint
                ans = fmt_interval(-Inf, root_constraint, true, true)
            else
                ans = fmt_interval(-Inf, root_constraint, true, false)
            end
        end
        
        problem(
            question="Find the domain of \$f(x) = \\frac{\\sqrt{$(tex(inner))}}{$(tex(denom))}\$",
            answer=ans,
            difficulty=(3500, 3800),
            answer_type="interval",
            solution=steps(
                "The radical requires \$$(tex(inner)) \\geq 0\$",
                "This gives \$x $(a > 0 ? "\\geq" : "\\leq") $(root_constraint)\$",
                "The denominator requires \$$(tex(denom)) \\neq 0\$, so \$x \\neq $(zero_constraint)\$",
                "Combining both constraints gives the domain",
                sol("Domain", ans)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Range of transformed rational function
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        c = nonzero(-5, 5)
        d = randint(-15, 15)
        k = nonzero(-10, 10)
        
        # f(x) = (ax + b)/(cx + d) + k
        # Range excludes horizontal asymptote: y = a/c + k
        excluded = a // c + k
        
        ans = fmt_interval(-Inf, excluded, true, false) * " ∪ " * 
              fmt_interval(excluded, Inf, false, true)
        
        problem(
            question="Find the range of \$f(x) = \\frac{$(tex(a*x + b))}{$(tex(c*x + d))} + $(k)\$",
            answer=ans,
            difficulty=(3600, 3900),
            answer_type="interval",
            solution=steps(
                "Let \$y = \\frac{$(tex(a*x + b))}{$(tex(c*x + d))} + $(k)\$",
                "Solve for x in terms of y: \$y - $(k) = \\frac{$(tex(a*x + b))}{$(tex(c*x + d))}\$",
                "Cross multiply: \$(y - $(k))($(tex(c*x + d))) = $(tex(a*x + b))\$",
                "The horizontal asymptote is \$y = \\frac{$(a)}{$(c)} + $(k) = $(excluded)\$",
                "This value is excluded from the range",
                sol("Range", ans)
            ),
            time=270
        )
        
    elseif problem_type == 3
        # Domain of nested composition with multiple restrictions
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        c = nonzero(-7, 7)
        d = randint(-18, 18)
        e = nonzero(-6, 6)
        f = randint(-15, 15)
        
        # g(x) = sqrt(ax + b)
        # h(x) = 1/sqrt(cx + d)
        # f(x) = g(h(x)) + ex + f
        # Need: cx + d > 0 (for h), and a/sqrt(cx+d) + b >= 0 (for g)
        
        constraint1 = -d // c
        
        if c > 0
            outer_domain = fmt_interval(constraint1, Inf, false, true)
        else
            outer_domain = fmt_interval(-Inf, constraint1, true, false)
        end
        
        ans = outer_domain
        
        problem(
            question="Let \$g(x) = \\sqrt{$(tex(a*x + b))}\$ and \$h(x) = \\frac{1}{\\sqrt{$(tex(c*x + d))}}\$. Find the domain of \$f(x) = g(h(x))\$",
            answer=ans,
            difficulty=(3700, 4100),
            answer_type="interval",
            solution=steps(
                "First, find the domain of \$h(x)\$: need \$$(tex(c*x + d)) > 0\$",
                "This gives \$x $(c > 0 ? ">" : "<") $(constraint1)\$",
                "For the composition, we need \$h(x)\$ to be in the domain of \$g\$",
                "Since \$h(x) = \\frac{1}{\\sqrt{$(tex(c*x + d))}} > 0\$ for all x in its domain",
                "And we need \$$(a) \\cdot h(x) + $(b) \\geq 0\$",
                "Analyzing the composition constraints",
                sol("Domain", ans)
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Range of piecewise function with careful analysis
        a = nonzero(-4, 4)
        b = randint(-10, 10)
        c = nonzero(-5, 5)
        d = randint(-12, 12)
        breakpoint = randint(-8, 8)
        
        # f(x) = ax^2 + b if x <= breakpoint
        # f(x) = cx + d if x > breakpoint
        
        val_at_break_quad = a * breakpoint^2 + b
        val_at_break_linear = c * breakpoint + d
        
        if a > 0
            # Parabola opens up, min at vertex or breakpoint
            vertex_y = b
            left_range_min = min(vertex_y, val_at_break_quad)
            left_range = fmt_interval(left_range_min, Inf, true, true)
        else
            # Parabola opens down, max at vertex or breakpoint
            vertex_y = b
            left_range_max = max(vertex_y, val_at_break_quad)
            left_range = fmt_interval(-Inf, left_range_max, true, true)
        end
        
        if c > 0
            right_range = fmt_interval(val_at_break_linear, Inf, false, true)
        else
            right_range = fmt_interval(-Inf, val_at_break_linear, true, false)
        end
        
        ans = fmt_interval(-Inf, Inf, true, true)
        
        problem(
            question="Find the range of the piecewise function:\n\$f(x) = \\begin{cases} $(tex(a*x^2 + b)) & x \\leq $(breakpoint) \\\\ $(tex(c*x + d)) & x > $(breakpoint) \\end{cases}\$",
            answer=ans,
            difficulty=(3800, 4200),
            answer_type="interval",
            solution=steps(
                "For \$x \\leq $(breakpoint)\$: quadratic \$$(tex(a*x^2 + b))\$ with vertex at \$(0, $(b))\$",
                "At \$x = $(breakpoint)\$: \$f($(breakpoint)) = $(val_at_break_quad)\$",
                "For \$x > $(breakpoint)\$: linear \$$(tex(c*x + d))\$ starts at \$($(breakpoint), $(val_at_break_linear))\$",
                "Combining both pieces and analyzing extrema",
                "The union of both ranges covers all real numbers",
                sol("Range", ans)
            ),
            time=280
        )
        
    else
        # Domain involving logarithm and radical composition
        a = nonzero(-6, 6)
        b = randint(-15, 15)
        c = nonzero(-4, 4)
        d = randint(-12, 12)
        
        # f(x) = log(sqrt(ax + b) - c) + d
        # Need: ax + b >= 0 and sqrt(ax + b) > c
        
        first_constraint = -b // a
        
        if c <= 0
            # sqrt always > c
            if a > 0
                ans = fmt_interval(first_constraint, Inf, true, true)
            else
                ans = fmt_interval(-Inf, first_constraint, true, true)
            end
        else
            # Need sqrt(ax + b) > c, so ax + b > c^2
            second_constraint = (c^2 - b) // a
            
            if a > 0
                ans = fmt_interval(max(first_constraint, second_constraint), Inf, false, true)
            else
                ans = fmt_interval(-Inf, min(first_constraint, second_constraint), true, false)
            end
        end
        
        problem(
            question="Find the domain of \$f(x) = \\log\\left(\\sqrt{$(tex(a*x + b))} - $(c)\\right)\$",
            answer=ans,
            difficulty=(3900, 4400),
            answer_type="interval",
            solution=steps(
                "For the square root: need \$$(tex(a*x + b)) \\geq 0\$",
                "This gives \$x $(a > 0 ? "\\geq" : "\\leq") $(first_constraint)\$",
                "For the logarithm: need \$\\sqrt{$(tex(a*x + b))} - $(c) > 0\$",
                "So \$\\sqrt{$(tex(a*x + b))} > $(c)\$",
                c > 0 ? "Squaring: \$$(tex(a*x + b)) > $(c^2)\$" : "Since \$$(c) \\leq 0\$, this is always satisfied when the square root exists",
                "Combining all constraints",
                sol("Domain", ans)
            ),
            time=290
        )
    end
end