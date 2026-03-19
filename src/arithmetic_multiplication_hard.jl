# arithmetic - multiplication (hard)
# Generated: 2026-03-08T19:46:45.227527

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/multiplication")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Strategic multiplication with pattern recognition (1800-2000)
        base = randint(11, 99)
        k = choice([9, 11, 99, 101, 999, 1001])
        
        product = base * k
        
        if k == 9
            trick = "$(base) × 10 - $(base) = $(base * 10) - $(base)"
        elseif k == 11
            trick = "$(base) × 10 + $(base) = $(base * 10) + $(base)"
        elseif k == 99
            trick = "$(base) × 100 - $(base) = $(base * 100) - $(base)"
        elseif k == 101
            trick = "$(base) × 100 + $(base) = $(base * 100) + $(base)"
        elseif k == 999
            trick = "$(base) × 1000 - $(base) = $(base * 1000) - $(base)"
        else
            trick = "$(base) × 1000 + $(base) = $(base * 1000) + $(base)"
        end
        
        problem(
            question="Compute \$$(base) \\times $(k)\$ without a calculator.",
            answer=product,
            difficulty=(1800, 1950),
            solution=steps(
                "Recognize pattern: \$$(k) = $(k > 100 ? div(k, 100) * 100 : (k > 10 ? div(k, 10) * 10 : k)) $(k % (k > 100 ? 100 : 10) >= 0 ? "+" : "-") $(abs(k % (k > 100 ? 100 : 10)))\$",
                "Apply distributive property: $(trick)",
                sol("Answer", product)
            ),
            time=120,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Digit sum divisibility and multiplication (1850-2050)
        a = randint(234, 876)
        b = randint(111, 999)
        
        product = a * b
        digit_sum = sum(digits(product))
        
        problem(
            question="Find the sum of the digits of \$$(a) \\times $(b)\$.",
            answer=digit_sum,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Compute product", "$(a) \\times $(b) = $(product)"),
                "Extract digits: $(join(reverse(digits(product)), ", "))",
                sol("Sum of digits", "$(join(reverse(digits(product)), " + ")) = $(digit_sum)")
            ),
            time=150,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Modular arithmetic with multiplication (2000-2200)
        a = randint(47, 199)
        b = randint(53, 197)
        m = choice([7, 11, 13, 17, 19, 23])
        
        product = a * b
        remainder = mod(product, m)
        
        problem(
            question="What is the remainder when \$$(a) \\times $(b)\$ is divided by \$$(m)\$?",
            answer=remainder,
            difficulty=(2000, 2200),
            solution=steps(
                "Find \$$(a) \\equiv $(mod(a, m)) \\pmod{$(m)}\$",
                "Find \$$(b) \\equiv $(mod(b, m)) \\pmod{$(m)}\$",
                "Multiply: \$$(mod(a, m)) \\times $(mod(b, m)) = $(mod(a, m) * mod(b, m)) \\equiv $(remainder) \\pmod{$(m)}\$",
                sol("Remainder", remainder)
            ),
            time=180,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Unit digit patterns in large products (1900-2100)
        base = choice([2, 3, 7, 8, 9])
        power = randint(15, 45)
        
        cycles = Dict(2 => [2,4,8,6], 3 => [3,9,7,1], 7 => [7,9,3,1], 8 => [8,4,2,6], 9 => [9,1])
        cycle = cycles[base]
        unit_digit = cycle[mod(power - 1, length(cycle)) + 1]
        
        problem(
            question="What is the units digit of \$$(base)^{$(power)}\$?",
            answer=unit_digit,
            difficulty=(1900, 2100),
            solution=steps(
                "Find the pattern of units digits for powers of $(base): $(join(cycle, ", ")), ...",
                "The cycle length is $(length(cycle))",
                "Find \$$(power) \\equiv $(mod(power - 1, length(cycle)) + 1) \\pmod{$(length(cycle))}\$ (position in cycle)",
                sol("Units digit", unit_digit)
            ),
            time=150,
            calculator="none"
        )
        
    else
        # Cross-multiplication with algebraic reasoning (2100-2400)
        n = randint(5, 15)
        k = randint(2, 6)
        target = n * (n + k)
        
        problem(
            question="If \$n(n + $(k)) = $(target)\$, what is the positive value of \$n\$?",
            answer=n,
            difficulty=(2100, 2400),
            solution=steps(
                sol("Given", "n(n + $(k)) = $(target)"),
                "Expand: \$n^2 + $(k)n - $(target) = 0\$",
                "Factor or test values: \$n = $(n)\$ satisfies \$$(n) \\times $(n + k) = $(target)\$",
                sol("Answer", n)
            ),
            time=200,
            calculator="none"
        )
    end
end