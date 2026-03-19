# algebra1 - factoring_trinomials (competition)
# Generated: 2026-03-08T20:00:53.177395

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/factoring_trinomials")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Olympiad-level: Factor a polynomial with large coefficients and hidden structure
        # Create a polynomial that factors as (ax + b)(cx + d)(ex + f) with large coefficients
        a = nonzero(-8, 8)
        b = randint(-25, 25)
        c = nonzero(-7, 7)
        d = randint(-30, 30)
        e = nonzero(-6, 6)
        f = randint(-20, 20)
        
        factor1 = a*x + b
        factor2 = c*x + d
        factor3 = e*x + f
        
        expr = expand(factor1 * factor2 * factor3)
        
        # Create a more complex form by adding/subtracting strategically
        k = nonzero(-5, 5)
        modified = expand(expr + k*x^2) - k*x^2
        
        problem(
            question="Factor completely over the integers: \$$(tex(modified))\$",
            answer=modified,
            difficulty=(3500, 4200),
            grading_mode="factor",
            solution=steps(
                sol("Given", modified),
                "Group terms strategically to reveal common factors",
                "Factor 1: \$$(tex(factor1))\$",
                "Factor 2: \$$(tex(factor2))\$",
                "Factor 3: \$$(tex(factor3))\$",
                sol("Complete factorization", factor1 * factor2 * factor3)
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Factor a quartic with non-obvious grouping
        # Construct as (ax^2 + bx + c)(dx^2 + ex + f) with strategic coefficients
        a1 = nonzero(-6, 6)
        b1 = randint(-15, 15)
        c1 = nonzero(-20, 20)
        
        a2 = nonzero(-5, 5)
        b2 = randint(-18, 18)
        c2 = nonzero(-25, 25)
        
        quad1 = a1*x^2 + b1*x + c1
        quad2 = a2*x^2 + b2*x + c2
        
        expr = expand(quad1 * quad2)
        
        problem(
            question="Factor the quartic polynomial: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(3800, 4500),
            grading_mode="factor",
            solution=steps(
                sol("Given quartic", expr),
                "Apply Sophie Germain identity or strategic grouping",
                "Recognize this factors as product of two quadratics",
                sol("First quadratic factor", quad1),
                sol("Second quadratic factor", quad2),
                sol("Complete factorization", quad1 * quad2)
            ),
            time=360
        )
        
    elseif problem_type == 3
        # High olympiad: Factor with substitution required
        # Create x^4 + ax^2 + b that factors nicely after y = x^2 substitution
        r1 = nonzero(-12, 12)
        r2 = nonzero(-15, 15)
        
        # (y - r1)(y - r2) where y = x^2
        # = y^2 - (r1+r2)y + r1*r2
        # = x^4 - (r1+r2)x^2 + r1*r2
        
        a_coef = -(r1 + r2)
        b_coef = r1 * r2
        
        expr = x^4 + a_coef*x^2 + b_coef
        
        # Factor back: if r1 > 0, (x^2 - r1) factors further
        # This creates a biquadratic that requires substitution
        
        problem(
            question="Factor completely over the reals: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(3600, 4300),
            grading_mode="factor",
            solution=steps(
                sol("Given biquadratic", expr),
                "Let \$y = x^2\$, then we have: \$y^2 + $(a_coef)y + $(b_coef)\$",
                "Factor in y: \$(y - $(r1))(y - $(r2))\$",
                "Substitute back: \$(x^2 - $(r1))(x^2 - $(r2))\$",
                "Factor further over reals if roots are positive",
                sol("Complete factorization", expr)
            ),
            time=300
        )
        
    else
        # Research-adjacent: Factor a sextic with multiple techniques
        # Create (x^2 + a)(x^2 + b)(x^2 + c) with specific structure
        a_val = nonzero(-10, 10)
        b_val = nonzero(-12, 12)
        c_val = nonzero(-8, 8)
        
        factor1 = x^2 + a_val
        factor2 = x^2 + b_val
        factor3 = x^2 + c_val
        
        expr = expand(factor1 * factor2 * factor3)
        
        # Add complexity by factoring out leading coefficient if possible
        lead = nonzero(-3, 3)
        expr_scaled = expand(lead * expr)
        
        problem(
            question="Factor the sextic polynomial over the reals: \$$(tex(expr_scaled))\$",
            answer=expr_scaled,
            difficulty=(4000, 4800),
            grading_mode="factor",
            solution=steps(
                sol("Given sextic", expr_scaled),
                "Factor out leading coefficient: \$$(lead)\$",
                "Remaining sextic: \$$(tex(expr))\$",
                "Apply grouping or recognize as product of quadratics",
                sol("First factor", factor1),
                sol("Second factor", factor2),
                sol("Third factor", factor3),
                sol("Complete factorization", expr_scaled)
            ),
            time=420
        )
    end
end