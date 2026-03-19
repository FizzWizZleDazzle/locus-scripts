# calculus - area_between_curves (very_easy)
# Generated: 2026-03-08T20:47:29.576043

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/area_between_curves")
    
    # For foundational/elementary (100-700), we want very simple setup:
    # - Simple functions (constants, linear)
    # - Easy bounds (small integers)
    # - Direct computation with no complex algebra
    
    prob_type = rand(1:4)
    
    if prob_type == 1
        # Type 1: Area between a horizontal line and x-axis (100-300 ELO)
        # Very foundational: just a rectangle
        h = randint(2, 8)
        a = randint(0, 4)
        width = randint(3, 7)
        b = a + width
        
        area = h * width
        
        problem(
            question="Find the area between \\(y = $h\\) and the \\(x\\)-axis from \\(x = $a\\) to \\(x = $b\\).",
            answer=area,
            difficulty=(100, 300),
            solution=steps(
                "The region is a rectangle with height \\($h\\) and width \\($(b) - $(a) = $(width)\\)",
                sol("Area", "$(h) \\times $(width)"),
                sol("Answer", area)
            ),
            time=45
        )
    elseif prob_type == 2
        # Type 2: Area between two horizontal lines (200-400 ELO)
        # Rectangle with offset
        y1 = randint(1, 5)
        y2 = y1 + randint(2, 6)
        a = randint(0, 3)
        width = randint(3, 6)
        b = a + width
        
        height = y2 - y1
        area = height * width
        
        problem(
            question="Find the area between \\(y = $y2\\) and \\(y = $y1\\) from \\(x = $a\\) to \\(x = $b\\).",
            answer=area,
            difficulty=(200, 400),
            solution=steps(
                "The region is a rectangle with height \\($(y2) - $(y1) = $(height)\\) and width \\($(b) - $(a) = $(width)\\)",
                sol("Area", "$(height) \\times $(width)"),
                sol("Answer", area)
            ),
            time=60
        )
    elseif prob_type == 3
        # Type 3: Area between a simple linear function and x-axis (400-600 ELO)
        # Triangle or trapezoid
        m = nonzero(1, 4)
        b_coef = randint(0, 8)
        
        # Choose bounds so area is clean
        a = 0
        b = randint(2, 6)
        
        # Area = integral from a to b of (mx + b_coef)
        # = [mx²/2 + b_coef*x] from a to b
        # = m*b²/2 + b_coef*b - (m*a²/2 + b_coef*a)
        
        area_val = m * b^2 // 2 + b_coef * b - (m * a^2 // 2 + b_coef * a)
        area_val = simplify(area_val)
        
        expr = m*x + b_coef
        
        problem(
            question="Find the area between \\(y = $(tex(expr))\\) and the \\(x\\)-axis from \\(x = $a\\) to \\(x = $b\\).",
            answer=area_val,
            difficulty=(400, 600),
            solution=steps(
                sol("Setup", "\\text{Area} = \\int_{$(a)}^{$(b)} ($(tex(expr))) \\, dx"),
                sol("Integrate", "\\left[\\frac{$(m)x^2}{2} + $(b_coef)x\\right]_{$(a)}^{$(b)}"),
                sol("Evaluate", "\\frac{$(m) \\cdot $(b)^2}{2} + $(b_coef) \\cdot $(b) = $(area_val)"),
                sol("Answer", area_val)
            ),
            time=90
        )
    else
        # Type 4: Area between two simple linear functions (500-700 ELO)
        # f(x) = mx + b1, g(x) = nx + b2 where f > g on interval
        m = randint(1, 3)
        n = randint(-2, 0)
        b1 = randint(3, 8)
        b2 = randint(0, 2)
        
        a = 0
        b = randint(2, 5)
        
        # Area = integral of (f - g)
        # = integral of ((m-n)x + (b1-b2))
        coef_x = m - n
        coef_const = b1 - b2
        
        area_val = coef_x * b^2 // 2 + coef_const * b
        area_val = simplify(area_val)
        
        f_expr = m*x + b1
        g_expr = n*x + b2
        
        problem(
            question="Find the area between \\(f(x) = $(tex(f_expr))\\) and \\(g(x) = $(tex(g_expr))\\) from \\(x = $a\\) to \\(x = $b\\).",
            answer=area_val,
            difficulty=(500, 700),
            solution=steps(
                sol("Setup", "\\text{Area} = \\int_{$(a)}^{$(b)} [($(tex(f_expr))) - ($(tex(g_expr)))] \\, dx"),
                sol("Simplify", "\\int_{$(a)}^{$(b)} ($(tex(simplify(f_expr - g_expr)))) \\, dx"),
                sol("Integrate", "\\left[\\frac{$(coef_x)x^2}{2} + $(coef_const)x\\right]_{$(a)}^{$(b)}"),
                sol("Answer", area_val)
            ),
            time=120
        )
    end
end