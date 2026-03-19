# multivariable_calculus - partial_derivatives (medium)
# Generated: 2026-03-08T20:58:09.049976

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/partial_derivatives")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Basic partial derivative of polynomial
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = randint(-15, 15)
        d = nonzero(-8, 8)
        e = randint(-15, 15)
        
        f = a*x^2 + b*x*y + c*y^2 + d*x + e*y
        
        if rand(Bool)
            partial = diff(f, x)
            var_str = "x"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", f),
                    "Take partial derivative with respect to \\(x\\), treating \\(y\\) as constant",
                    sol("\\frac{\\partial f}{\\partial x}", partial)
                ),
                time=90
            )
        else
            partial = diff(f, y)
            var_str = "y"
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1200, 1400),
                solution=steps(
                    sol("Given", f),
                    "Take partial derivative with respect to \\(y\\), treating \\(x\\) as constant",
                    sol("\\frac{\\partial f}{\\partial y}", partial)
                ),
                time=90
            )
        end
        
    elseif problem_type == 2
        # Second order partial derivative
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = randint(-12, 12)
        
        f = a*x^3 + b*x^2*y + c*x*y^2 + d*y^3
        
        order_choice = rand(1:3)
        if order_choice == 1
            # fxx
            partial = diff(diff(f, x), x)
            problem(
                question="Find \\(\\frac{\\partial^2 f}{\\partial x^2}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial x}", diff(f, x)),
                    sol("\\frac{\\partial^2 f}{\\partial x^2}", partial)
                ),
                time=120
            )
        elseif order_choice == 2
            # fyy
            partial = diff(diff(f, y), y)
            problem(
                question="Find \\(\\frac{\\partial^2 f}{\\partial y^2}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial y}", diff(f, y)),
                    sol("\\frac{\\partial^2 f}{\\partial y^2}", partial)
                ),
                time=120
            )
        else
            # fxy (mixed)
            partial = diff(diff(f, x), y)
            problem(
                question="Find \\(\\frac{\\partial^2 f}{\\partial y \\partial x}\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1400, 1600),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial x}", diff(f, x)),
                    sol("\\frac{\\partial^2 f}{\\partial y \\partial x}", partial)
                ),
                time=120
            )
        end
        
    elseif problem_type == 3
        # Evaluate partial at a point
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        f = a*x^2*y + b*x*y^2 + c*x*y
        
        x0 = randint(-4, 4)
        y0 = nonzero(-4, 4)
        
        if rand(Bool)
            partial = diff(f, x)
            val = substitute(partial, [x => x0, y => y0])
            problem(
                question="Evaluate \\(\\frac{\\partial f}{\\partial x}\\) at \\(($(x0), $(y0))\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=val,
                difficulty=(1400, 1600),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial x}", partial),
                    "Substitute \\(x = $(x0)\\) and \\(y = $(y0)\\)",
                    sol("Answer", val)
                ),
                time=120
            )
        else
            partial = diff(f, y)
            val = substitute(partial, [x => x0, y => y0])
            problem(
                question="Evaluate \\(\\frac{\\partial f}{\\partial y}\\) at \\(($(x0), $(y0))\\) for \\(f(x,y) = $(tex(f))\\)",
                answer=val,
                difficulty=(1400, 1600),
                solution=steps(
                    sol("Given", f),
                    sol("\\frac{\\partial f}{\\partial y}", partial),
                    "Substitute \\(x = $(x0)\\) and \\(y = $(y0)\\)",
                    sol("Answer", val)
                ),
                time=120
            )
        end
        
    elseif problem_type == 4
        # Three variable partial
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = randint(-10, 10)
        
        f = a*x*y*z + b*x^2*y + c*y*z^2 + d*z
        
        var_choice = rand(1:3)
        if var_choice == 1
            partial = diff(f, x)
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial x}\\) for \\(f(x,y,z) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", f),
                    "Take partial derivative with respect to \\(x\\), treating \\(y\\) and \\(z\\) as constants",
                    sol("\\frac{\\partial f}{\\partial x}", partial)
                ),
                time=100
            )
        elseif var_choice == 2
            partial = diff(f, y)
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial y}\\) for \\(f(x,y,z) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", f),
                    "Take partial derivative with respect to \\(y\\), treating \\(x\\) and \\(z\\) as constants",
                    sol("\\frac{\\partial f}{\\partial y}", partial)
                ),
                time=100
            )
        else
            partial = diff(f, z)
            problem(
                question="Find \\(\\frac{\\partial f}{\\partial z}\\) for \\(f(x,y,z) = $(tex(f))\\)",
                answer=partial,
                difficulty=(1300, 1500),
                solution=steps(
                    sol("Given", f),
                    "Take partial derivative with respect to \\(z\\), treating \\(x\\) and \\(y\\) as constants",
                    sol("\\frac{\\partial f}{\\partial z}", partial)
                ),
                time=100
            )
        end
        
    else
        # Verify Clairaut's theorem (mixed partials equal)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        f = a*x^3*y^2 + b*x^2*y^3 + c*x*y + d
        
        fxy = diff(diff(f, x), y)
        fyx = diff(diff(f, y), x)
        
        problem(
            question="Verify that \\(\\frac{\\partial^2 f}{\\partial y \\partial x} = \\frac{\\partial^2 f}{\\partial x \\partial y}\\) for \\(f(x,y) = $(tex(f))\\). Give the common value.",
            answer=fxy,
            difficulty=(1500, 1700),
            solution=steps(
                sol("Given", f),
                sol("\\frac{\\partial^2 f}{\\partial y \\partial x}", fxy),
                sol("\\frac{\\partial^2 f}{\\partial x \\partial y}", fyx),
                "By Clairaut's theorem, the mixed partials are equal",
                sol("Answer", fxy)
            ),
            time=180
        )
    end
end