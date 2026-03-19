# differential_equations - systems_of_odes (competition)
# Generated: 2026-03-08T20:58:01.107765

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/systems_of_odes")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Nonlinear system with invariant manifold analysis (ELO 3500-4000)
        a = nonzero(-3, 3)
        b = nonzero(-3, 3)
        c = nonzero(-3, 3)
        
        # System: x' = ax + y^2, y' = bx + cy
        # Find invariant manifolds and analyze stability
        
        problem(
            question="Consider the system of ODEs:\n\$\$\\begin{cases} \\frac{dx}{dt} = $(a)x + y^2 \\\\ \\frac{dy}{dt} = $(b)x + $(c)y \\end{cases}\$\$\n\nProve or disprove: There exists a polynomial invariant manifold of the form \$y = kx^2\$ for some constant \$k\$. If it exists, find \$k\$ and determine the stability of trajectories on this manifold near the origin.",
            answer="k = $(a//c), unstable",
            difficulty=(3600, 3900),
            solution=steps(
                "Assume invariant manifold \$y = kx^2\$ exists",
                "Differentiate: \$\\frac{dy}{dt} = 2kx\\frac{dx}{dt} = 2kx(ax + k^2x^4)\$",
                "From system: \$\\frac{dy}{dt} = bx + cky^2 = bx + ck^3x^4\$",
                "Equate coefficients: \$2ka = b\$ and higher order terms vanish when \$y = kx^2\$",
                sol("Solution", "k = $(a//c)"),
                "Linearize on manifold: substitute \$y = $(a//c)x^2\$ into first equation",
                "Stability analysis shows trajectories diverge from origin along this manifold"
            ),
            time=300,
        )
        
    elseif problem_type == 2
        # Hamiltonian system with first integral (ELO 3700-4200)
        α = nonzero(-4, 4)
        β = nonzero(-4, 4)
        γ = randint(2, 5)
        
        # System with Hamiltonian structure
        problem(
            question="Consider the autonomous system:\n\$\$\\begin{cases} \\frac{dx}{dt} = y(x^2 + y^2)^{$(γ-1)} \\\\ \\frac{dy}{dt} = -x(x^2 + y^2)^{$(γ-1)} \\end{cases}\$\$\n\nFind a non-constant first integral \$H(x,y)\$ such that \$\\frac{dH}{dt} = 0\$ along solution trajectories. Then, prove that all non-equilibrium trajectories are periodic and determine their period as a function of initial conditions.",
            answer="H(x,y) = (x^2 + y^2)^{$(γ)}/$(2γ), period = 2π/$(γ)",
            difficulty=(3800, 4200),
            solution=steps(
                "Try \$H(x,y) = (x^2 + y^2)^n\$ for some \$n\$",
                sol("Compute", "\\frac{\\partial H}{\\partial x} = 2nx(x^2 + y^2)^{n-1}, \\quad \\frac{\\partial H}{\\partial y} = 2ny(x^2 + y^2)^{n-1}"),
                sol("Chain rule", "\\frac{dH}{dt} = 2nx(x^2+y^2)^{n-1} \\cdot y(x^2+y^2)^{$(γ-1)} - 2ny(x^2+y^2)^{n-1} \\cdot x(x^2+y^2)^{$(γ-1)} = 0"),
                "This vanishes for all \$n\$, choose \$n = $(γ)\$",
                sol("First integral", "H(x,y) = (x^2 + y^2)^{$(γ)}"),
                "Level curves \$H = c\$ are circles, system rotates with angular velocity \$\\omega = r^{$(2(γ-1))}\$ where \$r^2 = x^2 + y^2\$",
                sol("Period", "T = \\frac{2\\pi}{r^{$(2(γ-1))}} = 2\\pi \\cdot r^{-$(2(γ-1))} = \\frac{2\\pi}{$(γ)} \\cdot (H)^{-\\frac{$(γ-1)}{$(γ)}}")
            ),
            time=300,
        )
        
    elseif problem_type == 3
        # Center manifold reduction for bifurcation (ELO 3900-4500)
        μ_crit = choice([-1, 0, 1])
        
        problem(
            question="Consider the parameter-dependent system:\n\$\$\\begin{cases} \\frac{dx}{dt} = \\mu x - y - x^2y \\\\ \\frac{dy}{dt} = x + \\mu y + xy^2 \\end{cases}\$\$\n\nUsing center manifold theory, determine the local behavior near the origin as the parameter \$\\mu\$ passes through zero. Specifically:\n(a) Show the linearization at \$\\mu = 0\$ has purely imaginary eigenvalues\n(b) Compute the center manifold to second order\n(c) Determine whether a Hopf bifurcation occurs and find the first Lyapunov coefficient to determine stability of the bifurcating periodic orbit.",
            answer="Supercritical Hopf bifurcation at μ=0, stable limit cycle for μ>0",
            difficulty=(4000, 4500),
            solution=steps(
                sol("Linearization at μ=0", "J = \\begin{pmatrix} 0 & -1 \\\\ 1 & 0 \\end{pmatrix}"),
                sol("Eigenvalues", "\\lambda = \\pm i"),
                "Center manifold theorem applies since eigenvalues on imaginary axis",
                "Convert to polar coordinates: \$x = r\\cos\\theta, y = r\\sin\\theta\$",
                "Compute \$\\frac{dr}{dt} = \\mu r - r^3(\\cos^2\\theta\\sin\\theta - \\sin\\theta\\cos^2\\theta) + O(r^5)\$",
                "Average over period: \$\\frac{dr}{dt} \\approx \\mu r + ar^3\$ where \$a < 0\$",
                "First Lyapunov coefficient \$a < 0\$ implies supercritical Hopf bifurcation",
                sol("Conclusion", "Stable limit cycle emerges for \\mu > 0 with radius \\sim \\sqrt{\\mu}")
            ),
            time=300,
        )
        
    else
        # Heteroclinic orbit and separatrix analysis (ELO 3600-4100)
        a = choice([1, 2, 3])
        
        problem(
            question="Consider the planar system:\n\$\$\\begin{cases} \\frac{dx}{dt} = y \\\\ \\frac{dy}{dt} = x - x^{$(2a+1)} \\end{cases}\$\$\n\nThis system has equilibrium points at \$x = 0, \\pm 1\$.\n(a) Classify each equilibrium point\n(b) Prove the existence of heteroclinic orbits connecting the saddles at \$x = \\pm 1\$ to the center at the origin\n(c) Find an explicit formula for the separatrix curve passing through \$(1, 0)\$ in the form \$E(x,y) = \\text{constant}\$.",
            answer="E(x,y) = y^2/2 + x^2/2 - x^{$(2a+2)}/$(2a+2) = 1/$(2a+2)",
            difficulty=(3700, 4100),
            solution=steps(
                sol("Energy function", "E(x,y) = \\frac{y^2}{2} - \\int_0^x (s - s^{$(2a+1)})ds = \\frac{y^2}{2} + \\frac{x^2}{2} - \\frac{x^{$(2a+2)}}{$(2a+2)}"),
                sol("Verify conserved", "\\frac{dE}{dt} = y\\frac{dy}{dt} - (x - x^{$(2a+1)})\\frac{dx}{dt} = y(x - x^{$(2a+1)}) - (x - x^{$(2a+1)})y = 0"),
                "At \$(1,0)\$: \$E = \\frac{1}{2} - \\frac{1}{$(2a+2)} = \\frac{$(a+1)}{$(2a+2)}\$",
                "Linearize at origin: eigenvalues \$\\pm i\$ (center)",
                "Linearize at \$(\\pm 1, 0)\$: eigenvalues real with opposite signs (saddles)",
                sol("Separatrix", "\\frac{y^2}{2} + \\frac{x^2}{2} - \\frac{x^{$(2a+2)}}{$(2a+2)} = \\frac{$(a+1)}{$(2a+2)}"),
                "This curve connects the saddle points to the center as \$t \\to \\pm\\infty\$"
            ),
            time=300,
        )
    end
end