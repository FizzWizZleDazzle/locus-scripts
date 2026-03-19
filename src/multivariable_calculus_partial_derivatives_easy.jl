# multivariable_calculus - partial_derivatives (easy)
# Generated: 2026-03-08T20:57:52.576436

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/partial_derivatives")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Basic partial derivative of polynomial (ELO 700-900)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = randint(-15, 15)
        
        f = a*x^2 + b*y^2 + c
        
        if rand(Bool)
            # ∂f/∂x
            ans = diff(f, x)
            var_name = "x"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(700, 900),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(y\\) as constant and differentiate with respect to \\(x\\)",
                    sol("\\frac{\\partial f}{\\partial x}", ans)
                ),
                time=60
            )
        else
            # ∂f/∂y
            ans = diff(f, y)
            var_name = "y"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(700, 900),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(x\\) as constant and differentiate with respect to \\(y\\)",
                    sol("\\frac{\\partial f}{\\partial y}", ans)
                ),
                time=60
            )
        end
        
    elseif problem_type == 2
        # Partial derivative with mixed terms (ELO 800-1000)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = randint(-12, 12)
        
        f = a*x^2 + b*x*y + c*y^2 + d
        
        if rand(Bool)
            ans = diff(f, x)
            var_name = "x"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(800, 1000),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(y\\) as constant and apply power rule to each term",
                    sol("\\frac{\\partial f}{\\partial x}", ans)
                ),
                time=75
            )
        else
            ans = diff(f, y)
            var_name = "y"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(800, 1000),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(x\\) as constant and apply power rule to each term",
                    sol("\\frac{\\partial f}{\\partial y}", ans)
                ),
                time=75
            )
        end
        
    elseif problem_type == 3
        # Evaluate partial derivative at a point (ELO 900-1100)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        f = a*x^2 + b*x*y + c*y^2
        
        x0 = randint(-4, 4)
        y0 = randint(-4, 4)
        
        if rand(Bool)
            partial = diff(f, x)
            ans = substitute(partial, Dict(x => x0, y => y0))
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}($(x0), $(y0))\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(900, 1100),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial x}", partial),
                    "Evaluate at \\(($(x0), $(y0))\\): \\($(tex(partial))\\big|_{($(x0),$(y0))} = $(ans)\\)",
                    sol("Answer", ans)
                ),
                time=90
            )
        else
            partial = diff(f, y)
            ans = substitute(partial, Dict(x => x0, y => y0))
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}($(x0), $(y0))\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(900, 1100),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial y}", partial),
                    "Evaluate at \\(($(x0), $(y0))\\): \\($(tex(partial))\\big|_{($(x0),$(y0))} = $(ans)\\)",
                    sol("Answer", ans)
                ),
                time=90
            )
        end
        
    else
        # Second order partial derivative (ELO 1000-1200)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = nonzero(-4, 4)
        
        f = a*x^3 + b*x^2*y + c*x*y^2 + d*y^3
        
        deriv_type = rand(1:3)
        
        if deriv_type == 1
            # ∂²f/∂x²
            ans = diff(diff(f, x), x)
            problem(
                question="Find \\(\\frac{\\partial^2 f}{\\partial x^2}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(1000, 1200),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial x}", diff(f, x)),
                    "Differentiate again with respect to \\(x\\)",
                    sol("\\frac{\\partial^2 f}{\\partial x^2}", ans)
                ),
                time=120
            )
        elseif deriv_type == 2
            # ∂²f/∂y²
            ans = diff(diff(f, y), y)
            problem(
                question="Find \\(\\frac{\\partial^2 f}{\\partial y^2}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(1000, 1200),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial y}", diff(f, y)),
                    "Differentiate again with respect to \\(y\\)",
                    sol("\\frac{\\partial^2 f}{\\partial y^2}", ans)
                ),
                time=120
            )
        else
            # ∂²f/∂x∂y (mixed partial)
            ans = diff(diff(f, x), y)
            problem(
                question="Find \\(\\frac{\\partial^2 f}{\\partial y \\partial x}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(1050, 1200),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial x}", diff(f, x)),
                    "Differentiate with respect to \\(y\\)",
                    sol("\\frac{\\partial^2 f}{\\partial y \\partial x}", ans)
                ),
                time=120
            )
        end
    end
end