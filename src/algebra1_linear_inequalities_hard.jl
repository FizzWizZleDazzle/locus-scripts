# algebra1 - linear_inequalities (hard)
# Generated: 2026-03-08T19:54:31.725227

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/linear_inequalities")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Compound inequality with absolute value
        # |ax + b| < c or |ax + b| > c
        a = nonzero(-8, 8)
        b = randint(-25, 25)
        c = randint(10, 40)
        is_less = rand(Bool)
        
        left_bound = (-c - b) // a
        right_bound = (c - b) // a
        
        if a < 0
            left_bound, right_bound = right_bound, left_bound
        end
        
        if is_less
            ans = fmt_interval(left_bound, right_bound, true, true)
            ineq_symbol = "<"
            explanation = "Split into compound inequality: \$$(tex(-c)) < $(tex(a*x + b)) < $(tex(c))\$"
        else
            ans = fmt_interval(-Inf, left_bound, true, true) * " ∪ " * fmt_interval(right_bound, Inf, true, true)
            ineq_symbol = ">"
            explanation = "Split into two cases: \$$(tex(a*x + b)) < $(tex(-c))\$ or \$$(tex(a*x + b)) > $(tex(c))\$"
        end
        
        problem(
            question="Solve \$|$(tex(a*x + b))| $(ineq_symbol) $(c)\$",
            answer=ans,
            difficulty=(1800, 2000),
            answer_type="interval",
            solution=steps(
                sol("Given", "|$(tex(a*x + b))| $(ineq_symbol) $(c)"),
                explanation,
                "Solve for x in each part",
                "Answer: \$$(ans)\$"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Rational inequality: (ax + b)/(cx + d) > 0 or < 0
        a = nonzero(-10, 10)
        b = randint(-30, 30)
        c = nonzero(-10, 10)
        d = randint(-30, 30)
        
        zero_point = -b // a
        asymptote = -d // c
        
        is_positive = rand(Bool)
        
        if zero_point < asymptote
            left = zero_point
            right = asymptote
        else
            left = asymptote
            right = zero_point
        end
        
        # Determine sign in each interval
        test_left = substitute(a*x + b, x => left - 1) / substitute(c*x + d, x => left - 1)
        test_middle = substitute(a*x + b, x => (left + right)/2) / substitute(c*x + d, x => (left + right)/2)
        test_right = substitute(a*x + b, x => right + 1) / substitute(c*x + d, x => right + 1)
        
        sign_left = test_left > 0
        sign_middle = test_middle > 0
        sign_right = test_right > 0
        
        intervals = []
        if (is_positive && sign_left) || (!is_positive && !sign_left)
            push!(intervals, fmt_interval(-Inf, left, true, zero_point == left))
        end
        if (is_positive && sign_middle) || (!is_positive && !sign_middle)
            push!(intervals, fmt_interval(left, right, zero_point == left, false))
        end
        if (is_positive && sign_right) || (!is_positive && !sign_right)
            push!(intervals, fmt_interval(right, Inf, zero_point == right, true))
        end
        
        ans = join(intervals, " ∪ ")
        
        problem(
            question="Solve \$\\frac{$(tex(a*x + b))}{$(tex(c*x + d))} $(is_positive ? ">" : "<") 0\$",
            answer=ans,
            difficulty=(1900, 2200),
            answer_type="interval",
            solution=steps(
                sol("Given", "\\frac{$(tex(a*x + b))}{$(tex(c*x + d))} $(is_positive ? ">" : "<") 0"),
                "Find critical points: numerator zero at \$x = $(tex(zero_point))\$, asymptote at \$x = $(tex(asymptote))\$",
                "Test sign in each interval",
                "Answer: \$$(ans)\$"
            ),
            time=240
        )
        
    elseif problem_type == 3
        # System of inequalities
        a1 = nonzero(-8, 8)
        b1 = randint(-25, 25)
        c1 = randint(-30, 30)
        
        a2 = nonzero(-8, 8)
        b2 = randint(-25, 25)
        c2 = randint(-30, 30)
        
        bound1 = (c1 - b1) // a1
        bound2 = (c2 - b2) // a2
        
        if a1 > 0
            int1_left = -Inf
            int1_right = bound1
            int1_left_open = true
            int1_right_open = false
        else
            int1_left = bound1
            int1_right = Inf
            int1_left_open = false
            int1_right_open = true
        end
        
        if a2 > 0
            int2_left = -Inf
            int2_right = bound2
            int2_left_open = true
            int2_right_open = false
        else
            int2_left = bound2
            int2_right = Inf
            int2_left_open = false
            int2_right_open = true
        end
        
        final_left = max(int1_left, int2_left)
        final_right = min(int1_right, int2_right)
        
        if final_left >= final_right
            ans = "∅"
        else
            left_open = (final_left == int1_left ? int1_left_open : int2_left_open)
            right_open = (final_right == int1_right ? int1_right_open : int2_right_open)
            ans = fmt_interval(final_left, final_right, left_open, right_open)
        end
        
        problem(
            question="Solve the system: \$$(tex(a1*x + b1)) \\leq $(c1)\$ and \$$(tex(a2*x + b2)) \\leq $(c2)\$",
            answer=ans,
            difficulty=(1850, 2100),
            answer_type="interval",
            solution=steps(
                "Solve first inequality: \$$(tex(a1*x + b1)) \\leq $(c1)\$",
                "Solve second inequality: \$$(tex(a2*x + b2)) \\leq $(c2)\$",
                "Find intersection of solution sets",
                "Answer: \$$(ans)\$"
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Quadratic inequality: ax² + bx + c > 0 or < 0
        r1 = randint(-15, 15)
        r2 = randint(-15, 15)
        while r2 == r1
            r2 = randint(-15, 15)
        end
        
        if r1 > r2
            r1, r2 = r2, r1
        end
        
        a = choice([-3, -2, -1, 1, 2, 3])
        expr = expand(a * (x - r1) * (x - r2))
        
        is_greater = rand(Bool)
        
        if (a > 0 && is_greater) || (a < 0 && !is_greater)
            ans = fmt_interval(-Inf, r1, true, true) * " ∪ " * fmt_interval(r2, Inf, true, true)
        else
            ans = fmt_interval(r1, r2, true, true)
        end
        
        problem(
            question="Solve \$$(tex(expr)) $(is_greater ? ">" : "<") 0\$",
            answer=ans,
            difficulty=(1800, 2000),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(tex(expr)) $(is_greater ? ">" : "<") 0"),
                "Factor: \$$(tex(a * (x - r1) * (x - r2))) $(is_greater ? ">" : "<") 0\$",
                "Critical points at \$x = $(r1), $(r2)\$",
                "Test intervals to find where inequality holds",
                "Answer: \$$(ans)\$"
            ),
            time=200
        )
        
    else
        # Multi-step with distribution and combining
        a = nonzero(-6, 6)
        b = randint(-20, 20)
        c = nonzero(-6, 6)
        d = randint(-20, 20)
        e = randint(-25, 25)
        
        lhs = expand(a*(x + b) - c*(x - d))
        coeff = a - c
        const_term = a*b + c*d
        
        bound = (e - const_term) // coeff
        
        if coeff > 0
            ans = fmt_interval(bound, Inf, true, true)
            symbol = ">"
        else
            ans = fmt_interval(-Inf, bound, true, true)
            symbol = "<"
        end
        
        problem(
            question="Solve \$$(tex(a*(x + b) - c*(x - d))) > $(e)\$",
            answer=ans,
            difficulty=(1900, 2200),
            answer_type="interval",
            solution=steps(
                sol("Given", "$(tex(a*(x + b) - c*(x - d))) > $(e)"),
                "Distribute: \$$(tex(lhs)) > $(e)\$",
                "Combine like terms: \$$(tex(coeff*x + const_term)) > $(e)\$",
                "Isolate x",
                "Answer: \$x $(symbol) $(tex(bound))\$"
            ),
            time=210
        )
    end
end