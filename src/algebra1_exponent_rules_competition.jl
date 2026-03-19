# algebra1 - exponent_rules (competition)
# Generated: 2026-03-08T19:59:10.444026

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z n m begin
    set_topic!("algebra1/exponent_rules")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Deep exponent tower simplification with nested powers
        # (a^(b^c))^(d^e) type problems requiring careful order of operations
        a = choice([2, 3, 5])
        b = randint(2, 4)
        c = randint(2, 3)
        d = randint(2, 3)
        e = randint(2, 3)
        
        inner_exp = b^c
        outer_exp = d^e
        final_exp = inner_exp * outer_exp
        
        expr_text = "\\left($(a)^{$(b)^{$(c)}}\\right)^{$(d)^{$(e)}}"
        
        problem(
            question = "Simplify to the form \\(a^n\\): \\[$(expr_text)\\]",
            answer = "$(a)^$(final_exp)",
            difficulty = (3500, 3800),
            solution = steps(
                "Given: \\($(expr_text)\\)",
                sol("Evaluate inner exponent", "$(b)^{$(c)} = $(inner_exp)"),
                sol("Evaluate outer exponent", "$(d)^{$(e)} = $(outer_exp)"),
                "Apply power rule: \\((a^m)^n = a^{mn}\\)",
                sol("Final exponent", "$(inner_exp) \\times $(outer_exp) = $(final_exp)"),
                sol("Answer", "$(a)^{$(final_exp)}")
            ),
            time = 240
        )
        
    elseif problem_type == 2
        # System of exponential equations requiring substitution
        # a^x * b^y = c and a^(2x) * b^(3y) = d
        base_a = choice([2, 3, 5])
        base_b = choice([2, 3, 7])
        
        x_val = randint(3, 8)
        y_val = randint(2, 6)
        
        c = base_a^x_val * base_b^y_val
        d = base_a^(2*x_val) * base_b^(3*y_val)
        
        problem(
            question = "Find \\(x + y\\) given the system: \\[$(base_a)^x \\cdot $(base_b)^y = $(c)\\] \\[$(base_a)^{2x} \\cdot $(base_b)^{3y} = $(d)\\]",
            answer = x_val + y_val,
            difficulty = (3700, 4100),
            solution = steps(
                "Given system with bases $(base_a) and $(base_b)",
                "Let \\(u = $(base_a)^x\\) and \\(v = $(base_b)^y\\)",
                "First equation: \\(uv = $(c)\\)",
                "Second equation: \\(u^2 v^3 = $(d)\\)",
                "Divide second by first squared: \\(v = \\frac{$(d)}{$(c)^2} \\cdot \\frac{1}{u} \\cdot u^2 = \\frac{$(d)}{$(c)^2} \\cdot u\\)",
                "Solve to find \\(x = $(x_val)\\) and \\(y = $(y_val)\\)",
                sol("Answer", "x + y = $(x_val + y_val)")
            ),
            time = 300
        )
        
    elseif problem_type == 3
        # Exponential Diophantine-style: find integer n such that a^n - b^m = c
        base = choice([2, 3])
        m_val = randint(4, 7)
        n_val = m_val + randint(1, 3)
        
        target = base^n_val - base^m_val
        
        problem(
            question = "Find the positive integer \\(n\\) such that \\($(base)^n - $(base)^{$(m_val)} = $(target)\\).",
            answer = n_val,
            difficulty = (3600, 4000),
            solution = steps(
                sol("Given equation", "$(base)^n - $(base)^{$(m_val)} = $(target)"),
                "Factor: \\($(base)^{$(m_val)}($(base)^{n-$(m_val)} - 1) = $(target)\\)",
                sol("Divide by \\($(base)^{$(m_val)}\\)", "$(base)^{n-$(m_val)} - 1 = $(target // base^m_val)"),
                sol("Therefore", "$(base)^{n-$(m_val)} = $(target // base^m_val + 1)"),
                "Recognize \\($(target // base^m_val + 1) = $(base)^{$(n_val - m_val)}\\)",
                sol("Answer", "n = $(n_val)")
            ),
            time = 270
        )
        
    elseif problem_type == 4
        # Product with many terms requiring prime factorization insight
        p = choice([2, 3, 5])
        q = choice([2, 3, 7])
        while q == p
            q = choice([2, 3, 7])
        end
        
        k = randint(15, 30)
        
        sum_formula = div(k * (k + 1), 2)
        
        problem(
            question = "Simplify \\($(p)^1 \\cdot $(p)^2 \\cdot $(p)^3 \\cdot \\ldots \\cdot $(p)^{$(k)}\\) to the form \\($(p)^n\\). What is \\(n\\)?",
            answer = sum_formula,
            difficulty = (3400, 3700),
            solution = steps(
                "Product of powers with same base: add exponents",
                sol("Exponent sum", "1 + 2 + 3 + \\ldots + $(k)"),
                "Use formula for arithmetic series: \\(\\frac{n(n+1)}{2}\\)",
                sol("Calculate", "\\frac{$(k) \\cdot $(k+1)}{2} = $(sum_formula)"),
                sol("Answer", sum_formula)
            ),
            time = 180
        )
        
    elseif problem_type == 5
        # Nested fractional exponents with radicals
        a = choice([2, 3, 5])
        inner_exp = randint(12, 24)
        outer_num = randint(2, 4)
        outer_den = randint(3, 6)
        
        while gcd(outer_num, outer_den) != 1
            outer_num = randint(2, 4)
            outer_den = randint(3, 6)
        end
        
        final_num = inner_exp * outer_num
        final_den = outer_den
        g = gcd(final_num, final_den)
        final_num = div(final_num, g)
        final_den = div(final_den, g)
        
        problem(
            question = "Simplify \\(\\left($(a)^{$(inner_exp)}\\right)^{\\frac{$(outer_num)}{$(outer_den)}}\\) to the form \\($(a)^{\\frac{p}{q}}\\) in lowest terms. What is \\(p + q\\)?",
            answer = final_num + final_den,
            difficulty = (3500, 3900),
            solution = steps(
                sol("Given", "\\left($(a)^{$(inner_exp)}\\right)^{\\frac{$(outer_num)}{$(outer_den)}}"),
                "Apply power rule: \\((a^m)^n = a^{mn}\\)",
                sol("Multiply exponents", "$(inner_exp) \\times \\frac{$(outer_num)}{$(outer_den)} = \\frac{$(inner_exp * outer_num)}{$(outer_den)}"),
                sol("Simplify fraction", "\\frac{$(inner_exp * outer_num)}{$(outer_den)} = \\frac{$(final_num)}{$(final_den)}"),
                sol("Answer", "p + q = $(final_num) + $(final_den) = $(final_num + final_den)")
            ),
            time = 240
        )
        
    else
        # Challenging equation: a^(2x) - b*a^x + c = 0 requiring substitution
        a = choice([2, 3, 5])
        r1 = randint(2, 5)
        r2 = randint(6, 12)
        
        b_coef = r1 + r2
        c_coef = r1 * r2
        
        x1_num = log(r1) / log(a)
        x2_num = log(r2) / log(a)
        
        # We want integer solutions, so pick r1, r2 as powers of a
        pow1 = randint(1, 3)
        pow2 = randint(4, 6)
        r1 = a^pow1
        r2 = a^pow2
        b_coef = r1 + r2
        c_coef = r1 * r2
        
        problem(
            question = "Find the sum of all solutions to \\($(a)^{2x} - $(b_coef) \\cdot $(a)^x + $(c_coef) = 0\\).",
            answer = pow1 + pow2,
            difficulty = (3800, 4200),
            solution = steps(
                sol("Given equation", "$(a)^{2x} - $(b_coef) \\cdot $(a)^x + $(c_coef) = 0"),
                "Let \\(u = $(a)^x\\), then equation becomes \\(u^2 - $(b_coef)u + $(c_coef) = 0\\)",
                "Factor: \\((u - $(r1))(u - $(r2)) = 0\\)",
                "Solutions: \\(u = $(r1)\\) or \\(u = $(r2)\\)",
                sol("Convert back", "$(a)^x = $(r1) = $(a)^{$(pow1)}\\) gives \\(x = $(pow1)\\)"),
                sol("And", "$(a)^x = $(r2) = $(a)^{$(pow2)}\\) gives \\(x = $(pow2)\\)"),
                sol("Answer", "$(pow1) + $(pow2) = $(pow1 + pow2)")
            ),
            time = 300
        )
    end
end