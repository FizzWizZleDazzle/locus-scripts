# algebra1 - factoring_gcf (hard)
# Generated: 2026-03-08T20:00:15.117110

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/factoring_gcf")
    
    # Problem type selector
    prob_type = rand(1:5)
    
    if prob_type == 1
        # GCF factoring with large coefficients and multiple variables
        gcf = randint(2, 15)
        n_terms = rand(3:4)
        
        # Generate terms with the GCF built in
        coeffs = [gcf * nonzero(-12, 12) for _ in 1:n_terms]
        x_powers = sort([randint(1, 5) for _ in 1:n_terms], rev=true)
        y_powers = sort([randint(0, 4) for _ in 1:n_terms], rev=true)
        
        terms = [coeffs[i] * x^x_powers[i] * y^y_powers[i] for i in 1:n_terms]
        expr = sum(terms)
        
        # Find actual GCF
        min_x = minimum(x_powers)
        min_y = minimum(y_powers)
        gcf_term = gcf * x^min_x * y^min_y
        
        factored_coeffs = [div(coeffs[i], gcf) for i in 1:n_terms]
        factored_powers_x = [x_powers[i] - min_x for i in 1:n_terms]
        factored_powers_y = [y_powers[i] - min_y for i in 1:n_terms]
        
        inside_terms = [factored_coeffs[i] * x^factored_powers_x[i] * y^factored_powers_y[i] for i in 1:n_terms]
        inside = sum(inside_terms)
        
        factored = gcf_term * inside
        
        problem(
            question = "Factor out the greatest common factor (GCF) from \$$(tex(expr))\$",
            answer = factored,
            difficulty = (1800, 2000),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Identify GCF of coefficients: $(gcf)",
                "Identify lowest powers: \$x^{$(min_x)}\$, \$y^{$(min_y)}\$",
                "GCF = \$$(tex(gcf_term))\$",
                sol("Factored form", factored)
            ),
            time = 150
        )
        
    elseif prob_type == 2
        # Challenging three-variable GCF with negative leading coefficient
        gcf = randint(3, 10)
        make_negative = rand(Bool)
        if make_negative
            gcf = -gcf
        end
        
        n_terms = rand(3:5)
        coeffs = [gcf * nonzero(-8, 8) for _ in 1:n_terms]
        x_powers = sort([randint(2, 6) for _ in 1:n_terms], rev=true)
        y_powers = sort([randint(1, 5) for _ in 1:n_terms], rev=true)
        z_powers = sort([randint(0, 4) for _ in 1:n_terms], rev=true)
        
        terms = [coeffs[i] * x^x_powers[i] * y^y_powers[i] * z^z_powers[i] for i in 1:n_terms]
        expr = sum(terms)
        
        min_x = minimum(x_powers)
        min_y = minimum(y_powers)
        min_z = minimum(z_powers)
        gcf_term = gcf * x^min_x * y^min_y * z^min_z
        
        factored_coeffs = [div(coeffs[i], gcf) for i in 1:n_terms]
        factored_powers_x = [x_powers[i] - min_x for i in 1:n_terms]
        factored_powers_y = [y_powers[i] - min_y for i in 1:n_terms]
        factored_powers_z = [z_powers[i] - min_z for i in 1:n_terms]
        
        inside_terms = [factored_coeffs[i] * x^factored_powers_x[i] * y^factored_powers_y[i] * z^factored_powers_z[i] for i in 1:n_terms]
        inside = sum(inside_terms)
        
        factored = gcf_term * inside
        
        problem(
            question = "Factor completely by removing the GCF: \$$(tex(expr))\$",
            answer = factored,
            difficulty = (2000, 2200),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Find GCF of coefficients: $(abs(gcf))" * (make_negative ? " (factor out negative)" : ""),
                "Lowest variable powers: \$x^{$(min_x)}y^{$(min_y)}z^{$(min_z)}\$",
                "Complete GCF = \$$(tex(gcf_term))\$",
                sol("Factored", factored)
            ),
            time = 180
        )
        
    elseif prob_type == 3
        # GCF factoring then factor by grouping (4 terms)
        # Create (ax + b)(cx + d) structure with common factor k
        k = randint(2, 8)
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        c = nonzero(-6, 6)
        d = nonzero(-8, 8)
        
        # Expand k(ax + b)(cx + d) = k(acx² + adx + bcx + bd)
        term1_coeff = k * a * c
        term2_coeff = k * a * d
        term3_coeff = k * b * c
        term4_coeff = k * b * d
        
        expr = term1_coeff * x^2 + term2_coeff * x + term3_coeff * x + term4_coeff
        factored = k * (a*x + b) * (c*x + d)
        
        problem(
            question = "Factor completely: \$$(tex(expr))\$",
            answer = factored,
            difficulty = (2100, 2300),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Factor out GCF = $(k)",
                "Inside: \$$(tex(a*c*x^2 + a*d*x + b*c*x + b*d))\$",
                "Group and factor: \$$(tex((a*x + b)*(c*x + d)))\$",
                sol("Complete factorization", factored)
            ),
            time = 210
        )
        
    elseif prob_type == 4
        # Large coefficient GCF with fractional result when factored
        gcf = randint(4, 20)
        n_terms = 3
        
        # Ensure we get non-trivial remaining polynomial
        coeffs = [gcf * nonzero(-15, 15) for _ in 1:n_terms]
        powers = sort([randint(3, 8), randint(2, 7), randint(1, 6)], rev=true)
        
        terms = [coeffs[i] * x^powers[i] for i in 1:n_terms]
        expr = sum(terms)
        
        min_power = minimum(powers)
        gcf_term = gcf * x^min_power
        
        factored_coeffs = [div(coeffs[i], gcf) for i in 1:n_terms]
        factored_powers = [powers[i] - min_power for i in 1:n_terms]
        
        inside_terms = [factored_coeffs[i] * x^factored_powers[i] for i in 1:n_terms]
        inside = sum(inside_terms)
        
        factored = gcf_term * inside
        
        problem(
            question = "Factor out the GCF from \$$(tex(expr))\$",
            answer = factored,
            difficulty = (1850, 2050),
            grading_mode = "factor",
            solution = steps(
                sol("Expression", expr),
                "GCF of coefficients: $(gcf)",
                "Lowest power of x: \$x^{$(min_power)}\$",
                "Combined GCF: \$$(tex(gcf_term))\$",
                sol("Result", factored)
            ),
            time = 140
        )
        
    else
        # Competition-level: GCF with two variables and strategic grouping needed
        # Form: k(a²x²y + abxy² + acx² + bcxy) where strategic factoring reveals structure
        k = randint(2, 6)
        a = nonzero(-5, 5)
        b = nonzero(-7, 7)
        c = nonzero(-6, 6)
        
        term1 = k * a^2 * x^2 * y
        term2 = k * a * b * x * y^2
        term3 = k * a * c * x^2
        term4 = k * b * c * x * y
        
        expr = term1 + term2 + term3 + term4
        
        # GCF is kx
        gcf_out = k * x
        inside = a^2 * x * y + a * b * y^2 + a * c * x + b * c * y
        # This factors as (ax + by)(ay + c)
        factored = gcf_out * (a*x + b*y) * (a*y + c)
        
        problem(
            question = "Factor completely: \$$(tex(expr))\$",
            answer = factored,
            difficulty = (2200, 2400),
            grading_mode = "factor",
            solution = steps(
                sol("Given", expr),
                "Factor out GCF \$$(tex(gcf_out))\$: \$$(tex(gcf_out))\\cdot($(tex(inside)))\$",
                "Factor by grouping the remaining polynomial",
                "Group as: \$$(tex(a*x*(a*y + c) + b*y*(a*y + c)))\$",
                sol("Complete factorization", factored)
            ),
            time = 240
        )
    end
end