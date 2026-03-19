# precalculus - polar_coordinates (competition)
# Generated: 2026-03-08T20:33:38.457685

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script r θ begin
    set_topic!("precalculus/polar_coordinates")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Complex polar curve with multiple intersections
        n = rand(3:7)
        m = rand(2:5)
        a = rand(2:6)
        b = rand(2:6)
        
        # Curve: r = a + b*cos(n*θ) intersecting with r = m
        # Find exact values where they intersect (requires solving transcendental equations)
        
        intersections = []
        for k in 0:(2*n-1)
            θ_val = (acos((m - a)/b) + 2π*k) / n
            if 0 <= θ_val < 2π && abs(a + b*cos(n*θ_val) - m) < 0.01
                push!(intersections, θ_val)
            end
        end
        
        num_intersections = length(intersections)
        
        problem(
            question="Consider the polar curves \$r = $a + $b\\cos($n\\theta)\$ and \$r = $m\$. Determine the number of intersection points in the region \$0 \\leq \\theta < 2\\pi\$, and find the exact value of \$\\theta\$ for the intersection point in the first quadrant closest to the positive x-axis.",
            answer=num_intersections,
            difficulty=(3500, 4000),
            solution=steps(
                "Set the two equations equal: \$$a + $b\\cos($n\\theta) = $m\$",
                "Solve: \$\\cos($n\\theta) = \\frac{$(m-a)}{$b}\$",
                "Find all solutions in \$[0, 2\\pi)\$ by solving \$$n\\theta = \\pm\\arccos\\left(\\frac{$(m-a)}{$b}\\right) + 2\\pi k\$",
                sol("Number of intersections", num_intersections)
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Area enclosed by polar curve with complex symmetry
        k = rand(3:8)
        a = rand(2:7)
        
        # r^2 = a^2 * cos(k*θ) family (rose-like curves)
        # Computing exact area requires integration and special symmetry arguments
        
        if k % 2 == 0
            area = k * a^2 / 4
            petals = 2*k
        else
            area = k * a^2 / 4
            petals = k
        end
        
        problem(
            question="Find the exact area enclosed by the polar curve \$r^2 = $a^2 \\cos($k\\theta)\$. Express your answer as a rational multiple of \$\\pi\$ if applicable, or in exact form.",
            answer=area,
            difficulty=(3800, 4300),
            solution=steps(
                "Recognize that \$r^2 = $a^2\\cos($k\\theta)\$ is defined when \$\\cos($k\\theta) \\geq 0\$",
                "Use the area formula \$A = \\frac{1}{2}\\int r^2 \\, d\\theta\$",
                "By symmetry, compute the area of one petal and multiply by the number of petals ($petals)",
                "Integrate: \$A = \\frac{1}{2}\\int_0^{\\pi/(2$k)} $a^2\\cos($k\\theta) \\, d\\theta \\times $petals\$",
                sol("Total area", area)
            ),
            time=360
        )
        
    elseif problem_type == 3
        # Arc length of spiral with parameter constraint
        a = rand(1:5)
        b = rand(2:6)
        θ_max = rand(2:4) * π
        
        # Archimedean spiral r = a + b*θ from 0 to θ_max
        # Arc length requires evaluating integral with sqrt(r^2 + (dr/dθ)^2)
        
        integrand_const = sqrt(a^2 + b^2)
        
        problem(
            question="Find the arc length of the Archimedean spiral \$r = $a + $b\\theta\$ from \$\\theta = 0\$ to \$\\theta = $θ_max/π\\pi\$. Your answer should involve an integral that requires substitution or numerical methods.",
            answer="integral",
            difficulty=(3600, 4100),
            solution=steps(
                "Use arc length formula: \$L = \\int_0^{$(θ_max/π)\\pi} \\sqrt{r^2 + \\left(\\frac{dr}{d\\theta}\\right)^2} \\, d\\theta\$",
                "Compute: \$r = $a + $b\\theta\$ and \$\\frac{dr}{d\\theta} = $b\$",
                "Substitute: \$L = \\int_0^{$(θ_max/π)\\pi} \\sqrt{($a + $b\\theta)^2 + $b^2} \\, d\\theta\$",
                "This integral requires hyperbolic substitution or numerical evaluation",
                "The exact form involves \$\\sinh^{-1}\$ and algebraic terms"
            ),
            time=300
        )
        
    elseif problem_type == 4
        # Tangent line to polar curve at specific point
        n = rand(2:5)
        a = rand(2:8)
        k = rand(1:n)
        θ_point = k * π / n
        
        # Curve r = a*sin(n*θ), find tangent line at θ = θ_point
        r_val = a * sin(n * θ_point)
        
        # Tangent slope in Cartesian: dy/dx = (dr/dθ * sin(θ) + r*cos(θ)) / (dr/dθ * cos(θ) - r*sin(θ))
        dr_dθ = a * n * cos(n * θ_point)
        
        if abs(dr_dθ * cos(θ_point) - r_val * sin(θ_point)) > 0.01
            slope_num = dr_dθ * sin(θ_point) + r_val * cos(θ_point)
            slope_den = dr_dθ * cos(θ_point) - r_val * sin(θ_point)
            m = slope_num / slope_den
        else
            m = "undefined"
        end
        
        problem(
            question="For the polar curve \$r = $a\\sin($n\\theta)\$, find the slope of the tangent line at \$\\theta = \\frac{$k\\pi}{$n}\$. Express your answer in exact form.",
            answer=m,
            difficulty=(3700, 4200),
            solution=steps(
                "Convert to Cartesian using \$x = r\\cos\\theta\$, \$y = r\\sin\\theta\$",
                "Compute \$\\frac{dy}{dx} = \\frac{\\frac{dr}{d\\theta}\\sin\\theta + r\\cos\\theta}{\\frac{dr}{d\\theta}\\cos\\theta - r\\sin\\theta}\$",
                "At \$\\theta = \\frac{$k\\pi}{$n}\$: \$r = $(round(r_val, digits=3))\$ and \$\\frac{dr}{d\\theta} = $(round(dr_dθ, digits=3))\$",
                "Substitute and simplify to find the slope",
                sol("Slope", m)
            ),
            time=240
        )
        
    else
        # Intersection area of two Limaçons with optimal strategy
        a₁ = rand(3:8)
        b₁ = rand(2:5)
        a₂ = rand(3:8)
        b₂ = rand(2:5)
        
        # r = a₁ + b₁*cos(θ) and r = a₂ + b₂*sin(θ)
        # Find the area of intersection - requires finding intersection points and careful integration
        
        problem(
            question="Consider the two limaçons \$r = $a₁ + $b₁\\cos\\theta\$ and \$r = $a₂ + $b₂\\sin\\theta\$. Set up (but do not evaluate) the integral(s) needed to find the exact area of their intersection region. Describe the strategy for finding the intersection points.",
            answer="setup",
            difficulty=(4000, 4600),
            solution=steps(
                "Find intersection points by solving \$$a₁ + $b₁\\cos\\theta = $a₂ + $b₂\\sin\\theta\$",
                "This transcendental equation may have 0, 2, or 4 solutions depending on parameters",
                "Use graphical analysis or numerical methods to locate all \$\\theta_i\$ where curves intersect",
                "Set up area as sum of regions: \$A = \\sum \\frac{1}{2}\\int_{\\theta_i}^{\\theta_{i+1}} (r_1^2 - r_2^2) \\, d\\theta\$",
                "Determine which curve is outer/inner in each angular sector",
                "The final area requires numerical integration or special function evaluation"
            ),
            time=360
        )
    end
end