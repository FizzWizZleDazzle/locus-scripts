# calculus - u_substitution (medium)
# Generated: 2026-03-08T20:45:34.283842

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x u begin
    set_topic!("calculus/u_substitution")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Basic polynomial u-substitution: ∫(ax+b)^n dx where n ≠ -1
        a = nonzero(-8, 8)
        b = randint(-15, 15)
        n = choice([2, 3, 4, 5, 6, 7])
        
        inner = a*x + b
        integrand = inner^n
        
        # Answer: (ax+b)^(n+1) / (a(n+1)) + C
        ans = inner^(n+1) / (a*(n+1))
        
        problem(
            question="Evaluate \\(\\displaystyle \\int $(tex(integrand)) \\, dx\\)",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", integrand),
                "Let \\(u = $(tex(inner))\\), then \\(du = $(a) \\, dx\\)",
                "Rewrite: \\(\\displaystyle \\int u^{$n} \\cdot \\frac{1}{$a} \\, du = \\frac{1}{$a} \\cdot \\frac{u^{$(n+1)}}{$(n+1)}\\)",
                "Substitute back: \\(\\displaystyle \\frac{($(tex(inner)))^{$(n+1)}}{$(a*(n+1))} + C\\)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Chain rule with exponential: ∫e^(ax+b) dx
        a = nonzero(-6, 6)
        b = randint(-12, 12)
        
        inner = a*x + b
        integrand = exp(inner)
        
        # Answer: e^(ax+b) / a + C
        ans = exp(inner) / a
        
        problem(
            question="Evaluate \\(\\displaystyle \\int e^{$(tex(inner))} \\, dx\\)",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", integrand),
                "Let \\(u = $(tex(inner))\\), then \\(du = $(a) \\, dx\\)",
                "Rewrite: \\(\\displaystyle \\int e^u \\cdot \\frac{1}{$a} \\, du = \\frac{1}{$a} e^u\\)",
                "Substitute back: \\(\\displaystyle \\frac{e^{$(tex(inner))}}{$a} + C\\)",
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Rational function needing u-sub: ∫(ax+b)/(cx+d)^n dx
        a = nonzero(-7, 7)
        b = randint(-10, 10)
        c = nonzero(-7, 7)
        d = randint(-10, 10)
        n = choice([2, 3, 4])
        
        numerator = a*x + b
        denominator = (c*x + d)^n
        integrand = numerator / denominator
        
        # For simplicity, choose a = k*c for some k to make it clean
        k = randint(2, 5)
        a = k * c
        remainder = b - k*d
        
        numerator = a*x + b
        integrand = numerator / denominator
        
        # Answer: k/(c(1-n)) * (cx+d)^(1-n) + remainder/(c(2-n))*(cx+d)^(2-n) + C
        # Simplified for n=2: k*ln|cx+d|/c + remainder/(c(cx+d)) + C
        if n == 2
            ans = (k / c) * log(abs(c*x + d)) + remainder / (c * (c*x + d))
        else
            ans = (k / (c*(1-n))) * (c*x + d)^(1-n) + (remainder / (c*(2-n))) * (c*x + d)^(2-n)
        end
        
        problem(
            question="Evaluate \\(\\displaystyle \\int \\frac{$(tex(numerator))}{$(tex(denominator))} \\, dx\\)",
            answer=ans,
            difficulty=(1400, 1700),
            solution=steps(
                sol("Given", integrand),
                "Let \\(u = $(tex(c*x + d))\\), then \\(du = $(c) \\, dx\\)",
                "Rewrite numerator as \\($(tex(numerator)) = $(k)($(tex(c*x + d))) $(remainder >= 0 ? "+" : "") $(remainder)\\)",
                "Split integral and apply u-substitution",
                sol("Answer", ans)
            ),
            time=180
        )
        
    elseif problem_type == 4
        # Product requiring u-sub: ∫x(ax²+b)^n dx
        a = nonzero(-5, 5)
        b = randint(-20, 20)
        n = choice([2, 3, 4, 5])
        
        inner = a*x^2 + b
        integrand = x * inner^n
        
        # Answer: (ax²+b)^(n+1) / (2a(n+1)) + C
        ans = inner^(n+1) / (2*a*(n+1))
        
        problem(
            question="Evaluate \\(\\displaystyle \\int x($(tex(inner)))^{$n} \\, dx\\)",
            answer=ans,
            difficulty=(1300, 1600),
            solution=steps(
                sol("Given", integrand),
                "Let \\(u = $(tex(inner))\\), then \\(du = $(2*a)x \\, dx\\)",
                "Rewrite: \\(\\displaystyle \\int u^{$n} \\cdot \\frac{1}{$(2*a)} \\, du = \\frac{1}{$(2*a)} \\cdot \\frac{u^{$(n+1)}}{$(n+1)}\\)",
                "Substitute back: \\(\\displaystyle \\frac{($(tex(inner)))^{$(n+1)}}{$(2*a*(n+1))} + C\\)",
                sol("Answer", ans)
            ),
            time=150
        )
        
    else
        # Trig substitution: ∫sin^n(x)cos(x) dx or ∫cos^n(x)sin(x) dx
        n = choice([2, 3, 4, 5, 6])
        trig_choice = rand(1:2)
        
        if trig_choice == 1
            # ∫sin^n(x)cos(x) dx
            integrand = sin(x)^n * cos(x)
            inner = sin(x)
            ans = sin(x)^(n+1) / (n+1)
            
            problem(
                question="Evaluate \\(\\displaystyle \\int \\sin^{$n}(x)\\cos(x) \\, dx\\)",
                answer=ans,
                difficulty=(1200, 1500),
                solution=steps(
                    sol("Given", integrand),
                    "Let \\(u = \\sin(x)\\), then \\(du = \\cos(x) \\, dx\\)",
                    "Rewrite: \\(\\displaystyle \\int u^{$n} \\, du = \\frac{u^{$(n+1)}}{$(n+1)}\\)",
                    "Substitute back: \\(\\displaystyle \\frac{\\sin^{$(n+1)}(x)}{$(n+1)} + C\\)",
                    sol("Answer", ans)
                ),
                time=120
            )
        else
            # ∫cos^n(x)sin(x) dx (with sign change)
            integrand = cos(x)^n * sin(x)
            inner = cos(x)
            ans = -cos(x)^(n+1) / (n+1)
            
            problem(
                question="Evaluate \\(\\displaystyle \\int \\cos^{$n}(x)\\sin(x) \\, dx\\)",
                answer=ans,
                difficulty=(1200, 1500),
                solution=steps(
                    sol("Given", integrand),
                    "Let \\(u = \\cos(x)\\), then \\(du = -\\sin(x) \\, dx\\)",
                    "Rewrite: \\(\\displaystyle \\int u^{$n} \\cdot (-1) \\, du = -\\frac{u^{$(n+1)}}{$(n+1)}\\)",
                    "Substitute back: \\(\\displaystyle -\\frac{\\cos^{$(n+1)}(x)}{$(n+1)} + C\\)",
                    sol("Answer", ans)
                ),
                time=120
            )
        end
    end
end