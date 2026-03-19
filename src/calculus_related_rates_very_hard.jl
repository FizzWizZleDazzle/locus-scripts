# calculus - related_rates (very_hard)
# Generated: 2026-03-08T20:42:09.756400

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("calculus/related_rates")
    
    problem_type = choice([
        :cone_volume,
        :sphere_surface,
        :ladder_sliding,
        :shadow_problem,
        :water_tank,
        :balloon_inflation,
        :particle_distance,
        :cylindrical_tank
    ])
    
    if problem_type == :cone_volume
        # A cone with fixed ratio h/r, water draining/filling at given rate
        ratio = choice([2, 3, 4, 1//2, 1//3, 2//3, 3//2, 4//3])
        dV_dt = choice([5, 8, 10, 12, 15, 20, -5, -8, -10, -12])
        h_val = randint(8, 24)
        
        # V = (1/3)πr²h, with r = h/ratio, so V = (π/3)(h/ratio)²h = πh³/(3ratio²)
        # dV/dt = (πh²/ratio²) dh/dt
        # dh/dt = (ratio² dV/dt)/(πh²)
        
        dh_dt_num = ratio^2 * dV_dt
        dh_dt_denom = h_val^2
        dh_dt_simplified = dh_dt_num // dh_dt_denom
        
        action = dV_dt > 0 ? "being filled" : "draining"
        
        question = "A conical water tank has height always $(ratio) times its radius (h = $(ratio)r). Water is $(action) at a rate of $(abs(dV_dt)) m³/min. At the instant when the water depth is $(h_val) m, how fast is the water level rising? Express your answer as a rational multiple of π."
        
        answer = dh_dt_simplified
        
        solution = steps(
            "Given: h = $(ratio)r, so r = h/$(ratio)",
            "Volume formula: V = (1/3)πr²h = (1/3)π(h/$(ratio))²h = πh³/(3·$(ratio^2))",
            "Differentiate with respect to time: dV/dt = (πh²/$(ratio^2)) dh/dt",
            "Substitute dV/dt = $(dV_dt) and h = $(h_val)",
            sol("dh/dt", "$(dh_dt_num)/(π·$(dh_dt_denom)) = $(dh_dt_simplified)/π m/min")
        )
        
        problem(
            question=question,
            answer="$(dh_dt_simplified)/π",
            difficulty=(2500, 3000),
            solution=solution,
            time=240
        )
        
    elseif problem_type == :sphere_surface
        # Sphere: given dS/dt, find dr/dt at specific r
        dS_dt = choice([16, 24, 32, 48, 64, 100])
        r_val = randint(4, 16)
        
        # S = 4πr², dS/dt = 8πr dr/dt
        # dr/dt = dS_dt / (8πr)
        
        dr_dt_num = dS_dt
        dr_dt_denom = 8 * r_val
        dr_dt_simplified = dr_dt_num // dr_dt_denom
        
        question = "A spherical balloon is being inflated such that its surface area increases at a rate of $(dS_dt) cm²/s. At the instant when the radius is $(r_val) cm, how fast is the radius increasing? Express your answer as a rational multiple of π."
        
        answer = dr_dt_simplified
        
        solution = steps(
            "Surface area formula: S = 4πr²",
            "Differentiate with respect to time: dS/dt = 8πr dr/dt",
            "Substitute dS/dt = $(dS_dt) and r = $(r_val)",
            "Solve: dr/dt = $(dS_dt)/(8π·$(r_val)) = $(dr_dt_num)/($(dr_dt_denom)π)",
            sol("dr/dt", "$(dr_dt_simplified)/π cm/s")
        )
        
        problem(
            question=question,
            answer="$(dr_dt_simplified)/π",
            difficulty=(2600, 3200),
            solution=solution,
            time=200
        )
        
    elseif problem_type == :ladder_sliding
        # Ladder of length L sliding down wall
        L = randint(15, 30)
        x_val = randint(5, L-5)
        dx_dt = choice([2, 3, 4, 5])
        
        # x² + y² = L², 2x dx/dt + 2y dy/dt = 0
        y_val = isqrt(L^2 - x_val^2)
        
        dy_dt_num = -x_val * dx_dt
        dy_dt_denom = y_val
        dy_dt_simplified = dy_dt_num // dy_dt_denom
        
        question = "A $(L)-meter ladder leans against a wall. The bottom of the ladder slides away from the wall at $(dx_dt) m/s. When the bottom is $(x_val) m from the wall, how fast is the top of the ladder sliding down? (The top is at height y = √($(L^2 - x_val^2)) = $(y_val) m at this instant.)"
        
        answer = dy_dt_simplified
        
        solution = steps(
            "Pythagorean relation: x² + y² = $(L^2)",
            "Differentiate: 2x dx/dt + 2y dy/dt = 0",
            "At x = $(x_val), y = $(y_val), dx/dt = $(dx_dt)",
            "Solve: dy/dt = -x dx/dt / y = -($(x_val)·$(dx_dt))/$(y_val)",
            sol("dy/dt", "$(dy_dt_simplified) m/s")
        )
        
        problem(
            question=question,
            answer=dy_dt_simplified,
            difficulty=(2700, 3300),
            solution=solution,
            time=220
        )
        
    elseif problem_type == :shadow_problem
        # Person walking away from streetlight, shadow length changing
        h_light = randint(8, 15)
        h_person = randint(4, 7)
        v = choice([2, 3, 4, 5])
        
        # Let x = distance from light, s = shadow length
        # By similar triangles: s/(h_person) = (x+s)/h_light
        # h_light·s = h_person(x+s)
        # s = h_person·x/(h_light - h_person)
        # ds/dt = h_person/(h_light - h_person) · dx/dt
        
        ds_dt_num = h_person * v
        ds_dt_denom = h_light - h_person
        ds_dt_simplified = ds_dt_num // ds_dt_denom
        
        question = "A person $(h_person) m tall walks away from a streetlight that is $(h_light) m high at a rate of $(v) m/s. How fast is the length of the person's shadow increasing?"
        
        answer = ds_dt_simplified
        
        solution = steps(
            "Let x = distance from light, s = shadow length",
            "Similar triangles: s/$(h_person) = (x+s)/$(h_light)",
            "Cross-multiply and solve for s: s = $(h_person)x/$(h_light - h_person)",
            "Differentiate: ds/dt = $(h_person)/$(h_light - h_person) · dx/dt",
            "Substitute dx/dt = $(v): ds/dt = $(ds_dt_num)/$(ds_dt_denom)",
            sol("ds/dt", "$(ds_dt_simplified) m/s")
        )
        
        problem(
            question=question,
            answer=ds_dt_simplified,
            difficulty=(2800, 3400),
            solution=solution,
            time=250
        )
        
    elseif problem_type == :water_tank
        # Inverted cone tank with water draining through hole
        R = randint(4, 10)
        H = randint(8, 16)
        rate = choice([2, 3, 4, 5, 6])
        h_val = randint(4, H-2)
        
        # V = (1/3)πr²h, r/h = R/H, so r = Rh/H
        # V = (1/3)π(R²/H²)h³
        # dV/dt = π(R²/H²)h² dh/dt
        
        dh_dt_num = -rate * H^2
        dh_dt_denom = R^2 * h_val^2
        dh_dt_simplified = dh_dt_num // dh_dt_denom
        
        question = "An inverted conical tank has radius $(R) m at the top and height $(H) m. Water drains from the bottom at $(rate) m³/min. When the water depth is $(h_val) m, how fast is the water level dropping? Express your answer as a rational multiple of π."
        
        answer = dh_dt_simplified
        
        solution = steps(
            "Cone dimensions: radius/height ratio = $(R)/$(H)",
            "Volume: V = (1/3)π($(R)h/$(H))²h = π·$(R^2)h³/(3·$(H^2))",
            "Differentiate: dV/dt = π·$(R^2)h²/$(H^2) · dh/dt",
            "Substitute dV/dt = -$(rate), h = $(h_val)",
            "Solve: dh/dt = -$(rate)·$(H^2)/(π·$(R^2)·$(h_val^2))",
            sol("dh/dt", "$(dh_dt_simplified)/π m/min")
        )
        
        problem(
            question=question,
            answer="$(dh_dt_simplified)/π",
            difficulty=(2900, 3500),
            solution=solution,
            time=280
        )
        
    elseif problem_type == :balloon_inflation
        # Spherical balloon: given dV/dt, find how fast distance to point is changing
        dV_dt = choice([100, 125, 150, 200, 250])
        d_ground = randint(8, 20)
        h_val = randint(6, 15)
        
        # V = (4/3)πr³, dV/dt = 4πr² dr/dt
        # Distance D = √(h² + d²), dD/dt = h/D · dh/dt = h/D · dr/dt
        
        D_val = isqrt(h_val^2 + d_ground^2)
        
        # dr/dt = dV_dt/(4πr²), where r = h at given instant
        # dD/dt = h/D · dV_dt/(4πh²) = dV_dt/(4πhD)
        
        dD_dt_num = dV_dt
        dD_dt_denom = 4 * h_val * D_val
        dD_dt_simplified = dD_dt_num // dD_dt_denom
        
        question = "A spherical balloon is being inflated at $(dV_dt) cm³/s. The balloon rises vertically directly above a point on the ground that is $(d_ground) cm away from an observer. When the balloon's radius (and height above its starting point) is $(h_val) cm, how fast is the distance from the observer to the balloon increasing? The distance is D = √($(h_val)² + $(d_ground)²) = $(D_val) cm at this instant. Express your answer as a rational multiple of π."
        
        answer = dD_dt_simplified
        
        solution = steps(
            "Volume: V = (4/3)πr³, so dV/dt = 4πr² dr/dt",
            "At r = h = $(h_val): dr/dt = $(dV_dt)/(4π·$(h_val^2))",
            "Distance: D = √(h² + $(d_ground^2)), so dD/dt = (h/D)·dh/dt",
            "Since balloon rises as it inflates, dh/dt = dr/dt",
            "dD/dt = $(h_val)/$(D_val) · $(dV_dt)/(4π·$(h_val^2)) = $(dV_dt)/(4π·$(h_val)·$(D_val))",
            sol("dD/dt", "$(dD_dt_simplified)/π cm/s")
        )
        
        problem(
            question=question,
            answer="$(dD_dt_simplified)/π",
            difficulty=(3000, 3500),
            solution=solution,
            time=300
        )
        
    elseif problem_type == :particle_distance
        # Two particles moving, find rate of change of distance
        v1 = randint(3, 8)
        v2 = randint(3, 8)
        x_val = randint(5, 15)
        y_val = randint(5, 15)
        
        # Particle 1 at (x, 0) moving right at v1, Particle 2 at (0, y) moving up at v2
        # D² = x² + y², 2D dD/dt = 2x dx/dt + 2y dy/dt
        
        D_val = isqrt(x_val^2 + y_val^2)
        
        dD_dt_num = x_val * v1 + y_val * v2
        dD_dt_denom = D_val
        dD_dt_simplified = dD_dt_num // dD_dt_denom
        
        question = "Particle A moves along the positive x-axis at $(v1) m/s. Particle B moves along the positive y-axis at $(v2) m/s. When A is at ($(x_val), 0) and B is at (0, $(y_val)), how fast is the distance between them changing? The distance is D = √($(x_val)² + $(y_val)²) = $(D_val) m at this instant."
        
        answer = dD_dt_simplified
        
        solution = steps(
            "Distance formula: D² = x² + y²",
            "Differentiate: 2D dD/dt = 2x dx/dt + 2y dy/dt",
            "At ($(x_val), $(y_val)): D = $(D_val), dx/dt = $(v1), dy/dt = $(v2)",
            "Substitute: 2·$(D_val)·dD/dt = 2·$(x_val)·$(v1) + 2·$(y_val)·$(v2)",
            "Solve: dD/dt = ($(x_val * v1) + $(y_val * v2))/$(D_val)",
            sol("dD/dt", "$(dD_dt_simplified) m/s")
        )
        
        problem(
            question=question,
            answer=dD_dt_simplified,
            difficulty=(2600, 3200),
            solution=solution,
            time=240
        )
        
    else # :cylindrical_tank
        # Cylindrical tank with water being pumped in/out
        radius = randint(3, 8)
        dV_dt = choice([10, 15, 20, 25, 30, -10, -15, -20])
        
        # V = πr²h, dV/dt = πr² dh/dt
        dh_dt_num = dV_dt
        dh_dt_denom = radius^2

        question = "Water is being pumped into a cylindrical tank of radius $(radius) m at a rate of $(abs(dV_dt))π m³/min. How fast is the water level rising? Express your answer as a fraction in terms of 1/r² units per minute."

        answer = dh_dt_num // dh_dt_denom

        solution = steps(
            "Volume of cylinder: V = πr²h where r = $(radius)",
            "Differentiate: dV/dt = πr² dh/dt",
            "Given dV/dt = $(dV_dt)π, r = $(radius)",
            "Solve: dh/dt = $(dV_dt)π/(π·$(radius)²) = $(dh_dt_num)/$(dh_dt_denom)",
            sol("dh/dt", "$(dh_dt_num // dh_dt_denom) m/min")
        )

        problem(
            question=question,
            answer=answer,
            difficulty=(2600, 3200),
            solution=solution,
            time=240
        )
    end
end