# multivariable_calculus - stokes_divergence (medium)
# Generated: 2026-03-08T21:06:05.722254

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/stokes_divergence")
    
    problem_type = choice([:divergence_compute, :curl_compute, :div_theorem, :stokes_theorem, :verify_divergence])
    
    if problem_type == :divergence_compute
        # Compute divergence of a vector field
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        exp_x = randint(1, 3)
        exp_y = randint(1, 3)
        exp_z = randint(1, 3)
        
        F_x = a * x^exp_x * y
        F_y = b * y^exp_y * z
        F_z = c * z^exp_z * x
        
        div_F = diff(F_x, x) + diff(F_y, y) + diff(F_z, z)
        div_F_simplified = simplify(expand(div_F))
        
        problem(
            question="Compute the divergence of the vector field \\(\\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), $(tex(F_z)) \\rangle\\)",
            answer=div_F_simplified,
            difficulty=(1200, 1400),
            solution=steps(
                "Divergence formula: \\(\\nabla \\cdot \\mathbf{F} = \\frac{\\partial F_x}{\\partial x} + \\frac{\\partial F_y}{\\partial y} + \\frac{\\partial F_z}{\\partial z}\\)",
                sol("\\frac{\\partial F_x}{\\partial x}", diff(F_x, x)),
                sol("\\frac{\\partial F_y}{\\partial y}", diff(F_y, y)),
                sol("\\frac{\\partial F_z}{\\partial z}", diff(F_z, z)),
                sol("\\nabla \\cdot \\mathbf{F}", div_F_simplified)
            ),
            time=120
        )
        
    elseif problem_type == :curl_compute
        # Compute curl of a vector field
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        
        F_x = a * y * z
        F_y = b * x * z
        F_z = c * x * y
        
        curl_x = diff(F_z, y) - diff(F_y, z)
        curl_y = diff(F_x, z) - diff(F_z, x)
        curl_z = diff(F_y, x) - diff(F_x, y)
        
        curl_x_simplified = simplify(expand(curl_x))
        curl_y_simplified = simplify(expand(curl_y))
        curl_z_simplified = simplify(expand(curl_z))
        
        problem(
            question="Compute the curl of the vector field \\(\\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), $(tex(F_z)) \\rangle\\)",
            answer="\\langle $(tex(curl_x_simplified)), $(tex(curl_y_simplified)), $(tex(curl_z_simplified)) \\rangle",
            difficulty=(1300, 1500),
            solution=steps(
                "Curl formula: \\(\\nabla \\times \\mathbf{F} = \\langle \\frac{\\partial F_z}{\\partial y} - \\frac{\\partial F_y}{\\partial z}, \\frac{\\partial F_x}{\\partial z} - \\frac{\\partial F_z}{\\partial x}, \\frac{\\partial F_y}{\\partial x} - \\frac{\\partial F_x}{\\partial y} \\rangle\\)",
                "Compute each component:",
                sol("i-component", curl_x_simplified),
                sol("j-component", curl_y_simplified),
                sol("k-component", curl_z_simplified),
                "Answer: \\(\\langle $(tex(curl_x_simplified)), $(tex(curl_y_simplified)), $(tex(curl_z_simplified)) \\rangle\\)"
            ),
            time=180
        )
        
    elseif problem_type == :div_theorem
        # Divergence theorem on a box
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        F_x = a * x
        F_y = b * y
        F_z = 0
        
        div_F = diff(F_x, x) + diff(F_y, y)
        
        L = randint(2, 6)
        W = randint(2, 6)
        H = randint(2, 6)
        
        volume = L * W * H
        flux = div_F * volume
        
        problem(
            question="Use the Divergence Theorem to find the outward flux of \\(\\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), 0 \\rangle\\) through the closed rectangular box \\([0, $L] \\times [0, $W] \\times [0, $H]\\).",
            answer=flux,
            difficulty=(1400, 1600),
            solution=steps(
                "By the Divergence Theorem: \\(\\iint_S \\mathbf{F} \\cdot d\\mathbf{S} = \\iiint_V \\nabla \\cdot \\mathbf{F} \\, dV\\)",
                sol("\\nabla \\cdot \\mathbf{F}", div_F),
                "The divergence is constant, so:",
                sol("\\text{Flux}", "$(tex(div_F)) \\cdot $(L) \\cdot $(W) \\cdot $(H) = $(flux)")
            ),
            time=150
        )
        
    elseif problem_type == :stokes_theorem
        # Stokes' theorem: curl field around a triangle in xy-plane
        a = nonzero(-4, 4)
        
        F_x = -a * y
        F_y = a * x
        F_z = 0
        
        curl_z = diff(F_y, x) - diff(F_x, y)
        curl_z_simplified = simplify(curl_z)
        
        base = randint(3, 8)
        height = randint(3, 8)
        area = base * height // 2
        
        circulation = curl_z_simplified * area
        
        problem(
            question="Use Stokes' Theorem to compute the circulation \\(\\oint_C \\mathbf{F} \\cdot d\\mathbf{r}\\) where \\(\\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), 0 \\rangle\\) and \\(C\\) is the boundary of the triangle with vertices \\((0,0,0)\\), \\(($base, 0, 0)\\), and \\((0, $height, 0)\\), oriented counterclockwise.",
            answer=circulation,
            difficulty=(1500, 1700),
            solution=steps(
                "By Stokes' Theorem: \\(\\oint_C \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_S (\\nabla \\times \\mathbf{F}) \\cdot d\\mathbf{S}\\)",
                "Compute the k-component of curl:",
                sol("(\\nabla \\times \\mathbf{F})_z", curl_z_simplified),
                "The surface is in the xy-plane with normal \\(\\mathbf{k}\\)",
                sol("\\text{Area of triangle}", area),
                sol("\\text{Circulation}", circulation)
            ),
            time=180
        )
        
    else  # verify_divergence
        # Verify if a field is divergence-free
        a = nonzero(-5, 5)
        
        # Construct a divergence-free field (curl of something)
        F_x = -a * y
        F_y = a * x
        F_z = 0
        
        div_F = diff(F_x, x) + diff(F_y, y) + diff(F_z, z)
        div_F_simplified = simplify(expand(div_F))
        
        is_div_free = (div_F_simplified == 0)
        
        problem(
            question="Determine whether the vector field \\(\\mathbf{F} = \\langle $(tex(F_x)), $(tex(F_y)), $(tex(F_z)) \\rangle\\) is divergence-free. Enter 1 for yes, 0 for no.",
            answer=is_div_free ? 1 : 0,
            difficulty=(1200, 1400),
            solution=steps(
                "A field is divergence-free if \\(\\nabla \\cdot \\mathbf{F} = 0\\)",
                sol("\\frac{\\partial F_x}{\\partial x}", diff(F_x, x)),
                sol("\\frac{\\partial F_y}{\\partial y}", diff(F_y, y)),
                sol("\\frac{\\partial F_z}{\\partial z}", diff(F_z, z)),
                sol("\\nabla \\cdot \\mathbf{F}", div_F_simplified),
                is_div_free ? "The field is divergence-free." : "The field is NOT divergence-free."
            ),
            time=120
        )
    end
end