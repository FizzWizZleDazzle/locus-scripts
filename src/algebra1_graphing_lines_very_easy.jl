# algebra1 - graphing_lines (very_easy)
# Generated: 2026-03-08T19:56:17.491255

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("algebra1/graphing_lines")
    
    problem_type = choice(1:6)
    
    if problem_type == 1
        # Identify slope from graph (foundational)
        m = choice([-3, -2, -1, 1, 2, 3])
        b = randint(-5, 5)
        
        g = GraphObj(x_range=(-6, 6), y_range=(-8, 8), width=400, height=400)
        plot!(g, m*x + b)
        point!(g, 0, b, label="(0, $b)")
        point!(g, 1, m + b, label="(1, $(m+b))")
        svg = render(g)
        
        problem(
            question="What is the slope of the line shown in the graph?",
            answer=m,
            difficulty=(200, 400),
            solution=steps(
                "Find two points on the line: (0, $b) and (1, $(m+b))",
                sol("Slope formula", "m = \\frac{y_2 - y_1}{x_2 - x_1} = \\frac{$(m+b) - $b}{1 - 0}"),
                sol("Answer", m)
            ),
            image=svg,
            calculator="none",
            time=60
        )
        
    elseif problem_type == 2
        # Find y-intercept from graph (foundational)
        m = choice([-2, -1, 1, 2])
        b = randint(-7, 7)
        
        g = GraphObj(x_range=(-6, 6), y_range=(-10, 10), width=400, height=400)
        plot!(g, m*x + b)
        point!(g, 0, b, label="")
        svg = render(g)
        
        problem(
            question="What is the y-intercept of the line shown in the graph?",
            answer=b,
            difficulty=(200, 400),
            solution=steps(
                "The y-intercept is where the line crosses the y-axis",
                "This occurs when x = 0",
                sol("Answer", b)
            ),
            image=svg,
            calculator="none",
            time=45
        )
        
    elseif problem_type == 3
        # Find slope from two points (elementary)
        x1 = randint(-8, 8)
        y1 = randint(-10, 10)
        dx = nonzero(-6, 6)
        dy = nonzero(-8, 8)
        x2 = x1 + dx
        y2 = y1 + dy
        m = dy // dx
        
        problem(
            question="Find the slope of the line passing through the points ($x1, $y1) and ($x2, $y2).",
            answer=m,
            difficulty=(400, 600),
            solution=steps(
                sol("Slope formula", "m = \\frac{y_2 - y_1}{x_2 - x_1}"),
                sol("Substitute", "m = \\frac{$y2 - ($y1)}{$x2 - ($x1)} = \\frac{$dy}{$dx}"),
                sol("Answer", m)
            ),
            calculator="none",
            time=75
        )
        
    elseif problem_type == 4
        # Identify if point is on line (elementary)
        m = nonzero(-5, 5)
        b = randint(-8, 8)
        x_val = randint(-6, 6)
        
        if choice([true, false])
            # Point IS on the line
            y_val = m * x_val + b
            ans = "yes"
            explanation = "Substituting x = $x_val gives y = $(m)*($x_val) + $b = $y_val, which matches"
        else
            # Point is NOT on the line
            y_correct = m * x_val + b
            y_val = y_correct + nonzero(-5, 5)
            ans = "no"
            explanation = "Substituting x = $x_val gives y = $(m)*($x_val) + $b = $y_correct, not $y_val"
        end
        
        problem(
            question="Is the point ($x_val, $y_val) on the line y = $(m)x + $b? Answer 'yes' or 'no'.",
            answer=ans,
            difficulty=(400, 600),
            answer_type="text",
            solution=steps(
                sol("Given line", y ~ m*x + b),
                explanation,
                sol("Answer", ans)
            ),
            calculator="none",
            time=60
        )
        
    elseif problem_type == 5
        # Write equation in slope-intercept form from slope and y-intercept (elementary)
        m = nonzero(-7, 7)
        b = randint(-10, 10)
        
        problem(
            question="Write the equation of a line with slope $m and y-intercept $b in slope-intercept form.",
            answer=m*x + b,
            difficulty=(500, 700),
            solution=steps(
                "Slope-intercept form is y = mx + b",
                "Substitute m = $m and b = $b",
                sol("Answer", y ~ m*x + b)
            ),
            calculator="none",
            time=60
        )
        
    else
        # Find x-intercept given equation (elementary)
        m = nonzero(-6, 6)
        b = nonzero(-10, 10)
        x_int = -b // m
        
        problem(
            question="Find the x-intercept of the line y = $(m)x + $b.",
            answer=x_int,
            difficulty=(500, 700),
            solution=steps(
                "The x-intercept occurs when y = 0",
                sol("Set y = 0", 0 ~ m*x + b),
                sol("Solve for x", "x = " * string(-b) * "/" * string(m) * " = " * string(x_int))
            ),
            calculator="none",
            time=75
        )
    end
end