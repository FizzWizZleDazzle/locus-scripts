# geometry - surface_area (very_hard)
# Generated: 2026-03-08T20:10:06.558277

include(joinpath(@__DIR__, "..", "julia", "src", "ProblemUtils.jl"))
using .ProblemUtils

@script begin
    set_topic!("geometry/surface_area")
    
    problem_type = rand(1:4)
    
    if problem_type == 1
        # Polyhedral surface area with constraints (Competition level)
        a = randint(3, 12)
        b = randint(3, 12)
        c = randint(3, 12)
        while gcd(gcd(a, b), c) > 1
            a = randint(3, 12)
            b = randint(3, 12)
            c = randint(3, 12)
        end
        
        h = randint(4, 15)
        
        # Create a triangular prism with specific triangle
        # Base is a triangle with sides a, b, c (we'll use a right triangle for cleanliness)
        base_a = randint(5, 20)
        base_b = randint(5, 20)
        base_c_sq = base_a^2 + base_b^2
        base_c = isqrt(base_c_sq)
        
        # Only proceed if it's a Pythagorean triple
        if base_c^2 == base_c_sq
            base_area = base_a * base_b // 2
            lateral_area = base_a * h + base_b * h + base_c * h
            total_area = 2 * base_area + lateral_area
            
            d = DiagramObj(400, 300)
            # Draw triangular prism in 3D perspective
            polygon!(d, [(50, 200), (150, 200), (100, 140)], fill="lightblue", stroke="black", stroke_width=2)
            polygon!(d, [(200, 150), (300, 150), (250, 90)], fill="lightcyan", stroke="black", stroke_width=2)
            line!(d, (50, 200), (200, 150), stroke="black", stroke_width=2)
            line!(d, (150, 200), (300, 150), stroke="black", stroke_width=2)
            line!(d, (100, 140), (250, 90), stroke="black", stroke_width=2)
            
            text!(d, "$(base_a)", 75, 220, font_size=14)
            text!(d, "$(base_b)", 130, 170, font_size=14)
            text!(d, "$(h)", 170, 175, font_size=14)
            
            problem(
                question="A right triangular prism has a base with legs of length $(base_a) and $(base_b). The height of the prism is $(h). Find the total surface area of the prism.",
                answer=total_area,
                difficulty=(2500, 2800),
                solution=steps(
                    "The base is a right triangle with legs $(base_a) and $(base_b)",
                    sol("Base area", "\\frac{1}{2} \\cdot $(base_a) \\cdot $(base_b) = $(base_area)"),
                    sol("Hypotenuse", "\\sqrt{$(base_a)^2 + $(base_b)^2} = $(base_c)"),
                    sol("Lateral area", "$(base_a) \\cdot $(h) + $(base_b) \\cdot $(h) + $(base_c) \\cdot $(h) = $(lateral_area)"),
                    sol("Total surface area", "2 \\cdot $(base_area) + $(lateral_area) = $(total_area)")
                ),
                image=render(d),
                time=240
            )
        else
            # Compound solid surface area (Olympiad level)
            r1 = randint(3, 8)
            h1 = randint(8, 15)
            r2 = randint(r1 + 1, r1 + 5)
            h2 = randint(4, 10)
            
            cylinder_lateral = 2 * r1 * h1
            cylinder_top = r1^2
            
            cone_slant_sq = r2^2 + h2^2
            cone_slant = isqrt(cone_slant_sq)
            
            if cone_slant^2 == cone_slant_sq
                cone_lateral = r2 * cone_slant
                annulus_area = r2^2 - r1^2
                
                total_area_symbolic = cylinder_lateral + cylinder_top + cone_lateral + annulus_area
                
                d = DiagramObj(400, 400)
                # Draw cylinder base
                circle!(d, 200, 300, 80, fill="lightblue", stroke="black", stroke_width=2)
                # Draw cylinder sides
                line!(d, 120, 300, 120, 180, stroke="black", stroke_width=2)
                line!(d, 280, 300, 280, 180, stroke="black", stroke_width=2)
                # Top of cylinder
                arc!(d, 200, 180, 80, 0, 180, stroke="black", stroke_width=2, fill="none")
                # Cone on top
                circle!(d, 200, 180, 100, fill="lightyellow", stroke="black", stroke_width=1)
                line!(d, 100, 180, 200, 80, stroke="black", stroke_width=2)
                line!(d, 300, 180, 200, 80, stroke="black", stroke_width=2)
                
                text!(d, "r=$(r1)", 150, 310, font_size=12)
                text!(d, "h=$(h1)", 90, 240, font_size=12)
                text!(d, "R=$(r2)", 250, 190, font_size=12)
                
                problem(
                    question="A solid consists of a cylinder of radius $(r1) and height $(h1), topped with a cone of base radius $(r2) and height $(h2). The cone's base is concentric with the cylinder's top. Find the total surface area (excluding the shared base). Express your answer as a multiple of π.",
                    answer=total_area_symbolic,
                    difficulty=(3000, 3300),
                    solution=steps(
                        sol("Cylinder lateral area", "2\\pi \\cdot $(r1) \\cdot $(h1) = $(2*r1*h1)\\pi"),
                        sol("Cylinder bottom", "\\pi \\cdot $(r1)^2 = $(r1^2)\\pi"),
                        sol("Cone slant height", "\\sqrt{$(r2)^2 + $(h2)^2} = $(cone_slant)"),
                        sol("Cone lateral area", "\\pi \\cdot $(r2) \\cdot $(cone_slant) = $(cone_lateral)\\pi"),
                        sol("Annular ring", "\\pi($(r2)^2 - $(r1)^2) = $(annulus_area)\\pi"),
                        sol("Total surface area", "$(total_area_symbolic)\\pi")
                    ),
                    image=render(d),
                    time=300
                )
            else
                # Sphere with inscribed cube (Competition)
                s = 2 * randint(2, 8)
                r_sq = 3 * (s // 2)^2
                r = isqrt(r_sq)
                
                if r^2 == r_sq
                    sphere_area = 4 * r^2
                    
                    d = DiagramObj(400, 400)
                    circle!(d, 200, 200, 120, fill="none", stroke="blue", stroke_width=2)
                    # Draw cube inscribed
                    polygon!(d, [(140, 140), (260, 140), (260, 260), (140, 260)], fill="lightgreen", opacity=0.3, stroke="black", stroke_width=2)
                    line!(d, 140, 140, 180, 110, stroke="black", stroke_width=1, stroke_dasharray="5,5")
                    line!(d, 260, 140, 300, 110, stroke="black", stroke_width=1, stroke_dasharray="5,5")
                    line!(d, 140, 260, 180, 230, stroke="black", stroke_width=1, stroke_dasharray="5,5")
                    line!(d, 260, 260, 300, 230, stroke="black", stroke_width=1, stroke_dasharray="5,5")
                    
                    text!(d, "s=$(s)", 200, 150, font_size=14)
                    
                    problem(
                        question="A cube with edge length $(s) is inscribed in a sphere. Find the surface area of the sphere. Express your answer as a multiple of π.",
                        answer=sphere_area,
                        difficulty=(2600, 2900),
                        solution=steps(
                            "The space diagonal of the cube equals the sphere diameter",
                            sol("Space diagonal", "$(s)\\sqrt{3}"),
                            sol("Radius", "r = \\frac{$(s)\\sqrt{3}}{2}"),
                            sol("r^2", "\\frac{$(s^2) \\cdot 3}{4} = $(r^2)"),
                            sol("Surface area", "4\\pi r^2 = $(sphere_area)\\pi")
                        ),
                        image=render(d),
                        time=240
                    )
                else
                    # Fallback: use a simple sphere problem
                    sphere_area = 4 * r_sq
                    problem(
                        question="A cube with edge length $(s) is inscribed in a sphere. Find the surface area of the sphere in terms of π.",
                        answer=sphere_area,
                        difficulty=(2600, 2900),
                        solution=steps(
                            "Space diagonal = $(s)√3",
                            sol("Radius squared", r_sq),
                            sol("Surface area", "4π · $(r_sq) = $(sphere_area)π")
                        ),
                        time=240
                    )
                end
            end
        end
        
    elseif problem_type == 2
        # Truncated pyramid (Competition)
        a1 = randint(6, 15)
        a2 = randint(3, a1 - 2)
        h = randint(4, 12)
        
        slant_sq = h^2 + ((a1 - a2) // 2)^2
        slant_val = isqrt(slant_sq)
        
        if slant_val^2 == slant_sq
            base1 = a1^2
            base2 = a2^2
            lateral = 2 * (a1 + a2) * slant_val
            total = base1 + base2 + lateral
            
            d = DiagramObj(400, 400)
            # Bottom square
            polygon!(d, [(100, 320), (300, 320), (300, 120), (100, 120)], fill="lightblue", opacity=0.4, stroke="black", stroke_width=2)
            # Top square
            polygon!(d, [(150, 200), (250, 200), (250, 100), (150, 100)], fill="lightcyan", opacity=0.6, stroke="black", stroke_width=2)
            # Connect edges
            line!(d, 100, 320, 150, 200, stroke="black", stroke_width=2)
            line!(d, 300, 320, 250, 200, stroke="black", stroke_width=2)
            line!(d, 300, 120, 250, 100, stroke="black", stroke_width=2)
            line!(d, 100, 120, 150, 100, stroke="black", stroke_width=2)
            
            text!(d, "$(a1)", 200, 340, font_size=14)
            text!(d, "$(a2)", 200, 90, font_size=14)
            text!(d, "h=$(h)", 80, 260, font_size=12)
            
            problem(
                question="A square pyramid is truncated by a plane parallel to the base. The lower base has side length $(a1), the upper base has side length $(a2), and the height of the truncated pyramid is $(h). Find the total surface area.",
                answer=total,
                difficulty=(2700, 3100),
                solution=steps(
                    sol("Lower base area", "$(a1)^2 = $(base1)"),
                    sol("Upper base area", "$(a2)^2 = $(base2)"),
                    sol("Slant height", "\\sqrt{$(h)^2 + \\left(\\frac{$(a1)-$(a2)}{2}\\right)^2} = $(slant_val)"),
                    sol("Lateral area", "2($(a1) + $(a2)) \\cdot $(slant_val) = $(lateral)"),
                    sol("Total surface area", "$(base1) + $(base2) + $(lateral) = $(total)")
                ),
                image=render(d),
                time=270
            )
        else
            # Slant height is not a perfect integer — use approximate value
            slant_approx = round(sqrt(slant_sq), digits=2)
            base1 = a1^2
            base2 = a2^2
            lateral = round(2 * (a1 + a2) * slant_approx, digits=2)
            total = round(base1 + base2 + lateral, digits=2)

            problem(
                question="A square pyramid is truncated by a plane parallel to the base. The lower base has side length $(a1), the upper base has side length $(a2), and the height is $(h). Find the total surface area. Round to 2 decimal places.",
                answer=total,
                difficulty=(2700, 3100),
                solution=steps(
                    sol("Lower base area", "$(a1)^2 = $(base1)"),
                    sol("Upper base area", "$(a2)^2 = $(base2)"),
                    sol("Slant height", "\\sqrt{$(h)^2 + \\left(\\frac{$(a1)-$(a2)}{2}\\right)^2} \\approx $(slant_approx)"),
                    sol("Lateral area", "2($(a1) + $(a2)) \\cdot $(slant_approx) \\approx $(lateral)"),
                    sol("Total surface area", "$(base1) + $(base2) + $(lateral) \\approx $(total)")
                ),
                time=270
            )
        end
        
    elseif problem_type == 3
        # Regular tetrahedron surface area (Olympiad)
        a = randint(4, 20)
        
        # Surface area of regular tetrahedron = sqrt(3) * a^2
        ans_coeff = a^2
        
        d = DiagramObj(400, 400)
        # Draw tetrahedron
        polygon!(d, [(200, 280), (120, 180), (280, 180)], fill="lightgreen", opacity=0.5, stroke="black", stroke_width=2)
        line!(d, 200, 280, 200, 100, stroke="black", stroke_width=2)
        line!(d, 120, 180, 200, 100, stroke="black", stroke_width=2)
        line!(d, 280, 180, 200, 100, stroke="black", stroke_width=2)
        
        text!(d, "$(a)", 160, 240, font_size=14)
        text!(d, "$(a)", 240, 240, font_size=14)
        
        problem(
            question="Find the surface area of a regular tetrahedron with edge length $(a). Express your answer in the form \\(k\\sqrt{3}\\) and enter the value of k.",
            answer=ans_coeff,
            difficulty=(3100, 3400),
            solution=steps(
                "A regular tetrahedron has 4 equilateral triangle faces",
                sol("Area of one face", "\\frac{\\sqrt{3}}{4} \\cdot $(a)^2 = \\frac{$(a^2)\\sqrt{3}}{4}"),
                sol("Total surface area", "4 \\cdot \\frac{$(a^2)\\sqrt{3}}{4} = $(ans_coeff)\\sqrt{3}"),
                sol("Answer", "k = $(ans_coeff)")
            ),
            image=render(d),
            time=210
        )
        
    else
        # Dodecahedron-related (Olympiad level)
        a = randint(2, 8)
        
        # Regular dodecahedron surface area = 3*sqrt(25+10*sqrt(5))*a^2
        # Simplified problem: find coefficient
        ans = 3 * a^2
        
        d = DiagramObj(400, 400)
        # Draw a pentagon to represent one face
        angles = [i * 72 for i in 0:4]
        pts = [(200 + 100*cos(deg2rad(a-90)), 200 + 100*sin(deg2rad(a-90))) for a in angles]
        polygon!(d, pts, fill="lightpink", opacity=0.6, stroke="black", stroke_width=2)
        
        # Add some 3D effect
        angles2 = [i * 72 for i in 0:4]
        pts2 = [(200 + 70*cos(deg2rad(a-90)), 150 + 70*sin(deg2rad(a-90))) for a in angles2]
        polygon!(d, pts2, fill="pink", opacity=0.4, stroke="black", stroke_width=1, stroke_dasharray="3,3")
        
        for i in 1:5
            line!(d, pts[i][1], pts[i][2], pts2[i][1], pts2[i][2], stroke="black", stroke_width=1)
        end

        problem(
            question="A regular dodecahedron has edge length $(a). Its surface area equals k*a^2*sqrt(25+10*sqrt(5)). Find k.",
            answer=3,
            difficulty=(3500, 3900),
            solution=steps(
                "12 regular pentagonal faces, each with area (sqrt(25+10*sqrt(5))/4)*a^2",
                "Total = 12*(sqrt(25+10*sqrt(5))/4)*a^2 = 3*sqrt(25+10*sqrt(5))*a^2",
                sol("Answer", "k = 3")
            ),
            image=render(d),
            time=300
        )
    end
end
