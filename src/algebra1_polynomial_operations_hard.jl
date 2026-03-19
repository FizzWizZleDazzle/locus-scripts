# algebra1 - polynomial_operations (hard)
# Generated: 2026-03-08T19:59:28.955055

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/polynomial_operations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Polynomial multiplication with higher degrees (1800-2100)
        deg1 = rand(2:4)
        deg2 = rand(2:3)
        
        p1 = rand_poly(x, deg1; coeff=(-8, 8))
        p2 = rand_poly(x, deg2; coeff=(-6, 6))
        
        product = expand(p1.expr * p2.expr)
        
        problem(
            question="Expand and simplify: \$($(tex(p1.expr)))($(tex(p2.expr)))\$",
            answer=product,
            difficulty=(1800, 2100),
            solution=steps(
                sol("Given product", p1.expr * p2.expr),
                "Apply distributive property to multiply each term",
                "Combine like terms",
                sol("Answer", product)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Polynomial division with remainder (1900-2200)
        divisor_deg = rand(1:2)
        quotient_deg = rand(2:3)
        
        divisor_roots = [nonzero(-10, 10) for _ in 1:divisor_deg]
        divisor = prod(x - r for r in divisor_roots)
        divisor = expand(divisor)
        
        q = rand_poly(x, quotient_deg; coeff=(-7, 7))
        remainder = randint(-20, 20)
        
        dividend = expand(divisor * q.expr + remainder)
        
        problem(
            question="Divide \$$(tex(dividend))\$ by \$$(tex(divisor))\$ and express in the form \$Q(x) + \\frac{R}{$(tex(divisor))}\$ where \$R\$ is a constant.",
            answer="$(tex(q.expr)) + \\frac{$(remainder)}{$(tex(divisor))}",
            difficulty=(1900, 2200),
            grading_mode="symbolic",
            solution=steps(
                sol("Dividend", dividend),
                sol("Divisor", divisor),
                "Perform polynomial long division",
                sol("Quotient", q.expr),
                sol("Remainder", remainder),
                "Answer: \$$(tex(q.expr)) + \\frac{$(remainder)}{$(tex(divisor))}\$"
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Composition of polynomials (2000-2300)
        inner = rand_quadratic(x; a=(-4, 4), b=(-6, 6), c=(-8, 8))
        outer_deg = rand(2:3)
        outer = rand_poly(x, outer_deg; coeff=(-5, 5))
        
        composition = substitute(outer.expr, x => inner.expr)
        composition = expand(composition)
        
        problem(
            question="Let \$f(x) = $(tex(outer.expr))\$ and \$g(x) = $(tex(inner.expr))\$. Find \$f(g(x))\$ in expanded form.",
            answer=composition,
            difficulty=(2000, 2300),
            solution=steps(
                sol("f(x)", outer.expr),
                sol("g(x)", inner.expr),
                "Substitute \$g(x)\$ into \$f(x)\$",
                sol("f(g(x))", substitute(outer.expr, x => inner.expr)),
                "Expand all terms",
                sol("Answer", composition)
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Finding polynomial given roots and conditions (2100-2400)
        r1, r2, r3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        while r1 == r2 || r2 == r3 || r1 == r3
            r1, r2, r3 = nonzero(-8, 8), nonzero(-8, 8), nonzero(-8, 8)
        end
        
        point_x = nonzero(-6, 6)
        while point_x in [r1, r2, r3]
            point_x = nonzero(-6, 6)
        end
        point_y = nonzero(-30, 30)
        
        base_poly = expand((x - r1) * (x - r2) * (x - r3))
        eval_base = substitute(base_poly, x => point_x)
        
        a_coeff = point_y // eval_base
        answer_poly = expand(simplify(a_coeff * base_poly))
        
        problem(
            question="Find the cubic polynomial \$P(x)\$ with roots at \$x = $(r1), $(r2), $(r3)\$ such that \$P($(point_x)) = $(point_y)\$. Express in standard form.",
            answer=answer_poly,
            difficulty=(2100, 2400),
            solution=steps(
                "Start with \$P(x) = a(x - $(r1))(x - $(r2))(x - $(r3))\$",
                sol("Base polynomial", base_poly),
                "Use condition \$P($(point_x)) = $(point_y)\$",
                "Calculate \$a = \\frac{$(point_y)}{$(eval_base)} = $(a_coeff)\$",
                sol("Answer", answer_poly)
            ),
            time=270
        )
        
    else
        # Polynomial with parametric coefficient (2200-2500)
        @variables k
        
        p1 = rand_quadratic(x; a=(-5, 5), b=(-8, 8), c=(-10, 10))
        p2 = rand_linear(x; a=(-6, 6), b=(-8, 8))
        
        result = expand(p1.expr + k * p2.expr)
        target_coeff_power = 1
        
        coeff_of_x = p1.b + k * p2.a
        k_value = solve(coeff_of_x ~ 0, k)[1]
        
        final_poly = substitute(result, k => k_value)
        
        problem(
            question="Consider the polynomial \$P(x) = $(tex(p1.expr)) + k($(tex(p2.expr)))\$ where \$k\$ is a real parameter. Find the value of \$k\$ such that the coefficient of \$x\$ in \$P(x)\$ is zero, and determine the resulting polynomial.",
            answer=final_poly,
            difficulty=(2200, 2500),
            solution=steps(
                sol("Given polynomial", result),
                "Identify coefficient of \$x\$: \$$(tex(coeff_of_x))\$",
                "Set coefficient equal to zero and solve for \$k\$",
                sol("k", k_value),
                "Substitute back into polynomial",
                sol("Answer", final_poly)
            ),
            time=300
        )
    end
end