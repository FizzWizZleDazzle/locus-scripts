# arithmetic - addition (competition)
# Generated: 2026-03-08T19:45:59.714022

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("arithmetic/addition")
    
    # For Olympiad/Research-Adjacent level addition problems, we need extremely creative setups
    # These problems involve deep number theory, combinatorics, or algebraic structures
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Digit sum problem with constraints (IMO-style)
        n = randint(100, 999)
        digit_sum = sum(digits(n))
        k = randint(5, 15)
        target = n + k * digit_sum
        
        # Find how many times we add the digit sum to reach a number with specific properties
        iterations = randint(3, 8)
        current = n
        for i in 1:iterations
            current = current + sum(digits(current))
        end
        
        problem(
            question="Let \\(S(n)\\) denote the sum of digits of a positive integer \\(n\\). Starting with \\(n_0 = $(n)\\), define the sequence \\(n_{k+1} = n_k + S(n_k)\\) for \\(k \\geq 0\\). Find \\(n_{$(iterations)}\\).",
            answer=current,
            difficulty=(3500, 4000),
            solution=steps(
                "Start with \\(n_0 = $(n)\\), \\(S($(n)) = $(sum(digits(n)))\\)",
                "Compute iteratively: \\(n_1 = $(n) + $(sum(digits(n))) = $(n + sum(digits(n)))\\)",
                "Continue this process $(iterations) times, tracking digit sums at each step",
                "The sequence involves careful arithmetic and pattern recognition",
                sol("Final answer", current)
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Modular arithmetic with addition chains (competition level)
        p = choice([97, 101, 103, 107, 109, 113])  # prime modulus
        a = randint(10, 50)
        b = randint(10, 50)
        n = randint(15, 25)
        
        # Sum of powers modulo p
        result = mod(sum(mod(a^i + b^i, p) for i in 1:n), p)
        
        problem(
            question="Compute \\(\\sum_{i=1}^{$(n)} ($(a)^i + $(b)^i) \\pmod{$(p)}\\).",
            answer=result,
            difficulty=(3800, 4200),
            solution=steps(
                "Use geometric series formula for each power sum separately",
                "\\(\\sum_{i=1}^{n} a^i = a\\frac{a^n - 1}{a - 1}\\) and similarly for \\(b\\)",
                "Apply modular arithmetic properties and Fermat's Little Theorem",
                "Since $(p) is prime, \\(a^{$(p-1)} \\equiv 1 \\pmod{$(p)}\\) if \\(\\gcd(a,$(p))=1\\)",
                "Compute each geometric sum modulo $(p) and add",
                sol("Final answer", result)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Combinatorial sum (USAMO-style)
        n = randint(8, 15)
        k = randint(3, min(6, n-2))
        
        # Sum involving binomial coefficients
        result = sum(binomial(i, k) for i in k:n)
        # This equals binomial(n+1, k+1) by hockey stick identity
        expected = binomial(n+1, k+1)
        
        problem(
            question="Evaluate \\(\\sum_{i=$(k)}^{$(n)} \\binom{i}{$(k)}\\).",
            answer=expected,
            difficulty=(3600, 4000),
            solution=steps(
                "Apply the Hockey Stick Identity (also known as Christmas Stocking Theorem)",
                "\\(\\sum_{i=r}^{n} \\binom{i}{r} = \\binom{n+1}{r+1}\\)",
                "This follows from Pascal's identity by induction",
                "Substitute \\(r = $(k)\\) and \\(n = $(n)\\)",
                sol("Answer", expected)
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Nested radical addition problem
        a = choice([2, 3, 5, 6, 7, 10])
        b = choice([2, 3, 5, 6, 7, 10])
        c = randint(1, 4)
        
        # Expression like sqrt(a + sqrt(b)) + sqrt(a - sqrt(b))
        # Squaring gives 2a + 2*sqrt(a^2 - b)
        inner = a^2 - b
        if inner > 0 && isinteger(sqrt(inner))
            simplified = 2 * isqrt(inner)
        else
            simplified = a + b + c
        end
        
        problem(
            question="Let \\(x = \\sqrt{$(a) + \\sqrt{$(b)}} + \\sqrt{$(a) - \\sqrt{$(b)}}\\). If \\(x^2\\) can be expressed as \\(p + q\\sqrt{r}\\) where \\(r\\) is square-free, find \\(p + q + r\\).",
            answer=2*a + 2 + (a^2 - b),
            difficulty=(3700, 4100),
            solution=steps(
                "Let \\(x = \\sqrt{$(a) + \\sqrt{$(b)}} + \\sqrt{$(a) - \\sqrt{$(b)}}\\)",
                "Square both sides: \\(x^2 = ($(a) + \\sqrt{$(b)}) + ($(a) - \\sqrt{$(b)}) + 2\\sqrt{($(a) + \\sqrt{$(b)})($(a) - \\sqrt{$(b)})}\\)",
                "Simplify: \\(x^2 = $(2*a) + 2\\sqrt{$(a)^2 - $(b)} = $(2*a) + 2\\sqrt{$(a^2 - b)}\\)",
                "Therefore \\(p = $(2*a)\\), \\(q = 2\\), \\(r = $(a^2 - b)\\)",
                sol("Answer", 2*a + 2 + (a^2 - b))
            ),
            time=270
        )
        
    else
        # Number theory: sum of divisors function
        n = choice([12, 18, 20, 24, 28, 30, 36, 40, 42, 48])
        divs = [d for d in 1:n if n % d == 0]
        sigma = sum(divs)
        
        # Find k such that sigma(k) = target
        target = sigma + randint(5, 20)
        
        problem(
            question="Let \\(\\sigma(n)\\) denote the sum of all positive divisors of \\(n\\). Given that \\(\\sigma($(n)) = $(sigma)\\), find the smallest positive integer \\(m > $(n)\\) such that \\(\\sigma(m) - \\sigma($(n)) = $(target - sigma)\\).",
            answer=target - sigma + n,
            difficulty=(3900, 4300),
            solution=steps(
                "First compute \\(\\sigma($(n))\\) by finding all divisors of $(n)",
                "Divisors of $(n): $(join(divs, ", "))",
                "Sum: \\(\\sigma($(n)) = $(sigma)\\)",
                "We need \\(\\sigma(m) = $(target)\\)",
                "Use multiplicativity of \\(\\sigma\\) and prime factorization",
                "Systematically check values or use divisor formulas",
                sol("Answer", target)
            ),
            time=300
        )
    end
end