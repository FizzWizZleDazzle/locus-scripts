# calculus - limits_algebraic (easy)
# Generated: 2026-03-08T20:36:37.703941

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/limits_algebraic")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Direct substitution limit (700-850 ELO)
        a = randint(-8, 8)
        b = randint(-12, 12)
        c = randint(-15, 15)
        expr = a*x^2 + b*x + c
        eval_point = randint(-6, 6)
        ans = a*eval_point^2 + b*eval_point + c
        
        problem(
            question="Evaluate \\lim_{x \\to $(eval_point)} $(tex(expr))",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                sol("Given limit", expr),
                "Since the function is continuous, use direct substitution: x = $(eval_point)",
                sol("Substitute", a*(eval_point)^2 + b*(eval_point) + c),
                sol("Answer", ans)
            ),
            time=60
        )
    elseif problem_type == 2
        # Factoring to cancel (800-1000 ELO)
        root = nonzero(-9, 9)
        other_root = nonzero(-9, 9)
        a = nonzero(-3, 3)
        
        numerator = expand(a*(x - root)*(x - other_root))
        denominator = x - root
        simplified = expand(a*(x - other_root))
        ans = a*(root - other_root)
        
        problem(
            question="Evaluate \\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor the numerator: \\($(tex(a*(x - root)*(x - other_root)))\\)",
                "Cancel the common factor \\((x - $(root))\\): \\($(tex(simplified))\\)",
                "Substitute x = $(root)",
                sol("Answer", ans)
            ),
            time=90
        )
    elseif problem_type == 3
        # Rationalize numerator (900-1100 ELO)
        eval_point = randint(1, 12)
        a = choice([1, 4, 9, 16, 25])
        
        # sqrt(a*x) - sqrt(a*eval_point) all over (x - eval_point)
        ans_num = a
        ans_den = 2*sqrt(a*eval_point)
        ans = ans_num // ans_den
        
        problem(
            question="Evaluate \\lim_{x \\to $(eval_point)} \\frac{\\sqrt{$(a)x} - $(sqrt(a*eval_point))}{x - $(eval_point)}",
            answer=ans,
            difficulty=(900, 1100),
            solution=steps(
                "Multiply by conjugate: \\(\\frac{\\sqrt{$(a)x} + $(sqrt(a*eval_point))}{\\sqrt{$(a)x} + $(sqrt(a*eval_point))}\\)",
                "Numerator becomes: \\($(a)x - $(a*eval_point) = $(a)(x - $(eval_point))\\)",
                "Cancel \\((x - $(eval_point))\\): \\(\\frac{$(a)}{\\sqrt{$(a)x} + $(sqrt(a*eval_point))}\\)",
                "Substitute x = $(eval_point)",
                sol("Answer", ans)
            ),
            time=120
        )
    elseif problem_type == 4
        # Polynomial limit at infinity (850-1050 ELO)
        lead_num = nonzero(-5, 5)
        lead_den = nonzero(-5, 5)
        b_num = randint(-10, 10)
        b_den = randint(-10, 10)
        
        degree = choice(2:3)
        
        if degree == 2
            numerator = lead_num*x^2 + b_num*x + randint(-15, 15)
            denominator = lead_den*x^2 + b_den*x + randint(-15, 15)
        else
            numerator = lead_num*x^3 + b_num*x^2 + randint(-10, 10)*x + randint(-15, 15)
            denominator = lead_den*x^3 + b_den*x^2 + randint(-10, 10)*x + randint(-15, 15)
        end
        
        ans = lead_num // lead_den
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(850, 1050),
            solution=steps(
                "Divide numerator and denominator by \\(x^$(degree)\\)",
                "Leading terms: \\(\\frac{$(lead_num)}{$(lead_den)}\\)",
                "As \\(x \\to \\infty\\), lower degree terms approach 0",
                sol("Answer", ans)
            ),
            time=90
        )
    else
        # Absolute value piecewise limit (950-1200 ELO)
        eval_point = nonzero(-8, 8)
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        
        # |x - eval_point| / (x - eval_point) as x -> eval_point
        # From left: -1, from right: +1
        side = choice(["left", "right"])
        
        if side == "left"
            ans = -1
            arrow = "$(eval_point)^-"
        else
            ans = 1
            arrow = "$(eval_point)^+"
        end
        
        problem(
            question="Evaluate \\lim_{x \\to $(arrow)} \\frac{|x - $(eval_point)|}{x - $(eval_point)}",
            answer=ans,
            difficulty=(950, 1200),
            solution=steps(
                "Analyze the absolute value based on direction of approach",
                side == "left" ? "From the left (x < $(eval_point)): \\(|x - $(eval_point)| = -(x - $(eval_point))\\)" : "From the right (x > $(eval_point)): \\(|x - $(eval_point)| = x - $(eval_point)\\)",
                side == "left" ? "Simplify: \\(\\frac{-(x - $(eval_point))}{x - $(eval_point)} = -1\\)" : "Simplify: \\(\\frac{x - $(eval_point)}{x - $(eval_point)} = 1\\)",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end