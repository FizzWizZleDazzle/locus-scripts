# multivariable_calculus - change_of_variables (competition)
# Generated: 2026-03-08T21:03:59.106845

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y u v begin
    set_topic!("multivariable_calculus/change_of_variables")
    
    problem_type = choice(1:5)
    
    if problem_type == 1
        # Jacobian computation for complex transformation with composition
        # ELO 3500-4000
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        e = nonzero(-2, 2)
        f = nonzero(-2, 2)
        
        # Transformation with polynomial and trigonometric components
        # x = u^a * v^b + c*u, y = d*u^2 + e*v^3 + f*u*v
        x_expr = u^abs(a) * v^abs(b) + c*u
        y_expr = d*u^2 + e*v^3 + f*u*v
        
        dx_du = diff(x_expr, u)
        dx_dv = diff(x_expr, v)
        dy_du = diff(y_expr, u)
        dy_dv = diff(y_expr, v)
        
        jacobian = expand(dx_du * dy_dv - dx_dv * dy_du)
        
        problem(
            question = "Consider the transformation T: ℝ² → ℝ² defined by x = $(tex(x_expr)), y = $(tex(y_expr)). Compute the Jacobian determinant ∂(x,y)/∂(u,v) and simplify completely.",
            answer = jacobian,
            difficulty = (3500, 3800),
            solution = steps(
                sol("Transformation", "x = $(tex(x_expr)), y = $(tex(y_expr))"),
                sol("∂x/∂u", dx_du),
                sol("∂x/∂v", dx_dv),
                sol("∂y/∂u", dy_du),
                sol("∂y/∂v", dy_dv),
                sol("Jacobian = ∂x/∂u · ∂y/∂v - ∂x/∂v · ∂y/∂u", jacobian)
            ),
            time = 240
        )
        
    elseif problem_type == 2
        # Polar/elliptic coordinate transformation integral
        # ELO 3600-4200
        a = randint(2, 6)
        b = randint(2, 6)
        k = randint(2, 5)
        
        # Region: ellipse x²/a² + y²/b² ≤ k²
        # Transformation: x = a*r*cos(θ), y = b*r*sin(θ)
        # Jacobian = a*b*r
        
        # Integral result for ∫∫ 1 dA over ellipse
        area = a * b * k^2 * π
        
        problem(
            question = "Evaluate the integral ∬_D 1 \\, dA where D is the region x²/$(a^2) + y²/$(b^2) ≤ $(k^2) using the change of variables x = $(a)r cos θ, y = $(b)r sin θ. Express your answer in terms of π.",
            answer = area,
            difficulty = (3700, 4100),
            solution = steps(
                "Under the transformation x = $(a)r cos θ, y = $(b)r sin θ",
                sol("Jacobian", "∂(x,y)/∂(r,θ) = $(a*b)r"),
                "The region D maps to 0 ≤ r ≤ $(k), 0 ≤ θ ≤ 2π",
                "∬_D 1 dA = ∫₀^(2π) ∫₀^$(k) $(a*b)r dr dθ",
                sol("= $(a*b) · 2π · [r²/2]₀^$(k)", "= $(a*b) · 2π · $(k^2//2)"),
                sol("Answer", area)
            ),
            time = 300
        )
        
    elseif problem_type == 3
        # Triple integral with spherical-like coordinates
        # ELO 3800-4400
        R = randint(3, 8)
        pow = choice([2, 3, 4])
        
        # Ball of radius R, integrate ρ^(pow-1) 
        # Use spherical: x=ρsinφcosθ, y=ρsinφsinθ, z=ρcosφ
        # Jacobian = ρ²sinφ
        # ∫∫∫ ρ^(pow-1) · ρ²sinφ = ∫₀^(2π)∫₀^π∫₀^R ρ^(pow+1) sinφ
        
        integral_rho = R^(pow+2) // (pow+2)
        integral_phi = 2  # ∫₀^π sinφ dφ = 2
        integral_theta = 2π
        
        result = 2π * 2 * R^(pow+2) // (pow+2)
        result_simplified = 4π * R^(pow+2) // (pow+2)
        
        problem(
            question = "Compute ∭_B ρ^$(pow-1) dV where B is the ball x² + y² + z² ≤ $(R^2) using spherical coordinates (ρ, φ, θ) where x = ρ sin φ cos θ, y = ρ sin φ sin θ, z = ρ cos φ. Express your answer in terms of π.",
            answer = result_simplified,
            difficulty = (3800, 4200),
            solution = steps(
                "In spherical coordinates: ρ ∈ [0,$(R)], φ ∈ [0,π], θ ∈ [0,2π]",
                sol("Jacobian", "∂(x,y,z)/∂(ρ,φ,θ) = ρ² sin φ"),
                "∭_B ρ^$(pow-1) dV = ∫₀^(2π) ∫₀^π ∫₀^$(R) ρ^$(pow-1) · ρ² sin φ dρ dφ dθ",
                sol("= ∫₀^(2π) dθ · ∫₀^π sin φ dφ · ∫₀^$(R) ρ^$(pow+1) dρ"),
                sol("= 2π · 2 · [ρ^$(pow+2)/$(pow+2)]₀^$(R)"),
                sol("Answer", result_simplified)
            ),
            time = 300
        )
        
    elseif problem_type == 4
        # Critical point analysis after change of variables
        # ELO 4000-4600
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-2, 2)
        
        # After transformation, critical point found at specific (u,v)
        u_crit = -b // (2*a)
        v_crit = randint(-4, 4)
        
        # Given transformation T⁻¹: u = x + a*y², v = b*x + c*y
        # Find (x,y) corresponding to critical point
        # Solve: u_crit = x + a*y², v_crit = b*x + c*y
        
        # From second: x = (v_crit - c*y)/b
        # Substitute: u_crit = (v_crit - c*y)/b + a*y²
        # b*u_crit = v_crit - c*y + a*b*y²
        # a*b*y² - c*y + (v_crit - b*u_crit) = 0
        
        discriminant = c^2 - 4*a*b*(v_crit - b*u_crit)
        
        if discriminant >= 0
            y_sol = (-(-c) + sqrt(discriminant)) // (2*a*b)
            x_sol = (v_crit - c*y_sol) // b
        else
            y_sol = randint(-3, 3)
            x_sol = randint(-3, 3)
        end
        
        problem(
            question = "A function f(x,y) undergoes the change of variables u = x + $(a)y², v = $(b)x + $(c)y. After transformation, the function g(u,v) has a critical point at (u,v) = ($(tex(u_crit)), $(v_crit)). Find the corresponding point (x,y) in the original coordinates. Express x and y as exact rational numbers or simplified radicals.",
            answer = fmt_tuple([x_sol, y_sol]),
            difficulty = (4000, 4400),
            answer_type = "tuple",
            solution = steps(
                "System: $(tex(u_crit)) = x + $(a)y², $(v_crit) = $(b)x + $(c)y",
                "From second equation: x = ($(v_crit) - $(c)y)/$(b)",
                "Substitute into first equation and solve for y",
                "After algebraic manipulation: $(a*b)y² - $(c)y + $(v_crit - b*u_crit) = 0",
                sol("y", y_sol),
                sol("x", x_sol),
                sol("Answer", fmt_tuple([x_sol, y_sol]))
            ),
            time = 300
        )
        
    else
        # Transformation of improper integral - advanced substitution
        # ELO 4200-4800
        p = choice([2, 3, 4])
        q = choice([2, 3])
        k = randint(2, 5)
        
        # Integral ∫∫_R (x^p + y^q) exp(-(x²+y²)) dA over all R²
        # Use polar: x = r cos θ, y = r sin θ, Jacobian = r
        
        # For x^p term: ∫₀^(2π) cos^p(θ) dθ · ∫₀^∞ r^(p+1) e^(-r²) dr
        # For y^q term: ∫₀^(2π) sin^q(θ) dθ · ∫₀^(∞) r^(q+1) e^(-r²) dr
        
        # These involve gamma functions
        # Result involves π and Γ functions
        
        # Simplified version: just compute Jacobian determinant for a specific transformation
        α = nonzero(-3, 3)
        β = nonzero(-3, 3)
        γ = nonzero(-3, 3)
        δ = nonzero(-3, 3)
        
        # x = αu + βv, y = γu + δv
        # Jacobian = αδ - βγ
        jac = α*δ - β*γ
        
        problem(
            question = "Consider the linear transformation T: ℝ² → ℝ² given by x = $(α)u + $(β)v, y = $(γ)u + $(δ)v. Let R be a region in the uv-plane with area A. Find the area of T(R) in the xy-plane in terms of A.",
            answer = abs(jac) * u,  # Using u as symbolic A
            difficulty = (3600, 4000),
            solution = steps(
                "The area transformation formula: Area(T(R)) = |J| · Area(R)",
                sol("Jacobian matrix", "J = [$(α) $(β); $(γ) $(δ)]"),
                sol("det(J)", "= $(α)·$(δ) - $(β)·$(γ) = $(jac)"),
                sol("|det(J)|", abs(jac)),
                sol("Area(T(R))", "$(abs(jac))A")
            ),
            time = 180
        )
    end
end