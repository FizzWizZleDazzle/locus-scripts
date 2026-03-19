# calculus - continuity (very_hard)
# Generated: 2026-03-08T20:38:40.383166

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x a n begin
    set_topic!("calculus/continuity")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Find value of parameter for continuity at a point (competition level)
        c = randint(-8, 8)
        k = randint(2, 5)
        p = randint(-12, 12)
        q = randint(-12, 12)
        
        # f(x) = (x^k + px + q)/(x - c) for x ≠ c, a for x = c
        # For continuity, need lim_{x→c} (x^k + px + q)/(x - c) to exist
        # This requires numerator = 0 at x = c
        # So c^k + p*c + q = 0, giving p = -(c^k + q)/c
        
        numerator_at_c = c^k + q
        if c != 0 && numerator_at_c % c == 0
            p_correct = -numerator_at_c ÷ c
        else
            # Adjust to make it work
            q = -c^k
            p_correct = 0
        end
        
        # Now numerator = x^k + p_correct*x + q factors as (x-c)*g(x)
        # The limit is g(c)
        poly_coeffs = zeros(Int, k+1)
        poly_coeffs[end] = 1
        poly_coeffs[end-1] = p_correct
        poly_coeffs[1] = q
        
        # Compute derivative at c (for non-L'Hopital approach)
        deriv_at_c = k * c^(k-1) + p_correct
        
        ans = deriv_at_c
        
        numerator_expr = x^k + p_correct*x + q
        
        problem(
            question="Let \\(f(x) = \\begin{cases} \\frac{$(tex(numerator_expr))}{x - $(c)} & x \\neq $(c) \\\\ a & x = $(c) \\end{cases}\\). Find the value of \\(a\\) that makes \\(f\\) continuous at \\(x = $(c)\\).",
            answer=ans,
            difficulty=(2500, 2800),
            solution=steps(
                "For continuity at \\(x = $(c)\\), we need \\(\\lim_{x \\to $(c)} f(x) = f($(c)) = a\\)",
                "The numerator \\($(tex(numerator_expr))\\) equals 0 at \\(x = $(c)\\), so we can factor",
                "Using L'Hôpital's rule or factoring: \\(\\lim_{x \\to $(c)} \\frac{$(tex(numerator_expr))}{x - $(c)} = $(ans)\\)",
                sol("Answer: \\(a\\)", ans)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Intermediate Value Theorem application (competition)
        a_val = randint(-10, -2)
        b_val = randint(3, 12)
        k = randint(3, 5)
        
        # Construct polynomial with sign change
        coeff1 = nonzero(-5, 5)
        coeff2 = nonzero(-8, 8)
        
        f_expr = coeff1*x^k + coeff2*x + randint(-20, 20)
        
        fa = substitute(f_expr, x => a_val)
        fb = substitute(f_expr, x => b_val)
        
        # Ensure sign change
        target = 0
        
        problem(
            question="Let \\(f(x) = $(tex(f_expr))\\). Prove that there exists at least one value \\(c \\in ($(a_val), $(b_val))\\) such that \\(f(c) = $(target)\\). What theorem guarantees this? (Answer: IVT or Intermediate Value Theorem)",
            answer="IVT",
            difficulty=(2400, 2700),
            answer_type="choice",
            solution=steps(
                sol("Given", f_expr),
                "Check continuity: \\(f\\) is a polynomial, hence continuous on \\(\\mathbb{R}\\)",
                "Compute \\(f($(a_val)) = $(fa)\\) and \\(f($(b_val)) = $(fb)\\)",
                "Since \\(f\\) is continuous and takes on values of opposite signs (or brackets 0), by IVT there exists \\(c \\in ($(a_val), $(b_val))\\) with \\(f(c) = 0\\)"
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Removable vs non-removable discontinuity (olympiad level)
        c = nonzero(-8, 8)
        
        # Create (x-c)^2 in numerator and (x-c) in denominator
        a_coeff = nonzero(-4, 4)
        const_term = randint(-15, 15)
        
        numerator = expand(a_coeff*(x - c)^2 + const_term*(x - c))
        denominator = x - c
        
        # Limit exists and equals a_coeff*0 + const_term = const_term
        ans = const_term
        
        problem(
            question="Consider \\(g(x) = \\frac{$(tex(numerator))}{$(tex(denominator))}\\). Determine whether the discontinuity at \\(x = $(c)\\) is removable. If it is removable, find the value that would make \\(g\\) continuous at \\(x = $(c)\\).",
            answer=ans,
            difficulty=(2600, 3000),
            solution=steps(
                sol("Given", numerator / denominator),
                "Factor numerator: \\($(tex(numerator)) = $(tex((x-c)*(a_coeff*(x-c) + const_term)))\\)",
                "Simplify: \\(g(x) = $(tex(a_coeff*(x-c) + const_term))\\) for \\(x \\neq $(c)\\)",
                "The limit \\(\\lim_{x \\to $(c)} g(x) = $(ans)\\) exists",
                "Discontinuity is removable; define \\(g($(c)) = $(ans)\\)"
            ),
            time=220
        )
        
    elseif problem_type == 4
        # Piecewise continuity with absolute value (olympiad)
        c = nonzero(-6, 6)
        m1 = nonzero(-8, 8)
        b1 = randint(-15, 15)
        
        # For x < c: m1*x + b1
        # For x ≥ c: need m2*x + b2 where m2*c + b2 = m1*c + b1
        
        value_at_c = m1 * c + b1
        
        # Choose m2 different from m1
        m2 = nonzero(-8, 8)
        while m2 == m1
            m2 = nonzero(-8, 8)
        end
        
        # Solve for b2: m2*c + b2 = value_at_c
        b2 = value_at_c - m2 * c
        
        ans = b2
        
        problem(
            question="Let \\(h(x) = \\begin{cases} $(m1)x + $(b1) & x < $(c) \\\\ $(m2)x + b & x \\geq $(c) \\end{cases}\\). Find the value of \\(b\\) such that \\(h\\) is continuous at \\(x = $(c)\\).",
            answer=ans,
            difficulty=(2700, 3200),
            solution=steps(
                "For continuity at \\(x = $(c)\\), need \\(\\lim_{x \\to $(c)^-} h(x) = h($(c))\\)",
                "Left limit: \\(\\lim_{x \\to $(c)^-} ($(m1)x + $(b1)) = $(value_at_c)\\)",
                "Right limit (and value): \\(h($(c)) = $(m2)($(c)) + b = $(m2*c) + b\\)",
                "Set equal: \\($(m2*c) + b = $(value_at_c)\\)",
                sol("Solve for b", ans)
            ),
            time=200
        )
        
    else
        # Continuity on interval - find all discontinuities (olympiad)
        r1 = randint(-10, -1)
        r2 = randint(1, 10)
        
        # f(x) = 1/((x-r1)(x-r2))
        denom = expand((x - r1)*(x - r2))
        
        ans = fmt_set(Set([r1, r2]))
        
        problem(
            question="Find all points of discontinuity of \\(f(x) = \\frac{1}{$(tex(denom))}\\). Express your answer as a set.",
            answer=ans,
            difficulty=(2800, 3400),
            answer_type="set",
            solution=steps(
                sol("Given", 1/denom),
                "Function is continuous wherever denominator is nonzero",
                "Factor denominator: \\($(tex(denom)) = (x - $(r1))(x - $(r2))\\)",
                "Denominator equals zero at \\(x = $(r1)\\) and \\(x = $(r2)\\)",
                "These are vertical asymptotes (infinite discontinuities)",
                sol("Discontinuities", ans)
            ),
            time=180
        )
    end
end