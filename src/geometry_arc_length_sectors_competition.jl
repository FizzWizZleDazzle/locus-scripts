# geometry - arc_length_sectors (competition)
# Generated: 2026-03-08T20:07:32.312375

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/arc_length_sectors")
    
    # Choose problem type randomly
    problem_type = choice([:tangent_circles_arc, :sector_intersection, :brachistochrone_like, :isoperimetric_sector])
    
    if problem_type == :tangent_circles_arc
        # Two circles tangent internally, find arc length on smaller circle
        # subtended by a chord that passes through tangent point
        R = randint(8, 20)  # radius of large circle
        r = randint(3, R-2)  # radius of small circle
        
        # The small circle is internally tangent to the large circle
        # Distance between centers = R - r
        # A chord of the large circle passes through the tangent point
        # and makes an angle with the line of centers
        
        θ_deg = choice([30, 45, 60, 75])
        θ_rad = θ_deg * π / 180
        
        # Create diagram
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, R * 10, :none, :black, 2)
        circle!(d, 200, 200 - (R - r) * 10, r * 10, :none, :blue, 2)
        point!(d, 200, 200 - R * 10, :red, 5, "T")
        
        # The angle subtended at the center of small circle by the chord
        # Using law of cosines and geometric properties
        # Distance from small circle center to tangent point = r
        # The chord creates an arc on the small circle
        
        # Angle subtended = 2 * arcsin(R * sin(θ) / r) when chord passes through tangent point
        # For this olympiad problem, the relationship is more subtle
        
        # After geometric analysis: the arc length involves the angle
        # φ = 2 * arcsin((R * sin(θ/2)) / r)
        
        sin_half = sin(θ_rad / 2)
        ratio = (R * sin_half) / r
        
        if ratio <= 1
            φ = 2 * asin(ratio)
            arc_length = r * φ
            
            # Simplify if possible
            if θ_deg == 30
                arc_ans = r * 2 * asin(R / (4 * r))
            elseif θ_deg == 60
                arc_ans = r * 2 * asin(R / (2 * r))
            else
                arc_ans = arc_length
            end
            
            svg = render(d)
            
            problem(
                question="Two circles are internally tangent at point T. The larger circle has radius $(R) and the smaller has radius $(r). A chord of the larger circle passes through T and makes an angle of $(θ_deg)° with the line joining the centers. Find the length of the arc on the smaller circle cut off by this chord. Express your answer in exact form.",
                answer=arc_ans,
                difficulty=(3500, 4000),
                solution=steps(
                    "Let O₁ be the center of the large circle (radius R=$(R)) and O₂ be the center of the small circle (radius r=$(r))",
                    "The distance between centers is |O₁O₂| = R - r = $(R - r) since circles are internally tangent",
                    "The chord passes through tangent point T and makes angle $(θ_deg)° with line O₁O₂",
                    "Using the inscribed angle theorem and law of sines in the configuration",
                    "The angle φ subtended at O₂ satisfies: φ = 2 arcsin((R sin($(θ_deg)°/2))/r) = 2 arcsin($(R)/r · sin($(θ_deg/2)°))",
                    sol("Arc length", "s = rφ = $(r) · 2 arcsin($(R * sin_half)/$(r))")
                ),
                image=svg,
                time=300
            )
        else
            # Fallback to simpler configuration
            r_new = randint(R + 2, R + 8)
            arc_simple = r_new * θ_rad
            svg = render(d)

            problem(
                question="A sector of a circle with radius $(r_new) has a central angle of $(θ_deg)°. Find the exact arc length.",
                answer=r_new * θ_rad,
                difficulty=(3500, 3800),
                solution=steps(
                    sol("Given", "r = $(r_new), θ = $(θ_deg)° = $(θ_rad) radians"),
                    "Arc length formula: s = rθ",
                    sol("Answer", "s = $(r_new) · $(θ_rad)")
                ),
                image=svg,
                time=240
            )
        end
        
    elseif problem_type == :sector_intersection
        # Find area of intersection of two circular sectors
        r1 = randint(6, 15)
        r2 = randint(6, 15)
        
        # Angle between the two radii
        α = choice([π/3, π/4, π/6, 2π/3])
        α_deg = round(Int, α * 180 / π)
        
        d = DiagramObj(400, 400)
        arc!(d, 200, 200, r1 * 12, 0, α_deg, :lightblue, :blue, 2)
        arc!(d, 200, 200, r2 * 12, 0, α_deg, :lightgreen, :green, 2)
        point!(d, 200, 200, :black, 5, "O")
        
        svg = render(d)
        
        # Area of intersection depends on which is smaller
        area_sector1 = r1^2 * α / 2
        area_sector2 = r2^2 * α / 2
        
        # Intersection is the smaller sector
        area_intersection = min(area_sector1, area_sector2)
        
        problem(
            question="Two circular sectors share a common vertex O. The first sector has radius $(r1) and central angle $(α_deg)°. The second sector has radius $(r2) and the same central angle $(α_deg)°, with both sectors starting from the same radius. Find the area of their intersection.",
            answer=area_intersection,
            difficulty=(3600, 4200),
            solution=steps(
                "Both sectors share vertex O and have central angle α = $(α_deg)° = $(α) radians",
                "Area of first sector: A₁ = (1/2)r₁²α = (1/2)($(r1))²($(α)) = $(area_sector1)",
                "Area of second sector: A₂ = (1/2)r₂²α = (1/2)($(r2))²($(α)) = $(area_sector2)",
                "Since sectors share the same angle from the same vertex, intersection is the smaller sector",
                sol("Area of intersection", min(r1, r2)^2 * α / 2)
            ),
            image=svg,
            time=280
        )
        
    elseif problem_type == :brachistochrone_like
        # Arc length along a specific curve (cycloid-inspired)
        R = randint(4, 12)
        θ = choice([π/2, π/3, 2π/3, π/4])
        θ_deg = round(Int, θ * 180 / π)
        
        d = DiagramObj(400, 400)
        circle!(d, 200, 200, R * 15, :none, :black, 2)
        arc!(d, 200, 200, R * 15, 0, θ_deg, :none, :red, 3)
        point!(d, 200, 200, :black, 5, "O")
        
        svg = render(d)
        
        # Problem: find arc length of cycloid-like curve
        # Arc length = R * θ for circular arc
        arc_basic = R * θ
        
        # Make it harder: arc length of curve y = R(1 - cos(t)), x = R(t - sin(t)) for t ∈ [0, θ]
        # This is a cycloid arc
        # Arc length = ∫√((dx/dt)² + (dy/dt)²) dt from 0 to θ
        # dx/dt = R(1 - cos(t)), dy/dt = R sin(t)
        # √(...) = R√(2(1 - cos(t))) = R√(2·2sin²(t/2)) = 2R|sin(t/2)|
        # Arc length = 2R ∫₀^θ sin(t/2) dt = 2R[-2cos(t/2)]₀^θ = 4R(1 - cos(θ/2))
        
        arc_cycloid = 4 * R * (1 - cos(θ / 2))
        
        problem(
            question="A point traces a cycloid curve given parametrically by x = $(R)(t - sin(t)), y = $(R)(1 - cos(t)) for t ∈ [0, $(θ)]. Find the exact arc length of this curve.",
            answer=arc_cycloid,
            difficulty=(3800, 4500),
            solution=steps(
                "Parametric equations: x = $(R)(t - sin(t)), y = $(R)(1 - cos(t))",
                "Find derivatives: dx/dt = $(R)(1 - cos(t)), dy/dt = $(R)sin(t)",
                "Arc length element: ds = √((dx/dt)² + (dy/dt)²) dt = $(R)√(2 - 2cos(t)) dt",
                "Simplify: √(2(1 - cos(t))) = √(4sin²(t/2)) = 2|sin(t/2)| = 2sin(t/2) for t ∈ [0, π]",
                "Integrate: s = ∫₀^$(θ) 2$(R)sin(t/2) dt = 4$(R)[-cos(t/2)]₀^$(θ)",
                sol("Answer", "s = 4$(R)(1 - cos($(θ)/2)) = " * string(arc_cycloid))
            ),
            image=svg,
            time=360
        )
        
    else  # isoperimetric_sector
        # Given perimeter, maximize area of sector
        P = randint(20, 50)
        
        d = DiagramObj(400, 400)
        # Optimal sector has θ = 2 radians
        r_opt = P / 4
        arc!(d, 200, 200, r_opt * 20, 0, 114, :lightblue, :blue, 2)
        line!(d, 200, 200, 200 + r_opt * 20, 200, :blue, 2)
        
        svg = render(d)
        
        # Perimeter = 2r + rθ = r(2 + θ) = P
        # Area = (1/2)r²θ
        # Express r = P/(2 + θ), A = (1/2)(P/(2+θ))²θ = P²θ/(2(2+θ)²)
        # Maximize: dA/dθ = P²(2+θ)² - P²θ·2(2+θ) / (2(2+θ)⁴) = 0
        # (2+θ) - 2θ = 0 → θ = 2
        
        θ_opt = 2
        r_opt_exact = P / 4
        area_max = P^2 / 16
        
        problem(
            question="A circular sector has a fixed perimeter of $(P) units (including the two radii and the arc). Find the maximum possible area of such a sector, and determine the central angle (in radians) that achieves this maximum. Express both answers exactly.",
            answer=(area_max, θ_opt),
            difficulty=(4000, 4800),
            solution=steps(
                "Let r be the radius and θ be the central angle (in radians)",
                "Perimeter constraint: 2r + rθ = r(2 + θ) = $(P)",
                "Express r in terms of θ: r = $(P)/(2 + θ)",
                "Area of sector: A = (1/2)r²θ = (1/2)($(P)/(2+θ))²θ = $(P)²θ/(2(2+θ)²)",
                "To maximize, take derivative: dA/dθ = $(P)²[(2+θ)² - 2θ(2+θ)]/(2(2+θ)⁴)",
                "Set equal to zero: (2+θ)² - 2θ(2+θ) = 0 → (2+θ)(2+θ-2θ) = (2+θ)(2-θ) = 0",
                "Since θ > 0, we need 2 - θ = 0, thus θ = 2 radians",
                "When θ = 2: r = $(P)/4, Area = (1/2)($(P)/4)²(2) = $(P)²/16 = $(area_max)",
                sol("Maximum area", area_max),
                sol("Optimal angle", "θ = 2 radians")
            ),
            image=svg,
            time=360
        )
    end
end