# algebra2 - logarithm_properties (competition)
# Generated: 2026-03-08T20:21:21.818038

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/logarithm_properties")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Solve a system involving logarithmic equations with change of base
        # log_a(b) * log_b(c) * log_c(a) = 1, but with specific values leading to a Diophantine constraint
        base1 = randint(2, 5)
        base2 = randint(2, 5)
        base3 = randint(2, 5)
        
        # Create: log_x(base1) + log_x(base2) = log_x(base3) + k where k forces a specific x
        k = randint(1, 3)
        target = base1 * base2 // (base3 * base1^k)
        
        # Actually, let's make a harder problem: find x such that log_x(a) + log_x(b) = c
        a = randint(3, 20)
        b = randint(3, 20)
        c = randint(2, 4)
        # log_x(a) + log_x(b) = c means log_x(ab) = c, so x^c = ab
        product = a * b
        ans = product^(1//c)
        
        # Only works if product is a perfect power
        # Better approach: pick x first, then construct
        ans = randint(2, 8)
        c = randint(2, 4)
        product = ans^c
        # Factor product into a*b
        divisors = [i for i in 2:product÷2 if product % i == 0]
        if length(divisors) > 0
            a = choice(divisors)
            b = product ÷ a
        else
            a = 1
            b = product
        end
        
        question_text = "Find the value of \\(x\\) satisfying \\[\\log_x($a) + \\log_x($b) = $c\\]"
        
        solution_text = steps(
            "Use the logarithm product rule: \\(\\log_x($a) + \\log_x($b) = \\log_x($a \\cdot $b) = \\log_x($product)\\)",
            sol("Equation becomes", "\\log_x($product) = $c"),
            "By definition of logarithm: \\(x^{$c} = $product\\)",
            sol("Solve for x", "x = $ans"),
            "Verification: \\($ans^{$c} = $product\\) ✓"
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(3500, 4000),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Research-adjacent: Functional equation with logarithms
        # Find all functions f such that f(log_a(x)) + f(log_a(y)) = f(log_a(xy)) for specific constraints
        
        # Simpler olympiad version: solve log_a(x) + log_b(x) = c for specific a,b,c
        a = randint(2, 5)
        b = randint(2, 5)
        while b == a
            b = randint(2, 5)
        end
        
        # log_a(x) + log_b(x) = log_a(x)(1 + log_a(b))
        # Let's pick x such that the answer is clean
        ans = randint(6, 30)
        
        # Compute what c should be
        c_val = log(ans)/log(a) + log(ans)/log(b)
        c_display = round(c_val, digits=4)
        
        # Better: construct so answer is exact
        # log_a(x) + log_b(x) = k, use change of base
        # ln(x)/ln(a) + ln(x)/ln(b) = k
        # ln(x)[1/ln(a) + 1/ln(b)] = k
        # This won't give clean answers easily
        
        # Different approach: nested logarithms
        # Solve: log_2(log_3(log_5(x))) = n
        n = randint(1, 3)
        inner = randint(2, 4)
        mid = 5^(3^inner)
        ans = 5^(3^(2^n))
        
        question_text = "Solve for \\(x\\): \\[\\log_2\\left(\\log_3\\left(\\log_5(x)\\right)\\right) = $n\\]"
        
        solution_text = steps(
            sol("Given", "\\log_2\\left(\\log_3\\left(\\log_5(x)\\right)\\right) = $n"),
            "Apply exponential to both sides: \\(\\log_3\\left(\\log_5(x)\\right) = 2^{$n}\\)",
            "Apply exponential again: \\(\\log_5(x) = 3^{2^{$n}}\\)",
            "Apply exponential once more: \\(x = 5^{3^{2^{$n}}}\\)",
            sol("Answer", "x = 5^{3^{$(2^n)}} = 5^{$(3^(2^n))}")
        )
        
        problem(
            question=question_text,
            answer="5^$(3^(2^n))",
            difficulty=(3800, 4500),
            solution=solution_text,
            answer_type="expression",
            time=300
        )
        
    elseif problem_type == 3
        # Olympiad: Inequality with logarithms requiring AM-GM or similar
        # Find all x such that log_x(a) + log_a(x) >= c
        a = randint(3, 12)
        c = randint(2, 4)
        
        # log_x(a) + log_a(x) = log_x(a) + 1/log_x(a)
        # Let y = log_x(a), then y + 1/y >= c
        # By AM-GM, y + 1/y >= 2 when y > 0
        # For y + 1/y >= c with c > 2: y^2 - cy + 1 >= 0
        # Roots: y = (c ± sqrt(c^2-4))/2
        
        c = 3  # Use c=3 for clean math
        # y + 1/y >= 3 means y^2 - 3y + 1 >= 0
        # y = (3 ± sqrt(5))/2
        y1 = (3 - sqrt(5))/2
        y2 = (3 + sqrt(5))/2
        
        # log_x(a) = y means x = a^(1/y)
        # Need 0 < y <= y1 or y >= y2
        # Since x > 0, x ≠ 1, and x = a^(1/y)
        
        question_text = "Find all positive real numbers \\(x \\neq 1\\) such that \\[\\log_x($a) + \\log_{$a}(x) \\geq 3\\]"
        
        bound1 = "$a^{2/(3+\\sqrt{5})}"
        bound2 = "$a^{2/(3-\\sqrt{5})}"
        
        ans = "x \\in (0, $a^{2/(3+\\sqrt{5})}] \\cup [$a^{2/(3-\\sqrt{5})}, \\infty)"
        
        solution_text = steps(
            "Let \\(y = \\log_x($a)\\), then \\(\\log_{$a}(x) = \\frac{1}{y}\\)",
            sol("Inequality becomes", "y + \\frac{1}{y} \\geq 3"),
            "Multiply by \\(y\\) (considering sign): \\(y^2 - 3y + 1 \\geq 0\\) when \\(y > 0\\), or \\(y^2 - 3y + 1 \\leq 0\\) when \\(y < 0\\)",
            "Roots of \\(y^2 - 3y + 1 = 0\\): \\(y = \\frac{3 \\pm \\sqrt{5}}{2}\\)",
            "For \\(y > 0\\): \\(y \\in (0, \\frac{3-\\sqrt{5}}{2}] \\cup [\\frac{3+\\sqrt{5}}{2}, \\infty)\\)",
            "Convert back: \\(x = $a^{1/y}\\), giving the solution intervals"
        )
        
        problem(
            question=question_text,
            answer=ans,
            difficulty=(4000, 4800),
            solution=solution_text,
            answer_type="expression",
            time=360
        )
        
    elseif problem_type == 4
        # Find integer solutions to logarithmic Diophantine equation
        # log_2(x) + log_3(y) = log_6(z) where x,y,z are positive integers
        
        # log_2(x) + log_3(y) = log_6(z)
        # Using change of base: ln(x)/ln(2) + ln(y)/ln(3) = ln(z)/ln(6)
        # This is complex; simpler version:
        
        # Find all positive integers n such that log_2(n) + log_3(n) is an integer
        # This requires n to be a power of lcm(2,3) = 6
        
        k = randint(2, 5)
        n = 6^k
        ans_val = k * (log(6)/log(2) + log(6)/log(3))
        
        # Better: solve 2^a * 3^b = c for given c
        c = randint(10, 100)
        
        # Even better olympiad problem:
        # Find all triples (a,b,c) of positive integers such that a^(log_b(c)) = c^(log_b(a))
        
        a = randint(2, 8)
        b = randint(2, 8)
        # a^(log_b(c)) = c^(log_b(a))
        # Taking log_b: log_b(a) * log_b(c) = log_b(a) * log_b(c)
        # This is always true! Need better constraint.
        
        # Different problem: find n such that log_2(n!) is an integer
        # n! must be a power of 2
        # Only n = 1, 2, 4 work (1! = 1, 2! = 2, 4! = 24 = 2^3 * 3, doesn't work)
        # Actually only n=1,2 work
        
        # Olympiad problem: Sum of logarithms
        # Compute: log_2(3) * log_3(4) * log_4(5) * ... * log_31(32)
        n = randint(4, 8)
        ans = n  # Telescoping product
        
        question_text = "Compute the value of \\[\\log_2(3) \\cdot \\log_3(4) \\cdot \\log_4(5) \\cdots \\log_{$((2^n)-1)}($(2^n))\\]"
        
        solution_text = steps(
            "Use change of base formula: \\(\\log_a(b) = \\frac{\\log(b)}{\\log(a)}\\)",
            "Product becomes: \\(\\frac{\\log(3)}{\\log(2)} \\cdot \\frac{\\log(4)}{\\log(3)} \\cdot \\frac{\\log(5)}{\\log(4)} \\cdots \\frac{\\log($(2^n))}{\\log($((2^n)-1))}\\)",
            "This is a telescoping product: \\(\\frac{\\log($(2^n))}{\\log(2)}\\)",
            sol("Simplify", "\\log_2($(2^n)) = $n")
        )
        
        problem(
            question=question_text,
            answer=n,
            difficulty=(3600, 4200),
            solution=solution_text,
            time=280
        )
        
    else
        # Research-adjacent: Prove or find counterexample
        # For which positive integers n does there exist an integer k such that log_n(k) = log_k(n^2)?
        
        # log_n(k) = log_k(n^2)
        # ln(k)/ln(n) = 2ln(n)/ln(k)
        # [ln(k)]^2 = 2[ln(n)]^2
        # ln(k) = sqrt(2) * ln(n)
        # k = n^sqrt(2)
        # For this to be an integer, need very specific n
        
        # Simpler olympiad: find all integer solutions to log_x(y) = log_y(x^2)
        # ln(y)/ln(x) = 2ln(x)/ln(y)
        # [ln(y)]^2 = 2[ln(x)]^2
        # y = x^sqrt(2) (not generally integer)
        
        # Or: y^2 = x^3 in disguise via logs
        
        ans1 = randint(2, 6)
        ans2 = ans1^3
        
        question_text = "Find all pairs of positive integers \\((x, y)\\) with \\(x, y > 1\\) satisfying \\[2\\log_x(y) = 3\\log_y(x)\\]"
        
        solution_text = steps(
            "Let \\(\\log_x(y) = t\\), so \\(\\log_y(x) = \\frac{1}{t}\\)",
            sol("Equation becomes", "2t = \\frac{3}{t}"),
            "Solving: \\(2t^2 = 3\\), so \\(t = \\sqrt{\\frac{3}{2}}\\)",
            "This means \\(y = x^{\\sqrt{3/2}}\\), which is irrational for integer \\(x\\)",
            "Therefore, there are no solutions in positive integers \\((x,y)\\) with \\(x, y > 1\\)"
        )
        
        problem(
            question=question_text,
            answer="No solutions",
            difficulty=(4200, 4900),
            solution=solution_text,
            answer_type="expression",
            time=300
        )
    end
end