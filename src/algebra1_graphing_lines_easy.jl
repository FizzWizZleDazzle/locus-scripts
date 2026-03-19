# algebra1 - graphing_lines (easy)
# Generated: 2026-03-08T19:56:27.899085

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/graphing_lines")
    
    problem_type = choice([
        :slope_from_two_points,
        :y_intercept_from_equation,
        :point_on_line,
        :slope_intercept_form,
        :x_intercept,
        :parallel_slope,
        :perpendicular_slope,
        :equation_from_point_slope,
        :slope_from_graph_description,
        :find_y_given_x
    ])
    
    if problem_type == :slope_from_two_points
        x1, y1 = randint(-12, 12), randint(-12, 12)
        x2, y2 = randint(-12, 12), randint(-12, 12)
        while x1 == x2
            x2 = randint(-12, 12)
        end
        m = (y2 - y1) // (x2 - x1)
        
        problem(
            question="Find the slope of the line passing through the points \\(($(x1), $(y1))\\) and \\(($(x2), $(y2))\\).",
            answer=m,
            difficulty=(700, 900),
            solution=steps(
                "Use the slope formula: \$m = \\frac{y_2 - y_1}{x_2 - x_1}\$",
                sol("Substitute", "m = \\frac{$(y2) - ($(y1))}{$(x2) - ($(x1))} = \\frac{$(y2 - y1)}{$(x2 - x1)}"),
                sol("Answer", m)
            ),
            time=90
        )
        
    elseif problem_type == :y_intercept_from_equation
        m = nonzero(-8, 8)
        b = randint(-15, 15)
        
        problem(
            question="What is the y-intercept of the line \$y = $(m)x + $(b)\$?",
            answer=b,
            difficulty=(700, 850),
            solution=steps(
                "The equation is in slope-intercept form: \$y = mx + b\$",
                "The y-intercept is the constant term \$b\$",
                sol("Answer", b)
            ),
            time=60
        )
        
    elseif problem_type == :point_on_line
        m = nonzero(-6, 6)
        b = randint(-10, 10)
        x_val = randint(-8, 8)
        y_val = m * x_val + b
        
        problem(
            question="Does the point \\(($(x_val), $(y_val))\\) lie on the line \$y = $(m)x + $(b)\$? Answer 'yes' or 'no'.",
            answer="yes",
            answer_type="text",
            difficulty=(750, 950),
            solution=steps(
                sol("Substitute \$x = $(x_val)\$ into the equation", "y = $(m)($(x_val)) + $(b)"),
                sol("Calculate", "y = $(m * x_val) + $(b) = $(y_val)"),
                "Since this matches the y-coordinate, the answer is yes"
            ),
            time=75
        )
        
    elseif problem_type == :slope_intercept_form
        m = nonzero(-7, 7)
        x_pt = randint(-10, 10)
        y_pt = randint(-10, 10)
        b = y_pt - m * x_pt
        
        problem(
            question="Write the equation of the line with slope \$m = $(m)\$ passing through \\(($(x_pt), $(y_pt))\\) in slope-intercept form.",
            answer="y = $(m)x + $(b)",
            answer_type="text",
            difficulty=(900, 1100),
            solution=steps(
                "Use point-slope form: \$y - y_1 = m(x - x_1)\$",
                sol("Substitute", "y - $(y_pt) = $(m)(x - $(x_pt))"),
                sol("Expand and simplify", "y = $(m)x + $(b)")
            ),
            time=120
        )
        
    elseif problem_type == :x_intercept
        m = nonzero(-8, 8)
        b = nonzero(-15, 15)
        x_int = -b // m
        
        problem(
            question="Find the x-intercept of the line \$y = $(m)x + $(b)\$.",
            answer=x_int,
            difficulty=(800, 1000),
            solution=steps(
                "Set \$y = 0\$ and solve for \$x\$",
                sol("Equation", "0 = $(m)x + $(b)"),
                sol("Solve", "x = $(x_int)")
            ),
            time=90
        )
        
    elseif problem_type == :parallel_slope
        m = nonzero(-9, 9)
        b = randint(-12, 12)
        
        problem(
            question="What is the slope of any line parallel to \$y = $(m)x + $(b)\$?",
            answer=m,
            difficulty=(750, 950),
            solution=steps(
                "Parallel lines have equal slopes",
                "The slope of the given line is \$m = $(m)\$",
                sol("Answer", m)
            ),
            time=60
        )
        
    elseif problem_type == :perpendicular_slope
        m = nonzero(-8, 8)
        b = randint(-12, 12)
        m_perp = -1 // m
        
        problem(
            question="What is the slope of any line perpendicular to \$y = $(m)x + $(b)\$?",
            answer=m_perp,
            difficulty=(850, 1050),
            solution=steps(
                "Perpendicular lines have slopes that are negative reciprocals",
                "The slope of the given line is \$m = $(m)\$",
                sol("Answer", "m_{\\perp} = -\\frac{1}{$(m)} = $(m_perp)")
            ),
            time=90
        )
        
    elseif problem_type == :equation_from_point_slope
        x1, y1 = randint(-10, 10), randint(-10, 10)
        m = nonzero(-6, 6)
        b = y1 - m * x1
        
        problem(
            question="Find the equation of the line passing through \\(($(x1), $(y1))\\) with slope \$m = $(m)\$. Write your answer in the form \$y = mx + b\$.",
            answer="y = $(m)x + $(b)",
            answer_type="text",
            difficulty=(900, 1150),
            solution=steps(
                sol("Use point-slope form", "y - $(y1) = $(m)(x - $(x1))"),
                "Expand the right side and add \$$(y1)\$ to both sides",
                sol("Slope-intercept form", "y = $(m)x + $(b)")
            ),
            time=120
        )
        
    elseif problem_type == :slope_from_graph_description
        rise = nonzero(-10, 10)
        run = nonzero(1, 10)
        m = rise // run
        
        problem(
            question="A line rises $(rise) units for every $(run) units of horizontal movement. What is its slope?",
            answer=m,
            difficulty=(700, 900),
            solution=steps(
                "Slope is the ratio of vertical change to horizontal change",
                sol("Formula", "m = \\frac{\\text{rise}}{\\text{run}}"),
                sol("Answer", "m = \\frac{$(rise)}{$(run)} = $(m)")
            ),
            time=75
        )
        
    else  # :find_y_given_x
        m = nonzero(-7, 7)
        b = randint(-12, 12)
        x_val = randint(-10, 10)
        y_val = m * x_val + b
        
        problem(
            question="If \$y = $(m)x + $(b)\$, find the value of \$y\$ when \$x = $(x_val)\$.",
            answer=y_val,
            difficulty=(700, 900),
            solution=steps(
                sol("Substitute \$x = $(x_val)\$", "y = $(m)($(x_val)) + $(b)"),
                "Multiply and add",
                sol("Answer", y_val)
            ),
            time=75
        )
    end
end