# calculus - lhopitals_rule (very_easy)
# Generated: 2026-03-08T20:43:48.863021

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/lhopitals_rule")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Type: Recognize 0/0 indeterminate form (200-400 ELO)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        root = randint(-10, 10)
        
        numerator = expand(a * (x - root))
        denominator = expand(b * (x - root))
        
        num_at_root = substitute(numerator, x => root)
        denom_at_root = substitute(denominator, x => root)
        
        problem(
            question="Evaluate the limit by direct substitution: \\(\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}\\). What form do you get?",
            answer="0/0",
            difficulty=(200, 400),
            answer_type="text",
            solution=steps(
                sol("Given limit", "\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
                "Substitute \\(x = $(root)\\) into numerator: $(tex(num_at_root))",
                "Substitute \\(x = $(root)\\) into denominator: $(tex(denom_at_root))",
                sol("Answer", "\\frac{0}{0} \\text{ (indeterminate form)}")
            ),
            time=45,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Type: Simple polynomial 0/0, cancel factor (400-600 ELO)
        a = nonzero(-6, 6)
        root = randint(-8, 8)
        
        numerator = expand(a * (x - root))
        denominator = x - root
        
        limit_value = a
        
        problem(
            question="Evaluate \\(\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}\\)",
            answer=limit_value,
            difficulty=(400, 600),
            solution=steps(
                sol("Given limit", "\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
                "Direct substitution gives \\(\\frac{0}{0}\\), an indeterminate form",
                "Factor numerator: \\($(tex(numerator)) = $(a)(x - $(root))\\)",
                "Cancel common factor \\((x - $(root))\\): \\(\\lim_{x \\to $(root)} $(a)\\)",
                sol("Answer", limit_value)
            ),
            time=60,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Type: Quadratic over linear 0/0 (500-700 ELO)
        a = nonzero(-5, 5)
        root = randint(-10, 10)
        other_root = randint(-10, 10)
        while other_root == root
            other_root = randint(-10, 10)
        end
        
        numerator = expand(a * (x - root) * (x - other_root))
        denominator = x - root
        
        simplified = expand(a * (x - other_root))
        limit_value = substitute(simplified, x => root)
        
        problem(
            question="Evaluate \\(\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}\\)",
            answer=limit_value,
            difficulty=(500, 700),
            solution=steps(
                sol("Given limit", "\\lim_{x \\to $(root)} \\frac{$(tex(numerator))}{$(tex(denominator))}"),
                "Direct substitution gives \\(\\frac{0}{0}\\)",
                "Factor numerator: \\($(tex(numerator)) = $(a)(x - $(root))(x - $(other_root))\\)",
                "Cancel \\((x - $(root))\\): \\(\\lim_{x \\to $(root)} $(a)(x - $(other_root))\\)",
                "Substitute \\(x = $(root)\\): \\($(a)($(root) - $(other_root)) = $(limit_value)\\)",
                sol("Answer", limit_value)
            ),
            time=90,
            calculator="none"
        )
        
    else
        # Type: Identify when L'Hopital's rule applies (300-500 ELO)
        scenario = choice(1:3)
        
        if scenario == 1
            a = nonzero(-8, 8)
            b = nonzero(-8, 8)
            problem(
                question="Does L'Hôpital's rule apply to \\(\\lim_{x \\to 0} \\frac{$(a)}{$(b)}\\)?",
                answer="No",
                difficulty=(300, 500),
                answer_type="text",
                solution=steps(
                    sol("Given limit", "\\lim_{x \\to 0} \\frac{$(a)}{$(b)}"),
                    "Substitute \\(x = 0\\): \\(\\frac{$(a)}{$(b)}\\)",
                    "This is NOT an indeterminate form (not \\(\\frac{0}{0}\\) or \\(\\frac{\\infty}{\\infty}\\))",
                    sol("Answer", "No, L'Hôpital's rule does not apply")
                ),
                time=45,
                calculator="none"
            )
        elseif scenario == 2
            root = randint(-8, 8)
            a = nonzero(-6, 6)
            problem(
                question="Does L'Hôpital's rule apply to \\(\\lim_{x \\to $(root)} \\frac{$(tex(a*(x-root)))}{$(tex(x-root))}\\)?",
                answer="Yes",
                difficulty=(300, 500),
                answer_type="text",
                solution=steps(
                    sol("Given limit", "\\lim_{x \\to $(root)} \\frac{$(tex(a*(x-root)))}{$(tex(x-root))}"),
                    "Substitute \\(x = $(root)\\): \\(\\frac{0}{0}\\)",
                    "This IS an indeterminate form",
                    sol("Answer", "Yes, L'Hôpital's rule applies")
                ),
                time=45,
                calculator="none"
            )
        else
            a = nonzero(-8, 8)
            problem(
                question="Does L'Hôpital's rule apply to \\(\\lim_{x \\to 0} \\frac{x^2}{$(a)}\\)?",
                answer="No",
                difficulty=(300, 500),
                answer_type="text",
                solution=steps(
                    sol("Given limit", "\\lim_{x \\to 0} \\frac{x^2}{$(a)}"),
                    "Substitute \\(x = 0\\): \\(\\frac{0}{$(a)}\\)",
                    "This equals 0, NOT an indeterminate form",
                    sol("Answer", "No, L'Hôpital's rule does not apply")
                ),
                time=45,
                calculator="none"
            )
        end
    end
end