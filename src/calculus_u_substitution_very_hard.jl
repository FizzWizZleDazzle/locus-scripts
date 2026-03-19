# calculus - u_substitution (very_hard)
# Generated: 2026-03-08T20:46:12.271291

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x u begin
    set_topic!("calculus/u_substitution")
    
    # Competition to Olympiad level (2500-3500): complex u-substitution problems
    # that require non-obvious substitutions, algebraic manipulation, or multiple insights
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: Disguised rational function requiring clever substitution
        # ∫ x³/(x²+a)^n dx where u = x²+a
        a = randint(1, 15)
        n = randint(2, 4)
        
        # Answer requires splitting: x³ = x · x² = x · (u - a)
        # ∫ x³/(x²+a)^n dx = (1/2)∫ (u-a)/u^n du
        
        if n == 2
            # (1/2)[ln|u| + a/u] + C
            ans_str = "\\frac{1}{2}\\ln|x^2 + $a| + \\frac{$(a)}{2(x^2 + $a)} + C"
        elseif n == 3
            # (1/2)[-1/u - a/(2u²)] + C
            ans_str = "-\\frac{1}{2(x^2 + $a)} - \\frac{$(a)}{4(x^2 + $a)^2} + C"
        else # n == 4
            ans_str = "-\\frac{1}{4(x^2 + $a)^2} - \\frac{$(a)}{6(x^2 + $a)^3} + C"
        end
        
        problem(
            question = "Evaluate \\displaystyle\\int \\frac{x^3}{(x^2 + $a)^{$n}} \\, dx",
            answer = ans_str,
            difficulty = (2500, 2900),
            solution = steps(
                "Observe that the derivative of \\(x^2 + $a\\) is \\(2x\\), suggesting \\(u = x^2 + $a\\)",
                "Rewrite: \\(x^3 = x \\cdot x^2 = x \\cdot (u - $a)\\), so \\(x^3 \\, dx = \\frac{1}{2}(u - $a) \\, du\\)",
                "The integral becomes \\(\\frac{1}{2}\\int \\frac{u - $a}{u^{$n}} \\, du = \\frac{1}{2}\\int \\left(u^{$(1-n)} - $(a)u^{-$n}\\right) du\\)",
                "Integrate term by term using power rule",
                sol("Answer", ans_str)
            ),
            time = 240
        )
        
    elseif problem_type == 2
        # Type 2: Nested substitution requiring back-substitution insight
        # ∫ x/(√(ax+b) + c)² dx where you need to substitute u = √(ax+b)
        a = randint(2, 8)
        b = randint(1, 12)
        c = randint(2, 9)
        
        # u = √(ax+b), u² = ax+b, x = (u²-b)/a, dx = (2u/a)du
        # Integral becomes: ∫ (u²-b)/(a(u+c)²) · (2u/a) du = (2/a²)∫ u(u²-b)/(u+c)² du
        
        ans_str = "\\frac{2}{$a}\\sqrt{$(a)x + $b} - \\frac{$(2*c)}{$a}\\ln|\\sqrt{$(a)x + $b} + $c| + \\frac{$(2*c*c - 2*b)}{$(a)^2(\\sqrt{$(a)x + $b} + $c)} + C"
        
        problem(
            question = "Evaluate \\displaystyle\\int \\frac{x}{(\\sqrt{$(a)x + $b} + $c)^2} \\, dx",
            answer = ans_str,
            difficulty = (2700, 3200),
            solution = steps(
                "Let \\(u = \\sqrt{$(a)x + $b}\\), so \\(u^2 = $(a)x + $b\\) and \\(x = \\frac{u^2 - $b}{$a}\\)",
                "Then \\(dx = \\frac{2u}{$a} \\, du\\)",
                "Substitute: \\(\\int \\frac{u^2 - $b}{$(a)(u + $c)^2} \\cdot \\frac{2u}{$a} \\, du = \\frac{2}{$(a*a)}\\int \\frac{u(u^2 - $b)}{(u + $c)^2} \\, du\\)",
                "Perform polynomial long division on \\(\\frac{u^3 - $(b)u}{(u + $c)^2}\\), then integrate",
                "Back-substitute \\(u = \\sqrt{$(a)x + $b}\\)",
                sol("Answer", ans_str)
            ),
            time = 300
        )
        
    elseif problem_type == 3
        # Type 3: Trigonometric substitution requiring clever rewrite
        # ∫ sin^m(x)cos^n(x) dx with odd powers requiring multiple steps
        m = 2 * randint(1, 3) + 1  # odd: 3, 5, 7
        n = 2 * randint(1, 2)      # even: 2, 4
        
        # Strategy: peel off sin(x), use sin²(x) = 1 - cos²(x), let u = cos(x)
        ans_parts = []
        sign = (-1)^((m+1)÷2)
        
        if m == 3 && n == 2
            ans_str = "\\frac{\\cos^3(x)}{3} - \\frac{\\cos^5(x)}{5} + C"
        elseif m == 5 && n == 2
            ans_str = "-\\frac{\\cos^3(x)}{3} + \\frac{2\\cos^5(x)}{5} - \\frac{\\cos^7(x)}{7} + C"
        elseif m == 3 && n == 4
            ans_str = "\\frac{\\cos^5(x)}{5} - \\frac{\\cos^7(x)}{7} + C"
        else
            ans_str = "-\\frac{\\cos^{$(n+1)}(x)}{$(n+1)} + \\frac{2\\cos^{$(n+3)}(x)}{$(n+3)} - \\frac{\\cos^{$(n+5)}(x)}{$(n+5)} + C"
        end
        
        problem(
            question = "Evaluate \\displaystyle\\int \\sin^{$m}(x) \\cos^{$n}(x) \\, dx",
            answer = ans_str,
            difficulty = (2600, 3100),
            solution = steps(
                "Since the power of sine is odd, peel off one factor: \\(\\sin^{$m}(x) = \\sin^{$(m-1)}(x) \\sin(x)\\)",
                "Use the identity \\(\\sin^2(x) = 1 - \\cos^2(x)\\) to rewrite \\(\\sin^{$(m-1)}(x)\\) in terms of \\(\\cos(x)\\)",
                "Let \\(u = \\cos(x)\\), so \\(du = -\\sin(x) \\, dx\\)",
                "The integral becomes \\(-\\int u^{$n}(1 - u^2)^{$(div(m-1,2))} \\, du\\)",
                "Expand \\((1 - u^2)^{$(div(m-1,2))}\\) and integrate term by term",
                sol("Answer", ans_str)
            ),
            time = 270
        )
        
    elseif problem_type == 4
        # Type 4: Exponential-polynomial requiring integration by parts after substitution
        # ∫ x²e^(ax) dx but disguised as ∫ (u-b)²e^u/a du through initial substitution
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        
        if a > 0
            ans_str = "\\frac{e^{$(a)x + $b}}{$(a)^3}\\left[$(a)^2 x^2 - 2$(a)x + 2\\right] + C"
        else
            ans_str = "\\frac{e^{$(a)x + $b}}{$(a)^3}\\left[$(a)^2 x^2 - 2$(a)x + 2\\right] + C"
        end
        
        problem(
            question = "Evaluate \\displaystyle\\int x^2 e^{$(a)x + $b} \\, dx",
            answer = ans_str,
            difficulty = (2500, 2800),
            solution = steps(
                "Let \\(u = $(a)x + $b\\), so \\(x = \\frac{u - $b}{$a}\\) and \\(dx = \\frac{1}{$a} \\, du\\)",
                "The integral becomes \\(\\frac{1}{$a}\\int \\left(\\frac{u - $b}{$a}\\right)^2 e^u \\, du = \\frac{1}{$(a*a*a)}\\int (u - $b)^2 e^u \\, du\\)",
                "Apply integration by parts twice on \\(\\int (u - $b)^2 e^u \\, du\\)",
                "First: \\(v = (u-$b)^2, dw = e^u du\\) gives \\((u-$b)^2 e^u - 2\\int (u-$b)e^u du\\)",
                "Second: Apply parts again to get \\((u-$b)^2 e^u - 2(u-$b)e^u + 2e^u + C\\)",
                "Substitute back \\(u = $(a)x + $b\\) and simplify"
            ),
            time = 300
        )
        
    else # problem_type == 5
        # Type 5: Rational function requiring partial fraction AFTER substitution
        # ∫ dx/((x+a)√(x+b)) where u = √(x+b) converts to rational in u
        a = randint(2, 12)
        b = randint(1, 10)
        diff_val = abs(a - b)
        
        if a != b
            if a > b
                ans_str = "\\frac{2}{\\sqrt{$(diff_val)}}\\arctan\\left(\\frac{\\sqrt{x + $b}}{\\sqrt{$(diff_val)}}\\right) + C"
            else
                ans_str = "\\frac{1}{\\sqrt{$(diff_val)}}\\ln\\left|\\frac{\\sqrt{x + $b} - \\sqrt{$(diff_val)}}{\\sqrt{x + $b} + \\sqrt{$(diff_val)}}\\right| + C"
            end
        else
            ans_str = "-\\frac{2}{\\sqrt{x + $b}} + C"
        end
        
        problem(
            question = "Evaluate \\displaystyle\\int \\frac{dx}{(x + $a)\\sqrt{x + $b}}",
            answer = ans_str,
            difficulty = (2800, 3400),
            solution = steps(
                "Let \\(u = \\sqrt{x + $b}\\), so \\(u^2 = x + $b\\) and \\(x = u^2 - $b\\)",
                "Then \\(dx = 2u \\, du\\) and \\(x + $a = u^2 - $b + $a = u^2 + $(a-b)\\)",
                "The integral becomes \\(\\int \\frac{2u}{(u^2 + $(a-b))u} \\, du = 2\\int \\frac{du}{u^2 + $(a-b)}\\)",
                a > b ? "This is of the form \\(\\int \\frac{du}{u^2 + a^2}\\), use \\(\\arctan\\) formula" : "Use partial fractions or logarithmic integration",
                "Apply the standard integral formula and back-substitute \\(u = \\sqrt{x + $b}\\)",
                sol("Answer", ans_str)
            ),
            time = 300
        )
    end
end