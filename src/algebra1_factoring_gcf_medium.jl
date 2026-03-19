# algebra1 - factoring_gcf (medium)
# Generated: 2026-03-08T19:59:49.232006

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/factoring_gcf")
    
    # Problem type selection
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Simple GCF factoring: gcf * (polynomial)
        gcf = nonzero(-12, 12)
        n_terms = rand(2:3)
        
        if n_terms == 2
            c1 = nonzero(-8, 8)
            c2 = nonzero(-8, 8)
            exp1 = rand(1:4)
            exp2 = rand(1:exp1-1)
            
            inside = c1 * x^exp1 + c2 * x^exp2
            expr = expand(gcf * inside)
            factored = gcf * inside
        else
            c1 = nonzero(-8, 8)
            c2 = nonzero(-8, 8)
            c3 = nonzero(-8, 8)
            exp1 = rand(2:4)
            exp2 = rand(1:exp1-1)
            
            inside = c1 * x^exp1 + c2 * x^exp2 + c3
            expr = expand(gcf * inside)
            factored = gcf * inside
        end
        
        diff = (1200, 1400)
        sol_steps = steps(
            sol("Given", expr),
            "Find GCF of all terms: $(abs(gcf))",
            "Factor out the GCF",
            sol("Answer", factored)
        )
        
    elseif prob_type == 2
        # GCF with higher powers and more terms
        gcf = nonzero(-15, 15)
        c1 = nonzero(-6, 6)
        c2 = nonzero(-6, 6)
        c3 = nonzero(-6, 6)
        c4 = nonzero(-6, 6)
        
        exp1 = rand(3:6)
        exp2 = rand(2:exp1-1)
        exp3 = rand(1:exp2-1)
        
        inside = c1 * x^exp1 + c2 * x^exp2 + c3 * x^exp3 + c4
        expr = expand(gcf * inside)
        factored = gcf * inside
        
        diff = (1400, 1600)
        sol_steps = steps(
            sol("Given", expr),
            "Identify GCF of coefficients: $(abs(gcf))",
            "Factor out the GCF from each term",
            sol("Factored form", factored)
        )
        
    elseif prob_type == 3
        # Negative leading coefficient that should be factored out
        gcf = -1 * rand(2:10)
        c1 = rand(2:8)  # Make inside have positive leading term
        c2 = nonzero(-10, 10)
        c3 = nonzero(-10, 10)
        
        exp1 = rand(2:4)
        exp2 = rand(1:exp1-1)
        
        inside = c1 * x^exp1 + c2 * x^exp2 + c3
        expr = expand(gcf * inside)
        factored = gcf * inside
        
        diff = (1300, 1500)
        sol_steps = steps(
            sol("Given", expr),
            "Factor out $(gcf) to make leading coefficient positive",
            "Distribute the negative GCF",
            sol("Answer", factored)
        )
        
    else
        # Large GCF with complex polynomial
        gcf_base = rand([2, 3, 5, 6, 10, 12, 15])
        gcf_mult = rand(2:4)
        gcf = gcf_base * gcf_mult
        
        c1 = nonzero(-5, 5)
        c2 = nonzero(-5, 5)
        c3 = nonzero(-5, 5)
        
        exp1 = rand(3:5)
        exp2 = rand(2:exp1-1)
        exp3 = rand(1:exp2-1)
        
        inside = c1 * x^exp1 + c2 * x^exp2 + c3 * x^exp3
        expr = expand(gcf * inside)
        factored = gcf * inside
        
        diff = (1500, 1700)
        sol_steps = steps(
            sol("Given", expr),
            "Find GCF of all coefficients: $(gcf)",
            "Factor out $(gcf) from each term",
            sol("Factored form", factored)
        )
    end
    
    problem(
        question="Factor completely by finding the GCF: \$$(tex(expr))\$",
        answer=factored,
        difficulty=diff,
        grading_mode="factor",
        solution=sol_steps,
        time=120
    )
end