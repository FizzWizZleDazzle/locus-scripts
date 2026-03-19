# algebra2 - exponential_equations (competition)
# Generated: 2026-03-08T20:20:23.141015

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/exponential_equations")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Nested exponential equation with substitution: a^(b^x) = a^k → find x
        # Olympiad level: requires careful logarithmic analysis
        a = choice([2, 3, 5, 7])
        b = choice([2, 3, 4, 5])
        x_ans = randint(2, 5)
        k = b^x_ans
        
        lhs = a^(b^x)
        rhs = a^k
        
        solution_text = steps(
            sol("Given equation", lhs ~ rhs),
            "Since the bases are equal, we have \$$(tex(b^x)) = $(k)\$",
            sol("Take logarithm base $(b)", x ~ log(b, k)),
            sol("Simplify", x ~ x_ans),
            sol("Answer", x_ans)
        )
        
        problem(
            question="Solve for \\(x\\): \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=x_ans,
            difficulty=(3500, 3800),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # System with exponential substitution: a^x + a^(-x) = k
        # Find a^x + a^(-2x) or similar
        a = choice([2, 3])
        t = randint(3, 6)  # a^x + a^(-x) = t
        
        # If a^x = u, then u + 1/u = t → u^2 - tu + 1 = 0
        # u = (t ± sqrt(t^2 - 4))/2
        discriminant = t^2 - 4
        u1_num = t + isqrt(discriminant)
        u2_num = t - isqrt(discriminant)
        
        # Want to find a^x + a^(-2x) = u + 1/u^2
        # Using u + 1/u = t, we can find u + 1/u^2
        
        # Let's compute: if u + 1/u = t, then u^2 + 1 = tu
        # u^3 + u = tu^2, so u^3 = tu^2 - u
        # 1/u^2 = 1/u^2
        # u + 1/u^2 = u + 1/u^2
        
        # Actually, let's use a cleaner formulation
        # If a^x + a^(-x) = s, find a^(2x) + a^(-2x)
        s = t
        result = s^2 - 2
        
        solution_text = steps(
            sol("Given", a^x + a^(-x) ~ s),
            "Let \$u = $(a)^x\$, so \$u + \\frac{1}{u} = $(s)\$",
            "Square both sides: \$u^2 + 2 + \\frac{1}{u^2} = $(s^2)\$",
            sol("Therefore", a^(2*x) + a^(-2*x) ~ result),
            sol("Answer", result)
        )
        
        problem(
            question="If \\($(a)^x + $(a)^{-x} = $(s)\\), find the value of \\($(a)^{2x} + $(a)^{-2x}\\)",
            answer=result,
            difficulty=(3700, 4000),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Exponential Diophantine: 2^x + 3^y = z^2
        # Pre-generate a solution
        x_ans = randint(3, 8)
        y_ans = randint(2, 5)
        sum_val = 2^x_ans + 3^y_ans
        
        # Check if it's a perfect square nearby
        z_ans = round(Int, sqrt(sum_val))
        if z_ans^2 != sum_val
            # Adjust to make it work
            z_ans = isqrt(sum_val) + 1
            while z_ans^2 < sum_val + 1000
                if z_ans^2 > 2^3 + 3^2  # Ensure we can find x, y
                    target = z_ans^2
                    # Try to express as 2^x + 3^y
                    for tx in 1:12
                        remainder = target - 2^tx
                        if remainder > 0
                            ty = log(3, remainder)
                            if abs(ty - round(ty)) < 0.0001 && round(Int, ty) >= 1
                                x_ans = tx
                                y_ans = round(Int, ty)
                                break
                            end
                        end
                    end
                    break
                end
                z_ans += 1
            end
        end
        
        # Use a known solution: 2^4 + 3^2 = 16 + 9 = 25 = 5^2
        x_ans = 4
        y_ans = 2
        z_ans = 5
        
        solution_text = steps(
            sol("Equation", 2^x + 3^y ~ z_ans^2),
            "Test small values systematically",
            "Try \\(x = 4\\): \\(2^4 = 16\\), need \\(3^y = $(z_ans^2 - 16)\\)",
            "Check: \\(3^2 = 9\\), so \\(16 + 9 = 25 = 5^2\\) ✓",
            sol("Answer", fmt_tuple([x_ans, y_ans]))
        )
        
        problem(
            question="Find positive integers \\(x\\) and \\(y\\) such that \\(2^x + 3^y = $(z_ans^2)\\). Enter your answer as an ordered pair \\((x, y)\\).",
            answer=fmt_tuple([x_ans, y_ans]),
            difficulty=(4200, 4600),
            answer_type="tuple",
            solution=solution_text,
            time=360
        )
        
    elseif problem_type == 4
        # Functional equation with exponentials: f(x) * f(y) = f(x + y) type
        # Find all solutions to a^(xy) = a^x * a^y where a > 0, a ≠ 1
        a = choice([2, 3, 5])
        
        solution_text = steps(
            sol("Given", a^(x*y) ~ a^x * a^y),
            "Use exponent laws: \\(a^x \\cdot a^y = a^{x+y}\\)",
            sol("Equation becomes", a^(x*y) ~ a^(x+y)),
            "Since \\(a > 0\\) and \\(a \\neq 1\\), exponents must be equal: \\(xy = x + y\\)",
            "Rearrange: \\(xy - x - y = 0\\), add 1: \\(xy - x - y + 1 = 1\\)",
            "Factor: \\((x-1)(y-1) = 1\\)",
            "For integer solutions: \\(x - 1 = 1, y - 1 = 1\\) or \\(x - 1 = -1, y - 1 = -1\\)",
            sol("Solutions", fmt_set(Set([fmt_tuple([2, 2]), fmt_tuple([0, 0])])))
        )
        
        problem(
            question="Find all integer pairs \\((x, y)\\) satisfying \\($(a)^{xy} = $(a)^x \\cdot $(a)^y\\). Express your answer as a set of ordered pairs.",
            answer=fmt_set(Set([fmt_tuple([2, 2]), fmt_tuple([0, 0])])),
            difficulty=(3800, 4200),
            answer_type="set",
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 5
        # Exponential inequality with multiple bases
        # Solve 2^x * 3^x < k where k is large
        k_exp = randint(15, 25)
        k = 6^k_exp
        ans_bound = k_exp
        
        solution_text = steps(
            sol("Given inequality", 2^x * 3^x < k),
            "Combine bases: \\((2 \\cdot 3)^x < $(k)\\)",
            sol("Simplify", 6^x < 6^k_exp),
            "Since exponential function \\(6^x\\) is strictly increasing",
            sol("Solution", x < ans_bound),
            sol("In interval notation", fmt_interval(-Inf, ans_bound, true, false))
        )
        
        problem(
            question="Solve the inequality: \\(2^x \\cdot 3^x < $(k)\\). Express your answer in interval notation.",
            answer=fmt_interval(-Inf, ans_bound, true, false),
            difficulty=(3600, 3900),
            answer_type="interval",
            solution=solution_text,
            time=240
        )
        
    else  # problem_type == 6
        # Transcendental equation: x^x = a where a is chosen
        # Find x such that x^x = 2^8 = 256
        target_exp = randint(6, 10)
        target = 2^target_exp
        x_ans = 2 * (target_exp // 2)  # Approximate integer solution
        
        # Actually use x^x = 2^8 → x = 4 (since 4^4 = 256)
        target_exp = 8
        target = 256
        x_ans = 4
        
        solution_text = steps(
            sol("Given equation", x^x ~ target),
            "Try small integer values: \\(2^2 = 4\\), \\(3^3 = 27\\), \\(4^4 = 256\\) ✓",
            "Verify: \\(4^4 = (2^2)^4 = 2^8 = 256\\)",
            "For uniqueness, note \\(f(x) = x^x\\) has minimum at \\(x = 1/e\\), increasing for \\(x > 1/e\\)",
            sol("Answer", x_ans)
        )
        
        problem(
            question="Find the positive integer \\(x\\) such that \\(x^x = $(target)\\).",
            answer=x_ans,
            difficulty=(3900, 4300),
            solution=solution_text,
            time=270
        )
    end
end