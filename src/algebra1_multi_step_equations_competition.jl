# algebra1 - multi_step_equations (competition)
# Generated: 2026-03-08T19:54:07.506949

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra1/multi_step_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: System with nested radicals and special structure
        a = randint(2, 5)
        b = randint(2, 5)
        k = randint(3, 8)
        
        # Answer is designed so x^2 + y^2 = k^2, xy = a*b
        r1 = randint(2, 6)
        r2 = k^2 - r1^2
        if r2 <= 0
            r1 = 2
            r2 = k^2 - 4
        end
        
        x_val = r1
        y_val = isqrt(r2)
        if y_val^2 != r2
            y_val = r1
            x_val = r1
        end
        
        sum_val = x_val + y_val
        prod_val = x_val * y_val
        
        problem(
            question="Let \\(x\\) and \\(y\\) be positive real numbers satisfying \\[x + y = $(sum_val)\\] and \\[x^2 + y^2 = $(x_val^2 + y_val^2).\\] Find the value of \\(x^3 + y^3\\).",
            answer=x_val^3 + y_val^3,
            difficulty=(3500, 4000),
            solution=steps(
                "Given: \\(x + y = $(sum_val)\\) and \\(x^2 + y^2 = $(x_val^2 + y_val^2)\\)",
                "From \\((x+y)^2 = x^2 + 2xy + y^2\\), we get \\($(sum_val^2) = $(x_val^2 + y_val^2) + 2xy\\)",
                "Therefore \\(xy = $(prod_val)\\)",
                "Using \\(x^3 + y^3 = (x+y)^3 - 3xy(x+y)\\)",
                sol("Answer", x_val^3 + y_val^3)
            ),
            time=240
        )
        
    elseif problem_type == 2
        # Research-adjacent: Functional equation with algebraic manipulation
        a = randint(3, 12)
        b = randint(2, 8)
        c = randint(5, 15)
        
        # Design so that f(a) has a clean solution
        # If f(x) = mx + n, then f(f(x)) = m(mx+n) + n = m²x + mn + n
        m = randint(2, 4)
        n = randint(-5, 5)
        
        target = m^2 * a + m*n + n + c
        answer = m * a + n
        
        problem(
            question="Suppose \\(f(x)\\) is a linear function such that \\[f(f(x)) + $(c) = $(target)\\] when \\(x = $(a)\\). If \\(f($(b)) = $(m*b + n)\\), find \\(f($(a))\\).",
            answer=answer,
            difficulty=(3800, 4500),
            solution=steps(
                "Since \\(f\\) is linear, let \\(f(x) = mx + n\\)",
                "Given \\(f($(b)) = $(m*b + n)\\), we have \\($(m)m + n = $(m*b + n)\\), so \\(m = $(m)\\) and we can solve for \\(n\\)",
                "Then \\(f(f(x)) = m^2 x + mn + n\\)",
                "Substituting \\(x = $(a)\\): \\($(m^2) \\cdot $(a) + $(m)n + n + $(c) = $(target)\\)",
                "Solving yields \\(n = $(n)\\), thus \\(f($(a)) = $(m) \\cdot $(a) + $(n)\\)",
                sol("Answer", answer)
            ),
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Diophantine-style equation with constraints
        p = rand([3, 5, 7, 11, 13])
        q = rand([2, 3, 5, 7])
        k = randint(20, 50)
        
        # Find integer solutions to px + qy = k where x, y > 0
        solutions = []
        for i in 1:div(k, p)
            remainder = k - p*i
            if remainder > 0 && remainder % q == 0
                j = div(remainder, q)
                if j > 0
                    push!(solutions, (i, j))
                end
            end
        end
        
        if isempty(solutions)
            # Fallback
            p = 3
            q = 2
            k = 24
            solutions = [(2, 9), (4, 6), (6, 3)]
        end
        
        answer = length(solutions)
        
        problem(
            question="How many pairs of positive integers \\((x, y)\\) satisfy the equation \\[$(p)x + $(q)y = $(k)?\\]",
            answer=answer,
            difficulty=(3600, 4200),
            solution=steps(
                "We need \\($(p)x + $(q)y = $(k)\\) with \\(x, y \\geq 1\\)",
                "Rearranging: \\(y = \\frac{$(k) - $(p)x}{$(q)}\\)",
                "For \\(y\\) to be a positive integer, \\($(k) - $(p)x\\) must be positive and divisible by \\($(q)\\)",
                "Testing values \\(x = 1, 2, 3, \\ldots\\) until \\($(p)x < $(k)\\)",
                "We find exactly $(answer) valid pair(s)",
                sol("Answer", answer)
            ),
            time=270
        )
        
    elseif problem_type == 4
        # Research-adjacent: Nested absolute value equation
        a = randint(3, 10)
        b = randint(2, 8)
        c = randint(5, 15)
        
        # Design: |x - a| + |x - b| = c where a < b
        if a > b
            a, b = b, a
        end
        
        # Solution exists when c >= b - a
        gap = b - a
        if c < gap
            c = gap + randint(2, 8)
        end
        
        # Solutions: when a <= x <= b, sum is constant = gap
        # When x < a: -(x-a) - (x-b) = c => -2x + a + b = c => x = (a+b-c)/2
        # When x > b: (x-a) + (x-b) = c => 2x - a - b = c => x = (a+b+c)/2
        
        x1 = (a + b - c) // 2
        x2 = (a + b + c) // 2
        
        if c == gap
            answer = fmt_interval(a, b, true, true)
        else
            answer = fmt_set(Set([x1, x2]))
        end
        
        problem(
            question="Solve for all real \\(x\\): \\[|x - $(a)| + |x - $(b)| = $(c)\\]",
            answer=answer,
            difficulty=(3700, 4300),
            answer_type=(c == gap ? "interval" : "set"),
            solution=steps(
                "Consider three cases based on the critical points \\(x = $(a)\\) and \\(x = $(b)\\)",
                "Case 1: \\(x < $(a)\\) gives \\(-(x-$(a)) - (x-$(b)) = $(c)\\)",
                "Case 2: \\($(a) \\leq x \\leq $(b)\\) gives \\((x-$(a)) - (x-$(b)) = $(gap)\\)",
                "Case 3: \\(x > $(b)\\) gives \\((x-$(a)) + (x-$(b)) = $(c)\\)",
                "Solving each case and checking validity",
                sol("Answer", answer)
            ),
            time=300
        )
        
    else
        # Olympiad: Symmetric polynomial system
        s = randint(8, 20)  # x + y + z
        p = randint(40, 100)  # xy + yz + zx
        
        # Choose values that work
        x_val = randint(3, 6)
        y_val = randint(3, 6)
        z_val = s - x_val - y_val
        
        if z_val <= 0
            z_val = randint(3, 6)
            s = x_val + y_val + z_val
        end
        
        p = x_val*y_val + y_val*z_val + z_val*x_val
        q = x_val * y_val * z_val
        
        target = x_val^2 + y_val^2 + z_val^2
        
        problem(
            question="Let \\(x, y, z\\) be real numbers satisfying \\[x + y + z = $(s)\\] and \\[xy + yz + zx = $(p).\\] Find the value of \\(x^2 + y^2 + z^2\\).",
            answer=target,
            difficulty=(3500, 4000),
            solution=steps(
                "Use the identity \\((x+y+z)^2 = x^2 + y^2 + z^2 + 2(xy + yz + zx)\\)",
                "Substituting: \\(($(s))^2 = x^2 + y^2 + z^2 + 2($(p))\\)",
                "Therefore \\($(s^2) = x^2 + y^2 + z^2 + $(2*p)\\)",
                "Solving: \\(x^2 + y^2 + z^2 = $(s^2) - $(2*p)\\)",
                sol("Answer", target)
            ),
            time=240
        )
    end
end