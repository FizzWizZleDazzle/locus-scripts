# calculus - implicit_differentiation (hard)
# Generated: 2026-03-08T20:40:52.628158

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/implicit_differentiation")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Circle/ellipse implicit differentiation
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(10, 50)
        
        # Equation: a*x^2 + b*y^2 = c
        lhs = a*x^2 + b*y^2
        
        # Differentiate implicitly: 2a*x + 2b*y*dy/dx = 0
        # dy/dx = -2a*x / (2b*y) = -a*x / (b*y)
        dydx = -a*x / (b*y)
        
        problem(
            question="Find \\frac{dy}{dx} using implicit differentiation: \$$(tex(lhs)) = $(c)\$",
            answer=dydx,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Given", lhs ~ c),
                "Differentiate both sides with respect to x: \$$(tex(2*a*x)) + $(tex(2*b*y))\\frac{dy}{dx} = 0\$",
                "Solve for \\frac{dy}{dx}: \$$(tex(2*b*y))\\frac{dy}{dx} = $(tex(-2*a*x))\$",
                sol("\\frac{dy}{dx}", dydx)
            ),
            time=120
        )
        
    elseif problem_type == 2
        # Product with y terms
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = randint(-20, 20)
        
        # Equation: x^2*y + a*x*y^2 = b
        lhs = x^2*y + a*x*y^2
        
        # Using product rule and chain rule
        # d/dx[x^2*y] = 2x*y + x^2*dy/dx
        # d/dx[a*x*y^2] = a*y^2 + a*x*2y*dy/dx
        # 2x*y + x^2*dy/dx + a*y^2 + 2a*x*y*dy/dx = 0
        # dy/dx(x^2 + 2a*x*y) = -2x*y - a*y^2
        
        numerator = -2*x*y - a*y^2
        denominator = x^2 + 2*a*x*y
        dydx = numerator / denominator
        
        problem(
            question="Find \\frac{dy}{dx} using implicit differentiation: \$$(tex(lhs)) = $(b)\$",
            answer=dydx,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", lhs ~ b),
                "Apply product rule to each term:",
                "\\frac{d}{dx}[x^2 y] = 2xy + x^2\\frac{dy}{dx}",
                "\\frac{d}{dx}[$(a)xy^2] = $(a)y^2 + $(2*a)xy\\frac{dy}{dx}",
                "Combine: \$2xy + x^2\\frac{dy}{dx} + $(tex(a*y^2)) + $(tex(2*a*x*y))\\frac{dy}{dx} = 0\$",
                "Factor out \\frac{dy}{dx}: \$(x^2 + $(tex(2*a*x*y)))\\frac{dy}{dx} = $(tex(-2*x*y - a*y^2))\$",
                sol("\\frac{dy}{dx}", dydx)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Rational expression with trig
        a = nonzero(-5, 5)
        b = randint(2, 6)
        
        # sin(x) + a*y / (x + y^b) = 0
        # More complex implicit differentiation
        
        # Let's do: x^2 + y^2 = a*x*y instead (folium-like)
        c = nonzero(2, 6)
        lhs = x^2 + y^2
        rhs = c*x*y
        
        # 2x + 2y*dy/dx = c*y + c*x*dy/dx
        # 2y*dy/dx - c*x*dy/dx = c*y - 2x
        # dy/dx(2y - c*x) = c*y - 2x
        
        numerator = c*y - 2*x
        denominator = 2*y - c*x
        dydx = numerator / denominator
        
        problem(
            question="Find \\frac{dy}{dx} using implicit differentiation: \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=dydx,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Differentiate both sides: \$2x + 2y\\frac{dy}{dx} = $(c)y + $(c)x\\frac{dy}{dx}\$",
                "Collect \\frac{dy}{dx} terms: \$(2y - $(c)x)\\frac{dy}{dx} = $(c)y - 2x\$",
                sol("\\frac{dy}{dx}", dydx)
            ),
            time=150
        )
        
    elseif problem_type == 4
        # Second derivative problem
        # For circle: x^2 + y^2 = r^2
        r_sq = randint(16, 64)
        
        # First derivative: 2x + 2y*dy/dx = 0, so dy/dx = -x/y
        dydx = -x/y
        
        # Second derivative using quotient rule:
        # d/dx[-x/y] = [(-1)*y - (-x)*(dy/dx)] / y^2
        # = [-y + x*(-x/y)] / y^2
        # = [-y - x^2/y] / y^2
        # = [-y^2 - x^2] / y^3
        # = -(x^2 + y^2) / y^3
        # = -r^2 / y^3
        
        d2ydx2 = -(x^2 + y^2) / y^3
        
        problem(
            question="For the circle \$x^2 + y^2 = $(r_sq)\$, find \\frac{d^2y}{dx^2} in terms of x and y.",
            answer=d2ydx2,
            difficulty=(2100, 2400),
            solution=steps(
                sol("Given", x^2 + y^2 ~ r_sq),
                "First derivative: \$2x + 2y\\frac{dy}{dx} = 0\$ gives \$\\frac{dy}{dx} = $(tex(dydx))\$",
                "Apply quotient rule to find \\frac{d^2y}{dx^2}:",
                "\\frac{d^2y}{dx^2} = \\frac{d}{dx}\\left[$(tex(dydx))\\right] = \\frac{-y - (-x)\\frac{dy}{dx}}{y^2}",
                "Substitute \\frac{dy}{dx} = $(tex(dydx)): \\frac{-y + x \\cdot \\frac{x}{y}}{y^2} = \\frac{-y^2 - x^2}{y^3}",
                sol("\\frac{d^2y}{dx^2}", d2ydx2)
            ),
            time=240
        )
        
    else
        # Tangent line at a specific point using implicit differentiation
        a = randint(3, 8)
        b = randint(3, 8)
        
        # Pick a point on the curve x^2/a^2 + y^2/b^2 = 1
        # Let's use x0 = a*cos(theta), y0 = b*sin(theta) for some nice angle
        angles = [0, 30, 45, 60]
        theta_deg = choice(angles)
        theta_rad = theta_deg * π / 180
        
        x0 = round(Int, a * cos(theta_rad))
        y0 = round(Int, b * sin(theta_rad))
        
        # Make sure point is reasonable
        if abs(x0) < 1
            x0 = choice([a, -a])
            y0 = 0
        end
        
        # For x^2/a^2 + y^2/b^2 = 1
        # Differentiate: 2x/a^2 + 2y/b^2 * dy/dx = 0
        # dy/dx = -(b^2 * x)/(a^2 * y)
        
        if y0 == 0
            # Vertical tangent case, pick different point
            x0 = 0
            y0 = b
        end
        
        slope = -(b^2 * x0) // (a^2 * y0)
        
        # Tangent line: y - y0 = slope*(x - x0)
        # y = slope*x - slope*x0 + y0
        tangent = slope*x + (y0 - slope*x0)
        
        problem(
            question="Find the equation of the tangent line to the ellipse \\frac{x^2}{$(a^2)} + \\frac{y^2}{$(b^2)} = 1 at the point ($(x0), $(y0)). Express in the form y = mx + b.",
            answer=tangent,
            difficulty=(2000, 2300),
            solution=steps(
                sol("Given", x^2//(a^2) + y^2//(b^2) ~ 1),
                "Differentiate implicitly: \\frac{2x}{$(a^2)} + \\frac{2y}{$(b^2)}\\frac{dy}{dx} = 0",
                "Solve for slope: \\frac{dy}{dx} = -\\frac{$(b^2)x}{$(a^2)y}",
                "At point ($(x0), $(y0)): slope = $(tex(slope))",
                "Tangent line: \$y - $(y0) = $(tex(slope))(x - $(x0))\$",
                sol("y", tangent)
            ),
            time=180
        )
    end
end