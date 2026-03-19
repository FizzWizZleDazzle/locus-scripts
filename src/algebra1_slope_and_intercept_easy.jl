# algebra1 - slope_and_intercept (easy)
# Generated: 2026-03-08T19:55:47.512981

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/slope_and_intercept")
    
    problem_type = choice([
        :find_slope_from_points,
        :find_intercept_from_equation,
        :write_equation_from_slope_intercept,
        :find_slope_from_equation,
        :find_y_intercept_from_points,
        :slope_intercept_to_standard,
        :identify_slope_and_intercept
    ])
    
    if problem_type == :find_slope_from_points
        x1, y1 = randint(-15, 15), randint(-15, 15)
        x2, y2 = randint(-15, 15), randint(-15, 15)
        while x1 == x2
            x2 = randint(-15, 15)
        end
        
        slope = (y2 - y1) // (x2 - x1)
        
        problem(
            question="Find the slope of the line passing through the points ($(x1), $(y1)) and ($(x2), $(y2)).",
            answer=slope,
            difficulty=(700, 900),
            solution=steps(
                "Use the slope formula: \$m = \\frac{y_2 - y_1}{x_2 - x_1}\$",
                sol("Substitute", "m = \\frac{$(y2) - ($(y1))}{$(x2) - ($(x1))} = \\frac{$(y2 - y1)}{$(x2 - x1)}"),
                sol("Answer", slope)
            ),
            time=60
        )
        
    elseif problem_type == :find_intercept_from_equation
        m = nonzero(-8, 8)
        b = randint(-20, 20)
        
        problem(
            question="What is the y-intercept of the line \$y = $(m)x $(b >= 0 ? "+" : "") $(b)\$?",
            answer=b,
            difficulty=(700, 850),
            solution=steps(
                "The equation is in slope-intercept form: \$y = mx + b\$",
                "The y-intercept is the constant term \$b\$",
                sol("Answer", b)
            ),
            time=45
        )
        
    elseif problem_type == :write_equation_from_slope_intercept
        m = nonzero(-10, 10)
        b = randint(-20, 20)
        
        ans_expr = m*x + b
        
        problem(
            question="Write the equation of a line with slope $(m) and y-intercept $(b) in slope-intercept form.",
            answer=ans_expr,
            difficulty=(800, 950),
            solution=steps(
                "Use slope-intercept form: \$y = mx + b\$",
                "Substitute \$m = $(m)\$ and \$b = $(b)\$",
                sol("Answer", "y = " * tex(ans_expr))
            ),
            time=60
        )
        
    elseif problem_type == :find_slope_from_equation
        a = nonzero(-12, 12)
        b = randint(-25, 25)
        
        # Create equation ax + b
        expr = a*x + b
        slope = a
        
        problem(
            question="Find the slope of the line \$y = $(tex(expr))\$.",
            answer=slope,
            difficulty=(750, 900),
            solution=steps(
                "The equation is in slope-intercept form: \$y = mx + b\$",
                "The coefficient of \$x\$ is the slope",
                sol("Answer", slope)
            ),
            time=50
        )
        
    elseif problem_type == :find_y_intercept_from_points
        m = nonzero(-8, 8)
        x1 = nonzero(-12, 12)
        y1 = randint(-20, 20)
        
        # Calculate b from point-slope: y1 = m*x1 + b
        b = y1 - m*x1
        
        problem(
            question="A line has slope $(m) and passes through the point ($(x1), $(y1)). Find the y-intercept.",
            answer=b,
            difficulty=(900, 1100),
            solution=steps(
                "Use point-slope form: \$y - y_1 = m(x - x_1)\$",
                sol("Substitute", "y - $(y1) = $(m)(x - $(x1))"),
                "Convert to slope-intercept form and solve for the y-intercept",
                sol("Expand", "y = $(m)x $(b >= 0 ? "+" : "") $(b)"),
                sol("Answer", b)
            ),
            time=90
        )
        
    elseif problem_type == :slope_intercept_to_standard
        m = nonzero(-8, 8)
        b = randint(-15, 15)
        
        # y = mx + b becomes -mx + y = b or mx - y = -b
        # Standard form: Ax + By = C with A positive
        A = -m
        B = 1
        C = b
        
        if A < 0
            A, B, C = -A, -B, -C
        end
        
        ans_str = "$(A)x $(B >= 0 ? "+" : "")$(B)y = $(C)"
        
        problem(
            question="Convert the equation \$y = $(m)x $(b >= 0 ? "+" : "") $(b)\$ to standard form \$Ax + By = C\$ where \$A\$ is positive.",
            answer=ans_str,
            difficulty=(1000, 1200),
            answer_type="expression",
            solution=steps(
                sol("Given", "y = $(m)x $(b >= 0 ? "+" : "") $(b)"),
                "Move all terms to one side: \$$(−m)x + y = $(b)\$",
                A < 0 ? "Multiply by -1 to make A positive" : "A is already positive",
                sol("Answer", ans_str)
            ),
            time=90
        )
        
    else  # :identify_slope_and_intercept
        m = nonzero(-10, 10)
        b = randint(-20, 20)
        
        ans_str = fmt_tuple((m, b))
        
        problem(
            question="Identify the slope and y-intercept of the line \$y = $(m)x $(b >= 0 ? "+" : "") $(b)\$. Give your answer as an ordered pair (slope, y-intercept).",
            answer=ans_str,
            difficulty=(750, 950),
            answer_type="tuple",
            solution=steps(
                "The equation is in slope-intercept form: \$y = mx + b\$",
                "The slope is the coefficient of \$x\$: \$m = $(m)\$",
                "The y-intercept is the constant term: \$b = $(b)\$",
                sol("Answer", ans_str)
            ),
            time=60
        )
    end
end