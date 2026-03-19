# calculus - curve_sketching (medium)
# Generated: 2026-03-08T20:42:22.938048

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/curve_sketching")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Find critical points of a polynomial
        q = rand_quadratic(x; a=(-5,5), b=(-12,12), c=(-15,15), nonzero_a=true)
        f = q.expr
        df = diff(f, x)
        crit_pts = solve(df ~ 0, x)
        
        if length(crit_pts) == 1
            ans = fmt_set(Set([float(crit_pts[1])]))
        else
            ans = fmt_set(Set([float(cp) for cp in crit_pts]))
        end
        
        problem(
            question="Find all critical points of \$f(x) = $(tex(f))\$",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="set",
            solution=steps(
                sol("Given", f),
                sol("Find derivative", df),
                "Set \$f'(x) = 0\$ and solve for \$x\$",
                "Critical points: $(ans)"
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Determine intervals of increase/decrease
        r1 = randint(-8, -1)
        r2 = randint(1, 8)
        a = choice([-1, 1])
        f = expand(a * (x - r1) * (x - r2))
        df = diff(f, x)
        
        if a > 0
            inc_int = fmt_interval(-Inf, (r1+r2)/2, true, false) * " ∪ " * fmt_interval((r1+r2)/2, Inf, false, true)
            dec_int = fmt_interval((r1+r2)/2, (r1+r2)/2, true, true)
            ans = inc_int
            question_text = "On what interval(s) is \$f(x) = $(tex(f))\$ increasing?"
        else
            dec_int = fmt_interval(-Inf, (r1+r2)/2, true, false) * " ∪ " * fmt_interval((r1+r2)/2, Inf, false, true)
            inc_int = fmt_interval((r1+r2)/2, (r1+r2)/2, true, true)
            ans = dec_int
            question_text = "On what interval(s) is \$f(x) = $(tex(f))\$ decreasing?"
        end
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(1300, 1500),
            answer_type="interval",
            solution=steps(
                sol("Given", f),
                sol("Derivative", df),
                "Find critical point: \$x = $((r1+r2)/2)\$",
                "Test intervals around critical point",
                "Answer: $(ans)"
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Find local extrema with second derivative test
        r = randint(-10, 10)
        a = nonzero(-4, 4)
        b = randint(-8, 8)
        f = expand(a*(x - r)^2 + b)
        df = diff(f, x)
        ddf = diff(df, x)
        
        extremum_type = a > 0 ? "minimum" : "maximum"
        y_val = float(substitute(f, x => r))
        
        problem(
            question="Find the local $(extremum_type) of \$f(x) = $(tex(f))\$ and state its coordinates",
            answer=fmt_tuple((r, y_val)),
            difficulty=(1400, 1600),
            answer_type="tuple",
            solution=steps(
                sol("Given", f),
                sol("First derivative", df),
                "Set \$f'(x) = 0\$: critical point at \$x = $(r)\$",
                sol("Second derivative", ddf),
                "Since \$f''($(r)) = $(float(substitute(ddf, x => r)))\$ $(a > 0 ? "> 0" : "< 0"), this is a local $(extremum_type)",
                "Coordinates: \$($(r), $(y_val))\$"
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Find inflection points of cubic
        a = nonzero(-3, 3)
        b = randint(-12, 12)
        c = randint(-15, 15)
        d = randint(-20, 20)
        f = a*x^3 + b*x^2 + c*x + d
        df = diff(f, x)
        ddf = diff(df, x)
        
        inflection_x = solve(ddf ~ 0, x)
        if length(inflection_x) > 0
            infl_x = float(inflection_x[1])
            infl_y = float(substitute(f, x => infl_x))
            ans = fmt_tuple((infl_x, infl_y))
        else
            ans = "none"
        end
        
        problem(
            question="Find the inflection point of \$f(x) = $(tex(f))\$. If none exists, enter 'none'.",
            answer=ans,
            difficulty=(1500, 1700),
            answer_type=ans == "none" ? "text" : "tuple",
            solution=steps(
                sol("Given", f),
                sol("First derivative", df),
                sol("Second derivative", ddf),
                "Set \$f''(x) = 0\$ and solve",
                ans == "none" ? "No inflection point exists" : "Inflection point at \$($(infl_x), $(infl_y))\$"
            ),
            time=180
        )
        
    else
        # Determine concavity intervals
        a = nonzero(-4, 4)
        h = randint(-8, 8)
        k = randint(-12, 12)
        f = expand(a*(x - h)^2 + k)
        df = diff(f, x)
        ddf = diff(df, x)
        
        if a > 0
            ans = fmt_interval(-Inf, Inf, true, true)
            concavity = "concave up"
        else
            ans = fmt_interval(-Inf, Inf, true, true)
            concavity = "concave down"
        end
        
        problem(
            question="On what interval is \$f(x) = $(tex(f))\$ $(concavity)?",
            answer=ans,
            difficulty=(1200, 1400),
            answer_type="interval",
            solution=steps(
                sol("Given", f),
                sol("First derivative", df),
                sol("Second derivative", ddf),
                "Since \$f''(x) = $(float(substitute(ddf, x => 0)))\$ $(a > 0 ? "> 0" : "< 0") for all \$x\$",
                "The function is $(concavity) on: $(ans)"
            ),
            time=100
        )
    end
end