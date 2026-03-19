# calculus - lhopitals_rule (medium)
# Generated: 2026-03-08T20:44:15.795210

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/lhopitals_rule")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # 0/0 form with polynomials
        root = nonzero(-8, 8)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        num = expand(a * (x - root) * (x - b))
        den = expand(c * (x - root) * (x - d))
        
        num_deriv = diff(num, x)
        den_deriv = diff(den, x)
        
        ans = substitute(num_deriv, x => root) // substitute(den_deriv, x => root)
        
        problem(
            question="Evaluate \\lim_{x \\to $(root)} \\frac{$(tex(num))}{$(tex(den))}",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                "Direct substitution gives \\frac{0}{0}, indeterminate form",
                sol("Apply L'Hôpital's Rule: \\lim_{x \\to $(root)} \\frac{$(tex(num_deriv))}{$(tex(den_deriv))}"),
                "Substitute x = $(root)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # 0/0 form with trigonometric functions
        a = nonzero(-6, 6)
        b = nonzero(2, 8)
        
        # lim x->0 of (sin(ax) - bx) / x^3 type or similar
        choice_trig = choice(1:3)
        
        if choice_trig == 1
            # sin(ax)/x as x->0
            ans = a
            problem(
                question="Evaluate \\lim_{x \\to 0} \\frac{\\sin($(a)x)}{x}",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "Direct substitution gives \\frac{0}{0}, indeterminate form",
                    "Apply L'Hôpital's Rule: \\lim_{x \\to 0} \\frac{$(a)\\cos($(a)x)}{1}",
                    "Substitute x = 0",
                    sol("Answer", ans)
                ),
                time=75
            )
        elseif choice_trig == 2
            # (1 - cos(ax))/x^2 as x->0
            ans = a^2 // 2
            problem(
                question="Evaluate \\lim_{x \\to 0} \\frac{1 - \\cos($(a)x)}{x^2}",
                answer=ans,
                difficulty=(1400, 1600),
                solution=steps(
                    "Direct substitution gives \\frac{0}{0}, indeterminate form",
                    "Apply L'Hôpital's Rule: \\lim_{x \\to 0} \\frac{$(a)\\sin($(a)x)}{2x}",
                    "Still \\frac{0}{0}, apply L'Hôpital's Rule again: \\lim_{x \\to 0} \\frac{$(a^2)\\cos($(a)x)}{2}",
                    sol("Substitute x = 0, Answer", ans)
                ),
                time=120
            )
        else
            # (e^(ax) - 1)/x as x->0
            ans = a
            problem(
                question="Evaluate \\lim_{x \\to 0} \\frac{e^{$(a)x} - 1}{x}",
                answer=ans,
                difficulty=(1300, 1500),
                solution=steps(
                    "Direct substitution gives \\frac{0}{0}, indeterminate form",
                    "Apply L'Hôpital's Rule: \\lim_{x \\to 0} \\frac{$(a)e^{$(a)x}}{1}",
                    "Substitute x = 0",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    elseif problem_type == 3
        # ∞/∞ form with polynomials
        a = nonzero(-5, 5)
        b = randint(-10, 10)
        c = nonzero(-5, 5)
        d = randint(-10, 10)
        
        power_choice = choice(1:3)
        
        if power_choice == 1
            # same degree
            ans = a // c
            problem(
                question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(a*x^2 + b))}{$(tex(c*x^2 + d))}",
                answer=ans,
                difficulty=(1200, 1400),
                solution=steps(
                    "As x → ∞, both numerator and denominator → ∞",
                    "Apply L'Hôpital's Rule: \\lim_{x \\to \\infty} \\frac{$(tex(2*a*x))}{$(tex(2*c*x))}",
                    "Apply L'Hôpital's Rule again: \\lim_{x \\to \\infty} \\frac{$(2*a)}{$(2*c)}",
                    sol("Answer", ans)
                ),
                time=90
            )
        elseif power_choice == 2
            # numerator higher degree
            problem(
                question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(a*x^3 + b))}{$(tex(c*x^2 + d))}",
                answer="\\infty",
                difficulty=(1300, 1500),
                solution=steps(
                    "As x → ∞, both numerator and denominator → ∞",
                    "Apply L'Hôpital's Rule: \\lim_{x \\to \\infty} \\frac{$(tex(3*a*x^2))}{$(tex(2*c*x))}",
                    "Still ∞/∞, apply again: \\lim_{x \\to \\infty} \\frac{$(tex(6*a*x))}{$(2*c)}",
                    "This limit is ∞ (or -∞ depending on signs)"
                ),
                time=120
            )
        else
            # denominator higher degree
            problem(
                question="Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(a*x^2 + b))}{$(tex(c*x^3 + d))}",
                answer=0,
                difficulty=(1300, 1500),
                solution=steps(
                    "As x → ∞, both numerator and denominator → ∞",
                    "Apply L'Hôpital's Rule: \\lim_{x \\to \\infty} \\frac{$(tex(2*a*x))}{$(tex(3*c*x^2))}",
                    "Still ∞/∞, apply again: \\lim_{x \\to \\infty} \\frac{$(2*a)}{$(tex(6*c*x))}",
                    sol("As x → ∞, this approaches", 0)
                ),
                time=120
            )
        end
        
    elseif problem_type == 4
        # Exponential forms
        a = nonzero(-4, 4)
        b = nonzero(2, 6)
        
        # ln(x)/x as x->∞
        problem(
            question="Evaluate \\lim_{x \\to \\infty} \\frac{\\ln(x)}{x^{$(b)}}",
            answer=0,
            difficulty=(1400, 1600),
            solution=steps(
                "As x → ∞, both numerator and denominator → ∞",
                "Apply L'Hôpital's Rule: \\lim_{x \\to \\infty} \\frac{1/x}{$(b)x^{$(b-1)}}",
                "Simplify: \\lim_{x \\to \\infty} \\frac{1}{$(b)x^{$(b)}}",
                sol("As x → ∞, this approaches", 0)
            ),
            time=120
        )
        
    else
        # More complex 0/0 with factoring required first
        root = nonzero(-6, 6)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        num = expand(a * (x - root)^2)
        den = expand(c * (x - root))
        
        ans = substitute(2*a*(x - root), x => root) // c
        
        problem(
            question="Evaluate \\lim_{x \\to $(root)} \\frac{$(tex(num))}{$(tex(den))}",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Direct substitution gives \\frac{0}{0}, indeterminate form",
                sol("Numerator derivative", tex(diff(num, x))),
                sol("Denominator derivative", tex(diff(den, x))),
                "Apply L'Hôpital's Rule and substitute x = $(root)",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end