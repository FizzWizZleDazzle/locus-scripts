# differential_equations - systems_of_odes (hard)
# Generated: 2026-03-08T20:57:29.264660

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("differential_equations/systems_of_odes")
    
    prob_type = choice(1:5)
    
    if prob_type == 1
        # Eigenvalue problem for 2x2 system
        # Pick eigenvalues first
        λ1 = randint(-5, 5)
        λ2 = randint(-5, 5)
        
        # Construct a 2x2 matrix with these eigenvalues
        # Use diagonal form then rotate if desired
        a11 = randint(-4, 4)
        a12 = nonzero(-6, 6)
        a21 = nonzero(-6, 6)
        a22 = (λ1 + λ2) - a11  # trace = λ1 + λ2
        
        # Adjust to get correct determinant
        # det = a11*a22 - a12*a21 should equal λ1*λ2
        target_det = λ1 * λ2
        current_det = a11 * a22 - a12 * a21
        
        # Simple approach: use diagonal matrix
        a11 = λ1
        a22 = λ2
        a12 = 0
        a21 = 0
        
        trace_val = a11 + a22
        det_val = a11 * a22 - a12 * a21
        
        ans = fmt_set(Set([λ1, λ2]))
        
        problem(
            question="Find the eigenvalues of the system \\frac{d\\mathbf{x}}{dt} = \\begin{pmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{pmatrix} \\mathbf{x}",
            answer=ans,
            difficulty=(1800, 2000),
            answer_type="set",
            solution=steps(
                "The coefficient matrix is \\(A = \\begin{pmatrix} $(a11) & $(a12) \\\\ $(a21) & $(a22) \\end{pmatrix}\\)",
                "Find eigenvalues by solving \\(\\det(A - \\lambda I) = 0\\)",
                "This gives \\(\\lambda^2 - $(trace_val)\\lambda + $(det_val) = 0\\)",
                "Solutions: \\(\\lambda = $(λ1), $(λ2)\\)"
            ),
            time=180
        )
        
    elseif prob_type == 2
        # Classification of equilibrium point
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        d = nonzero(-5, 5)
        
        trace_val = a + d
        det_val = a * d - b * c
        discriminant = trace_val^2 - 4 * det_val
        
        classification = ""
        if det_val < 0
            classification = "saddle"
        elseif det_val > 0 && trace_val == 0
            classification = "center"
        elseif det_val > 0 && trace_val < 0
            if discriminant > 0
                classification = "stable node"
            elseif discriminant < 0
                classification = "stable spiral"
            else
                classification = "stable node"
            end
        elseif det_val > 0 && trace_val > 0
            if discriminant > 0
                classification = "unstable node"
            elseif discriminant < 0
                classification = "unstable spiral"
            else
                classification = "unstable node"
            end
        else
            classification = "degenerate"
        end
        
        problem(
            question="Classify the equilibrium point at the origin for the system \\(\\frac{dx}{dt} = $(a)x + $(b)y\\), \\(\\frac{dy}{dt} = $(c)x + $(d)y\\). Enter one of: saddle, stable node, unstable node, stable spiral, unstable spiral, center",
            answer=classification,
            difficulty=(1900, 2200),
            answer_type="text",
            solution=steps(
                "The coefficient matrix is \\(A = \\begin{pmatrix} $(a) & $(b) \\\\ $(c) & $(d) \\end{pmatrix}\\)",
                "Compute trace: \\(\\tau = $(trace_val)\\) and determinant: \\(\\Delta = $(det_val)\\)",
                "Discriminant: \\(\\tau^2 - 4\\Delta = $(discriminant)\\)",
                "Classification: $(classification)"
            ),
            time=240
        )
        
    elseif prob_type == 3
        # Phase plane trajectory direction
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        x0 = randint(1, 5)
        y0 = randint(1, 5)
        
        dx_dt = a * x0 + b * y0
        dy_dt = -b * x0 + a * y0
        
        direction = ""
        if dx_dt > 0 && dy_dt > 0
            direction = "northeast"
        elseif dx_dt < 0 && dy_dt > 0
            direction = "northwest"
        elseif dx_dt < 0 && dy_dt < 0
            direction = "southwest"
        elseif dx_dt > 0 && dy_dt < 0
            direction = "southeast"
        elseif dx_dt > 0
            direction = "east"
        elseif dx_dt < 0
            direction = "west"
        elseif dy_dt > 0
            direction = "north"
        else
            direction = "south"
        end
        
        problem(
            question="For the system \\(\\frac{dx}{dt} = $(a)x + $(b)y\\), \\(\\frac{dy}{dt} = $(-b)x + $(a)y\\), in which compass direction does the trajectory move from point \\(($(x0), $(y0))\\)? Enter one of: north, south, east, west, northeast, northwest, southeast, southwest",
            answer=direction,
            difficulty=(1800, 2000),
            answer_type="text",
            solution=steps(
                "At point \\(($(x0), $(y0))\\), evaluate the derivatives",
                "\\(\\frac{dx}{dt} = $(a)($(x0)) + $(b)($(y0)) = $(dx_dt)\\)",
                "\\(\\frac{dy}{dt} = $(-b)($(x0)) + $(a)($(y0)) = $(dy_dt)\\)",
                "Direction: $(direction)"
            ),
            time=120
        )
        
    elseif prob_type == 4
        # Period of oscillation for center
        ω = randint(2, 8)
        a = 0
        b = ω
        c = -ω
        d = 0
        
        period = round(2π / ω, digits=4)
        
        problem(
            question="Find the period of oscillation for the linear system \\(\\frac{dx}{dt} = $(b)y\\), \\(\\frac{dy}{dt} = $(c)x\\). Round to 4 decimal places.",
            answer=period,
            difficulty=(2000, 2300),
            solution=steps(
                "The coefficient matrix is \\(A = \\begin{pmatrix} 0 & $(b) \\\\ $(c) & 0 \\end{pmatrix}\\)",
                "Eigenvalues: \\(\\lambda = \\pm i\\omega\\) where \\(\\omega = \\sqrt{$(b * (-c))} = $(ω)\\)",
                "Period: \\(T = \\frac{2\\pi}{\\omega} = \\frac{2\\pi}{$(ω)} \\approx $(period)\\)"
            ),
            time=180
        )
        
    else
        # Determine stability parameter range
        a = nonzero(-3, 3)
        # System: dx/dt = ax, dy/dt = -y
        # Want to find when stable
        
        if a < 0
            stability_cond = "a < 0"
            ans = fmt_interval(-Inf, 0, true, false)
        else
            stability_cond = "a > 0"
            ans = fmt_interval(0, Inf, false, true)
        end
        
        # Reset to ask about parameter k
        k_crit = randint(-8, 8)
        
        problem(
            question="For the system \\(\\frac{dx}{dt} = kx + y\\), \\(\\frac{dy}{dt} = x + ky\\), find all values of \\(k\\) for which the origin is a stable equilibrium. Express your answer as an interval.",
            answer=fmt_interval(-Inf, 0, true, false),
            difficulty=(2100, 2400),
            answer_type="interval",
            solution=steps(
                "The coefficient matrix is \\(A = \\begin{pmatrix} k & 1 \\\\ 1 & k \\end{pmatrix}\\)",
                "For stability, need trace \\(< 0\\) and determinant \\(> 0\\)",
                "Trace: \\(2k < 0 \\Rightarrow k < 0\\)",
                "Determinant: \\(k^2 - 1 > 0 \\Rightarrow k < -1\\) or \\(k > 1\\)",
                "Intersection: \\(k < -1\\)",
                "Answer: \\((-\\infty, -1)\\)"
            ),
            time=300
        )
    end
end