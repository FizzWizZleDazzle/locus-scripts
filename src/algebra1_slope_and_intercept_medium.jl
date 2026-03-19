# algebra1 - slope_and_intercept (medium)
# Generated: 2026-03-08T19:55:55.512090

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/slope_and_intercept")
    
    problem_type = choice([
        :find_slope_from_points,
        :find_intercept_from_point_slope,
        :write_equation_point_slope,
        :write_equation_two_points,
        :find_slope_from_equation,
        :parallel_line,
        :perpendicular_line,
        :x_intercept,
        :y_intercept_from_equation,
        :point_on_line
    ])
    
    if problem_type == :find_slope_from_points
        x1, y1 = randint(-15, 15), randint(-15, 15)
        x2, y2 = randint(-15, 15), randint(-15, 15)
        while x1 == x2
            x2 = randint(-15, 15)
        end
        m = (y2 - y1) // (x2 - x1)
        
        problem(
            question="Find the slope of the line passing through the points \$($(x1), $(y1))\$ and \$($(x2), $(y2))\$.",
            answer=m,
            difficulty=(1200, 1400),
            solution=steps(
                "Use the slope formula: \$m = \\frac{y_2 - y_1}{x_2 - x_1}\$",
                sol("Substitute", "m = \\frac{$(y2) - ($(y1))}{$(x2) - ($(x1))} = \\frac{$(y2-y1)}{$(x2-x1)}"),
                sol("Answer", m)
            ),
            time=90
        )
        
    elseif problem_type == :find_intercept_from_point_slope
        x1, y1 = randint(-12, 12), randint(-12, 12)
        m = nonzero(-8, 8) // choice([1, 2, 3, 4])
        b = y1 - m * x1
        
        problem(
            question="A line has slope \$$(tex(m))\$ and passes through the point \$($(x1), $(y1))\$. Find the y-intercept.",
            answer=b,
            difficulty=(1300, 1500),
            solution=steps(
                "Use point-slope form: \$y - y_1 = m(x - x_1)\$",
                sol("Substitute", "y - $(y1) = $(tex(m))(x - $(x1))"),
                "Convert to slope-intercept form \$y = mx + b\$",
                sol("Expand", "y = $(tex(m*x + b))"),
                sol("y-intercept", b)
            ),
            time=120
        )
        
    elseif problem_type == :write_equation_point_slope
        x1, y1 = randint(-10, 10), randint(-10, 10)
        m = nonzero(-6, 6) // choice([1, 2, 3])
        b = y1 - m * x1
        ans_expr = m * x + b
        
        problem(
            question="Write the equation of the line with slope \$$(tex(m))\$ passing through \$($(x1), $(y1))\$ in slope-intercept form.",
            answer=ans_expr,
            difficulty=(1400, 1600),
            solution=steps(
                "Start with point-slope form: \$y - y_1 = m(x - x_1)\$",
                sol("Substitute", "y - $(y1) = $(tex(m))(x - $(x1))"),
                "Distribute and solve for y",
                sol("Simplify", "y = $(tex(ans_expr))"),
                sol("Answer", ans_expr)
            ),
            time=120
        )
        
    elseif problem_type == :write_equation_two_points
        x1, y1 = randint(-12, 12), randint(-12, 12)
        x2, y2 = randint(-12, 12), randint(-12, 12)
        while x1 == x2
            x2 = randint(-12, 12)
        end
        m = (y2 - y1) // (x2 - x1)
        b = y1 - m * x1
        ans_expr = m * x + b
        
        problem(
            question="Find the equation of the line passing through \$($(x1), $(y1))\$ and \$($(x2), $(y2))\$ in slope-intercept form.",
            answer=ans_expr,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Find slope", "m = \\frac{$(y2) - $(y1)}{$(x2) - $(x1)} = $(tex(m))"),
                "Use point-slope form with \$($(x1), $(y1))\$",
                sol("Substitute", "y - $(y1) = $(tex(m))(x - $(x1))"),
                "Convert to slope-intercept form",
                sol("Answer", "y = $(tex(ans_expr))")
            ),
            time=150
        )
        
    elseif problem_type == :find_slope_from_equation
        m = nonzero(-8, 8) // choice([1, 2, 3, 4])
        b = randint(-15, 15)
        a = nonzero(-5, 5)
        c = randint(-12, 12)
        lhs = a * y
        rhs = expand(a * m * x + a * b + c)
        
        problem(
            question="Find the slope of the line given by the equation \$$(tex(lhs)) = $(tex(rhs))\$.",
            answer=m,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Solve for y to get slope-intercept form",
                sol("Divide by $(a)", "y = $(tex(m*x + b + c//a))"),
                sol("Slope", m)
            ),
            time=90
        )
        
    elseif problem_type == :parallel_line
        m = nonzero(-7, 7) // choice([1, 2, 3])
        b1 = randint(-10, 10)
        x1, y1 = randint(-8, 8), randint(-8, 8)
        b2 = y1 - m * x1
        ans_expr = m * x + b2
        
        problem(
            question="Find the equation of the line parallel to \$y = $(tex(m*x + b1))\$ and passing through \$($(x1), $(y1))\$.",
            answer=ans_expr,
            difficulty=(1500, 1700),
            solution=steps(
                "Parallel lines have the same slope",
                sol("Slope", m),
                "Use point-slope form with \$($(x1), $(y1))\$",
                sol("Substitute", "y - $(y1) = $(tex(m))(x - $(x1))"),
                sol("Answer", "y = $(tex(ans_expr))")
            ),
            time=120
        )
        
    elseif problem_type == :perpendicular_line
        m1 = nonzero(-6, 6) // choice([1, 2, 3])
        b1 = randint(-10, 10)
        x1, y1 = randint(-8, 8), randint(-8, 8)
        m2 = -1 // m1
        b2 = y1 - m2 * x1
        ans_expr = m2 * x + b2
        
        problem(
            question="Find the equation of the line perpendicular to \$y = $(tex(m1*x + b1))\$ and passing through \$($(x1), $(y1))\$.",
            answer=ans_expr,
            difficulty=(1600, 1800),
            solution=steps(
                "Perpendicular lines have slopes that are negative reciprocals",
                sol("Original slope", m1),
                sol("Perpendicular slope", m2),
                "Use point-slope form with \$($(x1), $(y1))\$",
                sol("Answer", "y = $(tex(ans_expr))")
            ),
            time=150
        )
        
    elseif problem_type == :x_intercept
        m = nonzero(-7, 7) // choice([1, 2, 3, 4])
        b = nonzero(-15, 15)
        x_int = -b // m
        
        problem(
            question="Find the x-intercept of the line \$y = $(tex(m*x + b))\$.",
            answer=x_int,
            difficulty=(1200, 1400),
            solution=steps(
                "The x-intercept occurs when \$y = 0\$",
                sol("Set y = 0", "0 = $(tex(m*x + b))"),
                "Solve for x",
                sol("x-intercept", x_int)
            ),
            time=90
        )
        
    elseif problem_type == :y_intercept_from_equation
        m = nonzero(-8, 8) // choice([1, 2, 3])
        b = randint(-18, 18)
        a = nonzero(-4, 4)
        c = randint(-10, 10)
        lhs = a * y - c
        rhs = a * m * x + a * b
        
        problem(
            question="Find the y-intercept of the line \$$(tex(lhs)) = $(tex(rhs))\$.",
            answer=b + c//a,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Convert to slope-intercept form",
                sol("Solve for y", "y = $(tex(m*x + b + c//a))"),
                sol("y-intercept", b + c//a)
            ),
            time=120
        )
        
    else  # :point_on_line
        m = nonzero(-6, 6) // choice([1, 2, 3, 4])
        b = randint(-12, 12)
        x_val = randint(-10, 10)
        y_val = m * x_val + b
        
        problem(
            question="Find the y-coordinate of the point on the line \$y = $(tex(m*x + b))\$ where \$x = $(x_val)\$.",
            answer=y_val,
            difficulty=(1100, 1300),
            solution=steps(
                sol("Given", "y = $(tex(m*x + b))"),
                sol("Substitute x = $(x_val)", "y = $(tex(m))($(x_val)) + $(b)"),
                sol("Answer", y_val)
            ),
            time=60
        )
    end
end