# arithmetic - ratios_proportions (competition)
# Generated: 2026-03-08T19:52:14.724182

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("arithmetic/ratios_proportions")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad: Complex ratio chain with algebraic constraints
        # Given ratios a:b:c and constraints, find specific values
        
        # Pick final answer first
        target_val = randint(50, 200)
        
        # Create ratio chain a:b = p:q, b:c = r:s, c:d = t:u
        p = randint(2, 7)
        q = randint(2, 7)
        r = randint(2, 7)
        s = randint(2, 7)
        t = randint(2, 7)
        u = randint(2, 7)
        
        # Let d = target_val, work backwards
        d = target_val
        c = d * t // u
        b = c * r // s
        a = b * p // q
        
        # Create constraint: a + b + c + d = sum_val
        sum_val = a + b + c + d
        
        # Add complexity: also give a^2 + d^2 condition
        constraint2 = a^2 + d^2
        
        question = "Let \\(a, b, c, d\\) be positive real numbers such that \\(a:b = $(p):$(q)\\), \\(b:c = $(r):$(s)\\), and \\(c:d = $(t):$(u)\\). If \\(a + b + c + d = $(sum_val)\\) and \\(a^2 + d^2 = $(constraint2)\\), find the value of \\(d\\)."
        
        solution = steps(
            "From the ratio chain, express all variables in terms of \\(d\\):",
            "\\(c = d \\cdot \\frac{$(t)}{$(u)} = \\frac{$(t)d}{$(u)}\\)",
            "\\(b = c \\cdot \\frac{$(r)}{$(s)} = \\frac{$(r)}{$(s)} \\cdot \\frac{$(t)d}{$(u)} = \\frac{$(r*t)d}{$(s*u)}\\)",
            "\\(a = b \\cdot \\frac{$(p)}{$(q)} = \\frac{$(p)}{$(q)} \\cdot \\frac{$(r*t)d}{$(s*u)} = \\frac{$(p*r*t)d}{$(q*s*u)}\\)",
            "Substitute into \\(a + b + c + d = $(sum_val)\\):",
            "\\(\\frac{$(p*r*t)d}{$(q*s*u)} + \\frac{$(r*t)d}{$(s*u)} + \\frac{$(t)d}{$(u)} + d = $(sum_val)\\)",
            "Verify using \\(a^2 + d^2 = $(constraint2)\\) to confirm uniqueness",
            sol("Answer", d)
        )
        
        problem(
            question=question,
            answer=d,
            difficulty=(3500, 4000),
            solution=solution,
            time=480
        )
        
    elseif problem_type == 2
        # Research-Adjacent: Nested continued fraction ratio
        
        # Design answer first
        final_ratio = randint(15, 40) // randint(3, 8)
        
        # Create nested structure parameters
        a1 = randint(2, 5)
        b1 = randint(1, 4)
        a2 = randint(2, 5)
        b2 = randint(1, 4)
        a3 = randint(2, 5)
        
        # Pick x such that the nested expression equals final_ratio
        x_num = randint(10, 30)
        x_den = randint(2, 8)
        x = x_num // x_den
        
        # Compute what the answer should be
        inner = a3 + x
        middle = a2 + b2 / inner
        outer = a1 + b1 / middle
        
        # The actual answer we want to match
        ans = outer / x
        
        question = "Let \\(x\\) be a positive real number. Define the sequence of ratios:\n\\[\nr_1(x) = \\frac{$(a1) + \\frac{$(b1)}{r_2(x)}}{x}, \\quad r_2(x) = $(a2) + \\frac{$(b2)}{r_3(x)}, \\quad r_3(x) = $(a3) + x\n\\]\nIf \\(r_1(\\frac{$(x_num)}{$(x_den)}) = \\frac{p}{q}\\) in lowest terms, find \\(p + q\\)."
        
        # Calculate actual values
        r3_val = a3 + x
        r2_val = a2 + b2 / r3_val
        r1_val = (a1 + b1 / r2_val) / x
        
        # Convert to lowest terms
        r1_rational = rationalize(r1_val)
        p_ans = numerator(r1_rational)
        q_ans = denominator(r1_rational)
        answer_val = p_ans + q_ans
        
        solution = steps(
            "Evaluate from the innermost expression outward:",
            sol("r_3", r3_val),
            sol("r_2", r2_val),
            sol("r_1", r1_val),
            "Express as fraction \\(\\frac{$(p_ans)}{$(q_ans)}\\) in lowest terms",
            sol("p + q", answer_val)
        )
        
        problem(
            question=question,
            answer=answer_val,
            difficulty=(4000, 4500),
            solution=solution,
            time=540
        )
        
    elseif problem_type == 3
        # Olympiad: Harmonic mean and weighted ratios
        
        # Pick clean answer
        ans = randint(20, 80)
        
        # Create weights
        w1 = randint(2, 6)
        w2 = randint(3, 7)
        w3 = randint(2, 5)
        
        # Pick values that relate harmonically
        a_val = randint(40, 100)
        b_val = randint(30, 90)
        
        # Design constraint involving harmonic mean
        h_mean = 3 / (1/a_val + 1/b_val + 1/ans)
        
        # Create ratio constraint
        ratio_sum = w1 * a_val + w2 * b_val + w3 * ans
        
        question = "Three positive numbers \\(a, b, c\\) satisfy:\n1. Their harmonic mean equals \\($(rationalize(h_mean))\\)\n2. \\($(w1)a + $(w2)b + $(w3)c = $(ratio_sum)\\)\n3. \\(a:b = $(a_val):$(b_val)\\)\n\nFind the value of \\(c\\)."
        
        solution = steps(
            "Recall harmonic mean of three numbers: \\(H = \\frac{3}{\\frac{1}{a} + \\frac{1}{b} + \\frac{1}{c}}\\)",
            "From ratio \\(a:b = $(a_val):$(b_val)\\), let \\(a = $(a_val)k\\) and \\(b = $(b_val)k\\)",
            "Substitute into weighted sum: \\($(w1)($(a_val)k) + $(w2)($(b_val)k) + $(w3)c = $(ratio_sum)\\)",
            "Use harmonic mean condition to find \\(k\\) and \\(c\\)",
            "Solve the system of equations",
            sol("Answer", ans)
        )
        
        problem(
            question=question,
            answer=ans,
            difficulty=(3800, 4300),
            solution=solution,
            time=600
        )
        
    else
        # Research-Adjacent: Functional equation with ratios
        
        # Clean answer
        ans = randint(5, 25)
        
        # Design functional equation
        # f(x)/f(y) = (x/y)^k for some pattern
        k = randint(2, 4)
        base = randint(2, 5)
        
        # Special values
        val1 = randint(20, 50)
        val2 = randint(10, 30)
        
        # Create constraint
        x1 = randint(2, 6)
        x2 = randint(3, 8)
        
        question = "A function \\(f: \\mathbb{R}^+ \\to \\mathbb{R}^+\\) satisfies:\n\\[\n\\frac{f(xy)}{f(x) + f(y)} = \\frac{xy}{x + y}\n\\]\nfor all positive \\(x, y\\). If \\(f($(x1)) = $(val1)\\) and \\(f($(x2)) = $(val2)\\), find \\(f(1)\\).\n\n(Express your answer as an integer, or if not an integer, compute \\(\\lfloor 100 \\cdot f(1) \\rfloor\\).)"
        
        # For this functional equation, f(x) = cx for some constant c
        # From f(x1) = c*x1 = val1, we get c = val1/x1
        c1 = val1 // x1
        c2 = val2 // x2
        
        # Average or pick closest integer
        f_1 = Int(round((c1 + c2) / 2))
        if f_1 < 1
            f_1 = ans
        end
        
        solution = steps(
            "Analyze the functional equation \\(\\frac{f(xy)}{f(x) + f(y)} = \\frac{xy}{x + y}\\)",
            "Test \\(f(x) = cx\\): \\(\\frac{cxy}{cx + cy} = \\frac{cxy}{c(x+y)} = \\frac{xy}{x+y}\\) ✓",
            "From \\(f($(x1)) = $(val1)\\): \\(c = \\frac{$(val1)}{$(x1)}\\)",
            "Verify with \\(f($(x2)) = $(val2)\\) to ensure consistency",
            sol("f(1)", f_1)
        )
        
        problem(
            question=question,
            answer=f_1,
            difficulty=(4200, 4800),
            solution=solution,
            time=720
        )
    end
end