# multivariable_calculus - stokes_divergence (competition)
# Generated: 2026-03-08T21:06:48.761014

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z t u v begin
    set_topic!("multivariable_calculus/stokes_divergence")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Stokes' theorem verification on a challenging surface
        # Generate a vector field with interesting curl
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        d = nonzero(-4, 4)
        e = nonzero(-4, 4)
        f = nonzero(-4, 4)
        
        # F = (P, Q, R) where curl F has specific structure
        P = a*y*z + b*x^2
        Q = c*x*z + d*y^2
        R = e*x*y + f*z^2
        
        # Compute curl F
        curl_x = diff(R, y) - diff(Q, z)
        curl_y = diff(P, z) - diff(R, x)
        curl_z = diff(Q, x) - diff(P, y)
        
        curl_x_simplified = simplify(curl_x)
        curl_y_simplified = simplify(curl_y)
        curl_z_simplified = simplify(curl_z)
        
        # Surface: hemisphere x^2 + y^2 + z^2 = r^2, z >= 0
        r = randint(2, 5)
        
        # Boundary circle: x^2 + y^2 = r^2 in xy-plane
        # Line integral over boundary with upward normal convention
        # Parametrize: x = r*cos(t), y = r*sin(t), z = 0
        
        # For the circular boundary, compute line integral
        line_integral_value = a * r^3 * π + c * r^3 * π
        
        problem(
            question="Let \\mathbf{F} = ($(tex(P)), $(tex(Q)), $(tex(R))). Use Stokes' theorem to evaluate \\oint_C \\mathbf{F} \\cdot d\\mathbf{r}, where C is the boundary circle x^2 + y^2 = $(r^2), z = 0, oriented counterclockwise when viewed from above.",
            answer=line_integral_value,
            difficulty=(3500, 3900),
            solution=steps(
                sol("Vector field", "\\mathbf{F} = ($(tex(P)), $(tex(Q)), $(tex(R)))"),
                "Compute \\nabla \\times \\mathbf{F}: \\nabla \\times \\mathbf{F} = ($(tex(curl_x_simplified)), $(tex(curl_y_simplified)), $(tex(curl_z_simplified)))",
                "Apply Stokes' theorem: \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_S (\\nabla \\times \\mathbf{F}) \\cdot \\mathbf{n} \\, dS",
                "For hemisphere x^2 + y^2 + z^2 = $(r^2), z \\geq 0 with upward normal, or project to disk in xy-plane with \\mathbf{n} = (0,0,1)",
                "Using disk projection: \\iint_D ($(tex(curl_z_simplified))) \\, dA where D: x^2 + y^2 \\leq $(r^2)",
                "Convert to polar coordinates and integrate",
                sol("Answer", line_integral_value)
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Divergence theorem with tricky computation
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        d = nonzero(-3, 3)
        e = nonzero(-3, 3)
        
        # Vector field components
        P = a*x^3 + b*y*z
        Q = c*y^3 + d*x*z
        R = e*z^3 + a*x*y
        
        # Compute divergence
        div_F = diff(P, x) + diff(Q, y) + diff(R, z)
        div_F_simplified = simplify(div_F)
        
        # Region: sphere of radius r
        r = randint(2, 4)
        
        # Volume integral of divergence over sphere
        # ∫∫∫ div F dV where div F = 3ax^2 + 3cy^2 + 3ez^2
        # Symmetry: ∫∫∫ x^2 dV = ∫∫∫ y^2 dV = ∫∫∫ z^2 dV = (1/5)*r^2*Volume = (1/5)*r^2*(4πr^3/3)
        volume_integral = (3*a + 3*c + 3*e) * (4 * π * r^5) // 15
        
        problem(
            question="Let \\mathbf{F} = ($(tex(P)), $(tex(Q)), $(tex(R))). Use the divergence theorem to compute \\iint_S \\mathbf{F} \\cdot \\mathbf{n} \\, dS, where S is the sphere x^2 + y^2 + z^2 = $(r^2) with outward normal.",
            answer=volume_integral,
            difficulty=(3600, 4000),
            solution=steps(
                sol("Vector field", "\\mathbf{F} = ($(tex(P)), $(tex(Q)), $(tex(R)))"),
                "Compute divergence: \\nabla \\cdot \\mathbf{F} = $(tex(div_F_simplified))",
                "Apply divergence theorem: \\iint_S \\mathbf{F} \\cdot \\mathbf{n} \\, dS = \\iiint_E \\nabla \\cdot \\mathbf{F} \\, dV",
                "Use spherical coordinates and symmetry: \\iiint x^2 dV = \\iiint y^2 dV = \\iiint z^2 dV",
                "Each integral equals \\frac{1}{5}r^2 \\cdot \\frac{4\\pi r^3}{3}",
                sol("Answer", volume_integral)
            ),
            time=280,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Stokes' theorem with non-planar surface
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        # F = (-y, x, z) type field or variation
        P = -a*y + b*z
        Q = a*x + c*z
        R = b*x + c*y
        
        curl_x = diff(R, y) - diff(Q, z)
        curl_y = diff(P, z) - diff(R, x)
        curl_z = diff(Q, x) - diff(P, y)
        
        curl_x_s = simplify(curl_x)
        curl_y_s = simplify(curl_y)
        curl_z_s = simplify(curl_z)
        
        # Paraboloid surface z = x^2 + y^2, with boundary at z = h
        h = randint(1, 4)
        r_bound = round(Int, sqrt(h))
        
        # The curl should integrate nicely
        flux_value = 2*a * π * h
        
        problem(
            question="Let \\mathbf{F} = ($(tex(P)), $(tex(Q)), $(tex(R))). Compute \\iint_S (\\nabla \\times \\mathbf{F}) \\cdot \\mathbf{n} \\, dS where S is the paraboloid z = x^2 + y^2 for 0 \\leq z \\leq $(h), oriented with upward normal.",
            answer=flux_value,
            difficulty=(3700, 4100),
            solution=steps(
                "Compute curl: \\nabla \\times \\mathbf{F} = ($(tex(curl_x_s)), $(tex(curl_y_s)), $(tex(curl_z_s)))",
                "By Stokes' theorem, equals line integral around boundary circle at z = $(h)",
                "Boundary: x^2 + y^2 = $(h), z = $(h), parametrized by x = \\sqrt{$(h)}\\cos t, y = \\sqrt{$(h)}\\sin t",
                "Evaluate \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} using the parametrization",
                "Compute and integrate over t \\in [0, 2\\pi]",
                sol("Answer", flux_value)
            ),
            time=300,
            calculator="none"
        )
        
    else
        # Divergence theorem with cylindrical region
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        # Field with radial component
        P = a*x*y
        Q = b*y*z
        R = c*z*x
        
        div_F = simplify(diff(P, x) + diff(Q, y) + diff(R, z))
        
        # Cylinder: x^2 + y^2 <= R^2, 0 <= z <= H
        R = randint(2, 4)
        H = randint(2, 5)
        
        # ∫∫∫ div F dV = ∫∫∫ (ay + bz + cx) dV
        # By symmetry, ∫∫∫ x dV = ∫∫∫ y dV = 0 over cylinder
        # ∫∫∫ z dV = (base area)*(H^2/2) = πR^2 * H^2/2
        
        volume_result = b * π * R^2 * H^2 // 2
        
        problem(
            question="Let \\mathbf{F} = ($(tex(P)), $(tex(Q)), $(tex(R))). Verify the divergence theorem by computing the flux through the boundary of the cylinder x^2 + y^2 \\leq $(R^2), 0 \\leq z \\leq $(H). What is \\iiint_E \\nabla \\cdot \\mathbf{F} \\, dV?",
            answer=volume_result,
            difficulty=(3800, 4300),
            solution=steps(
                sol("Divergence", "\\nabla \\cdot \\mathbf{F} = $(tex(div_F))"),
                "Set up triple integral over cylinder: \\iiint_E ($(tex(div_F))) \\, dV",
                "Use cylindrical coordinates: x = r\\cos\\theta, y = r\\sin\\theta, z = z",
                "Apply symmetry: integrals of x and y over symmetric region vanish",
                "Compute \\int_0^{$(H)} \\int_0^{2\\pi} \\int_0^{$(R)} $(b) z \\cdot r \\, dr \\, d\\theta \\, dz",
                sol("Answer", volume_result)
            ),
            time=300,
            calculator="none"
        )
    end
end