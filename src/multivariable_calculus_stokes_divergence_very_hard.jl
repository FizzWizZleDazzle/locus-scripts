# multivariable_calculus - stokes_divergence (very_hard)
# Generated: 2026-03-08T21:06:45.162138

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/stokes_divergence")
    
    problem_type = choice([
        :stokes_verification,
        :divergence_theorem,
        :circulation_flux,
        :surface_independence,
        :conservative_field
    ])
    
    if problem_type == :stokes_verification
        # Stokes' theorem verification with parametric surface
        # Pick a vector field F and surface S, verify ∮_C F·dr = ∬_S (∇×F)·n dS
        
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        # Vector field F = <P, Q, R>
        P = a*y
        Q = b*x
        R = c*z^2
        
        # Use unit circle boundary in xy-plane at z=0
        # Curl of F
        curl_x = diff(R, y) - diff(Q, z)
        curl_y = diff(P, z) - diff(R, x)
        curl_z = diff(Q, x) - diff(P, y)
        
        # For disk z=0, x²+y²≤1, normal is <0,0,1>
        curl_dot_n = curl_z
        surface_integral = substitute(curl_dot_n, z => 0)
        # Integrate over unit disk
        surf_result = surface_integral * π  # ∬ (b-a) dA over unit disk = π(b-a)
        
        # Line integral around C: x=cos(t), y=sin(t), z=0
        line_result = simplify(surf_result)
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle and let S be the disk x^2+y^2 \\leq 1 in the plane z=0, oriented upward. Compute \\iint_S (\\nabla \\times \\mathbf{F}) \\cdot d\\mathbf{S}."
        
        answer = line_result
        
        solution = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle"),
            sol("Curl computation", "\\nabla \\times \\mathbf{F} = \\langle $(tex(curl_x)), $(tex(curl_y)), $(tex(curl_z)) \\rangle"),
            "On surface z=0, normal vector is \\mathbf{n} = \\langle 0, 0, 1 \\rangle",
            sol("Dot product", "(\\nabla \\times \\mathbf{F}) \\cdot \\mathbf{n} = $(tex(curl_z))"),
            "Evaluate at z=0: $(tex(substitute(curl_z, z => 0)))",
            "Integrate over unit disk: \\iint_S $(tex(substitute(curl_z, z => 0))) \\, dS = $(tex(substitute(curl_z, z => 0))) \\cdot \\pi",
            sol("Answer", line_result)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2600, 3200),
            solution=solution,
            time=240
        )
        
    elseif problem_type == :divergence_theorem
        # Divergence theorem with specific region
        
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        # Vector field F = <ax², by², cz²>
        P = a*x^2
        Q = b*y^2
        R = c*z^2
        
        # Divergence
        div_F = diff(P, x) + diff(Q, y) + diff(R, z)
        div_simplified = simplify(div_F)
        
        # Region: sphere of radius r
        r = randint(2, 5)
        
        # Volume of sphere: 4πr³/3
        # Integral of (2ax + 2by + 2cz) over sphere
        # By symmetry, ∭ x dV = ∭ y dV = ∭ z dV = 0
        # So result is 2(a+b+c) times 0, but we have constant terms
        
        # Actually div_F = 2ax + 2by + 2cz
        # Over symmetric region, linear terms integrate to 0
        
        # Use cube instead for cleaner calculation
        L = randint(2, 4)
        volume = (2*L)^3
        
        # If divergence is constant or has symmetric terms
        # For F = <ax², by², cz²>, div = 2ax + 2by + 2cz
        # Over [-L,L]³, by symmetry this is 0
        
        flux_result = 0
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle. Use the Divergence Theorem to compute the outward flux of \\mathbf{F} through the boundary of the cube [-$(L), $(L)]^3."
        
        answer = flux_result
        
        solution = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle"),
            sol("Divergence", "\\nabla \\cdot \\mathbf{F} = $(tex(div_simplified))"),
            "By Divergence Theorem: \\iint_S \\mathbf{F} \\cdot d\\mathbf{S} = \\iiint_E (\\nabla \\cdot \\mathbf{F}) \\, dV",
            "Divergence is $(tex(div_simplified)) = $(tex(2*a))*x + $(tex(2*b))*y + $(tex(2*c))*z",
            "Over the symmetric region [-$(L), $(L)]^3, each linear term integrates to 0",
            sol("Answer", flux_result)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2700, 3300),
            solution=solution,
            time=270
        )
        
    elseif problem_type == :circulation_flux
        # Complex Stokes problem with parametric surface
        
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        
        # F = <-y, x, xyz>
        P = -a*y
        Q = a*x
        R = b*x*y*z
        
        # Surface: paraboloid z = x²+y² for x²+y²≤R²
        R_val = randint(1, 3)
        
        # Curl
        curl_x = diff(R, y) - diff(Q, z)
        curl_y = diff(P, z) - diff(R, x)
        curl_z = diff(Q, x) - diff(P, y)
        
        curl_z_val = simplify(curl_z)
        
        # For upward orientation on z = x²+y²
        # Normal vector is <-2x, -2y, 1> (pointing up)
        # curl·n = curl_x(-2x) + curl_y(-2y) + curl_z(1)
        
        curl_x_on_surf = substitute(curl_x, z => x^2 + y^2)
        curl_y_on_surf = substitute(curl_y, z => x^2 + y^2)
        curl_z_on_surf = substitute(curl_z, z => x^2 + y^2)
        
        # This gets complicated; use simpler boundary circulation
        # Boundary C: x²+y²=R², z=R²
        # Parametrize: x=R cos(t), y=R sin(t), z=R²
        
        # F·dr on boundary
        # dr = <-R sin(t), R cos(t), 0> dt
        # F = <-aR sin(t), aR cos(t), bR²R² cos(t)sin(t)>
        
        line_integral = 2*a*π*R_val^2
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle. Compute \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} where C is the boundary of the paraboloid z = x^2 + y^2 for x^2 + y^2 \\leq $(R_val)^2, oriented counterclockwise when viewed from above."
        
        answer = line_integral
        
        solution = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle"),
            "Boundary curve C: x^2 + y^2 = $(R_val^2), z = $(R_val^2)",
            "Parametrize: \\mathbf{r}(t) = \\langle $(R_val)\\cos t, $(R_val)\\sin t, $(R_val^2) \\rangle, 0 \\leq t \\leq 2\\pi",
            "Velocity: \\mathbf{r}'(t) = \\langle -$(R_val)\\sin t, $(R_val)\\cos t, 0 \\rangle",
            "On C: \\mathbf{F} = \\langle $(tex(-a*R_val))\\sin t, $(tex(a*R_val))\\cos t, $(tex(b*R_val^4))\\cos t \\sin t \\rangle",
            "\\mathbf{F} \\cdot \\mathbf{r}' = $(tex(a*R_val^2))\\sin^2 t + $(tex(a*R_val^2))\\cos^2 t = $(tex(a*R_val^2))",
            sol("Integral", "\\int_0^{2\\pi} $(tex(a*R_val^2)) \\, dt = $(tex(line_integral))")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2800, 3400),
            solution=solution,
            time=300
        )
        
    elseif problem_type == :surface_independence
        # Show flux is independent of surface choice
        
        a = nonzero(-4, 4)
        
        # Divergence-free field: F = ∇×G for some G
        # Use F = curl(<0, 0, axy>)
        # F = <ax, -ay, 0>
        
        P = a*x
        Q = -a*y
        R = 0
        
        div_F = diff(P, x) + diff(Q, y) + diff(R, z)
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle. Verify that \\mathbf{F} is divergence-free and compute the flux of \\mathbf{F} through any closed surface S."
        
        answer = 0
        
        solution = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle"),
            sol("Divergence", "\\nabla \\cdot \\mathbf{F} = $(tex(diff(P,x))) + $(tex(diff(Q,y))) + $(tex(diff(R,z))) = $(tex(div_F))"),
            "Since \\nabla \\cdot \\mathbf{F} = 0, the field is divergence-free",
            "By Divergence Theorem: \\iint_S \\mathbf{F} \\cdot d\\mathbf{S} = \\iiint_E 0 \\, dV",
            sol("Answer", 0)
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2500, 3000),
            solution=solution,
            time=180
        )
        
    else  # conservative_field
        # Determine if field is conservative and find potential
        
        a = randint(2, 5)
        b = randint(2, 5)
        c = randint(2, 5)
        
        # Conservative field: F = ∇f
        # f = ax²y + by²z + cz²x
        f = a*x^2*y + b*y^2*z + c*z^2*x
        
        P = diff(f, x)
        Q = diff(f, y)
        R = diff(f, z)
        
        # Check curl = 0
        curl_x = diff(R, y) - diff(Q, z)
        curl_y = diff(P, z) - diff(R, x)
        curl_z = diff(Q, x) - diff(P, y)
        
        question = "Let \\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle. Verify that \\mathbf{F} is conservative by computing \\nabla \\times \\mathbf{F}, then find a potential function f such that \\mathbf{F} = \\nabla f."
        
        answer = f
        
        solution = steps(
            sol("Vector field", "\\mathbf{F} = \\langle $(tex(P)), $(tex(Q)), $(tex(R)) \\rangle"),
            sol("Curl", "\\nabla \\times \\mathbf{F} = \\langle $(tex(curl_x)), $(tex(curl_y)), $(tex(curl_z)) \\rangle = \\mathbf{0}"),
            "Since curl is zero, \\mathbf{F} is conservative",
            "Integrate P with respect to x: \\int $(tex(P)) \\, dx = $(tex(a*x^2*y)) + g(y,z)",
            "Match Q and R components to determine g(y,z)",
            sol("Potential function", "f(x,y,z) = $(tex(f))")
        )
        
        problem(
            question=question,
            answer=answer,
            difficulty=(2900, 3500),
            solution=solution,
            time=300
        )
    end
end