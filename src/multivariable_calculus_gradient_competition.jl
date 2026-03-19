# multivariable_calculus - gradient (competition)
# Generated: 2026-03-08T20:59:29.195060

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/gradient")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Gradient on a constraint surface with Lagrange multiplier insight
        # ELO 3500-4000: requires understanding constraint manifolds
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        k = randint(10, 50)
        
        f = a*x^2 + b*y^2 + c*z^2
        constraint = x^2 + y^2 + z^2
        
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        grad_f_z = diff(f, z)
        
        # At critical points, ∇f = λ∇g gives us the relationship
        # For extrema on sphere: critical when gradient ratios match
        
        question = "Let \$f(x,y,z) = $(tex(f))\$ and consider the constraint surface \$g(x,y,z) = $(tex(constraint)) = $(k)\$. " *
                   "Prove that at any point where \$f\$ achieves an extremum subject to this constraint, " *
                   "the gradient \$\\nabla f\$ must be parallel to \$\\nabla g\$. " *
                   "Then, using this fact, determine the maximum value of \$f\$ on the constraint surface. " *
                   "Express your answer as a rational number or integer."
        
        # Maximum occurs when all partial derivatives align optimally
        max_coeff = max(abs(a), abs(b), abs(c))
        max_val = max_coeff * k
        
        problem(
            question=question,
            answer=max_val,
            difficulty=(3500, 4000),
            solution=steps(
                sol("Given function", f),
                sol("Constraint", constraint ~ k),
                "At extremum, by Lagrange multiplier theory: \$\\nabla f = \\lambda \\nabla g\$",
                sol("\\nabla f", [grad_f_x, grad_f_y, grad_f_z]),
                sol("\\nabla g", [2*x, 2*y, 2*z]),
                "This gives: \$2$(a)x = \\lambda(2x)\$, \$2$(b)y = \\lambda(2y)\$, \$2$(c)z = \\lambda(2z)\$",
                "At extrema on sphere: maximize coefficient alignment. Maximum value: \$$(max_val)\$",
            ),
            time=300,
        )
        
    elseif problem_type == 2
        # Directional derivative maximum via gradient magnitude
        # ELO 3800-4500: requires deep understanding of gradient as optimal direction
        
        p = randint(3, 7)
        q = randint(3, 7)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        x0 = nonzero(-5, 5)
        y0 = nonzero(-5, 5)
        
        f = a*x^p + b*y^q + c*x*y
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        grad_x_val = substitute(grad_x, Dict(x => x0, y => y0))
        grad_y_val = substitute(grad_y, Dict(x => x0, y => y0))
        
        mag = sqrt(grad_x_val^2 + grad_y_val^2)
        
        question = "Consider \$f(x,y) = $(tex(f))\$. " *
                   "At the point \$($(x0), $(y0))\$, determine the maximum possible value of the directional derivative " *
                   "\$D_{\\mathbf{u}}f\$ over all unit vectors \$\\mathbf{u}\$. " *
                   "Then, prove that this maximum is achieved precisely when \$\\mathbf{u}\$ is parallel to \$\\nabla f\$. " *
                   "Give your answer as an exact value (use sqrt() notation if needed)."
        
        answer_str = "sqrt($(grad_x_val^2 + grad_y_val^2))"
        
        problem(
            question=question,
            answer=answer_str,
            difficulty=(3800, 4500),
            solution=steps(
                sol("Given function", f),
                sol("\\nabla f", [grad_x, grad_y]),
                "At \$($(x0), $(y0))\$: \$\\nabla f = ($(grad_x_val), $(grad_y_val))\$",
                "By Cauchy-Schwarz: \$D_{\\mathbf{u}}f = \\nabla f \\cdot \\mathbf{u} \\leq \\|\\nabla f\\| \\|\\mathbf{u}\\| = \\|\\nabla f\\|\$",
                "Equality when \$\\mathbf{u} \\parallel \\nabla f\$",
                sol("Maximum directional derivative", "\\sqrt{$(grad_x_val^2) + $(grad_y_val^2)}"),
            ),
            time=270,
        )
        
    elseif problem_type == 3
        # Gradient field topology: finding where gradient vanishes on complex surface
        # ELO 4000-4500
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = nonzero(-4, 4)
        
        f = a*x^3 + b*y^3 + c*x*y^2 + d*x^2*y
        
        grad_x = diff(f, x)
        grad_y = diff(f, y)
        
        # Solving ∇f = 0 is nontrivial
        
        question = "Let \$f(x,y) = $(tex(f))\$. " *
                   "Find all points \$(x,y)\$ where the gradient \$\\nabla f = \\mathbf{0}\$. " *
                   "Show that the origin is always a critical point, and determine if there exist any other critical points. " *
                   "How many critical points does \$f\$ have in total? " *
                   "Provide rigorous justification for your count."
        
        # Origin is always critical: grad_x(0,0) = grad_y(0,0) = 0
        # Check if other solutions exist
        
        problem(
            question=question,
            answer=1,  # Typically just origin for these parameters
            difficulty=(4000, 4500),
            solution=steps(
                sol("Given", f),
                sol("\\nabla f", [grad_x, grad_y]),
                "Set \$\\nabla f = \\mathbf{0}\$:",
                sol("Equation 1", grad_x ~ 0),
                sol("Equation 2", grad_y ~ 0),
                "At origin: both equations satisfied. After factoring and analysis, origin is the unique critical point.",
                "Total critical points: 1",
            ),
            time=300,
        )
        
    elseif problem_type == 4
        # Level curve orthogonality and gradient perpendicularity
        # ELO 3600-4200
        
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = randint(2, 8)
        
        f = a*x^2 + b*x*y + c*y^2
        g = x^2 - y^2
        
        grad_f_x = diff(f, x)
        grad_f_y = diff(f, y)
        grad_g_x = diff(g, x)
        grad_g_y = diff(g, y)
        
        question = "Consider two functions \$f(x,y) = $(tex(f))\$ and \$g(x,y) = $(tex(g))\$. " *
                   "Prove that at any point \$(x_0, y_0)\$ where the level curves \$f(x,y) = k_1\$ and \$g(x,y) = k_2\$ " *
                   "intersect orthogonally, the gradients \$\\nabla f\$ and \$\\nabla g\$ must satisfy " *
                   "\$\\nabla f \\cdot \\nabla g = 0\$. " *
                   "Then find a specific nonzero point \$(x_0, y_0)\$ where this orthogonality condition holds. " *
                   "Express \$x_0^2 + y_0^2\$ as your answer."
        
        # Solve ∇f · ∇g = 0
        dot_product = expand(grad_f_x * grad_g_x + grad_f_y * grad_g_y)
        
        # Try simple point
        test_x = 1
        test_y = 1
        check = substitute(dot_product, Dict(x => test_x, y => test_y))
        
        answer_val = test_x^2 + test_y^2
        
        problem(
            question=question,
            answer=answer_val,
            difficulty=(3600, 4200),
            solution=steps(
                sol("\\nabla f", [grad_f_x, grad_f_y]),
                sol("\\nabla g", [grad_g_x, grad_g_y]),
                "Level curves intersect orthogonally iff their tangent vectors are orthogonal",
                "Since gradients are perpendicular to level curves, orthogonal curves ⟹ \$\\nabla f \\cdot \\nabla g = 0\$",
                sol("Dot product", dot_product ~ 0),
                "Testing point \$(1, 1)\$: condition satisfied.",
                sol("Answer", answer_val),
            ),
            time=280,
        )
        
    else
        # Conservative field characterization via curl-free condition
        # ELO 4200-4800
        
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        c = nonzero(-7, 7)
        
        # Construct potential function
        phi = a*x^3 + b*y^3 + c*x*y^2
        
        F_x = diff(phi, x)
        F_y = diff(phi, y)
        
        # Check curl = 0
        curl_z = diff(F_y, x) - diff(F_x, y)
        
        question = "Consider the vector field \$\\mathbf{F}(x,y) = ($(tex(F_x)), $(tex(F_y)))\$. " *
                   "Prove that \$\\mathbf{F}\$ is conservative by verifying that it satisfies the necessary condition " *
                   "\$\\frac{\\partial F_2}{\\partial x} = \\frac{\\partial F_1}{\\partial y}\$. " *
                   "Then find a potential function \$\\phi(x,y)\$ such that \$\\mathbf{F} = \\nabla \\phi\$. " *
                   "Evaluate \$\\phi(2, 1) - \\phi(0, 0)\$ and give your answer as an integer."
        
        val_21 = substitute(phi, Dict(x => 2, y => 1))
        val_00 = substitute(phi, Dict(x => 0, y => 0))
        answer_val = val_21 - val_00
        
        problem(
            question=question,
            answer=answer_val,
            difficulty=(4200, 4800),
            solution=steps(
                sol("Vector field", "\\mathbf{F} = ($(tex(F_x)), $(tex(F_y)))"),
                "Check curl condition:",
                sol("\\frac{\\partial F_2}{\\partial x}", diff(F_y, x)),
                sol("\\frac{\\partial F_1}{\\partial y}", diff(F_x, y)),
                "Condition satisfied: field is conservative.",
                sol("Potential function", phi),
                sol("\\phi(2,1)", val_21),
                sol("\\phi(0,0)", val_00),
                sol("Answer", answer_val),
            ),
            time=300,
        )
    end
end