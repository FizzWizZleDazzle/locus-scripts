# differential_equations - homogeneous_equations (very_hard)
# Generated: 2026-03-08T20:52:49.074203

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/homogeneous_equations")
    
    # Competition to Olympiad level homogeneous DE problems (2500-3500 ELO)
    # These require sophisticated techniques and deep understanding
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Type 1: Homogeneous DE with substitution y = vx leading to separable form
        # dy/dx = F(y/x) form with challenging rational functions
        
        # Create a homogeneous rational function F(y/x)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        # F(y/x) = (a(y/x)^2 + b(y/x)) / (c(y/x) + d)
        # Construct: dy/dx = (ay^2 + bxy) / (cy + dx)
        
        numerator = a*y^2 + b*x*y
        denominator = c*y + d*x
        
        question = "Solve the homogeneous differential equation: \$\\frac{dy}{dx} = \\frac{$(tex(numerator))}{$(tex(denominator))}\$"
        
        solution_text = steps(
            "Recognize this is a homogeneous equation of the form \$\\frac{dy}{dx} = F\\left(\\frac{y}{x}\\right)\$",
            "Substitute \$y = vx\$, so \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "The equation becomes: \$v + x\\frac{dv}{dx} = \\frac{av^2 + bv}{cv + d}\$",
            "Rearranging: \$x\\frac{dv}{dx} = \\frac{av^2 + bv}{cv + d} - v = \\frac{av^2 + bv - v(cv + d)}{cv + d}\$",
            "Simplify numerator: \$av^2 + bv - cv^2 - dv = (a-c)v^2 + (b-d)v\$",
            "Separate variables: \$\\frac{cv + d}{(a-c)v^2 + (b-d)v} dv = \\frac{dx}{x}\$",
            "Integrate both sides using partial fractions or substitution",
            "Back-substitute \$v = \\frac{y}{x}\$ to obtain the implicit solution",
            "The general solution involves logarithmic and rational terms in x and y"
        )
        
        answer = "implicit_solution"
        difficulty = (2600, 3200)
        time_limit = 300
        
    elseif problem_type == 2
        # Type 2: Bernoulli-type homogeneous equation requiring clever transformation
        
        p = rand(2:4)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        
        # x dy/dx = ay + bx(y/x)^p
        rhs = a*y + b*x*(y/x)^p
        
        question = "Solve the differential equation: \$x\\frac{dy}{dx} = $(tex(rhs))\$"
        
        solution_text = steps(
            "Divide both sides by x: \$\\frac{dy}{dx} = \\frac{$(tex(rhs))}{x}\$",
            "This is homogeneous. Let \$y = vx\$, so \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Substitute: \$v + x\\frac{dv}{dx} = av + bv^{$(p)}\$",
            "Rearrange: \$x\\frac{dv}{dx} = (a-1)v + bv^{$(p)}\$",
            "This is a Bernoulli equation in v. Use substitution \$w = v^{$(1-p)}\$ if \$p \\neq 1\$",
            "Separate variables: \$\\frac{dv}{(a-1)v + bv^{$(p)}} = \\frac{dx}{x}\$",
            "Integrate both sides (may require partial fractions or trigonometric substitution)",
            "Back-substitute \$v = \\frac{y}{x}\$ and solve for y in terms of x",
            "General solution: implicit form involving logarithmic and power terms"
        )
        
        answer = "implicit_solution"
        difficulty = (2700, 3400)
        time_limit = 360
        
    elseif problem_type == 3
        # Type 3: System requiring homogeneity recognition with polar substitution
        
        m = nonzero(-4, 4)
        n = nonzero(-4, 4)
        k = nonzero(-4, 4)
        
        # (mx^2 + ny^2) dx + kxy dy = 0
        M_expr = m*x^2 + n*y^2
        N_expr = k*x*y
        
        question = "Solve the exact/homogeneous differential equation: \$($(tex(M_expr)))dx + ($(tex(N_expr)))dy = 0\$"
        
        solution_text = steps(
            "Check if equation is exact: \$\\frac{\\partial M}{\\partial y} = $(2*n)y\$, \$\\frac{\\partial N}{\\partial x} = $(k)y\$",
            "If not exact, recognize the equation is homogeneous (both M and N are degree 2)",
            "Method 1: Use substitution \$y = vx\$, converting to separable form",
            "Method 2: Use polar coordinates \$x = r\\cos\\theta, y = r\\sin\\theta\$",
            "With \$y = vx\$: \$dy = vdx + xdv\$",
            "Substitute: \$($(m)x^2 + $(n)v^2x^2)dx + $(k)vx^2(vdx + xdv) = 0\$",
            "Collect terms and separate variables in v and x",
            "Integrate: \$\\int \\frac{dv}{f(v)} = -\\int \\frac{dx}{x}\$",
            "Back-substitute and apply initial condition if given",
            "General solution in implicit form"
        )
        
        answer = "implicit_solution"
        difficulty = (2800, 3500)
        time_limit = 360
        
    else
        # Type 4: Advanced homogeneous with trigonometric terms
        
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        # dy/dx = (y + x*tan(y/x)) / x or similar
        # Create: x dy - (y + a*x*sin(y/x)) dx = 0
        
        question = "Solve the homogeneous differential equation with trigonometric terms:\n\$x\\frac{dy}{dx} = y + $(a)x\\sin\\left(\\frac{y}{x}\\right) + $(b)x\\cos\\left(\\frac{y}{x}\\right)\$"
        
        solution_text = steps(
            "Recognize homogeneous form: RHS is a function of \$\\frac{y}{x}\$ only",
            "Let \$v = \\frac{y}{x}\$, so \$y = vx\$ and \$\\frac{dy}{dx} = v + x\\frac{dv}{dx}\$",
            "Substitute: \$v + x\\frac{dv}{dx} = v + $(a)\\sin(v) + $(b)\\cos(v)\$",
            "Simplify: \$x\\frac{dv}{dx} = $(a)\\sin(v) + $(b)\\cos(v)\$",
            "Separate variables: \$\\frac{dv}{$(a)\\sin(v) + $(b)\\cos(v)} = \\frac{dx}{x}\$",
            "Use Weierstrass substitution \$t = \\tan(v/2)\$ to rationalize the trigonometric integral",
            "Or rewrite: \$$(a)\\sin(v) + $(b)\\cos(v) = \\sqrt{$(a^2 + b^2)}\\sin(v + \\phi)\$ where \$\\tan\\phi = \\frac{$(b)}{$(a)}\$",
            "Integrate: \$\\int \\frac{dv}{\\sqrt{$(a^2 + b^2)}\\sin(v + \\phi)} = \\ln|x| + C\$",
            "The integral yields \$\\ln|\\csc(v+\\phi) - \\cot(v+\\phi)|\$ or similar",
            "Back-substitute \$v = \\frac{y}{x}\$ for the general solution"
        )
        
        answer = "implicit_solution"
        difficulty = (3000, 3600)
        time_limit = 420
    end
    
    problem(
        question=question,
        answer=answer,
        difficulty=difficulty,
        solution=solution_text,
        answer_type="text",
        grading_mode="expression",
        calculator="scientific",
        time=time_limit
    )
end