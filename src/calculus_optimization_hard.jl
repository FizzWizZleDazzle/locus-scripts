# calculus - optimization (hard)
# Generated: 2026-03-08T20:43:33.489151

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/optimization")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Box optimization with fixed perimeter
        perimeter = randint(40, 120)
        optimal_x = perimeter // 4
        optimal_y = perimeter // 4
        max_area = optimal_x * optimal_y
        
        problem(
            question="A rectangle has a fixed perimeter of $(perimeter) units. Find the dimensions that maximize the area.",
            answer=fmt_tuple((optimal_x, optimal_y)),
            difficulty=(1800, 2000),
            answer_type="tuple",
            solution=steps(
                "Let x and y be the dimensions of the rectangle",
                sol("Constraint", 2x + 2y ~ perimeter),
                sol("Area", "A = xy"),
                "Express y in terms of x: \$y = $(perimeter//2) - x\$",
                sol("A(x)", "A = x($(perimeter//2) - x) = $(perimeter//2)x - x^2"),
                sol("\\frac{dA}{dx}", "$(perimeter//2) - 2x"),
                "Set derivative to zero: \$$(perimeter//2) - 2x = 0\$",
                sol("Critical point", "x = $(optimal_x)"),
                "Therefore \$y = $(optimal_y)\$",
                "Second derivative test: \$\\frac{d^2A}{dx^2} = -2 < 0\$ confirms maximum",
                sol("Dimensions", fmt_tuple((optimal_x, optimal_y)))
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Cylinder optimization - maximize volume with fixed surface area
        S = randint(200, 800)
        r_opt = sqrt(S // (6 * π))
        h_opt = 2 * r_opt
        V_max = π * r_opt^2 * h_opt
        
        problem(
            question="A cylindrical can has a fixed surface area of $(S)π square units. Find the radius that maximizes the volume. (Surface area formula: \$S = 2\\pi r^2 + 2\\pi rh\$)",
            answer=r_opt,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", "S = 2\\pi r^2 + 2\\pi rh = $(S)\\pi"),
                "Solve for h: \$h = \\frac{$(S)\\pi - 2\\pi r^2}{2\\pi r} = \\frac{$(S) - 2r^2}{2r}\$",
                sol("Volume", "V = \\pi r^2 h = \\pi r^2 \\cdot \\frac{$(S) - 2r^2}{2r} = \\frac{\\pi r($(S) - 2r^2)}{2}"),
                "Expand: \$V = \\frac{$(S)\\pi r - 2\\pi r^3}{2}\$",
                sol("\\frac{dV}{dr}", "\\frac{$(S)\\pi - 6\\pi r^2}{2}"),
                "Set derivative to zero: \$$(S)\\pi - 6\\pi r^2 = 0\$",
                sol("Critical point", "r^2 = $(S//6), \\quad r = \\sqrt{\\frac{$(S)}{6}}"),
                "Second derivative: \$\\frac{d^2V}{dr^2} = -6\\pi r < 0\$ confirms maximum",
                sol("Optimal radius", "r = \\sqrt{\\frac{$(S)}{6\\pi}}")
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Fence optimization with one side against wall
        area_target = randint(400, 1600)
        optimal_x = sqrt(2 * area_target)
        optimal_y = area_target // optimal_x
        min_fence = optimal_x + 2 * optimal_y
        
        problem(
            question="A farmer wants to enclose a rectangular area of $(area_target) square meters using fencing on three sides (one side is against an existing wall). Find the dimensions that minimize the amount of fencing needed.",
            answer=fmt_tuple((optimal_x, optimal_y)),
            difficulty=(1900, 2100),
            answer_type="tuple",
            solution=steps(
                "Let x = width parallel to wall, y = depth perpendicular to wall",
                sol("Constraint", "xy = $(area_target)"),
                sol("Fence length", "F = x + 2y"),
                "Express y in terms of x: \$y = \\frac{$(area_target)}{x}\$",
                sol("F(x)", "F = x + 2\\cdot\\frac{$(area_target)}{x} = x + \\frac{$(2*area_target)}{x}"),
                sol("\\frac{dF}{dx}", "1 - \\frac{$(2*area_target)}{x^2}"),
                "Set derivative to zero: \$1 - \\frac{$(2*area_target)}{x^2} = 0\$",
                sol("Solve", "x^2 = $(2*area_target), \\quad x = \\sqrt{$(2*area_target)}"),
                "Therefore \$y = \\frac{$(area_target)}{\\sqrt{$(2*area_target)}} = \\sqrt{\\frac{$(area_target)}{2}}\$",
                "Second derivative: \$\\frac{d^2F}{dx^2} = \\frac{$(4*area_target)}{x^3} > 0\$ confirms minimum",
                sol("Dimensions", "(x, y) = (\\sqrt{$(2*area_target)}, \\sqrt{$(area_target//2)})")
            ),
            time=200
        )
        
    elseif problem_type == 4
        # Distance optimization - point to parabola
        a = nonzero(-3, 3)
        b = randint(-8, 8)
        c = randint(-12, 12)
        px = randint(-10, 10)
        py = randint(-10, 10)
        
        # Critical point from calculus
        crit_x = (2*a*px - b) // (2*a)
        crit_y = a*crit_x^2 + b*crit_x + c
        min_dist = sqrt((crit_x - px)^2 + (crit_y - py)^2)
        
        problem(
            question="Find the point on the parabola \$y = $(tex(a*x^2 + b*x + c))\$ that is closest to the point \$($(px), $(py))\$.",
            answer=fmt_tuple((crit_x, crit_y)),
            difficulty=(2100, 2300),
            answer_type="tuple",
            solution=steps(
                "Let \$(x, y)\$ be a point on the parabola where \$y = $(tex(a*x^2 + b*x + c))\$",
                sol("Distance squared", "D^2 = (x - $(px))^2 + (y - $(py))^2"),
                "Substitute parabola equation:",
                sol("D^2(x)", "(x - $(px))^2 + ($(tex(a*x^2 + b*x + c)) - $(py))^2"),
                "Take derivative and set to zero (using chain rule)",
                "After differentiation: \$\\frac{d(D^2)}{dx} = 2(x - $(px)) + 2($(tex(a*x^2 + b*x + c)) - $(py))\\cdot($(tex(diff(a*x^2 + b*x + c, x))))\$",
                "Set equal to zero and solve for critical points",
                sol("Critical x-value", "x = $(crit_x)"),
                sol("Corresponding y-value", "y = $(crit_y)"),
                sol("Closest point", fmt_tuple((crit_x, crit_y)))
            ),
            time=280
        )
        
    else
        # Norman window optimization (semicircle on top of rectangle)
        perimeter = randint(16, 36)
        # Optimal: r = P/(4+π)
        r_opt = perimeter // (4 + π)
        h_opt = (perimeter - π*r_opt) // 2 - r_opt
        area_max = 2*r_opt*h_opt + π*r_opt^2 // 2
        
        problem(
            question="A Norman window has the shape of a rectangle surmounted by a semicircle. If the perimeter of the window is $(perimeter) meters, find the radius of the semicircle that maximizes the area.",
            answer=r_opt,
            difficulty=(2200, 2400),
            solution=steps(
                "Let r = radius of semicircle, h = height of rectangle",
                sol("Perimeter", "P = 2h + 2r + \\pi r = $(perimeter)"),
                "Solve for h: \$h = \\frac{$(perimeter) - 2r - \\pi r}{2} = \\frac{$(perimeter)}{2} - r - \\frac{\\pi r}{2}\$",
                sol("Area", "A = 2rh + \\frac{\\pi r^2}{2}"),
                "Substitute h:",
                sol("A(r)", "A = 2r\\left(\\frac{$(perimeter)}{2} - r - \\frac{\\pi r}{2}\\right) + \\frac{\\pi r^2}{2}"),
                "Expand: \$A = $(perimeter)r - 2r^2 - \\pi r^2 + \\frac{\\pi r^2}{2} = $(perimeter)r - 2r^2 - \\frac{\\pi r^2}{2}\$",
                sol("\\frac{dA}{dr}", "$(perimeter) - 4r - \\pi r"),
                "Set derivative to zero: \$$(perimeter) - 4r - \\pi r = 0\$",
                sol("Solve", "r(4 + \\pi) = $(perimeter)"),
                sol("Optimal radius", "r = \\frac{$(perimeter)}{4 + \\pi}"),
                "Second derivative: \$\\frac{d^2A}{dr^2} = -4 - \\pi < 0\$ confirms maximum"
            ),
            time=300
        )
    end
end