# geometry - arc_length_sectors (hard)
# Generated: 2026-03-08T20:07:14.716152

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/arc_length_sectors")
    
    problem_type = choice([:arc_length_basic, :sector_area_basic, :arc_length_compound, :sector_optimization, :mixed_challenge])
    
    if problem_type == :arc_length_basic
        # Arc length problem with angle in degrees or radians
        r = randint(5, 25)
        use_degrees = choice([true, false])
        
        if use_degrees
            theta_deg = choice([30, 45, 60, 90, 120, 135, 150, 180, 210, 240, 270, 300])
            theta_rad = theta_deg * π / 180
            arc_length = r * theta_rad
            
            d = DiagramObj(600, 400)
            circle!(d, 300, 200, 150)
            line!(d, 300, 200, 450, 200, stroke="black", stroke_width=2)
            end_x = 300 + 150 * cos(theta_rad)
            end_y = 200 - 150 * sin(theta_rad)
            line!(d, 300, 200, end_x, end_y, stroke="black", stroke_width=2)
            
            if theta_deg <= 180
                arc_start = 0
                arc_end = theta_rad
            else
                arc_start = 0
                arc_end = theta_rad
            end
            
            arc!(d, 300, 200, 150, 0, theta_rad, stroke="blue", stroke_width=3, fill="none")
            angle_arc!(d, 300, 200, 50, 0, theta_rad)
            text!(d, 360, 210, "$(theta_deg)°", font_size=16)
            text!(d, 375, 200, "r = $(r)", font_size=14)
            
            img = render(d)
            
            problem(
                question="Find the arc length of the arc shown in the diagram. The radius is $(r) and the central angle is $(theta_deg)°. Express your answer in exact form.",
                answer=arc_length,
                difficulty=(1800, 2000),
                solution=steps(
                    sol("Given", "r = $(r), \\theta = $(theta_deg)°"),
                    "Convert angle to radians: \\theta = $(theta_deg) \\cdot \\frac{\\pi}{180} = \\frac{$(theta_deg)\\pi}{180} = \\frac{$(theta_deg ÷ gcd(theta_deg, 180))\\pi}{$(180 ÷ gcd(theta_deg, 180))}",
                    "Use arc length formula: s = r\\theta",
                    sol("s", arc_length)
                ),
                image=img,
                time=120
            )
        else
            theta_num = choice([1, 2, 3, 4, 5])
            theta_den = choice([3, 4, 6])
            theta_rad = theta_num * π / theta_den
            arc_length = r * theta_rad
            
            d = DiagramObj(600, 400)
            circle!(d, 300, 200, 150)
            line!(d, 300, 200, 450, 200, stroke="black", stroke_width=2)
            end_x = 300 + 150 * cos(float(theta_rad))
            end_y = 200 - 150 * sin(float(theta_rad))
            line!(d, 300, 200, end_x, end_y, stroke="black", stroke_width=2)
            arc!(d, 300, 200, 150, 0, float(theta_rad), stroke="blue", stroke_width=3, fill="none")
            angle_arc!(d, 300, 200, 50, 0, float(theta_rad))
            text!(d, 360, 210, "$(theta_num)π/$(theta_den)", font_size=16)
            text!(d, 375, 200, "r = $(r)", font_size=14)
            
            img = render(d)
            
            problem(
                question="Find the arc length of the arc shown in the diagram. The radius is $(r) and the central angle is \\frac{$(theta_num)\\pi}{$(theta_den)} radians. Express your answer in exact form.",
                answer=arc_length,
                difficulty=(1800, 2000),
                solution=steps(
                    sol("Given", "r = $(r), \\theta = \\frac{$(theta_num)\\pi}{$(theta_den)}"),
                    "Use arc length formula: s = r\\theta",
                    sol("s", "$(r) \\cdot \\frac{$(theta_num)\\pi}{$(theta_den)} = \\frac{$(r * theta_num)\\pi}{$(theta_den)}")
                ),
                image=img,
                time=120
            )
        end
        
    elseif problem_type == :sector_area_basic
        # Sector area problem
        r = randint(6, 20)
        theta_deg = choice([30, 45, 60, 90, 120, 135, 150])
        theta_rad = theta_deg * π / 180
        sector_area = r^2 * theta_rad / 2
        
        d = DiagramObj(600, 400)
        circle!(d, 300, 200, 150)
        line!(d, 300, 200, 450, 200, stroke="black", stroke_width=2)
        end_x = 300 + 150 * cos(theta_rad)
        end_y = 200 - 150 * sin(theta_rad)
        line!(d, 300, 200, end_x, end_y, stroke="black", stroke_width=2)
        
        pts_x = Float64[300]
        pts_y = Float64[200]
        for t in range(0, theta_rad, length=20)
            push!(pts_x, 300 + 150 * cos(t))
            push!(pts_y, 200 - 150 * sin(t))
        end
        push!(pts_x, 300)
        push!(pts_y, 200)
        polygon!(d, pts_x, pts_y, fill="lightblue", stroke="blue", stroke_width=2, opacity=0.5)
        
        angle_arc!(d, 300, 200, 50, 0, theta_rad)
        text!(d, 360, 210, "$(theta_deg)°", font_size=16)
        text!(d, 375, 200, "r = $(r)", font_size=14)
        
        img = render(d)
        
        problem(
            question="Find the area of the shaded sector. The radius is $(r) and the central angle is $(theta_deg)°. Express your answer in exact form.",
            answer=sector_area,
            difficulty=(1900, 2100),
            solution=steps(
                sol("Given", "r = $(r), \\theta = $(theta_deg)°"),
                "Convert angle to radians: \\theta = \\frac{$(theta_deg)\\pi}{180} = \\frac{$(theta_deg ÷ gcd(theta_deg, 180))\\pi}{$(180 ÷ gcd(theta_deg, 180))}",
                "Use sector area formula: A = \\frac{1}{2}r^2\\theta",
                sol("A", sector_area)
            ),
            image=img,
            time=150
        )
        
    elseif problem_type == :arc_length_compound
        # Two concentric circles with same angle
        r1 = randint(8, 15)
        r2 = r1 + randint(5, 10)
        theta_deg = choice([60, 90, 120, 135, 150])
        theta_rad = theta_deg * π / 180
        
        arc1 = r1 * theta_rad
        arc2 = r2 * theta_rad
        total_perimeter = arc1 + arc2 + 2 * (r2 - r1)
        
        d = DiagramObj(600, 400)
        circle!(d, 300, 200, 100, stroke="black", stroke_width=2, fill="none")
        circle!(d, 300, 200, 150, stroke="black", stroke_width=2, fill="none")
        
        line!(d, 400, 200, 450, 200, stroke="black", stroke_width=2)
        end_x1 = 300 + 100 * cos(theta_rad)
        end_y1 = 200 - 100 * sin(theta_rad)
        end_x2 = 300 + 150 * cos(theta_rad)
        end_y2 = 200 - 150 * sin(theta_rad)
        line!(d, end_x1, end_y1, end_x2, end_y2, stroke="black", stroke_width=2)
        
        arc!(d, 300, 200, 100, 0, theta_rad, stroke="blue", stroke_width=3, fill="none")
        arc!(d, 300, 200, 150, 0, theta_rad, stroke="blue", stroke_width=3, fill="none")
        line!(d, 400, 200, 450, 200, stroke="blue", stroke_width=3)
        line!(d, end_x1, end_y1, end_x2, end_y2, stroke="blue", stroke_width=3)
        
        angle_arc!(d, 300, 200, 50, 0, theta_rad)
        text!(d, 360, 210, "$(theta_deg)°", font_size=16)
        text!(d, 340, 200, "$(r1)", font_size=14)
        text!(d, 380, 200, "$(r2)", font_size=14)
        
        img = render(d)
        
        problem(
            question="Two concentric circles have radii $(r1) and $(r2) as shown. Find the perimeter of the shaded region bounded by the two arcs and two radial segments, where the central angle is $(theta_deg)°. Express your answer in exact form.",
            answer=total_perimeter,
            difficulty=(2000, 2200),
            solution=steps(
                sol("Given", "r_1 = $(r1), r_2 = $(r2), \\theta = $(theta_deg)° = \\frac{$(theta_deg ÷ gcd(theta_deg, 180))\\pi}{$(180 ÷ gcd(theta_deg, 180))}"),
                "Arc lengths: s_1 = $(r1)\\theta, s_2 = $(r2)\\theta",
                "Radial segments: 2(r_2 - r_1) = 2($(r2 - r1)) = $(2(r2 - r1))",
                "Total perimeter: s_1 + s_2 + 2(r_2 - r_1)",
                sol("P", total_perimeter)
            ),
            image=img,
            time=180
        )
        
    elseif problem_type == :sector_optimization
        # Find radius given arc length and angle, maximize area
        arc_len = randint(15, 40)
        theta_deg = choice([60, 90, 120])
        theta_rad = theta_deg * π / 180
        r = arc_len / theta_rad
        area = r^2 * theta_rad / 2
        
        d = DiagramObj(600, 400)
        circle!(d, 300, 200, 150, stroke="black", stroke_width=2, fill="none")
        line!(d, 300, 200, 450, 200, stroke="black", stroke_width=2)
        end_x = 300 + 150 * cos(theta_rad)
        end_y = 200 - 150 * sin(theta_rad)
        line!(d, 300, 200, end_x, end_y, stroke="black", stroke_width=2)
        
        pts_x = Float64[300]
        pts_y = Float64[200]
        for t in range(0, theta_rad, length=20)
            push!(pts_x, 300 + 150 * cos(t))
            push!(pts_y, 200 - 150 * sin(t))
        end
        push!(pts_x, 300)
        push!(pts_y, 200)
        polygon!(d, pts_x, pts_y, fill="lightgreen", stroke="green", stroke_width=2, opacity=0.5)
        
        arc!(d, 300, 200, 150, 0, theta_rad, stroke="blue", stroke_width=3, fill="none")
        angle_arc!(d, 300, 200, 50, 0, theta_rad)
        text!(d, 360, 210, "$(theta_deg)°", font_size=16)
        text!(d, 370, 130, "arc = $(arc_len)", font_size=14)
        
        img = render(d)
        
        problem(
            question="A sector has an arc length of $(arc_len) and a central angle of $(theta_deg)°. Find the area of this sector. Express your answer in exact form.",
            answer=area,
            difficulty=(2100, 2300),
            solution=steps(
                sol("Given", "s = $(arc_len), \\theta = $(theta_deg)° = \\frac{$(theta_deg ÷ gcd(theta_deg, 180))\\pi}{$(180 ÷ gcd(theta_deg, 180))}"),
                "From s = r\\theta, find radius: r = \\frac{s}{\\theta} = \\frac{$(arc_len)}{\\frac{$(theta_deg ÷ gcd(theta_deg, 180))\\pi}{$(180 ÷ gcd(theta_deg, 180))}}",
                sol("r", r),
                "Use sector area formula: A = \\frac{1}{2}r^2\\theta",
                sol("A", area)
            ),
            image=img,
            time=200
        )
        
    else  # mixed_challenge
        # Annulus sector with area calculation
        r_inner = randint(5, 12)
        r_outer = r_inner + randint(6, 12)
        theta_deg = choice([45, 60, 90, 120])
        theta_rad = theta_deg * π / 180
        
        area_outer = r_outer^2 * theta_rad / 2
        area_inner = r_inner^2 * theta_rad / 2
        annulus_area = area_outer - area_inner
        
        d = DiagramObj(600, 400)
        
        # Draw outer sector
        pts_x = Float64[300]
        pts_y = Float64[200]
        for t in range(0, theta_rad, length=30)
            push!(pts_x, 300 + 180 * cos(t))
            push!(pts_y, 200 - 180 * sin(t))
        end
        push!(pts_x, 300)
        push!(pts_y, 200)
        polygon!(d, pts_x, pts_y, fill="lightblue", stroke="none", opacity=0.6)
        
        # Draw inner sector (white to create annulus)
        pts_x_inner = [300]
        pts_y_inner = [200]
        for t in range(0, theta_rad, length=30)
            push!(pts_x_inner, 300 + 100 * cos(t))
            push!(pts_y_inner, 200 - 100 * sin(t))
        end
        push!(pts_x_inner, 300)
        push!(pts_y_inner, 200)
        polygon!(d, pts_x_inner, pts_y_inner, fill="white", stroke="none")

        # Draw arcs and radii
        segment!(d, (300, 200), (300 + 180, 200), stroke="black", linewidth=2)
        text!(d, "$(r_outer)", 300 + 140, 215, fontsize=12)
        text!(d, "$(r_inner)", 300 + 60, 215, fontsize=12)
        text!(d, "$(theta_deg)°", 320, 190, fontsize=11)

        question = "Find the area of the annular sector with inner radius $(r_inner), outer radius $(r_outer), and central angle $(theta_deg)°."
        ans_simplified = simplify(annulus_area)

        problem(
            question=question,
            answer=ans_simplified,
            difficulty=(1800, 2200),
            solution=steps(
                "Area of outer sector: \\frac{$(r_outer)^2 \\cdot $(theta_deg)°}{2} (in radians)",
                "Area of inner sector: \\frac{$(r_inner)^2 \\cdot $(theta_deg)°}{2} (in radians)",
                "Annulus area = outer - inner = $(tex(ans_simplified))"
            ),
            time=180,
            image=d
        )
    end
end