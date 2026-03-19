# arithmetic - long_division (very_hard)
# Generated: 2026-03-08T19:47:29.086043

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/long_division")
    
    # Competition to Olympiad level (2500-3500 ELO)
    # Focus on deep number theory properties in division problems
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Division with repeating decimals and period discovery
        # Find the period of 1/p where p is prime
        primes = [7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        p = choice(primes)
        
        # Calculate period length (order of 10 mod p)
        period = 1
        remainder = 10 % p
        while remainder != 1
            remainder = (remainder * 10) % p
            period += 1
        end
        
        question = "Find the length of the repeating block in the decimal expansion of \\frac{1}{$(p)}."
        answer = period
        diff = (2500, 3000)
        
        sol_text = steps(
            "To find the period of \\frac{1}{$(p)}, we need to find the smallest positive integer k such that 10^k ≡ 1 (mod $(p))",
            "This is equivalent to finding the multiplicative order of 10 modulo $(p)",
            "By Fermat's Little Theorem, 10^{$(p-1)} ≡ 1 (mod $(p)), so the order divides $(p-1)",
            "Testing divisors of $(p-1), we find the smallest k = $(period)",
            sol("Answer", period)
        )
        
    elseif problem_type == 2
        # Type 2: Find remainder when large number is divided
        # Using modular arithmetic properties
        base = randint(7, 15)
        exp = randint(50, 150)
        divisor = randint(11, 30)
        
        # Calculate base^exp mod divisor using fast exponentiation
        result = powermod(base, exp, divisor)
        
        question = "Find the remainder when \\($(base)^{$(exp)}\\) is divided by $(divisor)."
        answer = result
        diff = (2600, 3200)
        
        sol_text = steps(
            "We need to find \\($(base)^{$(exp)} \\bmod $(divisor)\\)",
            "Use Fermat's Little Theorem or Euler's theorem to reduce the exponent",
            "Compute successive powers of $(base) modulo $(divisor) and find the pattern",
            "Using modular exponentiation by repeated squaring",
            sol("Answer", result)
        )
        
    elseif problem_type == 3
        # Type 3: Divisibility and digit sum problems
        # Find n such that a specific division property holds
        k = randint(7, 15)
        target = randint(3, 12)
        n = k * target + randint(0, target - 1)
        
        # Create a number with specific digit sum
        digit_sum_target = randint(20, 40)
        
        question = "A positive integer N has digit sum $(digit_sum_target). When N is divided by 9, what is the remainder?"
        answer = digit_sum_target % 9
        diff = (2400, 2800)
        
        sol_text = steps(
            "By the divisibility rule for 9, a number has the same remainder when divided by 9 as the sum of its digits",
            "The digit sum is $(digit_sum_target)",
            "Calculate $(digit_sum_target) ÷ 9 = $(div(digit_sum_target, 9)) remainder $(digit_sum_target % 9)",
            sol("Answer", digit_sum_target % 9)
        )
        
    else
        # Type 4: Advanced: Find quotient and remainder with constraints
        # Given constraints on quotient and remainder, find dividend
        divisor = randint(15, 35)
        quotient = randint(20, 50)
        remainder = randint(1, divisor - 1)
        dividend = divisor * quotient + remainder
        
        # Add number theory twist
        question = "When the integer $(dividend) is divided by a certain divisor d, the quotient is $(quotient) and the remainder is $(remainder). If the remainder is less than the quotient, find the divisor d."
        answer = divisor
        diff = (2700, 3300)
        
        sol_text = steps(
            "By the division algorithm: $(dividend) = d · $(quotient) + $(remainder), where 0 ≤ $(remainder) < d",
            "Also given that $(remainder) < $(quotient)",
            "From $(dividend) = d · $(quotient) + $(remainder), we get d = \\frac{$(dividend) - $(remainder)}{$(quotient)} = \\frac{$(dividend - remainder)}{$(quotient)}",
            "Calculate: d = $(divisor)",
            "Verify: $(divisor) · $(quotient) + $(remainder) = $(dividend) ✓",
            sol("Answer", divisor)
        )
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=diff,
        solution=sol_text,
        time=240
    )
end