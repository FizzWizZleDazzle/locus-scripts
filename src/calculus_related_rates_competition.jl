# calculus - related_rates (competition)
# Generated: 2026-03-08T20:42:16.170069

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("calculus/related_rates")
    
    problem_type = rand(1:5)
    
    if problem_type == 1
        # Olympiad: A ladder sliding with acceleration, finding rate of change of angle when velocity is changing
        L = randint(15, 30)
        x0 = randint(8, Int(floor(L * 0.6)))
        y0 = round(Int, sqrt(L^2 - x0^2))
        
        # dx/dt at time when x = x0
        v_x = randint(2, 5)
        # d²x/dt² (acceleration)
        a_x = choice([1, 2, 3]) * choice([-1, 1])
        
        # Need dθ/dt when acceleration is considered
        # x = L cos(θ), dx/dt = -L sin(θ) dθ/dt
        # d²x/dt² = -L cos(θ)(dθ/dt)² - L sin(θ) d²θ/dt²
        
        sin_theta = y0 / L
        cos_theta = x0 / L
        
        # From dx/dt = -L sin(θ) dθ/dt
        dtheta_dt = -v_x / (L * sin_theta)
        
        # From d²x/dt² = -L cos(θ)(dθ/dt)² - L sin(θ) d²θ/dt²
        d2theta_dt2 = (-a_x + L * cos_theta * dtheta_dt^2) / (L * sin_theta)
        
        ans = round(d2theta_dt2, digits=6)
        
        problem(
            question="A ladder of length $(L) meters leans against a wall. The bottom of the ladder slides away from the wall with velocity $(v_x) m/s and acceleration $(a_x) m/s² at the instant when the bottom is $(x0) m from the wall. At this instant, find the angular acceleration d²θ/dt² (in rad/s²) of the angle θ between the ladder and the ground. Round to 6 decimal places.",
            answer=ans,
            difficulty=(3500, 3900),
            solution=steps(
                "Let x = distance from wall, y = height on wall, θ = angle with ground",
                sol("Constraint", "x² + y² = $(L^2)"),
                "At the instant: x = $(x0), y = $(y0), dx/dt = $(v_x), d²x/dt²= $(a_x)",
                "From x = L cos(θ): dx/dt = -L sin(θ) dθ/dt",
                sol("First derivative", "dθ/dt = -dx/dt / (L sin(θ)) = $(round(dtheta_dt, digits=6)) rad/s"),
                "Differentiate again: d²x/dt² = -L cos(θ)(dθ/dt)² - L sin(θ) d²θ/dt²",
                sol("Solve for d²θ/dt²", "d²θ/dt² = (-d²x/dt² + L cos(θ)(dθ/dt)²) / (L sin(θ))"),
                sol("Answer", ans)
            ),
            time=300
        )
        
    elseif problem_type == 2
        # Research-adjacent: Cone with varying angle, liquid draining with rate depending on depth
        # More complex related rates with cubic terms
        
        alpha_deg = randint(25, 50)
        alpha = alpha_deg * π / 180
        tan_alpha = tan(alpha)
        
        h0 = randint(8, 15)
        k = choice([Rational(1, 100), Rational(1, 80), Rational(1, 120)])
        
        # V = (1/3)πr²h where r = h tan(α)
        # V = (1/3)π tan²(α) h³
        # dV/dt = -k√h (outflow proportional to sqrt of pressure head)
        # π tan²(α) h² dh/dt = -k√h
        # dh/dt = -k / (π tan²(α) h^(3/2))
        
        dhdt = -float(k) / (π * tan_alpha^2 * h0^(3/2))
        ans = round(dhdt, digits=6)
        
        problem(
            question="A conical tank with vertex angle $(2*alpha_deg)° (half-angle $(alpha_deg)°) is draining. Water flows out at a rate proportional to √h, where h is the depth: dV/dt = -$(float(k))√h m³/s. When the depth is $(h0) m, find dh/dt (in m/s). Round to 6 decimal places.",
            answer=ans,
            difficulty=(3700, 4200),
            solution=steps(
                "Volume of cone: V = (1/3)πr²h where r = h tan($(alpha_deg)°)",
                sol("Volume formula", "V = (1/3)π tan²($(alpha_deg)°) h³"),
                "Differentiate with respect to t:",
                sol("Rate equation", "dV/dt = π tan²($(alpha_deg)°) h² dh/dt"),
                "Given: dV/dt = -$(float(k))√h",
                sol("Substitute", "π tan²($(alpha_deg)°) h² dh/dt = -$(float(k))√h"),
                sol("Solve for dh/dt", "dh/dt = -$(float(k)) / (π tan²($(alpha_deg)°) h^(3/2))"),
                "When h = $(h0):",
                sol("Answer", ans)
            ),
            time=360
        )
        
    elseif problem_type == 3
        # Olympiad: Shadow problem with two light sources
        
        h_person = randint(160, 190) / 100  # 1.6 to 1.9 m
        h_lamp = randint(6, 10)
        v_person = choice([1, 2, 3]) / 2  # 0.5, 1, 1.5 m/s
        
        d_person = randint(8, 15)
        
        # Person walks toward lamp
        # Shadow on ground: by similar triangles
        # s/h_person = (h_lamp - h_person)/(d - s) where d is distance from lamp base
        # Solve for s: s(d - s) = h_person(h_lamp - h_person)
        # This is wrong approach - let's use: shadow tip at distance x from lamp
        # h_lamp/x = h_person/(x - d)
        # x = h_lamp*d / (h_lamp - h_person)
        
        x = h_lamp * d_person / (h_lamp - h_person)
        
        # dx/dt when dd/dt = -v_person (approaching)
        # x = h_lamp * d / (h_lamp - h_person)
        # dx/dt = h_lamp/(h_lamp - h_person) * dd/dt
        
        dxdt = h_lamp / (h_lamp - h_person) * (-v_person)
        
        # Length of shadow: L = x - d
        # dL/dt = dx/dt - dd/dt
        dLdt = dxdt - (-v_person)
        
        ans = round(dLdt, digits=4)
        
        problem(
            question="A person of height $(h_person) m walks toward a street lamp of height $(h_lamp) m at a speed of $(v_person) m/s. When the person is $(d_person) m from the base of the lamp, find the rate at which the length of the person's shadow on the ground is changing (in m/s). Round to 4 decimal places.",
            answer=ans,
            difficulty=(3600, 4000),
            solution=steps(
                "Let d = distance of person from lamp, s = length of shadow",
                "By similar triangles: $(h_lamp)/(d+s) = $(h_person)/s",
                sol("Solve for s", "s = $(h_person)*d / ($(h_lamp) - $(h_person))"),
                "Differentiate: ds/dt = $(h_person)/($(h_lamp) - $(h_person)) * dd/dt",
                "Given: dd/dt = -$(v_person) (approaching lamp)",
                sol("Calculate", "ds/dt = $(h_person)/($(h_lamp - h_person)) × (-$(v_person))"),
                sol("Answer", ans)
            ),
            time=280
        )
        
    elseif problem_type == 4
        # Research-adjacent: Ellipse with moving point, implicit differentiation with constraint
        
        a = randint(8, 15)
        b = randint(5, a - 2)
        x0 = randint(3, a - 2)
        y0_sq = b^2 * (1 - x0^2 / a^2)
        y0 = round(sqrt(y0_sq), digits=4)
        
        dxdt = choice([2, 3, 4, 5]) * choice([-1, 1])
        
        # x²/a² + y²/b² = 1
        # Differentiate: 2x/a² dx/dt + 2y/b² dy/dt = 0
        # dy/dt = -(b²x)/(a²y) dx/dt
        
        dydt = -(b^2 * x0) / (a^2 * y0) * dxdt
        
        # Distance from origin: r = √(x² + y²)
        # dr/dt = (x dx/dt + y dy/dt)/r
        
        r0 = sqrt(x0^2 + y0^2)
        drdt = (x0 * dxdt + y0 * dydt) / r0
        
        ans = round(drdt, digits=5)
        
        problem(
            question="A point moves on the ellipse x²/$(a^2) + y²/$(b^2) = 1. At the instant when x = $(x0) (with y > 0), dx/dt = $(dxdt). Find the rate of change dr/dt of the distance r from the point to the origin. Round to 5 decimal places.",
            answer=ans,
            difficulty=(3800, 4300),
            solution=steps(
                sol("Ellipse equation", "x²/$(a^2) + y²/$(b^2) = 1"),
                "At x = $(x0): y = $(round(y0, digits=4))",
                "Implicit differentiation: 2x/$(a^2) dx/dt + 2y/$(b^2) dy/dt = 0",
                sol("Solve for dy/dt", "dy/dt = -$(b^2)x/($(a^2)y) dx/dt = $(round(dydt, digits=5))"),
                "Distance: r = √(x² + y²), so r² = x² + y²",
                "Differentiate: 2r dr/dt = 2x dx/dt + 2y dy/dt",
                sol("Solve for dr/dt", "dr/dt = (x dx/dt + y dy/dt)/r"),
                "Substitute values:",
                sol("Answer", ans)
            ),
            time=300
        )
        
    else
        # Olympiad/Research: Cylindrical tank with variable cross-section
        # Volume depends on height in nonlinear way
        
        R_base = randint(4, 8)
        h0 = randint(6, 12)
        rate_in = randint(2, 5)
        
        # Radius varies as r(h) = R_base(1 + h/H₀) where H₀ is some scale
        H0 = randint(15, 25)
        
        # V = ∫₀ʰ πr²(z) dz = ∫₀ʰ π R²(1 + z/H₀)² dz
        # V = πR² [h + h²/H₀ + h³/(3H₀²)]
        
        V_at_h0 = π * R_base^2 * (h0 + h0^2/H0 + h0^3/(3*H0^2))
        
        # dV/dt = πR²[1 + 2h/H₀ + h²/H₀²] dh/dt
        # dh/dt = dV/dt / (πR²[1 + 2h/H₀ + h²/H₀²])
        
        factor = 1 + 2*h0/H0 + h0^2/H0^2
        dhdt = rate_in / (π * R_base^2 * factor)
        
        ans = round(dhdt, digits=5)
        
        problem(
            question="A tank has a vertical axis and variable radius r(h) = $(R_base)(1 + h/$(H0)) meters, where h is the height from the bottom. Water flows in at $(rate_in) m³/s. When the water depth is $(h0) m, find dh/dt (in m/s). Round to 5 decimal places.",
            answer=ans,
            difficulty=(4000, 4500),
            solution=steps(
                "Volume element: dV = πr²(h) dh = π($(R_base))²(1 + h/$(H0))² dh",
                sol("Total volume", "V = π($(R_base))² ∫₀ʰ (1 + z/$(H0))² dz"),
                "Expand: (1 + z/$(H0))² = 1 + 2z/$(H0) + z²/$(H0^2)",
                sol("Volume formula", "V = π($(R_base))²[h + h²/$(H0) + h³/(3·$(H0^2))]"),
                "Differentiate with respect to t:",
                sol("Rate equation", "dV/dt = π($(R_base))²[1 + 2h/$(H0) + h²/$(H0^2)] dh/dt"),
                "At h = $(h0): coefficient = $(round(factor, digits=5))",
                sol("Solve", "dh/dt = $(rate_in)/(π·$(R_base^2)·$(round(factor, digits=5)))"),
                sol("Answer", ans)
            ),
            time=360
        )
    end
end