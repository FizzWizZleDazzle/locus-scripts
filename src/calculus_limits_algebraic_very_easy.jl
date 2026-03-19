# calculus - limits_algebraic (very_easy)
# Generated: 2026-03-08T20:36:12.959108

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/limits_algebraic")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Direct substitution - polynomial (ELO 200-400)
        a = randint(-8, 8)
        b = randint(-8, 8)
        c = randint(-8, 8)
        expr = a*x^2 + b*x + c
        pt = randint(-5, 5)
        ans = a*pt^2 + b*pt + c
        
        problem(
            question="Evaluate \\lim_{x \\to $(pt)} $(tex(expr))",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                sol("Given", expr),
                "Substitute x = $(pt) directly",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif problem_type == 2
        # Direct substitution - simple rational (ELO 300-500)
        a = nonzero(-6, 6)
        b = randint(-8, 8)
        c = nonzero(-6, 6)
        d = randint(-8, 8)
        num = a*x + b
        denom = c*x + d
        pt = randint(-5, 5)
        
        # Ensure denominator is not zero at pt
        while c*pt + d == 0
            pt = randint(-5, 5)
        end
        
        ans_num = a*pt + b
        ans_denom = c*pt + d
        ans = ans_num // ans_denom
        
        problem(
            question="Evaluate \\lim_{x \\to $(pt)} \\frac{$(tex(num))}{$(tex(denom))}",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                sol("Given", num / denom),
                "Substitute x = $(pt)",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Constant function limit (ELO 100-300)
        k = randint(-15, 15)
        pt = randint(-10, 10)
        
        problem(
            question="Evaluate \\lim_{x \\to $(pt)} $(k)",
            answer=k,
            difficulty=(100, 300),
            solution=steps(
                "The limit of a constant is the constant itself",
                "The function equals $(k) everywhere",
                sol("Answer", k)
            ),
            time=30
        )
        
    elseif problem_type == 4
        # Linear function limit (ELO 200-500)
        q = rand_linear(x; a=(-8, 8), b=(-12, 12))
        pt = randint(-8, 8)
        ans = q.a * pt + q.b
        
        problem(
            question="Evaluate \\lim_{x \\to $(pt)} $(tex(q.expr))",
            answer=ans,
            difficulty=(200, 500),
            solution=steps(
                sol("Given", q.expr),
                "Substitute x = $(pt)",
                sol("Answer", ans)
            ),
            time=45
        )
        
    else
        # Sum/difference of limits (ELO 400-700)
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        c = nonzero(-5, 5)
        d = randint(-8, 8)
        expr1 = a*x + b
        expr2 = c*x^2 + d
        combined = expr1 + expr2
        pt = randint(-5, 5)
        
        ans1 = a*pt + b
        ans2 = c*pt^2 + d
        ans = ans1 + ans2
        
        problem(
            question="Evaluate \\lim_{x \\to $(pt)} \\left[ $(tex(combined)) \\right]",
            answer=ans,
            difficulty=(400, 700),
            solution=steps(
                sol("Given", combined),
                "Use sum rule: break into separate limits",
                "Substitute x = $(pt) into each term: $(ans1) + $(ans2)",
                sol("Answer", ans)
            ),
            time=75
        )
    end
end