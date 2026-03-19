# algebra1 - systems_substitution (easy)
# Generated: 2026-03-08T19:57:06.893547

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/systems_substitution")
    
    # Pick clean integer solutions
    x_val = randint(-12, 12)
    y_val = randint(-12, 12)
    
    # Create first equation: express y in terms of x
    # y = mx + b where substituting x_val gives y_val
    m = nonzero(-8, 8)
    b = y_val - m * x_val
    eq1_lhs = y
    eq1_rhs = m * x + b
    
    # Create second equation: ax + by = c
    a = nonzero(-10, 10)
    b_coef = nonzero(-10, 10)
    c = a * x_val + b_coef * y_val
    eq2_lhs = a * x + b_coef * y
    
    # Determine difficulty based on coefficient complexity
    coef_sum = abs(a) + abs(b_coef) + abs(m) + abs(b)
    if coef_sum < 15 && abs(x_val) < 8 && abs(y_val) < 8
        diff_range = (700, 900)
        time_alloc = 90
    elseif coef_sum < 25 && abs(x_val) < 12 && abs(y_val) < 12
        diff_range = (900, 1100)
        time_alloc = 120
    else
        diff_range = (1100, 1200)
        time_alloc = 150
    end
    
    # Substitute eq1 into eq2
    substituted = substitute(eq2_lhs, y => eq1_rhs)
    simplified = expand(substituted)
    
    problem(
        question = "Solve the system using substitution:\n\$\$\\begin{cases}\n$(tex(eq1_lhs)) = $(tex(eq1_rhs)) \\\\\n$(tex(eq2_lhs)) = $(c)\n\\end{cases}\$\$",
        answer = fmt_tuple((x_val, y_val)),
        difficulty = diff_range,
        answer_type = "tuple",
        solution = steps(
            "Given system of equations",
            sol("Equation 1", eq1_lhs ~ eq1_rhs),
            sol("Equation 2", eq2_lhs ~ c),
            "Substitute equation 1 into equation 2:",
            sol(simplified ~ c),
            "Solve for x:",
            sol("x", x_val),
            "Substitute back into equation 1:",
            sol("y", y_val),
            "Solution: \$$(fmt_tuple((x_val, y_val)))\$"
        ),
        time = time_alloc,
    )
end