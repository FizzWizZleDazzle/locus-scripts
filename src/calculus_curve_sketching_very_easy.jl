# calculus - curve_sketching (very_easy)
# Generated: 2026-03-08T20:41:52.200976

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/curve_sketching")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Identify increasing/decreasing from graph description (ELO 200-400)
        slope = choice([-3, -2, -1, 1, 2, 3])
        direction = slope > 0 ? "increasing" : "decreasing"
        other_direction = slope > 0 ? "decreasing" : "increasing"
        
        problem(
            question="A line has slope $(slope). Is the function increasing or decreasing?",
            answer=direction,
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                "A line with slope $(slope) is $(slope > 0 ? "positive" : "negative")",
                "When the slope is $(slope > 0 ? "positive" : "negative"), the function is $(direction)",
                sol("Answer", direction)
            ),
            time=30
        )
        
    elseif problem_type == 2
        # Recognize critical point from derivative equals zero (ELO 400-600)
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        crit_pt = -b // a
        deriv = a * x + b
        
        problem(
            question="If \$f'(x) = $(tex(deriv))\$, at what value of \$x\$ is there a critical point?",
            answer=crit_pt,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", deriv),
                "Critical points occur when \$f'(x) = 0\$",
                sol("Solve", deriv ~ 0),
                sol("Answer", crit_pt)
            ),
            time=45
        )
        
    elseif problem_type == 3
        # Identify where derivative is positive/negative (ELO 500-700)
        root = randint(-12, 12)
        a = choice([-2, -1, 1, 2])
        deriv = a * (x - root)
        
        if a > 0
            interval_pos = fmt_interval(root, Inf, false, true)
            interval_neg = fmt_interval(-Inf, root, true, false)
            answer_increasing = interval_pos
        else
            interval_pos = fmt_interval(-Inf, root, true, false)
            interval_neg = fmt_interval(root, Inf, false, true)
            answer_increasing = interval_pos
        end
        
        problem(
            question="If \$f'(x) = $(tex(deriv))\$, on what interval is \$f(x)\$ increasing?",
            answer=answer_increasing,
            difficulty=(500, 700),
            answer_type="interval",
            solution=steps(
                sol("Given", deriv),
                "Function is increasing when \$f'(x) > 0\$",
                "Solve \$$(tex(deriv)) > 0\$",
                "Critical point at \$x = $(root)\$",
                sol("Answer", answer_increasing)
            ),
            time=60
        )
        
    elseif problem_type == 4
        # Find where function has horizontal tangent (ELO 400-600)
        r = randint(-10, 10)
        a = choice([1, 2])
        f_expr = a * (x - r)^2 + randint(-8, 8)
        deriv = diff(f_expr, x)
        
        problem(
            question="At what \$x\$-value does \$f(x) = $(tex(f_expr))\$ have a horizontal tangent line?",
            answer=r,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", f_expr),
                "Horizontal tangent when \$f'(x) = 0\$",
                sol("Derivative", deriv),
                "Solve \$$(tex(deriv)) = 0\$",
                sol("Answer", r)
            ),
            time=60
        )
        
    elseif problem_type == 5
        # Determine concavity from second derivative sign (ELO 500-700)
        a = choice([-6, -4, -2, 2, 4, 6])
        concavity = a > 0 ? "up" : "down"
        other_concavity = a > 0 ? "down" : "up"
        
        problem(
            question="If \$f''(x) = $(a)\$ for all \$x\$, is the function concave up or concave down?",
            answer="concave $(concavity)",
            difficulty=(500, 700),
            answer_type="text",
            solution=steps(
                sol("Given", "f''(x) = $(a)"),
                "When \$f''(x) $(a > 0 ? "> 0" : "< 0")\$, the function is concave $(concavity)",
                sol("Answer", "concave $(concavity)")
            ),
            time=30
        )
        
    else
        # Identify inflection point from second derivative (ELO 600-700)
        root = randint(-12, 12)
        a = nonzero(-3, 3)
        second_deriv = a * (x - root)
        
        problem(
            question="If \$f''(x) = $(tex(second_deriv))\$, at what \$x\$-value is there an inflection point?",
            answer=root,
            difficulty=(600, 700),
            solution=steps(
                sol("Given", second_deriv),
                "Inflection points occur when \$f''(x) = 0\$",
                sol("Solve", second_deriv ~ 0),
                sol("Answer", root)
            ),
            time=45
        )
    end
end