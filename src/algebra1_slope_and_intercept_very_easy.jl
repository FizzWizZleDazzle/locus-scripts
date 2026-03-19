# algebra1 - slope_and_intercept (very_easy)
# Generated: 2026-03-08T19:55:30.393969

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/slope_and_intercept")
    
    problem_type = choice([
        :identify_slope_intercept,
        :find_slope_two_points,
        :find_y_intercept,
        :write_equation_slope_intercept,
        :identify_from_graph,
        :find_slope_from_equation
    ])
    
    if problem_type == :identify_slope_intercept
        # Given y = mx + b, identify m and b
        m = randint(-8, 8)
        b = randint(-12, 12)
        
        question = "What is the slope of the line \$y = $(m)x $(b >= 0 ? "+" : "")$(b)\$?"
        answer = m
        difficulty = (150, 300)
        solution = steps(
            sol("Given equation", y ~ m*x + b),
            "In slope-intercept form \$y = mx + b\$, the coefficient of \$x\$ is the slope",
            sol("Slope", m)
        )
        time = 30
        
    elseif problem_type == :find_slope_two_points
        # Find slope given two points
        x1 = randint(-10, 10)
        y1 = randint(-10, 10)
        x2 = x1 + nonzero(-8, 8)
        y2 = y1 + nonzero(-8, 8)
        
        slope = (y2 - y1) // (x2 - x1)
        
        question = "Find the slope of the line passing through the points \$($(x1), $(y1))\$ and \$($(x2), $(y2))\$."
        answer = slope
        difficulty = (400, 600)
        solution = steps(
            "Use the slope formula: \$m = \\frac{y_2 - y_1}{x_2 - x_1}\$",
            sol("Substitute", "m = \\frac{$(y2) - ($(y1))}{$(x2) - ($(x1))} = \\frac{$(y2 - y1)}{$(x2 - x1)}"),
            sol("Slope", slope)
        )
        time = 60
        
    elseif problem_type == :find_y_intercept
        # Find y-intercept from equation
        m = nonzero(-8, 8)
        b = randint(-15, 15)
        
        question = "What is the y-intercept of the line \$y = $(m)x $(b >= 0 ? "+" : "")$(b)\$?"
        answer = b
        difficulty = (150, 300)
        solution = steps(
            sol("Given equation", y ~ m*x + b),
            "In slope-intercept form \$y = mx + b\$, the constant term is the y-intercept",
            sol("Y-intercept", b)
        )
        time = 30
        
    elseif problem_type == :write_equation_slope_intercept
        # Write equation given slope and y-intercept
        m = nonzero(-7, 7)
        b = randint(-12, 12)
        
        question = "Write the equation of a line with slope \$m = $(m)\$ and y-intercept \$b = $(b)\$ in slope-intercept form."
        answer = m*x + b
        difficulty = (300, 500)
        solution = steps(
            "Use slope-intercept form: \$y = mx + b\$",
            "Substitute \$m = $(m)\$ and \$b = $(b)\$",
            sol("Equation", y ~ m*x + b)
        )
        time = 45
        
    elseif problem_type == :identify_from_graph
        # Given a point and slope, find y-intercept
        m = nonzero(-6, 6)
        x_point = randint(-8, 8)
        y_point = randint(-10, 10)
        
        # Calculate b from point: y = mx + b => b = y - mx
        b = y_point - m * x_point
        
        question = "A line has slope \$m = $(m)\$ and passes through the point \$($(x_point), $(y_point))\$. What is the y-intercept?"
        answer = b
        difficulty = (500, 700)
        solution = steps(
            "Use point-slope relationship: \$y = mx + b\$",
            sol("Substitute point", "$(y_point) = $(m)($(x_point)) + b"),
            "Solve for \$b\$: \$b = $(y_point) - $(m * x_point) = $(b)\$",
            sol("Y-intercept", b)
        )
        time = 75
        
    else  # find_slope_from_equation
        # Given equation in standard form, find slope
        a = nonzero(-8, 8)
        b_coef = nonzero(-8, 8)
        c = randint(-15, 15)
        
        # ax + by = c => y = -a/b * x + c/b
        slope = -a // b_coef
        
        question = "Find the slope of the line \$$(a)x $(b_coef >= 0 ? "+" : "")$(b_coef)y = $(c)\$."
        answer = slope
        difficulty = (500, 700)
        solution = steps(
            sol("Given equation", "$(a)x $(b_coef >= 0 ? "+" : "")$(b_coef)y = $(c)"),
            "Solve for \$y\$ to get slope-intercept form: \$$(b_coef)y = $(- a)x + $(c)\$",
            "Divide by \$$(b_coef)\$: \$y = $(slope)x + $(c // b_coef)\$",
            sol("Slope", slope)
        )
        time = 90
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution,
        time=time
    )
end