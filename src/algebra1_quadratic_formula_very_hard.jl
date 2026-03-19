# algebra1 - quadratic_formula (very_hard)
# Generated: 2026-03-08T20:01:22.607998

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/quadratic_formula")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # COMPETITION: Quadratic with two irrational roots requiring deep algebraic manipulation
        # ELO: 2500-2800
        a = nonzero(-3, 3)
        p = nonzero(-15, 15)
        q = nonzero(-15, 15)
        while p^2 - 4*a*q < 0 || isqrt(p^2 - 4*a*q)^2 == p^2 - 4*a*q
            p = nonzero(-15, 15)
            q = nonzero(-15, 15)
        end
        
        expr = a*x^2 + p*x + q
        disc = p^2 - 4*a*q
        
        r1 = (-p + sqrt(disc)) / (2*a)
        r2 = (-p - sqrt(disc)) / (2*a)
        
        sum_roots = -p/a
        prod_roots = q/a
        
        problem(
            question="Let \\(\\alpha\\) and \\(\\beta\\) be the roots of \\($(tex(expr)) = 0\\). Find the value of \\(\\alpha^3 + \\beta^3\\).",
            answer=rationalize(sum_roots^3 - 3*sum_roots*prod_roots),
            difficulty=(2500, 2800),
            solution=steps(
                sol("Given", expr ~ 0),
                "By Vieta's formulas: \\(\\alpha + \\beta = $(tex(-p/a))\\) and \\(\\alpha\\beta = $(tex(q/a))\\)",
                "Use identity: \\(\\alpha^3 + \\beta^3 = (\\alpha + \\beta)^3 - 3\\alpha\\beta(\\alpha + \\beta)\\)",
                sol("Compute", "\\(\\alpha^3 + \\beta^3 = ($(tex(-p/a)))^3 - 3($(tex(q/a)))($(tex(-p/a)))\\)"),
                sol("Answer", rationalize(sum_roots^3 - 3*sum_roots*prod_roots))
            ),
            time=240
        )
        
    elseif problem_type == 2
        # COMPETITION-OLYMPIAD: Symmetric function of roots
        # ELO: 2700-3200
        a = nonzero(-4, 4)
        b = nonzero(-20, 20)
        c = nonzero(-20, 20)
        
        expr = a*x^2 + b*x + c
        
        sum_roots = -b/a
        prod_roots = c/a
        
        # Compute 1/α + 1/β = (α + β)/(αβ)
        result = sum_roots / prod_roots
        
        problem(
            question="If \\(r\\) and \\(s\\) are the roots of \\($(tex(expr)) = 0\\), find \\(\\frac{1}{r} + \\frac{1}{s}\\).",
            answer=rationalize(result),
            difficulty=(2700, 3200),
            solution=steps(
                sol("Given", expr ~ 0),
                "By Vieta's formulas: \\(r + s = $(tex(-b/a))\\) and \\(rs = $(tex(c/a))\\)",
                "Use: \\(\\frac{1}{r} + \\frac{1}{s} = \\frac{r+s}{rs}\\)",
                sol("Substitute", "\\(\\frac{1}{r} + \\frac{1}{s} = \\frac{$(tex(-b/a))}{$(tex(c/a))}\\)"),
                sol("Answer", rationalize(result))
            ),
            time=180
        )
        
    elseif problem_type == 3
        # OLYMPIAD: Nested quadratic composition
        # ELO: 3000-3500
        p = nonzero(-8, 8)
        q = nonzero(-12, 12)
        
        # First solve inner quadratic x^2 + px + q = 0
        disc1 = p^2 - 4*q
        while disc1 <= 0 || isqrt(disc1)^2 == disc1
            p = nonzero(-8, 8)
            q = nonzero(-12, 12)
            disc1 = p^2 - 4*q
        end
        
        r = nonzero(-6, 6)
        
        # We want roots of y^2 + py + q = r
        # So y^2 + py + (q-r) = 0
        disc2 = p^2 - 4*(q - r)
        
        # Count total real solutions
        count = 0
        if disc2 >= 0
            y1 = (-p + sqrt(disc2)) / 2
            y2 = (-p - sqrt(disc2)) / 2
            
            # For each y, check if x^2 + px + q = y has real solutions
            disc_y1 = p^2 - 4*(q - y1)
            disc_y2 = p^2 - 4*(q - y2)
            
            if disc_y1 >= 0
                count += 2
            end
            if disc_y2 >= 0 && abs(y1 - y2) > 0.0001
                count += 2
            end
        end
        
        problem(
            question="How many real solutions does the equation \\((x^2 + $(tex(p))x + $(tex(q)))^2 + $(tex(p))(x^2 + $(tex(p))x + $(tex(q))) + $(tex(q)) = $(r)\\) have?",
            answer=count,
            difficulty=(3000, 3500),
            solution=steps(
                "Let \\(y = x^2 + $(tex(p))x + $(tex(q))\\)",
                sol("Transform", "y^2 + $(tex(p))y + $(tex(q)) = $(r)"),
                "Solve for \\(y\\): \\(y^2 + $(tex(p))y + $(tex(q-r)) = 0\\)",
                "Discriminant: \\(\\Delta_y = $(p^2) - 4($(q-r)) = $(disc2)\\)",
                "For each real \\(y\\), solve \\(x^2 + $(tex(p))x + $(tex(q)) = y\\) and count real roots",
                sol("Answer", count)
            ),
            time=300
        )
        
    else
        # COMPETITION: Quadratic with parameter constraint
        # ELO: 2600-3000
        m = nonzero(-10, 10)
        n = nonzero(-15, 15)
        
        # ax^2 + (2m)x + (m^2 + n) = 0
        # For equal roots: discriminant = 0
        # (2m)^2 - 4a(m^2 + n) = 0
        # 4m^2 - 4a*m^2 - 4a*n = 0
        # m^2(1 - a) = a*n
        # a = m^2 / (m^2 + n)
        
        if m^2 + n != 0
            a_value = m^2 / (m^2 + n)
        else
            a_value = 1
        end
        
        problem(
            question="For what value of \\(a\\) does the equation \\(ax^2 + $(tex(2*m))x + $(tex(m^2 + n)) = 0\\) have exactly one real solution?",
            answer=rationalize(a_value),
            difficulty=(2600, 3000),
            solution=steps(
                sol("Given", "ax^2 + $(tex(2*m))x + $(tex(m^2 + n)) = 0"),
                "For one real solution, discriminant must equal zero",
                sol("Set discriminant", "($(tex(2*m)))^2 - 4a($(tex(m^2 + n))) = 0"),
                "Simplify: \\($(tex(4*m^2)) - $(tex(4*(m^2 + n)))a = 0\\)",
                sol("Solve for a", rationalize(a_value))
            ),
            time=200
        )
    end
end