# calculus - limits_algebraic (medium)
# Generated: 2026-03-08T20:36:37.276769

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/limits_algebraic")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Limit by direct substitution (simplest case)
        q = rand_quadratic(x; a=(-5,5), b=(-10,10), c=(-10,10))
        a = randint(-8, 8)
        ans = substitute(q.expr, x => a)
        
        problem(
            question="Evaluate \\lim_{x \\to $(a)} $(tex(q.expr))",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", q.expr),
                "The function is continuous at x = $(a), so substitute directly",
                sol("Substituting x = $(a)", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # Limit with factoring (removable discontinuity)
        r = randint(-10, 10)
        a = nonzero(-5, 5)
        b = randint(-12, 12)
        
        numerator = expand(a * (x - r) * (x - b))
        denominator = x - r
        ans = substitute(a * (x - b), x => r)
        
        problem(
            question="Evaluate \\lim_{x \\to $(r)} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor numerator: $(tex(a * (x - r) * (x - b)))",
                "Cancel common factor (x - $(r)): $(tex(a * (x - b)))",
                sol("Substitute x = $(r)", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Limit with rationalization (conjugate)
        a = randint(1, 20)
        h_sym = choice([:h, :x])
        @variables h
        var = h_sym == :h ? h : x
        
        numerator = sqrt(a + var) - sqrt(a)
        ans = 1 // (2 * sqrt(a))
        
        limit_expr = h_sym == :h ? "h \\to 0" : "x \\to 0"
        
        problem(
            question="Evaluate \\lim_{$(limit_expr)} \\frac{$(tex(numerator))}{$(tex(var))}",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Multiply by conjugate: \\frac{\\sqrt{$(a) + $(h_sym)} + \\sqrt{$(a)}}{\\sqrt{$(a) + $(h_sym)} + \\sqrt{$(a)}}",
                "Numerator becomes: $(a) + $(h_sym) - $(a) = $(h_sym)",
                "Simplify: \\frac{1}{\\sqrt{$(a) + $(h_sym)} + \\sqrt{$(a)}}",
                sol("Substitute $(h_sym) = 0", ans)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Limit with polynomial division
        r1 = randint(-8, 8)
        r2 = randint(-8, 8)
        while r2 == r1
            r2 = randint(-8, 8)
        end
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        numerator = expand(a * (x - r1) * (x - r2))
        denominator = expand(b * (x - r1))
        ans = substitute(a * (x - r2) // b, x => r1)
        
        problem(
            question="Evaluate \\lim_{x \\to $(r1)} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor numerator: $(tex(a * (x - r1) * (x - r2)))",
                "Factor denominator: $(tex(b * (x - r1)))",
                "Cancel (x - $(r1)): \\frac{$(tex(a * (x - r2)))}{$(b)}",
                sol("Substitute x = $(r1)", ans)
            ),
            time=120
        )
        
    else
        # Limit with complex rational expression
        r = randint(-6, 6)
        a = nonzero(-6, 6)
        b = randint(-10, 10)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        
        numerator = expand(a * (x - r) * (x - b))
        denominator = expand(c * (x - r) * (x - d))
        
        ans = substitute((a * (x - b)) / (c * (x - d)), x => r)
        
        problem(
            question="Evaluate \\lim_{x \\to $(r)} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor numerator: $(tex(a * (x - r) * (x - b)))",
                "Factor denominator: $(tex(c * (x - r) * (x - d)))",
                "Cancel common factor (x - $(r)): \\frac{$(tex(a * (x - b)))}{$(tex(c * (x - d)))}",
                sol("Substitute x = $(r)", ans)
            ),
            time=150
        )
    end
end