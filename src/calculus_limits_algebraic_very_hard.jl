# calculus - limits_algebraic (very_hard)
# Generated: 2026-03-08T20:37:03.675111

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x h begin
    set_topic!("calculus/limits_algebraic")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Indeterminate form requiring factoring and cancellation (2500-2800)
        # Create 0/0 form with hidden cancellation
        root = randint(-8, 8)
        p = randint(2, 4)  # multiplicity
        
        # Numerator has (x-root)^p as a factor
        other_roots_num = [nonzero(-10, 10) for _ in 1:(rand(1:2))]
        num_extra = prod([(x - r) for r in other_roots_num])
        numerator = expand((x - root)^p * num_extra)
        
        # Denominator has (x-root)^q as a factor, q < p
        q = rand(1:(p-1))
        other_roots_den = [nonzero(-10, 10) for _ in 1:(rand(1:2))]
        den_extra = prod([(x - r) for r in other_roots_den])
        denominator = expand((x - root)^q * den_extra)
        
        # After cancellation
        simplified_num = expand((x - root)^(p-q) * num_extra)
        simplified_den = expand(den_extra)
        
        limit_val = substitute(simplified_num, x => root) // substitute(simplified_den, x => root)
        
        question_text = "Evaluate \\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}"
        
        solution_text = steps(
            sol("Given", "\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
            "Direct substitution gives 0/0 form (indeterminate)",
            "Factor numerator and denominator, cancel common factor (x - $(root))^$(q)",
            sol("Simplified", "\\lim_{x \\to $(root)} \\frac{$(tex(simplified_num))}{$(tex(simplified_den))}"),
            "Substitute x = $(root)",
            sol("Answer", limit_val)
        )
        
        problem(
            question=question_text,
            answer=limit_val,
            difficulty=(2500, 2800),
            solution=solution_text,
            time=240
        )
        
    elseif problem_type == 2
        # Rationalization with nested radicals (2700-3100)
        a = nonzero(-12, 12)
        b = nonzero(-12, 12)
        c = randint(2, 8)
        d = randint(2, 8)
        
        # lim_{x→a} (sqrt(cx + d) - sqrt(ca + d)) / (x - a)
        # This is the derivative of sqrt(cx + d) at x = a
        limit_val = c // (2 * sqrt(c*a + d))
        
        numerator_text = "\\sqrt{$(c)x + $(d)} - \\sqrt{$(c*a + d)}"
        denominator_text = "x - $(a)"
        
        question_text = "Evaluate \\lim_{x \\to $(a)} \\frac{$(numerator_text)}{$(denominator_text)}"
        
        conjugate_text = "\\sqrt{$(c)x + $(d)} + \\sqrt{$(c*a + d)}"
        
        solution_text = steps(
            sol("Given", "\\lim_{x \\to $(a)} \\frac{$(numerator_text)}{$(denominator_text)}"),
            "Direct substitution gives 0/0 form",
            "Multiply by conjugate: \\frac{$(conjugate_text)}{$(conjugate_text)}",
            "Numerator becomes: ($(c)x + $(d)) - $(c*a + d) = $(c)(x - $(a))",
            sol("Simplified", "\\lim_{x \\to $(a)} \\frac{$(c)}{$(conjugate_text)}"),
            "Substitute x = $(a)",
            sol("Answer", limit_val)
        )
        
        problem(
            question=question_text,
            answer=limit_val,
            difficulty=(2700, 3100),
            solution=solution_text,
            time=300
        )
        
    elseif problem_type == 3
        # Piecewise limit requiring one-sided analysis (2600-3000)
        a = randint(-10, 10)
        m1 = nonzero(-8, 8)
        b1 = randint(-15, 15)
        
        m2 = nonzero(-8, 8)
        b2 = randint(-15, 15)
        
        # For limit to exist at x=a, need m1*a + b1 = m2*a + b2
        # Adjust b2 to make them equal
        b2 = m1*a + b1 - m2*a
        
        left_val = m1*a + b1
        right_val = m2*a + b2
        
        f1 = expand(m1*x + b1)
        f2 = expand(m2*x + b2)
        
        question_text = "Let f(x) = \\begin{cases} $(tex(f1)) & x < $(a) \\\\ $(tex(f2)) & x \\geq $(a) \\end{cases}. Evaluate \\lim_{x \\to $(a)} f(x) if it exists, or write DNE."
        
        if left_val == right_val
            answer_val = left_val
            solution_text = steps(
                "Evaluate left-hand limit: \\lim_{x \\to $(a)^-} f(x) = $(left_val)",
                "Evaluate right-hand limit: \\lim_{x \\to $(a)^+} f(x) = $(right_val)",
                "Since both one-sided limits agree",
                sol("Answer", answer_val)
            )
        else
            answer_val = "DNE"
            solution_text = steps(
                "Evaluate left-hand limit: \\lim_{x \\to $(a)^-} f(x) = $(left_val)",
                "Evaluate right-hand limit: \\lim_{x \\to $(a)^+} f(x) = $(right_val)",
                "Since one-sided limits differ, limit does not exist",
                sol("Answer", "DNE")
            )
        end
        
        problem(
            question=question_text,
            answer=answer_val,
            difficulty=(2600, 3000),
            solution=solution_text,
            answer_type="text",
            time=270
        )
        
    elseif problem_type == 4
        # Complex rational limit at infinity (2800-3200)
        # Form: (a*x^n + ...) / (b*x^n + ...) where n >= 3
        n = rand(3:5)
        a_lead = nonzero(-7, 7)
        b_lead = nonzero(-7, 7)
        
        num_coeffs = [randint(-12, 12) for _ in 1:n]
        num_coeffs[end] = a_lead
        den_coeffs = [randint(-12, 12) for _ in 1:n]
        den_coeffs[end] = b_lead
        
        numerator = sum([num_coeffs[i] * x^(i-1) for i in 1:n])
        denominator = sum([den_coeffs[i] * x^(i-1) for i in 1:n])
        
        limit_val = a_lead // b_lead
        
        question_text = "Evaluate \\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}"
        
        solution_text = steps(
            sol("Given", "\\lim_{x \\to \\infty} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
            "Divide numerator and denominator by x^$(n) (highest power)",
            "Lower degree terms vanish as x → ∞",
            sol("Simplified", "\\lim_{x \\to \\infty} \\frac{$(a_lead)}{$(b_lead)}"),
            sol("Answer", limit_val)
        )
        
        problem(
            question=question_text,
            answer=limit_val,
            difficulty=(2800, 3200),
            solution=solution_text,
            time=240
        )
        
    else
        # Sophisticated squeeze theorem application (3100-3500)
        a = randint(2, 6)
        
        # lim_{x→0} x^a * sin(1/x) or similar oscillating bounded function
        
        question_text = "Use the Squeeze Theorem to evaluate \\lim_{x \\to 0} x^{$(a)} \\sin\\left(\\frac{1}{x}\\right)"
        
        solution_text = steps(
            sol("Given", "\\lim_{x \\to 0} x^{$(a)} \\sin\\left(\\frac{1}{x}\\right)"),
            "Note that -1 \\leq \\sin\\left(\\frac{1}{x}\\right) \\leq 1 for all x \\neq 0",
            "Multiply by |x^{$(a)}|: -|x^{$(a)}| \\leq x^{$(a)} \\sin\\left(\\frac{1}{x}\\right) \\leq |x^{$(a)}|",
            "Since \\lim_{x \\to 0} |x^{$(a)}| = 0 and \\lim_{x \\to 0} -|x^{$(a)}| = 0",
            "By Squeeze Theorem",
            sol("Answer", 0)
        )
        
        problem(
            question=question_text,
            answer=0,
            difficulty=(3100, 3500),
            solution=solution_text,
            time=300
        )
    end
end