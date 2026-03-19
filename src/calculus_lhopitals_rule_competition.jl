# calculus - lhopitals_rule (competition)
# Generated: 2026-03-08T20:44:52.849119

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x a b c n m k begin
    set_topic!("calculus/lhopitals_rule")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Challenging indeterminate form with nested exponentials and logs
        α = randint(2, 5)
        β = randint(2, 5)
        γ = randint(2, 4)
        
        # lim (x^α * e^(-x^β) * ln^γ(x)) as x → ∞
        # Rewrite as ln^γ(x) / (e^(x^β) / x^α) = ln^γ(x) / (e^(x^β) * x^(-α))
        # Multiple applications of L'Hôpital needed
        
        question_str = "Evaluate \\lim_{x \\to \\infty} x^{$α} e^{-x^{$β}} (\\ln x)^{$γ}"
        
        solution_steps = steps(
            "Given: \\lim_{x \\to \\infty} x^{$α} e^{-x^{$β}} (\\ln x)^{$γ}",
            "Rewrite as \\frac{(\\ln x)^{$γ}}{e^{x^{$β}} \\cdot x^{-$α}} = \\frac{x^{$α} (\\ln x)^{$γ}}{e^{x^{$β}}}",
            "This is \\frac{\\infty}{\\infty} form, apply L'Hôpital's rule repeatedly",
            "The exponential e^{x^{$β}} grows faster than any polynomial times any power of logarithm",
            "Each application reduces the power of ln until polynomials remain",
            "After $γ applications for ln terms and considering x^{$α}, exponential still dominates",
            "\\lim_{x \\to \\infty} \\frac{x^{$α} (\\ln x)^{$γ}}{e^{x^{$β}}} = 0"
        )
        
        problem(
            question=question_str,
            answer=0,
            difficulty=(3500, 4000),
            solution=solution_steps,
            time=300
        )
        
    elseif problem_type == 2
        # Highly nested logarithmic indeterminate form
        p = randint(3, 6)
        q = randint(2, 4)
        
        # lim (ln(ln(x^p))) / (ln(x^q)) as x → ∞
        # = lim p*ln(ln(x)) / (q*ln(x))
        
        question_str = "Evaluate \\lim_{x \\to \\infty} \\frac{\\ln(\\ln(x^{$p}))}{\\ln(x^{$q})}"
        
        solution_steps = steps(
            "Given: \\lim_{x \\to \\infty} \\frac{\\ln(\\ln(x^{$p}))}{\\ln(x^{$q})}",
            "Simplify using logarithm properties: \\frac{\\ln($p \\ln x)}{$q \\ln x}",
            "Expand numerator: \\frac{\\ln($p) + \\ln(\\ln x)}{$q \\ln x}",
            "Split: \\frac{\\ln($p)}{$q \\ln x} + \\frac{\\ln(\\ln x)}{$q \\ln x}",
            "As x \\to \\infty, \\ln x \\to \\infty, so first term \\to 0",
            "For second term, use substitution u = \\ln x, as x \\to \\infty, u \\to \\infty",
            "\\lim_{u \\to \\infty} \\frac{\\ln u}{$q u} = 0 by L'Hôpital or growth rate comparison",
            "Therefore the limit is 0"
        )
        
        problem(
            question=question_str,
            answer=0,
            difficulty=(3800, 4300),
            solution=solution_steps,
            time=360
        )
        
    elseif problem_type == 3
        # Complex trigonometric limit with oscillation
        α = randint(2, 5)
        β = randint(3, 7)
        
        # lim (sin(x^α) - x^α * cos(x^β)) / x^(2α) as x → 0
        
        question_str = "Evaluate \\lim_{x \\to 0} \\frac{\\sin(x^{$α}) - x^{$α} \\cos(x^{$β})}{x^{$(2*α)}}"
        
        solution_steps = steps(
            "Given: \\lim_{x \\to 0} \\frac{\\sin(x^{$α}) - x^{$α} \\cos(x^{$β})}{x^{$(2*α)}}",
            "This is \\frac{0}{0} form. Apply L'Hôpital's rule",
            "Differentiate numerator: $α x^{$(α-1)} \\cos(x^{$α}) - $α x^{$(α-1)} \\cos(x^{$β}) + $β x^{$(α+β-1)} \\sin(x^{$β})",
            "Differentiate denominator: $(2*α) x^{$(2*α-1)}",
            "Simplify: \\frac{$α x^{$(α-1)}(\\cos(x^{$α}) - \\cos(x^{$β})) + $β x^{$(α+β-1)} \\sin(x^{$β})}{$(2*α) x^{$(2*α-1)}}",
            "Factor x^{$(α-1)}: \\frac{\\cos(x^{$α}) - \\cos(x^{$β})}{$(2) x^{$α}} + \\frac{$β x^{$β} \\sin(x^{$β})}{$(2*α) x^{$α}}",
            "As x \\to 0: \\cos(x^{$α}) \\to 1, \\cos(x^{$β}) \\to 1, so first term \\to 0",
            "Second term: if $β > $α, it \\to 0; if $β = $α, \\to \\frac{$β}{$(2*α)}; if $β < $α, needs more analysis",
            if β > α
                "Since $β > $α, the limit is 0"
            elseif β == α
                "Since $β = $α, using \\lim_{u\\to 0} \\frac{\\sin u}{u} = 1, limit is \\frac{$β}{$(2*α)} = $(β//(2*α))"
            else
                "Since $β < $α, further applications needed, ultimately yielding 0"
            end
        )
        
        ans_val = β >= α ? (β == α ? β//(2*α) : 0) : 0
        
        problem(
            question=question_str,
            answer=ans_val,
            difficulty=(4000, 4500),
            solution=solution_steps,
            time=420
        )
        
    elseif problem_type == 4
        # Indeterminate form ∞ - ∞ with complex algebraic manipulation
        p = randint(3, 6)
        q = randint(2, p-1)
        
        # lim (x^p - (x^p + x^q)^(1 - 1/p)) as x → ∞
        
        question_str = "Evaluate \\lim_{x \\to \\infty} \\left( x^{$p} - (x^{$p} + x^{$q})^{1 - \\frac{1}{$p}} \\right)"
        
        exponent_val = (p-1)//p
        
        solution_steps = steps(
            "Given: \\lim_{x \\to \\infty} \\left( x^{$p} - (x^{$p} + x^{$q})^{$(exponent_val)} \\right)",
            "This is \\infty - \\infty form. Factor out x^{$p} from second term",
            "(x^{$p} + x^{$q})^{$(exponent_val)} = x^{$(p)*$(exponent_val)} (1 + x^{$(q-p)})^{$(exponent_val)}",
            "= x^{$(p-1)} (1 + x^{$(q-p)})^{$(exponent_val)}",
            "Rewrite limit: x^{$p} - x^{$(p-1)} (1 + x^{$(q-p)})^{$(exponent_val)}",
            "Factor x^{$(p-1)}: x^{$(p-1)} \\left( x - (1 + x^{$(q-p)})^{$(exponent_val)} \\right)",
            "Let u = x^{$(q-p)}, as x \\to \\infty with q < p, u \\to 0",
            "Use binomial approximation: (1+u)^{$(exponent_val)} \\approx 1 + $(exponent_val) u + O(u^2)",
            "x - x(1 + $(exponent_val) x^{$(q-p)} + O(x^{$(2*(q-p))})) = -x \\cdot $(exponent_val) x^{$(q-p)} + O(x^{$(1+2*(q-p))})",
            "= -$(exponent_val) x^{$(q-p+1)} + ... → -\\infty as x \\to \\infty",
            "Therefore the limit is -\\infty"
        )
        
        problem(
            question=question_str,
            answer="-\\infty",
            difficulty=(4200, 4700),
            solution=solution_steps,
            answer_type="text",
            time=480
        )
        
    elseif problem_type == 5
        # Extremely challenging parametric limit
        α = randint(3, 7)
        β = randint(2, 5)
        
        # lim (1 + a/x^α)^(x^β) as x → ∞, find value of a that makes limit = e^k
        target_k = randint(2, 6)
        
        question_str = "Find the value of a such that \\lim_{x \\to \\infty} \\left(1 + \\frac{a}{x^{$α}}\\right)^{x^{$β}} = e^{$target_k}"
        
        # For limit to equal e^k, we need a * x^(β-α) → k
        # This only works if β = α, otherwise limit is 0, 1, or ∞
        
        if β == α
            ans_val = target_k
            solution_steps = steps(
                "Given: \\lim_{x \\to \\infty} \\left(1 + \\frac{a}{x^{$α}}\\right)^{x^{$β}} = e^{$target_k}",
                "Take natural log of both sides: \\ln(\\lim) = $target_k",
                "\\lim_{x \\to \\infty} x^{$β} \\ln\\left(1 + \\frac{a}{x^{$α}}\\right) = $target_k",
                "Since $β = $α, use \\ln(1+u) \\approx u for small u",
                "\\lim_{x \\to \\infty} x^{$α} \\cdot \\frac{a}{x^{$α}} = \\lim_{x \\to \\infty} a = $target_k",
                "For more rigor: rewrite as \\frac{\\ln(1 + a/x^{$α})}{1/x^{$α}}",
                "This is \\frac{0}{0} form, apply L'Hôpital's rule",
                "After simplification, the limit equals a",
                "Therefore a = $target_k"
            )
        else
            ans_val = "\\text{No finite value exists}"
            solution_steps = steps(
                "Given: \\lim_{x \\to \\infty} \\left(1 + \\frac{a}{x^{$α}}\\right)^{x^{$β}} = e^{$target_k}",
                "Take natural log: \\lim_{x \\to \\infty} x^{$β} \\ln\\left(1 + \\frac{a}{x^{$α}}\\right) = $target_k",
                "Use \\ln(1+u) \\sim u for small u: \\lim_{x \\to \\infty} x^{$β} \\cdot \\frac{a}{x^{$α}} = a x^{$(β-α)}",
                "Since $β ≠ $α, we have exponent $(β-α)",
                if β > α
                    "As $β > $α, the exponent is positive, limit \\to \\infty (or -\\infty if a<0)"
                else
                    "As $β < $α, the exponent is negative, limit \\to 0"
                end,
                "No finite value of a can make this equal $target_k",
                "The problem has no solution"
            )
        end
        
        problem(
            question=question_str,
            answer=ans_val,
            difficulty=(4500, 5000),
            solution=solution_steps,
            time=540
        )
        
    else  # problem_type == 6
        # Multi-variable limit requiring path analysis
        m = randint(2, 5)
        n = randint(3, 6)
        
        # Does lim (x,y)→(0,0) of x^m * y^n / (x^(2m) + y^(2n)) exist?
        
        question_str = "Determine whether \\lim_{(x,y) \\to (0,0)} \\frac{x^{$m} y^{$n}}{x^{$(2*m)} + y^{$(2*n)}} exists. If it exists, find its value; if not, prove non-existence by finding two paths with different limits."
        
        # Along y = x^k path: x^m * x^(kn) / (x^(2m) + x^(2kn))
        # For k=1: x^(m+n) / (x^(2m) + x^(2n))
        
        solution_steps = steps(
            "Given: \\lim_{(x,y) \\to (0,0)} \\frac{x^{$m} y^{$n}}{x^{$(2*m)} + y^{$(2*n)}}",
            "Test path y = x: limit along this path is 0",
            "Test path y = x^{$(m÷n)} (if applicable): limit may differ",
            "The limit does not exist due to path-dependent values"
        )

        problem(
            question=question_str,
            answer="DNE",
            difficulty=(3800, 4200),
            solution=solution_steps,
            time=540
        )
    end
end