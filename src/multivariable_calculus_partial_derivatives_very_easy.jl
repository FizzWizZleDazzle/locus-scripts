# multivariable_calculus - partial_derivatives (very_easy)
# Generated: 2026-03-08T20:57:41.806211

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/partial_derivatives")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Simple partial derivative: f(x,y) = ax + by
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        f = a*x + b*y
        
        if rand(Bool)
            # ∂f/∂x
            ans = a
            var_str = "x"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(200, 400),
                solution=steps(
                    sol("Given", f),
                    "Take the partial derivative with respect to \\(x\\), treating \\(y\\) as constant",
                    sol("Answer", ans)
                ),
                time=45
            )
        else
            # ∂f/∂y
            ans = b
            var_str = "y"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(200, 400),
                solution=steps(
                    sol("Given", f),
                    "Take the partial derivative with respect to \\(y\\), treating \\(x\\) as constant",
                    sol("Answer", ans)
                ),
                time=45
            )
        end
        
    elseif problem_type == 2
        # Quadratic in one variable: f(x,y) = ax² + by
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        f = a*x^2 + b*y
        
        if rand(Bool)
            # ∂f/∂x
            ans = 2*a*x
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(400, 600),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(y\\) as constant and differentiate with respect to \\(x\\) using power rule",
                    sol("Answer", ans)
                ),
                time=60
            )
        else
            # ∂f/∂y
            ans = b
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(300, 500),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(x\\) as constant and differentiate with respect to \\(y\\)",
                    sol("Answer", ans)
                ),
                time=45
            )
        end
        
    elseif problem_type == 3
        # Simple product: f(x,y) = axy + b
        a = nonzero(-7, 7)
        b = randint(-12, 12)
        f = a*x*y + b
        
        if rand(Bool)
            # ∂f/∂x
            ans = a*y
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(400, 600),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(y\\) as a constant coefficient and differentiate with respect to \\(x\\)",
                    sol("Answer", ans)
                ),
                time=60
            )
        else
            # ∂f/∂y
            ans = a*x
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(400, 600),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(x\\) as a constant coefficient and differentiate with respect to \\(y\\)",
                    sol("Answer", ans)
                ),
                time=60
            )
        end
        
    elseif problem_type == 4
        # Two terms: f(x,y) = ax² + by²
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        f = a*x^2 + b*y^2
        
        if rand(Bool)
            # ∂f/∂x
            ans = 2*a*x
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(500, 700),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(y\\) as constant; the term \\($(tex(b*y^2))\\) becomes a constant",
                    "Apply power rule to \\($(tex(a*x^2))\\)",
                    sol("Answer", ans)
                ),
                time=75
            )
        else
            # ∂f/∂y
            ans = 2*b*y
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(500, 700),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(x\\) as constant; the term \\($(tex(a*x^2))\\) becomes a constant",
                    "Apply power rule to \\($(tex(b*y^2))\\)",
                    sol("Answer", ans)
                ),
                time=75
            )
        end
        
    else
        # Three terms: f(x,y) = ax² + bxy + c
        a = nonzero(-4, 4)
        b = nonzero(-6, 6)
        c = randint(-10, 10)
        f = a*x^2 + b*x*y + c
        
        if rand(Bool)
            # ∂f/∂x
            ans = 2*a*x + b*y
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(600, 700),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(y\\) as constant and differentiate each term with respect to \\(x\\)",
                    "\\(\\frac{\\partial}{\\partial x}[$(tex(a*x^2))] = $(tex(2*a*x))\\), \\(\\frac{\\partial}{\\partial x}[$(tex(b*x*y))] = $(tex(b*y))\\), \\(\\frac{\\partial}{\\partial x}[$(c)] = 0\\)",
                    sol("Answer", ans)
                ),
                time=90
            )
        else
            # ∂f/∂y
            ans = b*x
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) where \\(f(x,y) = $(tex(f))\\)",
                answer=ans,
                difficulty=(500, 700),
                solution=steps(
                    sol("Given", f),
                    "Treat \\(x\\) as constant and differentiate each term with respect to \\(y\\)",
                    "\\(\\frac{\\partial}{\\partial y}[$(tex(a*x^2))] = 0\\), \\(\\frac{\\partial}{\\partial y}[$(tex(b*x*y))] = $(tex(b*x))\\), \\(\\frac{\\partial}{\\partial y}[$(c)] = 0\\)",
                    sol("Answer", ans)
                ),
                time=75
            )
        end
    end
end