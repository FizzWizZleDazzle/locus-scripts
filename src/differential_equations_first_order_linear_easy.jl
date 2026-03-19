# differential_equations - first_order_linear (easy)
# Generated: 2026-03-08T20:50:18.207112

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/first_order_linear")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Simple separable dy/dx = ky form (700-900 ELO)
        k = nonzero(-8, 8)
        C = randint(-15, 15)
        
        problem(
            question="Solve the differential equation: \$\\frac{dy}{dx} = $(k)y\$",
            answer="y = Ce^($(k)x)",
            difficulty=(700, 900),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(k)y"),
                "Separate variables: \$\\frac{dy}{y} = $(k)dx\$",
                "Integrate both sides: \$\\ln|y| = $(k)x + C\$",
                sol("General solution", "y = Ce^{$(k)x}"),
            ),
            time=90,
            answer_type="expression",
        )
        
    elseif problem_type == 2
        # dy/dx + P(x)y = 0 form (800-1000 ELO)
        p = nonzero(-6, 6)
        
        problem(
            question="Solve the differential equation: \$\\frac{dy}{dx} + $(p)y = 0\$",
            answer="y = Ce^($(-p)x)",
            difficulty=(800, 1000),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} + $(p)y = 0"),
                "Rewrite as: \$\\frac{dy}{dx} = $(-p)y\$",
                "Separate and integrate: \$\\ln|y| = $(-p)x + C\$",
                sol("General solution", "y = Ce^{$(-p)x}"),
            ),
            time=100,
            answer_type="expression",
        )
        
    elseif problem_type == 3
        # First order linear with constant coefficients dy/dx + ay = b (900-1100 ELO)
        a = nonzero(-5, 5)
        b = nonzero(-12, 12)
        particular = b // (-a)
        
        problem(
            question="Find the general solution: \$\\frac{dy}{dx} + $(a)y = $(b)\$",
            answer="y = Ce^($(-a)x) + $(particular)",
            difficulty=(900, 1100),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} + $(a)y = $(b)"),
                "Homogeneous solution: \$y_h = Ce^{$(-a)x}\$",
                "Particular solution (constant): \$y_p = $(particular)\$",
                sol("General solution", "y = Ce^{$(-a)x} + $(particular)"),
            ),
            time=120,
            answer_type="expression",
        )
        
    else
        # Initial value problem dy/dx = ky, y(0) = y0 (1000-1200 ELO)
        k = nonzero(-6, 6)
        y0 = nonzero(-10, 10)
        
        problem(
            question="Solve the initial value problem: \$\\frac{dy}{dx} = $(k)y\$, \$y(0) = $(y0)\$",
            answer="y = $(y0)e^($(k)x)",
            difficulty=(1000, 1200),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(k)y, \\quad y(0) = $(y0)"),
                "General solution: \$y = Ce^{$(k)x}\$",
                "Apply initial condition: \$$(y0) = Ce^{0} = C\$",
                sol("Particular solution", "y = $(y0)e^{$(k)x}"),
            ),
            time=120,
            answer_type="expression",
        )
    end
end