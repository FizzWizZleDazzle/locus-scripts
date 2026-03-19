# multivariable_calculus - triple_integrals (competition)
# Generated: 2026-03-08T21:03:08.120151

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/triple_integrals")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Olympiad-level: Triple integral with non-standard region requiring careful setup
        # Region: inside sphere x²+y²+z²=R², above cone z²=k²(x²+y²), z≥0
        R = randint(2, 5)
        k = rand([1, 2, 3])
        
        # The cone z = k√(x²+y²) intersects sphere at z = R/√(1+k²)
        # In spherical: φ ranges from 0 to arctan(1/k)
        phi_max_val = atan(1/k)
        
        # Volume calculation using spherical coordinates
        # ∫∫∫ ρ²sin(φ) dρ dφ dθ
        # ρ: 0 to R, φ: 0 to arctan(1/k), θ: 0 to 2π
        
        vol_exact = (2//3) * π * R^3 * (1 - k/sqrt(1 + k^2))
        
        question = "Compute the volume of the region bounded by the sphere \$x^2 + y^2 + z^2 = $(R^2)\$, " *
                   "above the cone \$z^2 = $(k^2)(x^2 + y^2)\$, and with \$z \\geq 0\$. " *
                   "Set up and evaluate the triple integral using an appropriate coordinate system. " *
                   "Express your answer in exact form."
        
        solution_text = steps(
            "The region is bounded above by sphere \$\\rho = $(R)\$ and below by cone \$\\phi = \\arctan(1/$(k))\$ in spherical coordinates.",
            "In spherical: \$x = \\rho\\sin\\phi\\cos\\theta\$, \$y = \\rho\\sin\\phi\\sin\\theta\$, \$z = \\rho\\cos\\phi\$, \$dV = \\rho^2\\sin\\phi\\,d\\rho\\,d\\phi\\,d\\theta\$",
            sol("V = \\int_0^{2\\pi}\\int_0^{\\arctan(1/$(k))}\\int_0^{$(R)} \\rho^2\\sin\\phi\\,d\\rho\\,d\\phi\\,d\\theta"),
            "Evaluate \$\\int_0^{$(R)} \\rho^2 d\\rho = \\frac{$(R)^3}{3} = \\frac{$(R^3)}{3}\$",
            "Evaluate \$\\int_0^{\\arctan(1/$(k))} \\sin\\phi d\\phi = 1 - \\cos(\\arctan(1/$(k))) = 1 - \\frac{$(k)}{\\sqrt{$(1+k^2)}}\$",
            "Evaluate \$\\int_0^{2\\pi} d\\theta = 2\\pi\$",
            sol("V = 2\\pi \\cdot \\frac{$(R^3)}{3} \\cdot \\left(1 - \\frac{$(k)}{\\sqrt{$(1+k^2)}}\\right) = \\frac{$(2*R^3)\\pi}{3}\\left(1 - \\frac{$(k)}{\\sqrt{$(1+k^2)}}\\right)")
        )
        
        problem(
            question=question,
            answer=vol_exact,
            difficulty=(3500, 4000),
            solution=solution_text,
            time=420
        )
        
    elseif problem_type == 2
        # Research-adjacent: Change of variables with Jacobian for non-standard transformation
        # Transform u=x+y, v=x-y, w=z, compute ∭_R f(u,v,w) dV over transformed region
        
        a = randint(1, 3)
        b = randint(1, 3)
        c = randint(1, 3)
        
        # Original region: 0≤x≤a, 0≤y≤b, 0≤z≤c
        # Under u=x+y, v=x-y, w=z: need to find image region and Jacobian
        # Inverse: x=(u+v)/2, y=(u-v)/2, z=w
        # Jacobian = |∂(x,y,z)/∂(u,v,w)| = 1/2
        
        # Image region: v ranges based on u constraints (complex)
        # For 0≤x≤a, 0≤y≤b: -b≤v≤a with 0≤u≤a+b and constraints
        
        integrand_type = rand(1:2)
        if integrand_type == 1
            # Integrate f(u,v,w) = u
            result = (1//2) * ((a+b)^2 * b / 2 + a^2 * (a-b) / 2) * c
            f_str = "u"
        else
            # Integrate f(u,v,w) = 1 (just volume with Jacobian)
            result = (1//2) * a * b * c
            f_str = "1"
        end
        
        question = "Let \$T\$ be the transformation \$u = x + y\$, \$v = x - y\$, \$w = z\$. " *
                   "Compute \$\\iiint_R $(f_str) \\, dV\$ where \$R\$ is the rectangular box " *
                   "\$0 \\leq x \\leq $(a)\$, \$0 \\leq y \\leq $(b)\$, \$0 \\leq z \\leq $(c)\$, " *
                   "by transforming to \$(u,v,w)\$ coordinates."
        
        solution_text = steps(
            "Find inverse transformation: \$x = \\frac{u+v}{2}\$, \$y = \\frac{u-v}{2}\$, \$z = w\$",
            "Compute Jacobian: \$J = \\begin{vmatrix} \\frac{1}{2} & \\frac{1}{2} & 0 \\\\ \\frac{1}{2} & -\\frac{1}{2} & 0 \\\\ 0 & 0 & 1 \\end{vmatrix} = -\\frac{1}{2}\$, so \$|J| = \\frac{1}{2}\$",
            "Transform region bounds: \$0 \\leq x \\leq $(a)\$ and \$0 \\leq y \\leq $(b)\$ gives constraints on \$(u,v)\$ plane",
            "The transformed integral becomes \$\\iiint_{R'} $(f_str) \\cdot \\frac{1}{2} \\, du\\,dv\\,dw\$",
            "Careful analysis of bounds and evaluation yields",
            sol("Answer", result)
        )
        
        problem(
            question=question,
            answer=result,
            difficulty=(3800, 4500),
            solution=solution_text,
            time=480
        )
        
    elseif problem_type == 3
        # Olympiad: Triple integral requiring clever symmetry argument
        # ∭_B (x²y + y²z + z²x) dV over ball x²+y²+z²≤R²
        
        R = randint(2, 4)
        
        # By symmetry, ∭ x²y dV = ∭ y²z dV = ∭ z²x dV
        # Each integral = 0 by symmetry (odd function in one variable)
        
        question = "Evaluate \$\\iiint_B (x^2 y + y^2 z + z^2 x) \\, dV\$ where \$B\$ is the ball " *
                   "\$x^2 + y^2 + z^2 \\leq $(R^2)\$. Justify your answer using symmetry arguments."
        
        solution_text = steps(
            "Consider each term separately: \$I_1 = \\iiint_B x^2 y \\, dV\$, \$I_2 = \\iiint_B y^2 z \\, dV\$, \$I_3 = \\iiint_B z^2 x \\, dV\$",
            "For \$I_1\$: The integrand \$x^2 y\$ is odd in \$y\$. The region \$B\$ is symmetric about the \$xz\$-plane (\$y \\to -y\$)",
            "By symmetry of odd functions over symmetric domains: \$I_1 = 0\$",
            "Similarly, \$I_2 = 0\$ (odd in \$z\$, symmetry about \$xy\$-plane) and \$I_3 = 0\$ (odd in \$x\$, symmetry about \$yz\$-plane)",
            sol("Answer", 0)
        )
        
        problem(
            question=question,
            answer=0,
            difficulty=(3600, 4200),
            solution=solution_text,
            time=360
        )
        
    else
        # Research-adjacent: Mass/center of mass with variable density in complex region
        # Region: inside ellipsoid x²/a² + y²/b² + z²/c² ≤ 1, density ρ(x,y,z) = 1 + z/c
        
        a = randint(1, 3)
        b = randint(1, 3)
        c = randint(2, 4)
        
        # Volume of ellipsoid: (4/3)πabc
        # Mass = ∭ (1 + z/c) dV
        # By symmetry, ∭ z dV over ellipsoid = 0 (odd in z, symmetric region)
        # So Mass = ∭ 1 dV = (4/3)πabc
        
        mass = (4//3) * π * a * b * c
        
        # z-coordinate of center of mass: z̄ = (1/M) ∭ z(1+z/c) dV
        # = (1/M) [∭ z dV + (1/c)∭ z² dV]
        # First term = 0 by symmetry
        # For ellipsoid, ∭ z² dV = (4/15)πabc³
        # So z̄ = (1/M) · (1/c) · (4/15)πabc³ = (4πabc²)/(15M) = c/5
        
        z_bar = c // 5
        
        question = "A solid occupies the region inside the ellipsoid " *
                   "\$\\frac{x^2}{$(a^2)} + \\frac{y^2}{$(b^2)} + \\frac{z^2}{$(c^2)} \\leq 1\$ " *
                   "with variable density \$\\rho(x,y,z) = 1 + \\frac{z}{$(c)}\$ (in consistent units). " *
                   "Find the \$z\$-coordinate of the center of mass. Express as a fraction."
        
        solution_text = steps(
            "Mass: \$M = \\iiint_E \\left(1 + \\frac{z}{$(c)}\\right) dV = \\iiint_E 1\\,dV + \\frac{1}{$(c)}\\iiint_E z\\,dV\$",
            "The ellipsoid is symmetric about the \$xy\$-plane, and \$z\$ is odd in \$z\$, so \$\\iiint_E z\\,dV = 0\$",
            sol("M = \\frac{4\\pi \\cdot $(a) \\cdot $(b) \\cdot $(c)}{3}"),
            "For \$\\bar{z}\$: \$\\bar{z} = \\frac{1}{M}\\iiint_E z\\left(1 + \\frac{z}{$(c)}\\right) dV = \\frac{1}{M}\\left[0 + \\frac{1}{$(c)}\\iiint_E z^2\\,dV\\right]\$",
            "For an ellipsoid with semi-axes \$($(a),$(b),$(c))\$: \$\\iiint_E z^2\\,dV = \\frac{4\\pi \\cdot $(a) \\cdot $(b) \\cdot $(c)^3}{15}\$",
            sol("\\bar{z} = \\frac{4\\pi \\cdot $(a) \\cdot $(b) \\cdot $(c^2)}{15M} = \\frac{$(c)}{5}")
        )
        
        problem(
            question=question,
            answer=z_bar,
            difficulty=(4000, 4800),
            solution=solution_text,
            time=540
        )
    end
end