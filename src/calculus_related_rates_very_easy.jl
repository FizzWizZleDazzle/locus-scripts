# calculus - related_rates (very_easy)
# Generated: 2026-03-08T20:41:05.410854

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("calculus/related_rates")
    
    prob_type = rand(1:6)
    
    if prob_type == 1
        # Simple rate recognition: given dx/dt, find dy/dt when y = kx
        k = nonzero(-8, 8)
        rate_x = nonzero(-10, 10)
        rate_y = k * rate_x
        
        problem(
            question="If \\(y = $(k)x\\) and \\(\\frac{dx}{dt} = $(rate_x)\\), what is \\(\\frac{dy}{dt}\\)?",
            answer=rate_y,
            difficulty=(200, 400),
            solution=steps(
                "Given: \\(y = $(k)x\\) and \\(\\frac{dx}{dt} = $(rate_x)\\)",
                "Differentiate both sides with respect to \\(t\\): \\(\\frac{dy}{dt} = $(k)\\frac{dx}{dt}\\)",
                sol("Answer", "\\frac{dy}{dt} = $(k) \\cdot $(rate_x) = $(rate_y)")
            ),
            time=60
        )
        
    elseif prob_type == 2
        # Basic chain rule: y = x^2, given dx/dt and x value, find dy/dt
        x_val = nonzero(-6, 6)
        rate_x = nonzero(-8, 8)
        rate_y = 2 * x_val * rate_x
        
        problem(
            question="If \\(y = x^2\\), \\(x = $(x_val)\\), and \\(\\frac{dx}{dt} = $(rate_x)\\), find \\(\\frac{dy}{dt}\\).",
            answer=rate_y,
            difficulty=(400, 600),
            solution=steps(
                "Given: \\(y = x^2\\), \\(x = $(x_val)\\), \\(\\frac{dx}{dt} = $(rate_x)\\)",
                "Differentiate: \\(\\frac{dy}{dt} = 2x\\frac{dx}{dt}\\)",
                "Substitute: \\(\\frac{dy}{dt} = 2($(x_val))($(rate_x)) = $(rate_y)\\)"
            ),
            time=90
        )
        
    elseif prob_type == 3
        # Sum relationship: z = x + y, given dx/dt and dy/dt, find dz/dt
        rate_x = nonzero(-12, 12)
        rate_y = nonzero(-12, 12)
        rate_z = rate_x + rate_y
        
        problem(
            question="If \\(z = x + y\\), \\(\\frac{dx}{dt} = $(rate_x)\\), and \\(\\frac{dy}{dt} = $(rate_y)\\), what is \\(\\frac{dz}{dt}\\)?",
            answer=rate_z,
            difficulty=(300, 500),
            solution=steps(
                "Given: \\(z = x + y\\), \\(\\frac{dx}{dt} = $(rate_x)\\), \\(\\frac{dy}{dt} = $(rate_y)\\)",
                "Differentiate both sides: \\(\\frac{dz}{dt} = \\frac{dx}{dt} + \\frac{dy}{dt}\\)",
                sol("Answer", "\\frac{dz}{dt} = $(rate_x) + $(rate_y) = $(rate_z)")
            ),
            time=75
        )
        
    elseif prob_type == 4
        # Product with constant: A = kx, given dA/dt, find dx/dt
        k = nonzero(2, 9)
        rate_A = nonzero(-15, 15)
        rate_x = rate_A // k
        
        problem(
            question="The area of a square is \\(A = $(k)x\\) where \\(x\\) is a length. If \\(\\frac{dA}{dt} = $(rate_A)\\), find \\(\\frac{dx}{dt}\\).",
            answer=rate_x,
            difficulty=(400, 600),
            solution=steps(
                "Given: \\(A = $(k)x\\) and \\(\\frac{dA}{dt} = $(rate_A)\\)",
                "Differentiate: \\(\\frac{dA}{dt} = $(k)\\frac{dx}{dt}\\)",
                "Solve: \\(\\frac{dx}{dt} = \\frac{$(rate_A)}{$(k)} = $(rate_x)\\)"
            ),
            time=90
        )
        
    elseif prob_type == 5
        # Rectangle area: A = xy with one constant dimension
        width = nonzero(3, 10)
        rate_h = nonzero(-8, 8)
        rate_A = width * rate_h
        
        problem(
            question="A rectangle has constant width $(width) units and variable height \\(h\\). If the height is changing at \\(\\frac{dh}{dt} = $(rate_h)\\) units per second, at what rate is the area \\(A\\) changing?",
            answer=rate_A,
            difficulty=(500, 700),
            solution=steps(
                "Given: width = $(width), \\(\\frac{dh}{dt} = $(rate_h)\\)",
                "Area formula: \\(A = $(width)h\\)",
                "Differentiate: \\(\\frac{dA}{dt} = $(width)\\frac{dh}{dt} = $(width) \\cdot $(rate_h) = $(rate_A)\\)"
            ),
            time=90
        )
        
    else
        # y = kx^2, given x, dx/dt, find dy/dt
        k = nonzero(2, 6)
        x_val = nonzero(2, 8)
        rate_x = nonzero(-7, 7)
        rate_y = 2 * k * x_val * rate_x
        
        problem(
            question="If \\(y = $(k)x^2\\), \\(x = $(x_val)\\), and \\(\\frac{dx}{dt} = $(rate_x)\\), find \\(\\frac{dy}{dt}\\).",
            answer=rate_y,
            difficulty=(500, 700),
            solution=steps(
                "Given: \\(y = $(k)x^2\\), \\(x = $(x_val)\\), \\(\\frac{dx}{dt} = $(rate_x)\\)",
                "Differentiate with respect to \\(t\\): \\(\\frac{dy}{dt} = $(k) \\cdot 2x\\frac{dx}{dt} = $(2*k)x\\frac{dx}{dt}\\)",
                "Substitute: \\(\\frac{dy}{dt} = $(2*k)($(x_val))($(rate_x)) = $(rate_y)\\)"
            ),
            time=120
        )
    end
end