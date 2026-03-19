# calculus - related_rates (medium)
# Generated: 2026-03-08T20:41:31.726030

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script x y t begin
    set_topic!("calculus/related_rates")
    
    problem_type = choice([
        :expanding_circle,
        :ladder_sliding,
        :cone_volume,
        :shadow_length,
        :distance_between_objects,
        :water_tank,
        :balloon_radius,
        :triangle_area
    ])
    
    if problem_type == :expanding_circle
        dr_dt = choice([2, 3, 4, 5, 6])
        radius_at_t = randint(5, 20)
        
        dA_dt = 2 * π * radius_at_t * dr_dt
        
        problem(
            question="The radius of a circle is increasing at a rate of $dr_dt cm/s. How fast is the area increasing when the radius is $radius_at_t cm? (Express your answer in terms of π)",
            answer=dA_dt,
            difficulty=(1200, 1400),
            solution=steps(
                "Given: dr/dt = $dr_dt cm/s, r = $radius_at_t cm",
                sol("Area formula", "A = πr²"),
                sol("Differentiate with respect to t", "dA/dt = 2πr(dr/dt)"),
                sol("Substitute values", "dA/dt = 2π($radius_at_t)($dr_dt) = $(2*radius_at_t*dr_dt)π cm²/s")
            ),
            time=120
        )
        
    elseif problem_type == :ladder_sliding
        ladder_length = randint(10, 25)
        base_distance = randint(5, Int(floor(ladder_length * 0.8)))
        dx_dt = choice([2, 3, 4, 5])
        
        height = sqrt(ladder_length^2 - base_distance^2)
        dy_dt = -(base_distance * dx_dt) / height
        
        problem(
            question="A $ladder_length ft ladder is leaning against a wall. The base of the ladder is sliding away from the wall at $dx_dt ft/s. How fast is the top of the ladder sliding down when the base is $base_distance ft from the wall?",
            answer=dy_dt,
            difficulty=(1400, 1600),
            solution=steps(
                "Given: L = $ladder_length ft, x = $base_distance ft, dx/dt = $dx_dt ft/s",
                sol("Pythagorean theorem", "x² + y² = $(ladder_length)²"),
                "At x = $base_distance: y = √($(ladder_length^2) - $(base_distance^2)) = $(height) ft",
                sol("Differentiate", "2x(dx/dt) + 2y(dy/dt) = 0"),
                sol("Solve for dy/dt", "dy/dt = -x(dx/dt)/y = -($base_distance)($dx_dt)/$(height) = $(dy_dt) ft/s")
            ),
            time=180
        )
        
    elseif problem_type == :cone_volume
        radius_rate = choice([3, 4, 5, 6])
        height_given = randint(8, 20)
        radius_given = randint(4, 12)
        
        dV_dt = (π / 3) * (radius_given^2 + 2 * height_given * radius_given * radius_rate)
        
        problem(
            question="Water is flowing into a conical tank at a constant rate. The radius increases at $radius_rate cm/s. At the instant when the radius is $radius_given cm and the height is $height_given cm, how fast is the volume increasing? (Use V = (1/3)πr²h and express answer in terms of π)",
            answer=dV_dt,
            difficulty=(1500, 1700),
            solution=steps(
                "Given: dr/dt = $radius_rate cm/s, r = $radius_given cm, h = $height_given cm",
                sol("Volume formula", "V = (1/3)πr²h"),
                sol("Differentiate using product rule", "dV/dt = (π/3)[2rh(dr/dt) + r²(dh/dt)]"),
                "Assume dh/dt = dr/dt = $radius_rate cm/s (for standard conical filling)",
                sol("Substitute", "dV/dt = (π/3)[2($radius_given)($height_given)($radius_rate) + $(radius_given)²($radius_rate)] = $(dV_dt) cm³/s")
            ),
            time=180
        )
        
    elseif problem_type == :shadow_length
        person_height = randint(5, 6)
        light_height = randint(12, 20)
        walking_speed = randint(2, 5)
        
        ds_dt = walking_speed * light_height / (light_height - person_height)
        
        problem(
            question="A person $person_height ft tall walks away from a streetlight that is $light_height ft high at a rate of $walking_speed ft/s. How fast is the length of the shadow increasing?",
            answer=ds_dt,
            difficulty=(1500, 1700),
            solution=steps(
                "Given: h = $person_height ft, H = $light_height ft, dx/dt = $walking_speed ft/s",
                sol("Similar triangles", "s/h = (x+s)/H"),
                "Simplify: Hs = h(x + s), so s = hx/(H - h)",
                sol("Differentiate", "ds/dt = h/(H-h) · dx/dt = $person_height/($(light_height-person_height)) · $walking_speed"),
                sol("Answer", "ds/dt = $(ds_dt) ft/s")
            ),
            time=180
        )
        
    elseif problem_type == :distance_between_objects
        speed_a = randint(30, 60)
        speed_b = randint(40, 70)
        dist_a = randint(2, 5)
        dist_b = randint(2, 5)
        
        distance = sqrt(dist_a^2 + dist_b^2)
        dz_dt = (dist_a * speed_a + dist_b * speed_b) / distance
        
        problem(
            question="Car A travels north at $speed_a mph and is currently $dist_a miles north of an intersection. Car B travels east at $speed_b mph and is currently $dist_b miles east of the same intersection. How fast is the distance between the cars increasing?",
            answer=dz_dt,
            difficulty=(1600, 1800),
            solution=steps(
                "Given: dx/dt = $speed_b mph, dy/dt = $speed_a mph, x = $dist_b mi, y = $dist_a mi",
                sol("Distance formula", "z² = x² + y²"),
                "Current distance: z = √($(dist_a)² + $(dist_b)²) = $(distance) mi",
                sol("Differentiate", "2z(dz/dt) = 2x(dx/dt) + 2y(dy/dt)"),
                sol("Solve", "dz/dt = [x(dx/dt) + y(dy/dt)]/z = [$(dist_b)($speed_b) + $(dist_a)($speed_a)]/$(distance) = $(dz_dt) mph")
            ),
            time=200
        )
        
    elseif problem_type == :water_tank
        base_length = randint(6, 12)
        base_width = randint(4, 10)
        dV_dt = randint(3, 8)
        
        dh_dt = dV_dt / (base_length * base_width)
        
        problem(
            question="Water is being pumped into a rectangular tank with base dimensions $base_length m × $base_width m at a rate of $dV_dt m³/min. How fast is the water level rising?",
            answer=dh_dt,
            difficulty=(1200, 1400),
            solution=steps(
                "Given: dV/dt = $dV_dt m³/min, base area = $base_length × $base_width = $(base_length*base_width) m²",
                sol("Volume formula", "V = $(base_length) × $(base_width) × h = $(base_length*base_width)h"),
                sol("Differentiate", "dV/dt = $(base_length*base_width)(dh/dt)"),
                sol("Solve for dh/dt", "dh/dt = $(dV_dt)/$(base_length*base_width) = $(dh_dt) m/min")
            ),
            time=120
        )
        
    elseif problem_type == :balloon_radius
        dV_dt = randint(50, 150)
        radius_at_t = randint(5, 15)
        
        dr_dt = dV_dt / (4 * π * radius_at_t^2)
        
        problem(
            question="A spherical balloon is being inflated at a rate of $dV_dt cm³/s. How fast is the radius increasing when the radius is $radius_at_t cm? (Use V = (4/3)πr³)",
            answer=dr_dt,
            difficulty=(1400, 1600),
            solution=steps(
                "Given: dV/dt = $dV_dt cm³/s, r = $radius_at_t cm",
                sol("Volume formula", "V = (4/3)πr³"),
                sol("Differentiate", "dV/dt = 4πr²(dr/dt)"),
                sol("Solve for dr/dt", "dr/dt = $(dV_dt)/(4π($(radius_at_t))²) = $(dV_dt)/($(4*radius_at_t^2)π) cm/s")
            ),
            time=150
        )
        
    else  # :triangle_area
        base_val = randint(8, 16)
        height_val = randint(6, 14)
        db_dt = randint(2, 4)
        dh_dt = randint(1, 3)
        
        dA_dt = (1//2) * (base_val * dh_dt + height_val * db_dt)
        
        problem(
            question="The base of a triangle is increasing at $db_dt cm/s and the height is increasing at $dh_dt cm/s. How fast is the area increasing when the base is $base_val cm and the height is $height_val cm?",
            answer=dA_dt,
            difficulty=(1300, 1500),
            solution=steps(
                "Given: db/dt = $db_dt cm/s, dh/dt = $dh_dt cm/s, b = $base_val cm, h = $height_val cm",
                sol("Area formula", "A = (1/2)bh"),
                sol("Differentiate using product rule", "dA/dt = (1/2)[b(dh/dt) + h(db/dt)]"),
                sol("Substitute", "dA/dt = (1/2)[$base_val($dh_dt) + $height_val($db_dt)] = $(dA_dt) cm²/s")
            ),
            time=150
        )
    end
end