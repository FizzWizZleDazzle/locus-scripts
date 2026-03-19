# multivariable_calculus - stokes_divergence (easy)
# Generated: 2026-03-08T21:06:03.994989

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/stokes_divergence")
    
    problem_type = rand(1:6)
    
    if problem_type == 1
        # Divergence of a simple vector field (700-900 ELO)
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        # F = (ax, by, cz)
        Fx = a * x
        Fy = b * y
        Fz = c * z
        
        div_F = a + b + c
        
        problem(
            question = "Compute the divergence of the vector field \\(\\mathbf{F}(x,y,z) = ($(tex(Fx)), $(tex(Fy)), $(tex(Fz)))\\).",
            answer = div_F,
            difficulty = (700, 900),
            solution = steps(
                "The divergence is \\(\\nabla \\cdot \\mathbf{F} = \\frac{\\partial F_x}{\\partial x} + \\frac{\\partial F_y}{\\partial y} + \\frac{\\partial F_z}{\\partial z}\\)",
                "\\(\\frac{\\partial}{\\partial x}($(tex(Fx))) = $(a)\\), \\(\\frac{\\partial}{\\partial y}($(tex(Fy))) = $(b)\\), \\(\\frac{\\partial}{\\partial z}($(tex(Fz))) = $(c)\\)",
                sol("Answer", div_F)
            ),
            time = 60
        )
        
    elseif problem_type == 2
        # Divergence with polynomial terms (800-1000 ELO)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        # F = (ax^2, by^2, cz^2)
        Fx = a * x^2
        Fy = b * y^2
        Fz = c * z^2
        
        div_F = 2*a*x + 2*b*y + 2*c*z
        
        problem(
            question = "Compute the divergence of the vector field \\(\\mathbf{F}(x,y,z) = ($(tex(Fx)), $(tex(Fy)), $(tex(Fz)))\\).",
            answer = div_F,
            difficulty = (800, 1000),
            solution = steps(
                "The divergence is \\(\\nabla \\cdot \\mathbf{F} = \\frac{\\partial F_x}{\\partial x} + \\frac{\\partial F_y}{\\partial y} + \\frac{\\partial F_z}{\\partial z}\\)",
                "\\(\\frac{\\partial}{\\partial x}($(tex(Fx))) = $(tex(2*a*x))\\), \\(\\frac{\\partial}{\\partial y}($(tex(Fy))) = $(tex(2*b*y))\\), \\(\\frac{\\partial}{\\partial z}($(tex(Fz))) = $(tex(2*c*z))\\)",
                sol("Answer", div_F)
            ),
            time = 90
        )
        
    elseif problem_type == 3
        # Curl of a simple vector field - z-component only (700-900 ELO)
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        
        # F = (ay, bx, 0)
        Fx = a * y
        Fy = b * x
        Fz = 0
        
        curl_z = b - a
        
        problem(
            question = "Compute the z-component of the curl of \\(\\mathbf{F}(x,y,z) = ($(tex(Fx)), $(tex(Fy)), 0)\\).",
            answer = curl_z,
            difficulty = (700, 900),
            solution = steps(
                "The z-component of curl is \\((\\nabla \\times \\mathbf{F})_z = \\frac{\\partial F_y}{\\partial x} - \\frac{\\partial F_x}{\\partial y}\\)",
                "\\(\\frac{\\partial}{\\partial x}($(tex(Fy))) = $(b)\\), \\(\\frac{\\partial}{\\partial y}($(tex(Fx))) = $(a)\\)",
                sol("Answer", curl_z)
            ),
            time = 75
        )
        
    elseif problem_type == 4
        # Divergence at a point (900-1100 ELO)
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        c = nonzero(-4, 4)
        
        x0 = randint(-5, 5)
        y0 = randint(-5, 5)
        z0 = randint(-5, 5)
        
        # F = (ax^2, by^2, cz^2)
        Fx = a * x^2
        Fy = b * y^2
        Fz = c * z^2
        
        div_F = 2*a*x + 2*b*y + 2*c*z
        div_at_point = 2*a*x0 + 2*b*y0 + 2*c*z0
        
        problem(
            question = "Compute the divergence of \\(\\mathbf{F}(x,y,z) = ($(tex(Fx)), $(tex(Fy)), $(tex(Fz)))\\) at the point \\(($(x0), $(y0), $(z0))\\).",
            answer = div_at_point,
            difficulty = (900, 1100),
            solution = steps(
                "First find \\(\\nabla \\cdot \\mathbf{F} = $(tex(2*a*x)) + $(tex(2*b*y)) + $(tex(2*c*z))\\)",
                "Evaluate at \\(($(x0), $(y0), $(z0))\\): \\($(tex(2*a*x0)) + $(tex(2*b*y0)) + $(tex(2*c*z0))\\)",
                sol("Answer", div_at_point)
            ),
            time = 90
        )
        
    elseif problem_type == 5
        # Divergence with mixed terms (900-1100 ELO)
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        d = nonzero(-6, 6)
        
        # F = (axy, byz, czx)
        Fx = a * x * y
        Fy = b * y * z
        Fz = c * z * x
        
        div_F = a*y + b*z + c*x
        
        problem(
            question = "Compute the divergence of \\(\\mathbf{F}(x,y,z) = ($(tex(Fx)), $(tex(Fy)), $(tex(Fz)))\\).",
            answer = div_F,
            difficulty = (900, 1100),
            solution = steps(
                "The divergence is \\(\\nabla \\cdot \\mathbf{F} = \\frac{\\partial F_x}{\\partial x} + \\frac{\\partial F_y}{\\partial y} + \\frac{\\partial F_z}{\\partial z}\\)",
                "\\(\\frac{\\partial}{\\partial x}($(tex(Fx))) = $(tex(a*y))\\), \\(\\frac{\\partial}{\\partial y}($(tex(Fy))) = $(tex(b*z))\\), \\(\\frac{\\partial}{\\partial z}($(tex(Fz))) = $(tex(c*x))\\)",
                sol("Answer", div_F)
            ),
            time = 100
        )
        
    else
        # Check if field is conservative by testing curl = 0 (1000-1200 ELO)
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        
        # Conservative field: F = grad(axy + bz^2) = (ay, ax, 2bz)
        Fx = a * y
        Fy = a * x
        Fz = 2 * b * z
        
        problem(
            question = "Is the vector field \\(\\mathbf{F}(x,y,z) = ($(tex(Fx)), $(tex(Fy)), $(tex(Fz)))\\) conservative? Answer 'yes' or 'no'.",
            answer = "yes",
            difficulty = (1000, 1200),
            answer_type = "string",
            solution = steps(
                "A field is conservative if \\(\\nabla \\times \\mathbf{F} = \\mathbf{0}\\)",
                "Check: \\(\\frac{\\partial F_z}{\\partial y} - \\frac{\\partial F_y}{\\partial z} = 0 - 0 = 0\\), \\(\\frac{\\partial F_x}{\\partial z} - \\frac{\\partial F_z}{\\partial x} = 0 - 0 = 0\\), \\(\\frac{\\partial F_y}{\\partial x} - \\frac{\\partial F_x}{\\partial y} = $(a) - $(a) = 0\\)",
                "Since curl is zero, the field is conservative"
            ),
            time = 120
        )
    end
end