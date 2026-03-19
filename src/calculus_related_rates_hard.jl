# calculus - related_rates (hard)
# Generated: 2026-03-08T20:41:58.032122

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("calculus/related_rates")
    
    scenario = choice([
        :ladder,
        :cone,
        :sphere,
        :cylinder,
        :rectangle,
        :triangle,
        :shadow,
        :kite,
        :water_tank,
        :balloon
    ])
    
    if scenario == :ladder
        # Ladder sliding down a wall
        L = randint(10, 25)
        x_val = randint(5, L-3)
        y_val = round(Int, sqrt(L^2 - x_val^2))
        dx_dt = randint(2, 8) // 10
        
        # From x^2 + y^2 = L^2, differentiate: 2x(dx/dt) + 2y(dy/dt) = 0
        dy_dt = -x_val * dx_dt / y_val
        
        question = "A $(L)-foot ladder is leaning against a wall. The bottom of the ladder is sliding away from the wall at $(dx_dt) ft/s. How fast is the top of the ladder sliding down the wall when the bottom is $(x_val) feet from the wall?"
        
        solution = steps(
            "Let x = distance from wall to bottom, y = height of top on wall",
            sol("Constraint", x^2 + y^2 ~ L^2),
            "Differentiate with respect to time: \\\$2x\\frac{dx}{dt} + 2y\\frac{dy}{dt} = 0\\\$",
            "When x = $(x_val), we have y = \\\$\\sqrt{$(L)^2 - $(x_val)^2} = $(y_val)\\\$",
            "Substitute: \\\$2($(x_val))($(dx_dt)) + 2($(y_val))\\frac{dy}{dt} = 0\\\$",
            sol("Answer", "\\frac{dy}{dt} = $(tex(dy_dt)) \\text{ ft/s}")
        )
        
        problem(
            question=question,
            answer=dy_dt,
            difficulty=(1800, 2100),
            solution=solution,
            time=240
        )
        
    elseif scenario == :cone
        # Water draining from a cone
        h_cone = randint(12, 20)
        r_cone = randint(6, 10)
        dV_dt = -randint(2, 8)
        h_val = randint(6, h_cone-2)
        
        # V = (1/3)πr²h, with r/h = r_cone/h_cone, so r = (r_cone/h_cone)h
        # V = (1/3)π(r_cone/h_cone)²h³
        # dV/dt = π(r_cone/h_cone)²h²(dh/dt)
        
        r_val = r_cone * h_val // h_cone
        dh_dt = dV_dt * h_cone^2 / (PHYS.π * r_cone^2 * h_val^2)
        dh_dt_approx = round(Float64(dh_dt), digits=3)
        
        question = "Water is draining from a conical tank with height $(h_cone) m and base radius $(r_cone) m. The water level is decreasing at what rate when the water is $(h_val) m deep, if the volume is decreasing at $(abs(dV_dt)) m³/min?"
        
        solution = steps(
            "Volume of cone: \\\$V = \\frac{1}{3}\\pi r^2 h\\\$",
            "Similar triangles: \\\$\\frac{r}{h} = \\frac{$(r_cone)}{$(h_cone)}\\\$, so \\\$r = \\frac{$(r_cone)}{$(h_cone)}h\\\$",
            "Substitute: \\\$V = \\frac{1}{3}\\pi\\left(\\frac{$(r_cone)}{$(h_cone)}\\right)^2 h^3 = \\frac{\\pi $(r_cone^2)}{3($(h_cone))^2}h^3\\\$",
            "Differentiate: \\\$\\frac{dV}{dt} = \\frac{\\pi $(r_cone^2)}{$(h_cone^2)} h^2 \\frac{dh}{dt}\\\$",
            "When h = $(h_val) and dV/dt = $(dV_dt): \\\$$(dV_dt) = \\frac{\\pi $(r_cone^2)}{$(h_cone^2)}($(h_val))^2\\frac{dh}{dt}\\\$",
            sol("Answer", "\\frac{dh}{dt} \\approx $(dh_dt_approx) \\text{ m/min}")
        )
        
        problem(
            question=question,
            answer=dh_dt_approx,
            difficulty=(2000, 2300),
            solution=solution,
            time=300
        )
        
    elseif scenario == :sphere
        # Expanding sphere (balloon or snowball)
        dr_dt = randint(2, 6) // 10
        r_val = randint(8, 20)
        
        # V = (4/3)πr³, dV/dt = 4πr²(dr/dt)
        dV_dt = 4 * PHYS.π * r_val^2 * dr_dt
        dV_dt_approx = round(Float64(dV_dt), digits=2)
        
        question = "A spherical balloon is being inflated so that its radius is increasing at $(dr_dt) cm/s. How fast is the volume increasing when the radius is $(r_val) cm?"
        
        solution = steps(
            sol("Volume formula", "V = \\frac{4}{3}\\pi r^3"),
            "Differentiate with respect to time: \\\$\\frac{dV}{dt} = 4\\pi r^2 \\frac{dr}{dt}\\\$",
            "When r = $(r_val) and dr/dt = $(dr_dt):",
            "Substitute: \\\$\\frac{dV}{dt} = 4\\pi($(r_val))^2($(dr_dt)) = $(4*r_val^2*dr_dt)\\pi\\\$",
            sol("Answer", "\\frac{dV}{dt} \\approx $(dV_dt_approx) \\text{ cm}^3\\text{/s}")
        )
        
        problem(
            question=question,
            answer=dV_dt_approx,
            difficulty=(1800, 2000),
            solution=solution,
            time=180
        )
        
    elseif scenario == :cylinder
        # Cylindrical tank filling
        r = randint(4, 10)
        dV_dt = randint(3, 12)
        h_val = randint(5, 15)
        
        # V = πr²h, dV/dt = πr²(dh/dt)
        dh_dt = dV_dt / (PHYS.π * r^2)
        dh_dt_approx = round(Float64(dh_dt), digits=3)
        
        question = "Water is being pumped into a cylindrical tank with radius $(r) m at a rate of $(dV_dt) m³/min. How fast is the water level rising?"
        
        solution = steps(
            sol("Volume formula", "V = \\pi r^2 h"),
            "Radius is constant at r = $(r), so differentiate:",
            "\\\$\\frac{dV}{dt} = \\pi($(r))^2\\frac{dh}{dt}\\\$",
            "Given dV/dt = $(dV_dt):",
            "\\\$$(dV_dt) = $(r^2)\\pi\\frac{dh}{dt}\\\$",
            sol("Answer", "\\frac{dh}{dt} = \\frac{$(dV_dt)}{$(r^2)\\pi} \\approx $(dh_dt_approx) \\text{ m/min}")
        )
        
        problem(
            question=question,
            answer=dh_dt_approx,
            difficulty=(1800, 2000),
            solution=solution,
            time=180
        )
        
    elseif scenario == :rectangle
        # Rectangle with changing dimensions
        l_val = randint(10, 25)
        w_val = randint(8, 20)
        dl_dt = randint(3, 8) // 10
        dw_dt = randint(2, 6) // 10
        
        # A = lw, dA/dt = l(dw/dt) + w(dl/dt)
        dA_dt = l_val * dw_dt + w_val * dl_dt
        
        question = "The length of a rectangle is increasing at $(dl_dt) cm/s and the width is increasing at $(dw_dt) cm/s. How fast is the area increasing when the length is $(l_val) cm and the width is $(w_val) cm?"
        
        solution = steps(
            sol("Area formula", "A = lw"),
            "Differentiate using product rule: \\\$\\frac{dA}{dt} = l\\frac{dw}{dt} + w\\frac{dl}{dt}\\\$",
            "When l = $(l_val), w = $(w_val), dl/dt = $(dl_dt), dw/dt = $(dw_dt):",
            "Substitute: \\\$\\frac{dA}{dt} = ($(l_val))($(dw_dt)) + ($(w_val))($(dl_dt))\\\$",
            sol("Answer", "\\frac{dA}{dt} = $(tex(dA_dt)) \\text{ cm}^2\\text{/s}")
        )
        
        problem(
            question=question,
            answer=dA_dt,
            difficulty=(1900, 2100),
            solution=solution,
            time=200
        )
        
    elseif scenario == :triangle
        # Right triangle with changing legs
        base_val = randint(9, 18)
        height_val = randint(12, 24)
        db_dt = randint(2, 5) // 10
        dh_dt = -randint(3, 7) // 10
        
        # A = (1/2)bh, dA/dt = (1/2)[b(dh/dt) + h(db/dt)]
        dA_dt = (base_val * dh_dt + height_val * db_dt) // 2
        
        question = "The base of a triangle is increasing at $(db_dt) m/s while the height is decreasing at $(abs(dh_dt)) m/s. How fast is the area changing when the base is $(base_val) m and the height is $(height_val) m?"
        
        solution = steps(
            sol("Area formula", "A = \\frac{1}{2}bh"),
            "Differentiate: \\\$\\frac{dA}{dt} = \\frac{1}{2}\\left[b\\frac{dh}{dt} + h\\frac{db}{dt}\\right]\\\$",
            "When b = $(base_val), h = $(height_val), db/dt = $(db_dt), dh/dt = $(dh_dt):",
            "Substitute: \\\$\\frac{dA}{dt} = \\frac{1}{2}[($(base_val))($(dh_dt)) + ($(height_val))($(db_dt))]\\\$",
            sol("Answer", "\\frac{dA}{dt} = $(tex(dA_dt)) \\text{ m}^2\\text{/s}")
        )
        
        problem(
            question=question,
            answer=dA_dt,
            difficulty=(2000, 2200),
            solution=solution,
            time=220
        )
        
    elseif scenario == :shadow
        # Person walking away from streetlight
        h_light = randint(20, 30)
        h_person = randint(5, 7)
        v = randint(3, 8) // 2
        
        # Similar triangles: s/h_person = (s+x)/h_light
        # s*h_light = h_person*(s+x)
        # s(h_light - h_person) = h_person*x
        # ds/dt = h_person/(h_light - h_person) * dx/dt
        ds_dt = h_person * v // (h_light - h_person)
        
        question = "A person $(h_person) ft tall walks away from a streetlight that is $(h_light) ft high at a rate of $(v) ft/s. How fast is the person's shadow lengthening?"
        
        solution = steps(
            "Let x = distance from person to light, s = shadow length",
            "Similar triangles: \\\$\\frac{s}{$(h_person)} = \\frac{s+x}{$(h_light)}\\\$",
            "Cross-multiply: \\\$$(h_light)s = $(h_person)(s+x)\\\$",
            "Simplify: \\\$$(h_light - h_person)s = $(h_person)x\\\$",
            "Differentiate: \\\$$(h_light - h_person)\\frac{ds}{dt} = $(h_person)\\frac{dx}{dt}\\\$",
            "Given dx/dt = $(v):",
            sol("Answer", "\\frac{ds}{dt} = \\frac{$(h_person)}{$(h_light - h_person)}($(v)) = $(tex(ds_dt)) \\text{ ft/s}")
        )
        
        problem(
            question=question,
            answer=ds_dt,
            difficulty=(2100, 2400),
            solution=solution,
            time=270
        )
        
    elseif scenario == :kite
        # Kite string being let out
        height = randint(80, 150)
        dx_dt = randint(4, 10)
        x_val = randint(100, 200)
        
        # L² = x² + height², 2L(dL/dt) = 2x(dx/dt)
        L_val = round(Int, sqrt(x_val^2 + height^2))
        dL_dt = x_val * dx_dt // L_val
        dL_dt_approx = round(Float64(dL_dt), digits=2)
        
        question = "A kite is flying at a constant height of $(height) ft. The kite is moving horizontally away from the person holding the string at $(dx_dt) ft/s. How fast is the string being let out when the horizontal distance is $(x_val) ft?"
        
        solution = steps(
            "Let x = horizontal distance, L = string length, h = $(height) (constant)",
            sol("Pythagorean relation", "L^2 = x^2 + $(height)^2"),
            "Differentiate: \\\$2L\\frac{dL}{dt} = 2x\\frac{dx}{dt}\\\$",
            "When x = $(x_val): \\\$L = \\sqrt{$(x_val)^2 + $(height)^2} \\approx $(L_val)\\\$",
            "Substitute: \\\$2($(L_val))\\frac{dL}{dt} = 2($(x_val))($(dx_dt))\\\$",
            sol("Answer", "\\frac{dL}{dt} \\approx $(dL_dt_approx) \\text{ ft/s}")
        )
        
        problem(
            question=question,
            answer=dL_dt_approx,
            difficulty=(2000, 2300),
            solution=solution,
            time=250
        )
        
    elseif scenario == :water_tank
        # Conical tank        # Conical tank
        R = randint(3, 8)
        H = randint(10, 20)
        dV_dt = randint(2, 10)
        h_val = randint(3, min(H - 2, 10))

        r_ratio = R / H
        dh_dt = dV_dt / (π * r_ratio^2 * h_val^2)

        question = "Water flows into a conical tank (top radius $(R), height $(H), vertex down) at $(dV_dt) ft^3/min. How fast is the water level rising when it is $(h_val) ft deep? Round to 4 decimal places."

        solution = steps(
            "By similar triangles: r/h = $(R)/$(H)",
            "V = (1/3)pi*($(R)/$(H))^2 * h^3",
            "dV/dt = pi*($(R)/$(H))^2 * h^2 * dh/dt",
            sol("Answer", round(Float64(dh_dt), digits=4))
        )

        problem(
            question=question,
            answer=round(Float64(dh_dt), digits=4),
            difficulty=(2200, 2500),
            solution=solution,
            time=270
        )
    end
end
