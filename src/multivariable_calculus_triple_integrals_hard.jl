# multivariable_calculus - triple_integrals (hard)
# Generated: 2026-03-08T21:02:47.238080

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/triple_integrals")
    
    problem_type = choice([
        :rectangular_box,
        :spherical_region,
        :cylindrical_region,
        :tetrahedron,
        :cone,
        :order_of_integration,
        :volume_calculation,
        :mass_with_density
    ])
    
    if problem_type == :rectangular_box
        # Triple integral over a rectangular box with polynomial integrand
        a, b = sort([randint(-8, 8), randint(-8, 8)])
        c, d = sort([randint(-8, 8), randint(-8, 8)])
        e, f = sort([randint(-8, 8), randint(-8, 8)])
        
        # Create polynomial integrand
        p = randint(1, 3)
        q = randint(1, 3)
        r = randint(1, 3)
        coeff = nonzero(-5, 5)
        
        integrand = coeff * x^p * y^q * z^r
        
        # Calculate answer step by step
        int_x = substitute(integrate(integrand, x), x => b) - substitute(integrate(integrand, x), x => a)
        int_xy = substitute(integrate(int_x, y), y => d) - substitute(integrate(int_x, y), y => c)
        ans = substitute(integrate(int_xy, z), z => f) - substitute(integrate(int_xy, z), z => e)
        ans = simplify(ans)
        
        problem(
            question="Evaluate \\(\\iiint_R $(tex(integrand)) \\, dV\\) where \\(R = [$a, $b] \\times [$c, $d] \\times [$e, $f]\\).",
            answer=ans,
            difficulty=(1800, 2000),
            solution=steps(
                sol("Region", "R = [$a, $b] \\times [$c, $d] \\times [$e, $f]"),
                sol("Integrand", integrand),
                "Integrate with respect to x: \\(\\int_{$a}^{$b} $(tex(integrand)) \\, dx = $(tex(int_x))\\)",
                "Integrate with respect to y: \\(\\int_{$c}^{$d} $(tex(int_x)) \\, dy = $(tex(int_xy))\\)",
                "Integrate with respect to z: \\(\\int_{$e}^{$f} $(tex(int_xy)) \\, dz = $(tex(ans))\\)",
                sol("Answer", ans)
            ),
            time=240
        )
        
    elseif problem_type == :spherical_region
        # Triple integral in spherical coordinates
        R = randint(2, 8)
        
        # Simple density function that makes calculation tractable
        integrand_type = choice([:constant, :r_squared])
        
        if integrand_type == :constant
            k = nonzero(-5, 5)
            # Volume of sphere: (4/3)πR³
            ans = k * 4//3 * π * R^3
            integrand_str = "$k"
        else
            k = nonzero(-3, 3)
            # ∫∫∫ k r² dV in spherical = k ∫₀^R ∫₀^π ∫₀^2π r² · r² sin(φ) dθ dφ dr
            # = k · 2π · 2 · R⁵/5 = (4πk/5)R⁵
            ans = 4 * π * k * R^5 // 5
            integrand_str = "$k \\rho^2"
        end
        
        problem(
            question="Evaluate \\(\\iiint_E $integrand_str \\, dV\\) where \\(E\\) is the ball of radius $(R) centered at the origin. Use spherical coordinates.",
            answer=ans,
            difficulty=(1900, 2100),
            solution=steps(
                "Convert to spherical coordinates: \\(dV = \\rho^2 \\sin(\\phi) \\, d\\rho \\, d\\phi \\, d\\theta\\)",
                "Limits: \\(0 \\leq \\rho \\leq $R\\), \\(0 \\leq \\phi \\leq \\pi\\), \\(0 \\leq \\theta \\leq 2\\pi\\)",
                integrand_type == :constant ? 
                    "\\(\\int_0^{2\\pi} \\int_0^{\\pi} \\int_0^{$R} $k \\rho^2 \\sin(\\phi) \\, d\\rho \\, d\\phi \\, d\\theta\\)" :
                    "\\(\\int_0^{2\\pi} \\int_0^{\\pi} \\int_0^{$R} $k \\rho^4 \\sin(\\phi) \\, d\\rho \\, d\\phi \\, d\\theta\\)",
                "Integrate with respect to each variable",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == :cylindrical_region
        # Triple integral in cylindrical coordinates
        R = randint(2, 6)
        H = randint(2, 8)
        
        integrand_type = choice([:constant, :r_linear])
        
        if integrand_type == :constant
            k = nonzero(-5, 5)
            # Volume of cylinder: πR²H
            ans = k * π * R^2 * H
            integrand_str = "$k"
        else
            k = nonzero(-3, 3)
            # ∫∫∫ k r dV in cylindrical = k ∫₀^H ∫₀^{2π} ∫₀^R r · r dr dθ dz
            # = k · H · 2π · R³/3 = (2πkH/3)R³
            ans = 2 * π * k * H * R^3 // 3
            integrand_str = "$k r"
        end
        
        problem(
            question="Evaluate \\(\\iiint_E $integrand_str \\, dV\\) where \\(E\\) is the cylinder \\(x^2 + y^2 \\leq $R^2\\), \\(0 \\leq z \\leq $H\\). Use cylindrical coordinates.",
            answer=ans,
            difficulty=(1850, 2050),
            solution=steps(
                "Convert to cylindrical coordinates: \\(dV = r \\, dr \\, d\\theta \\, dz\\)",
                "Limits: \\(0 \\leq r \\leq $R\\), \\(0 \\leq \\theta \\leq 2\\pi\\), \\(0 \\leq z \\leq $H\\)",
                integrand_type == :constant ?
                    "\\(\\int_0^{$H} \\int_0^{2\\pi} \\int_0^{$R} $k r \\, dr \\, d\\theta \\, dz\\)" :
                    "\\(\\int_0^{$H} \\int_0^{2\\pi} \\int_0^{$R} $k r^2 \\, dr \\, d\\theta \\, dz\\)",
                "Integrate with respect to each variable",
                sol("Answer", ans)
            ),
            time=270
        )
        
    elseif problem_type == :tetrahedron
        # Triple integral over tetrahedron
        a = randint(2, 8)
        b = randint(2, 8)
        c = randint(2, 8)
        
        # Constant integrand - volume of tetrahedron
        # Volume = (1/6)abc
        ans = a * b * c // 6
        
        problem(
            question="Find the volume of the tetrahedron bounded by the coordinate planes and the plane \\(\\frac{x}{$a} + \\frac{y}{$b} + \\frac{z}{$c} = 1\\).",
            answer=ans,
            difficulty=(1900, 2150),
            solution=steps(
                "The region is: \\(0 \\leq x \\leq $a\\), \\(0 \\leq y \\leq $b(1 - x/$a)\\), \\(0 \\leq z \\leq $c(1 - x/$a - y/$b)\\)",
                "Volume = \\(\\int_0^{$a} \\int_0^{$b(1-x/$a)} \\int_0^{$c(1-x/$a-y/$b)} dz \\, dy \\, dx\\)",
                "Integrate with respect to z, then y, then x",
                "Using the formula: Volume = \\(\\frac{1}{6}abc\\)",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == :cone
        # Triple integral over a cone
        R = randint(2, 6)
        H = randint(2, 8)
        
        # Volume of cone using cylindrical coordinates
        # z goes from 0 to H, r goes from 0 to R(1-z/H)
        # Volume = (1/3)πR²H
        ans = π * R^2 * H // 3
        
        problem(
            question="Find the volume of the cone \\(z = $H - \\frac{$H}{$R}\\sqrt{x^2 + y^2}\\) above the xy-plane.",
            answer=ans,
            difficulty=(2000, 2250),
            solution=steps(
                "In cylindrical coordinates: \\(z = $H - \\frac{$H}{$R}r\\), where \\(0 \\leq r \\leq $R\\)",
                "For fixed r, z ranges from 0 to \\($H - \\frac{$H}{$R}r\\)",
                "Volume = \\(\\int_0^{2\\pi} \\int_0^{$R} \\int_0^{$H(1-r/$R)} r \\, dz \\, dr \\, d\\theta\\)",
                "Integrate: \\(2\\pi \\int_0^{$R} r($H - \\frac{$H}{$R}r) \\, dr = \\frac{\\pi $R^2 $H}{3}\\)",
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == :order_of_integration
        # Change order of integration problem
        a = randint(1, 5)
        b = randint(2, 8)
        
        # Region: 0 ≤ x ≤ a, 0 ≤ y ≤ x, 0 ≤ z ≤ b
        # Volume with simple integrand
        k = nonzero(-5, 5)
        
        # Original: ∫₀ᵃ ∫₀ˣ ∫₀ᵇ k dz dy dx = k·b·a²/2
        ans = k * b * a^2 // 2
        
        problem(
            question="Evaluate \\(\\int_0^{$a} \\int_0^x \\int_0^{$b} $k \\, dz \\, dy \\, dx\\) by first changing the order of integration to \\(dy \\, dx \\, dz\\).",
            answer=ans,
            difficulty=(2100, 2350),
            solution=steps(
                "Original region: \\(0 \\leq x \\leq $a\\), \\(0 \\leq y \\leq x\\), \\(0 \\leq z \\leq $b\\)",
                "Rewrite with dy dx dz order: \\(0 \\leq z \\leq $b\\), \\(0 \\leq x \\leq $a\\), \\(0 \\leq y \\leq x\\)",
                "New integral: \\(\\int_0^{$b} \\int_0^{$a} \\int_0^x $k \\, dy \\, dx \\, dz\\)",
                "Evaluate: \\(\\int_0^{$b} \\int_0^{$a} $k x \\, dx \\, dz = \\int_0^{$b} \\frac{$k $a^2}{2} \\, dz\\)",
                sol("Answer", ans)
            ),
            time=270
        )
        
    elseif problem_type == :volume_calculation
        # Use triple integral to find volume between surfaces
        a = randint(2, 6)
        
        # Volume between z = x² + y² and z = a²
        # In cylindrical: ∫∫∫ r dr dθ dz, 0 ≤ r ≤ a, r² ≤ z ≤ a²
        # = 2π ∫₀ᵃ r(a² - r²) dr = 2π[a²r²/2 - r⁴/4]₀ᵃ = πa⁴/2
        ans = π * a^4 // 2
        
        problem(
            question="Find the volume of the region bounded by the paraboloid \\(z = x^2 + y^2\\) and the plane \\(z = $(a^2)\\).",
            answer=ans,
            difficulty=(1950, 2200),
            solution=steps(
                "Convert to cylindrical coordinates: \\(z = r^2\\)",
                "Region: \\(0 \\leq r \\leq $a\\), \\(0 \\leq \\theta \\leq 2\\pi\\), \\(r^2 \\leq z \\leq $(a^2)\\)",
                "Volume = \\(\\int_0^{2\\pi} \\int_0^{$a} \\int_{r^2}^{$(a^2)} r \\, dz \\, dr \\, d\\theta\\)",
                "Integrate: \\(2\\pi \\int_0^{$a} r($(a^2) - r^2) \\, dr = \\frac{\\pi $(a^4)}{2}\\)",
                sol("Answer", ans)
            ),
            time=300
        )
        
    else  # :mass_with_density
        # Mass calculation with variable density
        R = randint(2, 5)
        k = nonzero(-3, 3)
        
        # Density ρ(x,y,z) = k(x² + y² + z²) in ball of radius R
        # In spherical: ∫∫∫ k·ρ² · ρ² sin(φ) dρ dφ dθ
        # = k · 2π · 2 · R⁵/5 = (4πk/5)R⁵
        ans = 4 * π * k * R^5 // 5
        
        problem(
            question="Find the mass of the solid ball of radius $R centered at the origin if the density at point \\((x,y,z)\\) is \\(\\rho(x,y,z) = $(k)(x^2 + y^2 + z^2)\\). Express your answer in terms of \\(\\pi\\).",
            answer=ans,
            difficulty=(2200, 2500),
            solution=steps(
                "Convert to spherical coordinates: \\(x^2 + y^2 + z^2 = \\rho^2\\)",
                "Mass = \\(\\int_0^{2\\pi} \\int_0^{\\pi} \\int_0^{$(R)} $(k) \\rho^2 \\cdot \\rho^2 \\sin(\\phi) \\, d\\rho \\, d\\phi \\, d\\theta\\)",
                "Evaluate: \\($(k) \\cdot 2\\pi \\cdot 2 \\cdot \\frac{$(R)^5}{5} = \\frac{4\\pi \\cdot $(k) \\cdot $(R^5)}{5}\\)",
                sol("Answer", ans)
            ),
            time=300
        )
    end
end
