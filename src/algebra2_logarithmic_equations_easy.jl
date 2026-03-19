# algebra2 - logarithmic_equations (easy)
# Generated: 2026-03-08T20:20:56.762716

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra2/logarithmic_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple log equation: log_b(x) = c, answer is b^c
        base = choice([2, 3, 4, 5, 10])
        c = randint(1, 4)
        ans = base^c
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$base}(x) = $c\\)",
            answer=ans,
            difficulty=(700, 850),
            solution=steps(
                "Given: \\(\\log_{$base}(x) = $c\\)",
                "Convert to exponential form: \\(x = $base^{$c}\\)",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif problem_type == 2
        # log_b(ax + c) = d, solve for x
        base = choice([2, 3, 5, 10])
        a = nonzero(-5, 5)
        c = randint(-10, 10)
        d = randint(1, 3)
        # ax + c = base^d
        # x = (base^d - c) / a
        ans = (base^d - c) // a
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$base}($(tex(a*x + c))) = $d\\)",
            answer=ans,
            difficulty=(800, 950),
            solution=steps(
                "Given: \\(\\log_{$base}($(tex(a*x + c))) = $d\\)",
                "Convert to exponential form: \\($(tex(a*x + c)) = $base^{$d} = $(base^d)\\)",
                "Solve for \\(x\\): \\($(a)x = $(base^d - c)\\)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 3
        # log(x) + log(y) = c, where x and y are expressions, use product rule
        base = choice([2, 3, 5, 10])
        # Choose ans first, then factor it
        ans = randint(4, 50)
        # Find two factors
        factors = []
        for i in 2:Int(floor(sqrt(ans)))
            if ans % i == 0
                push!(factors, (i, ans ÷ i))
            end
        end
        if isempty(factors)
            # ans is prime, use 1 and ans
            f1, f2 = 1, ans
        else
            f1, f2 = choice(factors)
        end
        
        c = randint(1, 3)
        target = base^c
        
        # Make sure f1 * f2 = target
        valid_f1 = [i for i in 2:min(10, target) if target % i == 0 && target ÷ i >= 2]
        if isempty(valid_f1)
            f1 = 1
            f2 = target
        else
            f1 = choice(valid_f1)
            f2 = target ÷ f1
        end
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$base}(x) + \\log_{$base}($f1) = $c\\)",
            answer=f2,
            difficulty=(850, 1000),
            solution=steps(
                "Given: \\(\\log_{$base}(x) + \\log_{$base}($f1) = $c\\)",
                "Use product rule: \\(\\log_{$base}(x \\cdot $f1) = $c\\)",
                "Convert to exponential form: \\(x \\cdot $f1 = $base^{$c} = $target\\)",
                sol("Answer", f2)
            ),
            time=120
        )
        
    elseif problem_type == 4
        # log(x) - log(y) = c, use quotient rule
        base = choice([2, 3, 5, 10])
        c = randint(1, 3)
        target = base^c
        
        # x/y = target, choose y then x = target * y
        y_val = randint(2, 8)
        x_val = target * y_val
        
        problem(
            question="Solve for \\(x\\): \\(\\log_{$base}(x) - \\log_{$base}($y_val) = $c\\)",
            answer=x_val,
            difficulty=(900, 1050),
            solution=steps(
                "Given: \\(\\log_{$base}(x) - \\log_{$base}($y_val) = $c\\)",
                "Use quotient rule: \\(\\log_{$base}\\left(\\frac{x}{$y_val}\\right) = $c\\)",
                "Convert to exponential form: \\(\\frac{x}{$y_val} = $base^{$c} = $target\\)",
                sol("Answer", x_val)
            ),
            time=120
        )
        
    else
        # 2*log(x) = c or c*log(x) = d, use power rule
        base = choice([2, 3, 5, 10])
        coeff = randint(2, 4)
        d = randint(2, 6)
        
        # coeff * log_base(x) = d
        # log_base(x) = d/coeff
        # x = base^(d/coeff)
        
        if d % coeff == 0
            exp_val = d ÷ coeff
            ans = base^exp_val
            exp_str = string(exp_val)
        else
            ans = base^(d//coeff)
            exp_str = "\\frac{$d}{$coeff}"
        end
        
        problem(
            question="Solve for \\(x\\): \\($coeff \\log_{$base}(x) = $d\\)",
            answer=ans,
            difficulty=(850, 1100),
            solution=steps(
                "Given: \\($coeff \\log_{$base}(x) = $d\\)",
                "Divide both sides by $coeff: \\(\\log_{$base}(x) = $exp_str\\)",
                "Convert to exponential form: \\(x = $base^{$exp_str}\\)",
                sol("Answer", ans)
            ),
            time=90
        )
    end
end