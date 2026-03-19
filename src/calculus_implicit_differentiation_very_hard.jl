# calculus - implicit_differentiation (very_hard)
# Generated: 2026-03-08T20:40:45.263045

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/implicit_differentiation")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Circle/ellipse implicit differentiation with specific point
        a = randint(2, 8)
        b = randint(2, 8)
        x0 = nonzero(-10, 10)
        y0 = nonzero(-10, 10)
        
        # Adjust to make point lie on curve
        c = a * x0^2 + b * y0^2
        
        implicit_eq = a*x^2 + b*y^2 - c
        
        # Differentiate implicitly: 2ax + 2by(dy/dx) = 0
        # dy/dx = -ax/by
        slope_num = -a * x0
        slope_den = b * y0
        slope = slope_num // slope_den
        
        problem(
            question="Given the curve \$$(a)x^2 + $(b)y^2 = $(c)\$, find \$\\frac{dy}{dx}\$ at the point \$($(x0), $(y0))\$.",
            answer=slope,
            difficulty=(2500, 2800),
            solution=steps(
                sol("Given curve", a*x^2 + b*y^2 ~ c),
                "Differentiate both sides with respect to \$x\$: \$$(2a)x + $(2b)y\\frac{dy}{dx} = 0\$",
                "Solve for \$\\frac{dy}{dx}\$: \$\\frac{dy}{dx} = -\\frac{$(a)x}{$(b)y}\$",
                "Substitute \$(x, y) = ($(x0), $(y0))\$",
                sol("Answer", slope)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Complex implicit curve with product terms
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = randint(-15, 15)
        
        x0 = randint(1, 6)
        y0 = nonzero(-8, 8)
        
        # xy + ax^2 + by^2 = d
        d_val = x0 * y0 + a * x0^2 + b * y0^2
        
        implicit_eq = x*y + a*x^2 + b*y^2 - d_val
        
        # Differentiate: y + x(dy/dx) + 2ax + 2by(dy/dx) = 0
        # dy/dx(x + 2by) = -y - 2ax
        # dy/dx = -(y + 2ax)/(x + 2by)
        
        slope_num = -(y0 + 2*a*x0)
        slope_den = x0 + 2*b*y0
        slope = slope_num // slope_den
        
        problem(
            question="For the curve \$xy + $(a)x^2 + $(b)y^2 = $(d_val)\$, find \$\\frac{dy}{dx}\$ at \$($(x0), $(y0))\$.",
            answer=slope,
            difficulty=(2700, 3000),
            solution=steps(
                sol("Given", x*y + a*x^2 + b*y^2 ~ d_val),
                "Differentiate implicitly: \$y + x\\frac{dy}{dx} + $(2a)x + $(2b)y\\frac{dy}{dx} = 0\$",
                "Factor: \$\\frac{dy}{dx}(x + $(2b)y) = -y - $(2a)x\$",
                "Solve: \$\\frac{dy}{dx} = -\\frac{y + $(2a)x}{x + $(2b)y}\$",
                "At \$($(x0), $(y0))\$: \$\\frac{dy}{dx} = -\\frac{$(y0 + 2*a*x0)}{$(x0 + 2*b*y0)} = $(slope)\$"
            ),
            time=240
        )
        
    elseif problem_type == 3
        # Higher order implicit differentiation: find d²y/dx²
        a = randint(2, 5)
        x0 = randint(1, 4)
        y0 = randint(1, 4)
        
        # Simple circle: x^2 + y^2 = r^2
        r_sq = x0^2 + y0^2
        
        # First derivative: 2x + 2y(dy/dx) = 0 => dy/dx = -x/y
        dydx_val = -x0 // y0
        
        # Second derivative: d/dx[-x/y] = -(y - x(dy/dx))/y^2
        # = -(y - x(-x/y))/y^2 = -(y + x^2/y)/y^2 = -(y^2 + x^2)/y^3 = -r^2/y^3
        d2ydx2_num = -r_sq
        d2ydx2_den = y0^3
        d2ydx2 = d2ydx2_num // d2ydx2_den
        
        problem(
            question="Given \$x^2 + y^2 = $(r_sq)\$, find \$\\frac{d^2y}{dx^2}\$ at the point \$($(x0), $(y0))\$.",
            answer=d2ydx2,
            difficulty=(2900, 3200),
            solution=steps(
                sol("Given", x^2 + y^2 ~ r_sq),
                "First derivative: \$2x + 2y\\frac{dy}{dx} = 0\$ gives \$\\frac{dy}{dx} = -\\frac{x}{y}\$",
                "At \$($(x0), $(y0))\$: \$\\frac{dy}{dx} = $(dydx_val)\$",
                "Second derivative: \$\\frac{d}{dx}\\left[-\\frac{x}{y}\\right] = -\\frac{y - x\\frac{dy}{dx}}{y^2}\$",
                "Substitute \$\\frac{dy}{dx} = -\\frac{x}{y}\$: \$\\frac{d^2y}{dx^2} = -\\frac{y^2 + x^2}{y^3} = -\\frac{$(r_sq)}{y^3}\$",
                "At \$y = $(y0)\$: \$\\frac{d^2y}{dx^2} = -\\frac{$(r_sq)}{$(y0^3)} = $(d2ydx2)\$"
            ),
            time=300
        )
        
    else
        # Transcendental implicit equation
        a = randint(2, 6)
        b = nonzero(-4, 4)
        
        x0 = randint(1, 3)
        y0 = randint(1, 5)
        
        # sin(xy) + ax = by
        # Differentiate: cos(xy)(y + x dy/dx) + a = b dy/dx
        # cos(xy)y + a = dy/dx(b - x cos(xy))
        # dy/dx = (cos(xy)y + a)/(b - x cos(xy))
        
        # For computation, use symbolic forms
        xy_prod = x0 * y0
        
        problem(
            question="For the equation \$\\sin(xy) + $(a)x = $(b)y\$, find an expression for \$\\frac{dy}{dx}\$ in terms of \$x\$ and \$y\$.",
            answer="\\frac{y\\cos(xy) + $(a)}{$(b) - x\\cos(xy)}",
            answer_type="expression",
            difficulty=(3000, 3400),
            solution=steps(
                sol("Given", "\\sin(xy) + $(a)x = $(b)y"),
                "Differentiate implicitly: \$\\cos(xy)\\left(y + x\\frac{dy}{dx}\\right) + $(a) = $(b)\\frac{dy}{dx}\$",
                "Expand: \$y\\cos(xy) + x\\cos(xy)\\frac{dy}{dx} + $(a) = $(b)\\frac{dy}{dx}\$",
                "Collect \$\\frac{dy}{dx}\$ terms: \$\\frac{dy}{dx}\\left($(b) - x\\cos(xy)\\right) = y\\cos(xy) + $(a)\$",
                sol("Answer", "\\frac{dy}{dx} = \\frac{y\\cos(xy) + $(a)}{$(b) - x\\cos(xy)}")
            ),
            time=270
        )
    end
end