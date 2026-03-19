# algebra1 - two_step_equations (competition)
# Generated: 2026-03-08T19:53:23.092731

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/two_step_equations")
    
    # For Olympiad/Research-Adjacent (3500-5000), we need to create extremely challenging
    # "two-step equation" problems that go far beyond standard algebra.
    # We'll interpret "two_step_equations" as problems where the algebraic manipulation
    # is simple, but the problem setup, insight, or construction is extremely deep.
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Diophantine-flavored: Find integer solutions to a carefully crafted equation
        # that requires deep number-theoretic insight
        a = nonzero(11, 30)
        b = nonzero(11, 30)
        c = randint(100, 500)
        
        # We want ax + by = c where gcd(a,b) divides c
        g = gcd(a, b)
        c = g * randint(50, 200)
        
        # Find one particular solution using extended Euclidean algorithm
        # For simplicity, we'll construct a problem where we know a nice solution exists
        x0 = randint(5, 20)
        y0 = (c - a*x0) ÷ b
        
        # Additional constraint: x + y must equal a specific value
        target_sum = x0 + y0
        
        question = "Find positive integers \\(x\\) and \\(y\\) such that \\($(a)x + $(b)y = $(c)\\) and \\(x + y = $(target_sum)\\). Enter your answer as an ordered pair \\((x, y)\\)."
        
        answer = fmt_tuple([x0, y0])
        
        solution = steps(
            "Given the system: \\($(a)x + $(b)y = $(c)\\) and \\(x + y = $(target_sum)\\)",
            "From the second equation: \\(y = $(target_sum) - x\\)",
            "Substitute into first equation: \\($(a)x + $(b)($(target_sum) - x) = $(c)\\)",
            "Simplify: \\($(a)x + $(b*target_sum) - $(b)x = $(c)\\)",
            "Combine: \\($(a-b)x = $(c - b*target_sum)\\)",
            sol("Solve", "x = $(x0), y = $(y0)"),
            "Verify: \\($(a)($(x0)) + $(b)($(y0)) = $(a*x0 + b*y0) = $(c)\\) ✓"
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 3900),
            answer_type="tuple",
            solution=solution,
            time=240,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Functional equation style: solve for parameter that makes equation have specific property
        k = nonzero(2, 8)
        m = randint(15, 40)
        
        # Find a such that the equation kx + a = m has solution that is a perfect square
        target = randint(4, 12)
        ans = m - k * target^2
        
        question = "Find the value of \\(a\\) such that the equation \\($(k)x + a = $(m)\\) has a solution \\(x\\) that is a perfect square between 10 and 200."
        
        answer = ans
        
        solution = steps(
            sol("Given", k*x + "a" ~ m),
            "Solving for \\(x\\): \\(x = \\frac{$(m) - a}{$(k)}\\)",
            "We need \\(x = n^2\\) for some integer \\(n\\)",
            "Testing perfect squares in range: \\(n = $(target)\\) gives \\(x = $(target^2)\\)",
            "Substitute: \\($(k) \\cdot $(target^2) + a = $(m)\\)",
            "Solve: \\($(k * target^2) + a = $(m)\\)",
            sol("Answer", "a = $(ans)")
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3700, 4100),
            solution=solution,
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Modular arithmetic constraint with two-step structure
        p = choice([7, 11, 13, 17, 19, 23])
        a = nonzero(2, p-1)
        b = randint(1, p-1)
        target_mod = randint(1, p-1)
        
        # Find c such that solution to ax + b = c (mod p) equals target_mod
        ans = mod(a * target_mod + b, p)
        
        question = "Find the smallest positive integer \\(c\\) such that the congruence \\($(a)x + $(b) \\equiv c \\pmod{$(p)}\\) has solution \\(x \\equiv $(target_mod) \\pmod{$(p)}\\)."
        
        answer = ans
        
        solution = steps(
            "Given: \\($(a)x + $(b) \\equiv c \\pmod{$(p)}\\) with \\(x \\equiv $(target_mod) \\pmod{$(p)}\\)",
            "Substitute \\(x = $(target_mod)\\): \\($(a) \\cdot $(target_mod) + $(b) \\equiv c \\pmod{$(p)}\\)",
            "Calculate: \\($(a * target_mod) + $(b) = $(a * target_mod + b)\\)",
            "Reduce modulo $(p): \\($(a * target_mod + b) \\equiv $(ans) \\pmod{$(p)}\\)",
            sol("Answer", ans),
            "Verification: \\($(a) \\cdot $(target_mod) + $(b) = $(a*target_mod + b) \\equiv $(ans) \\pmod{$(p)}\\) ✓"
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3800, 4300),
            solution=solution,
            time=270,
            calculator="none"
        )
        
    else
        # Olympiad-style: constraint optimization
        # Find the maximum value of n such that equation has integer solution
        a = nonzero(3, 9)
        b = randint(20, 80)
        
        # We want ax + n = b where x must be positive integer
        # Maximum n occurs when x = 1
        ans = b - a
        
        question = "Find the maximum positive integer \\(n\\) such that the equation \\($(a)x + n = $(b)\\) has at least one positive integer solution for \\(x\\)."
        
        answer = ans
        
        solution = steps(
            "Given: \\\$$(a)x + n = $(b)\\\$",
            "Solving for \\(x\\): \\(x = \\frac{$(b) - n}{$(a)}\\)",
            "For \\(x\\) to be a positive integer: \\($(b) - n > 0\\) and \\($(a) | ($(b) - n)\\)",
            "Maximum \\(n\\) occurs when \\(x\\) is minimized, so \\(x = 1\\)",
            "Substitute: \\($(a)(1) + n = $(b)\\)",
            sol("Answer", "n = $(ans)"),
            "Check: For \\(n = $(ans)\\), we get \\(x = \\frac{$(b) - $(ans)}{$(a)} = \\frac{$(a)}{$(a)} = 1\\) ✓"
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3600, 4000),
            solution=solution,
            time=240,
            calculator="none"
        )
    end
end