# algebra2 - logarithm_properties (medium)
# Generated: 2026-03-08T20:20:24.800174

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/logarithm_properties")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Expanding logarithms using product/quotient/power rules
        # ELO: 1200-1400
        base = choice([2, 3, 5, 10])
        a = randint(2, 12)
        b = randint(2, 12)
        n = randint(2, 5)
        
        use_product = rand(Bool)
        use_power = rand(Bool)
        
        if use_product && use_power
            ans_str = "$(n)\\log_{$(base)}($(a)) + \\log_{$(base)}($(b))"
            question_str = "\\log_{$(base)}($(a)^{$(n)} \\cdot $(b))"
        elseif use_product
            ans_str = "\\log_{$(base)}($(a)) + \\log_{$(base)}($(b))"
            question_str = "\\log_{$(base)}($(a) \\cdot $(b))"
        else
            ans_str = "\\log_{$(base)}($(a)) - \\log_{$(base)}($(b))"
            question_str = "\\log_{$(base)}\\left(\\frac{$(a)}{$(b)}\\right)"
        end
        
        problem(
            question="Expand using logarithm properties: \$$(question_str)\$",
            answer=ans_str,
            difficulty=(1200, 1400),
            answer_type="expression",
            solution=steps(
                "Use logarithm properties:",
                use_product ? "Product rule: \\(\\log_b(xy) = \\log_b(x) + \\log_b(y)\\)" : "Quotient rule: \\(\\log_b(x/y) = \\log_b(x) - \\log_b(y)\\)",
                use_power ? "Power rule: \\(\\log_b(x^n) = n\\log_b(x)\\)" : "",
                sol("Answer", ans_str)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Condensing logarithms
        # ELO: 1300-1500
        base = choice([2, 3, 5, 10])
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 5)
        d = randint(2, 5)
        
        operation = rand(1:3)
        if operation == 1
            # Sum to product
            question_str = "$(c)\\log_{$(base)}($(a)) + $(d)\\log_{$(base)}($(b))"
            ans_str = "\\log_{$(base)}($(a)^{$(c)} \\cdot $(b)^{$(d)})"
        elseif operation == 2
            # Difference to quotient
            question_str = "$(c)\\log_{$(base)}($(a)) - $(d)\\log_{$(base)}($(b))"
            ans_str = "\\log_{$(base)}\\left(\\frac{$(a)^{$(c)}}{$(b)^{$(d)}}\\right)"
        else
            # Mixed
            e = randint(2, 8)
            question_str = "\\log_{$(base)}($(a)) + $(c)\\log_{$(base)}($(b)) - \\log_{$(base)}($(e))"
            ans_str = "\\log_{$(base)}\\left(\\frac{$(a) \\cdot $(b)^{$(c)}}{$(e)}\\right)"
        end
        
        problem(
            question="Condense into a single logarithm: \$$(question_str)\$",
            answer=ans_str,
            difficulty=(1300, 1500),
            answer_type="expression",
            solution=steps(
                "Apply logarithm properties in reverse:",
                "Power rule: \\(n\\log_b(x) = \\log_b(x^n)\\)",
                operation == 1 ? "Product rule: \\(\\log_b(x) + \\log_b(y) = \\log_b(xy)\\)" : "Quotient rule: \\(\\log_b(x) - \\log_b(y) = \\log_b(x/y)\\)",
                sol("Answer", ans_str)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Solving logarithmic equations (single log)
        # ELO: 1400-1600
        base = choice([2, 3, 4, 5, 10])
        ans = randint(2, 50)
        value = randint(2, 6)
        
        # log_base(x) = value, so x = base^value
        ans = base^value
        
        problem(
            question="Solve for \\(x\\): \$\\log_{$(base)}(x) = $(value)\$",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", "\\log_{$(base)}(x) = $(value)"),
                "Convert to exponential form: \\(x = $(base)^{$(value)}\\)",
                sol("Answer", "x = $(ans)")
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Solving logarithmic equations (combining logs)
        # ELO: 1500-1700
        base = choice([2, 3, 5, 10])
        ans = randint(3, 20)
        other = randint(2, 8)
        
        while other == ans
            other = randint(2, 8)
        end
        
        # log_base(x) + log_base(other) = log_base(x * other)
        product = ans * other
        result_power = randint(1, 3)
        
        # Find what power of base equals product
        result = product
        
        problem(
            question="Solve for \\(x\\): \$\\log_{$(base)}(x) + \\log_{$(base)}($(other)) = \\log_{$(base)}($(product))\$",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", "\\log_{$(base)}(x) + \\log_{$(base)}($(other)) = \\log_{$(base)}($(product))"),
                "Use product rule: \\(\\log_{$(base)}(x \\cdot $(other)) = \\log_{$(base)}($(product))\\)",
                "Since the logarithms are equal: \\(x \\cdot $(other) = $(product)\\)",
                "Divide both sides by $(other): \\(x = $(ans)\\)",
                sol("Answer", "x = $(ans)")
            ),
            time=150
        )
        
    else
        # Change of base formula application
        # ELO: 1400-1700
        old_base = choice([2, 3, 5, 7])
        new_base = choice([10, "e"])
        arg = randint(5, 30)
        
        if new_base == 10
            ans_str = "\\frac{\\log($(arg))}{\\log($(old_base))}"
        else
            ans_str = "\\frac{\\ln($(arg))}{\\ln($(old_base))}"
        end
        
        problem(
            question="Rewrite using the change of base formula with base $(new_base == 10 ? "10" : "e"): \$\\log_{$(old_base)}($(arg))\$",
            answer=ans_str,
            difficulty=(1400, 1700),
            answer_type="expression",
            solution=steps(
                sol("Given", "\\log_{$(old_base)}($(arg))"),
                "Change of base formula: \\(\\log_b(x) = \\frac{\\log_c(x)}{\\log_c(b)}\\)",
                new_base == 10 ? "Using base 10:" : "Using base e (natural log):",
                sol("Answer", ans_str)
            ),
            time=120
        )
    end
end