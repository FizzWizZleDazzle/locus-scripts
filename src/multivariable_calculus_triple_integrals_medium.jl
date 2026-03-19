# multivariable_calculus - triple_integrals (medium)
# Generated: 2026-03-08T21:02:13.496885

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/triple_integrals")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Simple triple integral over rectangular region (1200-1400)
        a = randint(1, 3)
        b = randint(1, 3)
        c = randint(1, 3)
        
        x_lower = 0
        x_upper = randint(1, 3)
        y_lower = 0
        y_upper = randint(1, 3)
        z_lower = 0
        z_upper = randint(1, 3)
        
        integrand = a*x + b*y + c*z
        
        # Compute answer
        int_z = expand(integrate(integrand, (z, z_lower, z_upper)))
        int_y = expand(integrate(int_z, (y, y_lower, y_upper)))
        ans = integrate(int_y, (x, x_lower, x_upper))
        
        problem(
            question="Evaluate the triple integral \\(\\iiint_R ($(tex(integrand))) \\, dV\\) where \\(R = [$(x_lower), $(x_upper)] \\times [$(y_lower), $(y_upper)] \\times [$(z_lower), $(z_upper)]\\).",
            answer=ans,
            difficulty=(1200, 1400),
            solution=steps(
                sol("Setup", "\\int_{$(x_lower)}^{$(x_upper)} \\int_{$(y_lower)}^{$(y_upper)} \\int_{$(z_lower)}^{$(z_upper)} ($(tex(integrand))) \\, dz \\, dy \\, dx"),
                sol("Integrate with respect to z", int_z),
                sol("Integrate with respect to y", int_y),
                sol("Integrate with respect to x", ans)
            ),
            time=180
        )
        
    elseif problem_type == 2
        # Volume under surface (1300-1500)
        a = randint(1, 4)
        b = randint(1, 4)
        
        x_upper = randint(2, 4)
        y_upper = randint(2, 4)
        
        integrand = a*x*y + b
        
        int_z = integrand
        int_y = expand(integrate(int_z, (y, 0, y_upper)))
        ans = integrate(int_y, (x, 0, x_upper))
        
        problem(
            question="Find the volume of the solid under the surface \\(z = $(tex(integrand))\\) and above the rectangle \\([0, $(x_upper)] \\times [0, $(y_upper)]\\) in the xy-plane.",
            answer=ans,
            difficulty=(1300, 1500),
            solution=steps(
                sol("Setup volume integral", "V = \\int_0^{$(x_upper)} \\int_0^{$(y_upper)} ($(tex(integrand))) \\, dy \\, dx"),
                sol("Integrate with respect to y", int_y),
                sol("Integrate with respect to x", ans)
            ),
            time=180
        )
        
    elseif problem_type == 3
        # Triple integral with variable limits (1400-1600)
        a = randint(2, 5)
        
        x_upper = randint(2, 3)
        
        integrand = a*x^2*y
        
        int_z = integrand * x
        int_y = expand(integrate(int_z, (y, 0, x)))
        ans = integrate(int_y, (x, 0, x_upper))
        
        problem(
            question="Evaluate \\(\\iiint_E $(tex(integrand)) \\, dV\\) where \\(E\\) is the region defined by \\(0 \\leq x \\leq $(x_upper)\\), \\(0 \\leq y \\leq x\\), \\(0 \\leq z \\leq x\\).",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Setup", "\\int_0^{$(x_upper)} \\int_0^x \\int_0^x $(tex(integrand)) \\, dz \\, dy \\, dx"),
                sol("Integrate with respect to z", int_z),
                sol("Integrate with respect to y", int_y),
                sol("Integrate with respect to x", ans)
            ),
            time=240
        )
        
    elseif problem_type == 4
        # Volume of tetrahedron (1500-1700)
        a = randint(2, 6)
        
        ans = a^3 // 6
        
        problem(
            question="Find the volume of the tetrahedron bounded by the coordinate planes and the plane \\(x + y + z = $(a)\\).",
            answer=ans,
            difficulty=(1500, 1700),
            solution=steps(
                "The region is described by \\(0 \\leq x \\leq $(a)\\), \\(0 \\leq y \\leq $(a) - x\\), \\(0 \\leq z \\leq $(a) - x - y\\)",
                sol("Setup", "V = \\int_0^{$(a)} \\int_0^{$(a)-x} \\int_0^{$(a)-x-y} dz \\, dy \\, dx"),
                "Integrate with respect to z: \\(\\int_0^{$(a)} \\int_0^{$(a)-x} ($(a) - x - y) \\, dy \\, dx\\)",
                "Integrate with respect to y: \\(\\int_0^{$(a)} \\frac{($(a)-x)^2}{2} \\, dx\\)",
                sol("Integrate with respect to x", ans)
            ),
            time=240
        )
        
    elseif problem_type == 5
        # Triple integral in cylindrical coordinates setup (1600-1800)
        r_upper = randint(2, 5)
        h = randint(3, 6)
        
        ans = "\\pi \\cdot $(r_upper^2) \\cdot $(h)"
        ans_val = π * r_upper^2 * h
        
        problem(
            question="Set up (but do not evaluate) the triple integral in cylindrical coordinates for the volume of a cylinder with radius $(r_upper) and height $(h). What is the volume?",
            answer=ans_val,
            difficulty=(1600, 1800),
            solution=steps(
                sol("Cylindrical coordinates", "V = \\iiint r \\, dr \\, d\\theta \\, dz"),
                sol("Limits", "\\int_0^{$(h)} \\int_0^{2\\pi} \\int_0^{$(r_upper)} r \\, dr \\, d\\theta \\, dz"),
                "Integrate \\(\\int_0^{$(r_upper)} r \\, dr = \\frac{$(r_upper)^2}{2}\\)",
                "Integrate \\(\\int_0^{2\\pi} \\frac{$(r_upper)^2}{2} \\, d\\theta = \\pi \\cdot $(r_upper^2)\\)",
                sol("Final answer", ans_val)
            ),
            time=180
        )
        
    else
        # Mass calculation with density (1400-1600)
        ρ = randint(2, 5)
        a = randint(2, 4)
        
        ans = ρ * a^3
        
        problem(
            question="Find the mass of a rectangular solid \\([0, $(a)] \\times [0, $(a)] \\times [0, $(a)]\\) with constant density \\(\\rho = $(ρ)\\) kg/m³.",
            answer=ans,
            difficulty=(1400, 1600),
            solution=steps(
                sol("Mass formula", "m = \\iiint_R \\rho \\, dV"),
                sol("Setup", "m = \\int_0^{$(a)} \\int_0^{$(a)} \\int_0^{$(a)} $(ρ) \\, dz \\, dy \\, dx"),
                "Each integral contributes a factor of $(a)",
                sol("Answer", "$(ρ) \\cdot $(a)^3 = $(ans)")
            ),
            time=150
        )
    end
end