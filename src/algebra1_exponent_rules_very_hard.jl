# algebra1 - exponent_rules (very_hard)
# Generated: 2026-03-08T19:59:03.292998

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/exponent_rules")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Competition-level: Solve exponential Diophantine equation
        # e.g., 2^x + 2^y = 2^z where x, y, z are positive integers with x < y
        base = choice([2, 3, 5])
        x_val = randint(2, 6)
        y_val = randint(x_val + 1, x_val + 4)
        
        # Create equation: base^x + base^y = base^z
        # Factor: base^x(1 + base^(y-x)) = base^z
        # So base^(z-x) = 1 + base^(y-x)
        
        # Only works if 1 + base^(y-x) is a power of base (rare!)
        # Instead: create specific case where base^x + base^y = base^x * (1 + base^(y-x))
        # Special case: if y-x = 1 and base = 2, then 2^x + 2^(x+1) = 2^x(1+2) = 3*2^x
        
        # Better approach: x + y = z in exponents with constraint
        # or solve 3^(2x) - 8*3^x - 9 = 0 (quadratic in 3^x)
        
        a = randint(1, 4)
        b = randint(8, 20)
        c = randint(5, 15)
        
        # Solve base^(2x) - b*base^x - c = 0
        # Let u = base^x, then u^2 - b*u - c = 0
        # Find integer solutions
        
        discriminant = b^2 + 4*c
        sqrt_disc = isqrt(discriminant)
        
        if sqrt_disc^2 == discriminant && (b + sqrt_disc) % 2 == 0
            u_pos = div(b + sqrt_disc, 2)
            # Check if u_pos is power of base
            if u_pos > 0
                log_val = log(u_pos) / log(base)
                if abs(log_val - round(log_val)) < 0.001
                    x_ans = round(Int, log_val)
                else
                    x_ans = randint(2, 5)
                    u_pos = base^x_ans
                    c = u_pos^2 - b*u_pos
                end
            else
                x_ans = randint(2, 4)
                u_pos = base^x_ans
                c = u_pos^2 - b*u_pos
            end
        else
            x_ans = randint(2, 4)
            u_pos = base^x_ans
            c = u_pos^2 - b*u_pos
        end
        
        problem(
            question="Solve for \\(x\\) (positive integer): \\($(base)^{2x} - $(b) \\cdot $(base)^x - $(c) = 0\\)",
            answer=x_ans,
            difficulty=(2500, 2900),
            solution=steps(
                "Let \\(u = $(base)^x\\), then \\(u^2 - $(b)u - $(c) = 0\\)",
                "Using quadratic formula: \\(u = \\frac{$(b) \\pm \\sqrt{$(b^2) + $(4*c)}}{2}\\)",
                "Solve for positive \\(u\\): \\(u = $(base^x_ans)\\)",
                sol("Since \\($(base)^x = $(base^x_ans) = $(base)^{$(x_ans)}\\), we have", x_ans)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Olympiad-level: Prove/find constraint on exponents
        # Find all positive integers n such that 2^n + 1 divides 3^n - 1
        
        # Or: find integers such that (a^m - b^m) / (a^n - b^n) is integer
        a = choice([2, 3, 5])
        b = choice([1, 2])
        m = randint(4, 8)
        
        # Find divisors of m for valid n
        divisors = [d for d in 1:m if m % d == 0]
        n = choice(divisors[2:end])  # Don't pick 1
        
        val_m = a^m - b^m
        val_n = a^n - b^n
        ratio = div(val_m, val_n)
        
        problem(
            question="Find the positive integer \\(k\\) such that \\(\\frac{$(a)^{$(m)} - $(b)^{$(m)}}{$(a)^{$(n)} - $(b)^{$(n)}} = k\\)",
            answer=ratio,
            difficulty=(2800, 3200),
            solution=steps(
                "Note that \\($(m) = $(div(m,n)) \\cdot $(n)\\), so we can factor",
                "\\($(a)^{$(m)} - $(b)^{$(m)} = ($(a)^{$(n)})^{$(div(m,n))} - ($(b)^{$(n)})^{$(div(m,n))}\\)",
                "Using \\(x^k - y^k = (x-y)(x^{k-1} + x^{k-2}y + \\cdots + y^{k-1})\\)",
                "After factoring and simplification",
                sol("Answer", ratio)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Competition: System with exponential constraints
        # Solve: x^a * y^b = c and x^d * y^e = f where x,y are positive integers
        
        x_ans = randint(2, 5)
        y_ans = randint(2, 5)
        a = randint(2, 4)
        b = randint(2, 4)
        d = randint(1, 3)
        e = randint(1, 3)
        
        c = x_ans^a * y_ans^b
        f = x_ans^d * y_ans^e
        
        problem(
            question="Find the ordered pair \\((x, y)\\) of positive integers satisfying: \\(x^{$(a)} \\cdot y^{$(b)} = $(c)\\) and \\(x^{$(d)} \\cdot y^{$(e)} = $(f)\\)",
            answer=fmt_tuple([x_ans, y_ans]),
            difficulty=(2600, 3100),
            answer_type="tuple",
            solution=steps(
                "Take logarithms or use prime factorization of both equations",
                "From \\(x^{$(a)} \\cdot y^{$(b)} = $(c)\\) and \\(x^{$(d)} \\cdot y^{$(e)} = $(f)\\)",
                "Test small integer values systematically",
                "Verify: \\($(x_ans)^{$(a)} \\cdot $(y_ans)^{$(b)} = $(c)\\) ✓",
                sol("Answer", fmt_tuple([x_ans, y_ans]))
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Olympiad: Exponential congruence or pattern
        # Find last digit of a^b or find n such that 2^n ≡ k (mod m)
        
        base = choice([2, 3, 7])
        exp = randint(15, 35)
        
        # Find last digit of base^exp (compute mod 10)
        last_digit = powermod(base, exp, 10)
        
        problem(
            question="Find the last digit (units digit) of \\($(base)^{$(exp)}\\)",
            answer=last_digit,
            difficulty=(2400, 2800),
            solution=steps(
                "Find the pattern of last digits for powers of $(base)",
                "The last digits cycle with period \\(\\phi(10) = 4\\) for coprime bases",
                "Compute \\($(base)^{$(exp)} \\pmod{10}\\)",
                "\\($(exp) \\equiv $(exp % 4) \\pmod{4}\\)" * (exp % 4 == 0 ? " (≡ 0, use cycle)" : ""),
                sol("Last digit", last_digit)
            ),
            time=210
        )
        
    else
        # Olympiad: Find number of solutions or prove constraint
        # e.g., how many positive integer solutions to a^x = b^y + c?
        
        a = choice([2, 3])
        b = choice([2, 3, 5])
        c = randint(1, 10)
        
        # Find x, y such that a^x = b^y + c
        # Generate one solution
        y_ans = randint(2, 5)
        target = b^y_ans + c
        
        # Check if target is power of a
        log_a = log(target) / log(a)
        if abs(log_a - round(log_a)) < 0.01
            x_ans = round(Int, log_a)
        else
            # Construct backward
            x_ans = randint(3, 6)
            target = a^x_ans
            c = target - b^y_ans
        end
        
        problem(
            question="Find the smallest positive integer \\(x\\) such that \\($(a)^x = $(b)^y + $(c)\\) has a positive integer solution \\(y\\)",
            answer=x_ans,
            difficulty=(3000, 3500),
            solution=steps(
                "Test small values of \\(y\\) and check if \\($(b)^y + $(c)\\) is a power of $(a)",
                "For \\(y = $(y_ans)\\): \\($(b)^{$(y_ans)} + $(c) = $(b^y_ans) + $(c) = $(target)\\)",
                "Check: \\($(target) = $(a)^{$(x_ans)}\\) ✓",
                "Verify this is the smallest such \\(x\\)",
                sol("Answer", x_ans)
            ),
            time=300
        )
    end
end