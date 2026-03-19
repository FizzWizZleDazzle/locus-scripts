# calculus - lhopitals_rule (very_hard)
# Generated: 2026-03-08T20:44:24.805992

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/lhopitals_rule")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # 0/0 form with polynomial cancellation hidden by composition
        a = nonzero(-5, 5)
        n = rand(3:5)
        m = rand(2:4)
        
        # Create f(x) = (x^n - a^n)/(x^m - a^m) as x -> a
        numerator = x^n - a^n
        denominator = x^m - a^m
        
        # Apply L'Hopital's rule n times or m times (whichever is smaller)
        times_needed = min(n, m)
        
        final_num = numerator
        final_den = denominator
        
        for i in 1:times_needed
            final_num = diff(final_num, x)
            final_den = diff(final_den, x)
        end
        
        limit_val = substitute(final_num, x => a) / substitute(final_den, x => a)
        
        problem(
            question="Evaluate \\lim_{x \\to $(a)} \\frac{$(tex(numerator))}{$(tex(denominator))} using L'Hôpital's rule.",
            answer=limit_val,
            difficulty=(2500, 2800),
            solution=steps(
                sol("Given", "\\lim_{x \\to $(a)} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
                "Verify 0/0 form: numerator and denominator both equal 0 at x=$(a)",
                "Apply L'Hôpital's rule $(times_needed) time(s)",
                sol("After differentiation", "\\lim_{x \\to $(a)} \\frac{$(tex(final_num))}{$(tex(final_den))}"),
                "Substitute x=$(a)",
                sol("Answer", limit_val)
            ),
            time=240,
            calculator="scientific"
        )
        
    elseif problem_type == 2
        # ∞/∞ form with exponentials
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        k = rand(2:4)
        m = rand(1:3)
        
        # lim x->∞ (a*e^(k*x) + b*x^m) / e^(k*x)
        numerator = a * exp(k*x) + b * x^m
        denominator = exp(k*x)
        
        # After k applications, e^(kx) dominates
        limit_val = a
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))} using L'Hôpital's rule.",
            answer=limit_val,
            difficulty=(2600, 2900),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
                "Verify ∞/∞ form as x → ∞",
                "Apply L'Hôpital's rule repeatedly (polynomial terms vanish)",
                "After sufficient applications, \\frac{$(a) \\cdot $(k)^$(m+1) e^{$(k)x}}{$(k)^$(m+1) e^{$(k)x}}",
                sol("Answer", limit_val)
            ),
            time=270,
            calculator="scientific"
        )
        
    elseif problem_type == 3
        # 0·∞ form requiring rewriting
        a = rand(2:6)
        b = nonzero(-4, 4)
        
        # lim x->0+ x^a * ln(x) = lim x->0+ ln(x) / (1/x^a)
        # This is -∞/∞ form, apply L'Hopital
        # d/dx[ln(x)] = 1/x, d/dx[x^(-a)] = -a*x^(-a-1)
        # Result: lim (1/x) / (-a*x^(-a-1)) = lim x^a / (-a) = 0
        
        limit_val = 0
        
        problem(
            question="Evaluate \\lim_{x \\to 0^+} x^{$(a)} \\ln(x) by first rewriting as an \\frac{\\infty}{\\infty} or \\frac{0}{0} form, then applying L'Hôpital's rule.",
            answer=limit_val,
            difficulty=(2700, 3100),
            solution=steps(
                sol("Given", "\\lim_{x \\to 0^+} x^{$(a)} \\ln(x)"),
                "Rewrite as \\lim_{x \\to 0^+} \\frac{\\ln(x)}{x^{-$(a)}} (∞/∞ form)",
                "Apply L'Hôpital's rule: \\lim_{x \\to 0^+} \\frac{1/x}{-$(a) x^{-$(a)-1}}",
                "Simplify: \\lim_{x \\to 0^+} \\frac{x^{$(a)}}{-$(a)} = \\frac{0}{-$(a)}",
                sol("Answer", 0)
            ),
            time=300,
            calculator="scientific"
        )
        
    elseif problem_type == 4
        # Indeterminate form 1^∞
        a = rand(2:5)
        b = nonzero(-6, 6)
        
        # lim x->∞ (1 + a/x)^(b*x)
        # Take ln: lim b*x*ln(1+a/x) = lim b*ln(1+a/x)/(1/x) (0/0)
        # L'Hopital: lim b*(-a/x^2)/(1+a/x) / (-1/x^2) = lim b*a/(1+a/x) = b*a
        # So answer is e^(a*b)
        
        limit_val = exp(a*b)
        
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\left(1 + \\frac{$(a)}{x}\\right)^{$(b)x} using logarithmic differentiation and L'Hôpital's rule.",
            answer=limit_val,
            difficulty=(2800, 3200),
            solution=steps(
                sol("Given", "\\lim_{x \\to \\infty} \\left(1 + \\frac{$(a)}{x}\\right)^{$(b)x}"),
                "Take natural log: \\ln(L) = \\lim_{x \\to \\infty} $(b)x \\ln\\left(1 + \\frac{$(a)}{x}\\right)",
                "Rewrite as \\lim_{x \\to \\infty} \\frac{$(b)\\ln(1+$(a)/x)}{1/x} (0/0 form)",
                "Apply L'Hôpital's rule: \\lim_{x \\to \\infty} \\frac{$(b) \\cdot \\frac{-$(a)/x^2}{1+$(a)/x}}{-1/x^2} = $(a*b)",
                sol("Answer", "e^{$(a*b)} = $(round(limit_val, digits=4))")
            ),
            time=300,
            calculator="scientific"
        )
        
    else
        # Challenging 0/0 with trigonometric functions
        a = nonzero(-4, 4)
        n = rand(2:4)
        
        # lim x->0 (sin(a*x) - a*x*cos(a*x)) / x^(n+2)
        # Need multiple L'Hopital applications
        
        numerator = sin(a*x) - a*x*cos(a*x)
        denominator = x^(n+2)
        
        # After (n+2) applications, extract leading coefficient
        final_num = numerator
        final_den = denominator
        
        for i in 1:(n+2)
            final_num = diff(final_num, x)
            final_den = diff(final_den, x)
        end
        
        # Evaluate at x=0
        limit_val_num = substitute(final_num, x => 0)
        limit_val_den = substitute(final_den, x => 0)
        limit_val = limit_val_num / limit_val_den
        
        problem(
            question="Evaluate \\lim_{x \\to 0} \\frac{\\sin($(a)x) - $(a)x\\cos($(a)x)}{x^{$(n+2)}} using L'Hôpital's rule.",
            answer=limit_val,
            difficulty=(2900, 3400),
            solution=steps(
                sol("Given", "\\lim_{x \\to 0} \\frac{\\sin($(a)x) - $(a)x\\cos($(a)x)}{x^{$(n+2)}}"),
                "Verify 0/0 form at x=0",
                "Apply L'Hôpital's rule $(n+2) times",
                "After repeated differentiation, evaluate at x=0",
                sol("Answer", limit_val)
            ),
            time=300,
            calculator="scientific"
        )
    end
end