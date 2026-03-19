# differential_equations - first_order_linear (competition)
# Generated: 2026-03-08T20:52:08.860848

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/first_order_linear")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Bernoulli equation with exotic substitution
        n = rand([3, 4, 5, 6])
        a = nonzero(-8, 8)
        b = nonzero(-12, 12)
        c = nonzero(-15, 15)
        
        # dy/dx + P(x)y = Q(x)y^n form
        P_coeff = a
        Q_coeff = b
        
        # Solution involves v = y^(1-n)
        v_power = 1 - n
        transformed_eq = "v' + $(P_coeff * v_power) v = $(Q_coeff * v_power)"
        
        question = "Solve the Bernoulli equation: \\frac{dy}{dx} + $(a)y = $(b)y^{$(n)}"
        answer = "y = \\left[\\frac{$(Q_coeff * v_power)}{$(P_coeff * v_power)} + Ce^{$(P_coeff * v_power)x}\\right]^{\\frac{1}{$(v_power)}}"
        
        sol_steps = steps(
            sol("Given Bernoulli equation", "\\frac{dy}{dx} + $(a)y = $(b)y^{$(n)}"),
            "Substitute v = y^{$(1-n)}, then \\frac{dv}{dx} = $(1-n)y^{$(−n)}\\frac{dy}{dx}",
            "Transform to linear: \\frac{dv}{dx} + $(P_coeff * v_power)v = $(Q_coeff * v_power)",
            "Integrating factor: \\mu = e^{$(P_coeff * v_power)x}",
            "General solution for v: v = \\frac{$(Q_coeff * v_power)}{$(P_coeff * v_power)} + Ce^{$(P_coeff * v_power)x}",
            sol("Back-substitute", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3500, 3900),
            solution=sol_steps,
            time=420,
            answer_type="expression"
        )
        
    elseif problem_type == 2
        # Riccati equation reduction via known particular solution
        a = nonzero(-6, 6)
        b = nonzero(-8, 8)
        c = nonzero(-10, 10)
        y1_const = nonzero(-5, 5)
        
        # y' = a + by + cy^2, with y_1 = y1_const as particular solution
        question = "Given the Riccati equation \\frac{dy}{dx} = $(a) + $(b)y + $(c)y^2 with particular solution y_1 = $(y1_const), find the general solution using the substitution y = y_1 + \\frac{1}{v}."
        
        # After substitution, get linear ODE for v
        linear_coeff = b + 2*c*y1_const
        
        answer = "y = $(y1_const) + \\frac{1}{Ce^{$(linear_coeff)x} - \\frac{1}{$(c)}}"
        
        sol_steps = steps(
            sol("Given Riccati equation", "\\frac{dy}{dx} = $(a) + $(b)y + $(c)y^2"),
            "Known particular solution: y_1 = $(y1_const)",
            "Substitute y = $(y1_const) + \\frac{1}{v}, so \\frac{dy}{dx} = -\\frac{1}{v^2}\\frac{dv}{dx}",
            "After substitution and simplification: \\frac{dv}{dx} + $(linear_coeff)v = $(c)",
            "Solve linear ODE: v = \\frac{1}{$(c)} + Ce^{-$(linear_coeff)x}",
            sol("General solution", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(3800, 4200),
            solution=sol_steps,
            time=480,
            answer_type="expression"
        )
        
    elseif problem_type == 3
        # Singularity analysis and existence/uniqueness at boundary
        a = nonzero(-7, 7)
        b = nonzero(-9, 9)
        x0 = rand([-3, -2, -1, 0, 1, 2, 3])
        y0 = nonzero(-8, 8)
        
        # Equation with singularity: (x-x0)y' + ay = b/(x-x0)^2
        question = "Analyze the IVP: (x - $(x0))\\frac{dy}{dx} + $(a)y = \\frac{$(b)}{(x - $(x0))^2}, y($(x0 + 1)) = $(y0). Determine the interval of existence and describe the behavior near x = $(x0)."
        
        interval_ans = fmt_interval(x0, Inf, false, true)
        answer = "Interval: $(interval_ans); solution has logarithmic singularity at x = $(x0)"
        
        sol_steps = steps(
            sol("Standard form", "\\frac{dy}{dx} + \\frac{$(a)}{x - $(x0)}y = \\frac{$(b)}{(x - $(x0))^3}"),
            "Integrating factor: \\mu = (x - $(x0))^{$(a)}",
            "P(x) = \\frac{$(a)}{x - $(x0)} continuous on ($(x0), \\infty), Q(x) = \\frac{$(b)}{(x - $(x0))^3} has non-integrable singularity at x = $(x0)",
            "By Picard-Lindelöf theorem, unique solution exists on largest interval containing $(x0 + 1) avoiding singularity",
            "Interval of existence: $(interval_ans)",
            sol("Behavior", "Solution approaches singularity as x \\to $(x0)^+")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4000, 4400),
            solution=sol_steps,
            time=540,
            answer_type="expression"
        )
        
    else
        # Parametric variation with Abel's theorem
        alpha = nonzero(-5, 5)
        beta = nonzero(-6, 6)
        gamma = nonzero(-4, 4)
        
        # Consider y' + p(x)y = q(x) where p depends on parameter
        question = "Let y_\\lambda(x) be the solution to \\frac{dy}{dx} + ($(alpha) + \\lambda)y = $(beta)e^{$(gamma)x}, y(0) = 0. Find \\frac{\\partial y_\\lambda}{\\partial \\lambda}\\bigg|_{\\lambda=0} at x = 1."
        
        # Use variational equation
        at_lambda_0_coeff = alpha
        exp_part = gamma
        
        # Derivative of solution with respect to parameter
        integrand_term = -beta / (exp_part - at_lambda_0_coeff)
        
        answer = "\\frac{\\partial y_\\lambda}{\\partial \\lambda}\\bigg|_{\\lambda=0, x=1} = \\frac{$(beta)}{$(at_lambda_0_coeff - exp_part)^2}\\left(e^{$(exp_part)} - e^{$(at_lambda_0_coeff)}\\right)"
        
        sol_steps = steps(
            sol("Given parameterized ODE", "\\frac{dy}{dx} + ($(alpha) + \\lambda)y = $(beta)e^{$(gamma)x}"),
            "Differentiate both sides with respect to \\lambda: \\frac{\\partial}{\\partial \\lambda}\\frac{dy}{dx} + ($(alpha) + \\lambda)\\frac{\\partial y}{\\partial \\lambda} + y = 0",
            "Let v = \\frac{\\partial y}{\\partial \\lambda}. At \\lambda = 0: v' + $(alpha)v = -y_0(x)",
            "First solve for y_0: y_0(x) = \\frac{$(beta)}{$(exp_part - at_lambda_0_coeff)}(e^{$(exp_part)x} - e^{$(at_lambda_0_coeff)x})",
            "Solve variational equation for v using integrating factor e^{$(alpha)x}",
            sol("Evaluate at x = 1", answer)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(4200, 4800),
            solution=sol_steps,
            time=600,
            answer_type="expression"
        )
    end
end