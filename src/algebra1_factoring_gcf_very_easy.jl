# algebra1 - factoring_gcf (very_easy)
# Generated: 2026-03-08T19:59:31.681823

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_gcf")
    
    # Choose difficulty level within 100-700 range
    level = rand([1, 2, 3])
    
    if level == 1
        # ELO 100-300: Factor out a simple positive integer GCF
        gcf = randint(2, 6)
        n_terms = rand([2, 3])
        
        if n_terms == 2
            c1 = randint(1, 8)
            c2 = randint(1, 8)
            expr = gcf * c1 * x + gcf * c2
            factored = gcf * (c1 * x + c2)
        else
            c1 = randint(1, 6)
            c2 = randint(1, 6)
            c3 = randint(1, 6)
            expr = gcf * c1 * x^2 + gcf * c2 * x + gcf * c3
            factored = gcf * (c1 * x^2 + c2 * x + c3)
        end
        
        diff_range = (200, 400)
        time_limit = 60
        
    elseif level == 2
        # ELO 300-500: Factor out GCF with variables
        gcf_coef = randint(2, 8)
        power = rand([1, 2])
        n_terms = rand([2, 3])
        
        if n_terms == 2
            c1 = randint(1, 8)
            c2 = randint(1, 8)
            expr = gcf_coef * c1 * x^(power + 1) + gcf_coef * c2 * x^power
            factored = gcf_coef * x^power * (c1 * x + c2)
        else
            c1 = randint(1, 6)
            c2 = randint(1, 6)
            c3 = randint(1, 6)
            expr = gcf_coef * c1 * x^(power + 2) + gcf_coef * c2 * x^(power + 1) + gcf_coef * c3 * x^power
            factored = gcf_coef * x^power * (c1 * x^2 + c2 * x + c3)
        end
        
        diff_range = (400, 550)
        time_limit = 90
        
    else
        # ELO 500-700: Factor out GCF with negative coefficients or larger powers
        gcf_coef = randint(2, 10)
        power = rand([2, 3])
        n_terms = 3
        
        c1 = nonzero(-8, 8)
        c2 = nonzero(-8, 8)
        c3 = nonzero(-8, 8)
        
        expr = gcf_coef * c1 * x^(power + 2) + gcf_coef * c2 * x^(power + 1) + gcf_coef * c3 * x^power
        factored = gcf_coef * x^power * (c1 * x^2 + c2 * x + c3)
        
        diff_range = (550, 700)
        time_limit = 120
    end
    
    problem(
        question = "Factor out the greatest common factor (GCF) from \$$(tex(expr))\$",
        answer = factored,
        difficulty = diff_range,
        grading_mode = "factor",
        solution = steps(
            sol("Expression", expr),
            "Identify the GCF of all terms",
            "Factor out the GCF",
            sol("Answer", factored)
        ),
        time = time_limit
    )
end