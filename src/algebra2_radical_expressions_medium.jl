# algebra2 - radical_expressions (medium)
# Generated: 2026-03-08T20:17:15.926034

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/radical_expressions")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simplifying radicals with variables (1200-1400)
        # √(a²b²c) = ab√c
        a = randint(2, 8)
        b = randint(2, 6)
        c = choice([2, 3, 5, 6, 7, 10, 11, 13, 14, 15])
        
        radicand = a^2 * b^2 * c
        ans_coeff = a * b
        
        problem(
            question="Simplify \\(\\sqrt{$(radicand)x^2}\\)",
            answer="$(ans_coeff)x\\sqrt{$(c)}",
            difficulty=(1200, 1350),
            solution=steps(
                sol("Given", "\\sqrt{$(radicand)x^2}"),
                "Factor perfect squares: \\(\\sqrt{$(a^2) \\cdot $(b^2) \\cdot $(c) \\cdot x^2}\\)",
                "Simplify: \\($(a) \\cdot $(b) \\cdot x \\cdot \\sqrt{$(c)} = $(ans_coeff)x\\sqrt{$(c)}\\)",
            ),
            time=90,
        )
        
    elseif problem_type == 2
        # Rationalizing denominators (1300-1500)
        # a/(b√c) = a√c/(bc)
        a = randint(2, 15)
        b = randint(2, 8)
        c = choice([2, 3, 5, 6, 7, 10, 11, 13])
        
        denom = b * c
        gcd_val = gcd(a, denom)
        num_simplified = div(a, gcd_val)
        denom_simplified = div(denom, gcd_val)
        
        if denom_simplified == 1
            ans_str = "$(num_simplified)\\sqrt{$(c)}"
        else
            ans_str = "\\frac{$(num_simplified)\\sqrt{$(c)}}{$(denom_simplified)}"
        end
        
        problem(
            question="Rationalize the denominator: \\(\\frac{$(a)}{$(b)\\sqrt{$(c)}}\\)",
            answer=ans_str,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", "\\frac{$(a)}{$(b)\\sqrt{$(c)}}"),
                "Multiply by \\(\\frac{\\sqrt{$(c)}}{\\sqrt{$(c)}}\\): \\(\\frac{$(a)\\sqrt{$(c)}}{$(b) \\cdot $(c)}\\)",
                "Simplify: \\($(ans_str)\\)",
            ),
            time=120,
        )
        
    elseif problem_type == 3
        # Rationalizing with binomial denominators (1500-1700)
        # 1/(a + b√c) = (a - b√c)/(a² - b²c)
        a = randint(2, 8)
        b = randint(2, 6)
        c = choice([2, 3, 5, 7])
        
        denom_result = a^2 - b^2 * c
        
        # Make sure denominator doesn't become zero or too small
        while abs(denom_result) < 2
            a = randint(2, 8)
            b = randint(2, 6)
            denom_result = a^2 - b^2 * c
        end
        
        gcd_a = gcd(a, abs(denom_result))
        gcd_b = gcd(b, abs(denom_result))
        gcd_val = gcd(gcd_a, gcd_b)
        
        num_a = div(a, gcd_val)
        num_b = div(b, gcd_val)
        final_denom = div(denom_result, gcd_val)
        
        sign = final_denom < 0 ? "-" : ""
        final_denom = abs(final_denom)
        
        if final_denom == 1
            ans_str = "$(sign)$(num_a) - $(num_b)\\sqrt{$(c)}"
        else
            ans_str = "\\frac{$(sign)$(num_a) - $(num_b)\\sqrt{$(c)}}{$(final_denom)}"
        end
        
        problem(
            question="Rationalize the denominator: \\(\\frac{1}{$(a) + $(b)\\sqrt{$(c)}}\\)",
            answer=ans_str,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", "\\frac{1}{$(a) + $(b)\\sqrt{$(c)}}"),
                "Multiply by conjugate: \\(\\frac{$(a) - $(b)\\sqrt{$(c)}}{($(a))^2 - ($(b))^2($(c))}\\)",
                "Simplify denominator: \\($(a^2) - $(b^2 * c) = $(denom_result)\\)",
                sol("Answer", ans_str),
            ),
            time=180,
        )
        
    elseif problem_type == 4
        # Solving radical equations (1400-1600)
        # √(ax + b) = c
        ans = randint(1, 25)
        a = randint(2, 8)
        b = randint(-15, 15)
        c = randint(3, 12)
        
        # Make sure c² = a*ans + b
        b = c^2 - a * ans
        
        problem(
            question="Solve for \\(x\\): \\(\\sqrt{$(a)x + $(b)} = $(c)\\)",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Given", "\\sqrt{$(a)x + $(b)} = $(c)"),
                "Square both sides: \\($(a)x + $(b) = $(c^2)\\)",
                "Solve for \\(x\\): \\($(a)x = $(c^2 - b)\\)",
                sol("Answer", "x = $(ans)"),
            ),
            time=120,
        )
        
    elseif problem_type == 5
        # Adding/subtracting radicals (1200-1400)
        # a√c + b√c = (a+b)√c
        a = randint(2, 9)
        b = randint(2, 9)
        c = choice([2, 3, 5, 6, 7, 10, 11, 13, 15])
        sum_val = a + b
        
        problem(
            question="Simplify: \\($(a)\\sqrt{$(c)} + $(b)\\sqrt{$(c)}\\)",
            answer="$(sum_val)\\sqrt{$(c)}",
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", "$(a)\\sqrt{$(c)} + $(b)\\sqrt{$(c)}"),
                "Combine like terms (same radical)",
                sol("Answer", "$(sum_val)\\sqrt{$(c)}"),
            ),
            time=60,
        )
        
    else
        # Solving equations with two radicals (1600-1800)
        # √(ax + b) + √(cx + d) = e
        ans = randint(2, 20)
        a = randint(2, 6)
        c = randint(2, 6)
        val1 = randint(2, 8)
        val2 = randint(2, 8)
        e = val1 + val2
        
        b = val1^2 - a * ans
        d = val2^2 - c * ans
        
        problem(
            question="Solve for \\(x\\): \\(\\sqrt{$(a)x + $(b)} + \\sqrt{$(c)x + $(d)} = $(e)\\)",
            answer=ans,
            difficulty=(1600, 1800),
            solution=steps(
                sol("Given", "\\sqrt{$(a)x + $(b)} + \\sqrt{$(c)x + $(d)} = $(e)"),
                "Isolate one radical and square both sides",
                "After simplification and solving: \\(x = $(ans)\\)",
                "Verify by substituting back into original equation",
            ),
            time=240,
        )
    end
end