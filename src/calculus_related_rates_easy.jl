# calculus - related_rates (easy)
# Generated: 2026-03-08T20:41:18.025063

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script t begin
    set_topic!("calculus/related_rates")
    
    problem_type = choice(1:4)
    
    if problem_type == 1
        # Expanding circle - basic related rates
        radius_val = randint(3, 12)
        dr_dt = randint(2, 8)
        
        # A = πr², dA/dt = 2πr(dr/dt)
        dA_dt = 2 * π * radius_val * dr_dt
        
        problem(
            question="A circular oil spill is expanding. When the radius is $(radius_val) meters, it is increasing at $(dr_dt) m/s. How fast is the area increasing at that moment? (Leave answer in terms of π)",
            answer=dA_dt,
            difficulty=(800, 1000),
            solution=steps(
                "Given: r = $(radius_val) m, dr/dt = $(dr_dt) m/s",
                sol("Area formula", "A = \\pi r^2"),
                sol("Differentiate", "\\frac{dA}{dt} = 2\\pi r \\frac{dr}{dt}"),
                "Substitute: dA/dt = 2π($(radius_val))($(dr_dt)) = $(Int(2 * radius_val * dr_dt))π m²/s",
                sol("Answer", "$(Int(2 * radius_val * dr_dt))\\pi \\text{ m}^2/\\text{s}")
            ),
            time=90,
        )
        
    elseif problem_type == 2
        # Expanding sphere volume - slightly harder
        radius_val = randint(4, 10)
        dr_dt = randint(1, 6)
        
        # V = (4/3)πr³, dV/dt = 4πr²(dr/dt)
        dV_dt = 4 * π * radius_val^2 * dr_dt
        
        problem(
            question="A spherical balloon is being inflated. When the radius is $(radius_val) cm, it is increasing at $(dr_dt) cm/s. How fast is the volume increasing? (Leave answer in terms of π)",
            answer=dV_dt,
            difficulty=(900, 1100),
            solution=steps(
                "Given: r = $(radius_val) cm, dr/dt = $(dr_dt) cm/s",
                sol("Volume formula", "V = \\frac{4}{3}\\pi r^3"),
                sol("Differentiate", "\\frac{dV}{dt} = 4\\pi r^2 \\frac{dr}{dt}"),
                "Substitute: dV/dt = 4π($(radius_val))²($(dr_dt)) = 4π($(radius_val^2))($(dr_dt)) = $(Int(4 * radius_val^2 * dr_dt))π cm³/s",
                sol("Answer", "$(Int(4 * radius_val^2 * dr_dt))\\pi \\text{ cm}^3/\\text{s}")
            ),
            time=120,
        )
        
    elseif problem_type == 3
        # Sliding ladder - Pythagorean relationship
        ladder_length = randint(10, 20)
        x_val = randint(5, Int(floor(ladder_length * 0.7)))
        dx_dt = randint(2, 6)
        
        # x² + y² = L², y = sqrt(L² - x²)
        y_val = Int(round(sqrt(ladder_length^2 - x_val^2)))
        
        # 2x(dx/dt) + 2y(dy/dt) = 0, so dy/dt = -(x/y)(dx/dt)
        dy_dt = -(x_val * dx_dt) // y_val
        
        problem(
            question="A $(ladder_length)-foot ladder is sliding down a wall. When the bottom is $(x_val) feet from the wall, it is sliding away at $(dx_dt) ft/s. How fast is the top sliding down? (Give exact answer as a fraction)",
            answer=dy_dt,
            difficulty=(1000, 1200),
            solution=steps(
                "Given: L = $(ladder_length) ft, x = $(x_val) ft, dx/dt = $(dx_dt) ft/s",
                sol("Pythagorean relation", "x^2 + y^2 = $(ladder_length)^2"),
                "Find y: y² = $(ladder_length^2) - $(x_val^2) = $(ladder_length^2 - x_val^2), so y = $(y_val) ft",
                sol("Differentiate", "2x\\frac{dx}{dt} + 2y\\frac{dy}{dt} = 0"),
                "Solve for dy/dt: dy/dt = -\\frac{x}{y}\\frac{dx}{dt} = -\\frac{$(x_val)}{$(y_val)}($(dx_dt))",
                sol("Answer", "\\frac{$(-(x_val * dx_dt))}{$(y_val)} \\text{ ft/s}")
            ),
            time=150,
        )
        
    else
        # Water tank - cone or cylinder
        is_cylinder = choice([true, false])
        
        if is_cylinder
            radius = randint(3, 8)
            h_val = randint(5, 15)
            dV_dt = randint(10, 40)
            
            # V = πr²h, dV/dt = πr²(dh/dt)
            dh_dt = dV_dt // (π * radius^2)
            
            problem(
                question="Water is being poured into a cylindrical tank with radius $(radius) meters at a rate of $(dV_dt) m³/min. How fast is the water level rising? (Leave answer in terms of π)",
                answer=dV_dt / (π * radius^2),
                difficulty=(800, 1000),
                solution=steps(
                    "Given: r = $(radius) m (constant), dV/dt = $(dV_dt) m³/min",
                    sol("Volume formula", "V = \\pi r^2 h"),
                    sol("Differentiate", "\\frac{dV}{dt} = \\pi r^2 \\frac{dh}{dt}"),
                    "Solve for dh/dt: dh/dt = \\frac{dV/dt}{\\pi r^2} = \\frac{$(dV_dt)}{\\pi($(radius))^2} = \\frac{$(dV_dt)}{$(radius^2)\\pi}",
                    sol("Answer", "\\frac{$(dV_dt)}{$(radius^2)\\pi} \\text{ m/min}")
                ),
                time=100,
            )
        else
            # Conical tank
            base_r = randint(4, 8)
            height = 2 * base_r
            h_val = randint(4, Int(floor(0.8 * height)))
            dV_dt = randint(5, 20)
            
            # V = (1/3)πr²h, r/h = base_r/height (constant ratio)
            # r = (base_r/height)h, so V = (1/3)π(base_r/height)²h³
            # dV/dt = π(base_r/height)²h²(dh/dt)
            ratio_sq = (base_r^2) // (height^2)
            dh_dt = dV_dt // (π * ratio_sq * h_val^2)
            
            problem(
                question="A conical tank (vertex down) has base radius $(base_r) m and height $(height) m. Water is being added at $(dV_dt) m³/min. When the water depth is $(h_val) m, how fast is the level rising? (Leave answer in terms of π)",
                answer=dV_dt / (π * (base_r^2 / height^2) * h_val^2),
                difficulty=(1000, 1200),
                solution=steps(
                    "Given: Base radius = $(base_r) m, total height = $(height) m, dV/dt = $(dV_dt) m³/min, h = $(h_val) m",
                    "By similar triangles: r/h = $(base_r)/$(height), so r = \\frac{$(base_r)}{$(height)}h",
                    sol("Volume formula", "V = \\frac{1}{3}\\pi r^2 h = \\frac{1}{3}\\pi\\left(\\frac{$(base_r)}{$(height)}h\\right)^2 h = \\frac{\\pi \\cdot $(base_r^2)}{3 \\cdot $(height^2)}h^3"),
                    sol("Differentiate", "\\frac{dV}{dt} = \\frac{\\pi \\cdot $(base_r^2)}{$(height^2)}h^2\\frac{dh}{dt}"),
                    "Solve: dh/dt = \\frac{$(dV_dt) \\cdot $(height^2)}{\\pi \\cdot $(base_r^2) \\cdot $(h_val^2)}",
                    sol("Answer", "\\frac{$(dV_dt * height^2)}{$(base_r^2 * h_val^2)\\pi} \\text{ m/min}")
                ),
                time=180,
            )
        end
    end
end