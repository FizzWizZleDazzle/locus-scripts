# calculus - lhopitals_rule (hard)
# Generated: 2026-03-08T20:44:19.511377

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/lhopitals_rule")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # 0/0 form: polynomial ratio
        root = randint(-8, 8)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = randint(-12, 12)
        d = randint(-12, 12)
        
        numerator = expand(a * (x - root) * (x - c))
        denominator = expand(b * (x - root) * (x - d))
        
        num_derivative = diff(numerator, x)
        denom_derivative = diff(denominator, x)
        
        ans = substitute(num_derivative, x => root) // substitute(denom_derivative, x => root)
        
        problem(
            question = "Evaluate \\displaystyle\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer = ans,
            difficulty = (1800, 2000),
            solution = steps(
                "Direct substitution gives \\frac{0}{0}, so apply L'Hôpital's Rule",
                sol("\\frac{d}{dx}[$(tex(numerator))]", num_derivative),
                sol("\\frac{d}{dx}[$(tex(denominator))]", denom_derivative),
                sol("\\lim_{x \\to $(root)} \\frac{$(tex(num_derivative))}{$(tex(denom_derivative))}", ans)
            ),
            time = 180
        )
        
    elseif problem_type == 2
        # ∞/∞ form: polynomial ratio
        n_deg = rand(2:4)
        d_deg = n_deg
        
        n_lead = nonzero(-6, 6)
        d_lead = nonzero(-6, 6)
        
        n_poly = rand_poly(x, n_deg; coeff=(-8, 8))
        d_poly = rand_poly(x, d_deg; coeff=(-8, 8))
        
        numerator = expand(n_lead * x^n_deg + n_poly.expr)
        denominator = expand(d_lead * x^d_deg + d_poly.expr)
        
        ans = n_lead // d_lead
        
        problem(
            question = "Evaluate \\displaystyle\\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer = ans,
            difficulty = (1900, 2100),
            solution = steps(
                "As x \\to \\infty, this gives \\frac{\\infty}{\\infty}, so apply L'Hôpital's Rule",
                sol("\\frac{d}{dx}[$(tex(numerator))]", diff(numerator, x)),
                sol("\\frac{d}{dx}[$(tex(denominator))]", diff(denominator, x)),
                "Continue applying L'Hôpital's Rule until degrees match",
                sol("Answer", ans)
            ),
            time = 240
        )
        
    elseif problem_type == 3
        # 0/0 with trig: sin(ax)/x or (1-cos(ax))/x^2
        a = nonzero(-5, 5)
        
        if rand(Bool)
            # sin(ax)/x form
            numerator_expr = "\\sin($(a)x)"
            denominator_expr = "x"
            ans = a
            
            problem(
                question = "Evaluate \\displaystyle\\lim_{x \\to 0} \\frac{$(numerator_expr)}{$(denominator_expr)}",
                answer = ans,
                difficulty = (2000, 2200),
                solution = steps(
                    "Direct substitution gives \\frac{0}{0}, so apply L'Hôpital's Rule",
                    "\\frac{d}{dx}[\\sin($(a)x)] = $(a)\\cos($(a)x)",
                    "\\frac{d}{dx}[x] = 1",
                    sol("\\lim_{x \\to 0} \\frac{$(a)\\cos($(a)x)}{1}", ans)
                ),
                time = 180
            )
        else
            # (1-cos(ax))/x^2 form
            ans = (a^2) // 2
            
            problem(
                question = "Evaluate \\displaystyle\\lim_{x \\to 0} \\frac{1 - \\cos($(a)x)}{x^2}",
                answer = ans,
                difficulty = (2100, 2300),
                solution = steps(
                    "Direct substitution gives \\frac{0}{0}, apply L'Hôpital's Rule",
                    "First application: \\lim_{x \\to 0} \\frac{$(a)\\sin($(a)x)}{2x}",
                    "Still \\frac{0}{0}, apply L'Hôpital's Rule again",
                    "Second application: \\lim_{x \\to 0} \\frac{$(a^2)\\cos($(a)x)}{2}",
                    sol("Answer", ans)
                ),
                time = 240
            )
        end
        
    elseif problem_type == 4
        # e^x polynomial ratio at infinity
        a = nonzero(-4, 4)
        n = rand(2:5)
        
        poly = rand_poly(x, n; coeff=(-6, 6))
        
        problem(
            question = "Evaluate \\displaystyle\\lim_{x \\to \\infty} \\frac{$(tex(poly.expr))}{e^{$(a)x}}",
            answer = 0,
            difficulty = (2000, 2200),
            solution = steps(
                "As x \\to \\infty, this gives \\frac{\\infty}{\\infty}, apply L'Hôpital's Rule",
                "Each application reduces polynomial degree by 1",
                "After $(n) applications, numerator becomes constant",
                "Exponential dominates in denominator",
                sol("Answer", 0)
            ),
            time = 240
        )
        
    elseif problem_type == 5
        # ln(x)/x^a at infinity
        a = rand(1:4)
        
        problem(
            question = "Evaluate \\displaystyle\\lim_{x \\to \\infty} \\frac{\\ln(x)}{x^{$(a)}}",
            answer = 0,
            difficulty = (1900, 2100),
            solution = steps(
                "As x \\to \\infty, this gives \\frac{\\infty}{\\infty}, apply L'Hôpital's Rule",
                "\\frac{d}{dx}[\\ln(x)] = \\frac{1}{x}",
                "\\frac{d}{dx}[x^{$(a)}] = $(a)x^{$(a-1)}",
                sol("\\lim_{x \\to \\infty} \\frac{1/x}{$(a)x^{$(a-1)}} = \\lim_{x \\to \\infty} \\frac{1}{$(a)x^{$(a)}}", 0)
            ),
            time = 180
        )
        
    else
        # Multiple applications needed: (x-a)^m / (x-a)^n where m > n
        root = randint(-6, 6)
        m = rand(3:5)
        n = rand(2:(m-1))
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        numerator = expand(a * (x - root)^m)
        denominator = expand(b * (x - root)^n)
        
        # After n applications, we get a(m)(m-1)...(m-n+1)(x-root)^(m-n) / (b*n!)
        coeff_num = a * prod([m - i for i in 0:(n-1)])
        coeff_denom = b * factorial(n)
        
        ans = 0  # Since m > n, limit is 0
        
        problem(
            question = "Evaluate \\displaystyle\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}",
            answer = ans,
            difficulty = (2200, 2400),
            solution = steps(
                "Direct substitution gives \\frac{0}{0}, apply L'Hôpital's Rule repeatedly",
                "After $(n) applications of L'Hôpital's Rule:",
                "Numerator degree reduces from $(m) to $(m-n)",
                "Denominator becomes constant",
                sol("\\lim_{x \\to $(root)} \\frac{$(tex(expand((x-root)^(m-n))))}{\\text{const}}", ans)
            ),
            time = 300
        )
    end
end