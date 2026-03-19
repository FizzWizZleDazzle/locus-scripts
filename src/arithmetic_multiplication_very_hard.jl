# arithmetic - multiplication (very_hard)
# Generated: 2026-03-08T19:46:52.764031

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/multiplication")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition level: Find product patterns in large factorials
        n = randint(15, 25)
        k = randint(3, 8)
        
        # Count trailing zeros in n! when expressed in base k
        count = 0
        temp_n = n
        p = randint(2, min(k-1, 7))
        while p <= k
            if k % p == 0
                power = 0
                temp_k = k
                while temp_k % p == 0
                    power += 1
                    temp_k ÷= p
                end
                
                contribution = 0
                divisor = p
                while divisor <= n
                    contribution += n ÷ divisor
                    divisor *= p
                end
                
                if count == 0
                    count = contribution ÷ power
                else
                    count = min(count, contribution ÷ power)
                end
            end
            p += 1
        end
        
        ans = count
        
        problem(
            question="How many trailing zeros does \\($(n)!\\) have when written in base \\($(k)\\)?",
            answer=ans,
            difficulty=(2500, 2900),
            solution=steps(
                "Find prime factorization of base $(k)",
                "Count powers of each prime factor in $(n)!",
                "Minimum ratio gives trailing zeros",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad level: Multiplicative number theory
        m = randint(100, 300)
        
        # Count positive integers n ≤ m such that n·φ(n) is a perfect square
        count = 0
        for n in 1:m
            phi_n = n
            temp = n
            p = 2
            while p * p <= temp
                if temp % p == 0
                    phi_n -= phi_n ÷ p
                    while temp % p == 0
                        temp ÷= p
                    end
                end
                p += 1
            end
            if temp > 1
                phi_n -= phi_n ÷ temp
            end
            
            product = n * phi_n
            sqrt_prod = isqrt(product)
            if sqrt_prod * sqrt_prod == product
                count += 1
            end
        end
        
        ans = count
        
        problem(
            question="How many positive integers \\(n \\leq $(m)\\) satisfy that \\(n \\cdot \\varphi(n)\\) is a perfect square?",
            answer=ans,
            difficulty=(3000, 3500),
            solution=steps(
                "For \\(n \\cdot \\varphi(n)\\) to be a perfect square, analyze prime factorizations",
                "Check each \\(n \\leq $(m)\\) individually",
                "Count satisfying values",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Competition level: Product of arithmetic sequence
        a = randint(2, 8)
        d = randint(2, 6)
        n = randint(4, 7)
        
        # Product: a(a+d)(a+2d)...(a+(n-1)d)
        product = 1
        for i in 0:(n-1)
            product *= (a + i*d)
        end
        
        # Find largest prime factor
        ans = 2
        temp = product
        p = 2
        while p * p <= temp
            if temp % p == 0
                ans = max(ans, p)
                while temp % p == 0
                    temp ÷= p
                end
            end
            p += 1
        end
        if temp > 1
            ans = max(ans, temp)
        end
        
        terms = join(["$(a + i*d)" for i in 0:(n-1)], " \\cdot ")
        
        problem(
            question="What is the largest prime factor of \\($(terms)\\)?",
            answer=ans,
            difficulty=(2600, 3000),
            solution=steps(
                sol("Product", product),
                "Factor $(product) into primes",
                "Identify largest prime divisor",
                sol("Answer", ans)
            ),
            time=200
        )
        
    else
        # Competition level: Multiplicative functions
        N = randint(50, 120)
        
        # Count divisors d of N! such that d² divides N!
        # First compute N!
        fact_primes = Dict{Int,Int}()
        for n in 2:N
            temp = n
            p = 2
            while p * p <= temp
                if temp % p == 0
                    count_p = 0
                    while temp % p == 0
                        count_p += 1
                        temp ÷= p
                    end
                    fact_primes[p] = get(fact_primes, p, 0) + count_p
                end
                p += 1
            end
            if temp > 1
                fact_primes[temp] = get(fact_primes, temp, 0) + 1
            end
        end
        
        # d² divides N! means for each prime p, if p^k || d, then 2k ≤ exponent in N!
        ans = 1
        for (p, exp) in fact_primes
            ans *= (exp ÷ 2 + 1)
        end
        
        problem(
            question="How many positive divisors \\(d\\) of \\($(N)!\\) satisfy \\(d^2 \\mid $(N)!\\)?",
            answer=ans,
            difficulty=(2700, 3200),
            solution=steps(
                "Find prime factorization of $(N)!",
                "For each prime \\(p^e\\) in factorization, \\(d\\) can have \\(p^k\\) where \\(2k \\leq e\\)",
                "Multiply choices: \\(\\prod (\\lfloor e/2 \\rfloor + 1)\\)",
                sol("Answer", ans)
            ),
            time=280
        )
    end
end