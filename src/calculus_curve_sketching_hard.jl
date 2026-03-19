# calculus - curve_sketching (hard)
# Generated: 2026-03-08T20:42:55.958083

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/curve_sketching")
    
    problem_type = choice([
        :inflection_points,
        :critical_points_classify,
        :intervals_concavity,
        :sketch_analysis,
        :max_min_on_interval,
        :asymptote_behavior
    ])
    
    if problem_type == :inflection_points
        # Generate polynomial with known inflection points
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c1 = randint(-8, 8)
        c2 = randint(-8, 8)
        # f(x) = a(x-c1)^3 + b(x-c2)^3 + constant
        # Inflection at x = c1 and x = c2
        const_term = randint(-15, 15)
        expr = expand(a*(x - c1)^3 + b*(x - c2)^3 + const_term)
        
        f_prime = diff(expr, x)
        f_double = diff(f_prime, x)
        
        inflection_pts = sort([c1, c2])
        
        problem(
            question = "Find all inflection points of \\(f(x) = $(tex(expr))\\). Enter your answer as a comma-separated list of x-coordinates.",
            answer = "$(inflection_pts[1]), $(inflection_pts[2])",
            difficulty = (1900, 2100),
            solution = steps(
                sol("f(x)", expr),
                sol("f'(x)", f_prime),
                sol("f''(x)", f_double),
                "Set \\(f''(x) = 0\\) and solve",
                "Verify sign change of \\(f''(x)\\) at each candidate",
                "Inflection points at \\(x = $(inflection_pts[1])\\) and \\(x = $(inflection_pts[2])\\)"
            ),
            time = 180
        )
        
    elseif problem_type == :critical_points_classify
        # Quartic with 3 critical points
        r1 = randint(-10, -2)
        r2 = randint(-1, 1)
        r3 = randint(2, 10)
        a = choice([-1, 1])
        
        # f'(x) = a(x-r1)(x-r2)(x-r3)
        f_prime_expr = a * (x - r1) * (x - r2) * (x - r3)
        f_prime_expanded = expand(f_prime_expr)
        
        # Integrate to get f(x)
        # For simplicity, construct the original function
        f_expr = expand(a * (x - r1) * (x - r2) * (x - r3) * x // 4 + randint(-20, 20))
        
        f_double = diff(f_prime_expanded, x)
        
        # Classify each critical point
        classifications = []
        for r in [r1, r2, r3]
            f_double_at_r = substitute(f_double, x => r)
            if f_double_at_r > 0
                push!(classifications, (r, "local minimum"))
            elseif f_double_at_r < 0
                push!(classifications, (r, "local maximum"))
            else
                push!(classifications, (r, "inconclusive"))
            end
        end
        
        answer_str = join(["x=$(c[1]): $(c[2])" for c in classifications], "; ")
        
        problem(
            question = "Given \\(f'(x) = $(tex(f_prime_expanded))\\), classify each critical point of \\(f(x)\\) as a local maximum, local minimum, or neither using the second derivative test.",
            answer = answer_str,
            difficulty = (1850, 2050),
            solution = steps(
                sol("f'(x)", f_prime_expanded),
                "Critical points where \\(f'(x) = 0\\): \\(x = $(r1), $(r2), $(r3)\\)",
                sol("f''(x)", f_double),
                "Evaluate \\(f''(x)\\) at each critical point",
                "If \\(f''(c) > 0\\): local min; if \\(f''(c) < 0\\): local max",
                answer_str
            ),
            time = 240
        )
        
    elseif problem_type == :intervals_concavity
        # Cubic with one inflection point
        a = nonzero(-4, 4)
        b = nonzero(-5, 5)
        infl_pt = randint(-8, 8)
        
        # f''(x) = a(x - infl_pt)
        f_double = a * (x - infl_pt)
        # f'(x) = a(x - infl_pt)^2/2 + b
        # f(x) = a(x - infl_pt)^3/6 + bx + c
        c = randint(-20, 20)
        f_expr = expand(a * (x - infl_pt)^3 // 6 + b * x + c)
        
        if a > 0
            concave_down = fmt_interval(-Inf, infl_pt, true, false)
            concave_up = fmt_interval(infl_pt, Inf, false, true)
        else
            concave_up = fmt_interval(-Inf, infl_pt, true, false)
            concave_down = fmt_interval(infl_pt, Inf, false, true)
        end
        
        problem(
            question = "For \\(f(x) = $(tex(f_expr))\\), determine the intervals where \\(f\\) is concave up and concave down.",
            answer = "Concave up: $(concave_up); Concave down: $(concave_down)",
            difficulty = (1800, 2000),
            solution = steps(
                sol("f(x)", f_expr),
                sol("f'(x)", diff(f_expr, x)),
                sol("f''(x)", simplify(diff(diff(f_expr, x), x))),
                "Find where \\(f''(x) = 0\\): \\(x = $(infl_pt)\\)",
                "Test sign of \\(f''(x)\\) on intervals",
                "Concave up: $(concave_up); Concave down: $(concave_down)"
            ),
            time = 200
        )
        
    elseif problem_type == :sketch_analysis
        # Rational function with vertical asymptote and hole
        hole_x = randint(-8, 8)
        va_x = randint(-10, 10)
        while va_x == hole_x
            va_x = randint(-10, 10)
        end
        
        a = nonzero(-4, 4)
        b = randint(-8, 8)
        
        # f(x) = a(x - b)(x - hole_x) / ((x - hole_x)(x - va_x))
        # Simplifies to a(x - b) / (x - va_x) with hole at hole_x
        numerator = expand(a * (x - b) * (x - hole_x))
        denominator = expand((x - hole_x) * (x - va_x))
        
        # Horizontal asymptote y = a (degree same)
        ha = a
        
        problem(
            question = "For \\(f(x) = \\frac{$(tex(numerator))}{$(tex(denominator))}\\), identify: (a) vertical asymptote(s), (b) hole(s), (c) horizontal asymptote.",
            answer = "VA: x=$(va_x); Hole: x=$(hole_x); HA: y=$(ha)",
            difficulty = (1900, 2200),
            solution = steps(
                "Factor numerator and denominator",
                "Numerator: \\($(tex(a*(x-b)*(x-hole_x)))\\)",
                "Denominator: \\($(tex((x-hole_x)*(x-va_x)))\\)",
                "Common factor \\((x - $(hole_x))\\) creates hole at \\(x = $(hole_x)\\)",
                "Simplified: \\(f(x) = \\frac{$(tex(a*(x-b)))}{$(tex(x-va_x))}\\)",
                "Vertical asymptote at \\(x = $(va_x)\\)",
                "Horizontal asymptote: \\(y = $(ha)\\) (degrees equal)",
                "VA: x=$(va_x); Hole: x=$(hole_x); HA: y=$(ha)"
            ),
            time = 220
        )
        
    elseif problem_type == :max_min_on_interval
        # Cubic on closed interval
        r1 = randint(-12, -3)
        r2 = randint(2, 12)
        a = choice([-1, 1, 2, -2])
        
        # f'(x) = a(x - r1)(x - r2)
        f_prime_factored = a * (x - r1) * (x - r2)
        f_prime_expanded = expand(f_prime_factored)
        
        # Integrate
        f_expr = expand(a * (x^3 // 3 - (r1 + r2) * x^2 // 2 + r1 * r2 * x) + randint(-10, 10))
        
        # Pick interval containing both critical points
        left = r1 - randint(2, 5)
        right = r2 + randint(2, 5)
        
        # Evaluate at endpoints and critical points
        candidates = [left, r1, r2, right]
        values = [substitute(f_expr, x => c) for c in candidates]
        
        max_val = maximum(values)
        min_val = minimum(values)
        max_x = candidates[findfirst(==(max_val), values)]
        min_x = candidates[findfirst(==(min_val), values)]
        
        problem(
            question = "Find the absolute maximum and minimum of \\(f(x) = $(tex(f_expr))\\) on \\([$(left), $(right)]\\).",
            answer = "Max: $(max_val) at x=$(max_x); Min: $(min_val) at x=$(min_x)",
            difficulty = (2000, 2300),
            solution = steps(
                sol("f(x)", f_expr),
                sol("f'(x)", f_prime_expanded),
                "Critical points: \\(x = $(r1), $(r2)\\)",
                "Evaluate at \\(x = $(left), $(r1), $(r2), $(right)\\)",
                "\\(f($(left)) = $(substitute(f_expr, x => left))\\)",
                "\\(f($(r1)) = $(substitute(f_expr, x => r1))\\)",
                "\\(f($(r2)) = $(substitute(f_expr, x => r2))\\)",
                "\\(f($(right)) = $(substitute(f_expr, x => right))\\)",
                "Max: $(max_val) at x=$(max_x); Min: $(min_val) at x=$(min_x)"
            ),
            time = 260
        )
        
    else # :asymptote_behavior
        # Rational with oblique asymptote
        # Degree of num = deg of den + 1
        a = nonzero(-3, 3)
        b = randint(-8, 8)
        c = randint(-8, 8)
        va_x = randint(-10, 10)
        
        # f(x) = (ax^2 + bx + c) / (x - va_x)
        # Oblique asymptote: y = ax + (av + b)
        numerator = expand(a * x^2 + b * x + c)
        denominator = x - va_x
        
        # Long division: ax^2 + bx + c divided by (x - va_x)
        # = ax + (av + b) + remainder/(x - va_x)
        quotient_slope = a
        quotient_intercept = a * va_x + b
        
        problem(
            question = "For \\(f(x) = \\frac{$(tex(numerator))}{$(tex(denominator))}\\), find the equation of the oblique asymptote and the vertical asymptote.",
            answer = "Oblique: y = $(quotient_slope)x + $(quotient_intercept); VA: x = $(va_x)",
            difficulty = (2100, 2400),
            solution = steps(
                sol("f(x)", numerator // denominator),
                "Use polynomial long division",
                "Divide \\($(tex(numerator))\\) by \\($(tex(denominator))\\)",
                "Quotient: \\($(quotient_slope)x + $(quotient_intercept)\\)",
                "Oblique asymptote: \\(y = $(quotient_slope)x + $(quotient_intercept)\\)",
                "Vertical asymptote where denominator = 0: \\(x = $(va_x)\\)",
                "Oblique: y = $(quotient_slope)x + $(quotient_intercept); VA: x = $(va_x)"
            ),
            time = 240
        )
    end
end