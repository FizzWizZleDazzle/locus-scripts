# differential_equations - characteristic_equation (very_hard)
# Generated: 2026-03-08T20:54:24.481958

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("differential_equations/characteristic_equation")
    
    # Competition to Olympiad level: 2500-3500 ELO
    # Generate complex characteristic equations with interesting properties
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Higher-order ODE with repeated roots and specific multiplicities
        # Target: 2600-2900 ELO
        r = nonzero(-5, 5)
        m = rand(3:5)  # multiplicity
        
        # Construct characteristic equation: (λ - r)^m = 0
        # Corresponding ODE has solutions of form x^k * e^(rx) for k=0,...,m-1
        
        char_poly = expand((y - r)^m)
        
        # Build the differential operator
        coeffs_list = []
        for i in 0:m
            c = binomial(m, i) * (-r)^(m-i)
            push!(coeffs_list, c)
        end
        
        # Generate ODE notation
        terms = String[]
        for i in m:-1:1
            if i == m
                push!(terms, "y^{($(m))}")
            elseif i == 2
                push!(terms, "$(coeffs_list[m-i+1])y''")
            elseif i == 1
                push!(terms, "$(coeffs_list[m-i+1])y'")
            else
                push!(terms, "$(coeffs_list[m-i+1])y^{($(i))}")
            end
        end
        push!(terms, "$(coeffs_list[m+1])y")
        
        ode_str = join(terms, " + ")
        ode_str = replace(ode_str, "+ -" => "- ")
        
        general_sol_terms = String[]
        for k in 0:(m-1)
            if k == 0
                push!(general_sol_terms, "c_1 e^{$(r)x}")
            else
                push!(general_sol_terms, "c_{$(k+1)} x^{$(k)} e^{$(r)x}")
            end
        end
        general_sol = join(general_sol_terms, " + ")
        
        problem(
            question="Consider the differential equation \$$(ode_str) = 0\$. Find the characteristic equation, determine all roots with their multiplicities, and write the general solution.",
            answer="λ = $(r) (multiplicity $(m))",
            difficulty=(2600, 2900),
            solution=steps(
                "The characteristic equation is obtained by substituting \$y = e^{\\lambda x}\$",
                sol("Characteristic equation", char_poly ~ 0),
                "Factoring: \$(\\lambda - $(r))^{$(m)} = 0\$",
                "Root: \$\\lambda = $(r)\$ with multiplicity \$$(m)\$",
                "General solution: \$y = $(general_sol)\$"
            ),
            time=240
        )
        
    elseif problem_type == 2
        # System of ODEs leading to characteristic equation with complex eigenvalues
        # Target: 2800-3200 ELO
        a = nonzero(-4, 4)
        b = nonzero(2, 8)
        
        # Characteristic equation: λ² - 2aλ + (a² + b²) = 0
        # Roots: λ = a ± bi
        
        char_eq = y^2 - 2*a*y + (a^2 + b^2)
        
        problem(
            question="A system of differential equations has the characteristic equation \$$(tex(char_eq)) = 0\$. Find all eigenvalues and describe the behavior of solutions. Determine if the equilibrium at the origin is stable, unstable, or a center.",
            answer="λ = $(a) ± $(b)i, " * (a > 0 ? "unstable spiral" : a < 0 ? "stable spiral" : "center"),
            difficulty=(2800, 3200),
            solution=steps(
                sol("Given characteristic equation", char_eq ~ 0),
                "Using the quadratic formula: \$\\lambda = \\frac{2($(a)) \\pm \\sqrt{4($(a))^2 - 4($(a^2 + b^2))}}{2}\$",
                "Simplify discriminant: \$4($(a^2)) - 4($(a^2 + b^2)) = -4($(b^2))\$",
                sol("Eigenvalues", "\\lambda = $(a) \\pm $(b)i"),
                "Real part = $(a): " * (a > 0 ? "unstable spiral (trajectories spiral outward)" : a < 0 ? "stable spiral (trajectories spiral to origin)" : "center (closed orbits)"),
                "Solution form: \$e^{$(a)x}(c_1 \\cos($(b)x) + c_2 \\sin($(b)x))\$"
            ),
            time=270
        )
        
    elseif problem_type == 3
        # Fourth-order equation with two pairs of complex conjugate roots
        # Target: 3000-3400 ELO
        a1 = rand(1:3)
        b1 = rand(2:5)
        a2 = rand(-3:-1)
        b2 = rand(2:5)
        
        # (λ - (a1 + b1*i))(λ - (a1 - b1*i))(λ - (a2 + b2*i))(λ - (a2 - b2*i))
        # = (λ² - 2a1*λ + (a1² + b1²))(λ² - 2a2*λ + (a2² + b2²))
        
        factor1 = y^2 - 2*a1*y + (a1^2 + b1^2)
        factor2 = y^2 - 2*a2*y + (a2^2 + b2^2)
        char_eq = expand(factor1 * factor2)
        
        problem(
            question="Solve the characteristic equation \$$(tex(char_eq)) = 0\$ and write the general solution to the corresponding fourth-order linear homogeneous ODE. Classify the stability.",
            answer="λ₁,₂ = $(a1) ± $(b1)i, λ₃,₄ = $(a2) ± $(b2)i",
            difficulty=(3000, 3400),
            solution=steps(
                sol("Characteristic equation", char_eq ~ 0),
                "Factor as product of two quadratics: \$($(tex(factor1)))($(tex(factor2))) = 0\$",
                "From first factor: \$\\lambda^2 - $(2*a1)\\lambda + $(a1^2 + b1^2) = 0\$ gives \$\\lambda = $(a1) \\pm $(b1)i\$",
                "From second factor: \$\\lambda^2 - $(2*a2)\\lambda + $(a2^2 + b2^2) = 0\$ gives \$\\lambda = $(a2) \\pm $(b2)i\$",
                sol("All eigenvalues", "\\lambda_1 = $(a1) + $(b1)i, \\lambda_2 = $(a1) - $(b1)i, \\lambda_3 = $(a2) + $(b2)i, \\lambda_4 = $(a2) - $(b2)i"),
                "General solution: \$y = e^{$(a1)x}(c_1\\cos($(b1)x) + c_2\\sin($(b1)x)) + e^{$(a2)x}(c_3\\cos($(b2)x) + c_4\\sin($(b2)x))\$",
                "Stability: " * (a1 > 0 || a2 > 0 ? "Unstable (positive real part present)" : a1 < 0 && a2 < 0 ? "Asymptotically stable (all negative real parts)" : "Marginally stable")
            ),
            time=300
        )
        
    else
        # Olympiad-style problem: characteristic equation with parameter
        # Target: 3200-3500 ELO
        k = rand(2:6)
        
        # Characteristic equation: λ³ + aλ² + bλ + c = 0
        # Special case where roots have interesting relationship
        
        r1 = rand(2:5)
        # Set r2 = -r1, r3 = k (sum = k, product controlled)
        r2 = -r1
        r3 = k
        
        # (λ - r1)(λ - r2)(λ - r3) = (λ² - r1²)(λ - k)
        char_eq = expand((y - r1)*(y - r2)*(y - r3))
        
        a_coef = -(r1 + r2 + r3)
        b_coef = r1*r2 + r1*r3 + r2*r3
        c_coef = -r1*r2*r3
        
        problem(
            question="Consider the characteristic equation \$$(tex(char_eq)) = 0\$. Prove that if this equation has two roots that are negatives of each other, find all roots and determine the general solution to the corresponding third-order ODE. Verify using Vieta's formulas.",
            answer="Roots: $(r1), $(r2), $(r3)",
            difficulty=(3200, 3500),
            solution=steps(
                sol("Given characteristic equation", char_eq ~ 0),
                "Rewrite: \$\\lambda^3 + $(a_coef)\\lambda^2 + $(b_coef)\\lambda + $(c_coef) = 0\$",
                "If two roots are negatives, say \$r\$ and \$-r\$, then \$(\\lambda^2 - r^2)\$ is a factor",
                "Try factoring: \$(\\lambda^2 - $(r1^2))(\\lambda - $(k)) = 0\$",
                "Expand to verify: \$(\\lambda^2 - $(r1^2))(\\lambda - $(k)) = $(tex(char_eq))\$ ✓",
                sol("Roots", "\\lambda_1 = $(r1), \\lambda_2 = $(r2), \\lambda_3 = $(r3)"),
                "Verify Vieta: sum = $(r1 + r2 + r3) = $(a_coef) ✓, product = $(r1*r2*r3) = $(-c_coef) ✓",
                "General solution: \$y = c_1 e^{$(r1)x} + c_2 e^{$(r2)x} + c_3 e^{$(r3)x}\$"
            ),
            time=300
        )
    end
end