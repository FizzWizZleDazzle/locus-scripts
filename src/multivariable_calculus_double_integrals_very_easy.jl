# multivariable_calculus - double_integrals (very_easy)
# Generated: 2026-03-08T21:00:52.331069

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y begin
    set_topic!("multivariable_calculus/double_integrals")
    
    prob_type = rand(1:5)
    
    if prob_type == 1
        # ELO 200-400: Evaluate a simple constant double integral
        c = randint(1, 9)
        x_lower = randint(0, 3)
        x_upper = randint(x_lower + 1, x_lower + 5)
        y_lower = randint(0, 3)
        y_upper = randint(y_lower + 1, y_lower + 5)
        
        dx = x_upper - x_lower
        dy = y_upper - y_lower
        ans = c * dx * dy
        
        problem(
            question="Evaluate the double integral: \$\\int_{$(y_lower)}^{$(y_upper)} \\int_{$(x_lower)}^{$(x_upper)} $(c) \\, dx \\, dy\$",
            answer=ans,
            difficulty=(200, 400),
            solution=steps(
                "Integrate the constant $(c) with respect to \$x\$ from $(x_lower) to $(x_upper)",
                sol("After x-integration", "$(c) \\cdot ($(x_upper) - $(x_lower)) = $(c * dx)"),
                "Now integrate $(c * dx) with respect to \$y\$ from $(y_lower) to $(y_upper)",
                sol("Answer", ans)
            ),
            time=60
        )
        
    elseif prob_type == 2
        # ELO 300-500: Integrate a simple linear function in one variable
        a = randint(1, 6)
        x_lower = randint(0, 2)
        x_upper = randint(x_lower + 1, x_lower + 4)
        y_lower = randint(0, 2)
        y_upper = randint(y_lower + 1, y_lower + 4)
        
        dx = x_upper - x_lower
        dy = y_upper - y_lower
        
        # Integral of ax from x_lower to x_upper
        x_integral = a * (x_upper^2 - x_lower^2) // 2
        ans = x_integral * dy
        
        problem(
            question="Evaluate the double integral: \$\\int_{$(y_lower)}^{$(y_upper)} \\int_{$(x_lower)}^{$(x_upper)} $(a)x \\, dx \\, dy\$",
            answer=ans,
            difficulty=(300, 500),
            solution=steps(
                "First integrate \$$(a)x\$ with respect to \$x\$",
                sol("After x-integration", "\\left[\\frac{$(a)x^2}{2}\\right]_{$(x_lower)}^{$(x_upper)} = \\frac{$(a)}{2}($(x_upper)^2 - $(x_lower)^2) = $(x_integral)"),
                "Now integrate $(x_integral) with respect to \$y\$ from $(y_lower) to $(y_upper)",
                sol("Answer", ans)
            ),
            time=90
        )
        
    elseif prob_type == 3
        # ELO 400-600: Integrate xy over a rectangular region
        x_lower = randint(0, 2)
        x_upper = randint(x_lower + 1, x_lower + 3)
        y_lower = randint(0, 2)
        y_upper = randint(y_lower + 1, y_lower + 3)
        
        # Integral of x from x_lower to x_upper: (x_upper^2 - x_lower^2)/2
        x_part = (x_upper^2 - x_lower^2) // 2
        # Integral of y from y_lower to y_upper: (y_upper^2 - y_lower^2)/2
        y_part = (y_upper^2 - y_lower^2) // 2
        ans = x_part * y_part
        
        problem(
            question="Evaluate the double integral: \$\\int_{$(y_lower)}^{$(y_upper)} \\int_{$(x_lower)}^{$(x_upper)} xy \\, dx \\, dy\$",
            answer=ans,
            difficulty=(400, 600),
            solution=steps(
                "First integrate \$xy\$ with respect to \$x\$, treating \$y\$ as constant",
                sol("After x-integration", "y \\cdot \\left[\\frac{x^2}{2}\\right]_{$(x_lower)}^{$(x_upper)} = y \\cdot \\frac{$(x_upper)^2 - $(x_lower)^2}{2} = $(x_part)y"),
                "Now integrate \$$(x_part)y\$ with respect to \$y\$ from $(y_lower) to $(y_upper)",
                sol("After y-integration", "$(x_part) \\cdot \\left[\\frac{y^2}{2}\\right]_{$(y_lower)}^{$(y_upper)} = $(x_part) \\cdot $(y_part)"),
                sol("Answer", ans)
            ),
            time=120
        )
        
    elseif prob_type == 4
        # ELO 500-700: Integrate x + y over a rectangular region
        x_lower = randint(0, 2)
        x_upper = randint(x_lower + 2, x_lower + 4)
        y_lower = randint(0, 2)
        y_upper = randint(y_lower + 2, y_lower + 4)
        
        dx = x_upper - x_lower
        dy = y_upper - y_lower
        
        # Integral of (x + y) dx dy splits into two parts
        # Part 1: integral of x dx = (x_upper^2 - x_lower^2)/2, then times dy
        x_integral = (x_upper^2 - x_lower^2) // 2
        part1 = x_integral * dy
        
        # Part 2: integral of y dx = y * dx, then integral of that dy = (y_upper^2 - y_lower^2)/2 * dx
        y_integral = (y_upper^2 - y_lower^2) // 2
        part2 = y_integral * dx
        
        ans = part1 + part2
        
        problem(
            question="Evaluate the double integral: \$\\int_{$(y_lower)}^{$(y_upper)} \\int_{$(x_lower)}^{$(x_upper)} (x + y) \\, dx \\, dy\$",
            answer=ans,
            difficulty=(500, 700),
            solution=steps(
                "Split the integral: \$\\int\\int (x + y) \\, dx \\, dy = \\int\\int x \\, dx \\, dy + \\int\\int y \\, dx \\, dy\$",
                "For the first part, integrate \$x\$ with respect to \$x\$: \$\\frac{x^2}{2}\\big|_{$(x_lower)}^{$(x_upper)} = $(x_integral)\$, then integrate over \$y\$: \$$(x_integral) \\cdot $(dy) = $(part1)\$",
                "For the second part, integrate \$y\$ with respect to \$x\$: \$y \\cdot $(dx)\$, then integrate over \$y\$: \$$(dx) \\cdot \\frac{y^2}{2}\\big|_{$(y_lower)}^{$(y_upper)} = $(part2)\$",
                sol("Answer", ans)
            ),
            time=150
        )
        
    else
        # ELO 400-650: Simple quadratic function in one variable
        a = randint(1, 4)
        x_lower = randint(0, 2)
        x_upper = randint(x_lower + 1, x_lower + 3)
        y_lower = randint(0, 2)
        y_upper = randint(y_lower + 1, y_lower + 3)
        
        dy = y_upper - y_lower
        
        # Integral of ax^2 from x_lower to x_upper
        x_integral = a * (x_upper^3 - x_lower^3) // 3
        ans = x_integral * dy
        
        problem(
            question="Evaluate the double integral: \$\\int_{$(y_lower)}^{$(y_upper)} \\int_{$(x_lower)}^{$(x_upper)} $(a)x^2 \\, dx \\, dy\$",
            answer=ans,
            difficulty=(400, 650),
            solution=steps(
                "First integrate \$$(a)x^2\$ with respect to \$x\$",
                sol("After x-integration", "\\left[\\frac{$(a)x^3}{3}\\right]_{$(x_lower)}^{$(x_upper)} = \\frac{$(a)}{3}($(x_upper)^3 - $(x_lower)^3) = $(x_integral)"),
                "Now integrate $(x_integral) with respect to \$y\$ from $(y_lower) to $(y_upper)",
                sol("Answer", ans)
            ),
            time=120
        )
    end
end