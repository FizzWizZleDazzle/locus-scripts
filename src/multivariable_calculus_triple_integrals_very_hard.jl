# multivariable_calculus - triple_integrals (very_hard)
# Generated: 2026-03-08T21:02:58.838112

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/triple_integrals")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Competition: Change of order of integration with non-trivial bounds
        # ELO 2500-2800
        a = randint(1, 4)
        b = randint(1, 3)
        c = randint(1, 3)
        
        # Original order: dz dy dx with bounds z: 0 to x^2+y^2, y: 0 to a*x, x: 0 to b
        # Need to find new order dz dx dy
        
        # The region is bounded by z = 0 below, z = x²+y² above
        # y from 0 to a*x means x >= y/a
        # x from 0 to b means y from 0 to a*b
        
        integrand_expr = c * x * y * z
        
        original_integral = "\\int_0^{$(b)} \\int_0^{$(a)x} \\int_0^{x^2+y^2} $(tex(integrand_expr)) \\, dz \\, dy \\, dx"
        
        # New bounds for dz dx dy order:
        # y: 0 to a*b
        # x: y/a to b  
        # z: 0 to x²+y²
        
        new_integral = "\\int_0^{$(a*b)} \\int_{y/$(a)}^{$(b)} \\int_0^{x^2+y^2} $(tex(integrand_expr)) \\, dz \\, dx \\, dy"
        
        problem(
            question="Rewrite the triple integral in the order \\(dz \\, dx \\, dy\\):\n\$\$$(original_integral)\$\$",
            answer=new_integral,
            difficulty=(2500, 2800),
            answer_type="text",
            solution=steps(
                "Identify the region of integration from the bounds",
                "Region: \\(0 \\leq z \\leq x^2+y^2\\), \\(0 \\leq y \\leq $(a)x\\), \\(0 \\leq x \\leq $(b)\\)",
                "From \\(y \\leq $(a)x\\) we get \\(x \\geq y/$(a)\\)",
                "Since \\(0 \\leq x \\leq $(b)\\) and \\(y \\leq $(a)x\\), we have \\(0 \\leq y \\leq $(a*b)\\)",
                "For fixed \\(y\\), \\(x\\) ranges from \\(y/$(a)\\) to \\($(b)\\)",
                sol("New integral", new_integral)
            ),
            time=240,
            calculator="none"
        )
        
    elseif problem_type == 2
        # Competition-Olympiad: Triple integral with symmetry and non-standard region
        # ELO 2700-3200
        
        # Region: sphere x²+y²+z² ≤ R², z ≥ 0, evaluate ∫∫∫ z√(x²+y²+z²) dV
        R = randint(2, 5)
        
        # Using spherical coordinates: ρ: 0 to R, φ: 0 to π/2, θ: 0 to 2π
        # Integrand becomes ρ·cos(φ)·ρ·ρ²sin(φ) = ρ⁴cos(φ)sin(φ)
        
        # ∫₀^(2π) dθ ∫₀^(π/2) ∫₀^R ρ⁴cos(φ)sin(φ) dρ dφ dθ
        # = 2π · [R⁵/5] · ∫₀^(π/2) cos(φ)sin(φ) dφ
        # = 2π · R⁵/5 · [sin²(φ)/2]₀^(π/2)
        # = 2π · R⁵/5 · 1/2 = πR⁵/5
        
        ans_num = R^5
        ans_denom = 5
        
        problem(
            question="Evaluate the triple integral over the upper hemisphere \\(x^2+y^2+z^2 \\leq $(R^2)\\), \\(z \\geq 0\\):\n\$\$\\iiint_E z\\sqrt{x^2+y^2+z^2} \\, dV\$\$",
            answer="\\frac{$(ans_num)\\pi}{$(ans_denom)}",
            difficulty=(2700, 3200),
            answer_type="expression",
            solution=steps(
                "Use spherical coordinates: \\(x = \\rho\\sin\\phi\\cos\\theta\\), \\(y = \\rho\\sin\\phi\\sin\\theta\\), \\(z = \\rho\\cos\\phi\\)",
                "Jacobian: \\(dV = \\rho^2\\sin\\phi \\, d\\rho \\, d\\phi \\, d\\theta\\)",
                "Upper hemisphere: \\(0 \\leq \\rho \\leq $(R)\\), \\(0 \\leq \\phi \\leq \\pi/2\\), \\(0 \\leq \\theta \\leq 2\\pi\\)",
                "Integrand becomes: \\(z\\sqrt{x^2+y^2+z^2} = (\\rho\\cos\\phi)(\\rho) = \\rho^2\\cos\\phi\\)",
                "Integral: \\(\\int_0^{2\\pi} \\int_0^{\\pi/2} \\int_0^{$(R)} \\rho^2\\cos\\phi \\cdot \\rho^2\\sin\\phi \\, d\\rho \\, d\\phi \\, d\\theta\\)",
                "\\(= 2\\pi \\cdot \\frac{$(R)^5}{5} \\cdot \\int_0^{\\pi/2} \\cos\\phi\\sin\\phi \\, d\\phi = 2\\pi \\cdot \\frac{$(R^5)}{5} \\cdot \\frac{1}{2}\\)",
                sol("Answer", "\\frac{$(ans_num)\\pi}{$(ans_denom)}")
            ),
            time=300,
            calculator="none"
        )
        
    elseif problem_type == 3
        # Olympiad: Volume using triple integral with coordinate transformation
        # ELO 3000-3400
        
        a = randint(2, 4)
        b = randint(2, 4)
        c = randint(2, 4)
        
        # Volume of ellipsoid x²/a² + y²/b² + z²/c² ≤ 1
        # Transform: u = x/a, v = y/b, w = z/c
        # Jacobian = abc
        # Volume = abc · (volume of unit sphere) = abc · 4π/3
        
        vol_coeff = 4 * a * b * c
        
        problem(
            question="Find the volume of the ellipsoid:\n\$\$\\frac{x^2}{$(a^2)} + \\frac{y^2}{$(b^2)} + \\frac{z^2}{$(c^2)} \\leq 1\$\$",
            answer="\\frac{$(vol_coeff)\\pi}{3}",
            difficulty=(3000, 3400),
            answer_type="expression",
            solution=steps(
                "Use the transformation: \\(u = \\frac{x}{$(a)}\\), \\(v = \\frac{y}{$(b)}\\), \\(w = \\frac{z}{$(c)}\\)",
                "The ellipsoid becomes the unit sphere: \\(u^2 + v^2 + w^2 \\leq 1\\)",
                "The Jacobian of the transformation is: \\(\\left|\\frac{\\partial(x,y,z)}{\\partial(u,v,w)}\\right| = $(a) \\cdot $(b) \\cdot $(c) = $(a*b*c)\\)",
                "Volume = \\($(a*b*c) \\iiint_{u^2+v^2+w^2 \\leq 1} du \\, dv \\, dw\\)",
                "The volume of the unit sphere is \\(\\frac{4\\pi}{3}\\)",
                sol("Answer", "\\frac{$(vol_coeff)\\pi}{3}")
            ),
            time=270,
            calculator="none"
        )
        
    else
        # Olympiad: Mass/center of mass with variable density
        # ELO 3100-3500
        
        R = randint(2, 4)
        k = randint(1, 3)
        
        # Find the z-coordinate of center of mass of hemisphere x²+y²+z² ≤ R², z ≥ 0
        # with density ρ(x,y,z) = k·z
        
        # Mass = ∫∫∫ kz dV
        # Using spherical: = k ∫₀^(2π) ∫₀^(π/2) ∫₀^R (ρcos φ)ρ²sin φ dρ dφ dθ
        # = 2πk · [R⁴/4] · ∫₀^(π/2) cos φ sin φ dφ = 2πk · R⁴/4 · 1/2 = πkR⁴/4
        
        # Moment about xy-plane = ∫∫∫ z·kz dV = k∫∫∫ z² dV
        # = k ∫₀^(2π) ∫₀^(π/2) ∫₀^R (ρcos φ)²ρ²sin φ dρ dφ dθ
        # = 2πk · [R⁵/5] · ∫₀^(π/2) cos² φ sin φ dφ = 2πk · R⁵/5 · 1/3 = 2πkR⁵/15
        
        # z̄ = (2πkR⁵/15) / (πkR⁴/4) = (2R/15) · (4) = 8R/15
        
        z_bar_num = 8 * R
        z_bar_denom = 15
        
        problem(
            question="Find the z-coordinate of the center of mass of the upper hemisphere \\(x^2+y^2+z^2 \\leq $(R^2)\\), \\(z \\geq 0\\), with density function \\(\\rho(x,y,z) = $(k)z\\).",
            answer="\\frac{$(z_bar_num)}{$(z_bar_denom)}",
            difficulty=(3100, 3500),
            answer_type="expression",
            solution=steps(
                "Use spherical coordinates with \\(z = \\rho\\cos\\phi\\), \\(dV = \\rho^2\\sin\\phi \\, d\\rho \\, d\\phi \\, d\\theta\\)",
                "Mass: \\(M = \\int_0^{2\\pi} \\int_0^{\\pi/2} \\int_0^{$(R)} $(k)\\rho\\cos\\phi \\cdot \\rho^2\\sin\\phi \\, d\\rho \\, d\\phi \\, d\\theta = \\frac{$(k)\\pi $(R)^4}{4}\\)",
                "Moment about xy-plane: \\(M_z = \\int_0^{2\\pi} \\int_0^{\\pi/2} \\int_0^{$(R)} $(k)\\rho^2\\cos^2\\phi \\cdot \\rho^2\\sin\\phi \\, d\\rho \\, d\\phi \\, d\\theta\\)",
                "Evaluate: \\(M_z = 2\\pi \\cdot $(k) \\cdot \\frac{$(R)^5}{5} \\cdot \\int_0^{\\pi/2} \\cos^2\\phi\\sin\\phi \\, d\\phi = \\frac{2\\pi $(k) $(R)^5}{15}\\)",
                "Center of mass z-coordinate: \\(\\bar{z} = \\frac{M_z}{M} = \\frac{2\\pi $(k) $(R)^5/15}{$(k)\\pi $(R)^4/4}\\)",
                sol("Answer", "\\frac{$(z_bar_num)}{$(z_bar_denom)}")
            ),
            time=300,
            calculator="none"
        )
    end
end