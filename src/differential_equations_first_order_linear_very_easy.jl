# differential_equations - first_order_linear (very_easy)
# Generated: 2026-03-08T20:50:11.125850

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/first_order_linear")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Recognize standard form dy/dx + P(x)y = Q(x)
        # ELO: 200-400 (recognition)
        a = nonzero(-5, 5)
        b = randint(-8, 8)
        
        problem(
            question="Is the differential equation \$\\frac{dy}{dx} + $(a)y = $(b)\$ a first-order linear differential equation?",
            answer="Yes",
            difficulty=(200, 400),
            solution=steps(
                "A first-order linear DE has the form \$\\frac{dy}{dx} + P(x)y = Q(x)\$",
                "Here \$P(x) = $(a)\$ and \$Q(x) = $(b)\$",
                sol("Answer", "Yes, this is first-order linear")
            ),
            time=45,
            answer_type="text"
        )
        
    elseif problem_type == 2
        # Type 2: Identify P(x) and Q(x) in standard form
        # ELO: 400-600 (elementary identification)
        p_coef = nonzero(-6, 6)
        q_val = randint(-10, 10)
        
        problem(
            question="For the differential equation \$\\frac{dy}{dx} + $(p_coef)y = $(q_val)\$, identify the function \$P(x)\$ in the standard form \$\\frac{dy}{dx} + P(x)y = Q(x)\$.",
            answer=p_coef,
            difficulty=(400, 600),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} + $(p_coef)y = $(q_val)"),
                "Standard form is \$\\frac{dy}{dx} + P(x)y = Q(x)\$",
                "Comparing terms, \$P(x) = $(p_coef)\$",
                sol("Answer", p_coef)
            ),
            time=60
        )
        
    elseif problem_type == 3
        # Type 3: Solve dy/dx = k (simplest separable, constant)
        # ELO: 500-700 (elementary integration)
        k = nonzero(-8, 8)
        
        problem(
            question="Solve the differential equation \$\\frac{dy}{dx} = $(k)\$. Express your answer in the form \$y = f(x)\$ (include the constant of integration \$C\$).",
            answer="$(k)x + C",
            difficulty=(500, 700),
            solution=steps(
                sol("Given", "\\frac{dy}{dx} = $(k)"),
                "Integrate both sides with respect to \$x\$",
                sol("\\int dy", "\\int $(k) \\, dx"),
                sol("Answer", "y = $(k)x + C")
            ),
            time=75,
            answer_type="text"
        )
        
    else
        # Type 4: Verify a solution (substitute and check)
        # ELO: 600-700 (elementary verification)
        a = nonzero(-4, 4)
        c_val = randint(1, 9)
        
        # Solution will be y = C*e^(-ax)
        # Check: dy/dx = -aC*e^(-ax), so dy/dx + ay = 0
        
        problem(
            question="Verify that \$y = $(c_val)e^{$(a)x}\$ is a solution to \$\\frac{dy}{dx} - $(a)y = 0\$. What is \$\\frac{dy}{dx}\$ for this function?",
            answer="$(a * c_val)*e^($(a)*x)",
            difficulty=(600, 700),
            solution=steps(
                sol("Given", "y = $(c_val)e^{$(a)x}"),
                "Compute derivative: \$\\frac{dy}{dx} = $(a) \\cdot $(c_val)e^{$(a)x} = $(a * c_val)e^{$(a)x}\$",
                "Check: \$\\frac{dy}{dx} - $(a)y = $(a * c_val)e^{$(a)x} - $(a) \\cdot $(c_val)e^{$(a)x} = 0\$ ✓",
                sol("Answer", "$(a * c_val)e^{$(a)x}")
            ),
            time=90,
            answer_type="text"
        )
    end
end