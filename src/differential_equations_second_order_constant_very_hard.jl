# differential_equations - second_order_constant (very_hard)
# Generated: 2026-03-08T20:53:29.329723

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("differential_equations/second_order_constant")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Characteristic equation with complex roots - challenging parameter
        a = nonzero(-5, 5)
        b = randint(10, 30)
        
        # Characteristic: r^2 + 2ar + (a^2 + b^2) = 0
        # Roots: -a ± bi (complex conjugates)
        discriminant = -b^2
        
        α = -a
        β = b
        
        # General solution: y = e^(αx)[C₁cos(βx) + C₂sin(βx)]
        
        question_text = "Solve the second-order linear differential equation with constant coefficients:\n\$\$\\frac{d^2y}{dx^2} + $(2*a)\\frac{dy}{dx} + $(a^2 + b^2)y = 0\$\$"
        
        if a == 0
            answer_text = "y = C₁cos($(β)x) + C₂sin($(β)x)"
        else
            answer_text = "y = e^{$(α)x}[C₁cos($(β)x) + C₂sin($(β)x)]"
        end
        
        solution_text = steps(
            "Write the characteristic equation: \$r^2 + $(2*a)r + $(a^2 + b^2) = 0\$",
            "Use quadratic formula: \$r = \\frac{-$(2*a) \\pm \\sqrt{$(4*a^2) - $(4*(a^2 + b^2))}}{2} = $(α) \\pm $(β)i\$",
            "For complex roots \$r = α \\pm βi\$, the general solution is \$y = e^{αx}[C_1\\cos(βx) + C_2\\sin(βx)]\$",
            "Answer: \$$(answer_text)\$"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2500, 3000),
            solution=solution_text,
            time=240,
            answer_type="text"
        )
        
    elseif problem_type == 2
        # Repeated roots with initial conditions - olympiad level
        r = nonzero(-8, 8)
        y0 = randint(-15, 15)
        dy0 = randint(-20, 20)
        
        # Characteristic: (r - r)^2 = 0, so r^2 - 2r*r + r^2 = 0
        # DE: y'' - 2ry' + r^2*y = 0
        
        c1 = y0
        c2 = dy0 - r*y0
        
        question_text = "Solve the initial value problem:\n\$\$\\frac{d^2y}{dx^2} - $(2*r)\\frac{dy}{dx} + $(r^2)y = 0\$\$\nwith \$y(0) = $(y0)\$ and \$y'(0) = $(dy0)\$"
        
        answer_text = "y = ($(c1) + $(c2)x)e^{$(r)x}"
        
        solution_text = steps(
            "Write characteristic equation: \$r^2 - $(2*r)r + $(r^2) = 0\$",
            "Factor: \$(r - $(r))^2 = 0\$, giving repeated root \$r = $(r)\$",
            "General solution for repeated roots: \$y = (C_1 + C_2x)e^{$(r)x}\$",
            "Apply \$y(0) = $(y0)\$: \$C_1 = $(c1)\$",
            "Compute \$y' = C_2e^{$(r)x} + $(r)(C_1 + C_2x)e^{$(r)x}\$",
            "Apply \$y'(0) = $(dy0)\$: \$C_2 + $(r)C_1 = $(dy0)\$, so \$C_2 = $(c2)\$",
            "Answer: \$$(answer_text)\$"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2800, 3300),
            solution=solution_text,
            time=300,
            answer_type="text"
        )
        
    elseif problem_type == 3
        # Two distinct real roots - competition level eigenvalue approach
        r1 = nonzero(-10, 10)
        r2 = nonzero(-10, 10)
        while r2 == r1
            r2 = nonzero(-10, 10)
        end
        
        # Characteristic: (r - r1)(r - r2) = 0
        # r^2 - (r1+r2)r + r1*r2 = 0
        
        b_coeff = -(r1 + r2)
        c_coeff = r1 * r2
        
        question_text = "Find the general solution to:\n\$\$\\frac{d^2y}{dx^2} + $(b_coeff)\\frac{dy}{dx} + $(c_coeff)y = 0\$\$"
        
        if r1 > r2
            answer_text = "y = C₁e^{$(r1)x} + C₂e^{$(r2)x}"
        else
            answer_text = "y = C₁e^{$(r2)x} + C₂e^{$(r1)x}"
        end
        
        solution_text = steps(
            "Write characteristic equation: \$r^2 + $(b_coeff)r + $(c_coeff) = 0\$",
            "Factor: \$(r - $(r1))(r - $(r2)) = 0\$",
            "Roots: \$r_1 = $(r1), r_2 = $(r2)\$",
            "For distinct real roots, general solution: \$y = C_1e^{r_1x} + C_2e^{r_2x}\$",
            "Answer: \$$(answer_text)\$"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(2400, 2800),
            solution=solution_text,
            time=180,
            answer_type="text"
        )
        
    else
        # Boundary value problem with eigenvalue flavor - olympiad
        L = randint(2, 6)
        n = randint(1, 4)
        
        # y'' + λy = 0 with y(0) = 0, y(L) = 0
        # Solution exists for λ = (nπ/L)^2
        
        λ = (n * π / L)^2
        ω = n * π / L
        
        question_text = "Consider the boundary value problem:\n\$\$\\frac{d^2y}{dx^2} + \\lambda y = 0\$\$\nwith \$y(0) = 0\$ and \$y($(L)) = 0\$.\n\nFind the smallest positive eigenvalue \$\\lambda\$ and the corresponding eigenfunction (up to a constant multiple)."
        
        answer_text = "λ = (π/$(L))², y = sin(πx/$(L))"
        
        solution_text = steps(
            "Characteristic equation: \$r^2 + \\lambda = 0\$ gives \$r = \\pm i\\sqrt{\\lambda}\$",
            "For \$\\lambda > 0\$: \$y = A\\cos(\\sqrt{\\lambda}x) + B\\sin(\\sqrt{\\lambda}x)\$",
            "Boundary \$y(0) = 0\$: \$A = 0\$, so \$y = B\\sin(\\sqrt{\\lambda}x)\$",
            "Boundary \$y($(L)) = 0\$: \$B\\sin(\\sqrt{\\lambda} \\cdot $(L)) = 0\$",
            "Non-trivial solution requires \$\\sqrt{\\lambda} \\cdot $(L) = n\\pi\$ for integer \$n \\geq 1\$",
            "Eigenvalues: \$\\lambda_n = \\left(\\frac{n\\pi}{$(L)}\\right)^2\$",
            "Smallest positive: \$\\lambda_1 = \\left(\\frac{\\pi}{$(L)}\\right)^2\$",
            "Eigenfunction: \$y = \\sin\\left(\\frac{\\pi x}{$(L)}\\right)\$"
        )
        
        problem(
            question=question_text,
            answer=answer_text,
            difficulty=(3000, 3500),
            solution=solution_text,
            time=360,
            answer_type="text"
        )
    end
end