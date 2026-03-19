# algebra2 - logarithmic_equations (hard)
# Generated: 2026-03-08T20:21:26.017510

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra2/logarithmic_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type: log_b(ax + c) = d, solve for x (1800-2000)
        base = choice([2, 3, 4, 5, 10])
        d = randint(2, 4)
        target = base^d
        a = nonzero(-5, 5)
        c = randint(-20, 20)
        ans = (target - c) // a
        
        if a == 1
            lhs_expr = x + c
        else
            lhs_expr = a*x + c
        end
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$base}($( tex(lhs_expr) )) = $d\\)",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                "Given: \\(\\log_{$base}($( tex(lhs_expr) )) = $d\\)",
                "Convert to exponential form: \\($( tex(lhs_expr) ) = $base^{$d} = $target\\)",
                "Solve for \\(x\\): \\($( tex(a*x) ) = $(target - c)\\)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Type: log(x) + log(ax + b) = log(c), solve for x (1900-2100)
        r1 = nonzero(1, 15)
        r2 = choice([val for val in -15:15 if val != 0 && val != r1])
        
        a = -(r1 + r2)
        b = r1 * r2
        c = r1 * (a * r1 + b)
        
        valid_root = r1 > 0 && (a * r1 + b) > 0 ? r1 : (r2 > 0 && (a * r2 + b) > 0 ? r2 : nothing)
        
        if valid_root === nothing
            r1 = randint(3, 12)
            a = randint(1, 5)
            b = randint(1, 10)
            c = r1 * (a * r1 + b)
            valid_root = r1
        end
        
        problem(
            question="Solve for \\(x\\): \\(\\log(x) + \\log($( a != 1 ? "$a x" : "x" )$(b >= 0 ? " + $b" : " - $(-b)")) = \\log($c)\\)",
            answer=valid_root,
            difficulty=(1900, 2100),
            solution=steps(
                "Use logarithm property: \\(\\log(x) + \\log($( a != 1 ? "$a x" : "x" )$(b >= 0 ? " + $b" : " - $(-b)")) = \\log(x($( a != 1 ? "$a x" : "x" )$(b >= 0 ? " + $b" : " - $(-b)")))\\)",
                "Set arguments equal: \\(x($( a != 1 ? "$a x" : "x" )$(b >= 0 ? " + $b" : " - $(-b)")) = $c\\)",
                "Expand and solve: \\($( a != 1 ? "$(a)x^2" : "x^2" )$(b >= 0 ? " + $(b)x" : " - $(-b)x") - $c = 0\\)",
                "Check domain: \\(x > 0\\) and \\($( a != 1 ? "$a x" : "x" )$(b >= 0 ? " + $b" : " - $(-b)") > 0\\)",
                sol("Answer", valid_root)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Type: log_b(x^2 + cx) - log_b(x) = d (2000-2200)
        base = choice([2, 3, 5])
        d = randint(1, 3)
        k = base^d
        c = randint(2, 10)
        ans = k - c
        
        if ans <= 0
            ans = randint(1, 10)
            c = k - ans
        end
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$base}(x^2 + $(c)x) - \\log_{$base}(x) = $d\\)",
            answer=ans,
            difficulty=(2000, 2200),
            solution=steps(
                "Use quotient property: \\(\\log_{$base}\\left(\\frac{x^2 + $(c)x}{x}\\right) = $d\\)",
                "Simplify: \\(\\log_{$base}(x + $c) = $d\\)",
                "Convert to exponential: \\(x + $c = $base^{$d} = $k\\)",
                "Solve: \\(x = $(k - c)\\)",
                "Verify domain: \\(x > 0\\) and \\(x^2 + $(c)x > 0\\)",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Type: log_a(x) * log_x(a) = c (2100-2300)
        c = randint(2, 5)
        
        problem(
            question="Solve for \\(x\\) (where \\(x > 0, x \\neq 1\\)): \\(\\log_3(x) \\cdot \\log_x(3) = $c\\)",
            answer=Set([]),
            answer_type="set",
            difficulty=(2100, 2300),
            solution=steps(
                "Use change of base property: \\(\\log_x(3) = \\frac{1}{\\log_3(x)}\\)",
                "Substitute: \\(\\log_3(x) \\cdot \\frac{1}{\\log_3(x)} = $c\\)",
                "Simplify: \\(1 = $c\\)",
                "This is a contradiction, so there is no solution",
                sol("Answer", "\\emptyset")
            ),
            time=150
        )
        
    else
        # Type: ln(2x + 1) - ln(x - 3) = ln(k) (2000-2400)
        ans = randint(8, 20)
        k_num = 2 * ans + 1
        k_den = ans - 3
        k = k_num // k_den
        
        problem(
            question="Solve for \\(x\\): \\(\\ln(2x + 1) - \\ln(x - 3) = \\ln\\left(\\frac{$k_num}{$k_den}\\right)\\)",
            answer=ans,
            difficulty=(2000, 2400),
            solution=steps(
                "Use quotient property: \\(\\ln\\left(\\frac{2x + 1}{x - 3}\\right) = \\ln\\left(\\frac{$k_num}{$k_den}\\right)\\)",
                "Set arguments equal: \\(\\frac{2x + 1}{x - 3} = \\frac{$k_num}{$k_den}\\)",
                "Cross multiply: \\($k_den(2x + 1) = $k_num(x - 3)\\)",
                "Expand: \\($(2*k_den)x + $k_den = $(k_num)x - $(3*k_num)\\)",
                "Solve: \\(x = $ans\\)",
                "Verify domain: \\(2x + 1 > 0\\) and \\(x - 3 > 0\\) ✓",
                sol("Answer", ans)
            ),
            time=200
        )
    end
end