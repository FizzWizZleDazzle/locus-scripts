# differential_equations - separable_equations (competition)
# Generated: 2026-03-08T20:50:29.688949

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/separable_equations")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad-level: Separable DE with unusual substitution/transformation
        # dy/dx = (ax^n + by^m)/(cy^k), requires clever separation
        
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        n = rand(2:5)
        m = rand(2:5)
        k = rand(2:5)
        
        # Construct: y^k dy = (ax^n + by^m)/c dx
        # This separates only if the cross term can be eliminated
        # Use special case: dy/dx = (x^n)/(y^k) for clean separation
        
        n_exp = rand(2:6)
        k_exp = rand(2:6)
        coeff = nonzero(-12, 12)
        
        # dy/dx = (coeff * x^n)/(y^k)
        # y^k dy = coeff * x^n dx
        # y^(k+1)/(k+1) = coeff * x^(n+1)/(n+1) + C
        
        initial_x = nonzero(-5, 5)
        initial_y = nonzero(-5, 5)
        
        # C = y0^(k+1)/(k+1) - coeff * x0^(n+1)/(n+1)
        C_num = initial_y^(k_exp+1) * (n_exp+1) - coeff * initial_x^(n_exp+1) * (k_exp+1)
        C_denom = (k_exp+1) * (n_exp+1)
        
        difficulty_val = 3500 + rand(0:500)
        
        problem(
            question="Solve the initial value problem: \$\\frac{dy}{dx} = \\frac{$(coeff)x^{$(n_exp)}}{y^{$(k_exp)}}\$ with \$y($(initial_x)) = $(initial_y)\$. Express your answer implicitly in the form \$F(x,y) = 0\$ where \$F\$ is a polynomial.",
            answer="y^$(k_exp+1) * $(n_exp+1) - $(coeff * (k_exp+1)) * x^$(n_exp+1) - $(C_num)",
            difficulty=difficulty_val,
            solution=steps(
                "Given: \$\\frac{dy}{dx} = \\frac{$(coeff)x^{$(n_exp)}}{y^{$(k_exp)}}\$",
                "Separate variables: \$y^{$(k_exp)} dy = $(coeff)x^{$(n_exp)} dx\$",
                "Integrate both sides: \$\\frac{y^{$(k_exp+1)}}{$(k_exp+1)} = \\frac{$(coeff)x^{$(n_exp+1)}}{$(n_exp+1)} + C\$",
                "Apply initial condition \$y($(initial_x)) = $(initial_y)\$: \$\\frac{$(initial_y)^{$(k_exp+1)}}{$(k_exp+1)} = \\frac{$(coeff) \\cdot $(initial_x)^{$(n_exp+1)}}{$(n_exp+1)} + C\$",
                "Solve for \$C\$: \$C = \\frac{$(C_num)}{$(C_denom)}\$",
                "Multiply through by \$$(k_exp+1) \\cdot $(n_exp+1)\$ to clear denominators",
                sol("Implicit solution", "y^$(k_exp+1) \\cdot $(n_exp+1) - $(coeff * (k_exp+1))x^$(n_exp+1) = $(C_num)")
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Separable DE requiring advanced integration techniques
        # dy/dx = f(x)g(y) where integration requires partial fractions or trig substitution
        
        # Use form: dy/dx = x^n / (y(y^2 + a^2))
        n_val = rand(1:4)
        a_sq = rand([1, 4, 9, 16, 25])
        
        x0 = rand(1:3)
        y0 = rand(2:5)
        
        difficulty_val = 4000 + rand(0:800)
        
        problem(
            question="Solve the differential equation \$\\frac{dy}{dx} = \\frac{x^{$(n_val)}}{y(y^2 + $(a_sq))}\$ with initial condition \$y($(x0)) = $(y0)\$. This requires partial fraction decomposition on the left-hand side after separation. Express the implicit solution.",
            answer="ln|y| - (1/$(2*a_sq)) * ln(y^2 + $(a_sq)) = x^$(n_val+1)/$(n_val+1) + C",
            difficulty=difficulty_val,
            solution=steps(
                "Separate variables: \$\\frac{y(y^2 + $(a_sq))}{y} dy = x^{$(n_val)} dx\$",
                "Simplify: \$(y^2 + $(a_sq)) dy = x^{$(n_val)} dx\$",
                "Wait, reconsider: \$\\frac{y dy}{y^2 + $(a_sq)} + \\frac{dy}{y} = \\frac{x^{$(n_val)} dx}{1}\$ is incorrect.",
                "Correct separation: \$\\frac{dy}{y(y^2 + $(a_sq))} = x^{$(n_val)} dx\$",
                "Use partial fractions: \$\\frac{1}{y(y^2+$(a_sq))} = \\frac{A}{y} + \\frac{By+C}{y^2+$(a_sq)}\$",
                "Solving: \$A = \\frac{1}{$(a_sq)}\$, \$B = -\\frac{1}{$(a_sq)}\$, \$C = 0\$",
                "Integrate: \$\\frac{1}{$(a_sq)}\\ln|y| - \\frac{1}{$(2*a_sq)}\\ln(y^2+$(a_sq)) = \\frac{x^{$(n_val+1)}}{$(n_val+1)} + C\$",
                "Apply initial condition to find \$C\$ and obtain implicit solution"
            ),
            time=360
        )
        
    elseif problem_type == 3
        # Olympiad: Homogeneous equation disguised as separable
        # dy/dx = (x + y)/(x - y), use substitution v = y/x
        
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        d = nonzero(-8, 8)
        
        # Ensure not parallel (ad - bc ≠ 0)
        while a*d == b*c
            d = nonzero(-8, 8)
        end
        
        x0 = nonzero(1, 5)
        y0 = nonzero(1, 5)
        
        difficulty_val = 3700 + rand(0:700)
        
        problem(
            question="Solve the differential equation \$\\frac{dy}{dx} = \\frac{$(a)x + $(b)y}{$(c)x + $(d)y}\$ with \$y($(x0)) = $(y0)\$. Note: This is a homogeneous equation. Use the substitution \$v = y/x\$.",
            answer="implicit_solution",
            difficulty=difficulty_val,
            solution=steps(
                "Recognize this as homogeneous: degree 1 in both numerator and denominator",
                "Substitute \$v = y/x\$, so \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
                "Rewrite: \$v + x\\frac{dv}{dx} = \\frac{$(a) + $(b)v}{$(c) + $(d)v}\$",
                "Isolate: \$x\\frac{dv}{dx} = \\frac{$(a) + $(b)v}{$(c) + $(d)v} - v = \\frac{$(a) + $(b)v - $(c)v - $(d)v^2}{$(c) + $(d)v}\$",
                "Separate: \$\\frac{$(c) + $(d)v}{$(a) + $(b-c)v - $(d)v^2} dv = \\frac{dx}{x}\$",
                "Integrate both sides (may require partial fractions on left)",
                "Back-substitute \$v = y/x\$ and apply initial condition \$y($(x0)) = $(y0)\$"
            ),
            time=360
        )
        
    else
        # Research-adjacent: Separable with transcendental solution
        # dy/dx = y * ln(x) / x, requires understanding of logarithmic integration
        
        base = rand(2:5)
        k = nonzero(-6, 6)
        
        x0 = rand(2:8)
        y0 = nonzero(-10, 10)
        
        # dy/y = k * ln(x)/x dx
        # ln|y| = k * (ln(x))^2 / 2 + C
        # |y| = exp(k * (ln(x))^2 / 2 + C)
        
        C_val = round(log(abs(y0)) - k * (log(x0))^2 / 2, digits=4)
        
        difficulty_val = 4200 + rand(0:600)
        
        problem(
            question="Solve the separable differential equation \$\\frac{dy}{dx} = \\frac{$(k) y \\ln(x)}{x}\$ with initial condition \$y($(x0)) = $(y0)\$. Express the solution in the form \$y = f(x)\$.",
            answer="$(y0) * exp($(k/2) * (ln(x)^2 - ln($(x0))^2))",
            difficulty=difficulty_val,
            solution=steps(
                "Separate variables: \$\\frac{dy}{y} = \\frac{$(k)\\ln(x)}{x} dx\$",
                "Let \$u = \\ln(x)\$, then \$du = \\frac{1}{x} dx\$",
                "Integral becomes: \$\\int \\frac{dy}{y} = $(k) \\int u \\, du\$",
                "Integrate: \$\\ln|y| = \\frac{$(k)u^2}{2} + C = \\frac{$(k)(\\ln x)^2}{2} + C\$",
                "Exponentiate: \$y = A e^{\\frac{$(k)(\\ln x)^2}{2}}\$ where \$A = e^C\$",
                "Apply \$y($(x0)) = $(y0)\$: \$$(y0) = A e^{\\frac{$(k)(\\ln $(x0))^2}{2}}\$",
                "Solve for \$A\$: \$A = $(y0) e^{-\\frac{$(k)(\\ln $(x0))^2}{2}}\$",
                sol("Solution", "y = $(y0) \\exp\\left(\\frac{$(k)}{2}\\left[(\\ln x)^2 - (\\ln $(x0))^2\\right]\\right)")
            ),
            time=300
        )
    end
end