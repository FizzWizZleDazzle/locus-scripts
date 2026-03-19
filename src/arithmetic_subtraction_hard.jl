# arithmetic - subtraction (hard)
# Generated: 2026-03-08T19:46:12.182022

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("arithmetic/subtraction")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Large multi-digit subtraction with borrowing across multiple zeros
        # ELO 1800-2000
        a = randint(100000, 999999)
        b = randint(10000, a - 1)
        while count(c -> c == '0', string(a)) < 2
            a = randint(100000, 999999)
        end
        ans = a - b
        
        problem(
            question="Calculate: \$$(a) - $(b)\$",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", "$(a) - $(b)"),
                "Perform multi-digit subtraction with borrowing",
                "Work from right to left, borrowing across zeros as needed",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Subtraction chain with strategic grouping
        # ELO 1900-2100
        nums = [randint(1000, 9999) for _ in 1:5]
        sort!(nums, rev=true)
        
        total = nums[1]
        for i in 2:5
            total -= nums[i]
        end
        ans = total
        
        expr_str = "$(nums[1])"
        for i in 2:5
            expr_str *= " - $(nums[i])"
        end
        
        problem(
            question="Calculate: \$$(expr_str)\$",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", expr_str),
                "Group and simplify strategically",
                "Calculate step by step: $(nums[1]) - $(nums[2]) = $(nums[1] - nums[2])",
                "Continue subtraction through remaining terms",
                sol("Answer", ans)
            ),
            time=150
        )
        
    elseif problem_type == 3
        # Finding the missing subtrahend
        # ELO 2000-2200
        minuend = randint(50000, 150000)
        difference = randint(10000, minuend - 1000)
        subtrahend = minuend - difference
        ans = subtrahend
        
        problem(
            question="Find the value of \$x\$ if \$$(minuend) - x = $(difference)\$",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", "$(minuend) - x = $(difference)"),
                "Rearrange: \$x = $(minuend) - $(difference)\$",
                "This is a subtraction problem in disguise",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 4
        # Subtraction with pattern recognition
        # ELO 2100-2300
        base = randint(100, 999)
        power = choice(3:5)
        num1 = base^power
        num2 = base^(power - 1)
        ans = num1 - num2
        
        problem(
            question="Calculate: \$$(base)^{$(power)} - $(base)^{$(power-1)}\$",
            answer=ans,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", "$(base)^{$(power)} - $(base)^{$(power-1)}"),
                "Factor out \$$(base)^{$(power-1)}\$: \$$(base)^{$(power-1)}($(base) - 1)\$",
                "Calculate: \$$(base)^{$(power-1)} = $(num2)\$",
                "Then: \$$(num2) \\times $(base - 1) = $(ans)\$",
                sol("Answer", ans)
            ),
            time=180
        )
        
    else
        # Complex alternating sum with large numbers
        # ELO 2200-2400
        n = randint(8, 12)
        start = randint(10000, 50000)
        diff = randint(100, 500)
        
        total = start
        terms_str = "$(start)"
        for i in 1:n
            val = start + i * diff
            if i % 2 == 1
                total -= val
                terms_str *= " - $(val)"
            else
                total += val
                terms_str *= " + $(val)"
            end
        end
        ans = total
        
        problem(
            question="Calculate the alternating sum: \$$(terms_str)\$",
            answer=ans,
            difficulty=(2200, 2400),
            solution=steps(
                sol("Given", terms_str),
                "Notice arithmetic progression with common difference $(diff)",
                "Group positive and negative terms separately",
                "Sum of subtracted terms minus sum of added terms",
                sol("Answer", ans)
            ),
            time=240
        )
    end
end