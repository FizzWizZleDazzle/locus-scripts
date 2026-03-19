# calculus - derivative_rules (competition)
# Generated: 2026-03-08T20:39:44.735870

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/derivative_rules")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: Implicit differentiation with nested compositions
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        # Create a challenging implicit equation like sin(x^2 y) + cos(xy^2) = arctan(x + y)
        lhs = sin(x^2 * y) + cos(x * y^2)
        rhs = atan(x + y)
        
        # Compute dy/dx implicitly
        # d/dx[sin(x^2 y)] = cos(x^2 y) * (2xy + x^2 dy/dx)
        # d/dx[cos(xy^2)] = -sin(xy^2) * (y^2 + 2xy dy/dx)
        # d/dx[arctan(x+y)] = 1/(1+(x+y)^2) * (1 + dy/dx)
        
        numerator_terms = "\\cos(x^2 y)(2xy) - \\sin(xy^2)(y^2) - \\frac{1}{1+(x+y)^2}"
        denominator_terms = "\\cos(x^2 y)(x^2) - \\sin(xy^2)(2xy) - \\frac{1}{1+(x+y)^2}"
        
        problem(
            question="Given the implicit equation \\[\\sin(x^2 y) + \\cos(xy^2) = \\arctan(x + y)\\] find \\(\\frac{dy}{dx}\\) in terms of \\(x\\) and \\(y\\).",
            answer="\\frac{\\cos(x^2 y)(2xy) - \\sin(xy^2)(y^2) - \\frac{1}{1+(x+y)^2}}{\\cos(x^2 y)(x^2) - \\sin(xy^2)(2xy) - \\frac{1}{1+(x+y)^2}}",
            difficulty=(3500, 3800),
            answer_type="expression",
            solution=steps(
                "Given implicit equation: \\(\\sin(x^2 y) + \\cos(xy^2) = \\arctan(x + y)\\)",
                "Differentiate both sides with respect to \\(x\\):<br>\\(\\frac{d}{dx}[\\sin(x^2 y)] = \\cos(x^2 y) \\cdot \\frac{d}{dx}[x^2 y] = \\cos(x^2 y)(2xy + x^2 y')\\)<br>\\(\\frac{d}{dx}[\\cos(xy^2)] = -\\sin(xy^2) \\cdot \\frac{d}{dx}[xy^2] = -\\sin(xy^2)(y^2 + 2xy y')\\)<br>\\(\\frac{d}{dx}[\\arctan(x+y)] = \\frac{1}{1+(x+y)^2}(1 + y')\\)",
                "Combine and solve for \\(y'\\):<br>\\(\\cos(x^2 y)(2xy + x^2 y') - \\sin(xy^2)(y^2 + 2xy y') = \\frac{1 + y'}{1+(x+y)^2}\\)",
                "Collect \\(y'\\) terms:<br>\\(y'[\\cos(x^2 y) x^2 - \\sin(xy^2)(2xy) - \\frac{1}{1+(x+y)^2}] = \\frac{1}{1+(x+y)^2} - \\cos(x^2 y)(2xy) + \\sin(xy^2)(y^2)\\)",
                sol("Answer", "\\frac{dy}{dx} = \\frac{$(numerator_terms)}{$(denominator_terms)}")
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Research-adjacent: Higher-order derivative with pattern recognition
        n = rand(4:7)
        k = rand(2:4)
        
        # f(x) = x^n * e^(kx), find the pattern for f^(m)(x)
        expr_str = "x^{$n} e^{$(k)x}"
        
        # The m-th derivative follows a pattern involving binomial coefficients
        m = rand(n:n+3)
        
        problem(
            question="Let \\(f(x) = $(expr_str)\\). Find a closed-form expression for the \\($m\\)-th derivative \\(f^{($m)}(x)\\) using the generalized Leibniz rule.",
            answer="\\sum_{j=0}^{\\min($m, $n)} \\binom{$m}{j} \\frac{$(factorial(n))}{($n-j)!} x^{$n-j} $(k)^{$m-j} e^{$(k)x}",
            difficulty=(4200, 4600),
            answer_type="expression",
            solution=steps(
                sol("Given", "f(x) = $(expr_str)"),
                "Apply the generalized Leibniz rule: \\((uv)^{(m)} = \\sum_{j=0}^{m} \\binom{m}{j} u^{(j)} v^{(m-j)}\\)",
                "Let \\(u(x) = x^{$n}\\) and \\(v(x) = e^{$(k)x}\\)<br>Then \\(u^{(j)}(x) = \\frac{$(factorial(n))}{($n-j)!} x^{$n-j}\\) for \\(j \\leq $n\\) (and 0 for \\(j > $n\\))<br>And \\(v^{(m-j)}(x) = $(k)^{m-j} e^{$(k)x}\\)",
                "Substitute into Leibniz rule for \\(j = 0\\) to \\(\\min($m, $n)\\)",
                sol("Answer", "f^{($m)}(x) = \\sum_{j=0}^{\\min($m, $n)} \\binom{$m}{j} \\frac{$(factorial(n))}{($n-j)!} x^{$n-j} $(k)^{$m-j} e^{$(k)x}")
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Olympiad: Logarithmic differentiation with complex product
        a = nonzero(2, 6)
        b = nonzero(2, 6)
        c = nonzero(2, 6)
        
        # f(x) = (x^2 + a)^x * (x^3 - b)^(x^2) / (x + c)^(sqrt(x))
        numerator = "(x^2 + $a)^x (x^3 - $b)^{x^2}"
        denominator = "(x + $c)^{\\sqrt{x}}"
        
        problem(
            question="Use logarithmic differentiation to find \\(\\frac{d}{dx}\\left[\\frac{$(numerator)}{$(denominator)}\\right]\\). Express your answer in terms of \\(f(x)\\) where \\(f(x)\\) is the original function.",
            answer="f(x) \\left[\\frac{x(2x)}{x^2+$a} + (x^2 + $a)^x \\ln(x^2+$a) + \\frac{x^2(3x^2)}{x^3-$b} + 2x(x^3-$b)^{x^2}\\ln(x^3-$b) - \\frac{\\sqrt{x}}{x+$c} - \\frac{(x+$c)^{\\sqrt{x}}\\ln(x+$c)}{2\\sqrt{x}}\\right]",
            difficulty=(3700, 4000),
            answer_type="expression",
            solution=steps(
                sol("Given", "f(x) = \\frac{$(numerator)}{$(denominator)}"),
                "Take natural logarithm: \\(\\ln f(x) = x\\ln(x^2+$a) + x^2\\ln(x^3-$b) - \\sqrt{x}\\ln(x+$c)\\)",
                "Differentiate both sides using implicit differentiation:<br>\\(\\frac{f'(x)}{f(x)} = \\ln(x^2+$a) + x\\cdot\\frac{2x}{x^2+$a} + 2x\\ln(x^3-$b) + x^2\\cdot\\frac{3x^2}{x^3-$b} - \\frac{\\ln(x+$c)}{2\\sqrt{x}} - \\sqrt{x}\\cdot\\frac{1}{x+$c}\\)",
                "Simplify each term by collecting",
                sol("Answer", "f'(x) = f(x) \\left[\\ln(x^2+$a) + \\frac{2x^2}{x^2+$a} + 2x\\ln(x^3-$b) + \\frac{3x^4}{x^3-$b} - \\frac{\\ln(x+$c)}{2\\sqrt{x}} - \\frac{\\sqrt{x}}{x+$c}\\right]")
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Research-adjacent: Functional equation involving derivatives
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        # Find all differentiable functions f: R -> R such that f'(x) = a*f(x/b) for all x
        problem(
            question="Find all infinitely differentiable functions \\(f: \\mathbb{R} \\to \\mathbb{R}\\) satisfying the functional equation \\[f'(x) = $a f\\left(\\frac{x}{$b}\\right)\\] for all \\(x \\in \\mathbb{R}\\). Prove that your answer is complete.",
            answer="f(x) = C e^{$a $(b) x / (1 - $b)} for any constant C, provided $b \\neq 1",
            difficulty=(4500, 4900),
            answer_type="expression",
            solution=steps(
                sol("Given functional equation", "f'(x) = $a f(x/$b)"),
                "Differentiate the equation repeatedly:<br>\\(f''(x) = $a \\cdot \\frac{1}{$b} f'(x/$b) = \\frac{$a}{$b} \\cdot $a f(x/$b^2) = \\frac{$a^2}{$b} f(x/$b^2)\\)<br>By induction: \\(f^{(n)}(x) = \\frac{$a^n}{$b^{n-1}} f(x/$b^n)\\)",
                "Evaluate at \\(x = 0\\): \\(f^{(n)}(0) = \\frac{$(a)^n}{$(b)^{n-1}} f(0)\\)<br>This gives the Taylor series: \\(f(x) = f(0) \\sum_{n=0}^{\\infty} \\frac{$(a)^n x^n}{$(b)^{n-1} \\cdot n!}\\)",
                "Recognize this as \\(f(x) = f(0) \\cdot $b \\sum_{n=0}^{\\infty} \\frac{($a x / $b)^n}{n!} = C \\cdot $b \\cdot e^{$a x / $b}\\) where \\(C = f(0)/$b\\)",
                sol("Answer", "f(x) = C e^{$(a*b) x / $b} = C e^{$a x / $b} for any constant \\(C\\), assuming \\($b \\neq 1\\)")
            ),
            time=300,
            calculator="none"
        )
        
    else  # problem_type == 5
        # Olympiad: Derivative involving composition with inverse function
        a = nonzero(2, 5)
        b = nonzero(2, 5)
        
        # If f(x) = x^a + bx and g is the inverse of f, find g'(f(c)) for some c
        c = nonzero(-3, 3)
        fc_val = c^a + b*c
        
        problem(
            question="Let \\(f(x) = x^{$a} + $(b)x\\) and suppose \\(g\\) is the inverse function of \\(f\\) on an appropriate domain. Find \\(g'(f($c))\\) without explicitly computing \\(g\\).",
            answer="\\frac{1}{$a \\cdot $(c)^{$(a-1)} + $b}",
            difficulty=(3600, 3900),
            answer_type="expression",
            solution=steps(
                sol("Given", "f(x) = x^{$a} + $(b)x, and \\(g = f^{-1}\\)"),
                "Use the inverse function theorem: If \\(g(f(x)) = x\\), then differentiating both sides gives \\(g'(f(x)) \\cdot f'(x) = 1\\)",
                "Therefore \\(g'(f(x)) = \\frac{1}{f'(x)}\\)",
                "Compute \\(f'(x) = $a x^{$(a-1)} + $b\\), so \\(f'($c) = $a \\cdot $(c)^{$(a-1)} + $b\\)",
                sol("Answer", "g'(f($c)) = \\frac{1}{$a \\cdot $(c)^{$(a-1)} + $b}")
            ),
            time=240,
            calculator="none"
        )
    end
end