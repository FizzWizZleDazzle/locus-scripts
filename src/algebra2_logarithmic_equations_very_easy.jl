# algebra2 - logarithmic_equations (very_easy)
# Generated: 2026-03-08T20:20:38.545800

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/logarithmic_equations")
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Type 1: Evaluate basic logarithm (100-400 ELO)
        # log_b(b^k) = k
        base = choice([2, 3, 4, 5, 10])
        exponent = randint(1, 4)
        value = base^exponent
        ans = exponent
        
        problem(
            question="Evaluate \\log_{$base}($value)",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Recognize that $value = $base^$exponent",
                "Use the property: \\log_b(b^k) = k",
                sol("Answer", ans)
            ),
            time=45
        )
        
    elseif prob_type == 2
        # Type 2: Simple logarithm definition (400-600 ELO)
        # If log_b(x) = k, then x = b^k
        base = choice([2, 3, 4, 5])
        k = randint(2, 5)
        ans = base^k
        
        problem(
            question="If \\log_{$base}(x) = $k, find x",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", "\\log_{$base}(x) = $k"),
                "By definition of logarithm: x = $base^$k",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif prob_type == 3
        # Type 3: Find the base (500-700 ELO)
        # log_b(value) = exponent, find b
        exponent = randint(2, 3)
        base = choice([2, 3, 4, 5])
        value = base^exponent
        ans = base
        
        problem(
            question="If \\log_{b}($value) = $exponent, find b",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "\\log_{b}($value) = $exponent"),
                "By definition: b^$exponent = $value",
                "Taking the $(exponent)th root: b = $(ans)",
                sol("Answer", ans)
            ),
            time=75
        )
        
    else
        # Type 4: Simple log property (300-600 ELO)
        # log_b(1) = 0 or log_b(b) = 1
        base = choice([2, 3, 4, 5, 10])
        
        if rand(Bool)
            # log_b(1) = 0
            problem(
                question="Evaluate \\log_{$base}(1)",
                answer=0,
                difficulty=(300, 500),
                solution=steps(
                    "Recall that any number raised to power 0 equals 1",
                    "$base^0 = 1",
                    sol("Answer", 0)
                ),
                time=40
            )
        else
            # log_b(b) = 1
            problem(
                question="Evaluate \\log_{$base}($base)",
                answer=1,
                difficulty=(300, 500),
                solution=steps(
                    "Recall that any number raised to power 1 equals itself",
                    "$base^1 = $base",
                    sol("Answer", 1)
                ),
                time=40
            )
        end
    end
end