# calculus - definite_integrals (hard)
# Generated: 2026-03-08T20:47:34.830852

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/definite_integrals")
    
    problem_type = choice([
        "polynomial",
        "rational_decomposition",
        "trig_identity",
        "substitution_transform",
        "even_odd_symmetry",
        "piecewise_integral",
        "area_between_curves"
    ])
    
    if problem_type == "polynomial"
        # ELO 1800-2000: Higher degree polynomial with fractional bounds
        n = randint(4, 7)
        p = rand_poly(x, n; coeff=(-8, 8))
        
        # Choose interesting bounds (often involving fractions or negative values)
        a_num = randint(-12, 12)
        a_den = choice([1, 2, 3, 4])
        b_num = randint(a_num + 1, 20)
        b_den = choice([1, 2, 3, 4])
        a = a_num // a_den
        b = b_num // b_den
        
        antideriv_terms = []
        for i in 0:n
            coeff = p.coeffs[i+1]
            if coeff != 0
                push!(antideriv_terms, coeff * x^(i+1) / (i+1))
            end
        end
        antideriv = sum(antideriv_terms)
        
        val_b = substitute(antideriv, x => b)
        val_a = substitute(antideriv, x => a)
        ans = simplify(val_b - val_a)
        
        problem(
            question="Evaluate \\int_{$(tex(a))}^{$(tex(b))} $(tex(p.expr)) \\, dx",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given integral", p.expr),
                "Find antiderivative by power rule",
                sol("F(x)", antideriv),
                "Evaluate F($(tex(b))) - F($(tex(a)))",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == "rational_decomposition"
        # ELO 2000-2200: Partial fraction decomposition
        r1 = nonzero(-8, 8)
        r2 = nonzero(-8, 8)
        while r2 == r1
            r2 = nonzero(-8, 8)
        end
        
        # Create A/(x-r1) + B/(x-r2)
        A = nonzero(-6, 6)
        B = nonzero(-6, 6)
        
        numer = expand(A*(x - r2) + B*(x - r1))
        denom = expand((x - r1)*(x - r2))
        
        # Choose bounds that don't include poles
        a = min(r1, r2) - randint(5, 12)
        b = min(r1, r2) - randint(1, 4)
        
        # Answer: A*ln|b-r1| - A*ln|a-r1| + B*ln|b-r2| - B*ln|a-r2|
        # Simplify to A*ln|(b-r1)/(a-r1)| + B*ln|(b-r2)/(a-r2)|
        term1 = A * log(abs((b - r1) // (a - r1)))
        term2 = B * log(abs((b - r2) // (a - r2)))
        ans = term1 + term2
        
        problem(
            question="Evaluate \\int_{$(a)}^{$(b)} \\frac{$(tex(numer))}{$(tex(denom))} \\, dx",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "Use partial fraction decomposition",
                "\\frac{$(tex(numer))}{$(tex(denom))} = \\frac{$(A)}{x - $(r1)} + \\frac{$(B)}{x - $(r2)}",
                "Integrate each term: $(A)\\ln|x - $(r1)| + $(B)\\ln|x - $(r2)|",
                "Evaluate from $(a) to $(b)",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == "trig_identity"
        # ELO 1900-2100: Trigonometric integral requiring identity
        k = nonzero(-5, 5)
        m = choice([2, 4, 6])  # even power for sin^2 or cos^2 identity
        
        # Integral of sin^2(kx) from 0 to π/k or similar
        a = 0
        b_num = randint(1, 4) * π
        b = b_num / abs(k)
        
        # sin^2(kx) = (1 - cos(2kx))/2
        # Integral: x/2 - sin(2kx)/(4k)
        val_b = b/2 - sin(2*k*b)/(4*k)
        val_a = 0
        ans = simplify(val_b - val_a)
        
        problem(
            question="Evaluate \\int_{0}^{$(tex(b))} \\sin^2($(k)x) \\, dx",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Use identity: \\sin^2(u) = \\frac{1 - \\cos(2u)}{2}",
                "Rewrite: \\int \\frac{1 - \\cos($(2*k)x)}{2} \\, dx",
                "Antiderivative: \\frac{x}{2} - \\frac{\\sin($(2*k)x)}{$(4*k)}",
                "Evaluate from 0 to $(tex(b))",
                sol("Answer", ans)
            ),
            time=210
        )
        
    elseif problem_type == "substitution_transform"
        # ELO 2000-2200: u-substitution with transformation
        a_inner = nonzero(-8, 8)
        b_inner = nonzero(-8, 8)
        
        # Integral of x*(ax + b)^n dx
        n = randint(3, 6)
        inner = a_inner*x + b_inner
        
        # Choose bounds
        a = randint(-10, -1)
        b = randint(1, 10)
        
        # Antiderivative requires u-sub: u = ax+b, x = (u-b)/a, dx = du/a
        # ∫ x*u^n dx = ∫ ((u-b)/a) * u^n * (1/a) du
        # = (1/a^2) ∫ (u^(n+1) - b*u^n) du
        # = (1/a^2) [u^(n+2)/(n+2) - b*u^(n+1)/(n+1)]
        
        u_b = a_inner*b + b_inner
        u_a = a_inner*a + b_inner
        
        val_b = (u_b^(n+2)/(n+2) - b_inner*u_b^(n+1)/(n+1)) / (a_inner^2)
        val_a = (u_a^(n+2)/(n+2) - b_inner*u_a^(n+1)/(n+1)) / (a_inner^2)
        ans = simplify(val_b - val_a)
        
        problem(
            question="Evaluate \\int_{$(a)}^{$(b)} x($(tex(inner)))^{$(n)} \\, dx",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "Use substitution: u = $(tex(inner)), du = $(a_inner) dx",
                "Express x in terms of u: x = \\frac{u - $(b_inner)}{$(a_inner)}",
                "Transform integral and bounds",
                "Integrate with respect to u",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == "even_odd_symmetry"
        # ELO 1800-2000: Exploit even/odd function symmetry
        k = nonzero(-7, 7)
        n = choice([3, 5, 7])  # odd power
        
        # Integral of x^n * cos(kx) from -a to a (odd function times even = odd)
        a = randint(3, 15)
        
        # Since x^n is odd and cos is even, product is odd
        # Integral over symmetric interval is 0
        ans = 0
        
        problem(
            question="Evaluate \\int_{-$(a)}^{$(a)} x^{$(n)} \\cos($(k)x) \\, dx",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Recognize f(x) = x^{$(n)} \\cos($(k)x)",
                "x^{$(n)} is odd, \\cos($(k)x) is even",
                "Product of odd and even function is odd",
                "Integral of odd function over symmetric interval [-a, a] is zero",
                sol("Answer", 0)
            ),
            time=120
        )
        
    elseif problem_type == "piecewise_integral"
        # ELO 1900-2100: Piecewise function integral
        c = randint(-5, 5)  # breakpoint
        
        # Left piece: quadratic
        q1 = rand_quadratic(x; a=(-5, 5), b=(-8, 8), c=(-10, 10))
        # Right piece: linear
        l1 = rand_linear(x; a=(-8, 8), b=(-10, 10))
        
        a = c - randint(3, 8)
        b = c + randint(3, 8)
        
        # Integrate each piece
        anti1_terms = q1.a * x^3/3 + q1.b * x^2/2 + q1.c * x
        anti2_terms = l1.a * x^2/2 + l1.b * x
        
        int1 = substitute(anti1_terms, x => c) - substitute(anti1_terms, x => a)
        int2 = substitute(anti2_terms, x => b) - substitute(anti2_terms, x => c)
        ans = simplify(int1 + int2)
        
        problem(
            question="Evaluate \\int_{$(a)}^{$(b)} f(x) \\, dx where f(x) = \\begin{cases} $(tex(q1.expr)) & x < $(c) \\\\ $(tex(l1.expr)) & x \\geq $(c) \\end{cases}",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Split integral at x = $(c)",
                "\\int_{$(a)}^{$(c)} $(tex(q1.expr)) dx + \\int_{$(c)}^{$(b)} $(tex(l1.expr)) dx",
                "Evaluate each piece separately",
                "Sum the results",
                sol("Answer", ans)
            ),
            time=240
        )
        
    else  # area_between_curves
        # ELO 2100-2400: Area between two curves
        # Top curve: quadratic opening down
        r1 = randint(-8, -1)
        r2 = randint(1, 8)
        a_top = randint(-3, -1)
        top = expand(a_top * (x - r1) * (x - r2))
        
        # Bottom curve: line below it
        m = randint(-2, 2)
        offset = randint(5, 12)
        bottom = m*x - offset
        
        # Area = integral of (top - bottom) from r1 to r2
        diff_expr = expand(top - bottom)
        
        # Integrate
        coeff_2 = a_top
        coeff_1 = -a_top*(r1 + r2) - m
        coeff_0 = a_top*r1*r2 + offset
        
        anti = coeff_2*x^3/3 + coeff_1*x^2/2 + coeff_0*x
        
        val_r2 = substitute(anti, x => r2)
        val_r1 = substitute(anti, x => r1)
        ans = simplify(val_r2 - val_r1)
        
        problem(
            question="Find the area between y = $(tex(top)) and y = $(tex(bottom)) from x = $(r1) to x = $(r2)",
            answer=ans,
            difficulty=(2100, 2400),
            solution=steps(
                "Top curve: y = $(tex(top))",
                "Bottom curve: y = $(tex(bottom))",
                "Area = \\int_{$(r1)}^{$(r2)} [$(tex(top)) - ($(tex(bottom)))] dx",
                sol("Simplify", diff_expr),
                "Integrate and evaluate",
                sol("Answer", ans)
            ),
            time=270
        )
    end
end