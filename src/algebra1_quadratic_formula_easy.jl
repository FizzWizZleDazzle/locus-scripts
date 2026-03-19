# algebra1 - quadratic_formula (easy)
# Generated: 2026-03-08T20:00:49.495174

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("algebra1/quadratic_formula")
    
    # Pick random roots and construct quadratic backward
    r1 = randint(-12, 12)
    r2 = randint(-12, 12)
    a = nonzero(-3, 3)
    
    # Expand to get standard form
    expr = expand(a * (x - r1) * (x - r2))
    
    # Extract coefficients for solution display
    # expr = a*x^2 - a*(r1+r2)*x + a*r1*r2
    coeff_a = a
    coeff_b = -a * (r1 + r2)
    coeff_c = a * r1 * r2
    
    # Discriminant for solution verification
    discriminant = coeff_b^2 - 4*coeff_a*coeff_c
    
    # Sort roots for consistent answer format
    roots = sort([r1, r2])
    
    problem(
        question = "Solve using the quadratic formula: \$$(tex(expr)) = 0\$",
        answer = fmt_set(Set([r1, r2])),
        difficulty = (700, 1200),
        answer_type = "set",
        solution = steps(
            sol("Given", expr ~ 0),
            "Standard form: \$$(coeff_a)x^2 + $(coeff_b)x + $(coeff_c) = 0\$",
            "Apply quadratic formula: \$x = \\frac{-b \\pm \\sqrt{b^2-4ac}}{2a}\$",
            "Here \$a=$(coeff_a)\$, \$b=$(coeff_b)\$, \$c=$(coeff_c)\$",
            "Discriminant: \$\\Delta = $(coeff_b)^2 - 4($(coeff_a))($(coeff_c)) = $(discriminant)\$",
            sol("x = \\frac{-$(coeff_b) \\pm \\sqrt{$(discriminant)}}{$(2*coeff_a)}"),
            "Solutions: \$x = $(roots[1])\$ and \$x = $(roots[2])\$",
            sol("Answer", fmt_set(Set([r1, r2])))
        ),
        time = 120,
        calculator = "scientific"
    )
end