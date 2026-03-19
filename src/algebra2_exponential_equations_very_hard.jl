# algebra2 - exponential_equations (very_hard)
# Generated: 2026-03-08T20:20:15.660883

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/exponential_equations")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Competition: Exponential equation with logarithmic transformation
        # Difficulty: 2500-2800
        base = choice([2, 3, 5, 7])
        k = randint(2, 5)
        c = randint(10, 50)
        
        # Solve base^(kx) = c
        # Answer: x = log(c) / (k * log(base))
        ans = log(c) / (k * log(base))
        
        problem(
            question="Solve for \\(x\\): \\\$$(base)^{$(k)x} = $(c)\\\$. Express your answer as an exact value using logarithms.",
            answer="\\frac{\\log($(c))}{$(k)\\log($(base))}",
            difficulty=(2500, 2800),
            answer_type="expression",
            solution=steps(
                "Given: \\\$$(base)^{$(k)x} = $(c)\\\$",
                "Take logarithm of both sides: \\\$$(k)x \\log($(base)) = \\log($(c))\\\$",
                "Solve for \\(x\\): \\\$x = \\frac{\\log($(c))}{$(k)\\log($(base))}\\\$"
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Competition: System of exponential equations
        # Difficulty: 2600-3000
        a = randint(2, 4)
        b = randint(2, 4)
        m = randint(3, 8)
        n = randint(3, 8)
        
        # Solve: a^x * b^y = m and a^(2x) * b^y = n
        # From first: b^y = m/a^x
        # Substitute into second: a^(2x) * (m/a^x) = n
        # a^x * m = n, so a^x = n/m
        # x = log(n/m) / log(a)
        # b^y = m/a^x = m/(n/m) = m^2/n
        # y = log(m^2/n) / log(b)
        
        x_ans = log(n/m) / log(a)
        y_ans = log(m^2/n) / log(b)
        
        problem(
            question="Solve the system of equations for \\(x\\) and \\(y\\):<br>\\\$($(a))^x \\cdot $(b)^y = $(m)\\\$<br>\\\$($(a))^{2x} \\cdot $(b)^y = $(n)\\\$<br>Express your answer as an ordered pair \\((x, y)\\) using logarithms.",
            answer=fmt_tuple([x_ans, y_ans]),
            difficulty=(2600, 3000),
            answer_type="tuple",
            solution=steps(
                "From the first equation: \\\$$(b)^y = \\frac{$(m)}{$(a)^x}\\\$",
                "Substitute into the second equation: \\\$$(a)^{2x} \\cdot \\frac{$(m)}{$(a)^x} = $(n)\\\$",
                "Simplify: \\\$$(a)^x \\cdot $(m) = $(n)\\\$, so \\\$$(a)^x = \\frac{$(n)}{$(m)}\\\$",
                "Therefore: \\\$x = \\frac{\\log($(n)/$(m))}{\\log($(a))}\\\$",
                "Back-substitute: \\\$$(b)^y = \\frac{$(m)^2}{$(n)}\\\$, so \\\$y = \\frac{\\log($(m)^2/$(n))}{\\log($(b))}\\\$"
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Olympiad: Functional equation with exponentials
        # Difficulty: 3000-3400
        a = randint(2, 5)
        k = randint(2, 4)
        
        # Find all solutions to: a^(x^2) = a^(kx)
        # x^2 = kx
        # x^2 - kx = 0
        # x(x - k) = 0
        # x = 0 or x = k
        
        problem(
            question="Find all real solutions to the equation \\\$($(a))^{x^2} = $(a)^{$(k)x}\\\$.",
            answer=fmt_set(Set([0, k])),
            difficulty=(3000, 3400),
            answer_type="set",
            solution=steps(
                "Since the bases are equal and positive (≠1), we can equate exponents: \\\$x^2 = $(k)x\\\$",
                "Rearrange: \\\$x^2 - $(k)x = 0\\\$",
                "Factor: \\\$x(x - $(k)) = 0\\\$",
                "Solutions: \\\$x = 0\\\$ or \\\$x = $(k)\\\$",
                "Answer: \\\$\\{0, $(k)\\}\\\$"
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Competition: Exponential with substitution
        # Difficulty: 2700-3100
        a = randint(2, 4)
        p = randint(3, 7)
        q = randint(-10, -2)
        
        # Solve: a^(2x) + p*a^x + q = 0
        # Let u = a^x, then u^2 + p*u + q = 0
        # Discriminant
        disc = p^2 - 4*q
        
        if disc < 0
            problem_type = 5  # Retry with different type
        else
            u1 = (-p + sqrt(disc)) / 2
            u2 = (-p - sqrt(disc)) / 2
            
            sols = []
            if u1 > 0
                push!(sols, log(u1) / log(a))
            end
            if u2 > 0
                push!(sols, log(u2) / log(a))
            end
            
            if length(sols) == 0
                problem_type = 5  # Retry
            else
                problem(
                    question="Solve for \\(x\\): \\\$($(a))^{2x} + $(p) \\cdot $(a)^x + $(q) = 0\\\$. Express all solutions using logarithms.",
                    answer=fmt_set(Set(sols)),
                    difficulty=(2700, 3100),
                    answer_type="set",
                    solution=steps(
                        "Let \\\$u = $(a)^x\\\$, then the equation becomes: \\\$u^2 + $(p)u + $(q) = 0\\\$",
                        "Using the quadratic formula: \\\$u = \\frac{-$(p) \\pm \\sqrt{$(p^2) - 4($(q))}}{2}\\\$",
                        "Compute: \\\$u = \\frac{-$(p) \\pm \\sqrt{$(disc)}}{2}\\\$",
                        "Valid solutions require \\\$u > 0\\\$ (since \\\$u = $(a)^x\\\$)",
                        "For each valid \\\$u\\), solve \\\$$(a)^x = u\\\$ to get \\\$x = \\frac{\\log(u)}{\\log($(a))}\\\$"
                    ),
                    time=240
                )
            end
        end
    end
    
    if problem_type == 5
        # Olympiad: Nested exponentials
        # Difficulty: 3200-3600
        base = choice([2, 3])
        target = base^randint(2, 4)
        
        # Solve: base^(base^x) = target
        # base^x = log_base(target)
        # x = log_base(log_base(target))
        
        inner = log(target) / log(base)
        ans = log(inner) / log(base)
        
        problem(
            question="Solve for \\(x\\): \\\$($(base))^{$(base)^x} = $(target)\\\$. Express your answer using logarithms.",
            answer="\\log_{$(base)}(\\log_{$(base)}($(target)))",
            difficulty=(3200, 3600),
            answer_type="expression",
            solution=steps(
                "Given: \\\$($(base))^{$(base)^x} = $(target)\\\$",
                "Take \\\$\\log_{$(base)}\\\$ of both sides: \\\$$(base)^x = \\log_{$(base)}($(target))\\\$",
                "Compute: \\\$\\log_{$(base)}($(target)) = \\frac{\\log($(target))}{\\log($(base))}\\\$",
                "Take \\\$\\log_{$(base)}\\\$ again: \\\$x = \\log_{$(base)}\\left(\\log_{$(base)}($(target))\\right)\\\$",
                "This can also be written as: \\\$x = \\frac{\\log(\\log($(target))/\\log($(base)))}{\\log($(base))}\\\$"
            ),
            time=270
        )
        
    elseif problem_type == 6
        # Competition: Exponential inequality
        # Difficulty: 2800-3200
        base = choice([2, 3, 5])
        k = randint(2, 4)
        c = randint(5, 20)
        
        # Solve: base^(kx) > c
        # kx > log_base(c)
        # x > log_base(c) / k
        
        bound = log(c) / (k * log(base))
        ans = fmt_interval(bound, Inf, false, true)
        
        problem(
            question="Solve the inequality: \\\$($(base))^{$(k)x} > $(c)\\\$. Express your answer in interval notation using exact values.",
            answer=ans,
            difficulty=(2800, 3200),
            answer_type="interval",
            solution=steps(
                "Given: \\\$($(base))^{$(k)x} > $(c)\\\$",
                "Since \\\$$(base) > 1\\\$, taking logarithms preserves the inequality:",
                "\\\$$(k)x \\log($(base)) > \\log($(c))\\\$",
                "Solve for \\(x\\): \\\$x > \\frac{\\log($(c))}{$(k)\\log($(base))}\\\$",
                "Answer in interval notation: \\\$\\left(\\frac{\\log($(c))}{$(k)\\log($(base))}, \\infty\\right)\\\$"
            ),
            time=210
        )
    end
end