# arithmetic - long_division (competition)
# Generated: 2026-03-08T19:47:44.575954

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("arithmetic/long_division")
    
    # Generate an olympiad-level long division problem (ELO 3500-5000)
    # These problems involve deep number theory, divisibility properties,
    # and creative insights beyond mechanical computation
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Find digit patterns in repeating decimals with number theory
        # Example: Find the 2024th digit after the decimal point in 1/p for prime p
        
        primes_with_long_periods = [7, 17, 19, 23, 29, 47, 59, 61, 97]
        p = choice(primes_with_long_periods)
        position = randint(1000, 5000)
        
        # Calculate the repeating block
        remainder = 1
        digits = []
        remainders_seen = Dict{Int, Int}()
        pos = 0
        
        while remainder != 0 && !haskey(remainders_seen, remainder)
            remainders_seen[remainder] = pos
            remainder *= 10
            push!(digits, div(remainder, p))
            remainder = mod(remainder, p)
            pos += 1
        end
        
        period_length = length(digits)
        digit_position = mod(position - 1, period_length) + 1
        ans = digits[digit_position]
        
        question = "Let \$d_n\$ denote the \$n\$-th digit after the decimal point in the decimal expansion of \$\\frac{1}{$(p)}\$. Find \$d_{$(position)}\$."
        
        solution = steps(
            "The decimal expansion of \$\\frac{1}{$(p)}\$ is periodic with period \$$(period_length)\$",
            sol("Period length", period_length),
            "To find \$d_{$(position)}\$, compute \$$(position) \\equiv $(digit_position) \\pmod{$(period_length)}\$",
            "The repeating block is: " * join(string.(digits), ""),
            sol("Answer: \$d_{$(position)} = \$", ans)
        )
        
    elseif problem_type == 2
        # Type 2: Divisibility with large powers and remainders
        # Find remainder when a large expression is divided by a prime
        
        base = randint(7, 25)
        exponent = randint(100, 500)
        modulus = choice([7, 11, 13, 17, 19, 23, 29, 31])
        
        # Use Fermat's Little Theorem: a^(p-1) ≡ 1 (mod p) if gcd(a,p)=1
        if gcd(base, modulus) == 1
            reduced_exp = mod(exponent, modulus - 1)
            ans = powermod(base, reduced_exp, modulus)
        else
            ans = 0
        end
        
        question = "Find the remainder when \$$(base)^{$(exponent)}\$ is divided by \$$(modulus)\$."
        
        solution = steps(
            "Since \$\\gcd($(base), $(modulus)) = $(gcd(base, modulus))\$, we use Fermat's Little Theorem",
            "By Fermat: \$$(base)^{$(modulus-1)} \\equiv 1 \\pmod{$(modulus)}\$",
            "Reduce exponent: \$$(exponent) \\equiv $(mod(exponent, modulus-1)) \\pmod{$(modulus-1)}\$",
            sol("Therefore: \$$(base)^{$(exponent)} \\equiv $(base)^{$(mod(exponent, modulus-1))} \\equiv\$", ans, "\$\\pmod{$(modulus)}\$"),
            sol("Answer", ans)
        )
        
    elseif problem_type == 3
        # Type 3: Find the sum of digits in a specific quotient or remainder pattern
        # Related to digital roots and deep divisibility
        
        n = randint(50, 200)
        # Sum of quotients when dividing consecutive integers by n
        total = sum(div(k, n) for k in 1:n*n)
        
        # Calculate sum of digits
        function sum_of_digits(num)
            s = 0
            while num > 0
                s += mod(num, 10)
                num = div(num, 10)
            end
            return s
        end
        
        ans = sum_of_digits(total)
        
        question = "Compute the sum of all digits in the decimal representation of \$\\sum_{k=1}^{$(n^2)} \\left\\lfloor \\frac{k}{$(n)} \\right\\rfloor\$."
        
        solution = steps(
            "Group terms: each quotient \$q\$ appears exactly \$$(n)\$ times",
            "Sum = \$$(n) \\cdot (0 + 1 + 2 + \\cdots + $(n-1))\$ = \$$(n) \\cdot \\frac{$(n-1) \\cdot $(n)}{2}\$",
            sol("Total", total),
            "Sum of digits of \$$(total)\$:",
            sol("Answer", ans)
        )
        
    else
        # Type 4: Advanced divisibility with constraints
        # Find number of integers satisfying division properties
        
        a = randint(3, 12)
        b = randint(3, 12)
        r1 = randint(1, a-1)
        r2 = randint(1, b-1)
        upper = randint(500, 2000)
        
        # Count integers n ≤ upper such that n ≡ r1 (mod a) and n ≡ r2 (mod b)
        # Use Chinese Remainder Theorem if gcd(a,b)=1
        
        g = gcd(a, b)
        if mod(r1 - r2, g) == 0
            # Solution exists
            m = div(a * b, g)
            # Find smallest solution by CRT
            x = r1
            while mod(x, b) != r2
                x += a
                if x > m
                    x = r1
                    break
                end
            end
            
            if mod(x, b) == r2
                ans = div(upper - x, m) + 1
            else
                ans = 0
            end
        else
            ans = 0
        end
        
        question = "How many positive integers \$n \\leq $(upper)\$ satisfy both \$n \\equiv $(r1) \\pmod{$(a)}\$ and \$n \\equiv $(r2) \\pmod{$(b)}\$?"
        
        solution = steps(
            "Check if system is solvable: \$\\gcd($(a), $(b)) = $(g)\$ must divide \$$(r1) - $(r2) = $(r1-r2)\$",
            "By Chinese Remainder Theorem, solutions have period \$\\text{lcm}($(a), $(b)) = $(div(a*b, g))\$",
            "Find the smallest positive solution and count multiples up to \$$(upper)\$",
            sol("Number of solutions", ans),
            sol("Answer", ans)
        )
    end
    
    problem(
        question=question,
        answer=ans,
        difficulty=(3500, 5000),
        solution=solution,
        time=600,
        calculator="none"
    )
end