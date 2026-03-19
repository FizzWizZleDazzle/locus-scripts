# algebra1 - factoring_gcf (very_hard)
# Generated: 2026-03-08T20:00:13.649997

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/factoring_gcf")
    
    # Competition to Olympiad level (2500-3500): Advanced GCF problems
    # involving high powers, multiple variables, and non-obvious factorizations
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Multi-variable polynomial with large coefficients and high powers
        # requiring recognition of disguised common factors
        
        # Choose a complex GCF with multiple variables
        gcf_coeff = choice([6, 10, 12, 15, 18, 20, 24, 30, 36, 40, 42, 48])
        gcf_x_pow = randint(3, 7)
        gcf_y_pow = randint(2, 5)
        gcf_z_pow = randint(1, 4)
        
        # Create terms with this GCF
        n_terms = randint(4, 6)
        terms = []
        term_strs = []
        
        for i in 1:n_terms
            coeff = gcf_coeff * nonzero(-8, 8)
            x_pow = gcf_x_pow + randint(0, 4)
            y_pow = gcf_y_pow + randint(0, 3)
            z_pow = gcf_z_pow + randint(0, 2)
            
            term = coeff * x^x_pow * y^y_pow * z^z_pow
            push!(terms, term)
            push!(term_strs, tex(term))
        end
        
        expr = sum(terms)
        gcf_expr = gcf_coeff * x^gcf_x_pow * y^gcf_y_pow * z^gcf_z_pow
        
        problem(
            question="Factor out the greatest common factor from \$$(tex(expr))\$",
            answer=expr,
            difficulty=(2500, 3000),
            grading_mode="factor",
            solution=steps(
                sol("Given expression", expr),
                "Identify the GCF of all coefficients: $(gcf_coeff)",
                "Find minimum powers: \$x^{$(gcf_x_pow)}\$, \$y^{$(gcf_y_pow)}\$, \$z^{$(gcf_z_pow)}\$",
                sol("GCF", gcf_expr),
                "Factor out the GCF to obtain the final factored form",
                sol("Answer", expr)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Nested factoring: factor out GCF, then recognize another pattern
        # (difference of squares or sum/difference of cubes in what remains)
        
        gcf_coeff = choice([4, 6, 8, 9, 12, 16, 18, 25])
        gcf_x_pow = randint(2, 5)
        
        # Create difference of squares after factoring GCF
        a = nonzero(-15, 15)
        b = nonzero(-15, 15)
        
        # expr = gcf * (a²x² - b²) = gcf * (ax - b)(ax + b)
        inner = a^2 * x^2 - b^2
        expr = expand(gcf_coeff * x^gcf_x_pow * inner)
        
        gcf_expr = gcf_coeff * x^gcf_x_pow
        final_factored = gcf_expr * (a*x - b) * (a*x + b)
        
        problem(
            question="Completely factor \$$(tex(expr))\$ by first finding the GCF, then factoring further",
            answer=final_factored,
            difficulty=(2800, 3200),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Factor out the GCF: \$$(tex(gcf_expr))\$",
                sol("After GCF", gcf_expr * inner),
                "Recognize difference of squares: \$($(tex(a*x)))^2 - $(b^2) = ($(tex(a*x)) - $(b))($(tex(a*x)) + $(b))\$",
                sol("Complete factorization", final_factored)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # GCF involving fractional coefficients (disguised as large numbers)
        # that simplify to reveal elegant structure
        
        # Create rational GCF
        gcf_num = choice([2, 3, 5, 7])
        gcf_den = choice([2, 3, 4, 5, 6])
        if gcf_num == gcf_den
            gcf_den = gcf_den + 1
        end
        
        gcf_x_pow = randint(4, 8)
        gcf_y_pow = randint(2, 6)
        
        n_terms = randint(3, 5)
        terms = []
        
        for i in 1:n_terms
            mult = nonzero(-12, 12)
            coeff_num = gcf_num * mult
            coeff = (coeff_num * gcf_den) // gcf_den  # Make integer coefficient
            x_pow = gcf_x_pow + randint(0, 3)
            y_pow = gcf_y_pow + randint(0, 3)
            
            term = coeff * x^x_pow * y^y_pow
            push!(terms, term)
        end
        
        expr = sum(terms)
        gcf_expr = (gcf_num // gcf_den) * x^gcf_x_pow * y^gcf_y_pow
        
        problem(
            question="Factor out the greatest common factor (including fractional coefficients if needed) from \$$(tex(expr))\$",
            answer=expr,
            difficulty=(2600, 3100),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Analyze coefficients for common rational factor: \$\\frac{$(gcf_num)}{$(gcf_den)}\$",
                "Identify minimum variable powers: \$x^{$(gcf_x_pow)}y^{$(gcf_y_pow)}\$",
                sol("GCF", gcf_expr),
                sol("Factored form", expr)
            ),
            time=270
        )
        
    else  # problem_type == 4
        # Olympiad-level: expression with hidden GCF requiring algebraic manipulation
        # Factor expression of form (x^a + b)(x^c + d) + k(x^a + b) where GCF is (x^a + b)
        
        a = randint(4, 8)
        b = nonzero(-20, 20)
        c = randint(3, 7)
        d = nonzero(-25, 25)
        k = nonzero(-15, 15)
        
        # GCF will be (x^a + b)
        factor1 = x^a + b
        factor2 = x^c + d
        
        # Construct: (x^a + b)(x^c + d) + k(x^a + b)
        expr = expand(factor1 * factor2 + k * factor1)
        final_factored = factor1 * (factor2 + k)
        
        problem(
            question="Factor completely by recognizing the common binomial factor in \$$(tex(expr))\$",
            answer=final_factored,
            difficulty=(3100, 3500),
            grading_mode="factor",
            solution=steps(
                sol("Given expression", expr),
                "Rewrite to identify structure: group terms strategically",
                "Notice that \$$(tex(factor1))\$ appears as a common factor",
                sol("Factor out", factor1),
                "Remaining factor: \$$(tex(factor2 + k))\$",
                sol("Complete factorization", final_factored)
            ),
            time=300
        )
    end
end