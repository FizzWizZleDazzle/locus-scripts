# algebra1 - factoring_gcf (competition)
# Generated: 2026-03-08T20:00:29.454035

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/factoring_gcf")
    
    # For Olympiad/Research-Adjacent (3500-5000), we need extremely sophisticated GCF problems
    # that involve deep algebraic insight, non-obvious patterns, and creative factoring strategies
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Multi-variable polynomial with hidden GCF structure requiring substitution insight
        # Create a complex expression where the GCF emerges only after recognizing a pattern
        
        a = nonzero(-15, 15)
        b = nonzero(-15, 15)
        c = nonzero(-15, 15)
        
        m = randint(3, 7)
        n = randint(3, 7)
        k = randint(2, 5)
        
        # Create terms with a hidden common factor structure
        # Example: x^7*y^4 + x^5*y^6 + x^4*y^5 = x^4*y^4(x^3 + x*y^2 + y)
        
        base_exp_x = randint(4, 8)
        base_exp_y = randint(4, 8)
        base_exp_z = randint(3, 6)
        
        num_terms = randint(4, 6)
        
        terms = []
        term_strs = []
        
        gcf_coeff = abs(nonzero(-12, 12))
        
        for i in 1:num_terms
            coeff = gcf_coeff * nonzero(-8, 8)
            exp_x = base_exp_x + randint(0, 4)
            exp_y = base_exp_y + randint(0, 4)
            exp_z = base_exp_z + randint(0, 3)
            
            term = coeff * x^exp_x * y^exp_y * z^exp_z
            push!(terms, term)
            push!(term_strs, "$(coeff)x^{$(exp_x)}y^{$(exp_y)}z^{$(exp_z)}")
        end
        
        expr = sum(terms)
        
        gcf_str = "$(gcf_coeff)x^{$(base_exp_x)}y^{$(base_exp_y)}z^{$(base_exp_z)}"
        
        question = "Factor out the greatest common factor from: \$" * join(term_strs, " + ") * "\$"
        
        solution_text = steps(
            "Identify the coefficients: look for the GCD of the numerical coefficients",
            "For the variable x: minimum exponent is $(base_exp_x)",
            "For the variable y: minimum exponent is $(base_exp_y)",
            "For the variable z: minimum exponent is $(base_exp_z)",
            "The GCF is: \$$(gcf_str)\$",
            "Factor out the GCF and simplify each term",
            "Verify by expanding back to the original expression"
        )
        
        difficulty = (3500, 4200)
        time_limit = 240
        
    elseif problem_type == 2
        # Type 2: Nested factoring with strategic grouping insight
        # Requires recognizing that after factoring GCF, further factoring reveals structure
        
        p = nonzero(-8, 8)
        q = nonzero(-8, 8)
        r = nonzero(-8, 8)
        
        exp1 = randint(5, 9)
        exp2 = randint(4, 8)
        exp3 = randint(3, 7)
        
        gcf_exp = randint(3, 6)
        
        # Create something like: 6x^8 + 9x^7 - 15x^6 = 3x^6(2x^2 + 3x - 5)
        # But with much higher complexity
        
        gcf_coeff = abs(nonzero(4, 15))
        
        inner_a = nonzero(-10, 10)
        inner_b = nonzero(-10, 10)
        inner_c = nonzero(-10, 10)
        inner_d = nonzero(-10, 10)
        
        term1 = gcf_coeff * inner_a * x^(gcf_exp + 4) * y^(gcf_exp + 2)
        term2 = gcf_coeff * inner_b * x^(gcf_exp + 3) * y^(gcf_exp + 3)
        term3 = gcf_coeff * inner_c * x^(gcf_exp + 2) * y^(gcf_exp + 1)
        term4 = gcf_coeff * inner_d * x^(gcf_exp + 1) * y^(gcf_exp + 4)
        
        expr = term1 + term2 + term3 + term4
        
        question = "Factor completely by first extracting the GCF, then analyzing the remaining polynomial: \$$(tex(expr))\$"
        
        solution_text = steps(
            sol("Given", expr),
            "Identify minimum exponents: x has min exponent $(gcf_exp+1), y has min exponent $(gcf_exp+1)",
            "Numerical GCD of coefficients reveals common factor $(gcf_coeff)",
            "GCF is: \$$(gcf_coeff)x^{$(gcf_exp+1)}y^{$(gcf_exp+1)}\$",
            "Factor out and examine the quotient polynomial for additional structure",
            "The remaining polynomial may factor further depending on coefficient relationships",
            "Complete factorization requires checking for special patterns (difference of squares, trinomial forms)"
        )
        
        expr = "$(gcf_coeff)x^{$(gcf_exp+1)}y^{$(gcf_exp+1)}($(inner_a)x^3y + $(inner_b)x^2y^2 + $(inner_c)x + $(inner_d)y^3)"
        difficulty = (3800, 4500)
        time_limit = 300

    elseif problem_type == 3
        # Type 3: Abstract GCF problem with parametric constraints
        # Given constraints, find the GCF in terms of parameters
        
        k = randint(3, 8)
        m = randint(2, 6)
        n = randint(2, 6)
        
        alpha = randint(4, 10)
        beta = randint(3, 9)
        
        question = "Consider the polynomial \$P(x,y) = $(2*k)x^{$(alpha+3)}y^{$(beta+2)} + $(3*k)x^{$(alpha+1)}y^{$(beta+4)} - $(k)x^{$(alpha)}y^{$(beta)}\$. " *
                   "Determine the greatest common factor in factored form, and prove that no higher-degree GCF exists."
        
        gcf_result = "$(k)x^{$(alpha)}y^{$(beta)}"
        
        solution_text = steps(
            "Examine numerical coefficients: $(2*k), $(3*k), $(k) → GCD = $(k)",
            "For variable x: exponents are $(alpha+3), $(alpha+1), $(alpha) → minimum is $(alpha)",
            "For variable y: exponents are $(beta+2), $(beta+4), $(beta) → minimum is $(beta)",
            "Therefore GCF = \$$(gcf_result)\$",
            "After factoring out, we get: \$$(gcf_result)(2x^3y^2 + 3xy^4 - 1)\$",
            "To prove maximality: check that remaining terms share no common factors",
            "The terms 2x³y², 3xy⁴, and -1 are coprime in the polynomial ring",
            "Hence \$$(gcf_result)\$ is the unique greatest common factor"
        )
        
        expr = gcf_result
        difficulty = (4000, 4600)
        time_limit = 300

    else  # problem_type == 4
        # Type 4: GCF with substitution and recognition of higher-level patterns
        # Olympiad-style: requires seeing expr as composition of functions
        
        base = randint(3, 7)
        offset = nonzero(-5, 5)
        
        # Create something like: (x^2+3)^5 * 12y^4 + (x^2+3)^3 * 18y^6 - (x^2+3)^2 * 6y^3
        
        coeff1 = 12 * nonzero(-3, 3)
        coeff2 = 18 * nonzero(-3, 3)
        coeff3 = 6 * nonzero(-3, 3)
        
        power1 = randint(4, 6)
        power2 = randint(3, 5)
        power3 = randint(2, 4)
        
        min_power = minimum([power1, power2, power3])
        
        exp_y1 = randint(4, 7)
        exp_y2 = randint(5, 8)
        exp_y3 = randint(3, 6)
        
        min_y = minimum([exp_y1, exp_y2, exp_y3])
        
        gcd_coeff = gcd(abs(coeff1), gcd(abs(coeff2), abs(coeff3)))
        
        inner_expr = x^2 + offset
        
        question = "Let \$u = x^2 + $(offset)\$. Factor the GCF from: " *
                   "\$$(coeff1)u^{$(power1)}y^{$(exp_y1)} + $(coeff2)u^{$(power2)}y^{$(exp_y2)} + $(coeff3)u^{$(power3)}y^{$(exp_y3)}\$. " *
                   "Express your answer in terms of both u and the original variable x."
        
        gcf_factored = "$(gcd_coeff)u^{$(min_power)}y^{$(min_y)}"
        gcf_substituted = "$(gcd_coeff)(x^2 + $(offset))^{$(min_power)}y^{$(min_y)}"
        
        solution_text = steps(
            "Identify the GCD of numerical coefficients: gcd($(abs(coeff1)), $(abs(coeff2)), $(abs(coeff3))) = $(gcd_coeff)",
            "Minimum power of u across all terms: $(min_power)",
            "Minimum power of y across all terms: $(min_y)",
            "GCF in terms of u: \$$(gcf_factored)\$",
            "Substitute back \$u = x^2 + $(offset)\$",
            "GCF in original variables: \$$(gcf_substituted)\$",
            "Factor out to obtain: \$$(gcf_substituted) \\cdot \\text{(remaining polynomial)}\$",
            "Verification: expand the factored form to recover the original expression"
        )
        
        expr = gcf_substituted
        difficulty = (4200, 4800)
        time_limit = 360
    end

    problem(
        question=question,
        answer=expr,
        difficulty=difficulty,
        solution=solution_text,
        grading_mode="factor",
        time=time_limit
    )
end