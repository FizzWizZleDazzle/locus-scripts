# differential_equations - separable_equations (hard)
# Generated: 2026-03-08T20:50:04.835390

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/separable_equations")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Type 1: dy/dx = f(x)g(y) with polynomial factors
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        k = nonzero(-6, 6)
        
        # dy/dx = k*f(x)*g(y)
        f_x = a*x + b
        g_y = y^2 + nonzero(-15, 15)
        
        rhs = k * f_x * g_y
        
        # Integrate: ∫dy/(y²+c) = ∫k(ax+b)dx
        # (1/√c)arctan(y/√c) = k(ax²/2 + bx) + C
        
        problem(
            question="Solve the separable differential equation: \$\\frac{dy}{dx} = $(tex(rhs))\$",
            answer="separable",
            difficulty=(1800, 2100),
            grading_mode="text",
            solution=steps(
                sol("Given", diff(y, x) ~ rhs),
                "Separate variables: \$\\frac{dy}{$(tex(g_y))} = $(k) \\cdot $(tex(f_x)) \\, dx\$",
                "Integrate both sides",
                "Solution involves arctan or logarithmic terms depending on the discriminant"
            ),
            time=240,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Type 2: dy/dx = y/x type (homogeneous)
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = nonzero(-7, 7)
        
        # dy/dx = (ay + bx)/(cx)
        numerator = a*y + b*x
        denominator = c*x
        
        problem(
            question="Solve the separable differential equation: \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))}\$",
            answer="separable",
            difficulty=(1900, 2200),
            grading_mode="text",
            solution=steps(
                sol("Given", diff(y, x) ~ numerator/denominator),
                "Rewrite as: \$\\frac{dy}{dx} = \\frac{$(a)y}{$(c)x} + \\frac{$(b)}{$(c)}\$",
                "Separate: \$\\frac{dy}{$(a)y + $(b*c)x/$(c)} = \\frac{dx}{$(c)x}\$",
                "Integrate both sides to obtain implicit solution"
            ),
            time=270,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Type 3: dy/dx = f(x)/g(y) clean separation
        m = nonzero(-6, 6)
        n = nonzero(-6, 6)
        p = nonzero(-5, 5)
        q = nonzero(-5, 5)
        
        # dy/dx = (mx + n)/(py + q)
        numerator = m*x + n
        denominator = p*y + q
        
        problem(
            question="Find the general solution to \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))}\$",
            answer="separable",
            difficulty=(1850, 2050),
            grading_mode="text",
            solution=steps(
                sol("Given", diff(y, x) ~ numerator/denominator),
                "Separate variables: \$($(tex(denominator))) \\, dy = ($(tex(numerator))) \\, dx\$",
                "Integrate: \$\\int ($(p)y + $(q)) \\, dy = \\int ($(m)x + $(n)) \\, dx\$",
                "General solution: \$\\frac{$(p)y^2}{2} + $(q)y = \\frac{$(m)x^2}{2} + $(n)x + C\$"
            ),
            time=210,
            calculator="none"
        )
        
    elseif problem_type == 4
        # Type 4: Exponential growth/decay with initial condition
        k = nonzero(-8, 8)
        y0 = nonzero(-20, 20)
        t0 = rand([0, 1])
        
        # dy/dt = ky, y(t0) = y0
        
        problem(
            question="Solve the initial value problem: \$\\frac{dy}{dt} = $(k)y\$, \$y($(t0)) = $(y0)\$",
            answer="exponential",
            difficulty=(1800, 2000),
            grading_mode="text",
            solution=steps(
                sol("Given IVP", diff(y, t) ~ k*y),
                "Separate and integrate: \$\\int \\frac{dy}{y} = \\int $(k) \\, dt\$",
                "General solution: \$\\ln|y| = $(k)t + C\$, so \$y = Ae^{$(k)t}\$",
                "Apply initial condition \$y($(t0)) = $(y0)\$: \$A = $(y0)e^{$(-k*t0)}\$",
                "Particular solution: \$y = $(y0)e^{$(k)(t - $(t0))}\$"
            ),
            time=240,
            calculator="none"
        )
        
    else
        # Type 5: More complex separable with trig or rational functions
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-4, 4)
        
        # dy/dx = (ax² + b)/(y)
        numerator = a*x^2 + b
        denominator = y
        
        y0 = nonzero(-15, 15)
        x0 = rand([0, 1, -1])
        
        problem(
            question="Solve the initial value problem: \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{y}\$, \$y($(x0)) = $(y0)\$",
            answer="separable",
            difficulty=(2000, 2300),
            grading_mode="text",
            solution=steps(
                sol("Given IVP", diff(y, x) ~ numerator/denominator),
                "Separate variables: \$y \\, dy = ($(tex(numerator))) \\, dx\$",
                "Integrate both sides: \$\\int y \\, dy = \\int ($(a)x^2 + $(b)) \\, dx\$",
                "General solution: \$\\frac{y^2}{2} = \\frac{$(a)x^3}{3} + $(b)x + C\$",
                "Apply \$y($(x0)) = $(y0)\$: find \$C = $(y0^2/2 - a*x0^3/3 - b*x0)\$",
                "Particular solution: \$y^2 = \\frac{2 \\cdot $(a)x^3}{3} + $(2*b)x + $(y0^2 - 2*a*x0^3/3 - 2*b*x0)\$"
            ),
            time=300,
            calculator="scientific"
        )
    end
end