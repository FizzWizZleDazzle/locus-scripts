# calculus - volumes_of_revolution (easy)
# Generated: 2026-03-08T20:48:42.522513

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x begin
    set_topic!("calculus/volumes_of_revolution")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Disk method: revolve y = constant or y = mx around x-axis
        a = randint(1, 8)
        b = randint(a+1, a+6)
        
        if choice([true, false])
            # Constant function y = k
            k = randint(2, 8)
            f_expr = k
            volume = π * k^2 * (b - a)
            integrand = k^2
            
            soln = steps(
                "Revolve \$y = $(k)\$ around the x-axis from \$x = $(a)\$ to \$x = $(b)\$",
                sol("Volume formula", "V = \\pi \\int_{$(a)}^{$(b)} [f(x)]^2 \\, dx"),
                sol("Setup", "V = \\pi \\int_{$(a)}^{$(b)} $(k^2) \\, dx"),
                sol("Evaluate", "V = $(k^2)\\pi (x) \\Big|_{$(a)}^{$(b)} = $(k^2)\\pi($(b) - $(a))"),
                sol("Answer", "V = $(volume//π)\\pi")
            )
            
            ans_tex = "$(volume//π)\\pi"
        else
            # Linear function y = cx
            c = randint(1, 5)
            f_expr = c*x
            volume = π * c^2 * (b^3 - a^3) // 3
            
            soln = steps(
                "Revolve \$y = $(c)x\$ around the x-axis from \$x = $(a)\$ to \$x = $(b)\$",
                sol("Volume formula", "V = \\pi \\int_{$(a)}^{$(b)} [f(x)]^2 \\, dx"),
                sol("Setup", "V = \\pi \\int_{$(a)}^{$(b)} ($(c)x)^2 \\, dx = $(c^2)\\pi \\int_{$(a)}^{$(b)} x^2 \\, dx"),
                sol("Evaluate", "V = $(c^2)\\pi \\cdot \\frac{x^3}{3} \\Big|_{$(a)}^{$(b)} = $(c^2)\\pi \\cdot \\frac{$(b^3) - $(a^3)}{3}"),
                sol("Answer", "V = \\frac{$(c^2 * (b^3 - a^3))}{3}\\pi")
            )
            
            ans_tex = "\\frac{$(c^2 * (b^3 - a^3))}{3}\\pi"
        end
        
        problem(
            question = "Find the volume of the solid obtained by revolving the region bounded by \$y = $(tex(f_expr))\$, \$x = $(a)\$, \$x = $(b)\$, and the x-axis around the x-axis.",
            answer = ans_tex,
            difficulty = (700, 900),
            solution = soln,
            time = 120
        )
        
    elseif problem_type == 2
        # Disk method: revolve y = √x around x-axis
        a = choice([0, 1])
        b = randint(4, 16)
        
        volume = π * (b^2 - a^2) // 2
        
        soln = steps(
            "Revolve \$y = \\sqrt{x}\$ around the x-axis from \$x = $(a)\$ to \$x = $(b)\$",
            sol("Volume formula", "V = \\pi \\int_{$(a)}^{$(b)} [f(x)]^2 \\, dx"),
            sol("Setup", "V = \\pi \\int_{$(a)}^{$(b)} (\\sqrt{x})^2 \\, dx = \\pi \\int_{$(a)}^{$(b)} x \\, dx"),
            sol("Evaluate", "V = \\pi \\cdot \\frac{x^2}{2} \\Big|_{$(a)}^{$(b)} = \\pi \\cdot \\frac{$(b^2) - $(a^2)}{2}"),
            sol("Answer", "V = \\frac{$(b^2 - a^2)}{2}\\pi")
        )
        
        problem(
            question = "Find the volume of the solid obtained by revolving the region bounded by \$y = \\sqrt{x}\$, \$x = $(a)\$, \$x = $(b)\$, and the x-axis around the x-axis.",
            answer = "\\frac{$(b^2 - a^2)}{2}\\pi",
            difficulty = (800, 1000),
            solution = soln,
            time = 150
        )
        
    elseif problem_type == 3
        # Washer method: revolve region between y = c and y = mx around x-axis
        a = randint(1, 6)
        b = randint(a+2, a+8)
        k = randint(2, 7)
        m = randint(1, 3)
        
        # Outer radius: y = k, Inner radius: y = mx
        outer_vol = π * k^2 * (b - a)
        inner_vol = π * m^2 * (b^3 - a^3) // 3
        volume = outer_vol - inner_vol
        
        soln = steps(
            "Revolve region between \$y = $(k)\$ and \$y = $(m)x\$ around the x-axis from \$x = $(a)\$ to \$x = $(b)\$",
            sol("Washer method", "V = \\pi \\int_{$(a)}^{$(b)} [R(x)^2 - r(x)^2] \\, dx"),
            sol("Setup", "V = \\pi \\int_{$(a)}^{$(b)} [$(k^2) - $(m^2)x^2] \\, dx"),
            sol("Evaluate", "V = \\pi [$(k^2)x - \\frac{$(m^2)x^3}{3}] \\Big|_{$(a)}^{$(b)}"),
            sol("Answer", "V = \\pi[$(k^2 * b) - \\frac{$(m^2 * b^3)}{3} - $(k^2 * a) + \\frac{$(m^2 * a^3)}{3}]")
        )
        
        numer = 3*k^2*(b-a) - m^2*(b^3 - a^3)
        
        problem(
            question = "Find the volume of the solid obtained by revolving the region bounded by \$y = $(k)\$, \$y = $(m)x\$, \$x = $(a)\$, and \$x = $(b)\$ around the x-axis.",
            answer = "\\frac{$(numer)}{3}\\pi",
            difficulty = (900, 1100),
            solution = soln,
            time = 180
        )
        
    else
        # Shell method: revolve y = k around y-axis
        a = randint(1, 6)
        b = randint(a+2, a+8)
        k = randint(2, 8)
        
        volume = π * k * (b^2 - a^2)
        
        soln = steps(
            "Revolve \$y = $(k)\$ around the y-axis from \$x = $(a)\$ to \$x = $(b)\$",
            sol("Shell method", "V = 2\\pi \\int_{$(a)}^{$(b)} x \\cdot f(x) \\, dx"),
            sol("Setup", "V = 2\\pi \\int_{$(a)}^{$(b)} x \\cdot $(k) \\, dx = $(2*k)\\pi \\int_{$(a)}^{$(b)} x \\, dx"),
            sol("Evaluate", "V = $(2*k)\\pi \\cdot \\frac{x^2}{2} \\Big|_{$(a)}^{$(b)} = $(k)\\pi($(b^2) - $(a^2))"),
            sol("Answer", "V = $(k*(b^2 - a^2))\\pi")
        )
        
        problem(
            question = "Find the volume of the solid obtained by revolving the region bounded by \$y = $(k)\$, \$x = $(a)\$, \$x = $(b)\$, and the x-axis around the y-axis using the shell method.",
            answer = "$(k*(b^2 - a^2))\\pi",
            difficulty = (1000, 1200),
            solution = soln,
            time = 180
        )
    end
end