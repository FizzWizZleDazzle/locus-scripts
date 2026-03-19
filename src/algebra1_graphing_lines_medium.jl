# algebra1 - graphing_lines (medium)
# Generated: 2026-03-08T19:56:48.374926

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/graphing_lines")
    
    problem_type = choice([
        :slope_intercept_to_standard,
        :standard_to_slope_intercept,
        :point_slope_form,
        :find_equation_two_points,
        :find_slope_from_equation,
        :find_intercepts,
        :parallel_line,
        :perpendicular_line,
        :graph_interpretation
    ])
    
    if problem_type == :slope_intercept_to_standard
        m = randint(-8, 8)
        b = randint(-15, 15)
        slope_int = m*x + b
        A = -m
        B = 1
        C = b
        
        problem(
            question="Convert to standard form (Ax + By = C): \$y = $(tex(slope_int))\$",
            answer=fmt_equation(A*x + B*y, C),
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", y ~ slope_int),
                "Move x-term to left side",
                sol("Standard form", A*x + B*y ~ C)
            ),
            time=90
        )
        
    elseif problem_type == :standard_to_slope_intercept
        A = nonzero(-10, 10)
        B = nonzero(-10, 10)
        C = randint(-20, 20)
        m = -A // B
        b = C // B
        
        problem(
            question="Convert to slope-intercept form: \$$(A)x + $(B)y = $(C)\$",
            answer=expand(m*x + b),
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", A*x + B*y ~ C),
                "Solve for y: \$$(B)y = $(tex(-A*x + C))\$",
                sol("Divide by $(B)", y ~ m*x + b)
            ),
            time=90
        )
        
    elseif problem_type == :point_slope_form
        x1 = randint(-10, 10)
        y1 = randint(-10, 10)
        m = nonzero(-8, 8)
        b = y1 - m*x1
        ans = expand(m*x + b)
        
        problem(
            question="Write the equation of the line passing through \$($(x1), $(y1))\$ with slope \$m = $(m)\$ in slope-intercept form.",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                "Use point-slope form: \$y - y_1 = m(x - x_1)\$",
                sol("Substitute", y - y1 ~ m*(x - x1)),
                sol("Simplify to slope-intercept", y ~ ans)
            ),
            time=120
        )
        
    elseif problem_type == :find_equation_two_points
        x1 = randint(-12, 12)
        y1 = randint(-12, 12)
        x2 = randint(-12, 12)
        while x2 == x1
            x2 = randint(-12, 12)
        end
        y2 = randint(-12, 12)
        while y2 == y1
            y2 = randint(-12, 12)
        end
        
        m = (y2 - y1) // (x2 - x1)
        b = y1 - m*x1
        ans = expand(m*x + b)
        
        problem(
            question="Find the equation of the line passing through \$($(x1), $(y1))\$ and \$($(x2), $(y2))\$ in slope-intercept form.",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Slope", "m = \\frac{$(y2) - $(y1)}{$(x2) - $(x1)} = $(tex(m))"),
                "Use point-slope form with \$($(x1), $(y1))\$",
                sol("Answer", y ~ ans)
            ),
            time=150
        )
        
    elseif problem_type == :find_slope_from_equation
        A = nonzero(-12, 12)
        B = nonzero(-12, 12)
        C = randint(-25, 25)
        m = -A // B
        
        problem(
            question="What is the slope of the line \$$(A)x + $(B)y = $(C)\$?",
            answer=m,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", A*x + B*y ~ C),
                "Solve for y: \$y = $(tex(-A//B * x + C//B))\$",
                sol("Slope", m)
            ),
            time=90
        )
        
    elseif problem_type == :find_intercepts
        A = nonzero(-10, 10)
        B = nonzero(-10, 10)
        C = nonzero(-20, 20)
        x_int = C // A
        y_int = C // B
        
        if choice([true, false])
            problem(
                question="Find the x-intercept of \$$(A)x + $(B)y = $(C)\$",
                answer=x_int,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", A*x + B*y ~ C),
                    "Set y = 0: \$$(A)x = $(C)\$",
                    sol("x-intercept", x_int)
                ),
                time=90
            )
        else
            problem(
                question="Find the y-intercept of \$$(A)x + $(B)y = $(C)\$",
                answer=y_int,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", A*x + B*y ~ C),
                    "Set x = 0: \$$(B)y = $(C)\$",
                    sol("y-intercept", y_int)
                ),
                time=90
            )
        end
        
    elseif problem_type == :parallel_line
        m = nonzero(-8, 8)
        b_orig = randint(-15, 15)
        x1 = randint(-10, 10)
        y1 = randint(-10, 10)
        b_new = y1 - m*x1
        ans = expand(m*x + b_new)
        
        problem(
            question="Find the equation of the line parallel to \$y = $(tex(m*x + b_orig))\$ that passes through \$($(x1), $(y1))\$",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "Parallel lines have the same slope: \$m = $(m)\$",
                sol("Use point-slope", y - y1 ~ m*(x - x1)),
                sol("Simplify", y ~ ans)
            ),
            time=120
        )
        
    elseif problem_type == :perpendicular_line
        m = nonzero(-8, 8)
        b_orig = randint(-15, 15)
        x1 = randint(-10, 10)
        y1 = randint(-10, 10)
        m_perp = -1 // m
        b_new = y1 - m_perp*x1
        ans = expand(m_perp*x + b_new)
        
        problem(
            question="Find the equation of the line perpendicular to \$y = $(tex(m*x + b_orig))\$ that passes through \$($(x1), $(y1))\$",
            answer=ans,
            difficulty=(1600, 1800),
            solution=steps(
                sol("Original slope", m),
                sol("Perpendicular slope", "m_{\\perp} = $(tex(m_perp))"),
                sol("Use point-slope and simplify", y ~ ans)
            ),
            time=150
        )
        
    else  # graph_interpretation
        m = nonzero(-6, 6)
        b = randint(-12, 12)
        x_val = randint(-8, 8)
        y_val = m*x_val + b
        
        if choice([true, false])
            problem(
                question="For the line \$y = $(tex(m*x + b))\$, what is the y-value when \$x = $(x_val)\$?",
                answer=y_val,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", y ~ m*x + b),
                    sol("Substitute x = $(x_val)", y ~ m*x_val + b),
                    sol("Answer", y_val)
                ),
                time=90
            )
        else
            y_given = randint(-15, 15)
            x_ans = (y_given - b) // m
            problem(
                question="For the line \$y = $(tex(m*x + b))\$, what is the x-value when \$y = $(y_given)\$?",
                answer=x_ans,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", y ~ m*x + b),
                    sol("Substitute y = $(y_given)", y_given ~ m*x + b),
                    sol("Solve for x", x_ans)
                ),
                time=100
            )
        end
    end
end