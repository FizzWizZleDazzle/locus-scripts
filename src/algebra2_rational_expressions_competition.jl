# algebra2 - rational_expressions (competition)
# Generated: 2026-03-08T20:16:27.419819

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("algebra2/rational_expressions")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad-level: Functional equation with rational expressions
        # Find all functions f: ℚ⁺ → ℚ⁺ satisfying f(x) + f(1/x) = g(x) for some rational g
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        # Construct problem where f(x) = (ax+b)/(x+c)
        # Then f(x) + f(1/x) = (ax+b)/(x+c) + (a/x+b)/(1/x+c) = (ax+b)/(x+c) + (a+bx)/(1+cx)
        
        num1 = a*x + b
        den1 = x + c
        num2 = a + b*x
        den2 = 1 + c*x
        
        sum_expr = simplify(num1/den1 + num2/den2)
        
        question = "Let \\(f: \\mathbb{Q}^+ \\to \\mathbb{Q}\\) be a rational function such that " *
                   "\\[f(x) + f\\left(\\frac{1}{x}\\right) = $(tex(sum_expr))\\]" *
                   "for all \\(x > 0\\). If \\(f(x) = \\frac{Ax + B}{x + C}\\) for rational constants \\(A, B, C\\), " *
                   "find \\(A + B + C\\)."
        
        answer = a + b + c
        
        solution = steps(
            "Let \\(f(x) = \\frac{Ax + B}{x + C}\\). Then \\(f\\left(\\frac{1}{x}\\right) = \\frac{\\frac{A}{x} + B}{\\frac{1}{x} + C} = \\frac{A + Bx}{1 + Cx}\\)",
            "Substituting: \\[\\frac{Ax + B}{x + C} + \\frac{A + Bx}{1 + Cx} = $(tex(sum_expr))\\]",
            "Cross-multiply and expand both sides to get polynomial identity",
            "Compare coefficients: \\(A = $(a)\\), \\(B = $(b)\\), \\(C = $(c)\\)",
            sol("Answer", a + b + c)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 4200),
            solution=solution,
            time=480
        )
        
    elseif problem_type == 2
        # Research-adjacent: Minimize rational expression with constraint
        # Find minimum of P(x)/Q(x) subject to R(x)/S(x) = k
        
        a = nonzero(2, 8)
        b = nonzero(2, 8)
        c = nonzero(1, 6)
        d = nonzero(1, 6)
        
        # Objective: (x^2 + a)/(x^2 + b)
        # Constraint: x^2 = c
        
        obj_num = x^2 + a
        obj_den = x^2 + b
        
        # At x^2 = c: (c + a)/(c + b)
        min_val = (c + a) // (c + b)
        
        question = "Consider the function \\[f(x) = \\frac{$(tex(obj_num))}{$(tex(obj_den))}\\]" *
                   "Find the minimum value of \\(f(x)\\) over all real \\(x\\) satisfying \\(x^2 = $(c)\\). " *
                   "Express your answer as a simplified fraction."
        
        answer = min_val
        
        solution = steps(
            sol("Given constraint", x^2 ~ c),
            "Substitute \\(x^2 = $(c)\\) into \\(f(x)\\):",
            sol("f(x) = \\frac{$(c) + $(a)}{$(c) + $(b)}", min_val),
            "Since \\(x^2 = $(c)\\) determines the value uniquely (up to sign), this is both minimum and maximum",
            sol("Answer", min_val)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4500),
            solution=solution,
            time=420
        )
        
    elseif problem_type == 3
        # Olympiad: Partial fractions with parameter
        # Decompose expression and find when specific coefficient vanishes
        
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        r3 = nonzero(-10, 10)
        
        while r1 == r2 || r1 == r3 || r2 == r3
            r2 = nonzero(-10, 10)
            r3 = nonzero(-10, 10)
        end
        
        # Numerator degree 2: ax^2 + bx + c
        a_coef = nonzero(-5, 5)
        b_coef = randint(-15, 15)
        
        numerator = a_coef*x^2 + b_coef*x + r1*r2 + r1*r3 + r2*r3
        denominator = expand((x - r1)*(x - r2)*(x - r3))
        
        # Partial fraction A/(x-r1) + B/(x-r2) + C/(x-r3)
        # Find sum A + B + C
        
        # Evaluate at x → ∞: coefficient of x^2 in num / coefficient of x^3 in den = a_coef/1
        sum_abc = a_coef
        
        question = "Decompose \\[\\frac{$(tex(numerator))}{$(tex(denominator))}\\] " *
                   "into partial fractions \\[\\frac{A}{x - ($(r1))} + \\frac{B}{x - ($(r2))} + \\frac{C}{x - ($(r3))}\\]" *
                   "Find \\(A + B + C\\)."
        
        answer = sum_abc
        
        solution = steps(
            "For partial fractions of proper/improper rational functions, sum of residues equals leading coefficient ratio",
            "Degree of numerator: 2, degree of denominator: 3",
            "As \\(x \\to \\infty\\): \\(\\frac{$(a_coef)x^2 + \\cdots}{x^3 + \\cdots} \\to 0\\) plus pole contributions",
            "Alternatively: multiply through and compare coefficients, or use Heaviside cover-up",
            "The sum \\(A + B + C = $(a_coef)\\) (coefficient of \\(x^2\\) in numerator)",
            sol("Answer", sum_abc)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3600, 4300),
            solution=solution,
            time=450
        )
        
    elseif problem_type == 4
        # Research-adjacent: Rational expression equality with multiple variables
        
        a = nonzero(2, 7)
        b = nonzero(2, 7)
        c = nonzero(2, 7)
        
        # Find when (x+a)/(y+b) + (y+b)/(x+a) = c
        # Let u = (x+a)/(y+b), then u + 1/u = c
        # u^2 - cu + 1 = 0
        # u = (c ± sqrt(c^2-4))/2
        
        # For specific answer: (x+a)/(y+b) * (y+b)/(x+a) = 1
        # So product is always 1
        
        discriminant = c^2 - 4
        
        question = "Suppose \\(x, y\\) are positive reals satisfying " *
                   "\\[\\frac{x + $(a)}{y + $(b)} + \\frac{y + $(b)}{x + $(a)} = $(c)\\]" *
                   "Find the product \\[\\frac{x + $(a)}{y + $(b)} \\cdot \\frac{y + $(b)}{x + $(a)}\\]"
        
        answer = 1
        
        solution = steps(
            "Let \\(u = \\frac{x + $(a)}{y + $(b)}\\). Then \\(\\frac{y + $(b)}{x + $(a)} = \\frac{1}{u}\\)",
            "The equation becomes \\(u + \\frac{1}{u} = $(c)\\)",
            "The product \\(u \\cdot \\frac{1}{u} = 1\\) for any \\(u \\neq 0\\)",
            "This is independent of the constraint equation",
            sol("Answer", 1)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3400, 4000),
            solution=solution,
            time=360
        )
        
    else
        # Olympiad: Complex rational expression simplification
        
        n = randint(3, 7)
        k = randint(2, n-1)
        
        # Telescope: sum from i=1 to n of 1/(i(i+k))
        # = (1/k) * sum [1/i - 1/(i+k)]
        # = (1/k) * [H_{n+k} - H_k - (H_n - H_0)]
        # = (1/k) * [sum_{i=n+1}^{n+k} 1/i]
        
        # Compute exact answer
        answer_num = 0
        answer_den = 1
        for i in 1:n
            term_num = 1
            term_den = i * (i + k)
            # Add term_num/term_den to answer_num/answer_den
            answer_num = answer_num * term_den + term_num * answer_den
            answer_den = answer_den * term_den
            # Simplify
            g = gcd(answer_num, answer_den)
            answer_num = div(answer_num, g)
            answer_den = div(answer_den, g)
        end
        
        answer = answer_num // answer_den
        
        question = "Simplify the sum \\[S = \\sum_{i=1}^{$(n)} \\frac{1}{i(i + $(k))}\\]" *
                   "Express your answer as a simplified fraction."
        
        solution = steps(
            "Use partial fractions: \\(\\frac{1}{i(i+$(k))} = \\frac{1}{$(k)}\\left(\\frac{1}{i} - \\frac{1}{i+$(k)}\\right)\\)",
            "The sum becomes \\[S = \\frac{1}{$(k)} \\sum_{i=1}^{$(n)} \\left(\\frac{1}{i} - \\frac{1}{i+$(k)}\\right)\\]",
            "This is a telescoping series: \\[S = \\frac{1}{$(k)}\\left(1 + \\frac{1}{2} + \\cdots + \\frac{1}{$(k)} - \\frac{1}{$(n+1)} - \\cdots - \\frac{1}{$(n+k)}\\right)\\]",
            "Terms from 1 to \\($(k)\\) remain, terms from \\($(n+1)\\) to \\($(n+k)\\) are subtracted",
            sol("Computing", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3700, 4600),
            solution=solution,
            time=540
        )
    end
end