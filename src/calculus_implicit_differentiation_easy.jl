# calculus - implicit_differentiation (easy)
# Generated: 2026-03-08T20:40:15.088048

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("calculus/implicit_differentiation")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Circle: x^2 + y^2 = r^2, find dy/dx
        r_sq = randint(4, 100)
        lhs = x^2 + y^2
        
        # dy/dx = -x/y
        dydx = -x/y
        
        problem(
            question="Find \\frac{dy}{dx} using implicit differentiation: \$$(tex(lhs)) = $(r_sq)\$",
            answer=dydx,
            difficulty=(700, 900),
            solution=steps(
                sol("Given", lhs ~ r_sq),
                "Differentiate both sides with respect to x: \$2x + 2y\\frac{dy}{dx} = 0\$",
                "Solve for \\frac{dy}{dx}: \$2y\\frac{dy}{dx} = -2x\$",
                sol("Answer", dydx)
            ),
            time=90
        )
        
    elseif problem_type == 2
        # Linear combination: ax + by = c, find dy/dx
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = randint(-30, 30)
        lhs = a*x + b*y
        
        # dy/dx = -a/b
        dydx = -a//b
        
        problem(
            question="Find \\frac{dy}{dx} using implicit differentiation: \$$(tex(lhs)) = $(c)\$",
            answer=dydx,
            difficulty=(700, 850),
            solution=steps(
                sol("Given", lhs ~ c),
                "Differentiate both sides: \$$(a) + $(b)\\frac{dy}{dx} = 0\$",
                "Solve for \\frac{dy}{dx}: \$$(b)\\frac{dy}{dx} = $(-a)\$",
                sol("Answer", dydx)
            ),
            time=75
        )
        
    elseif problem_type == 3
        # x^2 + y^2 = axy type, find dy/dx
        a = nonzero(-6, 6)
        lhs = x^2 + y^2
        rhs = a*x*y
        
        # Differentiate: 2x + 2y(dy/dx) = a*y + a*x(dy/dx)
        # dy/dx = (ay - 2x)/(2y - ax)
        dydx_num = a*y - 2*x
        dydx_den = 2*y - a*x
        dydx = dydx_num / dydx_den
        
        problem(
            question="Find \\frac{dy}{dx} using implicit differentiation: \$$(tex(lhs)) = $(tex(rhs))\$",
            answer=dydx,
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", lhs ~ rhs),
                "Differentiate both sides: \$2x + 2y\\frac{dy}{dx} = $(a)y + $(a)x\\frac{dy}{dx}\$",
                "Collect terms with \\frac{dy}{dx}: \$(2y - $(a)x)\\frac{dy}{dx} = $(a)y - 2x\$",
                sol("Answer", dydx)
            ),
            time=120
        )
        
    else
        # x^2 + ay^2 = c, find dy/dx
        a = nonzero(-7, 7)
        c = randint(10, 80)
        lhs = x^2 + a*y^2
        
        # dy/dx = -x/(ay)
        dydx = -x/(a*y)
        
        problem(
            question="Find \\frac{dy}{dx} using implicit differentiation: \$$(tex(lhs)) = $(c)\$",
            answer=dydx,
            difficulty=(750, 950),
            solution=steps(
                sol("Given", lhs ~ c),
                "Differentiate both sides: \$2x + $(2*a)y\\frac{dy}{dx} = 0\$",
                "Solve for \\frac{dy}{dx}: \$$(2*a)y\\frac{dy}{dx} = -2x\$",
                sol("Answer", dydx)
            ),
            time=90
        )
    end
end