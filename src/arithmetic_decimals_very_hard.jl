# arithmetic - decimals (very_hard)
# Generated: 2026-03-08T19:50:06.161295

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/decimals")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Find decimal expansion period of fraction with large prime denominator
        # ELO: 2600-3200 (requires number theory insight about decimal periods)
        primes = [7, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
        p = choice(primes)
        numerator = randint(1, p-1)
        
        # Calculate period length (order of 10 mod p)
        period = 1
        remainder = 10 % p
        while remainder != 1
            remainder = (remainder * 10) % p
            period += 1
        end
        
        problem(
            question="The decimal expansion of \\(\\frac{$(numerator)}{$(p)}\\) is eventually periodic. Find the length of the minimal repeating period.",
            answer=period,
            difficulty=(2600, 3200),
            solution=steps(
                sol("Given fraction", numerator // p),
                "The period length of \\(\\frac{a}{p}\\) where \\(\\gcd(a,p)=1\\) equals the multiplicative order of 10 modulo $(p)",
                "Find smallest \\(k\\) such that \\(10^k \\equiv 1 \\pmod{$(p)}\\)",
                "By Fermat's Little Theorem, \\(k\\) divides \\(\\phi($(p)) = $(p-1)\\)",
                "Testing divisors of $(p-1), we find the order is $(period)",
                sol("Answer", period)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Type 2: Decimal digit sum problem with patterns
        # ELO: 2700-3400 (combinatorial reasoning with decimal representations)
        k = randint(3, 7)
        n = randint(15, 35)
        
        # Calculate sum of digits in decimal expansion of (10^n - 1)/k
        value = (BigInt(10)^n - 1) ÷ k
        digit_sum = sum(parse(Int, string(d)) for d in string(value))
        
        problem(
            question="Compute the sum of all digits in the decimal representation of \\(\\frac{10^{$(n)} - 1}{$(k)}\\).",
            answer=digit_sum,
            difficulty=(2700, 3400),
            solution=steps(
                sol("Given expression", (10^n - 1) // k),
                "Note that \\(10^{$(n)} - 1 = \\underbrace{999\\ldots9}_{$(n) \\text{ nines}}\\)",
                "When divided by $(k), we get a repeating pattern",
                "Calculate: \\(\\frac{10^{$(n)} - 1}{$(k)} = $(value)\\)",
                "Sum the digits: $(join([string(d) for d in string(value)], " + ")) = $(digit_sum)",
                sol("Answer", digit_sum)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Type 3: Find number of decimal places before pattern or specific digit
        # ELO: 2800-3500 (deep divisibility and decimal structure)
        base_primes = [3, 7, 11, 13, 17, 19, 23]
        p1 = choice(base_primes)
        p2 = choice(setdiff(base_primes, [p1]))
        denom = p1 * p2
        numer = randint(1, denom-1)
        while gcd(numer, denom) != 1
            numer = randint(1, denom-1)
        end
        
        # Find number of non-repeating digits (determined by factors of 2 and 5 in denominator)
        # Since denom has no factors of 2 or 5, non_repeating = 0
        non_repeating = 0
        
        # Find period
        temp_denom = denom
        period = 1
        remainder = 10 % temp_denom
        while remainder != 1
            remainder = (remainder * 10) % temp_denom
            period += 1
        end
        
        total_before_repeat = non_repeating + period
        
        problem(
            question="When \\(\\frac{$(numer)}{$(denom)}\\) is written as a decimal, how many digits appear before the decimal expansion begins to repeat? (Count digits immediately after the decimal point up to but not including the first repetition.)",
            answer=period,
            difficulty=(2800, 3500),
            solution=steps(
                sol("Given fraction", numer // denom),
                "Factor denominator: \\($(denom) = $(p1) \\times $(p2)\\)",
                "Since $(denom) has no factors of 2 or 5, the decimal is purely periodic",
                "The period length equals the multiplicative order of 10 modulo $(denom)",
                "Using \\(\\text{lcm}(\\text{ord}_{$(p1)}(10), \\text{ord}_{$(p2)}(10))\\), we find period = $(period)",
                sol("Answer", period)
            ),
            time=270
        )
        
    else
        # Type 4: Olympiad-style decimal equation problem
        # ELO: 3000-3600 (requires clever algebraic manipulation with decimals)
        a = randint(2, 8)
        b = randint(1, 9)
        c = randint(10, 50)
        
        # Construct: If 0.ababab... = x, then x = ab/99
        decimal_val = (10*a + b) // 99
        result = c * (10*a + b) // 99
        
        problem(
            question="If \\(0.\\overline{$(a)$(b)}\\) denotes the repeating decimal \\(0.$(a)$(b)$(a)$(b)$(a)$(b)\\ldots\\), find the value of \\($(c) \\times 0.\\overline{$(a)$(b)}\\) as a fraction in lowest terms. Enter your answer as a decimal rounded to 6 decimal places.",
            answer=round(Float64(result), digits=6),
            difficulty=(3000, 3600),
            solution=steps(
                "Let \\(x = 0.\\overline{$(a)$(b)} = 0.$(a)$(b)$(a)$(b)$(a)$(b)\\ldots\\)",
                "Then \\(100x = $(a)$(b).$(a)$(b)$(a)$(b)\\ldots\\)",
                "Subtracting: \\(100x - x = $(a)$(b)\\), so \\(99x = $(a)$(b)\\)",
                sol("Therefore", "x = " * string((10*a + b) // 99)),
                "Multiply by $(c): \\($(c) \\times \\frac{$(10*a + b)}{99} = \\frac{$(c*(10*a + b))}{99}\\)",
                sol("As decimal", round(Float64(result), digits=6))
            ),
            time=240
        )
    end
end