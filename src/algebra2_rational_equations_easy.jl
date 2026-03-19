# algebra2 - rational_equations (easy)
# Generated: 2026-03-08T20:16:10.801636

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/rational_equations")
    
    # Choose problem type
    prob_type = choice(1:4)
    
    if prob_type == 1
        # Simple rational equation: a/(x+b) = c, solve for x
        # ELO ~700-900
        a = nonzero(-15, 15)
        b = nonzero(-12, 12)
        c = nonzero(-8, 8)
        ans = (a // c) - b
        
        # Make sure denominator doesn't vanish at solution
        while abs(ans + b) < 0.01
            b = nonzero(-12, 12)
            ans = (a // c) - b
        end
        
        lhs = a / (x + b)
        
        problem(
            question = "Solve for \\(x\\): \\[$(tex(lhs)) = $(c)\\]",
            answer = ans,
            difficulty = (750, 900),
            solution = steps(
                sol("Given equation", lhs ~ c),
                "Multiply both sides by \\($(tex(x + b))\\): \\($(a) = $(c)($(tex(x + b)))\\)",
                "Expand: \\($(a) = $(tex(expand(c*(x + b))))\\)",
                "Solve for \\(x\\): \\($(tex(c*x)) = $(a - c*b)\\)",
                sol("Answer", ans)
            ),
            time = 90
        )
        
    elseif prob_type == 2
        # Equation with two rational terms: a/(x+b) + c/(x+d) = e
        # ELO ~900-1100
        b = nonzero(-10, 10)
        d = nonzero(-10, 10)
        while d == b
            d = nonzero(-10, 10)
        end
        
        # Pick a solution that doesn't make denominators zero
        ans = randint(-15, 15)
        while ans == -b || ans == -d
            ans = randint(-15, 15)
        end
        
        # Work backwards: pick a, c, then compute e
        a = nonzero(-8, 8)
        c = nonzero(-8, 8)
        e_val = substitute(a/(x+b) + c/(x+d), x => ans)
        
        lhs = a/(x+b) + c/(x+d)
        
        problem(
            question = "Solve for \\(x\\): \\[$(tex(lhs)) = $(tex(e_val))\\]",
            answer = ans,
            difficulty = (900, 1100),
            solution = steps(
                sol("Given equation", lhs ~ e_val),
                "Multiply both sides by \\($(tex((x+b)*(x+d)))\\) (the LCD)",
                "Simplify: \\($(a)($(tex(x+d))) + $(c)($(tex(x+b))) = $(tex(e_val * (x+b)*(x+d)))\\)",
                "Expand and collect like terms",
                "Solve the resulting linear or quadratic equation",
                sol("Answer", ans)
            ),
            time = 150
        )
        
    elseif prob_type == 3
        # Rational equation with x in numerator: (ax+b)/(x+c) = d
        # ELO ~800-1000
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        c = nonzero(-12, 12)
        d = nonzero(-7, 7)
        
        # Solve: ax + b = d(x + c) => ax + b = dx + dc => (a-d)x = dc - b
        if a == d
            # Pick different values to avoid infinite solutions
            a = nonzero(-8, 8)
            d = nonzero(-7, 7)
            while a == d
                d = nonzero(-7, 7)
            end
        end
        
        ans = (d*c - b) // (a - d)
        
        lhs = (a*x + b) / (x + c)
        
        problem(
            question = "Solve for \\(x\\): \\[$(tex(lhs)) = $(d)\\]",
            answer = ans,
            difficulty = (800, 1000),
            solution = steps(
                sol("Given equation", lhs ~ d),
                "Multiply both sides by \\($(tex(x + c))\\): \\($(tex(a*x + b)) = $(d)($(tex(x + c)))\\)",
                "Expand right side: \\($(tex(a*x + b)) = $(tex(expand(d*(x + c))))\\)",
                "Collect terms: \\($(tex((a-d)*x)) = $(d*c - b)\\)",
                sol("Answer", ans)
            ),
            time = 120
        )
        
    else  # prob_type == 4
        # Cross-multiplication: a/(x+b) = c/(x+d)
        # ELO ~850-1050
        b = nonzero(-10, 10)
        d = nonzero(-10, 10)
        while d == b
            d = nonzero(-10, 10)
        end
        
        a = nonzero(-12, 12)
        c = nonzero(-12, 12)
        
        # Solve: a(x+d) = c(x+b) => ax + ad = cx + cb => (a-c)x = cb - ad
        if a == c
            c = nonzero(-12, 12)
            while a == c
                c = nonzero(-12, 12)
            end
        end
        
        ans = (c*b - a*d) // (a - c)
        
        # Verify solution doesn't make denominators zero
        while abs(ans + b) < 0.01 || abs(ans + d) < 0.01
            b = nonzero(-10, 10)
            d = nonzero(-10, 10)
            while d == b
                d = nonzero(-10, 10)
            end
            ans = (c*b - a*d) // (a - c)
        end
        
        lhs = a / (x + b)
        rhs = c / (x + d)
        
        problem(
            question = "Solve for \\(x\\): \\[$(tex(lhs)) = $(tex(rhs))\\]",
            answer = ans,
            difficulty = (850, 1050),
            solution = steps(
                sol("Given equation", lhs ~ rhs),
                "Cross-multiply: \\($(a)($(tex(x+d))) = $(c)($(tex(x+b)))\\)",
                "Expand: \\($(tex(expand(a*(x+d)))) = $(tex(expand(c*(x+b))))\\)",
                "Collect like terms: \\($(tex((a-c)*x)) = $(c*b - a*d)\\)",
                sol("Answer", ans)
            ),
            time = 120
        )
    end
end