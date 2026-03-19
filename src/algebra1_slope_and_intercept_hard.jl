# algebra1 - slope_and_intercept (hard)
# Generated: 2026-03-08T19:55:59.639092

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/slope_and_intercept")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Find slope given two points with large coordinates
        x1 = randint(-25, 25)
        y1 = randint(-30, 30)
        x2 = randint(-25, 25)
        while x2 == x1
            x2 = randint(-25, 25)
        end
        y2 = randint(-30, 30)
        
        m = (y2 - y1) // (x2 - x1)
        
        problem(
            question="Find the slope of the line passing through the points \\(($(x1), $(y1))\\) and \\(($(x2), $(y2))\\).",
            answer=m,
            difficulty=(1800, 2000),
            solution=steps(
                "Use the slope formula: \$m = \\frac{y_2 - y_1}{x_2 - x_1}\$",
                sol("Substitute", "m = \\frac{$(y2) - ($(y1))}{$(x2) - ($(x1))} = \\frac{$(y2 - y1)}{$(x2 - x1)}"),
                sol("Slope", m)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Find y-intercept given slope and a point
        m = nonzero(-15, 15) // rand([1, 2, 3, 4, 5])
        x1 = randint(-20, 20)
        y1 = randint(-25, 25)
        
        b = y1 - m * x1
        
        problem(
            question="A line with slope \\(m = $(tex(m))\\) passes through the point \\(($(x1), $(y1))\\). Find the y-intercept \\(b\\).",
            answer=b,
            difficulty=(1850, 2050),
            solution=steps(
                "Use point-slope form: \$y - y_1 = m(x - x_1)\$",
                sol("Substitute", "y - $(y1) = $(tex(m))(x - $(x1))"),
                "Convert to slope-intercept form \$y = mx + b\$",
                sol("Expand", "y = $(tex(m * x)) + $(tex(m * (-x1) + y1))"),
                sol("Y-intercept", b)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Find equation of perpendicular line through a point
        m_original = nonzero(-12, 12) // rand([1, 2, 3, 4])
        m_perp = -1 // m_original
        
        x1 = randint(-18, 18)
        y1 = randint(-22, 22)
        
        b = y1 - m_perp * x1
        
        problem(
            question="Find the equation of the line perpendicular to \\(y = $(tex(m_original))x + $(randint(-10, 10))\\) that passes through \\(($(x1), $(y1))\\). Write your answer in the form \\(y = mx + b\\) and enter the value of \\(b\\).",
            answer=b,
            difficulty=(1900, 2100),
            solution=steps(
                "Perpendicular slope: \$m_{\\perp} = -\\frac{1}{m} = -\\frac{1}{$(tex(m_original))} = $(tex(m_perp))\$",
                "Use point-slope form with \$m = $(tex(m_perp))\$ and point \\(($(x1), $(y1))\\)",
                sol("Equation", "y - $(y1) = $(tex(m_perp))(x - $(x1))"),
                sol("Slope-intercept form", "y = $(tex(m_perp * x)) + $(tex(b))"),
                sol("Y-intercept", b)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Find x-coordinate where line passes through given y
        m = nonzero(-10, 10) // rand([1, 2, 3, 5])
        b = randint(-25, 25)
        y_target = randint(-30, 30)
        
        x_ans = (y_target - b) // m
        
        problem(
            question="The line \\(y = $(tex(m))x + $(b)\\) passes through the point \\((x, $(y_target))\\). Find \\(x\\).",
            answer=x_ans,
            difficulty=(1850, 2050),
            solution=steps(
                sol("Given equation", "y = $(tex(m))x + $(b)"),
                sol("Substitute \\(y = $(y_target)\\)", "$(y_target) = $(tex(m))x + $(b)"),
                "Solve for \\(x\\): \$$(tex(m))x = $(y_target - b)\$",
                sol("Answer", x_ans)
            ),
            time=100
        )
        
    elseif problem_type == 5
        # Find slope where line intersects another line at specific x
        m1 = nonzero(-8, 8) // rand([1, 2, 4])
        b1 = randint(-20, 20)
        
        x_int = randint(-15, 15)
        y_int = m1 * x_int + b1
        
        b2 = randint(-20, 20)
        while b2 == y_int
            b2 = randint(-20, 20)
        end
        
        m2 = (y_int - b2) // x_int
        
        problem(
            question="Find the slope \\(m\\) of the line \\(y = mx + $(b2)\\) if it intersects the line \\(y = $(tex(m1))x + $(b1)\\) at \\(x = $(x_int)\\).",
            answer=m2,
            difficulty=(2000, 2200),
            solution=steps(
                "Find y-coordinate of intersection by substituting into first line",
                sol("y-coordinate", "y = $(tex(m1)) \\cdot $(x_int) + $(b1) = $(tex(y_int))"),
                "Intersection point: \\(($(x_int), $(tex(y_int)))\\)",
                "Substitute into second line: \$$(tex(y_int)) = m \\cdot $(x_int) + $(b2)\$",
                sol("Solve for m", "m = \\frac{$(tex(y_int - b2))}{$(x_int)} = $(tex(m2))"),
                sol("Slope", m2)
            ),
            time=180
        )
        
    else  # problem_type == 6
        # Find slope given parallel line and point, then find specific coordinate
        m = nonzero(-9, 9) // rand([1, 2, 3, 4])
        b_given = randint(-15, 15)
        
        x1 = randint(-18, 18)
        y1 = randint(-20, 20)
        
        b_new = y1 - m * x1
        
        x_query = randint(-15, 15)
        while x_query == x1
            x_query = randint(-15, 15)
        end
        y_query = m * x_query + b_new
        
        problem(
            question="A line parallel to \\(y = $(tex(m))x + $(b_given)\\) passes through \\(($(x1), $(y1))\\). What is the y-coordinate when \\(x = $(x_query)\\)?",
            answer=y_query,
            difficulty=(2100, 2300),
            solution=steps(
                "Parallel lines have equal slopes: \$m = $(tex(m))\$",
                "Use point-slope form with \\(($(x1), $(y1))\\)",
                sol("Equation", "y - $(y1) = $(tex(m))(x - $(x1))"),
                sol("Slope-intercept form", "y = $(tex(m))x + $(tex(b_new))"),
                sol("Substitute \\(x = $(x_query)\\)", "y = $(tex(m)) \\cdot $(x_query) + $(tex(b_new)) = $(tex(y_query))"),
                sol("Answer", y_query)
            ),
            time=180
        )
    end
end