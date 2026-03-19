# calculus - curve_sketching (easy)
# Generated: 2026-03-08T20:42:15.353005

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/curve_sketching")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Find critical points of a quadratic
        q = rand_quadratic(x; a=(-5,5), b=(-12,12), c=(-20,20))
        while q.a == 0
            q = rand_quadratic(x; a=(-5,5), b=(-12,12), c=(-20,20))
        end
        
        df = diff(q.expr, x)
        crit_pt = solve(df ~ 0, x)[1]
        
        problem(
            question="Find the critical point(s) of \$f(x) = $(tex(q.expr))\$",
            answer=crit_pt,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", q.expr),
                sol("Find derivative", df),
                "Set derivative equal to zero and solve",
                sol("Critical point", crit_pt)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Determine intervals of increase/decrease for quadratic
        a = nonzero(-6, 6)
        b = randint(-15, 15)
        c = randint(-25, 25)
        f = a*x^2 + b*x + c
        df = diff(f, x)
        crit = -b // (2*a)
        
        if a > 0
            inc = fmt_interval(crit, Inf, false, true)
            dec = fmt_interval(-Inf, crit, true, false)
            answer_text = "Increasing: $(inc), Decreasing: $(dec)"
        else
            inc = fmt_interval(-Inf, crit, true, false)
            dec = fmt_interval(crit, Inf, false, true)
            answer_text = "Increasing: $(inc), Decreasing: $(dec)"
        end
        
        problem(
            question="Find the intervals where \$f(x) = $(tex(f))\$ is increasing and decreasing.",
            answer=answer_text,
            difficulty=(800, 1000),
            answer_type="expression",
            solution=steps(
                sol("Given", f),
                sol("Derivative", df),
                "Set \$f'(x) = 0\$ to find critical point: \$x = $(tex(crit))\$",
                "Test intervals around critical point",
                a > 0 ? "Since \$a > 0\$, parabola opens upward" : "Since \$a < 0\$, parabola opens downward",
                answer_text
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Find local maximum or minimum of a quadratic
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        c = randint(-20, 20)
        f = a*x^2 + b*x + c
        
        crit_x = -b // (2*a)
        y_val = substitute(f, x => crit_x)
        
        extremum_type = a > 0 ? "minimum" : "maximum"
        
        problem(
            question="Find the local $(extremum_type) value of \$f(x) = $(tex(f))\$",
            answer=y_val,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", f),
                sol("Derivative", diff(f, x)),
                "Critical point at \$x = $(tex(crit_x))\$",
                "Since \$a = $(a)\$ " * (a > 0 ? "> 0" : "< 0") * ", this is a $(extremum_type)",
                sol("$(extremum_type) value", y_val)
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Determine concavity of a quadratic
        a = nonzero(-7, 7)
        b = randint(-15, 15)
        c = randint(-30, 30)
        f = a*x^2 + b*x + c
        
        df = diff(f, x)
        d2f = diff(df, x)
        
        concavity = a > 0 ? "concave up" : "concave down"
        
        problem(
            question="Determine whether \$f(x) = $(tex(f))\$ is concave up or concave down.",
            answer=concavity,
            difficulty=(700, 900),
            answer_type="expression",
            solution=steps(
                sol("Given", f),
                sol("First derivative", df),
                sol("Second derivative", d2f),
                "Since \$f''(x) = $(tex(d2f))\$ " * (a > 0 ? "> 0" : "< 0") * " for all \$x\$",
                "The function is $(concavity) everywhere"
            ),
            time=90
        )
        
    else
        # Find where derivative is positive/negative for a cubic
        a = nonzero(-3, 3)
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        while r2 == r1
            r2 = randint(-8, 8)
        end
        
        if r1 > r2
            r1, r2 = r2, r1
        end
        
        df = expand(a * (x - r1) * (x - r2))
        
        if a > 0
            pos_interval = fmt_interval(-Inf, r1, true, false) * " ∪ " * fmt_interval(r2, Inf, false, true)
            neg_interval = fmt_interval(r1, r2, false, false)
        else
            pos_interval = fmt_interval(r1, r2, false, false)
            neg_interval = fmt_interval(-Inf, r1, true, false) * " ∪ " * fmt_interval(r2, Inf, false, true)
        end
        
        problem(
            question="If \$f'(x) = $(tex(df))\$, find where \$f'(x) > 0\$",
            answer=pos_interval,
            difficulty=(900, 1100),
            answer_type="expression",
            solution=steps(
                sol("Given derivative", df),
                "Factor: \$f'(x) = $(tex(a*(x - r1)*(x - r2)))\$",
                "Critical points at \$x = $(r1)\$ and \$x = $(r2)\$",
                "Test sign in each interval",
                sol("f'(x) > 0 on", pos_interval)
            ),
            time=120
        )
    end
end