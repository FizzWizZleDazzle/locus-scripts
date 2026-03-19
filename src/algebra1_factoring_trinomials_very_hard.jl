# algebra1 - factoring_trinomials (very_hard)
# Generated: 2026-03-08T20:00:42.569126

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_trinomials")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition-level: Factor polynomial with large coefficients and nested structure
        # ELO 2500-2800: Requires recognizing Sophie Germain identity or sum/difference of powers
        r1 = randint(-15, 15)
        r2 = randint(-15, 15)
        r3 = randint(-15, 15)
        while r1 == r2 || r2 == r3 || r1 == r3
            r2 = randint(-15, 15)
            r3 = randint(-15, 15)
        end
        
        a = nonzero(-5, 5)
        # Create (x - r1)(x - r2)(x - r3)
        expr = expand(a * (x - r1) * (x - r2) * (x - r3))
        factored = a * (x - r1) * (x - r2) * (x - r3)
        
        problem(
            question="Factor completely: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(2500, 2800),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "This is a cubic polynomial. Look for rational roots using the Rational Root Theorem.",
                "Test possible roots: factors of the constant term divided by factors of the leading coefficient.",
                "Finding roots: \$x = $(r1), $(r2), $(r3)\$",
                sol("Factored form", factored)
            ),
            time=240,
        )
        
    elseif problem_type == 2
        # Olympiad-level: Factoring with constraints or special forms
        # ELO 3000-3300: Recognize x^4 + 4a^4 = (x^2 + 2ax + 2a^2)(x^2 - 2ax + 2a^2)
        k = nonzero(-8, 8)
        a_val = abs(k)
        
        # Create x^4 + 4a^4 form
        expr = x^4 + 4*a_val^4
        factor1 = x^2 + 2*a_val*x + 2*a_val^2
        factor2 = x^2 - 2*a_val*x + 2*a_val^2
        
        problem(
            question="Factor over the reals: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(3000, 3300),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "Recognize Sophie Germain identity: \$a^4 + 4b^4 = (a^2 + 2ab + 2b^2)(a^2 - 2ab + 2b^2)\$",
                "Here \$a = x\$ and \$b = $(a_val)\$",
                "Apply the identity:",
                sol("Factored form", factor1 * factor2)
            ),
            time=300,
        )
        
    elseif problem_type == 3
        # Competition-level: Multivariate factoring requiring substitution
        # ELO 2600-2900: Factor expressions like x^4 + x^2 + 1
        # Create x^4 + bx^2 + c that factors nicely
        m = randint(2, 8)
        n = randint(2, 8)
        while m == n
            n = randint(2, 8)
        end
        
        # (x^2 + mx + n)(x^2 - mx + n) = x^4 + (2n - m^2)x^2 + n^2
        b_coeff = 2*n - m^2
        c_coeff = n^2
        
        expr = x^4 + b_coeff*x^2 + c_coeff
        factor1 = x^2 + m*x + n
        factor2 = x^2 - m*x + n
        
        problem(
            question="Factor completely over the reals: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(2600, 2900),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "This is a biquadratic. Let \$u = x^2\$, so the expression becomes \$u^2 + $(b_coeff)u + $(c_coeff)\$",
                "Factor in terms of \$u\$: find two numbers that multiply to $(c_coeff) and add to $(b_coeff)",
                "Back-substitute \$u = x^2\$ and factor further as difference/sum patterns",
                sol("Factored form", factor1 * factor2)
            ),
            time=270,
        )
        
    else
        # Olympiad-level: Cyclotomic-like polynomial or advanced identity
        # ELO 3200-3500: Factor x^n - 1 or similar with non-obvious factorizations
        n = choice([5, 6, 7, 8])
        
        if n == 5
            # x^5 - 1 = (x - 1)(x^4 + x^3 + x^2 + x + 1)
            expr = x^5 - 1
            factor1 = x - 1
            factor2 = x^4 + x^3 + x^2 + x + 1
            desc = "cyclotomic polynomial of order 5"
        elseif n == 6
            # x^6 - 1 = (x - 1)(x + 1)(x^2 - x + 1)(x^2 + x + 1)
            expr = x^6 - 1
            factor1 = (x - 1)*(x + 1)
            factor2 = (x^2 - x + 1)*(x^2 + x + 1)
            desc = "cyclotomic factorization using x^6 - 1 = (x^3 - 1)(x^3 + 1)"
        elseif n == 7
            # x^7 - 1 = (x - 1)(x^6 + x^5 + x^4 + x^3 + x^2 + x + 1)
            expr = x^7 - 1
            factor1 = x - 1
            factor2 = x^6 + x^5 + x^4 + x^3 + x^2 + x + 1
            desc = "cyclotomic polynomial of order 7"
        else
            # x^8 - 1
            expr = x^8 - 1
            factor1 = (x - 1)*(x + 1)
            factor2 = (x^2 + 1)*(x^4 + 1)
            desc = "repeated difference of squares"
        end
        
        problem(
            question="Factor completely over the reals: \$$(tex(expr))\$",
            answer=expr,
            difficulty=(3200, 3500),
            grading_mode="factor",
            solution=steps(
                sol("Given", expr),
                "This is a $(desc).",
                "Factor out \$(x - 1)\$ using the root \$x = 1\$",
                "Apply difference of powers formula: \$x^n - 1 = (x - 1)(x^{n-1} + x^{n-2} + \\cdots + x + 1)\$",
                "For complete factorization, check if remaining factors can be further decomposed",
                "Final factorization over the reals"
            ),
            time=300,
        )
    end
end