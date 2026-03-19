# arithmetic - addition (hard)
# Generated: 2026-03-08T19:45:41.729711

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/addition")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Strategic digit sum with constraints (1800-2000)
        # Find numbers whose digits sum to specific values with arithmetic constraints
        target_sum = randint(15, 25)
        n_digits = rand(3:5)
        constraint_digit = rand(1:9)
        constraint_count = rand(2:3)
        
        # Generate a valid number
        digits = Int[]
        for i in 1:constraint_count
            push!(digits, constraint_digit)
        end
        remaining_sum = target_sum - constraint_digit * constraint_count
        remaining_digits = n_digits - constraint_count
        
        if remaining_digits > 0 && remaining_sum >= 0
            for i in 1:(remaining_digits-1)
                d = min(9, remaining_sum)
                d = rand(0:d)
                push!(digits, d)
                remaining_sum -= d
            end
            push!(digits, max(0, remaining_sum))
        end
        
        shuffle!(digits)
        n = Base.length(digits)
        num = sum(digits[i] * 10^(n-i) for i in 1:n)
        
        problem(
            question="Find a $(n_digits)-digit positive integer where exactly $(constraint_count) of its digits are $(constraint_digit), and the sum of all its digits equals $(target_sum). What is one such number?",
            answer=num,
            difficulty=(1800, 2000),
            solution=steps(
                "We need $(n_digits) digits with sum = $(target_sum)",
                "Using $(constraint_count) digits of $(constraint_digit): contributes $(constraint_digit * constraint_count)",
                "Remaining $(n_digits - constraint_count) digits must sum to $(target_sum - constraint_digit * constraint_count)",
                sol("One valid answer", num)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Type 2: Consecutive integer sums with complex patterns (2000-2200)
        # Sum of consecutive integers equals a large computed value
        start = randint(50, 150)
        length = randint(15, 30)
        
        # Sum of consecutive integers from start to start+length-1
        total = length * start + length * (length - 1) ÷ 2
        
        problem(
            question="The sum of $(length) consecutive positive integers equals $(total). What is the smallest of these integers?",
            answer=start,
            difficulty=(2000, 2200),
            solution=steps(
                "Let the first integer be n",
                sol("Sum formula", "n + (n+1) + ... + (n+$(length-1)) = $(total)"),
                "This simplifies to: $(length)n + $(length*(length-1)÷2) = $(total)",
                "Solving: $(length)n = $(total - length*(length-1)÷2)",
                sol("Answer", start)
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Type 3: Weighted average with constraints (2100-2300)
        n_groups = rand(3:4)
        weights = [randint(10, 40) for _ in 1:n_groups]
        values = [randint(60, 95) for _ in 1:n_groups]
        
        total_weight = sum(weights)
        weighted_sum = sum(weights[i] * values[i] for i in 1:n_groups)
        avg = weighted_sum ÷ total_weight
        
        # Ask for one of the unknown values given others
        unknown_idx = rand(1:n_groups)
        given_values = [i == unknown_idx ? "x" : string(values[i]) for i in 1:n_groups]
        
        problem(
            question="There are $(n_groups) groups of students with sizes $(fmt_list(weights)). Their average test scores are $(join([i == unknown_idx ? "x" : string(values[i]) for i in 1:n_groups], ", ")). If the overall weighted average is $(avg), find x.",
            answer=values[unknown_idx],
            difficulty=(2100, 2300),
            solution=steps(
                "Set up weighted average equation",
                sol("Equation", "\\frac{" * join(["$(weights[i]) \\cdot " * (i == unknown_idx ? "x" : "$(values[i])") for i in 1:n_groups], " + ") * "}{$(total_weight)} = $(avg)"),
                "Multiply both sides by $(total_weight): " * join(["$(weights[i]) \\cdot " * (i == unknown_idx ? "x" : "$(values[i])") for i in 1:n_groups], " + ") * " = $(avg * total_weight)",
                "Known sum: $(sum(i == unknown_idx ? 0 : weights[i] * values[i] for i in 1:n_groups))",
                "Therefore: $(weights[unknown_idx])x = $(avg * total_weight - sum(i == unknown_idx ? 0 : weights[i] * values[i] for i in 1:n_groups))",
                sol("Answer", values[unknown_idx])
            ),
            time=270
        )
        
    else
        # Type 4: Digit manipulation with modular arithmetic (2200-2500)
        # Three-digit number with special properties
        a = randint(3, 7)
        b = randint(2, 6)
        c = randint(1, 5)
        
        # Original number abc
        original = 100*a + 10*b + c
        # Reversed cba
        reversed = 100*c + 10*b + a
        # Difference
        diff = original - reversed
        
        # Additional constraint: sum of digits
        digit_sum = a + b + c
        
        problem(
            question="A three-digit number has the property that when its digits are reversed, the difference between the original number and the reversed number is $(diff). Additionally, the sum of its digits is $(digit_sum). If the hundreds digit is larger than the units digit, what is the original number?",
            answer=original,
            difficulty=(2200, 2500),
            solution=steps(
                "Let the number be 100a + 10b + c where a > c",
                sol("Difference equation", "(100a + 10b + c) - (100c + 10b + a) = $(diff)"),
                "Simplifying: 99a - 99c = $(diff), so a - c = $(diff ÷ 99)",
                sol("Sum constraint", "a + b + c = $(digit_sum)"),
                "From a - c = $(diff ÷ 99) and a + b + c = $(digit_sum)",
                "We can solve: a = $(a), b = $(b), c = $(c)",
                sol("Answer", original)
            ),
            time=300
        )
    end
end