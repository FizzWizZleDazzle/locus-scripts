# arithmetic - multiplication (competition)
# Generated: 2026-03-08T19:47:14.253090

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z n k begin
    set_topic!("arithmetic/multiplication")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Multiplicative number theory: Find all n such that n! ends in exactly k zeros
        k = randint(15, 40)
        
        # Legendre's formula: highest power of p dividing n! is sum(floor(n/p^i))
        # For trailing zeros, we need highest power of 5 (since 2s are plentiful)
        function trailing_zeros(n)
            count = 0
            power = 5
            while power <= n
                count += div(n, power)
                power *= 5
            end
            return count
        end
        
        # Find n such that trailing_zeros(n) = k
        low = 5 * k
        high = 5 * k + 10
        
        valid_n = []
        for n_test in low:high
            if trailing_zeros(n_test) == k
                push!(valid_n, n_test)
            end
        end
        
        ans = fmt_set(Set(valid_n))
        
        problem(
            question="Find all positive integers \\(n\\) such that \\(n!\\) ends in exactly \\($(k)\\) zeros when written in base 10.",
            answer=ans,
            difficulty=(3500, 4000),
            answer_type="set",
            solution=steps(
                "The number of trailing zeros in \\(n!\\) equals the highest power of 5 dividing \\(n!\\) (since powers of 2 are always more abundant).",
                "By Legendre's formula: \\(\\nu_5(n!) = \\lfloor n/5 \\rfloor + \\lfloor n/25 \\rfloor + \\lfloor n/125 \\rfloor + \\cdots\\)",
                "We need \\(\\nu_5(n!) = $(k)\\). Testing values near \\(5 \\times $(k) = $(5*k)\\):",
                sol("Answer", ans)
            ),
            time=480
        )
        
    elseif problem_type == 2
        # Digit product: Find all n-digit numbers where product of digits equals a specific value
        target_product = choice([64, 72, 96, 108, 120, 144, 162, 180, 192, 216, 240])
        n_digits = 3
        
        # Count solutions
        function count_digit_products(n_digits, target, current_product=1, position=1, first_digit=true)
            if position > n_digits
                return current_product == target ? 1 : 0
            end
            
            count = 0
            start_digit = first_digit ? 1 : 0
            
            for d in start_digit:9
                new_product = current_product * d
                if new_product <= target && target % new_product == 0
                    count += count_digit_products(n_digits, target, new_product, position + 1, false)
                end
            end
            
            return count
        end
        
        ans = count_digit_products(n_digits, target_product)
        
        problem(
            question="How many \\($(n_digits)\\)-digit positive integers have the property that the product of their digits equals \\($(target_product)\\)?",
            answer=ans,
            difficulty=(3600, 4200),
            solution=steps(
                "Factor \\($(target_product)\\) using only digits 1-9: find all ordered sequences of \\($(n_digits)\\) digits whose product is \\($(target_product)\\).",
                "Use recursive counting with backtracking: at each position, try digits \\(d\\) where \\(d\\) divides the remaining target.",
                "Account for leading digit constraint (cannot be 0).",
                sol("Answer", ans)
            ),
            time=600
        )
        
    elseif problem_type == 3
        # Multiplicative order: Find the smallest k such that a^k ≡ 1 (mod m)
        primes = [17, 19, 23, 29, 31, 37, 41, 43, 47, 53]
        p = choice(primes)
        a = randint(2, p-2)
        
        # Find multiplicative order
        function mult_order(a, p)
            for k in 1:(p-1)
                if powermod(a, k, p) == 1
                    return k
                end
            end
            return p - 1
        end
        
        ans = mult_order(a, p)
        
        problem(
            question="Find the smallest positive integer \\(k\\) such that \\($(a)^k \\equiv 1 \\pmod{$(p)}\\).",
            answer=ans,
            difficulty=(3400, 3800),
            solution=steps(
                "We seek the multiplicative order of \\($(a)\\) modulo \\($(p)\\).",
                "By Fermat's Little Theorem, \\($(a)^{$(p-1)} \\equiv 1 \\pmod{$(p)}\\), so \\(k \\mid $(p-1)\\).",
                "Test divisors of \\($(p-1)\\) in ascending order until \\($(a)^k \\equiv 1 \\pmod{$(p)}\\).",
                sol("Answer", ans)
            ),
            time=360
        )
        
    elseif problem_type == 4
        # Product of specific form: compute product of (1 - 1/p^2) for primes up to N
        N = choice([11, 13, 17, 19, 23])
        primes_list = filter(isprime, 2:N)
        
        # Compute product as rational
        product_num = 1
        product_den = 1
        
        for p in primes_list
            product_num *= (p^2 - 1)
            product_den *= p^2
        end
        
        g = gcd(product_num, product_den)
        product_num = div(product_num, g)
        product_den = div(product_den, g)
        
        ans = "$(product_num)/$(product_den)"
        
        problem(
            question="Compute the product \\(\\prod_{p \\text{ prime}, p \\leq $(N)} \\left(1 - \\frac{1}{p^2}\\right)\\). Express your answer as a fraction in lowest terms.",
            answer=ans,
            difficulty=(3700, 4100),
            solution=steps(
                "The primes up to \\($(N)\\) are: \\($(join(primes_list, ", "))\\).",
                "Compute: \\(\\prod \\left(1 - \\frac{1}{p^2}\\right) = \\prod \\frac{p^2 - 1}{p^2}\\).",
                "Multiply numerators and denominators separately, then reduce.",
                sol("Answer", "\\frac{$(product_num)}{$(product_den)}")
            ),
            time=420
        )
        
    else
        # Double factorial congruence: compute n!! mod m
        n = randint(25, 50)
        m = choice([7, 11, 13, 17, 19, 23])
        
        # Compute n!! = n * (n-2) * (n-4) * ... mod m
        function double_factorial_mod(n, m)
            result = 1
            current = n
            while current >= 1
                result = mod(result * current, m)
                current -= 2
            end
            return result
        end
        
        ans = double_factorial_mod(n, m)
        
        problem(
            question="Compute \\($(n)!! \\bmod $(m)\\), where \\(n!! = n \\cdot (n-2) \\cdot (n-4) \\cdots\\) is the double factorial.",
            answer=ans,
            difficulty=(3500, 3900),
            solution=steps(
                "The double factorial \\($(n)!!\\) is the product of all positive integers up to \\($(n)\\) with the same parity as \\($(n)\\).",
                "Compute the product modulo \\($(m)\\) to avoid overflow: multiply each term and reduce.",
                "\\($(n)!! = $(n) \\cdot $(n-2) \\cdot $(n-4) \\cdots \\pmod{$(m)}\\).",
                sol("Answer", ans)
            ),
            time=300
        )
    end
end