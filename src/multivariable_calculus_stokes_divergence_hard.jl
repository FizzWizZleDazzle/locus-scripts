# multivariable_calculus - stokes_divergence (hard)
# Generated: 2026-03-08T21:06:08.254886

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y z begin
    set_topic!("multivariable_calculus/stokes_divergence")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Compute divergence of a vector field
        a = nonzero(-8, 8)
        b = nonzero(-8, 8)
        c = nonzero(-8, 8)
        
        exp_x = rand(1:3)
        exp_y = rand(1:3)
        exp_z = rand(1:3)
        
        F1 = a * x^exp_x * y
        F2 = b * x * y^exp_y
        F3 = c * y * z^exp_z
        
        div_F = diff(F1, x) + diff(F2, y) + diff(F3, z)
        div_F = simplify(div_F)
        
        problem(
            question = "Calculate the divergence of the vector field \\mathbf{F} = \\langle $(tex(F1)), $(tex(F2)), $(tex(F3)) \\rangle.",
            answer = div_F,
            difficulty = (1800, 2000),
            solution = steps(
                "Divergence is given by \\nabla \\cdot \\mathbf{F} = \\frac{\\partial F_1}{\\partial x} + \\frac{\\partial F_2}{\\partial y} + \\frac{\\partial F_3}{\\partial z}",
                sol("\\frac{\\partial F_1}{\\partial x}", diff(F1, x)),
                sol("\\frac{\\partial F_2}{\\partial y}", diff(F2, y)),
                sol("\\frac{\\partial F_3}{\\partial z}", diff(F3, z)),
                sol("\\nabla \\cdot \\mathbf{F}", div_F)
            ),
            time = 120
        )
        
    elseif problem_type == 2
        # Compute curl of a vector field
        a = nonzero(-6, 6)
        b = nonzero(-6, 6)
        c = nonzero(-6, 6)
        
        F1 = a * y * z
        F2 = b * x * z
        F3 = c * x * y
        
        curl_x = diff(F3, y) - diff(F2, z)
        curl_y = diff(F1, z) - diff(F3, x)
        curl_z = diff(F2, x) - diff(F1, y)
        
        curl_x = simplify(curl_x)
        curl_y = simplify(curl_y)
        curl_z = simplify(curl_z)
        
        ans = "\\langle $(tex(curl_x)), $(tex(curl_y)), $(tex(curl_z)) \\rangle"
        
        problem(
            question = "Calculate the curl of the vector field \\mathbf{F} = \\langle $(tex(F1)), $(tex(F2)), $(tex(F3)) \\rangle.",
            answer = ans,
            difficulty = (1900, 2100),
            answer_type = "expression",
            solution = steps(
                "Curl is given by \\nabla \\times \\mathbf{F} = \\left\\langle \\frac{\\partial F_3}{\\partial y} - \\frac{\\partial F_2}{\\partial z}, \\frac{\\partial F_1}{\\partial z} - \\frac{\\partial F_3}{\\partial x}, \\frac{\\partial F_2}{\\partial x} - \\frac{\\partial F_1}{\\partial y} \\right\\rangle",
                sol("First component", curl_x),
                sol("Second component", curl_y),
                sol("Third component", curl_z),
                sol("\\nabla \\times \\mathbf{F}", ans)
            ),
            time = 180
        )
        
    elseif problem_type == 3
        # Divergence Theorem problem - flux through closed surface
        a = nonzero(-5, 5)
        b = nonzero(-5, 5)
        c = nonzero(-5, 5)
        
        F1 = a * x
        F2 = b * y
        F3 = c * z
        
        div_F = a + b + c
        
        R = rand(2:5)
        volume = (4 // 3) * R^3
        
        flux = div_F * volume
        
        problem(
            question = "Use the Divergence Theorem to find the flux of \\mathbf{F} = \\langle $(tex(F1)), $(tex(F2)), $(tex(F3)) \\rangle outward through the sphere x^2 + y^2 + z^2 = $(R^2).",
            answer = flux,
            difficulty = (2000, 2200),
            solution = steps(
                "By the Divergence Theorem, \\iint_S \\mathbf{F} \\cdot d\\mathbf{S} = \\iiint_E (\\nabla \\cdot \\mathbf{F}) \\, dV",
                sol("\\nabla \\cdot \\mathbf{F}", div_F),
                "The volume of a sphere of radius $(R) is V = \\frac{4}{3}\\pi r^3 = $(tex(volume))\\pi",
                sol("Flux", tex(flux) * "\\pi")
            ),
            time = 180
        )
        
    elseif problem_type == 4
        # Verify if a vector field is conservative (curl = 0)
        a = nonzero(-7, 7)
        b = nonzero(-7, 7)
        
        # Make it conservative by choosing appropriate coefficients
        F1 = a * x + b * y
        F2 = b * x + a * z
        F3 = a * y
        
        curl_x = diff(F3, y) - diff(F2, z)
        curl_y = diff(F1, z) - diff(F3, x)
        curl_z = diff(F2, x) - diff(F1, y)
        
        is_conservative = (curl_x == 0 && curl_y == 0 && curl_z == 0)
        ans = is_conservative ? "Yes" : "No"
        
        problem(
            question = "Is the vector field \\mathbf{F} = \\langle $(tex(F1)), $(tex(F2)), $(tex(F3)) \\rangle conservative? Answer Yes or No.",
            answer = ans,
            difficulty = (1900, 2100),
            answer_type = "text",
            solution = steps(
                "A vector field is conservative if and only if \\nabla \\times \\mathbf{F} = \\mathbf{0}",
                sol("\\frac{\\partial F_3}{\\partial y} - \\frac{\\partial F_2}{\\partial z}", curl_x),
                sol("\\frac{\\partial F_1}{\\partial z} - \\frac{\\partial F_3}{\\partial x}", curl_y),
                sol("\\frac{\\partial F_2}{\\partial x} - \\frac{\\partial F_1}{\\partial y}", curl_z),
                "Since the curl is $(is_conservative ? "zero" : "not zero"), the field is $(is_conservative ? "" : "not ")conservative"
            ),
            time = 150
        )
        
    else
        # Line integral using Stokes' Theorem
        a = nonzero(-4, 4)
        b = nonzero(-4, 4)
        
        F1 = -a * y
        F2 = b * x
        F3 = 0
        
        curl_z = diff(F2, x) - diff(F1, y)
        curl_z = simplify(curl_z)
        
        R = rand(2:6)
        area = R^2
        
        line_integral = curl_z * area
        
        problem(
            question = "Use Stokes' Theorem to evaluate \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} where \\mathbf{F} = \\langle $(tex(F1)), $(tex(F2)), 0 \\rangle and C is the circle x^2 + y^2 = $(R^2) in the xy-plane, oriented counterclockwise.",
            answer = line_integral,
            difficulty = (2100, 2300),
            solution = steps(
                "By Stokes' Theorem, \\oint_C \\mathbf{F} \\cdot d\\mathbf{r} = \\iint_S (\\nabla \\times \\mathbf{F}) \\cdot \\mathbf{n} \\, dS",
                sol("(\\nabla \\times \\mathbf{F})_z", curl_z),
                "For the disk in the xy-plane, \\mathbf{n} = \\mathbf{k} and dS = dA",
                "Area of circle: \\pi r^2 = $(tex(area))\\pi",
                sol("Line integral", tex(line_integral) * "\\pi")
            ),
            time = 200
        )
    end
end