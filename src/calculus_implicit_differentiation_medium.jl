# calculus - implicit_differentiation (medium)
# Generated: 2026-03-08T20:40:29.916128

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/implicit_differentiation")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Circle: x² + y² = r²
        r = randint(2, 8)
        r_sq = r^2
        expr = x^2 + y^2
        
        # Differentiate implicitly: 2x + 2y(dy/dx) = 0
        # dy/dx = -x/y
        dydx = -x/y
        
        problem(
            question="Use implicit differentiation to find \\(\\frac{dy}{dx}\\) if \\($(tex(expr)) = $(r_sq)\\)",
            answer=dydx,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Given", expr ~ r_sq),
                "Differentiate both sides with respect to \\(x\\): \\(2x + 2y\\frac{dy}{dx} = 0\\)",
                "Solve for \\(\\frac{dy}{dx}\\): \\(2y\\frac{dy}{dx} = -2x\\)",
                sol("Answer", dydx)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Ellipse: ax² + by² = c
        a = randint(1, 5)
        b = randint(1, 5)
        c = randint(10, 50)
        expr = a*x^2 + b*y^2
        
        # Differentiate: 2ax + 2by(dy/dx) = 0
        # dy/dx = -ax/(by)
        dydx = simplify(-a*x/(b*y))
        
        problem(
            question="Find \\(\\frac{dy}{dx}\\) using implicit differentiation: \\($(tex(expr)) = $(c)\\)",
            answer=dydx,
            difficulty=(1200, 1500),
            solution=steps(
                sol("Given", expr ~ c),
                "Differentiate both sides: \\($(2*a)x + $(2*b)y\\frac{dy}{dx} = 0\\)",
                "Isolate \\(\\frac{dy}{dx}\\): \\($(2*b)y\\frac{dy}{dx} = -$(2*a)x\\)",
                sol("Answer", dydx)
            ),
            time=120
        )
        
    elseif problem_type == 3
        # Product with y: xy = k or x²y = k
        if rand(Bool)
            k = randint(5, 30)
            expr = x*y
            # Differentiate: y + x(dy/dx) = 0
            dydx = -y/x
        else
            k = randint(10, 50)
            expr = x^2*y
            # Differentiate: 2xy + x²(dy/dx) = 0
            dydx = -2*y/x
        end
        
        problem(
            question="Use implicit differentiation to find \\(\\frac{dy}{dx}\\) if \\($(tex(expr)) = $(k)\\)",
            answer=dydx,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Given", expr ~ k),
                "Apply product rule and differentiate implicitly",
                "Solve for \\(\\frac{dy}{dx}\\)",
                sol("Answer", dydx)
            ),
            time=100
        )
        
    elseif problem_type == 4
        # Mixed terms: x² + xy + y² = c
        c = randint(10, 40)
        expr = x^2 + x*y + y^2
        
        # Differentiate: 2x + y + x(dy/dx) + 2y(dy/dx) = 0
        # (x + 2y)(dy/dx) = -(2x + y)
        # dy/dx = -(2x + y)/(x + 2y)
        dydx = -(2*x + y)/(x + 2*y)
        
        problem(
            question="Find \\(\\frac{dy}{dx}\\) using implicit differentiation: \\($(tex(expr)) = $(c)\\)",
            answer=dydx,
            difficulty=(1400, 1700),
            solution=steps(
                sol("Given", expr ~ c),
                "Differentiate both sides: \\(2x + y + x\\frac{dy}{dx} + 2y\\frac{dy}{dx} = 0\\)",
                "Factor and solve: \\((x + 2y)\\frac{dy}{dx} = -(2x + y)\\)",
                sol("Answer", dydx)
            ),
            time=150
        )
        
    else
        # Higher power: x³ + y³ = k or x² + y³ = k
        if rand(Bool)
            k = randint(20, 80)
            expr = x^3 + y^3
            # Differentiate: 3x² + 3y²(dy/dx) = 0
            dydx = -x^2/y^2
        else
            k = randint(15, 50)
            expr = x^2 + y^3
            # Differentiate: 2x + 3y²(dy/dx) = 0
            dydx = -2*x/(3*y^2)
        end
        
        problem(
            question="Use implicit differentiation to find \\(\\frac{dy}{dx}\\) if \\($(tex(expr)) = $(k)\\)",
            answer=dydx,
            difficulty=(1300, 1600),
            solution=steps(
                sol("Given", expr ~ k),
                "Differentiate both sides with respect to \\(x\\), using chain rule for \\(y\\) terms",
                "Solve for \\(\\frac{dy}{dx}\\)",
                sol("Answer", dydx)
            ),
            time=120
        )
    end
end