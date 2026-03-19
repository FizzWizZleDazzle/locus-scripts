# algebra2 - logarithm_properties (very_easy)
# Generated: 2026-03-08T20:19:57.468987

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/logarithm_properties")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple log evaluation: log_b(b^n) = n
        base = choice([2, 3, 4, 5, 10])
        exponent = randint(1, 4)
        value = base^exponent
        ans = exponent
        
        problem(
            question="Evaluate \\log_{$base}($value)",
            answer=ans,
            difficulty=(100, 400),
            solution=steps(
                "Recognize that $value = $base^$exponent",
                "Apply the property: \\log_b(b^n) = n",
                sol("Answer", ans)
            ),
            time=45
        )
    elseif problem_type == 2
        # Basic log property: log(1) = 0
        base = choice([2, 3, 5, 7, 10])
        ans = 0
        
        problem(
            question="Evaluate \\log_{$base}(1)",
            answer=ans,
            difficulty=(100, 300),
            solution=steps(
                "Recall that any base raised to the power 0 equals 1",
                "$base^0 = 1",
                sol("Answer", ans)
            ),
            time=30
        )
    elseif problem_type == 3
        # Product rule: log(ab) = log(a) + log(b)
        base = choice([2, 3, 5, 10])
        a = randint(2, 8)
        b = randint(2, 8)
        product = a * b
        
        problem(
            question="Expand \\log_{$base}($product) using the product rule, given that $product = $a \\cdot $b",
            answer="\\log_{$base}($a) + \\log_{$base}($b)",
            difficulty=(400, 700),
            answer_type="expression",
            solution=steps(
                "Apply the product rule: \\log_b(xy) = \\log_b(x) + \\log_b(y)",
                "Identify $product = $a \\cdot $b",
                sol("Answer", "\\log_{$base}($a) + \\log_{$base}($b)")
            ),
            time=60
        )
    elseif problem_type == 4
        # Power rule: log(a^n) = n*log(a)
        base = choice([2, 3, 5, 10])
        a = randint(2, 9)
        n = randint(2, 5)
        ans = n
        
        problem(
            question="If \\log_{$base}($a) = k, what is \\log_{$base}($a^$n)?",
            answer="$(n)k",
            difficulty=(500, 700),
            answer_type="expression",
            solution=steps(
                "Apply the power rule: \\log_b(a^n) = n \\cdot \\log_b(a)",
                "Substitute \\log_{$base}($a) = k",
                sol("Answer", "$(n)k")
            ),
            time=75
        )
    elseif problem_type == 5
        # Quotient rule: log(a/b) = log(a) - log(b)
        base = choice([2, 3, 5, 10])
        a = randint(10, 30)
        b = randint(2, 9)
        
        problem(
            question="Expand \\log_{$base}\\left(\\frac{$a}{$b}\\right) using the quotient rule",
            answer="\\log_{$base}($a) - \\log_{$base}($b)",
            difficulty=(400, 700),
            answer_type="expression",
            solution=steps(
                "Apply the quotient rule: \\log_b\\left(\\frac{x}{y}\\right) = \\log_b(x) - \\log_b(y)",
                "Identify numerator = $a and denominator = $b",
                sol("Answer", "\\log_{$base}($a) - \\log_{$base}($b)")
            ),
            time=60
        )
    else
        # Recognize log_b(b) = 1
        base = choice([2, 3, 4, 5, 7, 10])
        ans = 1
        
        problem(
            question="Evaluate \\log_{$base}($base)",
            answer=ans,
            difficulty=(100, 300),
            solution=steps(
                "Recall that \\log_b(b) = 1",
                "This is because $base^1 = $base",
                sol("Answer", ans)
            ),
            time=30
        )
    end
end